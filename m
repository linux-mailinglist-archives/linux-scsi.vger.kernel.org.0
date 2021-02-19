Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9C31F67C
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Feb 2021 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBSJY3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Feb 2021 04:24:29 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40767 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhBSJY1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Feb 2021 04:24:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UOxr5iR_1613726624;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UOxr5iR_1613726624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Feb 2021 17:23:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, dick.kennedy@broadcom.com,
        james.smart@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: lpfc: Fix different base types in assignment
Date:   Fri, 19 Feb 2021 17:23:42 +0800
Message-Id: <1613726622-38442-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warnings:
drivers/scsi/lpfc/lpfc_nvme.c:833:22: warning: incorrect type in
assignment (different base types)

cpu_to_le32() returns __le32, but sgl->sge_len is uint32_t type.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 39d147e..b916a20 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -833,7 +833,7 @@
 	 * operation.
 	 */
 	sgl = lpfc_ncmd->dma_sgl;
-	sgl->sge_len = cpu_to_le32(nCmd->cmdlen);
+	sgl->sge_len = (__force uint32_t)cpu_to_le32(nCmd->cmdlen);
 	if (phba->cfg_nvme_embed_cmd) {
 		sgl->addr_hi = 0;
 		sgl->addr_lo = 0;
-- 
1.8.3.1

