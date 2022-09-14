Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB975B8342
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Sep 2022 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiINIsm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Sep 2022 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiINIsb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Sep 2022 04:48:31 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E0C6F54E
        for <linux-scsi@vger.kernel.org>; Wed, 14 Sep 2022 01:48:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPmY40c_1663145302;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VPmY40c_1663145302)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 16:48:27 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 3/5] scsi: megaraid_sas: simplify the megasas_update_device_list
Date:   Wed, 14 Sep 2022 16:48:01 +0800
Message-Id: <1663145283-4872-4-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663145283-4872-1-git-send-email-kanie@linux.alibaba.com>
References: <1663145283-4872-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove unnecessary dcmd_ret check and go to statements.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 4973c9c..1ac33b1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -8766,33 +8766,26 @@ static inline void megasas_remove_scsi_device(struct scsi_device *sdev)
 int megasas_update_device_list(struct megasas_instance *instance,
 			       int event_type)
 {
-	int dcmd_ret = DCMD_SUCCESS;
+	int dcmd_ret;
 
 	if (instance->enable_fw_dev_list) {
-		dcmd_ret = megasas_host_device_list_query(instance, false);
-		if (dcmd_ret != DCMD_SUCCESS)
-			goto out;
+		return megasas_host_device_list_query(instance, false);
 	} else {
 		if (event_type & SCAN_PD_CHANNEL) {
 			dcmd_ret = megasas_get_pd_list(instance);
-
 			if (dcmd_ret != DCMD_SUCCESS)
-				goto out;
+				return dcmd_ret;
 		}
 
 		if (event_type & SCAN_VD_CHANNEL) {
 			if (!instance->requestorId ||
 			megasas_get_ld_vf_affiliation(instance, 0)) {
-				dcmd_ret = megasas_ld_list_query(instance,
+				return megasas_ld_list_query(instance,
 						MR_LD_QUERY_TYPE_EXPOSED_TO_HOST);
-				if (dcmd_ret != DCMD_SUCCESS)
-					goto out;
 			}
 		}
 	}
-
-out:
-	return dcmd_ret;
+	return DCMD_SUCCESS;
 }
 
 /**
-- 
1.8.3.1

