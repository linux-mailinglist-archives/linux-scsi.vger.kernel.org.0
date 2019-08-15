Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 399548E18E
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 01:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfHNX5x (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 19:57:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32954 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfHNX5w (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Aug 2019 19:57:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id go14so31876plb.0
        for <linux-scsi@vger.kernel.org>; Wed, 14 Aug 2019 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ra7PdEGkH0sh0JXJB2GXQR4HdV+bXslFZg1qWowcb+k=;
        b=P31BesteoTCZXpP2jqns00rhAKIkfuJxw/He12UTXhSCgZ9XACKo6AUb8vvzFDMCHU
         wu59tIRyX8Hk/pydEAMORgIH20SVsYTdRIvV5pbP7u3kzL0OploST0FyiqyUgJWqGsfC
         ftClzqnLSJm4s/cFwZfGnIsI08OWWjNSpxw7We9EIdDXr63Kw+W0w2Wfy4dL8NAQ055Q
         bRP+PY5wOhx3XeS4zMvNPXbCl2MOLXhCclMM8BW/OZUrcQ247WQ153IKd2OehCJQL9Tw
         kpyYb7TBJlP6x79NhyVVwrnFBOcdtetKOSxC45unETkIWN8dczbgO3otGO9247I1Y9Yx
         zJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ra7PdEGkH0sh0JXJB2GXQR4HdV+bXslFZg1qWowcb+k=;
        b=hDOrsOiVB+rBGoSxKSm4XIqotgazL424jG/f21RaHGb3K9UD9WyNycdj2892y3PADm
         y29xIdhQ6IzXSi3FlJ9c6gNmQMZvdKzMS11jzqmX84Ty9ZxksncBz1M9XDqcqUh2lVq0
         ZP7qFXP8uKTaIikckZ7Fr/IEM7h49zz0yMTw8my/bMiww9smpp4b1XaKmzpfjtls3riz
         3fhrUJ5OuDeVxxQloglz/N56QsWxccNqVNE61JMvp3jhK+iYr2SPfEbTntSImrytpsch
         eeKB3pHDeBZ5fsugiqCgzQmGZkc2a5almgx1lwmvMqN4F/yNbMfb/bZO3u1ONxipYm9b
         IAdw==
X-Gm-Message-State: APjAAAW/FdQiyhCHDCHE7A9qV2sPOWjG3+FwHk+TulkBvh/rcBCFaOBX
        uU7sFVeeTKoIgVsO8cBitWyEADoW
X-Google-Smtp-Source: APXvYqwypareXgkXGiqZYGjTENVxUaYr93ms6lBYhqQ1mgchAuNZh+KQ9LXtarAlRxvuYSJOFxV6LA==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr1821303ply.261.1565827070613;
        Wed, 14 Aug 2019 16:57:50 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k22sm987299pfk.157.2019.08.14.16.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 16:57:50 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 36/42] lpfc: Migrate to %px and %pf in kernel print calls
Date:   Wed, 14 Aug 2019 16:57:06 -0700
Message-Id: <20190814235712.4487-37-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190814235712.4487-1-jsmart2021@gmail.com>
References: <20190814235712.4487-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In order to see real addresses, convert %p with %px for kernel addresses
and replace %p with %pf for functions.

While converting, standardize on "x%px" throughout (not %px or 0x%px).

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c       |  2 +-
 drivers/scsi/lpfc/lpfc_ct.c        |  5 ++-
 drivers/scsi/lpfc/lpfc_debugfs.c   |  4 +-
 drivers/scsi/lpfc/lpfc_els.c       |  4 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c   | 78 +++++++++++++++++----------------
 drivers/scsi/lpfc/lpfc_init.c      | 18 ++++----
 drivers/scsi/lpfc/lpfc_nportdisc.c |  2 +-
 drivers/scsi/lpfc/lpfc_nvme.c      | 90 +++++++++++++++++++-------------------
 drivers/scsi/lpfc/lpfc_nvmet.c     | 10 ++---
 drivers/scsi/lpfc/lpfc_scsi.c      | 16 +++----
 drivers/scsi/lpfc/lpfc_sli.c       | 16 +++----
 11 files changed, 125 insertions(+), 120 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 9b9858078076..9966588ef3b2 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -1040,7 +1040,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 				if (!dmabuf) {
 					lpfc_printf_log(phba, KERN_ERR,
 						LOG_LIBDFC, "2616 No dmabuf "
-						"found for iocbq 0x%p\n",
+						"found for iocbq x%px\n",
 						iocbq);
 					kfree(evt_dat->data);
 					kfree(evt_dat);
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 1717f3403a97..25e86706e207 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -1227,8 +1227,9 @@ lpfc_cmpl_ct_cmd_gft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			if (fc4_data_1 &  LPFC_FC4_TYPE_BITMASK)
 				ndlp->nlp_fc4_type |= NLP_FC4_NVME;
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
-					 "3064 Setting ndlp %p, DID x%06x with "
-					 "FC4 x%08x, Data: x%08x x%08x %d\n",
+					 "3064 Setting ndlp x%px, DID x%06x "
+					 "with FC4 x%08x, Data: x%08x x%08x "
+					 "%d\n",
 					 ndlp, did, ndlp->nlp_fc4_type,
 					 FC_TYPE_FCP, FC_TYPE_NVME,
 					 ndlp->nlp_state);
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 1ee857d9d165..75055ee59e91 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -361,7 +361,7 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
 			phys = ((uint64_t)hbq_buf->dbuf.phys & 0xffffffff);
 			if (phys == le32_to_cpu(hbqe->bde.addrLow)) {
 				len +=  scnprintf(buf+len, size-len,
-					"Buf%d: %p %06x\n", i,
+					"Buf%d: x%px %06x\n", i,
 					hbq_buf->dbuf.virt, hbq_buf->tag);
 				found = 1;
 				break;
@@ -2210,7 +2210,7 @@ lpfc_debugfs_dumpDif_open(struct inode *inode, struct file *file)
 		goto out;
 
 	/* Round to page boundary */
-	pr_err("9060 BLKGRD: %s: _dump_buf_dif=0x%p file=%pD\n",
+	pr_err("9060 BLKGRD: %s: _dump_buf_dif=x%px file=%pD\n",
 			__func__, _dump_buf_dif, file);
 	debug->buffer = _dump_buf_dif;
 	if (!debug->buffer) {
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 54ec7f0822e5..aaad1c74bb98 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -2140,7 +2140,7 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 		    !(vport->fc_flag & FC_OFFLINE_MODE)) {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "4110 Issue PLOGI x%x deferred "
-					 "on NPort x%x rpi x%x Data: %p\n",
+					 "on NPort x%x rpi x%x Data: x%px\n",
 					 ndlp->nlp_defer_did, ndlp->nlp_DID,
 					 ndlp->nlp_rpi, ndlp);
 
@@ -4236,7 +4236,7 @@ lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	mempool_free(pmb, phba->mbox_mem_pool);
 	if (ndlp) {
 		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-				 "0006 rpi%x DID:%x flg:%x %d map:%x %p\n",
+				 "0006 rpi%x DID:%x flg:%x %d map:%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 				 kref_read(&ndlp->kref),
 				 ndlp->nlp_usg_map, ndlp);
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 95db23adc96d..01fc525f4826 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -133,7 +133,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		ndlp->nlp_sid, ndlp->nlp_DID, ndlp->nlp_flag);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3181 dev_loss_callbk x%06x, rport %p flg x%x\n",
+			 "3181 dev_loss_callbk x%06x, rport x%px flg x%x\n",
 			 ndlp->nlp_DID, ndlp->rport, ndlp->nlp_flag);
 
 	/* Don't defer this if we are in the process of deleting the vport
@@ -237,7 +237,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		ndlp->nlp_DID, ndlp->nlp_type, rport->scsi_target_id);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3182 dev_loss_tmo_handler x%06x, rport %p flg x%x\n",
+			 "3182 dev_loss_tmo_handler x%06x, rport x%px flg x%x\n",
 			 ndlp->nlp_DID, ndlp->rport, ndlp->nlp_flag);
 
 	/*
@@ -3323,7 +3323,7 @@ lpfc_mbx_process_link_up(struct lpfc_hba *phba, struct lpfc_mbx_read_top *la)
 out:
 	lpfc_vport_set_state(vport, FC_VPORT_FAILED);
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_MBOX,
-			 "0263 Discovery Mailbox error: state: 0x%x : %p %p\n",
+			 "0263 Discovery Mailbox error: state: 0x%x : x%px x%px\n",
 			 vport->port_state, sparam_mbox, cfglink_mbox);
 	lpfc_issue_clear_la(phba, vport);
 	return;
@@ -3535,7 +3535,7 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	pmb->ctx_ndlp = NULL;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
-			 "0002 rpi:%x DID:%x flg:%x %d map:%x %p\n",
+			 "0002 rpi:%x DID:%x flg:%x %d map:%x x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp->nlp_usg_map, ndlp);
@@ -4047,7 +4047,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
-			 "0003 rpi:%x DID:%x flg:%x %d map%x %p\n",
+			 "0003 rpi:%x DID:%x flg:%x %d map%x x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp->nlp_usg_map, ndlp);
@@ -4166,7 +4166,7 @@ lpfc_register_remote_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		fc_remote_port_rolechg(rport, rport_ids.roles);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3183 rport register x%06x, rport %p role x%x\n",
+			 "3183 rport register x%06x, rport x%px role x%x\n",
 			 ndlp->nlp_DID, rport, rport_ids.roles);
 
 	if ((rport->scsi_target_id != -1) &&
@@ -4190,7 +4190,7 @@ lpfc_unregister_remote_port(struct lpfc_nodelist *ndlp)
 		ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-			 "3184 rport unregister x%06x, rport %p\n",
+			 "3184 rport unregister x%06x, rport x%px\n",
 			 ndlp->nlp_DID, rport);
 
 	fc_remote_port_delete(rport);
@@ -4509,9 +4509,9 @@ lpfc_enable_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (NLP_CHK_FREE_REQ(ndlp)) {
 		spin_unlock_irqrestore(&phba->ndlp_lock, flags);
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
-				"0277 lpfc_enable_node: ndlp:x%p "
+				"0277 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 		goto free_rpi;
 	}
@@ -4519,9 +4519,9 @@ lpfc_enable_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (NLP_CHK_NODE_ACT(ndlp)) {
 		spin_unlock_irqrestore(&phba->ndlp_lock, flags);
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
-				"0278 lpfc_enable_node: ndlp:x%p "
+				"0278 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 		goto free_rpi;
 	}
@@ -4551,7 +4551,7 @@ lpfc_enable_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		ndlp->nlp_rpi = rpi;
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
 				 "0008 rpi:%x DID:%x flg:%x refcnt:%d "
-				 "map:%x %p\n", ndlp->nlp_rpi, ndlp->nlp_DID,
+				 "map:%x x%px\n", ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_flag,
 				 kref_read(&ndlp->kref),
 				 ndlp->nlp_usg_map, ndlp);
@@ -4824,7 +4824,7 @@ lpfc_nlp_logo_unreg(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	    (ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1434 UNREG cmpl deferred logo x%x "
-				 "on NPort x%x Data: x%x %p\n",
+				 "on NPort x%x Data: x%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_defer_did, ndlp);
 
@@ -4874,7 +4874,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "1436 unreg_rpi SKIP UNREG x%x on "
 					 "NPort x%x deferred x%x  flg x%x "
-					 "Data: %p\n",
+					 "Data: x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_defer_did,
 					 ndlp->nlp_flag, ndlp);
@@ -4924,7 +4924,8 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "1433 unreg_rpi UNREG x%x on "
-					 "NPort x%x deferred flg x%x Data:%p\n",
+					 "NPort x%x deferred flg x%x "
+					 "Data:x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp);
 
@@ -5065,16 +5066,16 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 			 ndlp->nlp_state, ndlp->nlp_rpi);
 	if (NLP_CHK_FREE_REQ(ndlp)) {
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
-				"0280 lpfc_cleanup_node: ndlp:x%p "
+				"0280 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 		lpfc_dequeue_node(vport, ndlp);
 	} else {
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
-				"0281 lpfc_cleanup_node: ndlp:x%p "
+				"0281 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 		lpfc_disable_node(vport, ndlp);
 	}
@@ -5165,7 +5166,7 @@ lpfc_nlp_remove(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		 * allocated by the firmware.
 		 */
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-				 "0005 rpi:%x DID:%x flg:%x %d map:%x %p\n",
+				 "0005 rpi:%x DID:%x flg:%x %d map:%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 				 kref_read(&ndlp->kref),
 				 ndlp->nlp_usg_map, ndlp);
@@ -5201,8 +5202,8 @@ lpfc_nlp_remove(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		 * for registered rport so need to cleanup rport
 		 */
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
-				"0940 removed node x%p DID x%x "
-				" rport not null %p\n",
+				"0940 removed node x%px DID x%x "
+				" rport not null x%px\n",
 				ndlp, ndlp->nlp_DID, ndlp->rport);
 		rport = ndlp->rport;
 		rdata = rport->dd_data;
@@ -5329,7 +5330,7 @@ lpfc_findnode_mapped(struct lpfc_vport *vport)
 			spin_unlock_irqrestore(shost->host_lock, iflags);
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
 					 "2025 FIND node DID "
-					 "Data: x%p x%x x%x x%x %p\n",
+					 "Data: x%px x%x x%x x%x x%px\n",
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1,
 					 ndlp->active_rrqs_xri_bitmap);
@@ -5996,7 +5997,7 @@ lpfc_mbx_cmpl_fdmi_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI,
-			 "0004 rpi:%x DID:%x flg:%x %d map:%x %p\n",
+			 "0004 rpi:%x DID:%x flg:%x %d map:%x x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp->nlp_usg_map, ndlp);
@@ -6050,8 +6051,8 @@ __lpfc_find_node(struct lpfc_vport *vport, node_filter filter, void *param)
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
 		if (filter(ndlp, param)) {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-					 "3185 FIND node filter %p DID "
-					 "ndlp %p did x%x flg x%x st x%x "
+					 "3185 FIND node filter %pf DID "
+					 "ndlp x%px did x%x flg x%x st x%x "
 					 "xri x%x type x%x rpi x%x\n",
 					 filter, ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp->nlp_state,
@@ -6061,7 +6062,7 @@ __lpfc_find_node(struct lpfc_vport *vport, node_filter filter, void *param)
 		}
 	}
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-			 "3186 FIND node filter %p NOT FOUND.\n", filter);
+			 "3186 FIND node filter %pf NOT FOUND.\n", filter);
 	return NULL;
 }
 
@@ -6185,7 +6186,7 @@ lpfc_nlp_init(struct lpfc_vport *vport, uint32_t did)
 		ndlp->nlp_rpi = rpi;
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
 				 "0007 rpi:%x DID:%x flg:%x refcnt:%d "
-				 "map:%x %p\n", ndlp->nlp_rpi, ndlp->nlp_DID,
+				 "map:%x x%px\n", ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_flag,
 				 kref_read(&ndlp->kref),
 				 ndlp->nlp_usg_map, ndlp);
@@ -6223,8 +6224,9 @@ lpfc_nlp_release(struct kref *kref)
 		ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			"0279 lpfc_nlp_release: ndlp:x%p did %x "
+			"0279 %s: ndlp:x%px did %x "
 			"usgmap:x%x refcnt:%d rpi:%x\n",
+			__func__,
 			(void *)ndlp, ndlp->nlp_DID, ndlp->nlp_usg_map,
 			kref_read(&ndlp->kref), ndlp->nlp_rpi);
 
@@ -6271,9 +6273,9 @@ lpfc_nlp_get(struct lpfc_nodelist *ndlp)
 		if (!NLP_CHK_NODE_ACT(ndlp) || NLP_CHK_FREE_ACK(ndlp)) {
 			spin_unlock_irqrestore(&phba->ndlp_lock, flags);
 			lpfc_printf_vlog(ndlp->vport, KERN_WARNING, LOG_NODE,
-				"0276 lpfc_nlp_get: ndlp:x%p "
+				"0276 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 			return NULL;
 		} else
@@ -6299,9 +6301,9 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 		return 1;
 
 	lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-	"node put:        did:x%x flg:x%x refcnt:x%x",
-		ndlp->nlp_DID, ndlp->nlp_flag,
-		kref_read(&ndlp->kref));
+			"node put:        did:x%x flg:x%x refcnt:x%x",
+			ndlp->nlp_DID, ndlp->nlp_flag,
+			kref_read(&ndlp->kref));
 	phba = ndlp->phba;
 	spin_lock_irqsave(&phba->ndlp_lock, flags);
 	/* Check the ndlp memory free acknowledge flag to avoid the
@@ -6311,9 +6313,9 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 	if (NLP_CHK_FREE_ACK(ndlp)) {
 		spin_unlock_irqrestore(&phba->ndlp_lock, flags);
 		lpfc_printf_vlog(ndlp->vport, KERN_WARNING, LOG_NODE,
-				"0274 lpfc_nlp_put: ndlp:x%p "
+				"0274 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 		return 1;
 	}
@@ -6324,9 +6326,9 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 	if (NLP_CHK_IACT_REQ(ndlp)) {
 		spin_unlock_irqrestore(&phba->ndlp_lock, flags);
 		lpfc_printf_vlog(ndlp->vport, KERN_WARNING, LOG_NODE,
-				"0275 lpfc_nlp_put: ndlp:x%p "
+				"0275 %s: ndlp:x%px "
 				"usgmap:x%x refcnt:%d\n",
-				(void *)ndlp, ndlp->nlp_usg_map,
+				__func__, (void *)ndlp, ndlp->nlp_usg_map,
 				kref_read(&ndlp->kref));
 		return 1;
 	}
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7227bd46244d..9cde3dc35437 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -2877,7 +2877,7 @@ lpfc_cleanup(struct lpfc_vport *vport)
 						&vport->fc_nodes, nlp_listp) {
 				lpfc_printf_vlog(ndlp->vport, KERN_ERR,
 						LOG_NODE,
-						"0282 did:x%x ndlp:x%p "
+						"0282 did:x%x ndlp:x%px "
 						"usgmap:x%x refcnt:%d\n",
 						ndlp->nlp_DID, (void *)ndlp,
 						ndlp->nlp_usg_map,
@@ -3081,7 +3081,7 @@ lpfc_sli4_node_prep(struct lpfc_hba *phba)
 			ndlp->nlp_rpi = rpi;
 			lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
 					 "0009 rpi:%x DID:%x "
-					 "flg:%x map:%x %p\n", ndlp->nlp_rpi,
+					 "flg:%x map:%x x%px\n", ndlp->nlp_rpi,
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_usg_map, ndlp);
 		}
@@ -3505,7 +3505,7 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
 					lpfc_printf_vlog(ndlp->vport,
 							 KERN_INFO, LOG_NODE,
 							 "0011 lpfc_offline: "
-							 "ndlp:x%p did %x "
+							 "ndlp:x%px did %x "
 							 "usgmap:x%x rpi:%x\n",
 							 ndlp, ndlp->nlp_DID,
 							 ndlp->nlp_usg_map,
@@ -7622,7 +7622,7 @@ lpfc_setup_bg(struct lpfc_hba *phba, struct Scsi_Host *shost)
 			if (_dump_buf_data) {
 				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
 					"9043 BLKGRD: allocated %d pages for "
-				       "_dump_buf_data at 0x%p\n",
+				       "_dump_buf_data at x%px\n",
 				       (1 << pagecnt), _dump_buf_data);
 				_dump_buf_data_order = pagecnt;
 				memset(_dump_buf_data, 0,
@@ -7637,7 +7637,7 @@ lpfc_setup_bg(struct lpfc_hba *phba, struct Scsi_Host *shost)
 			       "memory for hexdump\n");
 	} else
 		lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-			"9045 BLKGRD: already allocated _dump_buf_data=0x%p"
+			"9045 BLKGRD: already allocated _dump_buf_data=x%px"
 		       "\n", _dump_buf_data);
 	if (!_dump_buf_dif) {
 		while (pagecnt) {
@@ -7646,7 +7646,7 @@ lpfc_setup_bg(struct lpfc_hba *phba, struct Scsi_Host *shost)
 			if (_dump_buf_dif) {
 				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
 					"9046 BLKGRD: allocated %d pages for "
-				       "_dump_buf_dif at 0x%p\n",
+				       "_dump_buf_dif at x%px\n",
 				       (1 << pagecnt), _dump_buf_dif);
 				_dump_buf_dif_order = pagecnt;
 				memset(_dump_buf_dif, 0,
@@ -7661,7 +7661,7 @@ lpfc_setup_bg(struct lpfc_hba *phba, struct Scsi_Host *shost)
 			       "memory for hexdump\n");
 	} else
 		lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-			"9048 BLKGRD: already allocated _dump_buf_dif=0x%p\n",
+			"9048 BLKGRD: already allocated _dump_buf_dif=x%px\n",
 		       _dump_buf_dif);
 }
 
@@ -13594,14 +13594,14 @@ lpfc_exit(void)
 	fc_release_transport(lpfc_vport_transport_template);
 	if (_dump_buf_data) {
 		printk(KERN_ERR	"9062 BLKGRD: freeing %lu pages for "
-				"_dump_buf_data at 0x%p\n",
+				"_dump_buf_data at x%px\n",
 				(1L << _dump_buf_data_order), _dump_buf_data);
 		free_pages((unsigned long)_dump_buf_data, _dump_buf_data_order);
 	}
 
 	if (_dump_buf_dif) {
 		printk(KERN_ERR	"9049 BLKGRD: freeing %lu pages for "
-				"_dump_buf_dif at 0x%p\n",
+				"_dump_buf_dif at x%px\n",
 				(1L << _dump_buf_dif_order), _dump_buf_dif);
 		free_pages((unsigned long)_dump_buf_dif, _dump_buf_dif_order);
 	}
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index f4eea52c66f5..41ac07b99739 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -885,7 +885,7 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1435 release_rpi SKIP UNREG x%x on "
 				 "NPort x%x deferred x%x  flg x%x "
-				 "Data: %p\n",
+				 "Data: x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_defer_did,
 				 ndlp->nlp_flag, ndlp);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 106aef82620d..b599ddc40c6b 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -247,7 +247,7 @@ lpfc_nvme_create_queue(struct nvme_fc_local_port *pnvme_lport,
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
 			 "6073 Binding %s HdwQueue %d  (cpu %d) to "
-			 "hdw_queue %d qhandle %p\n", str,
+			 "hdw_queue %d qhandle x%px\n", str,
 			 qidx, qhandle->cpu_id, qhandle->index, qhandle);
 	*handle = (void *)qhandle;
 	return 0;
@@ -282,7 +282,7 @@ lpfc_nvme_delete_queue(struct nvme_fc_local_port *pnvme_lport,
 	vport = lport->vport;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-			"6001 ENTER.  lpfc_pnvme %p, qidx x%x qhandle %p\n",
+			"6001 ENTER.  lpfc_pnvme x%px, qidx x%x qhandle x%px\n",
 			lport, qidx, handle);
 	kfree(handle);
 }
@@ -293,7 +293,7 @@ lpfc_nvme_localport_delete(struct nvme_fc_local_port *localport)
 	struct lpfc_nvme_lport *lport = localport->private;
 
 	lpfc_printf_vlog(lport->vport, KERN_INFO, LOG_NVME,
-			 "6173 localport %p delete complete\n",
+			 "6173 localport x%px delete complete\n",
 			 lport);
 
 	/* release any threads waiting for the unreg to complete */
@@ -332,7 +332,7 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	 * calling state machine to remove the node.
 	 */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			"6146 remoteport delete of remoteport %p\n",
+			"6146 remoteport delete of remoteport x%px\n",
 			remoteport);
 	spin_lock_irq(&vport->phba->hbalock);
 
@@ -383,8 +383,8 @@ lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	ndlp = (struct lpfc_nodelist *)cmdwqe->context1;
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 			 "6047 nvme cmpl Enter "
-			 "Data %p DID %x Xri: %x status %x reason x%x cmd:%p "
-			 "lsreg:%p bmp:%p ndlp:%p\n",
+			 "Data %px DID %x Xri: %x status %x reason x%x "
+			 "cmd:x%px lsreg:x%px bmp:x%px ndlp:x%px\n",
 			 pnvme_lsreq, ndlp ? ndlp->nlp_DID : 0,
 			 cmdwqe->sli4_xritag, status,
 			 (wcqe->parameter & 0xffff),
@@ -404,7 +404,7 @@ lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	else
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
 				 "6046 nvme cmpl without done call back? "
-				 "Data %p DID %x Xri: %x status %x\n",
+				 "Data %px DID %x Xri: %x status %x\n",
 				pnvme_lsreq, ndlp ? ndlp->nlp_DID : 0,
 				cmdwqe->sli4_xritag, status);
 	if (ndlp) {
@@ -517,7 +517,8 @@ lpfc_nvme_gen_req(struct lpfc_vport *vport, struct lpfc_dmabuf *bmp,
 	/* Issue GEN REQ WQE for NPORT <did> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "6050 Issue GEN REQ WQE to NPORT x%x "
-			 "Data: x%x x%x wq:%p lsreq:%p bmp:%p xmit:%d 1st:%d\n",
+			 "Data: x%x x%x wq:x%px lsreq:x%px bmp:x%px "
+			 "xmit:%d 1st:%d\n",
 			 ndlp->nlp_DID, genwqe->iotag,
 			 vport->port_state,
 			genwqe, pnvme_lsreq, bmp, xmit_len, first_len);
@@ -595,7 +596,7 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 	ndlp = rport->ndlp;
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
-				 "6051 Remoteport %p, rport has invalid ndlp. "
+				 "6051 Remoteport x%px, rport has invalid ndlp. "
 				 "Failing LS Req\n", pnvme_rport);
 		return -ENODEV;
 	}
@@ -647,10 +648,10 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 
 	/* Expand print to include key fields. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			 "6149 Issue LS Req to DID 0x%06x lport %p, rport %p "
-			 "lsreq%p rqstlen:%d rsplen:%d %pad %pad\n",
-			 ndlp->nlp_DID,
-			 pnvme_lport, pnvme_rport,
+			 "6149 Issue LS Req to DID 0x%06x lport x%px, "
+			 "rport x%px lsreq x%px rqstlen:%d rsplen:%d "
+			 "%pad %pad\n",
+			 ndlp->nlp_DID, pnvme_lport, pnvme_rport,
 			 pnvme_lsreq, pnvme_lsreq->rqstlen,
 			 pnvme_lsreq->rsplen, &pnvme_lsreq->rqstdma,
 			 &pnvme_lsreq->rspdma);
@@ -666,8 +667,8 @@ lpfc_nvme_ls_req(struct nvme_fc_local_port *pnvme_lport,
 	if (ret != WQE_SUCCESS) {
 		atomic_inc(&lport->xmt_ls_err);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
-				 "6052 EXIT. issue ls wqe failed lport %p, "
-				 "rport %p lsreq%p Status %x DID %x\n",
+				 "6052 EXIT. issue ls wqe failed lport x%px, "
+				 "rport x%px lsreq x%px Status %x DID %x\n",
 				 pnvme_lport, pnvme_rport, pnvme_lsreq,
 				 ret, ndlp->nlp_DID);
 		lpfc_mbuf_free(vport->phba, bmp->virt, bmp->phys);
@@ -724,7 +725,7 @@ lpfc_nvme_ls_abort(struct nvme_fc_local_port *pnvme_lport,
 
 	/* Expand print to include key fields. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_ABTS,
-			 "6040 ENTER.  lport %p, rport %p lsreq %p rqstlen:%d "
+			 "6040 ENTER.  lport x%px, rport x%px lsreq x%px rqstlen:%d "
 			 "rsplen:%d %pad %pad\n",
 			 pnvme_lport, pnvme_rport,
 			 pnvme_lsreq, pnvme_lsreq->rqstlen,
@@ -985,8 +986,8 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	if (!lpfc_ncmd->nvmeCmd) {
 		spin_unlock(&lpfc_ncmd->buf_lock);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE | LOG_NVME_IOERR,
-				 "6066 Missing cmpl ptrs: lpfc_ncmd %p, "
-				 "nvmeCmd %p\n",
+				 "6066 Missing cmpl ptrs: lpfc_ncmd x%px, "
+				 "nvmeCmd x%px\n",
 				 lpfc_ncmd, lpfc_ncmd->nvmeCmd);
 
 		/* Release the lpfc_ncmd regardless of the missing elements. */
@@ -1101,8 +1102,8 @@ lpfc_nvme_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 			if (lpfc_ncmd->result == IOERR_ABORT_REQUESTED)
 				lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NVME_IOERR,
-					 "6032 Delay Aborted cmd %p "
-					 "nvme cmd %p, xri x%x, "
+					 "6032 Delay Aborted cmd x%px "
+					 "nvme cmd x%px, xri x%x, "
 					 "xb %d\n",
 					 lpfc_ncmd, nCmd,
 					 lpfc_ncmd->cur_iocbq.sli4_xritag,
@@ -1506,8 +1507,8 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	ndlp = rport->ndlp;
 	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_NVME_IOERR,
-				 "6053 Fail IO, ndlp not ready: rport %p "
-				  "ndlp %p, DID x%06x\n",
+				 "6053 Busy IO, ndlp not ready: rport x%px "
+				  "ndlp x%px, DID x%06x\n",
 				 rport, ndlp, pnvme_rport->port_id);
 		atomic_inc(&lport->xmt_fcp_err);
 		ret = -EBUSY;
@@ -1759,7 +1760,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	/* Announce entry to new IO submit field. */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_ABTS,
 			 "6002 Abort Request to rport DID x%06x "
-			 "for nvme_fc_req %p\n",
+			 "for nvme_fc_req x%px\n",
 			 pnvme_rport->port_id,
 			 pnvme_fcreq);
 
@@ -1806,8 +1807,8 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	if (lpfc_nbuf->nvmeCmd != pnvme_fcreq) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
 				 "6143 NVME req mismatch: "
-				 "lpfc_nbuf %p nvmeCmd %p, "
-				 "pnvme_fcreq %p.  Skipping Abort xri x%x\n",
+				 "lpfc_nbuf x%px nvmeCmd x%px, "
+				 "pnvme_fcreq x%px.  Skipping Abort xri x%x\n",
 				 lpfc_nbuf, lpfc_nbuf->nvmeCmd,
 				 pnvme_fcreq, nvmereq_wqe->sli4_xritag);
 		goto out_unlock;
@@ -1816,7 +1817,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	/* Don't abort IOs no longer on the pending queue. */
 	if (!(nvmereq_wqe->iocb_flag & LPFC_IO_ON_TXCMPLQ)) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
-				 "6142 NVME IO req %p not queued - skipping "
+				 "6142 NVME IO req x%px not queued - skipping "
 				 "abort req xri x%x\n",
 				 pnvme_fcreq, nvmereq_wqe->sli4_xritag);
 		goto out_unlock;
@@ -1831,8 +1832,8 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	if (nvmereq_wqe->iocb_flag & LPFC_DRIVER_ABORTED) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
 				 "6144 Outstanding NVME I/O Abort Request "
-				 "still pending on nvme_fcreq %p, "
-				 "lpfc_ncmd %p xri x%x\n",
+				 "still pending on nvme_fcreq x%px, "
+				 "lpfc_ncmd %px xri x%x\n",
 				 pnvme_fcreq, lpfc_nbuf,
 				 nvmereq_wqe->sli4_xritag);
 		goto out_unlock;
@@ -1842,7 +1843,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	if (!abts_buf) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
 				 "6136 No available abort wqes. Skipping "
-				 "Abts req for nvme_fcreq %p xri x%x\n",
+				 "Abts req for nvme_fcreq x%px xri x%x\n",
 				 pnvme_fcreq, nvmereq_wqe->sli4_xritag);
 		goto out_unlock;
 	}
@@ -1893,7 +1894,7 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	if (ret_val) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_ABTS,
 				 "6137 Failed abts issue_wqe with status x%x "
-				 "for nvme_fcreq %p.\n",
+				 "for nvme_fcreq x%px.\n",
 				 ret_val, pnvme_fcreq);
 		lpfc_sli_release_iocbq(phba, abts_buf);
 		return;
@@ -2096,8 +2097,8 @@ lpfc_nvme_create_localport(struct lpfc_vport *vport)
 	if (!ret) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME | LOG_NVME_DISC,
 				 "6005 Successfully registered local "
-				 "NVME port num %d, localP %p, private %p, "
-				 "sg_seg %d\n",
+				 "NVME port num %d, localP x%px, private "
+				 "x%px, sg_seg %d\n",
 				 localport->port_num, localport,
 				 localport->private,
 				 lpfc_nvme_template.max_sgl_segments);
@@ -2165,7 +2166,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 					pending += pring->txcmplq_cnt;
 			}
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_IOERR,
-					 "6176 Lport %p Localport %p wait "
+					 "6176 Lport x%px Localport x%px wait "
 					 "timed out. Pending %d. Renewing.\n",
 					 lport, vport->localport, pending);
 			continue;
@@ -2173,7 +2174,7 @@ lpfc_nvme_lport_unreg_wait(struct lpfc_vport *vport,
 		break;
 	}
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_IOERR,
-			 "6177 Lport %p Localport %p Complete Success\n",
+			 "6177 Lport x%px Localport x%px Complete Success\n",
 			 lport, vport->localport);
 }
 #endif
@@ -2204,7 +2205,7 @@ lpfc_nvme_destroy_localport(struct lpfc_vport *vport)
 	lport = (struct lpfc_nvme_lport *)localport->private;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-			 "6011 Destroying NVME localport %p\n",
+			 "6011 Destroying NVME localport x%px\n",
 			 localport);
 
 	/* lport's rport list is clear.  Unregister
@@ -2254,12 +2255,12 @@ lpfc_nvme_update_localport(struct lpfc_vport *vport)
 	lport = (struct lpfc_nvme_lport *)localport->private;
 	if (!lport) {
 		lpfc_printf_vlog(vport, KERN_WARNING, LOG_NVME,
-				 "6171 Update NVME fail. localP %p, No lport\n",
+				 "6171 Update NVME fail. localP x%px, No lport\n",
 				 localport);
 		return;
 	}
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-			 "6012 Update NVME lport %p did x%x\n",
+			 "6012 Update NVME lport x%px did x%x\n",
 			 localport, vport->fc_myDID);
 
 	localport->port_id = vport->fc_myDID;
@@ -2269,7 +2270,7 @@ lpfc_nvme_update_localport(struct lpfc_vport *vport)
 		localport->port_role = FC_PORT_ROLE_NVME_INITIATOR;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			 "6030 bound lport %p to DID x%06x\n",
+			 "6030 bound lport x%px to DID x%06x\n",
 			 lport, localport->port_id);
 #endif
 }
@@ -2350,8 +2351,9 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				lpfc_printf_vlog(ndlp->vport, KERN_INFO,
 						 LOG_NVME_DISC,
 						 "6014 Rebind lport to current "
-						 "remoteport %p wwpn 0x%llx, "
-						 "Data: x%x x%x %p %p x%x x%06x\n",
+						 "remoteport x%px wwpn 0x%llx, "
+						 "Data: x%x x%x x%px x%px x%x "
+						 " x%06x\n",
 						 remote_port,
 						 remote_port->port_name,
 						 remote_port->port_id,
@@ -2406,7 +2408,7 @@ lpfc_nvme_register_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				 "6022 Bind lport x%px to remoteport x%px "
 				 "rport x%px WWNN 0x%llx, "
 				 "Rport WWPN 0x%llx DID "
-				 "x%06x Role x%x, ndlp %p prev_ndlp %p\n",
+				 "x%06x Role x%x, ndlp %p prev_ndlp x%px\n",
 				 lport, remote_port, rport,
 				 rpinfo.node_name, rpinfo.port_name,
 				 rpinfo.port_id, rpinfo.port_role,
@@ -2515,7 +2517,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		goto input_err;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
-			 "6033 Unreg nvme remoteport %p, portname x%llx, "
+			 "6033 Unreg nvme remoteport x%px, portname x%llx, "
 			 "port_id x%06x, portstate x%x port type x%x\n",
 			 remoteport, remoteport->port_name,
 			 remoteport->port_id, remoteport->port_state,
@@ -2553,7 +2555,7 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
  input_err:
 #endif
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_NVME_DISC,
-			 "6168 State error: lport %p, rport%p FCID x%06x\n",
+			 "6168 State error: lport x%px, rport x%px FCID x%06x\n",
 			 vport->localport, ndlp->rport, ndlp->nlp_DID);
 }
 
@@ -2597,7 +2599,7 @@ lpfc_sli4_nvme_xri_aborted(struct lpfc_hba *phba,
 				lpfc_sli4_abts_err_handler(phba, ndlp, axri);
 
 			lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-					"6311 nvme_cmd %p xri x%x tag x%x "
+					"6311 nvme_cmd x%px xri x%x tag x%x "
 					"abort complete and xri released\n",
 					lpfc_ncmd->nvmeCmd, xri,
 					lpfc_ncmd->cur_iocbq.iotag);
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index f42cc3150c6f..253a9fdd245e 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1437,7 +1437,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 			infop = lpfc_get_ctx_list(phba, i, j);
 			lpfc_printf_log(phba, KERN_INFO, LOG_NVME | LOG_INIT,
 					"6408 TOTAL NVMET ctx for CPU %d "
-					"MRQ %d: cnt %d nextcpu %p\n",
+					"MRQ %d: cnt %d nextcpu x%px\n",
 					i, j, infop->nvmet_ctx_list_cnt,
 					infop->nvmet_ctx_next_cpu);
 		}
@@ -1500,7 +1500,7 @@ lpfc_nvmet_create_targetport(struct lpfc_hba *phba)
 
 		lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
 				"6026 Registered NVME "
-				"targetport: %p, private %p "
+				"targetport: x%px, private x%px "
 				"portnm %llx nodenm %llx segs %d qs %d\n",
 				phba->targetport, tgtp,
 				pinfo.port_name, pinfo.node_name,
@@ -1555,7 +1555,7 @@ lpfc_nvmet_update_targetport(struct lpfc_hba *phba)
 		return 0;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-			 "6007 Update NVMET port %p did x%x\n",
+			 "6007 Update NVMET port x%px did x%x\n",
 			 phba->targetport, vport->fc_myDID);
 
 	phba->targetport->port_id = vport->fc_myDID;
@@ -1926,7 +1926,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 		if (!wait_for_completion_timeout(tgtp->tport_unreg_cmp,
 					msecs_to_jiffies(LPFC_NVMET_WAIT_TMO)))
 			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
-					"6179 Unreg targetport %p timeout "
+					"6179 Unreg targetport x%px timeout "
 					"reached.\n", phba->targetport);
 		lpfc_nvmet_cleanup_io_context(phba);
 	}
@@ -3109,7 +3109,7 @@ lpfc_nvmet_xmt_ls_abort_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	atomic_inc(&tgtp->xmt_ls_abort_cmpl);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_ABTS,
-			"6083 Abort cmpl: ctx %p WCQE:%08x %08x %08x %08x\n",
+			"6083 Abort cmpl: ctx x%px WCQE:%08x %08x %08x %08x\n",
 			ctxp, wcqe->word0, wcqe->total_data_placed,
 			result, wcqe->word3);
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 8ae24500806e..95ba5000d0ec 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -1775,7 +1775,7 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	if (!sgpe || !sgde) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
-				"9020 Invalid s/g entry: data=0x%p prot=0x%p\n",
+				"9020 Invalid s/g entry: data=x%px prot=x%px\n",
 				sgpe, sgde);
 		return 0;
 	}
@@ -2154,7 +2154,7 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	if (!sgpe || !sgde) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
-				"9082 Invalid s/g entry: data=0x%p prot=0x%p\n",
+				"9082 Invalid s/g entry: data=x%px prot=x%px\n",
 				sgpe, sgde);
 		return 0;
 	}
@@ -3873,7 +3873,7 @@ lpfc_scsi_cmd_iocb_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pIocbIn,
 		uint32_t *lp = (uint32_t *)cmd->sense_buffer;
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
-				 "0710 Iodone <%d/%llu> cmd %p, error "
+				 "0710 Iodone <%d/%llu> cmd x%px, error "
 				 "x%x SNS x%x x%x Data: x%x x%x\n",
 				 cmd->device->id, cmd->device->lun, cmd,
 				 cmd->result, *lp, *(lp + 3), cmd->retries,
@@ -4997,7 +4997,7 @@ lpfc_chk_tgt_mapped(struct lpfc_vport *vport, struct scsi_cmnd *cmnd)
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 	if (!rdata) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
-			"0797 Tgt Map rport failure: rdata x%p\n", rdata);
+			"0797 Tgt Map rport failure: rdata x%px\n", rdata);
 		return FAILED;
 	}
 	pnode = rdata->pnode;
@@ -5095,7 +5095,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 	if (!rdata || !rdata->pnode) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
-				 "0798 Device Reset rdata failure: rdata x%p\n",
+				 "0798 Device Reset rdata failure: rdata x%px\n",
 				 rdata);
 		return FAILED;
 	}
@@ -5107,7 +5107,7 @@ lpfc_device_reset_handler(struct scsi_cmnd *cmnd)
 	status = lpfc_chk_tgt_mapped(vport, cmnd);
 	if (status == FAILED) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
-			"0721 Device Reset rport failure: rdata x%p\n", rdata);
+			"0721 Device Reset rport failure: rdata x%px\n", rdata);
 		return FAILED;
 	}
 
@@ -5166,7 +5166,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 	rdata = lpfc_rport_data_from_scsi_device(cmnd->device);
 	if (!rdata || !rdata->pnode) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
-				 "0799 Target Reset rdata failure: rdata x%p\n",
+				 "0799 Target Reset rdata failure: rdata x%px\n",
 				 rdata);
 		return FAILED;
 	}
@@ -5178,7 +5178,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 	status = lpfc_chk_tgt_mapped(vport, cmnd);
 	if (status == FAILED) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_FCP,
-			"0722 Target Reset rport failure: rdata x%p\n", rdata);
+			"0722 Target Reset rport failure: rdata x%px\n", rdata);
 		if (pnode) {
 			spin_lock_irq(shost->host_lock);
 			pnode->nlp_flag &= ~NLP_NPR_ADISC;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 0142545873a5..efa602592728 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2514,7 +2514,7 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				vport,
 				KERN_INFO, LOG_MBOX | LOG_DISCOVERY,
 				"1438 UNREG cmpl deferred mbox x%x "
-				"on NPort x%x Data: x%x x%x %p\n",
+				"on NPort x%x Data: x%x x%x %px\n",
 				ndlp->nlp_rpi, ndlp->nlp_DID,
 				ndlp->nlp_flag, ndlp->nlp_defer_did, ndlp);
 
@@ -2572,7 +2572,7 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 					vport, KERN_INFO, LOG_MBOX | LOG_SLI,
 					 "0010 UNREG_LOGIN vpi:%x "
 					 "rpi:%x DID:%x defer x%x flg x%x "
-					 "map:%x %p\n",
+					 "map:%x %px\n",
 					 vport->vpi, ndlp->nlp_rpi,
 					 ndlp->nlp_DID, ndlp->nlp_defer_did,
 					 ndlp->nlp_flag,
@@ -2590,7 +2590,7 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 						vport, KERN_INFO, LOG_DISCOVERY,
 						"4111 UNREG cmpl deferred "
 						"clr x%x on "
-						"NPort x%x Data: x%x %p\n",
+						"NPort x%x Data: x%x x%px\n",
 						ndlp->nlp_rpi, ndlp->nlp_DID,
 						ndlp->nlp_defer_did, ndlp);
 					ndlp->nlp_flag &= ~NLP_UNREG_INP;
@@ -2712,7 +2712,7 @@ lpfc_sli_handle_mb_event(struct lpfc_hba *phba)
 
 		/* Mailbox cmd <cmd> Cmpl <cmpl> */
 		lpfc_printf_log(phba, KERN_INFO, LOG_MBOX | LOG_SLI,
-				"(%d):0307 Mailbox cmd x%x (x%x/x%x) Cmpl x%p "
+				"(%d):0307 Mailbox cmd x%x (x%x/x%x) Cmpl %pf "
 				"Data: x%x x%x x%x x%x x%x x%x x%x x%x x%x "
 				"x%x x%x x%x\n",
 				pmb->vport ? pmb->vport->vpi : 0,
@@ -7991,7 +7991,7 @@ lpfc_mbox_timeout_handler(struct lpfc_hba *phba)
 
 	/* Mbox cmd <mbxCommand> timeout */
 	lpfc_printf_log(phba, KERN_ERR, LOG_MBOX | LOG_SLI,
-			"0310 Mailbox command x%x timeout Data: x%x x%x x%p\n",
+			"0310 Mailbox command x%x timeout Data: x%x x%x x%px\n",
 			mb->mbxCommand,
 			phba->pport->port_state,
 			phba->sli.sli_flag,
@@ -10998,7 +10998,7 @@ lpfc_sli_ring_taggedbuf_get(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	spin_unlock_irq(&phba->hbalock);
 	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 			"0402 Cannot find virtual addr for buffer tag on "
-			"ring %d Data x%lx x%p x%p x%x\n",
+			"ring %d Data x%lx x%px x%px x%x\n",
 			pring->ringno, (unsigned long) tag,
 			slp->next, slp->prev, pring->postbufq_cnt);
 
@@ -11042,7 +11042,7 @@ lpfc_sli_ringpostbuf_get(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	spin_unlock_irq(&phba->hbalock);
 	lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
 			"0410 Cannot find virtual addr for mapped buf on "
-			"ring %d Data x%llx x%p x%p x%x\n",
+			"ring %d Data x%llx x%px x%px x%x\n",
 			pring->ringno, (unsigned long long)phys,
 			slp->next, slp->prev, pring->postbufq_cnt);
 	return NULL;
@@ -11097,7 +11097,7 @@ lpfc_sli_abort_els_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			abort_iocb = phba->sli.iocbq_lookup[abort_context];
 
 		lpfc_printf_log(phba, KERN_WARNING, LOG_ELS | LOG_SLI,
-				"0327 Cannot abort els iocb %p "
+				"0327 Cannot abort els iocb x%px "
 				"with tag %x context %x, abort status %x, "
 				"abort code %x\n",
 				abort_iocb, abort_iotag, abort_context,
-- 
2.13.7

