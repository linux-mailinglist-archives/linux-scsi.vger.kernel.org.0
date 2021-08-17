Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CA3EE958
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbhHQJRc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 05:17:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbhHQJRR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Aug 2021 05:17:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 46D8E21D44;
        Tue, 17 Aug 2021 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629191802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMEH0o3KwZ3qPbyOGuvmtd11cUkKiVSaGqOGZExzpkk=;
        b=FlLufHL+k5Z/Ep+gggiNmkbE2ZN1vohuWlBQDK2m2/DT28IQntG2AG5MdErIcfPt9X3OYX
        DhVgy8v26gqZAATAA9VOn6jwPQNY99vUF8kG6L+dTMKAy5/2ALTZI6/1NvWXo8p7E3tlUI
        vdvnmgog4pOXRuA1RW66Yghu5MdjnoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629191802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMEH0o3KwZ3qPbyOGuvmtd11cUkKiVSaGqOGZExzpkk=;
        b=nVhblV1EgEPeYdSfc4/a1+PtsIS6HF39oGsNM5QOHbqw51Raiw52PVFBYgBXOAyCMJ6/2H
        /Vj9nKRykJTE8yAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 41548A3BA9;
        Tue, 17 Aug 2021 09:16:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3E8C3518CE91; Tue, 17 Aug 2021 11:16:42 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH 25/51] lpfc: use fc_block_rport()
Date:   Tue, 17 Aug 2021 11:14:30 +0200
Message-Id: <20210817091456.73342-26-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817091456.73342-1-hare@suse.de>
References: <20210817091456.73342-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use fc_block_rport() instead of fc_block_scsi_eh() as the SCSI command
will be removed as argument for SCSI EH functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index d68c08af5514..0bbf767f7253 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5727,6 +5727,7 @@ static int
 lpfc_abort_handler(struct scsi_cmnd *cmnd)
 {
 	struct Scsi_Host  *shost = cmnd->device->host;
+	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
 	struct lpfc_iocbq *iocb;
@@ -5738,7 +5739,7 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 	unsigned long flags;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(waitq);
 
-	status = fc_block_scsi_eh(cmnd);
+	status = fc_block_rport(rport);
 	if (status != 0 && status != SUCCESS)
 		return status;
 
@@ -6187,6 +6188,7 @@ static int
 lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 {
 	struct Scsi_Host  *shost = cmnd->device->host;
+	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_rport_data *rdata;
 	struct lpfc_nodelist *pnode;
@@ -6196,7 +6198,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 	int status;
 	u32 logit = LOG_FCP;
 
-	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
+	rdata = rport->dd_data;
 	if (!rdata || !rdata->pnode) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0798 Device Reset rdata failure: rdata x%px\n",
@@ -6204,7 +6206,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 		return FAILED;
 	}
 	pnode = rdata->pnode;
-	status = fc_block_scsi_eh(cmnd);
+	status = fc_block_rport(rport);
 	if (status != 0 && status != SUCCESS)
 		return status;
 
@@ -6261,6 +6263,7 @@ static int
 lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 {
 	struct Scsi_Host  *shost = cmnd->device->host;
+	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_rport_data *rdata;
 	struct lpfc_nodelist *pnode;
@@ -6273,7 +6276,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 	unsigned long flags;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(waitq);
 
-	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
+	rdata = rport->dd_data;
 	if (!rdata || !rdata->pnode) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0799 Target Reset rdata failure: rdata x%px\n",
@@ -6281,7 +6284,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 		return FAILED;
 	}
 	pnode = rdata->pnode;
-	status = fc_block_scsi_eh(cmnd);
+	status = fc_block_rport(rport);
 	if (status != 0 && status != SUCCESS)
 		return status;
 
-- 
2.29.2

