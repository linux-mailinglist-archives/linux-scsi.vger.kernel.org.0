Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA954D0DDB
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 03:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiCHCJx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Mar 2022 21:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiCHCJw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Mar 2022 21:09:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2196763A5;
        Mon,  7 Mar 2022 18:08:56 -0800 (PST)
X-UUID: 87f433136fee49d4a85d9897590e7bb9-20220308
X-UUID: 87f433136fee49d4a85d9897590e7bb9-20220308
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 891801972; Tue, 08 Mar 2022 10:08:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 8 Mar 2022 10:08:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 10:08:10 +0800
From:   Alice Chao <alice.chao@mediatek.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <matthias.bgg@gmail.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <stanley.chu@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <jonathan.hsu@mediatek.com>, <powen.kao@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <yanxu.wei@mediatek.com>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v2 1/1] scsi: Fix racing between dev init and dev reset
Date:   Tue, 8 Mar 2022 10:07:26 +0800
Message-ID: <20220308020725.16116-2-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Device reset thread uses kobject_uevent_env() to get kobj.parent
after scsi_evt_emit(), and it races with device init thread which
calls device_add() to create kobj.parent before kobject_uevent_env().

Device reset call trace:
fill_kobj_path
kobject_get_path
kobject_uevent_env
scsi_evt_emit			<- add wait_event()
scsi_evt_thread

Device init call trace:
fill_kobj_path
kobject_get_path
kobject_uevent_env
device_add				<- create kobj.parent
scsi_target_add
scsi_sysfs_add_sdev
scsi_add_lun
scsi_probe_and_add_lun

These two jobs are scheduled asynchronously, we can't guaranteed that
kobj.parent will be created in device init thread before device reset
thread calls kobj_get_path().

To resolve the racing issue between device init thread and device
reset thread, we use wait_event() in scsi_evt_emit() to wait for
device_add() to complete the creation of kobj.parent.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
---
 drivers/scsi/scsi_lib.c  | 1 +
 drivers/scsi/scsi_scan.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0a70aa763a96..abf9a71ed77c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2461,6 +2461,7 @@ static void scsi_evt_emit(struct scsi_device *sdev, struct scsi_event *evt)
 		break;
 	case SDEV_EVT_POWER_ON_RESET_OCCURRED:
 		envp[idx++] = "SDEV_UA=POWER_ON_RESET_OCCURRED";
+		wait_event(sdev->host->host_wait, sdev->sdev_gendev.kobj.parent != NULL);
 		break;
 	default:
 		/* do nothing */
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f4e6c68ac99e..431f229ac435 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1904,6 +1904,7 @@ static void do_scsi_scan_host(struct Scsi_Host *shost)
 	} else {
 		scsi_scan_host_selected(shost, SCAN_WILD_CARD, SCAN_WILD_CARD,
 				SCAN_WILD_CARD, 0);
+		wake_up(&shost->host_wait);
 	}
 }
 
-- 
2.18.0

