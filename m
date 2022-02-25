Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F97A4C3BA3
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Feb 2022 03:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiBYCYL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 21:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiBYCYC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 21:24:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D21EC249
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b8so3575369pjb.4
        for <linux-scsi@vger.kernel.org>; Thu, 24 Feb 2022 18:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oN/WNZ0FXQsqXRyiAcLEl4Xc8JKA4M9vHAszRn1+HqM=;
        b=l82G3A0hlB2aZDI94opblXLTxZ5NedJjbWJNeacfQ8ntKTKRDejCAfZ4JDPzQsRM/Y
         wV2CoYwFqoGPwmBoYOCK54AIn144whUNFIy98mNfv8i5G9TMoDRLQk4CnRLzFgbRCqYZ
         pLxjTeJFpkaeGsMXrqWd3ycWBaaST3G034xy6y+rDkVI/Bba86vHqCM3vmUSX1z28uu/
         D3UiY8Xq82GrLLmcJHbz8mc6P1drz/ukUWPL0UdAlJilV+iqyQmNqNvM87fmkWRXkPqZ
         E0RsS4D/FPTFGEHrNBntADajpBQFl8mRFmKDpyLlRmECCyeeBpJ3R+v2Zyk7dMLlL9JB
         8Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oN/WNZ0FXQsqXRyiAcLEl4Xc8JKA4M9vHAszRn1+HqM=;
        b=NqWcGy+/heHJJafHKiBTxiIcQzPbr5SXb6X9es/tfDZzNyRRr6Jajzi4vLck1jCx2z
         e3hmdWAwVm7z7dw0xlcq4fh7Z3EgH8Jkspj1p8v6ur7NU1oSiA+YJ3pV41bP9b48pHEL
         xDQwqXHqVHXnK4Mi7sfm93JcWRri/HTs+Ex1GZtYiluN0Kc+YppM89FSqnm0seyesdzF
         eqljRjzaXXu26pVPh49zd/hhlvUFFbUrrIKeH3FHTcb4OxiLsdbbRr57g4/TexGtXWfL
         Dl0moey90/SALcDM93RgQCLfysv7cFFJOoMpEso1T4Mlc+UCAHVQxv+MVo2xew2ii7Gw
         QYeQ==
X-Gm-Message-State: AOAM531eG1Dh/fAvPDssQboPAzaZasb9hEQsMQcmtdJlAiS+vXxQA6ZU
        YbU9EoVwse2v9swOrlpTc1aRuw+fzR8=
X-Google-Smtp-Source: ABdhPJyUpgFT2b9LQcXzlraAMGPVlmNLYKhXsVIIlH1cdMCS/YF8l/Tb/8a7XhO+LUBey2FARuwoww==
X-Received: by 2002:a17:90a:6383:b0:1b9:64d7:3af9 with SMTP id f3-20020a17090a638300b001b964d73af9mr992544pjj.156.1645755808612;
        Thu, 24 Feb 2022 18:23:28 -0800 (PST)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f3b355dcb1sm845596pfh.58.2022.02.24.18.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:23:28 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 13/17] lpfc: SLI path split: refactor SCSI paths
Date:   Thu, 24 Feb 2022 18:23:04 -0800
Message-Id: <20220225022308.16486-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220225022308.16486-1-jsmart2021@gmail.com>
References: <20220225022308.16486-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch refactors the SCSI paths to use SLI-4 as the primary
interface.

Changes include:
- conversion away from using sli-3 iocb structures to set/access fields
  in common routines. Use the new generic get/set routines that were added.
  This move changes code from indirect structure references to using
  local variables with the generic routines.
- refactor routines when setting non-generic fields, to have both
  both sli3 and sli4 specific sections. This replaces the set-as-sli3
  then translate to sli4 behavior of the past.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |   4 +
 drivers/scsi/lpfc/lpfc_scsi.c | 374 +++++++++++++++-------------------
 drivers/scsi/lpfc/lpfc_sli.c  |   6 +-
 3 files changed, 174 insertions(+), 210 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 28b1d5b7df08..66e492ec0c2c 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -917,6 +917,10 @@ struct lpfc_hba {
 		(struct lpfc_vport *vport,
 		 struct lpfc_io_buf *lpfc_cmd,
 		 uint8_t tmo);
+	int (*lpfc_scsi_prep_task_mgmt_cmd)
+		(struct lpfc_vport *vport,
+		 struct lpfc_io_buf *lpfc_cmd,
+		 u64 lun, u8 task_mgmt_cmd);
 
 	/* IOCB interface function jump table entries */
 	int (*__lpfc_sli_issue_iocb)
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index fcb4302ad8c1..52de61f2ac92 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -2942,154 +2942,58 @@ lpfc_calc_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
  * -1 - Internal error (bad profile, ...etc)
  */
 static int
-lpfc_sli4_parse_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd,
-		       struct lpfc_wcqe_complete *wcqe)
+lpfc_parse_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd,
+		  struct lpfc_iocbq *pIocbOut)
 {
 	struct scsi_cmnd *cmd = lpfc_cmd->pCmd;
+	struct sli3_bg_fields *bgf;
 	int ret = 0;
-	u32 status = bf_get(lpfc_wcqe_c_status, wcqe);
+	struct lpfc_wcqe_complete *wcqe;
+	u32 status;
 	u32 bghm = 0;
 	u32 bgstat = 0;
 	u64 failing_sector = 0;
 
-	if (status == CQE_STATUS_DI_ERROR) {
-		if (bf_get(lpfc_wcqe_c_bg_ge, wcqe)) /* Guard Check failed */
-			bgstat |= BGS_GUARD_ERR_MASK;
-		if (bf_get(lpfc_wcqe_c_bg_ae, wcqe)) /* AppTag Check failed */
-			bgstat |= BGS_APPTAG_ERR_MASK;
-		if (bf_get(lpfc_wcqe_c_bg_re, wcqe)) /* RefTag Check failed */
-			bgstat |= BGS_REFTAG_ERR_MASK;
-
-		/* Check to see if there was any good data before the error */
-		if (bf_get(lpfc_wcqe_c_bg_tdpv, wcqe)) {
-			bgstat |= BGS_HI_WATER_MARK_PRESENT_MASK;
-			bghm = wcqe->total_data_placed;
-		}
-
-		/*
-		 * Set ALL the error bits to indicate we don't know what
-		 * type of error it is.
-		 */
-		if (!bgstat)
-			bgstat |= (BGS_REFTAG_ERR_MASK | BGS_APPTAG_ERR_MASK |
-				BGS_GUARD_ERR_MASK);
-	}
-
-	if (lpfc_bgs_get_guard_err(bgstat)) {
-		ret = 1;
-
-		scsi_build_sense(cmd, 1, ILLEGAL_REQUEST, 0x10, 0x1);
-		set_host_byte(cmd, DID_ABORT);
-		phba->bg_guard_err_cnt++;
-		lpfc_printf_log(phba, KERN_WARNING, LOG_FCP | LOG_BG,
-				"9059 BLKGRD: Guard Tag error in cmd"
-				" 0x%x lba 0x%llx blk cnt 0x%x "
-				"bgstat=x%x bghm=x%x\n", cmd->cmnd[0],
-				(unsigned long long)scsi_get_lba(cmd),
-				scsi_logical_block_count(cmd), bgstat, bghm);
-	}
-
-	if (lpfc_bgs_get_reftag_err(bgstat)) {
-		ret = 1;
-
-		scsi_build_sense(cmd, 1, ILLEGAL_REQUEST, 0x10, 0x3);
-		set_host_byte(cmd, DID_ABORT);
-
-		phba->bg_reftag_err_cnt++;
-		lpfc_printf_log(phba, KERN_WARNING, LOG_FCP | LOG_BG,
-				"9060 BLKGRD: Ref Tag error in cmd"
-				" 0x%x lba 0x%llx blk cnt 0x%x "
-				"bgstat=x%x bghm=x%x\n", cmd->cmnd[0],
-				(unsigned long long)scsi_get_lba(cmd),
-				scsi_logical_block_count(cmd), bgstat, bghm);
-	}
+	if (phba->sli_rev == LPFC_SLI_REV4) {
+		wcqe = &pIocbOut->wcqe_cmpl;
+		status = bf_get(lpfc_wcqe_c_status, wcqe);
 
-	if (lpfc_bgs_get_apptag_err(bgstat)) {
-		ret = 1;
+		if (status == CQE_STATUS_DI_ERROR) {
+			/* Guard Check failed */
+			if (bf_get(lpfc_wcqe_c_bg_ge, wcqe))
+				bgstat |= BGS_GUARD_ERR_MASK;
 
-		scsi_build_sense(cmd, 1, ILLEGAL_REQUEST, 0x10, 0x2);
-		set_host_byte(cmd, DID_ABORT);
+			/* AppTag Check failed */
+			if (bf_get(lpfc_wcqe_c_bg_ae, wcqe))
+				bgstat |= BGS_APPTAG_ERR_MASK;
 
-		phba->bg_apptag_err_cnt++;
-		lpfc_printf_log(phba, KERN_WARNING, LOG_FCP | LOG_BG,
-				"9062 BLKGRD: App Tag error in cmd"
-				" 0x%x lba 0x%llx blk cnt 0x%x "
-				"bgstat=x%x bghm=x%x\n", cmd->cmnd[0],
-				(unsigned long long)scsi_get_lba(cmd),
-				scsi_logical_block_count(cmd), bgstat, bghm);
-	}
+			/* RefTag Check failed */
+			if (bf_get(lpfc_wcqe_c_bg_re, wcqe))
+				bgstat |= BGS_REFTAG_ERR_MASK;
 
-	if (lpfc_bgs_get_hi_water_mark_present(bgstat)) {
-		/*
-		 * setup sense data descriptor 0 per SPC-4 as an information
-		 * field, and put the failing LBA in it.
-		 * This code assumes there was also a guard/app/ref tag error
-		 * indication.
-		 */
-		cmd->sense_buffer[7] = 0xc;   /* Additional sense length */
-		cmd->sense_buffer[8] = 0;     /* Information descriptor type */
-		cmd->sense_buffer[9] = 0xa;   /* Additional descriptor length */
-		cmd->sense_buffer[10] = 0x80; /* Validity bit */
+			/* Check to see if there was any good data before the
+			 * error
+			 */
+			if (bf_get(lpfc_wcqe_c_bg_tdpv, wcqe)) {
+				bgstat |= BGS_HI_WATER_MARK_PRESENT_MASK;
+				bghm = wcqe->total_data_placed;
+			}
 
-		/* bghm is a "on the wire" FC frame based count */
-		switch (scsi_get_prot_op(cmd)) {
-		case SCSI_PROT_READ_INSERT:
-		case SCSI_PROT_WRITE_STRIP:
-			bghm /= cmd->device->sector_size;
-			break;
-		case SCSI_PROT_READ_STRIP:
-		case SCSI_PROT_WRITE_INSERT:
-		case SCSI_PROT_READ_PASS:
-		case SCSI_PROT_WRITE_PASS:
-			bghm /= (cmd->device->sector_size +
-				sizeof(struct scsi_dif_tuple));
-			break;
+			/*
+			 * Set ALL the error bits to indicate we don't know what
+			 * type of error it is.
+			 */
+			if (!bgstat)
+				bgstat |= (BGS_REFTAG_ERR_MASK |
+					   BGS_APPTAG_ERR_MASK |
+					   BGS_GUARD_ERR_MASK);
 		}
 
-		failing_sector = scsi_get_lba(cmd);
-		failing_sector += bghm;
-
-		/* Descriptor Information */
-		put_unaligned_be64(failing_sector, &cmd->sense_buffer[12]);
-	}
-
-	if (!ret) {
-		/* No error was reported - problem in FW? */
-		lpfc_printf_log(phba, KERN_WARNING, LOG_FCP | LOG_BG,
-				"9068 BLKGRD: Unknown error in cmd"
-				" 0x%x lba 0x%llx blk cnt 0x%x "
-				"bgstat=x%x bghm=x%x\n", cmd->cmnd[0],
-				(unsigned long long)scsi_get_lba(cmd),
-				scsi_logical_block_count(cmd), bgstat, bghm);
-
-		/* Calculate what type of error it was */
-		lpfc_calc_bg_err(phba, lpfc_cmd);
+	} else {
+		bgf = &pIocbOut->iocb.unsli3.sli3_bg;
+		bghm = bgf->bghm;
+		bgstat = bgf->bgstat;
 	}
-	return ret;
-}
-
-/*
- * This function checks for BlockGuard errors detected by
- * the HBA.  In case of errors, the ASC/ASCQ fields in the
- * sense buffer will be set accordingly, paired with
- * ILLEGAL_REQUEST to signal to the kernel that the HBA
- * detected corruption.
- *
- * Returns:
- *  0 - No error found
- *  1 - BlockGuard error found
- * -1 - Internal error (bad profile, ...etc)
- */
-static int
-lpfc_parse_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd,
-		  struct lpfc_iocbq *pIocbOut)
-{
-	struct scsi_cmnd *cmd = lpfc_cmd->pCmd;
-	struct sli3_bg_fields *bgf = &pIocbOut->iocb.unsli3.sli3_bg;
-	int ret = 0;
-	uint32_t bghm = bgf->bghm;
-	uint32_t bgstat = bgf->bgstat;
-	uint64_t failing_sector = 0;
 
 	if (lpfc_bgs_get_invalid_prof(bgstat)) {
 		cmd->result = DID_ERROR << 16;
@@ -3117,7 +3021,6 @@ lpfc_parse_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd,
 
 	if (lpfc_bgs_get_guard_err(bgstat)) {
 		ret = 1;
-
 		scsi_build_sense(cmd, 1, ILLEGAL_REQUEST, 0x10, 0x1);
 		set_host_byte(cmd, DID_ABORT);
 		phba->bg_guard_err_cnt++;
@@ -3131,10 +3034,8 @@ lpfc_parse_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd,
 
 	if (lpfc_bgs_get_reftag_err(bgstat)) {
 		ret = 1;
-
 		scsi_build_sense(cmd, 1, ILLEGAL_REQUEST, 0x10, 0x3);
 		set_host_byte(cmd, DID_ABORT);
-
 		phba->bg_reftag_err_cnt++;
 		lpfc_printf_log(phba, KERN_WARNING, LOG_FCP | LOG_BG,
 				"9056 BLKGRD: Ref Tag error in cmd "
@@ -3146,10 +3047,8 @@ lpfc_parse_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd,
 
 	if (lpfc_bgs_get_apptag_err(bgstat)) {
 		ret = 1;
-
 		scsi_build_sense(cmd, 1, ILLEGAL_REQUEST, 0x10, 0x2);
 		set_host_byte(cmd, DID_ABORT);
-
 		phba->bg_apptag_err_cnt++;
 		lpfc_printf_log(phba, KERN_WARNING, LOG_FCP | LOG_BG,
 				"9061 BLKGRD: App Tag error in cmd "
@@ -4195,7 +4094,6 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	struct Scsi_Host *shost;
 	u32 logit = LOG_FCP;
 	u32 status, idx;
-	unsigned long iflags = 0;
 	u32 lat;
 	u8 wait_xb_clr = 0;
 
@@ -4210,30 +4108,16 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 	rdata = lpfc_cmd->rdata;
 	ndlp = rdata->pnode;
 
-	if (bf_get(lpfc_wcqe_c_xb, wcqe)) {
-		/* TOREMOVE - currently this flag is checked during
-		 * the release of lpfc_iocbq. Remove once we move
-		 * to lpfc_wqe_job construct.
-		 *
-		 * This needs to be done outside buf_lock
-		 */
-		spin_lock_irqsave(&phba->hbalock, iflags);
-		lpfc_cmd->cur_iocbq.cmd_flag |= LPFC_EXCHANGE_BUSY;
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-	}
-
-	/* Guard against abort handler being called at same time */
-	spin_lock(&lpfc_cmd->buf_lock);
-
 	/* Sanity check on return of outstanding command */
 	cmd = lpfc_cmd->pCmd;
 	if (!cmd) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "9042 I/O completion: Not an active IO\n");
-		spin_unlock(&lpfc_cmd->buf_lock);
 		lpfc_release_scsi_buf(phba, lpfc_cmd);
 		return;
 	}
+	/* Guard against abort handler being called at same time */
+	spin_lock(&lpfc_cmd->buf_lock);
 	idx = lpfc_cmd->cur_iocbq.hba_wqidx;
 	if (phba->sli4_hba.hdwq)
 		phba->sli4_hba.hdwq[idx].scsi_cstat.io_cmpls++;
@@ -4408,12 +4292,14 @@ lpfc_fcp_io_cmd_wqe_cmpl(struct lpfc_hba *phba, struct lpfc_iocbq *pwqeIn,
 				 * This is a response for a BG enabled
 				 * cmd. Parse BG error
 				 */
-				lpfc_sli4_parse_bg_err(phba, lpfc_cmd,
-						       wcqe);
+				lpfc_parse_bg_err(phba, lpfc_cmd, pwqeOut);
 				break;
+			} else {
+				lpfc_printf_vlog(vport, KERN_WARNING,
+						 LOG_BG,
+						 "9040 non-zero BGSTAT "
+						 "on unprotected cmd\n");
 			}
-			lpfc_printf_vlog(vport, KERN_WARNING, LOG_BG,
-				 "9040 non-zero BGSTAT on unprotected cmd\n");
 		}
 		lpfc_printf_vlog(vport, KERN_WARNING, logit,
 				 "9036 Local Reject FCP cmd x%x failed"
@@ -5019,7 +4905,7 @@ lpfc_scsi_prep_cmnd(struct lpfc_vport *vport, struct lpfc_io_buf *lpfc_cmd,
 }
 
 /**
- * lpfc_scsi_prep_task_mgmt_cmd - Convert SLI3 scsi TM cmd to FCP info unit
+ * lpfc_scsi_prep_task_mgmt_cmd_s3 - Convert SLI3 scsi TM cmd to FCP info unit
  * @vport: The virtual port for which this call is being executed.
  * @lpfc_cmd: Pointer to lpfc_io_buf data structure.
  * @lun: Logical unit number.
@@ -5033,10 +4919,9 @@ lpfc_scsi_prep_cmnd(struct lpfc_vport *vport, struct lpfc_io_buf *lpfc_cmd,
  *   1 - Success
  **/
 static int
-lpfc_scsi_prep_task_mgmt_cmd(struct lpfc_vport *vport,
-			     struct lpfc_io_buf *lpfc_cmd,
-			     uint64_t lun,
-			     uint8_t task_mgmt_cmd)
+lpfc_scsi_prep_task_mgmt_cmd_s3(struct lpfc_vport *vport,
+				struct lpfc_io_buf *lpfc_cmd,
+				u64 lun, u8 task_mgmt_cmd)
 {
 	struct lpfc_iocbq *piocbq;
 	IOCB_t *piocb;
@@ -5057,15 +4942,10 @@ lpfc_scsi_prep_task_mgmt_cmd(struct lpfc_vport *vport,
 	memset(fcp_cmnd, 0, sizeof(struct fcp_cmnd));
 	int_to_scsilun(lun, &fcp_cmnd->fcp_lun);
 	fcp_cmnd->fcpCntl2 = task_mgmt_cmd;
-	if (vport->phba->sli_rev == 3 &&
-	    !(vport->phba->sli3_options & LPFC_SLI3_BG_ENABLED))
+	if (!(vport->phba->sli3_options & LPFC_SLI3_BG_ENABLED))
 		lpfc_fcpcmd_to_iocb(piocb->unsli3.fcp_ext.icd, fcp_cmnd);
 	piocb->ulpCommand = CMD_FCP_ICMND64_CR;
 	piocb->ulpContext = ndlp->nlp_rpi;
-	if (vport->phba->sli_rev == LPFC_SLI_REV4) {
-		piocb->ulpContext =
-		  vport->phba->sli4_hba.rpi_ids[ndlp->nlp_rpi];
-	}
 	piocb->ulpFCP2Rcvy = (ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) ? 1 : 0;
 	piocb->ulpClass = (ndlp->nlp_fcp_info & 0x0f);
 	piocb->ulpPU = 0;
@@ -5081,8 +4961,79 @@ lpfc_scsi_prep_task_mgmt_cmd(struct lpfc_vport *vport,
 	} else
 		piocb->ulpTimeout = lpfc_cmd->timeout;
 
-	if (vport->phba->sli_rev == LPFC_SLI_REV4)
-		lpfc_sli4_set_rsp_sgl_last(vport->phba, lpfc_cmd);
+	return 1;
+}
+
+/**
+ * lpfc_scsi_prep_task_mgmt_cmd_s4 - Convert SLI4 scsi TM cmd to FCP info unit
+ * @vport: The virtual port for which this call is being executed.
+ * @lpfc_cmd: Pointer to lpfc_io_buf data structure.
+ * @lun: Logical unit number.
+ * @task_mgmt_cmd: SCSI task management command.
+ *
+ * This routine creates FCP information unit corresponding to @task_mgmt_cmd
+ * for device with SLI-4 interface spec.
+ *
+ * Return codes:
+ *   0 - Error
+ *   1 - Success
+ **/
+static int
+lpfc_scsi_prep_task_mgmt_cmd_s4(struct lpfc_vport *vport,
+				struct lpfc_io_buf *lpfc_cmd,
+				u64 lun, u8 task_mgmt_cmd)
+{
+	struct lpfc_iocbq *pwqeq = &lpfc_cmd->cur_iocbq;
+	union lpfc_wqe128 *wqe = &pwqeq->wqe;
+	struct fcp_cmnd *fcp_cmnd;
+	struct lpfc_rport_data *rdata = lpfc_cmd->rdata;
+	struct lpfc_nodelist *ndlp = rdata->pnode;
+
+	if (!ndlp || ndlp->nlp_state != NLP_STE_MAPPED_NODE)
+		return 0;
+
+	pwqeq->vport = vport;
+	/* Initialize 64 bytes only */
+	memset(wqe, 0, sizeof(union lpfc_wqe128));
+
+	/* From the icmnd template, initialize words 4 - 11 */
+	memcpy(&wqe->words[4], &lpfc_icmnd_cmd_template.words[4],
+	       sizeof(uint32_t) * 8);
+
+	fcp_cmnd = lpfc_cmd->fcp_cmnd;
+	/* Clear out any old data in the FCP command area */
+	memset(fcp_cmnd, 0, sizeof(struct fcp_cmnd));
+	int_to_scsilun(lun, &fcp_cmnd->fcp_lun);
+	fcp_cmnd->fcpCntl3 = 0;
+	fcp_cmnd->fcpCntl2 = task_mgmt_cmd;
+
+	bf_set(payload_offset_len, &wqe->fcp_icmd,
+	       sizeof(struct fcp_cmnd) + sizeof(struct fcp_rsp));
+	bf_set(cmd_buff_len, &wqe->fcp_icmd, 0);
+	bf_set(wqe_ctxt_tag, &wqe->generic.wqe_com,  /* ulpContext */
+	       vport->phba->sli4_hba.rpi_ids[ndlp->nlp_rpi]);
+	bf_set(wqe_erp, &wqe->fcp_icmd.wqe_com,
+	       ((ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) ? 1 : 0));
+	bf_set(wqe_class, &wqe->fcp_icmd.wqe_com,
+	       (ndlp->nlp_fcp_info & 0x0f));
+
+	/* ulpTimeout is only one byte */
+	if (lpfc_cmd->timeout > 0xff) {
+		/*
+		 * Do not timeout the command at the firmware level.
+		 * The driver will provide the timeout mechanism.
+		 */
+		bf_set(wqe_tmo, &wqe->fcp_icmd.wqe_com, 0);
+	} else {
+		bf_set(wqe_tmo, &wqe->fcp_icmd.wqe_com, lpfc_cmd->timeout);
+	}
+
+	lpfc_prep_embed_io(vport->phba, lpfc_cmd);
+	bf_set(wqe_xri_tag, &wqe->generic.wqe_com, pwqeq->sli4_xritag);
+	wqe->generic.wqe_com.abort_tag = pwqeq->iotag;
+	bf_set(wqe_reqtag, &wqe->generic.wqe_com, pwqeq->iotag);
+
+	lpfc_sli4_set_rsp_sgl_last(vport->phba, lpfc_cmd);
 
 	return 1;
 }
@@ -5109,6 +5060,8 @@ lpfc_scsi_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->lpfc_release_scsi_buf = lpfc_release_scsi_buf_s3;
 		phba->lpfc_get_scsi_buf = lpfc_get_scsi_buf_s3;
 		phba->lpfc_scsi_prep_cmnd_buf = lpfc_scsi_prep_cmnd_buf_s3;
+		phba->lpfc_scsi_prep_task_mgmt_cmd =
+					lpfc_scsi_prep_task_mgmt_cmd_s3;
 		break;
 	case LPFC_PCI_DEV_OC:
 		phba->lpfc_scsi_prep_dma_buf = lpfc_scsi_prep_dma_buf_s4;
@@ -5116,6 +5069,8 @@ lpfc_scsi_api_table_setup(struct lpfc_hba *phba, uint8_t dev_grp)
 		phba->lpfc_release_scsi_buf = lpfc_release_scsi_buf_s4;
 		phba->lpfc_get_scsi_buf = lpfc_get_scsi_buf_s4;
 		phba->lpfc_scsi_prep_cmnd_buf = lpfc_scsi_prep_cmnd_buf_s4;
+		phba->lpfc_scsi_prep_task_mgmt_cmd =
+					lpfc_scsi_prep_task_mgmt_cmd_s4;
 		break;
 	default:
 		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
@@ -5594,6 +5549,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 {
 	struct lpfc_vport *vport = (struct lpfc_vport *) shost->hostdata;
 	struct lpfc_hba   *phba = vport->phba;
+	struct lpfc_iocbq *cur_iocbq = NULL;
 	struct lpfc_rport_data *rdata;
 	struct lpfc_nodelist *ndlp;
 	struct lpfc_io_buf *lpfc_cmd;
@@ -5687,6 +5643,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	}
 	lpfc_cmd->rx_cmd_start = start;
 
+	cur_iocbq = &lpfc_cmd->cur_iocbq;
 	/*
 	 * Store the midlayer's command structure for the completion phase
 	 * and complete the command initialization.
@@ -5694,7 +5651,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	lpfc_cmd->pCmd  = cmnd;
 	lpfc_cmd->rdata = rdata;
 	lpfc_cmd->ndlp = ndlp;
-	lpfc_cmd->cur_iocbq.cmd_cmpl = NULL;
+	cur_iocbq->cmd_cmpl = NULL;
 	cmnd->host_scribble = (unsigned char *)lpfc_cmd;
 
 	err = lpfc_scsi_prep_cmnd(vport, lpfc_cmd, ndlp);
@@ -5736,7 +5693,6 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 		goto out_host_busy_free_buf;
 	}
 
-
 	/* check the necessary and sufficient condition to support VMID */
 	if (lpfc_is_vmid_enabled(phba) &&
 	    (ndlp->vmid_support ||
@@ -5749,20 +5705,19 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 		if (uuid) {
 			err = lpfc_vmid_get_appid(vport, uuid, cmnd,
 				(union lpfc_vmid_io_tag *)
-					&lpfc_cmd->cur_iocbq.vmid_tag);
+					&cur_iocbq->vmid_tag);
 			if (!err)
-				lpfc_cmd->cur_iocbq.cmd_flag |= LPFC_IO_VMID;
+				cur_iocbq->cmd_flag |= LPFC_IO_VMID;
 		}
 	}
-
 	atomic_inc(&ndlp->cmd_pending);
+
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_SCSI_IO))
 		this_cpu_inc(phba->sli4_hba.c_stat->xmt_io);
 #endif
 	/* Issue I/O to adapter */
-	err = lpfc_sli_issue_fcp_io(phba, LPFC_FCP_RING,
-				    &lpfc_cmd->cur_iocbq,
+	err = lpfc_sli_issue_fcp_io(phba, LPFC_FCP_RING, cur_iocbq,
 				    SLI_IOCB_RET_IOCB);
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (start) {
@@ -5775,25 +5730,25 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 #endif
 	if (err) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
-				   "3376 FCP could not issue IOCB err %x "
-				   "FCP cmd x%x <%d/%llu> "
-				   "sid: x%x did: x%x oxid: x%x "
-				   "Data: x%x x%x x%x x%x\n",
-				   err, cmnd->cmnd[0],
-				   cmnd->device ? cmnd->device->id : 0xffff,
-				   cmnd->device ? cmnd->device->lun : (u64)-1,
-				   vport->fc_myDID, ndlp->nlp_DID,
-				   phba->sli_rev == LPFC_SLI_REV4 ?
-				   lpfc_cmd->cur_iocbq.sli4_xritag : 0xffff,
-				   phba->sli_rev == LPFC_SLI_REV4 ?
-				   phba->sli4_hba.rpi_ids[ndlp->nlp_rpi] :
-				   lpfc_cmd->cur_iocbq.iocb.ulpContext,
-				   lpfc_cmd->cur_iocbq.iotag,
-				   phba->sli_rev == LPFC_SLI_REV4 ?
-				   bf_get(wqe_tmo,
-				   &lpfc_cmd->cur_iocbq.wqe.generic.wqe_com) :
-				   lpfc_cmd->cur_iocbq.iocb.ulpTimeout,
-				   (uint32_t)(scsi_cmd_to_rq(cmnd)->timeout / 1000));
+				 "3376 FCP could not issue iocb err %x "
+				 "FCP cmd x%x <%d/%llu> "
+				 "sid: x%x did: x%x oxid: x%x "
+				 "Data: x%x x%x x%x x%x\n",
+				 err, cmnd->cmnd[0],
+				 cmnd->device ? cmnd->device->id : 0xffff,
+				 cmnd->device ? cmnd->device->lun : (u64)-1,
+				 vport->fc_myDID, ndlp->nlp_DID,
+				 phba->sli_rev == LPFC_SLI_REV4 ?
+				 cur_iocbq->sli4_xritag : 0xffff,
+				 phba->sli_rev == LPFC_SLI_REV4 ?
+				 phba->sli4_hba.rpi_ids[ndlp->nlp_rpi] :
+				 cur_iocbq->iocb.ulpContext,
+				 cur_iocbq->iotag,
+				 phba->sli_rev == LPFC_SLI_REV4 ?
+				 bf_get(wqe_tmo,
+					&cur_iocbq->wqe.generic.wqe_com) :
+				 cur_iocbq->iocb.ulpTimeout,
+				 (uint32_t)(scsi_cmd_to_rq(cmnd)->timeout / 1000));
 
 		goto out_host_busy_free_buf;
 	}
@@ -6173,7 +6128,7 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
 		return FAILED;
 	pnode = rdata->pnode;
 
-	lpfc_cmd = lpfc_get_scsi_buf(phba, pnode, NULL);
+	lpfc_cmd = lpfc_get_scsi_buf(phba, rdata->pnode, NULL);
 	if (lpfc_cmd == NULL)
 		return FAILED;
 	lpfc_cmd->timeout = phba->cfg_task_mgmt_tmo;
@@ -6181,8 +6136,8 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
 	lpfc_cmd->pCmd = cmnd;
 	lpfc_cmd->ndlp = pnode;
 
-	status = lpfc_scsi_prep_task_mgmt_cmd(vport, lpfc_cmd, lun_id,
-					   task_mgmt_cmd);
+	status = phba->lpfc_scsi_prep_task_mgmt_cmd(vport, lpfc_cmd, lun_id,
+						    task_mgmt_cmd);
 	if (!status) {
 		lpfc_release_scsi_buf(phba, lpfc_cmd);
 		return FAILED;
@@ -6195,6 +6150,7 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
 		return FAILED;
 	}
 	iocbq->cmd_cmpl = lpfc_tskmgmt_def_cmpl;
+	iocbq->vport = vport;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
 			 "0702 Issue %s to TGT %d LUN %llu "
@@ -6206,26 +6162,28 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
 	status = lpfc_sli_issue_iocb_wait(phba, LPFC_FCP_RING,
 					  iocbq, iocbqrsp, lpfc_cmd->timeout);
 	if ((status != IOCB_SUCCESS) ||
-	    (iocbqrsp->iocb.ulpStatus != IOSTAT_SUCCESS)) {
+	    (get_job_ulpstatus(phba, iocbqrsp) != IOSTAT_SUCCESS)) {
 		if (status != IOCB_SUCCESS ||
-		    iocbqrsp->iocb.ulpStatus != IOSTAT_FCP_RSP_ERROR)
+		    get_job_ulpstatus(phba, iocbqrsp) != IOSTAT_FCP_RSP_ERROR)
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "0727 TMF %s to TGT %d LUN %llu "
 					 "failed (%d, %d) cmd_flag x%x\n",
 					 lpfc_taskmgmt_name(task_mgmt_cmd),
 					 tgt_id, lun_id,
-					 iocbqrsp->iocb.ulpStatus,
-					 iocbqrsp->iocb.un.ulpWord[4],
+					 get_job_ulpstatus(phba, iocbqrsp),
+					 get_job_word4(phba, iocbqrsp),
 					 iocbq->cmd_flag);
 		/* if ulpStatus != IOCB_SUCCESS, then status == IOCB_SUCCESS */
 		if (status == IOCB_SUCCESS) {
-			if (iocbqrsp->iocb.ulpStatus == IOSTAT_FCP_RSP_ERROR)
+			if (get_job_ulpstatus(phba, iocbqrsp) ==
+			    IOSTAT_FCP_RSP_ERROR)
 				/* Something in the FCP_RSP was invalid.
 				 * Check conditions */
 				ret = lpfc_check_fcp_rsp(vport, lpfc_cmd);
 			else
 				ret = FAILED;
-		} else if (status == IOCB_TIMEDOUT) {
+		} else if ((status == IOCB_TIMEDOUT) ||
+			   (status == IOCB_ABORTED)) {
 			ret = TIMEOUT_ERROR;
 		} else {
 			ret = FAILED;
@@ -6235,7 +6193,7 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct scsi_cmnd *cmnd,
 
 	lpfc_sli_release_iocbq(phba, iocbqrsp);
 
-	if (ret != TIMEOUT_ERROR)
+	if (status != IOCB_TIMEDOUT)
 		lpfc_release_scsi_buf(phba, lpfc_cmd);
 
 	return ret;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 8c031fc8891d..53926dc68cdf 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -12648,6 +12648,7 @@ lpfc_sli_wake_iocb_wait(struct lpfc_hba *phba,
 	wait_queue_head_t *pdone_q;
 	unsigned long iflags;
 	struct lpfc_io_buf *lpfc_cmd;
+	size_t offset = offsetof(struct lpfc_iocbq, wqe);
 
 	spin_lock_irqsave(&phba->hbalock, iflags);
 	if (cmdiocbq->cmd_flag & LPFC_IO_WAKE_TMO) {
@@ -12668,10 +12669,11 @@ lpfc_sli_wake_iocb_wait(struct lpfc_hba *phba,
 		return;
 	}
 
+	/* Copy the contents of the local rspiocb into the caller's buffer. */
 	cmdiocbq->cmd_flag |= LPFC_IO_WAKE;
 	if (cmdiocbq->context2 && rspiocbq)
-		memcpy(&((struct lpfc_iocbq *)cmdiocbq->context2)->iocb,
-		       &rspiocbq->iocb, sizeof(IOCB_t));
+		memcpy((char *)cmdiocbq->context2 + offset,
+		       (char *)rspiocbq + offset, sizeof(*rspiocbq) - offset);
 
 	/* Set the exchange busy flag for task management commands */
 	if ((cmdiocbq->cmd_flag & LPFC_IO_FCP) &&
-- 
2.26.2

