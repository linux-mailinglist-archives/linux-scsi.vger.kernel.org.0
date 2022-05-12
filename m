Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49876524B1B
	for <lists+linux-scsi@lfdr.de>; Thu, 12 May 2022 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353052AbiELLNA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 May 2022 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353010AbiELLMw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 May 2022 07:12:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22460BA1
        for <linux-scsi@vger.kernel.org>; Thu, 12 May 2022 04:12:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 592471F92F;
        Thu, 12 May 2022 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652353966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05spcI19zUszoO5qQeumMBnCw6D8Gzr9o3dJShkLC+o=;
        b=ygXJ94i6UjCQThgWr2D6qYTv62A55pbf2VsnmdZcjAFrCaznL2t8A0An8NbN4xFHuRmeuQ
        PTFQO+0TfZTz1aflDyI67GxBbna8Z6aTlmXuEh97CfFM0fXU1NhPovI2hF4ZcK78ws37v8
        M5e4GRlXz2Da0jrrU3jjY0gAoLc+vjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652353966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05spcI19zUszoO5qQeumMBnCw6D8Gzr9o3dJShkLC+o=;
        b=mr9wnFMDm99RzB9R9EWKJ2kJTZqhcF71Fc0FVP3WJIqkDxSywv6KTeI+rsPZx8GwUiNLgr
        GJzpd4GesbIfGTAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 4D4452C152;
        Thu, 12 May 2022 11:12:46 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0CDEE51943E6; Thu, 12 May 2022 13:12:46 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Saurav Kashyap <skashyap@marvell.com>
Subject: [PATCH 07/20] bnx2fc: Do not rely on a scsi command for lun or target reset
Date:   Thu, 12 May 2022 13:12:23 +0200
Message-Id: <20220512111236.109851-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220512111236.109851-1-hare@suse.de>
References: <20220512111236.109851-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When a LUN or target reset is issued we should not rely on a scsi
command to be present; we'll have to reset the entire device or
target anyway.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc.h     |  1 +
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 14 +++--
 drivers/scsi/bnx2fc/bnx2fc_io.c  | 94 ++++++++++++++++----------------
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc.h b/drivers/scsi/bnx2fc/bnx2fc.h
index 046247420cfa..7e74f77da14f 100644
--- a/drivers/scsi/bnx2fc/bnx2fc.h
+++ b/drivers/scsi/bnx2fc/bnx2fc.h
@@ -384,6 +384,7 @@ struct bnx2fc_rport {
 };
 
 struct bnx2fc_mp_req {
+	u64 tm_lun;
 	u8 tm_flags;
 
 	u32 req_len;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 776544385598..090d436bcef8 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -1709,7 +1709,8 @@ void bnx2fc_init_task(struct bnx2fc_cmd *io_req,
 	struct fcoe_cached_sge_ctx *cached_sge;
 	struct fcoe_ext_mul_sges_ctx *sgl;
 	int dev_type = tgt->dev_type;
-	u64 *fcp_cmnd;
+	struct fcp_cmnd *fcp_cmnd;
+	u64 *raw_fcp_cmnd;
 	u64 tmp_fcp_cmnd[4];
 	u32 context_id;
 	int cnt, i;
@@ -1778,16 +1779,19 @@ void bnx2fc_init_task(struct bnx2fc_cmd *io_req,
 	task->txwr_rxrd.union_ctx.tx_seq.ctx.seq_cnt = 1;
 
 	/* Fill FCP_CMND IU */
-	fcp_cmnd = (u64 *)
+	fcp_cmnd = (struct fcp_cmnd *)&tmp_fcp_cmnd;
+	bnx2fc_build_fcp_cmnd(io_req, fcp_cmnd);
+	int_to_scsilun(sc_cmd->device->lun, &fcp_cmnd->fc_lun);
+	memcpy(fcp_cmnd->fc_cdb, sc_cmd->cmnd, sc_cmd->cmd_len);
+	raw_fcp_cmnd = (u64 *)
 		    task->txwr_rxrd.union_ctx.fcp_cmd.opaque;
-	bnx2fc_build_fcp_cmnd(io_req, (struct fcp_cmnd *)&tmp_fcp_cmnd);
 
 	/* swap fcp_cmnd */
 	cnt = sizeof(struct fcp_cmnd) / sizeof(u64);
 
 	for (i = 0; i < cnt; i++) {
-		*fcp_cmnd = cpu_to_be64(tmp_fcp_cmnd[i]);
-		fcp_cmnd++;
+		*raw_fcp_cmnd = cpu_to_be64(tmp_fcp_cmnd[i]);
+		raw_fcp_cmnd++;
 	}
 
 	/* Rx Write Tx Read */
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 962454f2e2b1..055d9424bc0d 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -658,10 +658,9 @@ int bnx2fc_init_mp_req(struct bnx2fc_cmd *io_req)
 	return SUCCESS;
 }
 
-static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
+static int bnx2fc_initiate_tmf(struct fc_lport *lport, struct fc_rport *rport,
+			       u64 tm_lun, u8 tm_flags)
 {
-	struct fc_lport *lport;
-	struct fc_rport *rport;
 	struct fc_rport_libfc_priv *rp;
 	struct fcoe_port *port;
 	struct bnx2fc_interface *interface;
@@ -670,7 +669,6 @@ static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
 	struct bnx2fc_mp_req *tm_req;
 	struct fcoe_task_ctx_entry *task;
 	struct fcoe_task_ctx_entry *task_page;
-	struct Scsi_Host *host = sc_cmd->device->host;
 	struct fc_frame_header *fc_hdr;
 	struct fcp_cmnd *fcp_cmnd;
 	int task_idx, index;
@@ -679,8 +677,6 @@ static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
 	u32 sid, did;
 	unsigned long start = jiffies;
 
-	lport = shost_priv(host);
-	rport = starget_to_rport(scsi_target(sc_cmd->device));
 	port = lport_priv(lport);
 	interface = port->priv;
 
@@ -691,7 +687,7 @@ static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
 	}
 	rp = rport->dd_data;
 
-	rc = fc_block_scsi_eh(sc_cmd);
+	rc = fc_block_rport(rport);
 	if (rc)
 		return rc;
 
@@ -720,7 +716,7 @@ static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
 		goto retry_tmf;
 	}
 	/* Initialize rest of io_req fields */
-	io_req->sc_cmd = sc_cmd;
+	io_req->sc_cmd = NULL;
 	io_req->port = port;
 	io_req->tgt = tgt;
 
@@ -738,11 +734,13 @@ static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
 	/* Set TM flags */
 	io_req->io_req_flags = 0;
 	tm_req->tm_flags = tm_flags;
+	tm_req->tm_lun = tm_lun;
 
 	/* Fill FCP_CMND */
 	bnx2fc_build_fcp_cmnd(io_req, (struct fcp_cmnd *)tm_req->req_buf);
 	fcp_cmnd = (struct fcp_cmnd *)tm_req->req_buf;
-	memset(fcp_cmnd->fc_cdb, 0,  sc_cmd->cmd_len);
+	int_to_scsilun(tm_lun, &fcp_cmnd->fc_lun);
+	memset(fcp_cmnd->fc_cdb, 0,  BNX2FC_MAX_CMD_LEN);
 	fcp_cmnd->fc_dl = 0;
 
 	/* Fill FC header */
@@ -765,8 +763,6 @@ static int bnx2fc_initiate_tmf(struct scsi_cmnd *sc_cmd, u8 tm_flags)
 	task = &(task_page[index]);
 	bnx2fc_init_mp_task(io_req, task);
 
-	bnx2fc_priv(sc_cmd)->io_req = io_req;
-
 	/* Obtain free SQ entry */
 	spin_lock_bh(&tgt->tgt_lock);
 	bnx2fc_add_2_sq(tgt, xid);
@@ -1064,7 +1060,10 @@ int bnx2fc_initiate_cleanup(struct bnx2fc_cmd *io_req)
  */
 int bnx2fc_eh_target_reset(struct scsi_cmnd *sc_cmd)
 {
-	return bnx2fc_initiate_tmf(sc_cmd, FCP_TMF_TGT_RESET);
+	struct fc_rport *rport = starget_to_rport(scsi_target(sc_cmd->device));
+	struct fc_lport *lport = shost_priv(rport_to_shost(rport));
+
+	return bnx2fc_initiate_tmf(lport, rport, 0, FCP_TMF_TGT_RESET);
 }
 
 /**
@@ -1077,7 +1076,11 @@ int bnx2fc_eh_target_reset(struct scsi_cmnd *sc_cmd)
  */
 int bnx2fc_eh_device_reset(struct scsi_cmnd *sc_cmd)
 {
-	return bnx2fc_initiate_tmf(sc_cmd, FCP_TMF_LUN_RESET);
+	struct fc_rport *rport = starget_to_rport(scsi_target(sc_cmd->device));
+	struct fc_lport *lport = shost_priv(rport_to_shost(rport));
+
+	return bnx2fc_initiate_tmf(lport, rport, sc_cmd->device->lun,
+				   FCP_TMF_LUN_RESET);
 }
 
 static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
@@ -1452,10 +1455,9 @@ void bnx2fc_process_abts_compl(struct bnx2fc_cmd *io_req,
 
 static void bnx2fc_lun_reset_cmpl(struct bnx2fc_cmd *io_req)
 {
-	struct scsi_cmnd *sc_cmd = io_req->sc_cmd;
 	struct bnx2fc_rport *tgt = io_req->tgt;
 	struct bnx2fc_cmd *cmd, *tmp;
-	u64 tm_lun = sc_cmd->device->lun;
+	struct bnx2fc_mp_req *tm_req = &io_req->mp_req;
 	u64 lun;
 	int rc = 0;
 
@@ -1467,8 +1469,10 @@ static void bnx2fc_lun_reset_cmpl(struct bnx2fc_cmd *io_req)
 	 */
 	list_for_each_entry_safe(cmd, tmp, &tgt->active_cmd_queue, link) {
 		BNX2FC_TGT_DBG(tgt, "LUN RST cmpl: scan for pending IOs\n");
+		if (!cmd->sc_cmd)
+			continue;
 		lun = cmd->sc_cmd->device->lun;
-		if (lun == tm_lun) {
+		if (lun == tm_req->tm_lun) {
 			/* Initiate ABTS on this cmd */
 			if (!test_and_set_bit(BNX2FC_FLAG_ISSUE_ABTS,
 					      &cmd->req_flags)) {
@@ -1572,31 +1576,36 @@ void bnx2fc_process_tm_compl(struct bnx2fc_cmd *io_req,
 		printk(KERN_ERR PFX "tmf's fc_hdr r_ctl = 0x%x\n",
 			fc_hdr->fh_r_ctl);
 	}
-	if (!bnx2fc_priv(sc_cmd)->io_req) {
-		printk(KERN_ERR PFX "tm_compl: io_req is NULL\n");
-		return;
-	}
-	switch (io_req->fcp_status) {
-	case FC_GOOD:
-		if (io_req->cdb_status == 0) {
-			/* Good IO completion */
-			sc_cmd->result = DID_OK << 16;
-		} else {
-			/* Transport status is good, SCSI status not good */
-			sc_cmd->result = (DID_OK << 16) | io_req->cdb_status;
+	if (sc_cmd) {
+		if (!bnx2fc_priv(sc_cmd)->io_req) {
+			printk(KERN_ERR PFX "tm_compl: io_req is NULL\n");
+			return;
+		}
+		switch (io_req->fcp_status) {
+		case FC_GOOD:
+			if (io_req->cdb_status == 0) {
+				/* Good IO completion */
+				sc_cmd->result = DID_OK << 16;
+			} else {
+				/* Transport status is good, SCSI status not good */
+				sc_cmd->result = (DID_OK << 16) | io_req->cdb_status;
+			}
+			if (io_req->fcp_resid)
+				scsi_set_resid(sc_cmd, io_req->fcp_resid);
+			break;
+
+		default:
+			BNX2FC_IO_DBG(io_req, "process_tm_compl: fcp_status = %d\n",
+				      io_req->fcp_status);
+			break;
 		}
-		if (io_req->fcp_resid)
-			scsi_set_resid(sc_cmd, io_req->fcp_resid);
-		break;
 
-	default:
-		BNX2FC_IO_DBG(io_req, "process_tm_compl: fcp_status = %d\n",
-			   io_req->fcp_status);
-		break;
-	}
+		sc_cmd = io_req->sc_cmd;
+		io_req->sc_cmd = NULL;
 
-	sc_cmd = io_req->sc_cmd;
-	io_req->sc_cmd = NULL;
+		bnx2fc_priv(sc_cmd)->io_req = NULL;
+		scsi_done(sc_cmd);
+	}
 
 	/* check if the io_req exists in tgt's tmf_q */
 	if (io_req->on_tmf_queue) {
@@ -1609,9 +1618,6 @@ void bnx2fc_process_tm_compl(struct bnx2fc_cmd *io_req,
 		return;
 	}
 
-	bnx2fc_priv(sc_cmd)->io_req = NULL;
-	scsi_done(sc_cmd);
-
 	kref_put(&io_req->refcount, bnx2fc_cmd_release);
 	if (io_req->wait_for_abts_comp) {
 		BNX2FC_IO_DBG(io_req, "tm_compl - wake up the waiter\n");
@@ -1740,15 +1746,9 @@ static void bnx2fc_unmap_sg_list(struct bnx2fc_cmd *io_req)
 void bnx2fc_build_fcp_cmnd(struct bnx2fc_cmd *io_req,
 				  struct fcp_cmnd *fcp_cmnd)
 {
-	struct scsi_cmnd *sc_cmd = io_req->sc_cmd;
-
 	memset(fcp_cmnd, 0, sizeof(struct fcp_cmnd));
 
-	int_to_scsilun(sc_cmd->device->lun, &fcp_cmnd->fc_lun);
-
 	fcp_cmnd->fc_dl = htonl(io_req->data_xfer_len);
-	memcpy(fcp_cmnd->fc_cdb, sc_cmd->cmnd, sc_cmd->cmd_len);
-
 	fcp_cmnd->fc_cmdref = 0;
 	fcp_cmnd->fc_pri_ta = 0;
 	fcp_cmnd->fc_tm_flags = io_req->mp_req.tm_flags;
-- 
2.29.2

