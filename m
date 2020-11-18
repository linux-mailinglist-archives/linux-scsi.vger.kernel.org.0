Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663292B7E65
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Nov 2020 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgKRNht (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Nov 2020 08:37:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58688 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgKRNht (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Nov 2020 08:37:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kfNea-0002zN-EB; Wed, 18 Nov 2020 13:37:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: lpfc: remove dead code on second !ndlp check
Date:   Wed, 18 Nov 2020 13:37:44 +0000
Message-Id: <20201118133744.461385-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is a null check on the pointer ndlp that exits via
error path issue_ct_rsp_exit followed by another null check on the
same pointer that is almost identical to the previous null check
stanza and yet can never can be reached because the previous check
exited via issue_ct_rsp_exit. This is deadcode and can be removed.

Addresses-Coverity: ("Logically dead code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 35f4998504c1..41e3657c2d8d 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -1526,12 +1526,6 @@ lpfc_issue_ct_rsp(struct lpfc_hba *phba, struct bsg_job *job, uint32_t tag,
 			goto issue_ct_rsp_exit;
 		}
 
-		/* Check if the ndlp is active */
-		if (!ndlp) {
-			rc = IOCB_ERROR;
-			goto issue_ct_rsp_exit;
-		}
-
 		/* get a refernece count so the ndlp doesn't go away while
 		 * we respond
 		 */
-- 
2.28.0

