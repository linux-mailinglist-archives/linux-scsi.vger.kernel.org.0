Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98C81BF92E
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD3NUR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 09:20:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgD3NUL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 09:20:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA82CAF7C;
        Thu, 30 Apr 2020 13:20:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH RFC v3 29/41] snic: use reserved commands
Date:   Thu, 30 Apr 2020 15:18:52 +0200
Message-Id: <20200430131904.5847-30-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200430131904.5847-1-hare@suse.de>
References: <20200430131904.5847-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Use a reserved command for host and device reset.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/snic/snic.h      |   4 +-
 drivers/scsi/snic/snic_main.c |   8 +++
 drivers/scsi/snic/snic_scsi.c | 140 +++++++++++++++++-------------------------
 3 files changed, 66 insertions(+), 86 deletions(-)

diff --git a/drivers/scsi/snic/snic.h b/drivers/scsi/snic/snic.h
index de0ab5fc8474..7dc529ae8a90 100644
--- a/drivers/scsi/snic/snic.h
+++ b/drivers/scsi/snic/snic.h
@@ -59,7 +59,6 @@
  */
 #define SNIC_TAG_ABORT		BIT(30)		/* Tag indicating abort */
 #define SNIC_TAG_DEV_RST	BIT(29)		/* Tag for device reset */
-#define SNIC_TAG_IOCTL_DEV_RST	BIT(28)		/* Tag for User Device Reset */
 #define SNIC_TAG_MASK		(BIT(24) - 1)	/* Mask for lookup */
 #define SNIC_NO_TAG		-1
 
@@ -278,6 +277,7 @@ struct snic {
 
 	/* Scsi Host info */
 	struct Scsi_Host *shost;
+	struct scsi_device *shost_dev;
 
 	/* vnic related structures */
 	struct vnic_dev_bar bar0;
@@ -380,7 +380,7 @@ int snic_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
 int snic_abort_cmd(struct scsi_cmnd *);
 int snic_device_reset(struct scsi_cmnd *);
 int snic_host_reset(struct scsi_cmnd *);
-int snic_reset(struct Scsi_Host *, struct scsi_cmnd *);
+int snic_reset(struct Scsi_Host *);
 void snic_shutdown_scsi_cleanup(struct snic *);
 
 
diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
index 14f4ce665e58..f520da64ec8e 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -303,6 +303,7 @@ static int
 snic_add_host(struct Scsi_Host *shost, struct pci_dev *pdev)
 {
 	int ret = 0;
+	struct snic *snic = shost_priv(shost);
 
 	ret = scsi_add_host(shost, &pdev->dev);
 	if (ret) {
@@ -313,6 +314,12 @@ snic_add_host(struct Scsi_Host *shost, struct pci_dev *pdev)
 		return ret;
 	}
 
+	snic->shost_dev = scsi_get_virtual_dev(shost, 1, 0);
+	if (!snic->shost_dev) {
+		SNIC_HOST_ERR(shost,
+			      "snic: scsi_get_virtual_dev failed\n");
+		return -ENOMEM;
+	}
 	SNIC_BUG_ON(shost->work_q != NULL);
 	snprintf(shost->work_q_name, sizeof(shost->work_q_name), "scsi_wq_%d",
 		 shost->host_no);
@@ -385,6 +392,7 @@ snic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		goto prob_end;
 	}
+	shost->nr_reserved_cmds = 2;
 	snic = shost_priv(shost);
 	snic->shost = shost;
 
diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index b3650c989ed4..d42e178bfab3 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -77,7 +77,7 @@ static const char * const snic_io_status_str[] = {
 	[SNIC_STAT_FATAL_ERROR]	= "SNIC_STAT_FATAL_ERROR",
 };
 
-static void snic_scsi_cleanup(struct snic *, int);
+static void snic_scsi_cleanup(struct snic *);
 
 const char *
 snic_state_to_str(unsigned int state)
@@ -867,7 +867,6 @@ snic_process_itmf_cmpl(struct snic *snic,
 		break;
 
 	case SNIC_TAG_DEV_RST:
-	case SNIC_TAG_DEV_RST | SNIC_TAG_IOCTL_DEV_RST:
 		snic_proc_dr_cmpl_locked(snic, fwreq, cmpl_stat, cmnd_id, sc);
 		spin_unlock_irqrestore(io_lock, flags);
 		ret = 0;
@@ -920,7 +919,6 @@ static void
 snic_itmf_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 {
 	struct scsi_cmnd  *sc = NULL;
-	struct snic_req_info *rqi = NULL;
 	struct snic_itmf_cmpl *itmf_cmpl = NULL;
 	ulong ctx;
 	u32 cmnd_id;
@@ -938,14 +936,6 @@ snic_itmf_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 		      "Itmf_cmpl: nterm %u , flags 0x%x\n",
 		      le32_to_cpu(itmf_cmpl->nterminated), itmf_cmpl->flags);
 
-	/* spl case, dev reset issued through ioctl */
-	if (cmnd_id & SNIC_TAG_IOCTL_DEV_RST) {
-		rqi = (struct snic_req_info *) ctx;
-		sc = rqi->sc;
-
-		goto ioctl_dev_rst;
-	}
-
 	if ((cmnd_id & SNIC_TAG_MASK) >= snic->max_tag_id) {
 		SNIC_HOST_ERR(snic->shost,
 			      "Itmf_cmpl: Tag 0x%x out of Range,HdrStat %s\n",
@@ -958,7 +948,6 @@ snic_itmf_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 	sc = scsi_host_find_tag(snic->shost, cmnd_id & SNIC_TAG_MASK);
 	WARN_ON_ONCE(!sc);
 
-ioctl_dev_rst:
 	if (!sc) {
 		atomic64_inc(&snic->s_stats.io.sc_null);
 		SNIC_HOST_ERR(snic->shost,
@@ -974,13 +963,13 @@ snic_itmf_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 
 
 static void
-snic_hba_reset_scsi_cleanup(struct snic *snic, struct scsi_cmnd *sc)
+snic_hba_reset_scsi_cleanup(struct snic *snic)
 {
 	struct snic_stats *st = &snic->s_stats;
 	long act_ios = 0, act_fwreqs = 0;
 
 	SNIC_SCSI_DBG(snic->shost, "HBA Reset scsi cleanup.\n");
-	snic_scsi_cleanup(snic, snic_cmd_tag(sc));
+	snic_scsi_cleanup(snic);
 
 	/* Update stats on pending IOs */
 	act_ios = atomic64_read(&st->io.active);
@@ -1021,17 +1010,6 @@ snic_hba_reset_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 		      "reset_cmpl: type = %x, hdr_stat = %x, cmnd_id = %x, hid = %x, ctx = %lx\n",
 		      typ, hdr_stat, cmnd_id, hid, ctx);
 
-	/* spl case, host reset issued through ioctl */
-	if (cmnd_id == SCSI_NO_TAG) {
-		rqi = (struct snic_req_info *) ctx;
-		SNIC_HOST_INFO(snic->shost,
-			       "reset_cmpl:Tag %d ctx %lx cmpl stat %s\n",
-			       cmnd_id, ctx, snic_io_status_to_str(hdr_stat));
-		sc = rqi->sc;
-
-		goto ioctl_hba_rst;
-	}
-
 	if (cmnd_id >= snic->max_tag_id) {
 		SNIC_HOST_ERR(snic->shost,
 			      "reset_cmpl: Tag 0x%x out of Range,HdrStat %s\n",
@@ -1042,7 +1020,6 @@ snic_hba_reset_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 	}
 
 	sc = scsi_host_find_tag(snic->shost, cmnd_id);
-ioctl_hba_rst:
 	if (!sc) {
 		atomic64_inc(&snic->s_stats.io.sc_null);
 		SNIC_HOST_ERR(snic->shost,
@@ -1089,7 +1066,7 @@ snic_hba_reset_cmpl_handler(struct snic *snic, struct snic_fw_req *fwreq)
 	spin_unlock_irqrestore(io_lock, flags);
 
 	/* scsi cleanup */
-	snic_hba_reset_scsi_cleanup(snic, sc);
+	snic_hba_reset_scsi_cleanup(snic);
 
 	SNIC_BUG_ON(snic_get_state(snic) != SNIC_OFFLINE &&
 		    snic_get_state(snic) != SNIC_FWRESET);
@@ -2150,7 +2127,7 @@ snic_device_reset(struct scsi_cmnd *sc)
 	struct Scsi_Host *shost = sc->device->host;
 	struct snic *snic = shost_priv(shost);
 	struct snic_req_info *rqi = NULL;
-	int tag = snic_cmd_tag(sc);
+	struct scsi_cmnd *reset_sc = NULL;
 	int start_time = jiffies;
 	int ret = FAILED;
 	int dr_supp = 0;
@@ -2174,42 +2151,41 @@ snic_device_reset(struct scsi_cmnd *sc)
 		goto dev_rst_end;
 	}
 
-	/* There is no tag when lun reset is issue through ioctl. */
-	if (unlikely(tag <= SNIC_NO_TAG)) {
-		SNIC_HOST_INFO(snic->shost,
-			       "Devrst: LUN Reset Recvd thru IOCTL.\n");
+	reset_sc = scsi_get_reserved_cmd(sc->device, DMA_NONE, false);
+	if (!reset_sc)
+		goto dev_rst_end;
 
-		rqi = snic_req_init(snic, 0);
-		if (!rqi)
-			goto dev_rst_end;
+	rqi = snic_req_init(snic, 0);
+	if (!rqi)
+		goto dev_rst_end;
 
-		memset(scsi_cmd_priv(sc), 0,
-			sizeof(struct snic_internal_io_state));
-		CMD_SP(sc) = (char *)rqi;
-		CMD_FLAGS(sc) = SNIC_NO_FLAGS;
+	memset(scsi_cmd_priv(reset_sc), 0,
+	       sizeof(struct snic_internal_io_state));
+	CMD_SP(reset_sc) = (char *)rqi;
+	CMD_FLAGS(reset_sc) = SNIC_NO_FLAGS;
 
-		/* Add special tag for dr coming from user spc */
-		rqi->tm_tag = SNIC_TAG_IOCTL_DEV_RST;
-		rqi->sc = sc;
-	}
+	rqi->sc = reset_sc;
 
-	ret = snic_send_dr_and_wait(snic, sc);
+	ret = snic_send_dr_and_wait(snic, reset_sc);
 	if (ret) {
 		SNIC_HOST_ERR(snic->shost,
 			      "Devrst: IO w/ Tag %x Failed w/ err = %d\n",
-			      tag, ret);
+			      snic_cmd_tag(reset_sc), ret);
 
-		snic_unlink_and_release_req(snic, sc, 0);
+		snic_unlink_and_release_req(snic, reset_sc, 0);
 
 		goto dev_rst_end;
 	}
 
-	ret = snic_dr_finish(snic, sc);
+	ret = snic_dr_finish(snic, reset_sc);
 
 dev_rst_end:
-	SNIC_TRC(snic->shost->host_no, tag, (ulong) sc,
-		 jiffies_to_msecs(jiffies - start_time),
-		 0, SNIC_TRC_CMD(sc), SNIC_TRC_CMD_STATE_FLAGS(sc));
+	if (reset_sc) {
+		SNIC_TRC(snic->shost->host_no, snic_cmd_tag(reset_sc), (ulong) reset_sc,
+			 jiffies_to_msecs(jiffies - start_time),
+			 0, SNIC_TRC_CMD(reset_sc), SNIC_TRC_CMD_STATE_FLAGS(reset_sc));
+		scsi_put_reserved_cmd(reset_sc);
+	}
 
 	SNIC_SCSI_DBG(snic->shost,
 		      "Devrst: Returning from Device Reset : %s\n",
@@ -2229,10 +2205,11 @@ snic_device_reset(struct scsi_cmnd *sc)
  * snic_issue_hba_reset : Queues FW Reset Request.
  */
 static int
-snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
+snic_issue_hba_reset(struct snic *snic)
 {
 	struct snic_req_info *rqi = NULL;
 	struct snic_host_req *req = NULL;
+	struct scsi_cmnd *reset_sc;
 	spinlock_t *io_lock = NULL;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
@@ -2241,30 +2218,31 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 	rqi = snic_req_init(snic, 0);
 	if (!rqi) {
 		ret = -ENOMEM;
-
 		goto hba_rst_end;
 	}
 
-	if (snic_cmd_tag(sc) == SCSI_NO_TAG) {
-		memset(scsi_cmd_priv(sc), 0,
-			sizeof(struct snic_internal_io_state));
-		SNIC_HOST_INFO(snic->shost, "issu_hr:Host reset thru ioctl.\n");
-		rqi->sc = sc;
+	reset_sc = scsi_get_reserved_cmd(snic->shost_dev,
+					 DMA_NONE, false);
+	if (!reset_sc) {
+		ret = -EBUSY;
+		goto hba_rst_end_put;
 	}
-
+	memset(scsi_cmd_priv(reset_sc), 0,
+	       sizeof(struct snic_internal_io_state));
+	rqi->sc = reset_sc;
 	req = rqi_to_req(rqi);
 
-	io_lock = snic_io_lock_hash(snic, sc);
+	io_lock = snic_io_lock_hash(snic, reset_sc);
 	spin_lock_irqsave(io_lock, flags);
-	SNIC_BUG_ON(CMD_SP(sc) != NULL);
-	CMD_STATE(sc) = SNIC_IOREQ_PENDING;
-	CMD_SP(sc) = (char *) rqi;
-	CMD_FLAGS(sc) |= SNIC_IO_INITIALIZED;
+	SNIC_BUG_ON(CMD_SP(reset_sc) != NULL);
+	CMD_STATE(reset_sc) = SNIC_IOREQ_PENDING;
+	CMD_SP(reset_sc) = (char *) rqi;
+	CMD_FLAGS(reset_sc) |= SNIC_IO_INITIALIZED;
 	snic->remove_wait = &wait;
 	spin_unlock_irqrestore(io_lock, flags);
 
 	/* Initialize Request */
-	snic_io_hdr_enc(&req->hdr, SNIC_REQ_HBA_RESET, 0, snic_cmd_tag(sc),
+	snic_io_hdr_enc(&req->hdr, SNIC_REQ_HBA_RESET, 0, snic_cmd_tag(reset_sc),
 			snic->config.hid, 0, (ulong) rqi);
 
 	req->u.reset.flags = 0;
@@ -2279,7 +2257,7 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 	}
 
 	spin_lock_irqsave(io_lock, flags);
-	CMD_FLAGS(sc) |= SNIC_HOST_RESET_ISSUED;
+	CMD_FLAGS(reset_sc) |= SNIC_HOST_RESET_ISSUED;
 	spin_unlock_irqrestore(io_lock, flags);
 	atomic64_inc(&snic->s_stats.reset.hba_resets);
 	SNIC_HOST_INFO(snic->shost, "Queued HBA Reset Successfully.\n");
@@ -2296,13 +2274,14 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 
 	spin_lock_irqsave(io_lock, flags);
 	snic->remove_wait = NULL;
-	rqi = (struct snic_req_info *) CMD_SP(sc);
-	CMD_SP(sc) = NULL;
+	rqi = (struct snic_req_info *) CMD_SP(reset_sc);
+	CMD_SP(reset_sc) = NULL;
 	spin_unlock_irqrestore(io_lock, flags);
 
 	if (rqi)
 		snic_req_free(snic, rqi);
 
+	scsi_put_reserved_cmd(reset_sc);
 	ret = 0;
 
 	return ret;
@@ -2310,10 +2289,13 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 hba_rst_err:
 	spin_lock_irqsave(io_lock, flags);
 	snic->remove_wait = NULL;
-	rqi = (struct snic_req_info *) CMD_SP(sc);
-	CMD_SP(sc) = NULL;
+	rqi = (struct snic_req_info *) CMD_SP(reset_sc);
+	CMD_SP(reset_sc) = NULL;
 	spin_unlock_irqrestore(io_lock, flags);
 
+hba_rst_end_put:
+	if (reset_sc)
+		scsi_put_reserved_cmd(reset_sc);
 	if (rqi)
 		snic_req_free(snic, rqi);
 
@@ -2326,7 +2308,7 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 } /* end of snic_issue_hba_reset */
 
 int
-snic_reset(struct Scsi_Host *shost, struct scsi_cmnd *sc)
+snic_reset(struct Scsi_Host *shost)
 {
 	struct snic *snic = shost_priv(shost);
 	enum snic_state sv_state;
@@ -2355,7 +2337,7 @@ snic_reset(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	while (atomic_read(&snic->ios_inflight))
 		schedule_timeout(msecs_to_jiffies(1));
 
-	ret = snic_issue_hba_reset(snic, sc);
+	ret = snic_issue_hba_reset(snic);
 	if (ret) {
 		SNIC_HOST_ERR(shost,
 			      "reset:Host Reset Failed w/ err %d.\n",
@@ -2394,7 +2376,7 @@ snic_host_reset(struct scsi_cmnd *sc)
 		      sc, sc->cmnd[0], sc->request,
 		      snic_cmd_tag(sc), CMD_FLAGS(sc));
 
-	ret = snic_reset(shost, sc);
+	ret = snic_reset(shost);
 
 	SNIC_TRC(shost->host_no, snic_cmd_tag(sc), (ulong) sc,
 		 jiffies_to_msecs(jiffies - start_time),
@@ -2436,7 +2418,7 @@ snic_cmpl_pending_tmreq(struct snic *snic, struct scsi_cmnd *sc)
  * snic_scsi_cleanup: Walks through tag map and releases the reqs
  */
 static void
-snic_scsi_cleanup(struct snic *snic, int ex_tag)
+snic_scsi_cleanup(struct snic *snic)
 {
 	struct snic_req_info *rqi = NULL;
 	struct scsi_cmnd *sc = NULL;
@@ -2448,19 +2430,9 @@ snic_scsi_cleanup(struct snic *snic, int ex_tag)
 	SNIC_SCSI_DBG(snic->shost, "sc_clean: scsi cleanup.\n");
 
 	for (tag = 0; tag < snic->max_tag_id; tag++) {
-		/* Skip ex_tag */
-		if (tag == ex_tag)
-			continue;
-
 		io_lock = snic_io_lock_tag(snic, tag);
 		spin_lock_irqsave(io_lock, flags);
 		sc = scsi_host_find_tag(snic->shost, tag);
-		if (!sc) {
-			spin_unlock_irqrestore(io_lock, flags);
-
-			continue;
-		}
-
 		if (unlikely(snic_tmreq_pending(sc))) {
 			/*
 			 * When FW Completes reset w/o sending completions
@@ -2520,7 +2492,7 @@ snic_shutdown_scsi_cleanup(struct snic *snic)
 {
 	SNIC_HOST_INFO(snic->shost, "Shutdown time SCSI Cleanup.\n");
 
-	snic_scsi_cleanup(snic, SCSI_NO_TAG);
+	snic_scsi_cleanup(snic);
 } /* end of snic_shutdown_scsi_cleanup */
 
 /*
-- 
2.16.4

