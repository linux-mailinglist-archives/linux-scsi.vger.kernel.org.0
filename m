Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF58371768
	for <lists+linux-scsi@lfdr.de>; Mon,  3 May 2021 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhECPEo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 May 2021 11:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhECPEj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 3 May 2021 11:04:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CC08B19B;
        Mon,  3 May 2021 15:03:44 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/18] fnic: use scsi_host_busy_iter() to traverse commands
Date:   Mon,  3 May 2021 17:03:17 +0200
Message-Id: <20210503150333.130310-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210503150333.130310-1-hare@suse.de>
References: <20210503150333.130310-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use scsi_host_busy_iter() to traverse commands instead of
hand-crafted routines walking the command list.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/fnic/fnic_scsi.c | 821 ++++++++++++++++------------------
 1 file changed, 375 insertions(+), 446 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index f41d1b1c2e39..762cc8bd2653 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1361,90 +1361,90 @@ int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do)
 	return wq_work_done;
 }
 
-static void fnic_cleanup_io(struct fnic *fnic)
+static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data,
+				 bool reserved)
 {
-	int i;
+	struct fnic *fnic = data;
 	struct fnic_io_req *io_req;
 	unsigned long flags = 0;
-	struct scsi_cmnd *sc;
 	spinlock_t *io_lock;
 	unsigned long start_time = 0;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 
-	for (i = 0; i < fnic->fnic_max_tag_id; i++) {
-		io_lock = fnic_io_lock_tag(fnic, i);
-		spin_lock_irqsave(io_lock, flags);
-		sc = scsi_host_find_tag(fnic->lport->host, i);
-		if (!sc) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
-		if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-			!(CMD_FLAGS(sc) & FNIC_DEV_RST_DONE)) {
-			/*
-			 * We will be here only when FW completes reset
-			 * without sending completions for outstanding ios.
-			 */
-			CMD_FLAGS(sc) |= FNIC_DEV_RST_DONE;
-			if (io_req && io_req->dr_done)
-				complete(io_req->dr_done);
-			else if (io_req && io_req->abts_done)
-				complete(io_req->abts_done);
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		} else if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-		if (!io_req) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-
-		CMD_SP(sc) = NULL;
-
-		spin_unlock_irqrestore(io_lock, flags);
+	io_lock = fnic_io_lock_tag(fnic, sc->request->tag);
+	spin_lock_irqsave(io_lock, flags);
 
+	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
+	    !(CMD_FLAGS(sc) & FNIC_DEV_RST_DONE)) {
 		/*
-		 * If there is a scsi_cmnd associated with this io_req, then
-		 * free the corresponding state
+		 * We will be here only when FW completes reset
+		 * without sending completions for outstanding ios.
 		 */
-		start_time = io_req->start_time;
-		fnic_release_ioreq_buf(fnic, io_req, sc);
-		mempool_free(io_req, fnic->io_req_pool);
+		CMD_FLAGS(sc) |= FNIC_DEV_RST_DONE;
+		if (io_req && io_req->dr_done)
+			complete(io_req->dr_done);
+		else if (io_req && io_req->abts_done)
+			complete(io_req->abts_done);
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	} else if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
+	if (!io_req) {
+		spin_unlock_irqrestore(io_lock, flags);
+		goto cleanup_scsi_cmd;
+	}
 
-		sc->result = DID_TRANSPORT_DISRUPTED << 16;
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "%s: tag:0x%x : sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
-			      __func__, sc->request->tag, sc,
-			      (jiffies - start_time));
+	CMD_SP(sc) = NULL;
 
-		if (atomic64_read(&fnic->io_cmpl_skip))
-			atomic64_dec(&fnic->io_cmpl_skip);
-		else
-			atomic64_inc(&fnic_stats->io_stats.io_completions);
+	spin_unlock_irqrestore(io_lock, flags);
 
-		/* Complete the command to SCSI */
-		if (sc->scsi_done) {
-			if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED))
-				shost_printk(KERN_ERR, fnic->lport->host,
-				"Calling done for IO not issued to fw: tag:0x%x sc:0x%p\n",
-				 sc->request->tag, sc);
+	/*
+	 * If there is a scsi_cmnd associated with this io_req, then
+	 * free the corresponding state
+	 */
+	start_time = io_req->start_time;
+	fnic_release_ioreq_buf(fnic, io_req, sc);
+	mempool_free(io_req, fnic->io_req_pool);
 
-			FNIC_TRACE(fnic_cleanup_io,
-				  sc->device->host->host_no, i, sc,
-				  jiffies_to_msecs(jiffies - start_time),
-				  0, ((u64)sc->cmnd[0] << 32 |
-				  (u64)sc->cmnd[2] << 24 |
-				  (u64)sc->cmnd[3] << 16 |
-				  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
-				  (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+cleanup_scsi_cmd:
+	sc->result = DID_TRANSPORT_DISRUPTED << 16;
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		      "fnic_cleanup_io: tag:0x%x : sc:0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
+		      sc->request->tag, sc, (jiffies - start_time));
 
-			sc->scsi_done(sc);
-		}
+	if (atomic64_read(&fnic->io_cmpl_skip))
+		atomic64_dec(&fnic->io_cmpl_skip);
+	else
+		atomic64_inc(&fnic_stats->io_stats.io_completions);
+
+	/* Complete the command to SCSI */
+	if (sc->scsi_done) {
+		if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED))
+			shost_printk(KERN_ERR, fnic->lport->host,
+				     "Calling done for IO not issued to fw: tag:0x%x sc:0x%p\n",
+				     sc->request->tag, sc);
+
+		FNIC_TRACE(fnic_cleanup_io,
+			   sc->device->host->host_no, sc->request->tag, sc,
+			   jiffies_to_msecs(jiffies - start_time),
+			   0, ((u64)sc->cmnd[0] << 32 |
+			       (u64)sc->cmnd[2] << 24 |
+			       (u64)sc->cmnd[3] << 16 |
+			       (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
+			   (((u64)CMD_FLAGS(sc) << 32) | CMD_STATE(sc)));
+
+		sc->scsi_done(sc);
 	}
+	return true;
+}
+
+static void fnic_cleanup_io(struct fnic *fnic)
+{
+	scsi_host_busy_iter(fnic->lport->host,
+			    fnic_cleanup_io_iter, fnic);
 }
 
 void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
@@ -1555,143 +1555,141 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 	return 0;
 }
 
-static void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
+struct fnic_rport_abort_io_iter_data {
+	struct fnic *fnic;
+	u32 port_id;
+	int term_cnt;
+};
+
+static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data,
+				     bool reserved)
 {
-	int tag;
-	int abt_tag;
-	int term_cnt = 0;
+	struct fnic_rport_abort_io_iter_data *iter_data = data;
+	struct fnic *fnic = iter_data->fnic;
+	int abt_tag = sc->request->tag;
 	struct fnic_io_req *io_req;
 	spinlock_t *io_lock;
 	unsigned long flags;
-	struct scsi_cmnd *sc;
 	struct reset_stats *reset_stats = &fnic->fnic_stats.reset_stats;
 	struct terminate_stats *term_stats = &fnic->fnic_stats.term_stats;
 	struct scsi_lun fc_lun;
 	enum fnic_ioreq_state old_ioreq_state;
 
-	FNIC_SCSI_DBG(KERN_DEBUG,
-		      fnic->lport->host,
-		      "fnic_rport_exch_reset called portid 0x%06x\n",
-		      port_id);
-
-	if (fnic->in_remove)
-		return;
-
-	for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
-		abt_tag = tag;
-		io_lock = fnic_io_lock_tag(fnic, tag);
-		spin_lock_irqsave(io_lock, flags);
-		sc = scsi_host_find_tag(fnic->lport->host, tag);
-		if (!sc) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+	io_lock = fnic_io_lock_tag(fnic, abt_tag);
+	spin_lock_irqsave(io_lock, flags);
 
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+	io_req = (struct fnic_io_req *)CMD_SP(sc);
 
-		if (!io_req || io_req->port_id != port_id) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+	if (!io_req || io_req->port_id != iter_data->port_id) {
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
 
-		if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-			(!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+	if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
+	    (!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"fnic_rport_exch_reset dev rst not pending sc 0x%p\n",
 			sc);
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
 
-		/*
-		 * Found IO that is still pending with firmware and
-		 * belongs to rport that went away
-		 */
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-		if (io_req->abts_done) {
-			shost_printk(KERN_ERR, fnic->lport->host,
+	/*
+	 * Found IO that is still pending with firmware and
+	 * belongs to rport that went away
+	 */
+	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
+	if (io_req->abts_done) {
+		shost_printk(KERN_ERR, fnic->lport->host,
 			"fnic_rport_exch_reset: io_req->abts_done is set "
 			"state is %s\n",
 			fnic_ioreq_state_to_str(CMD_STATE(sc)));
-		}
+	}
 
-		if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED)) {
-			shost_printk(KERN_ERR, fnic->lport->host,
-				  "rport_exch_reset "
-				  "IO not yet issued %p tag 0x%x flags "
-				  "%x state %d\n",
-				  sc, tag, CMD_FLAGS(sc), CMD_STATE(sc));
-		}
-		old_ioreq_state = CMD_STATE(sc);
-		CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
-		CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
-		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
-			atomic64_inc(&reset_stats->device_reset_terminates);
-			abt_tag = (tag | FNIC_TAG_DEV_RST);
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"fnic_rport_exch_reset dev rst sc 0x%p\n",
-			sc);
-		}
+	if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED)) {
+		shost_printk(KERN_ERR, fnic->lport->host,
+			     "rport_exch_reset "
+			     "IO not yet issued %p tag 0x%x flags "
+			     "%x state %d\n",
+			     sc, abt_tag, CMD_FLAGS(sc), CMD_STATE(sc));
+	}
+	old_ioreq_state = CMD_STATE(sc);
+	CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
+	CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
+	if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
+		atomic64_inc(&reset_stats->device_reset_terminates);
+		abt_tag |= FNIC_TAG_DEV_RST;
+	}
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		      "fnic_rport_exch_reset dev rst sc 0x%p\n", sc);
+	BUG_ON(io_req->abts_done);
 
-		BUG_ON(io_req->abts_done);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		      "fnic_rport_reset_exch: Issuing abts\n");
 
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "fnic_rport_reset_exch: Issuing abts\n");
+	spin_unlock_irqrestore(io_lock, flags);
 
+	/* Now queue the abort command to firmware */
+	int_to_scsilun(sc->device->lun, &fc_lun);
+
+	if (fnic_queue_abort_io_req(fnic, abt_tag,
+				    FCPIO_ITMF_ABT_TASK_TERM,
+				    fc_lun.scsi_lun, io_req)) {
+		/*
+		 * Revert the cmd state back to old state, if
+		 * it hasn't changed in between. This cmd will get
+		 * aborted later by scsi_eh, or cleaned up during
+		 * lun reset
+		 */
+		spin_lock_irqsave(io_lock, flags);
+		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
+			CMD_STATE(sc) = old_ioreq_state;
+		spin_unlock_irqrestore(io_lock, flags);
+	} else {
+		spin_lock_irqsave(io_lock, flags);
+		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
+			CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
+		else
+			CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
 		spin_unlock_irqrestore(io_lock, flags);
+		atomic64_inc(&term_stats->terminates);
+		iter_data->term_cnt++;
+	}
+	return true;
+}
 
-		/* Now queue the abort command to firmware */
-		int_to_scsilun(sc->device->lun, &fc_lun);
+static void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
+{
+	struct terminate_stats *term_stats = &fnic->fnic_stats.term_stats;
+	struct fnic_rport_abort_io_iter_data iter_data = {
+		.fnic = fnic,
+		.port_id = port_id,
+		.term_cnt = 0,
+	};
 
-		if (fnic_queue_abort_io_req(fnic, abt_tag,
-					    FCPIO_ITMF_ABT_TASK_TERM,
-					    fc_lun.scsi_lun, io_req)) {
-			/*
-			 * Revert the cmd state back to old state, if
-			 * it hasn't changed in between. This cmd will get
-			 * aborted later by scsi_eh, or cleaned up during
-			 * lun reset
-			 */
-			spin_lock_irqsave(io_lock, flags);
-			if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-				CMD_STATE(sc) = old_ioreq_state;
-			spin_unlock_irqrestore(io_lock, flags);
-		} else {
-			spin_lock_irqsave(io_lock, flags);
-			if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
-				CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
-			else
-				CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
-			spin_unlock_irqrestore(io_lock, flags);
-			atomic64_inc(&term_stats->terminates);
-			term_cnt++;
-		}
-	}
-	if (term_cnt > atomic64_read(&term_stats->max_terminates))
-		atomic64_set(&term_stats->max_terminates, term_cnt);
+	FNIC_SCSI_DBG(KERN_DEBUG,
+		      fnic->lport->host,
+		      "fnic_rport_exch_reset called portid 0x%06x\n",
+		      port_id);
+
+	if (fnic->in_remove)
+		return;
+
+	scsi_host_busy_iter(fnic->lport->host, fnic_rport_abort_io_iter,
+			    &iter_data);
+	if (iter_data.term_cnt > atomic64_read(&term_stats->max_terminates))
+		atomic64_set(&term_stats->max_terminates, iter_data.term_cnt);
 
 }
 
 void fnic_terminate_rport_io(struct fc_rport *rport)
 {
-	int tag;
-	int abt_tag;
-	int term_cnt = 0;
-	struct fnic_io_req *io_req;
-	spinlock_t *io_lock;
-	unsigned long flags;
-	struct scsi_cmnd *sc;
-	struct scsi_lun fc_lun;
 	struct fc_rport_libfc_priv *rdata;
 	struct fc_lport *lport;
 	struct fnic *fnic;
-	struct fc_rport *cmd_rport;
-	struct reset_stats *reset_stats;
-	struct terminate_stats *term_stats;
-	enum fnic_ioreq_state old_ioreq_state;
 
 	if (!rport) {
 		printk(KERN_ERR "fnic_terminate_rport_io: rport is NULL\n");
@@ -1719,108 +1717,7 @@ void fnic_terminate_rport_io(struct fc_rport *rport)
 	if (fnic->in_remove)
 		return;
 
-	reset_stats = &fnic->fnic_stats.reset_stats;
-	term_stats = &fnic->fnic_stats.term_stats;
-
-	for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
-		abt_tag = tag;
-		io_lock = fnic_io_lock_tag(fnic, tag);
-		spin_lock_irqsave(io_lock, flags);
-		sc = scsi_host_find_tag(fnic->lport->host, tag);
-		if (!sc) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
-		if (!io_req) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-
-		cmd_rport = starget_to_rport(scsi_target(sc->device));
-		if (rport != cmd_rport) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-
-		if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-			(!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"fnic_terminate_rport_io dev rst not pending sc 0x%p\n",
-			sc);
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-		/*
-		 * Found IO that is still pending with firmware and
-		 * belongs to rport that went away
-		 */
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-		if (io_req->abts_done) {
-			shost_printk(KERN_ERR, fnic->lport->host,
-			"fnic_terminate_rport_io: io_req->abts_done is set "
-			"state is %s\n",
-			fnic_ioreq_state_to_str(CMD_STATE(sc)));
-		}
-		if (!(CMD_FLAGS(sc) & FNIC_IO_ISSUED)) {
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-				  "fnic_terminate_rport_io "
-				  "IO not yet issued %p tag 0x%x flags "
-				  "%x state %d\n",
-				  sc, tag, CMD_FLAGS(sc), CMD_STATE(sc));
-		}
-		old_ioreq_state = CMD_STATE(sc);
-		CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
-		CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
-		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
-			atomic64_inc(&reset_stats->device_reset_terminates);
-			abt_tag = (tag | FNIC_TAG_DEV_RST);
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			"fnic_terminate_rport_io dev rst sc 0x%p\n", sc);
-		}
-
-		BUG_ON(io_req->abts_done);
-
-		FNIC_SCSI_DBG(KERN_DEBUG,
-			      fnic->lport->host,
-			      "fnic_terminate_rport_io: Issuing abts\n");
-
-		spin_unlock_irqrestore(io_lock, flags);
-
-		/* Now queue the abort command to firmware */
-		int_to_scsilun(sc->device->lun, &fc_lun);
-
-		if (fnic_queue_abort_io_req(fnic, abt_tag,
-					    FCPIO_ITMF_ABT_TASK_TERM,
-					    fc_lun.scsi_lun, io_req)) {
-			/*
-			 * Revert the cmd state back to old state, if
-			 * it hasn't changed in between. This cmd will get
-			 * aborted later by scsi_eh, or cleaned up during
-			 * lun reset
-			 */
-			spin_lock_irqsave(io_lock, flags);
-			if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-				CMD_STATE(sc) = old_ioreq_state;
-			spin_unlock_irqrestore(io_lock, flags);
-		} else {
-			spin_lock_irqsave(io_lock, flags);
-			if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
-				CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
-			else
-				CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
-			spin_unlock_irqrestore(io_lock, flags);
-			atomic64_inc(&term_stats->terminates);
-			term_cnt++;
-		}
-	}
-	if (term_cnt > atomic64_read(&term_stats->max_terminates))
-		atomic64_set(&term_stats->max_terminates, term_cnt);
-
+	fnic_rport_exch_reset(fnic, rport->port_id);
 }
 
 /*
@@ -2115,165 +2012,183 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 	return ret;
 }
 
-/*
- * Clean up any pending aborts on the lun
- * For each outstanding IO on this lun, whose abort is not completed by fw,
- * issue a local abort. Wait for abort to complete. Return 0 if all commands
- * successfully aborted, 1 otherwise
- */
-static int fnic_clean_pending_aborts(struct fnic *fnic,
-				     struct scsi_cmnd *lr_sc,
-					 bool new_sc)
+struct fnic_pending_aborts_iter_data {
+	struct fnic *fnic;
+	struct scsi_cmnd *lr_sc;
+	struct scsi_device *lun_dev;
+	int ret;
+};
 
+static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc,
+				     void *data, bool reserved)
 {
-	int tag, abt_tag;
+	struct fnic_pending_aborts_iter_data *iter_data = data;
+	struct fnic *fnic = iter_data->fnic;
+	struct scsi_device *lun_dev = iter_data->lun_dev;
+	int abt_tag = sc->request->tag;
 	struct fnic_io_req *io_req;
 	spinlock_t *io_lock;
 	unsigned long flags;
-	int ret = 0;
-	struct scsi_cmnd *sc;
 	struct scsi_lun fc_lun;
-	struct scsi_device *lun_dev = lr_sc->device;
 	DECLARE_COMPLETION_ONSTACK(tm_done);
 	enum fnic_ioreq_state old_ioreq_state;
 
-	for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
-		io_lock = fnic_io_lock_tag(fnic, tag);
-		spin_lock_irqsave(io_lock, flags);
-		sc = scsi_host_find_tag(fnic->lport->host, tag);
-		/*
-		 * ignore this lun reset cmd if issued using new SC
-		 * or cmds that do not belong to this lun
-		 */
-		if (!sc || ((sc == lr_sc) && new_sc) || sc->device != lun_dev) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+	if (sc == iter_data->lr_sc || sc->device != lun_dev)
+		return true;
+	if (reserved)
+		return true;
 
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
-
-		if (!io_req || sc->device != lun_dev) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-
-		/*
-		 * Found IO that is still pending with firmware and
-		 * belongs to the LUN that we are resetting
-		 */
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-			      "Found IO in %s on lun\n",
-			      fnic_ioreq_state_to_str(CMD_STATE(sc)));
-
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
-		if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
-			(!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-				"%s dev rst not pending sc 0x%p\n", __func__,
-				sc);
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+	io_lock = fnic_io_lock_tag(fnic, abt_tag);
+	spin_lock_irqsave(io_lock, flags);
+	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	if (!io_req) {
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
 
-		if (io_req->abts_done)
-			shost_printk(KERN_ERR, fnic->lport->host,
-			  "%s: io_req->abts_done is set state is %s\n",
-			  __func__, fnic_ioreq_state_to_str(CMD_STATE(sc)));
-		old_ioreq_state = CMD_STATE(sc);
-		/*
-		 * Any pending IO issued prior to reset is expected to be
-		 * in abts pending state, if not we need to set
-		 * FNIC_IOREQ_ABTS_PENDING to indicate the IO is abort pending.
-		 * When IO is completed, the IO will be handed over and
-		 * handled in this function.
-		 */
-		CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
+	/*
+	 * Found IO that is still pending with firmware and
+	 * belongs to the LUN that we are resetting
+	 */
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
+		      "Found IO in %s on lun\n",
+		      fnic_ioreq_state_to_str(CMD_STATE(sc)));
 
-		BUG_ON(io_req->abts_done);
+	if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING) {
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
+	if ((CMD_FLAGS(sc) & FNIC_DEVICE_RESET) &&
+	    (!(CMD_FLAGS(sc) & FNIC_DEV_RST_ISSUED))) {
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			      "%s dev rst not pending sc 0x%p\n", __func__,
+			      sc);
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
 
-		abt_tag = tag;
-		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
-			abt_tag |= FNIC_TAG_DEV_RST;
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-				  "%s: dev rst sc 0x%p\n", __func__, sc);
-		}
+	if (io_req->abts_done)
+		shost_printk(KERN_ERR, fnic->lport->host,
+			     "%s: io_req->abts_done is set state is %s\n",
+			     __func__, fnic_ioreq_state_to_str(CMD_STATE(sc)));
+	old_ioreq_state = CMD_STATE(sc);
+	/*
+	 * Any pending IO issued prior to reset is expected to be
+	 * in abts pending state, if not we need to set
+	 * FNIC_IOREQ_ABTS_PENDING to indicate the IO is abort pending.
+	 * When IO is completed, the IO will be handed over and
+	 * handled in this function.
+	 */
+	CMD_STATE(sc) = FNIC_IOREQ_ABTS_PENDING;
 
-		CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
-		io_req->abts_done = &tm_done;
-		spin_unlock_irqrestore(io_lock, flags);
+	BUG_ON(io_req->abts_done);
 
-		/* Now queue the abort command to firmware */
-		int_to_scsilun(sc->device->lun, &fc_lun);
+	if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET) {
+		abt_tag |= FNIC_TAG_DEV_RST;
+		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+			      "%s: dev rst sc 0x%p\n", __func__, sc);
+	}
 
-		if (fnic_queue_abort_io_req(fnic, abt_tag,
-					    FCPIO_ITMF_ABT_TASK_TERM,
-					    fc_lun.scsi_lun, io_req)) {
-			spin_lock_irqsave(io_lock, flags);
-			io_req = (struct fnic_io_req *)CMD_SP(sc);
-			if (io_req)
-				io_req->abts_done = NULL;
-			if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-				CMD_STATE(sc) = old_ioreq_state;
-			spin_unlock_irqrestore(io_lock, flags);
-			ret = 1;
-			goto clean_pending_aborts_end;
-		} else {
-			spin_lock_irqsave(io_lock, flags);
-			if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
-				CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
-			spin_unlock_irqrestore(io_lock, flags);
-		}
-		CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
+	CMD_ABTS_STATUS(sc) = FCPIO_INVALID_CODE;
+	io_req->abts_done = &tm_done;
+	spin_unlock_irqrestore(io_lock, flags);
 
-		wait_for_completion_timeout(&tm_done,
-					    msecs_to_jiffies
-					    (fnic->config.ed_tov));
+	/* Now queue the abort command to firmware */
+	int_to_scsilun(sc->device->lun, &fc_lun);
 
-		/* Recheck cmd state to check if it is now aborted */
+	if (fnic_queue_abort_io_req(fnic, abt_tag,
+				    FCPIO_ITMF_ABT_TASK_TERM,
+				    fc_lun.scsi_lun, io_req)) {
 		spin_lock_irqsave(io_lock, flags);
 		io_req = (struct fnic_io_req *)CMD_SP(sc);
-		if (!io_req) {
-			spin_unlock_irqrestore(io_lock, flags);
-			CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_REQ_NULL;
-			continue;
-		}
+		if (io_req)
+			io_req->abts_done = NULL;
+		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
+			CMD_STATE(sc) = old_ioreq_state;
+		spin_unlock_irqrestore(io_lock, flags);
+		iter_data->ret = FAILED;
+		return false;
+	} else {
+		spin_lock_irqsave(io_lock, flags);
+		if (CMD_FLAGS(sc) & FNIC_DEVICE_RESET)
+			CMD_FLAGS(sc) |= FNIC_DEV_RST_TERM_ISSUED;
+		spin_unlock_irqrestore(io_lock, flags);
+	}
+	CMD_FLAGS(sc) |= FNIC_IO_INTERNAL_TERM_ISSUED;
 
-		io_req->abts_done = NULL;
+	wait_for_completion_timeout(&tm_done, msecs_to_jiffies
+				    (fnic->config.ed_tov));
 
-		/* if abort is still pending with fw, fail */
-		if (CMD_ABTS_STATUS(sc) == FCPIO_INVALID_CODE) {
-			spin_unlock_irqrestore(io_lock, flags);
-			CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_DONE;
-			ret = 1;
-			goto clean_pending_aborts_end;
-		}
-		CMD_STATE(sc) = FNIC_IOREQ_ABTS_COMPLETE;
+	/* Recheck cmd state to check if it is now aborted */
+	spin_lock_irqsave(io_lock, flags);
+	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	if (!io_req) {
+		spin_unlock_irqrestore(io_lock, flags);
+		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_REQ_NULL;
+		return true;
+	}
 
-		/* original sc used for lr is handled by dev reset code */
-		if (sc != lr_sc)
-			CMD_SP(sc) = NULL;
+	io_req->abts_done = NULL;
+
+	/* if abort is still pending with fw, fail */
+	if (CMD_ABTS_STATUS(sc) == FCPIO_INVALID_CODE) {
 		spin_unlock_irqrestore(io_lock, flags);
+		CMD_FLAGS(sc) |= FNIC_IO_ABT_TERM_DONE;
+		iter_data->ret = FAILED;
+		return false;
+	}
+	CMD_STATE(sc) = FNIC_IOREQ_ABTS_COMPLETE;
 
-		/* original sc used for lr is handled by dev reset code */
-		if (sc != lr_sc) {
-			fnic_release_ioreq_buf(fnic, io_req, sc);
-			mempool_free(io_req, fnic->io_req_pool);
-		}
+	/* original sc used for lr is handled by dev reset code */
+	if (sc != iter_data->lr_sc)
+		CMD_SP(sc) = NULL;
+	spin_unlock_irqrestore(io_lock, flags);
 
-		/*
-		 * Any IO is returned during reset, it needs to call scsi_done
-		 * to return the scsi_cmnd to upper layer.
-		 */
-		if (sc->scsi_done) {
-			/* Set result to let upper SCSI layer retry */
-			sc->result = DID_RESET << 16;
-			sc->scsi_done(sc);
-		}
+	/* original sc used for lr is handled by dev reset code */
+	if (sc != iter_data->lr_sc) {
+		fnic_release_ioreq_buf(fnic, io_req, sc);
+		mempool_free(io_req, fnic->io_req_pool);
 	}
 
+	/*
+	 * Any IO is returned during reset, it needs to call scsi_done
+	 * to return the scsi_cmnd to upper layer.
+	 */
+	if (sc->scsi_done) {
+		/* Set result to let upper SCSI layer retry */
+		sc->result = DID_RESET << 16;
+		sc->scsi_done(sc);
+	}
+	return true;
+}
+
+/*
+ * Clean up any pending aborts on the lun
+ * For each outstanding IO on this lun, whose abort is not completed by fw,
+ * issue a local abort. Wait for abort to complete. Return 0 if all commands
+ * successfully aborted, 1 otherwise
+ */
+static int fnic_clean_pending_aborts(struct fnic *fnic,
+				     struct scsi_cmnd *lr_sc,
+				     bool new_sc)
+
+{
+	int ret = SUCCESS;
+	struct fnic_pending_aborts_iter_data iter_data = {
+		.fnic = fnic,
+		.lun_dev = lr_sc->device,
+		.ret = SUCCESS,
+	};
+
+	if (new_sc)
+		iter_data.lr_sc = lr_sc;
+
+	scsi_host_busy_iter(fnic->lport->host,
+			    fnic_pending_aborts_iter, &iter_data);
+	if (iter_data.ret == FAILED) {
+		ret = iter_data.ret;
+		goto clean_pending_aborts_end;
+	}
 	schedule_timeout(msecs_to_jiffies(2 * fnic->config.ed_tov));
 
 	/* walk again to check, if IOs are still pending in fw */
@@ -2772,58 +2687,72 @@ void fnic_exch_mgr_reset(struct fc_lport *lp, u32 sid, u32 did)
 
 }
 
-/*
- * fnic_is_abts_pending() is a helper function that
- * walks through tag map to check if there is any IOs pending,if there is one,
- * then it returns 1 (true), otherwise 0 (false)
- * if @lr_sc is non NULL, then it checks IOs specific to particular LUN,
- * otherwise, it checks for all IOs.
- */
-int fnic_is_abts_pending(struct fnic *fnic, struct scsi_cmnd *lr_sc)
+static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data,
+				   bool reserved)
 {
-	int tag;
+	struct fnic_pending_aborts_iter_data *iter_data = data;
+	struct fnic *fnic = iter_data->fnic;
+	int cmd_state;
 	struct fnic_io_req *io_req;
 	spinlock_t *io_lock;
 	unsigned long flags;
-	int ret = 0;
-	struct scsi_cmnd *sc;
-	struct scsi_device *lun_dev = NULL;
 
-	if (lr_sc)
-		lun_dev = lr_sc->device;
+	/*
+	 * ignore this lun reset cmd or cmds that do not belong to
+	 * this lun
+	 */
+	if (iter_data->lr_sc && sc == iter_data->lr_sc)
+		return true;
+	if (iter_data->lun_dev && sc->device != iter_data->lun_dev)
+		return true;
 
-	/* walk again to check, if IOs are still pending in fw */
-	for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
-		sc = scsi_host_find_tag(fnic->lport->host, tag);
-		/*
-		 * ignore this lun reset cmd or cmds that do not belong to
-		 * this lun
-		 */
-		if (!sc || (lr_sc && (sc->device != lun_dev || sc == lr_sc)))
-			continue;
+	io_lock = fnic_io_lock_hash(fnic, sc);
+	spin_lock_irqsave(io_lock, flags);
 
-		io_lock = fnic_io_lock_hash(fnic, sc);
-		spin_lock_irqsave(io_lock, flags);
+	io_req = (struct fnic_io_req *)CMD_SP(sc);
+	if (!io_req) {
+		spin_unlock_irqrestore(io_lock, flags);
+		return true;
+	}
 
-		io_req = (struct fnic_io_req *)CMD_SP(sc);
+	/*
+	 * Found IO that is still pending with firmware and
+	 * belongs to the LUN that we are resetting
+	 */
+	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
+		      "Found IO in %s on lun\n",
+		      fnic_ioreq_state_to_str(CMD_STATE(sc)));
+	cmd_state = CMD_STATE(sc);
+	spin_unlock_irqrestore(io_lock, flags);
+	if (cmd_state == FNIC_IOREQ_ABTS_PENDING)
+		iter_data->ret = 1;
 
-		if (!io_req || sc->device != lun_dev) {
-			spin_unlock_irqrestore(io_lock, flags);
-			continue;
-		}
+	return iter_data->ret ? false : true;
+}
 
-		/*
-		 * Found IO that is still pending with firmware and
-		 * belongs to the LUN that we are resetting
-		 */
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
-			      "Found IO in %s on lun\n",
-			      fnic_ioreq_state_to_str(CMD_STATE(sc)));
+/*
+ * fnic_is_abts_pending() is a helper function that
+ * walks through tag map to check if there is any IOs pending,if there is one,
+ * then it returns 1 (true), otherwise 0 (false)
+ * if @lr_sc is non NULL, then it checks IOs specific to particular LUN,
+ * otherwise, it checks for all IOs.
+ */
+int fnic_is_abts_pending(struct fnic *fnic, struct scsi_cmnd *lr_sc)
+{
+	struct fnic_pending_aborts_iter_data iter_data = {
+		.fnic = fnic,
+		.lun_dev = NULL,
+		.ret = 0,
+	};
 
-		if (CMD_STATE(sc) == FNIC_IOREQ_ABTS_PENDING)
-			ret = 1;
-		spin_unlock_irqrestore(io_lock, flags);
+	if (lr_sc) {
+		iter_data.lun_dev = lr_sc->device;
+		iter_data.lr_sc = lr_sc;
 	}
 
-	return ret;
+	/* walk again to check, if IOs are still pending in fw */
+	scsi_host_busy_iter(fnic->lport->host,
+			    fnic_abts_pending_iter, &iter_data);
+
+	return iter_data.ret;
 }
-- 
2.29.2

