Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662F262EFAE
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Nov 2022 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbiKRIia (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Nov 2022 03:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiKRIi2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Nov 2022 03:38:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9C6327;
        Fri, 18 Nov 2022 00:38:26 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND97Z6QktzqSYc;
        Fri, 18 Nov 2022 16:34:34 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:18 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 16:38:18 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <chenxiang66@hisilicon.com>, <john.g.garry@oracle.com>,
        <damien.lemoal@opensource.wdc.com>, <yanaijie@huawei.com>,
        <johannes.thumshirn@wdc.com>, <duoming@zju.edu.cn>,
        <zhanjie9@hisilicon.com>, <liyihang9@huawei.com>,
        <yangxingui@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH for-next 1/5] Revert "scsi: hisi_sas: Drain bcast events in hisi_sas_rescan_topology()"
Date:   Fri, 18 Nov 2022 16:37:10 +0800
Message-ID: <20221118083714.4034612-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
References: <20221118083714.4034612-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This reverts commit 11ff0c98fca35df16c84d4eee52008faecaf10a6.

Draining or flushing events in hisi_sas_rescan_topology() can hang
the driver, typically with phy up or phy down events being processed,
i.e. sas_porte_bytes_dmaed() or sas_phye_loss_of_signal().

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 54860d252466..4527ac266bb6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1323,7 +1323,6 @@ static void hisi_sas_refresh_port_id(struct hisi_hba *hisi_hba)
 
 static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 state)
 {
-	struct sas_ha_struct *sas_ha = &hisi_hba->sha;
 	struct asd_sas_port *_sas_port = NULL;
 	int phy_no;
 
@@ -1352,12 +1351,6 @@ static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 state)
 			hisi_sas_phy_down(hisi_hba, phy_no, 0, GFP_KERNEL);
 		}
 	}
-	/*
-	 * Ensure any bcast events are processed prior to calling async nexus
-	 * reset calls from hisi_sas_clear_nexus_ha() ->
-	 * hisi_sas_async_I_T_nexus_reset()
-	 */
-	sas_drain_work(sas_ha);
 }
 
 static void hisi_sas_reset_init_all_devices(struct hisi_hba *hisi_hba)
-- 
2.30.0

