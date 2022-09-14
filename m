Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954395B8343
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Sep 2022 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiINIsp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Sep 2022 04:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiINIsj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Sep 2022 04:48:39 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462916A487
        for <linux-scsi@vger.kernel.org>; Wed, 14 Sep 2022 01:48:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPmWGJJ_1663145311;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VPmWGJJ_1663145311)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 16:48:36 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 5/5] scsi: megaraid_sas: move megasas_dbg_lvl init to megasas_init
Date:   Wed, 14 Sep 2022 16:48:03 +0800
Message-Id: <1663145283-4872-6-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663145283-4872-1-git-send-email-kanie@linux.alibaba.com>
References: <1663145283-4872-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The megasas_dbg_lvl is a driver level parameter, dont init in
probe path, otherwise we can not see any debug print when bind
a device to megaraid driver.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index b5503f9..66f84b5 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -7439,7 +7439,6 @@ static inline void megasas_init_ctrl_params(struct megasas_instance *instance)
 	    (instance->pdev->device == PCI_DEVICE_ID_LSI_SAS0071SKINNY))
 		instance->flag_ieee = 1;
 
-	megasas_dbg_lvl = 0;
 	instance->flag = 0;
 	instance->unload = 1;
 	instance->last_time = 0;
@@ -9011,6 +9010,7 @@ static int __init megasas_init(void)
 	 */
 	pr_info("megasas: %s\n", MEGASAS_VERSION);
 
+	megasas_dbg_lvl = 0;
 	support_poll_for_event = 2;
 	support_device_change = 1;
 	support_nvme_encapsulation = true;
-- 
1.8.3.1

