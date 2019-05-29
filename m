Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E812DE31
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfE2N3T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:45564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbfE2N3M (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73AD0AFF4;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 16/24] snic: use reserved commands
Date:   Wed, 29 May 2019 15:28:53 +0200
Message-Id: <20190529132901.27645-17-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190529132901.27645-1-hare@suse.de>
References: <20190529132901.27645-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Use a reserved command for host and device reset.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/snic/snic.h      |  2 +-
 drivers/scsi/snic/snic_main.c |  3 ++
 drivers/scsi/snic/snic_scsi.c | 96 +++++++++++++++++++++++--------------------
 3 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/scsi/snic/snic.h b/drivers/scsi/snic/snic.h
index de0ab5fc8474..0af5918a6bb8 100644
--- a/drivers/scsi/snic/snic.h
+++ b/drivers/scsi/snic/snic.h
@@ -380,7 +380,7 @@ int snic_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
 int snic_abort_cmd(struct scsi_cmnd *);
 int snic_device_reset(struct scsi_cmnd *);
 int snic_host_reset(struct scsi_cmnd *);
-int snic_reset(struct Scsi_Host *, struct scsi_cmnd *);
+int snic_reset(struct Scsi_Host *);
 void snic_shutdown_scsi_cleanup(struct snic *);
 
 
diff --git a/drivers/scsi/snic/snic_main.c b/drivers/scsi/snic/snic_main.c
index 14f4ce665e58..f64111abb534 100644
--- a/drivers/scsi/snic/snic_main.c
+++ b/drivers/scsi/snic/snic_main.c
@@ -385,6 +385,9 @@ snic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		goto prob_end;
 	}
+	shost->nr_reserved_cmds = 1;
+	shost->can_queue--;
+	shost->use_reserved_cmd_q = true;
 	snic = shost_priv(shost);
 	snic->shost = shost;
 
diff --git a/drivers/scsi/snic/snic_scsi.c b/drivers/scsi/snic/snic_scsi.c
index b3650c989ed4..cbe022286ec2 100644
--- a/drivers/scsi/snic/snic_scsi.c
+++ b/drivers/scsi/snic/snic_scsi.c
@@ -2150,7 +2150,7 @@ snic_device_reset(struct scsi_cmnd *sc)
 	struct Scsi_Host *shost = sc->device->host;
 	struct snic *snic = shost_priv(shost);
 	struct snic_req_info *rqi = NULL;
-	int tag = snic_cmd_tag(sc);
+	struct scsi_cmnd *reset_sc = NULL;
 	int start_time = jiffies;
 	int ret = FAILED;
 	int dr_supp = 0;
@@ -2174,42 +2174,43 @@ snic_device_reset(struct scsi_cmnd *sc)
 		goto dev_rst_end;
 	}
 
-	/* There is no tag when lun reset is issue through ioctl. */
-	if (unlikely(tag <= SNIC_NO_TAG)) {
-		SNIC_HOST_INFO(snic->shost,
-			       "Devrst: LUN Reset Recvd thru IOCTL.\n");
+	reset_sc = scsi_get_reserved_cmd(sc->device);
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
+	/* Add special tag for dr coming from user spc */
+	rqi->tm_tag = SNIC_TAG_IOCTL_DEV_RST;
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
@@ -2229,10 +2230,11 @@ snic_device_reset(struct scsi_cmnd *sc)
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
@@ -2241,30 +2243,30 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
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
+	reset_sc = scsi_host_get_reserved_cmd(snic->shost);
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
@@ -2279,7 +2281,7 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 	}
 
 	spin_lock_irqsave(io_lock, flags);
-	CMD_FLAGS(sc) |= SNIC_HOST_RESET_ISSUED;
+	CMD_FLAGS(reset_sc) |= SNIC_HOST_RESET_ISSUED;
 	spin_unlock_irqrestore(io_lock, flags);
 	atomic64_inc(&snic->s_stats.reset.hba_resets);
 	SNIC_HOST_INFO(snic->shost, "Queued HBA Reset Successfully.\n");
@@ -2296,13 +2298,14 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 
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
@@ -2310,10 +2313,13 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
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
 
@@ -2326,7 +2332,7 @@ snic_issue_hba_reset(struct snic *snic, struct scsi_cmnd *sc)
 } /* end of snic_issue_hba_reset */
 
 int
-snic_reset(struct Scsi_Host *shost, struct scsi_cmnd *sc)
+snic_reset(struct Scsi_Host *shost)
 {
 	struct snic *snic = shost_priv(shost);
 	enum snic_state sv_state;
@@ -2355,7 +2361,7 @@ snic_reset(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	while (atomic_read(&snic->ios_inflight))
 		schedule_timeout(msecs_to_jiffies(1));
 
-	ret = snic_issue_hba_reset(snic, sc);
+	ret = snic_issue_hba_reset(snic);
 	if (ret) {
 		SNIC_HOST_ERR(shost,
 			      "reset:Host Reset Failed w/ err %d.\n",
@@ -2394,7 +2400,7 @@ snic_host_reset(struct scsi_cmnd *sc)
 		      sc, sc->cmnd[0], sc->request,
 		      snic_cmd_tag(sc), CMD_FLAGS(sc));
 
-	ret = snic_reset(shost, sc);
+	ret = snic_reset(shost);
 
 	SNIC_TRC(shost->host_no, snic_cmd_tag(sc), (ulong) sc,
 		 jiffies_to_msecs(jiffies - start_time),
-- 
2.16.4

