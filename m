Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C05B8340
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Sep 2022 10:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiINIsn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Sep 2022 04:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiINIsg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Sep 2022 04:48:36 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231172B6A
        for <linux-scsi@vger.kernel.org>; Wed, 14 Sep 2022 01:48:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VPmeSTT_1663145307;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VPmeSTT_1663145307)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 16:48:31 +0800
From:   Guixin Liu <kanie@linux.alibaba.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH 4/5] scsi: megaraid_sas: remove unnecessary memset
Date:   Wed, 14 Sep 2022 16:48:02 +0800
Message-Id: <1663145283-4872-5-git-send-email-kanie@linux.alibaba.com>
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

Remove memset pd_list and ld_ids in megasas_get_device_list,
because they will be memset in megasas_host_device_list_query
or megasas_get_pd_list and megasas_ld_list_query.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 1ac33b1..b5503f9 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5878,10 +5878,6 @@ static void megasas_setup_reply_map(struct megasas_instance *instance)
 static
 int megasas_get_device_list(struct megasas_instance *instance)
 {
-	memset(instance->pd_list, 0,
-	       (MEGASAS_MAX_PD * sizeof(struct megasas_pd_list)));
-	memset(instance->ld_ids, 0xff, MEGASAS_MAX_LD_IDS);
-
 	if (instance->enable_fw_dev_list) {
 		if (megasas_host_device_list_query(instance, true))
 			return FAILED;
-- 
1.8.3.1

