Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB13086B8
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Jan 2021 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhA2HpR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 Jan 2021 02:45:17 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:33485 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232076AbhA2HpO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 29 Jan 2021 02:45:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UNCq90q_1611906249;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNCq90q_1611906249)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Jan 2021 15:44:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kashyap.desai@broadcom.com
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] Revert "Revert "scsi: megaraid_sas: Simplify the calculation of variables
Date:   Fri, 29 Jan 2021 15:44:08 +0800
Message-Id: <1611906248-57219-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/megaraid/megaraid_sas_base.c:8644:30-32: WARNING !A || A
&& B is equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 63a4f48..dd26107 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -8641,8 +8641,7 @@ int megasas_update_device_list(struct megasas_instance *instance,
 
 		if (event_type & SCAN_VD_CHANNEL) {
 			if (!instance->requestorId ||
-			    (instance->requestorId &&
-			     megasas_get_ld_vf_affiliation(instance, 0))) {
+			     megasas_get_ld_vf_affiliation(instance, 0)) {
 				dcmd_ret = megasas_ld_list_query(instance,
 						MR_LD_QUERY_TYPE_EXPOSED_TO_HOST);
 				if (dcmd_ret != DCMD_SUCCESS)
-- 
1.8.3.1

