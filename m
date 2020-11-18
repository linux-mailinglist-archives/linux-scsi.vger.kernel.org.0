Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6E2B7E22
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Nov 2020 14:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKRNNt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Nov 2020 08:13:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57997 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRNNt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Nov 2020 08:13:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kfNHN-0001Bz-Bc; Wed, 18 Nov 2020 13:13:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: lpfc: fix pointer defereference before it is null checked issue
Date:   Wed, 18 Nov 2020 13:13:45 +0000
Message-Id: <20201118131345.460631-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a null check on pointer lpfc_cmd after the pointer has been
dereferenced when pointers rdata and ndlp are initialized at the start
of the function. Fix this by only assigning rdata and ndlp after the
pointer lpfc_cmd has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 96e209be6ecb ("scsi: lpfc: Convert SCSI I/O completions to SLI-3 and SLI-4 handlers")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index f989490359a5..3b989f720937 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4022,8 +4022,8 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	struct lpfc_io_buf *lpfc_cmd =
 		(struct lpfc_io_buf *)pwqeIn->context1;
 	struct lpfc_vport *vport = pwqeIn->vport;
-	struct lpfc_rport_data *rdata = lpfc_cmd->rdata;
-	struct lpfc_nodelist *ndlp = rdata->pnode;
+	struct lpfc_rport_data *rdata;
+	struct lpfc_nodelist *ndlp;
 	struct scsi_cmnd *cmd;
 	unsigned long flags;
 	struct lpfc_fast_path_event *fast_path_evt;
@@ -4040,6 +4040,9 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 		return;
 	}
 
+	rdata = lpfc_cmd->rdata;
+	ndlp = rdata->pnode;
+
 	if (bf_get(lpfc_wcqe_c_xb, wcqe)) {
 		/* TOREMOVE - currently this flag is checked during
 		 * the release of lpfc_iocbq. Remove once we move
-- 
2.28.0

