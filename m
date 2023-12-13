Return-Path: <linux-scsi+bounces-839-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327D80D43F
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 18:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ABB1C20362
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CD4E620;
	Mon, 11 Dec 2023 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="GdvXahEF"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA993;
	Mon, 11 Dec 2023 09:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=7057; q=dns/txt; s=iport;
  t=1702316457; x=1703526057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cpv6QwSm9+a1QAopqvXeKFSDxAz4QPiX1woop39G0X8=;
  b=GdvXahEFsTpCmIp2a1LSLUmYvuPJkf0Z5ZwSx/iuQU/cyCnS+k8hdeMM
   YQ7qEGrqeBdEdOZ8uRwoChXp74QuIRWewtqINaLLDWohGhsBOjROpACWn
   PWojjo6pvIlrOCCvrVVd3awupy2eZ3c/2Wmp8hTjAFld53/YlxvDmJ7gk
   E=;
X-CSE-ConnectionGUID: TV2WF/1kQ5atXiRr8OU45Q==
X-CSE-MsgGUID: g6spZEoHR5eC2la1bhYHWA==
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="158455421"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:40:56 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BBHaKr3009547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Dec 2023 17:40:55 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v6 09/13] scsi: fnic: Remove usage of host_lock
Date: Mon, 11 Dec 2023 09:36:13 -0800
Message-Id: <20231211173617.932990-10-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231211173617.932990-1-kartilak@cisco.com>
References: <20231211173617.932990-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-1.cisco.com

Remove usage of host_lock.
Replace with fnic_lock, where necessary.
fnic does not use host_lock. fnic uses fnic_lock.
Use fnic lock to protect fnic members in fnic_queuecommand.
Add log messages in error cases.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v4 and v5:
    Incorporate review comments from Martin:
	Modify patch commits to include a "---" separator.

Changes between v2 and v3:
    Squash the following commits into one:
    scsi: fnic: Remove usage of host_lock
    scsi: fnic: Use fnic_lock to protect fnic structures
    in queuecommand
---
 drivers/scsi/fnic/fnic_scsi.c | 55 ++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index c7f3bfc650d1..e9acb2e7dd2e 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -170,17 +170,14 @@ __fnic_set_state_flags(struct fnic *fnic, unsigned long st_flags,
 			unsigned long clearbits)
 {
 	unsigned long flags = 0;
-	unsigned long host_lock_flags = 0;
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	spin_lock_irqsave(fnic->lport->host->host_lock, host_lock_flags);
 
 	if (clearbits)
 		fnic->state_flags &= ~st_flags;
 	else
 		fnic->state_flags |= st_flags;
 
-	spin_unlock_irqrestore(fnic->lport->host->host_lock, host_lock_flags);
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	return;
@@ -427,14 +424,27 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	int io_lock_acquired = 0;
 	struct fc_rport_libfc_priv *rp;
 
-	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED)))
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+
+	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED))) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: fnic IO blocked flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
+			fnic->fnic_num, __func__, __LINE__, fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
-	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET)))
+	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET))) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: fnic flags: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
+			fnic->fnic_num, __func__, __LINE__, fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
 	rport = starget_to_rport(scsi_target(sc->device));
 	if (!rport) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				"returning DID_NO_CONNECT for IO as rport is NULL\n");
 		sc->result = DID_NO_CONNECT << 16;
@@ -444,6 +454,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 
 	ret = fc_remote_port_chkready(rport);
 	if (ret) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 				"rport is not ready\n");
 		atomic64_inc(&fnic_stats->misc_stats.rport_not_ready);
@@ -454,6 +465,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 
 	rp = rport->dd_data;
 	if (!rp || rp->rp_state == RPORT_ST_DELETE) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"rport 0x%x removed, returning DID_NO_CONNECT\n",
 			rport->port_id);
@@ -465,6 +477,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 	}
 
 	if (rp->rp_state != RPORT_ST_READY) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
 			"rport 0x%x in state 0x%x, returning DID_IMM_RETRY\n",
 			rport->port_id, rp->rp_state);
@@ -474,17 +487,17 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 		return 0;
 	}
 
-	if (lp->state != LPORT_ST_READY || !(lp->link_up))
+	if (lp->state != LPORT_ST_READY || !(lp->link_up)) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host,
+			"fnic<%d>: %s: %d: state not ready: %d/link not up: %d Returning HOST_BUSY\n",
+			fnic->fnic_num, __func__, __LINE__, lp->state, lp->link_up);
 		return SCSI_MLQUEUE_HOST_BUSY;
+	}
 
 	atomic_inc(&fnic->in_flight);
 
-	/*
-	 * Release host lock, use driver resource specific locks from here.
-	 * Don't re-enable interrupts in case they were disabled prior to the
-	 * caller disabling them.
-	 */
-	spin_unlock(lp->host->host_lock);
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 	fnic_priv(sc)->state = FNIC_IOREQ_NOT_INITED;
 	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
 
@@ -569,8 +582,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 			mempool_free(io_req, fnic->io_req_pool);
 		}
 		atomic_dec(&fnic->in_flight);
-		/* acquire host lock before returning to SCSI */
-		spin_lock(lp->host->host_lock);
 		return ret;
 	} else {
 		atomic64_inc(&fnic_stats->io_stats.active_ios);
@@ -598,8 +609,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 		spin_unlock_irqrestore(io_lock, flags);
 
 	atomic_dec(&fnic->in_flight);
-	/* acquire host lock before returning to SCSI */
-	spin_lock(lp->host->host_lock);
 	return ret;
 }
 
@@ -1493,18 +1502,17 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 					  struct fnic_io_req *io_req)
 {
 	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
-	struct Scsi_Host *host = fnic->lport->host;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	unsigned long flags;
 
-	spin_lock_irqsave(host->host_lock, flags);
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (unlikely(fnic_chk_state_flags_locked(fnic,
 						FNIC_FLAGS_IO_BLOCKED))) {
-		spin_unlock_irqrestore(host->host_lock, flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		return 1;
 	} else
 		atomic_inc(&fnic->in_flight);
-	spin_unlock_irqrestore(host->host_lock, flags);
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
 
@@ -1939,7 +1947,6 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 				       struct fnic_io_req *io_req)
 {
 	struct vnic_wq_copy *wq = &fnic->hw_copy_wq[0];
-	struct Scsi_Host *host = fnic->lport->host;
 	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
 	struct scsi_lun fc_lun;
 	int ret = 0;
@@ -1949,14 +1956,14 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 	if (tag == SCSI_NO_TAG)
 		tag = io_req->tag;
 
-	spin_lock_irqsave(host->host_lock, intr_flags);
+	spin_lock_irqsave(&fnic->fnic_lock, intr_flags);
 	if (unlikely(fnic_chk_state_flags_locked(fnic,
 						FNIC_FLAGS_IO_BLOCKED))) {
-		spin_unlock_irqrestore(host->host_lock, intr_flags);
+		spin_unlock_irqrestore(&fnic->fnic_lock, intr_flags);
 		return FAILED;
 	} else
 		atomic_inc(&fnic->in_flight);
-	spin_unlock_irqrestore(host->host_lock, intr_flags);
+	spin_unlock_irqrestore(&fnic->fnic_lock, intr_flags);
 
 	spin_lock_irqsave(&fnic->wq_copy_lock[0], intr_flags);
 
-- 
2.31.1


