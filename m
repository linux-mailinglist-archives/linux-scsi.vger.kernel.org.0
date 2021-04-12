Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FC535B825
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Apr 2021 03:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhDLBca (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Apr 2021 21:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhDLBcZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 11 Apr 2021 21:32:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB7C06138C
        for <linux-scsi@vger.kernel.org>; Sun, 11 Apr 2021 18:32:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h25so8156116pgm.3
        for <linux-scsi@vger.kernel.org>; Sun, 11 Apr 2021 18:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgXoIif8THFBBABH36AMYQPwblp00ourbqCPZSeuX2A=;
        b=H/+54ssVw2chIVXJPYbQuCeOcmxv9T6YEn09YeYXuKckgvsm50lBA5ejConHiny8r5
         3s7RI3W1o3aBAYfgqfpOLgHZHbB0ESiHOXMnm29zOUWu/WH7443G0eUWghWYV+S89MEh
         oAtX493xZNOWaoMattCTeuIwPB0udGFc6TjfUw2RyXhZZNf7myAxnew7u8upRg5um5YW
         ZebmX+2bcKqd5yZ/ZEr9SqfiqwpRKBJjVsfPmUWlGMA4CEmUySFfd9mmGGhNjKGJIFw/
         F2HIjH1LpqrLMK/Z9yXfJsdeBypZLomCFssOGzv3v0SrxsDJaDeWeq3yTVjZPJbOnAlO
         wIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgXoIif8THFBBABH36AMYQPwblp00ourbqCPZSeuX2A=;
        b=lAiZqpaeb+HGzl6mMPlMDhlyjV/ROgCJPgbC0ifXy2MjPgEIWtzNYco5DGbC4wf0ik
         J6zDnYHK4JhCBULsNL0E6T9EffidWobUd/hz7nBC7d0JFKRQK4N640MAt8XZ3yixz5Cv
         ys+uRTvfpQKSzLZdOBSK96WO7tUNeF/XmJNMylXt+ImkXq0uX21AFnVd1UMznmkVTiu+
         DnHDkYVOwbDpnqXgXngCHstW3jDNL6aulo+HpSw2Ud+Ov8qbmvpWp7j0qgizJ458uyS+
         PcAiaROPLmmY01X363tNJPoMN/WcKNAirtCZqiWA6PSzpVLahpSIiG/LDoGkmgu1PDZZ
         hLYw==
X-Gm-Message-State: AOAM532z/5nlOuLMpv8IzqMjfSBLB2dm91SoqN4423ouxrtN7zEXVV0F
        3JXC49qbzGqMb5lkeL4a8rVntts0+Xc=
X-Google-Smtp-Source: ABdhPJxZp383HjELw1d1OWM5kzWVOKamvMqoEfniMhuv7YdKTpC5WYYftAPS30PQbqu4hwl5UCjH1g==
X-Received: by 2002:a62:b412:0:b029:21f:6b06:7bdd with SMTP id h18-20020a62b4120000b029021f6b067bddmr22570795pfn.51.1618191127307;
        Sun, 11 Apr 2021 18:32:07 -0700 (PDT)
Received: from localhost.localdomain (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id i17sm8153163pfd.84.2021.04.11.18.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 18:32:07 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH v2 12/16] lpfc: Fix various trivial errors in comments and log messages
Date:   Sun, 11 Apr 2021 18:31:23 -0700
Message-Id: <20210412013127.2387-13-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412013127.2387-1-jsmart2021@gmail.com>
References: <20210412013127.2387-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Clean up minor issues spotted by tools and code review:
 - Spelling Errors
 - Spurious characters and errors in function headers
 - nvme_info wqerr and err fields source data reversed
 - extraneous new line in log message 0466
 - spacing error in log message 0109
 - messages 0140 and 0141 have portname and nodename reversed
 - Incorrect function labelling in comment

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_attr.c      | 11 +++++------
 drivers/scsi/lpfc/lpfc_bsg.c       | 16 ++++++++--------
 drivers/scsi/lpfc/lpfc_els.c       |  4 ++--
 drivers/scsi/lpfc/lpfc_nportdisc.c |  4 ++--
 drivers/scsi/lpfc/lpfc_sli.c       |  8 ++++----
 5 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b703fe3b606e..de5a21998b96 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -487,8 +487,8 @@ lpfc_nvme_info_show(struct device *dev, struct device_attribute *attr,
 		  atomic_read(&lport->xmt_fcp_noxri),
 		  atomic_read(&lport->xmt_fcp_bad_ndlp),
 		  atomic_read(&lport->xmt_fcp_qdepth),
-		  atomic_read(&lport->xmt_fcp_err),
-		  atomic_read(&lport->xmt_fcp_wqerr));
+		  atomic_read(&lport->xmt_fcp_wqerr),
+		  atomic_read(&lport->xmt_fcp_err));
 	if (strlcat(buf, tmp, PAGE_SIZE) >= PAGE_SIZE)
 		goto buffer_done;
 
@@ -1176,8 +1176,7 @@ lpfc_emptyq_wait(struct lpfc_hba *phba, struct list_head *q, spinlock_t *lock)
 		msleep(20);
 		if (cnt++ > 250) {  /* 5 secs */
 			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
-					"0466 %s %s\n",
-					"Outstanding IO when ",
+					"0466 Outstanding IO when "
 					"bringing Adapter offline\n");
 				return 0;
 		}
@@ -5929,7 +5928,7 @@ LPFC_ATTR_RW(XLanePriority, 0, 0x0, 0x7f, "CS_CTL for Express Lane Feature.");
 LPFC_ATTR_R(enable_bg, 0, 0, 1, "Enable BlockGuard Support");
 
 /*
-# lpfc_prot_mask: i
+# lpfc_prot_mask:
 #	- Bit mask of host protection capabilities used to register with the
 #	  SCSI mid-layer
 # 	- Only meaningful if BG is turned on (lpfc_enable_bg=1).
@@ -5954,7 +5953,7 @@ LPFC_ATTR(prot_mask,
 	"T10-DIF host protection capabilities mask");
 
 /*
-# lpfc_prot_guard: i
+# lpfc_prot_guard:
 #	- Bit mask of protection guard types to register with the SCSI mid-layer
 #	- Guard types are currently either 1) T10-DIF CRC 2) IP checksum
 #	- Allows you to ultimately specify which profiles to use
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 48a6b0cc58ef..32e562f27e8f 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -3878,7 +3878,7 @@ lpfc_bsg_sli_cfg_dma_desc_setup(struct lpfc_hba *phba, enum nemb_type nemb_tp,
  * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine performs SLI_CONFIG (0x9B) read mailbox command operation with
- * non-embedded external bufffers.
+ * non-embedded external buffers.
  **/
 static int
 lpfc_bsg_sli_cfg_read_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
@@ -4067,7 +4067,7 @@ lpfc_bsg_sli_cfg_read_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
  * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine performs SLI_CONFIG (0x9B) write mailbox command operation with
- * non-embedded external bufffers.
+ * non-embedded external buffers.
  **/
 static int
 lpfc_bsg_sli_cfg_write_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
@@ -4211,7 +4211,7 @@ lpfc_bsg_sli_cfg_write_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
 		goto job_error;
 	}
 
-	/* wait for additoinal external buffers */
+	/* wait for additional external buffers */
 
 	bsg_reply->result = 0;
 	bsg_job_done(job, bsg_reply->result,
@@ -4233,8 +4233,8 @@ lpfc_bsg_sli_cfg_write_cmd_ext(struct lpfc_hba *phba, struct bsg_job *job,
  * @dmabuf: Pointer to a DMA buffer descriptor.
  *
  * This routine handles SLI_CONFIG (0x9B) mailbox command with non-embedded
- * external bufffers, including both 0x9B with non-embedded MSEs and 0x9B
- * with embedded sussystem 0x1 and opcodes with external HBDs.
+ * external buffers, including both 0x9B with non-embedded MSEs and 0x9B
+ * with embedded subsystem 0x1 and opcodes with external HBDs.
  **/
 static int
 lpfc_bsg_handle_sli_cfg_mbox(struct lpfc_hba *phba, struct bsg_job *job,
@@ -4559,7 +4559,7 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, struct bsg_job *job,
 		goto job_error;
 	}
 
-	/* wait for additoinal external buffers */
+	/* wait for additional external buffers */
 	bsg_reply->result = 0;
 	bsg_job_done(job, bsg_reply->result,
 		       bsg_reply->reply_payload_rcv_len);
@@ -4625,7 +4625,7 @@ lpfc_bsg_handle_sli_cfg_ebuf(struct lpfc_hba *phba, struct bsg_job *job,
  * @job: Pointer to the job object.
  * @dmabuf: Pointer to a DMA buffer descriptor.
  *
- * This routine checkes and handles non-embedded multi-buffer SLI_CONFIG
+ * This routine checks and handles non-embedded multi-buffer SLI_CONFIG
  * (0x9B) mailbox commands and external buffers.
  **/
 static int
@@ -4703,7 +4703,7 @@ lpfc_bsg_handle_sli_cfg_ext(struct lpfc_hba *phba, struct bsg_job *job,
  * from the mailbox pool, copy the caller mailbox command.
  *
  * If offline and the sli is active we need to poll for the command (port is
- * being reset) and com-plete the job, otherwise issue the mailbox command and
+ * being reset) and complete the job, otherwise issue the mailbox command and
  * let our completion handler finish the command.
  **/
 static int
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index c919bedd931c..21108f322c99 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4378,7 +4378,7 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		irsp->ulpStatus, irsp->un.ulpWord[4], ndlp->nlp_DID);
 	/* ACC to LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0109 ACC to LOGO completes to NPort x%x refcnt %d"
+			 "0109 ACC to LOGO completes to NPort x%x refcnt %d "
 			 "Data: x%x x%x x%x\n",
 			 ndlp->nlp_DID, kref_read(&ndlp->kref), ndlp->nlp_flag,
 			 ndlp->nlp_state, ndlp->nlp_rpi);
@@ -4783,7 +4783,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 }
 
 /**
- * lpfc_els_rsp_reject - Propare and issue a rjt response iocb command
+ * lpfc_els_rsp_reject - Prepare and issue a rjt response iocb command
  * @vport: pointer to a virtual N_Port data structure.
  * @rejectError: reject response to issue
  * @oldiocb: pointer to the original lpfc command iocb data structure.
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index fd3d0197d155..bb4e65a32ecc 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -340,7 +340,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	sp = (struct serv_parm *) ((uint8_t *) lp + sizeof (uint32_t));
 	if (wwn_to_u64(sp->portName.u.wwn) == 0) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-				 "0140 PLOGI Reject: invalid nname\n");
+				 "0140 PLOGI Reject: invalid pname\n");
 		stat.un.b.lsRjtRsnCode = LSRJT_UNABLE_TPC;
 		stat.un.b.lsRjtRsnCodeExp = LSEXP_INVALID_PNAME;
 		lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb, ndlp,
@@ -349,7 +349,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 	if (wwn_to_u64(sp->nodeName.u.wwn) == 0) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-				 "0141 PLOGI Reject: invalid pname\n");
+				 "0141 PLOGI Reject: invalid nname\n");
 		stat.un.b.lsRjtRsnCode = LSRJT_UNABLE_TPC;
 		stat.un.b.lsRjtRsnCodeExp = LSEXP_INVALID_NNAME;
 		lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb, ndlp,
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3b48e3e88e67..11145a78dbe9 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -935,7 +935,7 @@ __lpfc_sli_get_iocbq(struct lpfc_hba *phba)
  * @phba: Pointer to HBA context object.
  * @xritag: XRI value.
  *
- * This function clears the sglq pointer from the array of acive
+ * This function clears the sglq pointer from the array of active
  * sglq's. The xritag that is passed in is used to index into the
  * array. Before the xritag can be used it needs to be adjusted
  * by subtracting the xribase.
@@ -957,7 +957,7 @@ __lpfc_clear_active_sglq(struct lpfc_hba *phba, uint16_t xritag)
  * @phba: Pointer to HBA context object.
  * @xritag: XRI value.
  *
- * This function returns the sglq pointer from the array of acive
+ * This function returns the sglq pointer from the array of active
  * sglq's. The xritag that is passed in is used to index into the
  * array. Before the xritag can be used it needs to be adjusted
  * by subtracting the xribase.
@@ -14851,7 +14851,7 @@ lpfc_sli4_hba_intr_handler(int irq, void *dev_id)
 	}
 
 	return IRQ_HANDLED;
-} /* lpfc_sli4_fp_intr_handler */
+} /* lpfc_sli4_hba_intr_handler */
 
 /**
  * lpfc_sli4_intr_handler - Device-level interrupt handler for SLI-4 device
@@ -18106,7 +18106,7 @@ lpfc_sli4_xri_inrange(struct lpfc_hba *phba,
 
 /**
  * lpfc_sli4_seq_abort_rsp - bls rsp to sequence abort
- * @vport: pointer to a vitural port.
+ * @vport: pointer to a virtual port.
  * @fc_hdr: pointer to a FC frame header.
  * @aborted: was the partially assembled receive sequence successfully aborted
  *
-- 
2.26.2

