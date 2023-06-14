Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D7716D0C
	for <lists+linux-scsi@lfdr.de>; Tue, 30 May 2023 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjE3TDo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 May 2023 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjE3TDn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 May 2023 15:03:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A1102
        for <linux-scsi@vger.kernel.org>; Tue, 30 May 2023 12:03:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b0460d3b41so3164165ad.1
        for <linux-scsi@vger.kernel.org>; Tue, 30 May 2023 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685473420; x=1688065420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kockdt6uutSAzwWXM5GLuDFvBa5J7CXvrOsdSIw8WpU=;
        b=jx4uzUj78FXi0+ZcTrXyPzQtEnjrfcYV69LB07AGjsXYBWmC1v/Hz9h/o/CasjEXm7
         Sah+obJgOO+MUAqvqfi45mlfdQiMa8RIhBMycRIeUdSHpkiYopfIco12DsX/TKqIpMvh
         NSiP4ftv507BLHUTrlUbDNxkOzSxk1nX5rqUQ3Lig5cIFLAEHcANeqKBq88aP7v+lciD
         9MeLFnIS/oRJxxz7T49Fq1x/Yo9W7unHuYlhDoHaQdAKOLp7j32P2kh86TMxdGgzEj0o
         OfTSTOyuhnAixihFWzOrATobHFkjOc90cXSCZOR+P33uc9mODYopD99UaNhumhpKmAaO
         5CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685473420; x=1688065420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kockdt6uutSAzwWXM5GLuDFvBa5J7CXvrOsdSIw8WpU=;
        b=AAxgqusIxB4RfAbbKZoBn9vyvWZbjxxFYTxkorktj+JBx0GlkIoS/Kh4JvhUuupnZl
         /2J0ZgLCijHj+EVxiO7jDnWxZDI25CcMZqDBYKr93aZAm0og1ldY3X8/rEsEBW7d1fZW
         FSwbG6/TqcWDyiIspdRxEUODm/TdXyrbEz8bCht4GuLCxHjgDG5DlELBGPDZZhY9DYdm
         TtsFaFe1OZz3pkDO17dHMKne8BZoxPdM5bn3m2Q5DP8WSFD13/slYL/twVbJuQoxADAi
         hOhDiZ++BWsf0+ojo531LAK17d/75aVuH9JwekBiJt5PEUodLvulpI9jKbsraXXf9k2M
         Yk9Q==
X-Gm-Message-State: AC+VfDyzLubdN29pitt+q2mg2BD03u274gGdR5JRMVjS3t9f1uHQVv7i
        bek4omuThtDM2bwSy/AcBrQ1xZbk/1g=
X-Google-Smtp-Source: ACHHUZ6k2FtBLIkUkEm9jcc3ANJqDLwwP+Sdla7QKEwRJ+aWR9FulIepkNzUQIKVCpmpKf5H0S+GRw==
X-Received: by 2002:a17:902:f542:b0:1ac:775b:3e0a with SMTP id h2-20020a170902f54200b001ac775b3e0amr327475plf.5.1685473419932;
        Tue, 30 May 2023 12:03:39 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902bd4700b001ab13f1fa82sm10630297plx.85.2023.05.30.12.03.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2023 12:03:39 -0700 (PDT)
From:   Justin Tee <justintee8345@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     jsmart2021@gmail.com, justin.tee@broadcom.com,
        Justin Tee <justintee8345@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] lpfc: Fix incorrect big endian type assignments in FDMI and VMID paths
Date:   Tue, 30 May 2023 12:14:05 -0700
Message-Id: <20230530191405.21580-1-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
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

The kernel test robot reported sparse warnings regarding the improper usage
of beXX_to_cpu macros.

Change the flagged FDMI and VMID member variables to __beXX and redo the
beXX_to_cpu macros appropriately.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305261159.lTW5NYrv-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202305260751.NWFvhLY5-lkp@intel.com/
---
 drivers/scsi/lpfc/lpfc_ct.c | 88 ++++++++++++++++++-------------------
 drivers/scsi/lpfc/lpfc_hw.h | 16 +++----
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index e880d127d7f5..321806cefede 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -287,7 +287,7 @@ lpfc_ct_handle_mibreq(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocbq)
 	u32 ulp_status = get_job_ulpstatus(phba, ctiocbq);
 	u32 ulp_word4 = get_job_word4(phba, ctiocbq);
 	u32 did;
-	u32 mi_cmd;
+	u16 mi_cmd;
 
 	did = bf_get(els_rsp64_sid, &ctiocbq->wqe.xmit_els_rsp);
 	if (ulp_status) {
@@ -311,7 +311,7 @@ lpfc_ct_handle_mibreq(struct lpfc_hba *phba, struct lpfc_iocbq *ctiocbq)
 
 	ct_req = (struct lpfc_sli_ct_request *)ctiocbq->cmd_dmabuf->virt;
 
-	mi_cmd = ct_req->CommandResponse.bits.CmdRsp;
+	mi_cmd = be16_to_cpu(ct_req->CommandResponse.bits.CmdRsp);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "6442 : MI Cmd : x%x Not Supported\n", mi_cmd);
 	lpfc_ct_reject_event(ndlp, ct_req,
@@ -486,7 +486,7 @@ lpfc_free_ct_rsp(struct lpfc_hba *phba, struct lpfc_dmabuf *mlist)
 }
 
 static struct lpfc_dmabuf *
-lpfc_alloc_ct_rsp(struct lpfc_hba *phba, int cmdcode, struct ulp_bde64 *bpl,
+lpfc_alloc_ct_rsp(struct lpfc_hba *phba, __be16 cmdcode, struct ulp_bde64 *bpl,
 		  uint32_t size, int *entries)
 {
 	struct lpfc_dmabuf *mlist = NULL;
@@ -507,8 +507,8 @@ lpfc_alloc_ct_rsp(struct lpfc_hba *phba, int cmdcode, struct ulp_bde64 *bpl,
 
 		INIT_LIST_HEAD(&mp->list);
 
-		if (cmdcode == be16_to_cpu(SLI_CTNS_GID_FT) ||
-		    cmdcode == be16_to_cpu(SLI_CTNS_GFF_ID))
+		if (be16_to_cpu(cmdcode) == SLI_CTNS_GID_FT ||
+		    be16_to_cpu(cmdcode) == SLI_CTNS_GFF_ID)
 			mp->virt = lpfc_mbuf_alloc(phba, MEM_PRI, &(mp->phys));
 		else
 			mp->virt = lpfc_mbuf_alloc(phba, 0, &(mp->phys));
@@ -671,7 +671,7 @@ lpfc_ct_cmd(struct lpfc_vport *vport, struct lpfc_dmabuf *inmp,
 	struct ulp_bde64 *bpl = (struct ulp_bde64 *) bmp->virt;
 	struct lpfc_dmabuf *outmp;
 	int cnt = 0, status;
-	int cmdcode = ((struct lpfc_sli_ct_request *) inmp->virt)->
+	__be16 cmdcode = ((struct lpfc_sli_ct_request *)inmp->virt)->
 		CommandResponse.bits.CmdRsp;
 
 	bpl++;			/* Skip past ct request */
@@ -1043,8 +1043,8 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				    outp,
 				    CTreq->un.gid.Fc4Type,
 				    get_job_data_placed(phba, rspiocb));
-		} else if (CTrsp->CommandResponse.bits.CmdRsp ==
-			   be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
+		} else if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+			   SLI_CT_RESPONSE_FS_RJT) {
 			/* NameServer Rsp Error */
 			if ((CTrsp->ReasonCode == SLI_CT_UNABLE_TO_PERFORM_REQ)
 			    && (CTrsp->Explanation == SLI_CT_NO_FC4_TYPES)) {
@@ -1052,14 +1052,14 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					LOG_DISCOVERY,
 					"0269 No NameServer Entries "
 					"Data: x%x x%x x%x x%x\n",
-					CTrsp->CommandResponse.bits.CmdRsp,
+					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 					(uint32_t) CTrsp->ReasonCode,
 					(uint32_t) CTrsp->Explanation,
 					vport->fc_flag);
 
 				lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 				"GID_FT no entry  cmd:x%x rsn:x%x exp:x%x",
-				(uint32_t)CTrsp->CommandResponse.bits.CmdRsp,
+				be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 				(uint32_t) CTrsp->ReasonCode,
 				(uint32_t) CTrsp->Explanation);
 			} else {
@@ -1067,14 +1067,14 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					LOG_DISCOVERY,
 					"0240 NameServer Rsp Error "
 					"Data: x%x x%x x%x x%x\n",
-					CTrsp->CommandResponse.bits.CmdRsp,
+					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 					(uint32_t) CTrsp->ReasonCode,
 					(uint32_t) CTrsp->Explanation,
 					vport->fc_flag);
 
 				lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 				"GID_FT rsp err1  cmd:x%x rsn:x%x exp:x%x",
-				(uint32_t)CTrsp->CommandResponse.bits.CmdRsp,
+				be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 				(uint32_t) CTrsp->ReasonCode,
 				(uint32_t) CTrsp->Explanation);
 			}
@@ -1085,14 +1085,14 @@ lpfc_cmpl_ct_cmd_gid_ft(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					"0241 NameServer Rsp Error "
 					"Data: x%x x%x x%x x%x\n",
-					CTrsp->CommandResponse.bits.CmdRsp,
+					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 					(uint32_t) CTrsp->ReasonCode,
 					(uint32_t) CTrsp->Explanation,
 					vport->fc_flag);
 
 			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
 				"GID_FT rsp err2  cmd:x%x rsn:x%x exp:x%x",
-				(uint32_t)CTrsp->CommandResponse.bits.CmdRsp,
+				be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 				(uint32_t) CTrsp->ReasonCode,
 				(uint32_t) CTrsp->Explanation);
 		}
@@ -1247,8 +1247,8 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Good status, continue checking */
 		CTreq = (struct lpfc_sli_ct_request *)inp->virt;
 		CTrsp = (struct lpfc_sli_ct_request *)outp->virt;
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    cpu_to_be16(SLI_CT_RESPONSE_FS_ACC)) {
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC) {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "4105 NameServer Rsp Data: x%x x%x "
 					 "x%x x%x sz x%x\n",
@@ -1262,8 +1262,8 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				    outp,
 				    CTreq->un.gid.Fc4Type,
 				    get_job_data_placed(phba, rspiocb));
-		} else if (CTrsp->CommandResponse.bits.CmdRsp ==
-			   be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
+		} else if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+			   SLI_CT_RESPONSE_FS_RJT) {
 			/* NameServer Rsp Error */
 			if ((CTrsp->ReasonCode == SLI_CT_UNABLE_TO_PERFORM_REQ)
 			    && (CTrsp->Explanation == SLI_CT_NO_FC4_TYPES)) {
@@ -1271,7 +1271,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					vport, KERN_INFO, LOG_DISCOVERY,
 					"4106 No NameServer Entries "
 					"Data: x%x x%x x%x x%x\n",
-					CTrsp->CommandResponse.bits.CmdRsp,
+					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 					(uint32_t)CTrsp->ReasonCode,
 					(uint32_t)CTrsp->Explanation,
 					vport->fc_flag);
@@ -1279,7 +1279,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				lpfc_debugfs_disc_trc(
 				vport, LPFC_DISC_TRC_CT,
 				"GID_PT no entry  cmd:x%x rsn:x%x exp:x%x",
-				(uint32_t)CTrsp->CommandResponse.bits.CmdRsp,
+				be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 				(uint32_t)CTrsp->ReasonCode,
 				(uint32_t)CTrsp->Explanation);
 			} else {
@@ -1287,7 +1287,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 					vport, KERN_INFO, LOG_DISCOVERY,
 					"4107 NameServer Rsp Error "
 					"Data: x%x x%x x%x x%x\n",
-					CTrsp->CommandResponse.bits.CmdRsp,
+					be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 					(uint32_t)CTrsp->ReasonCode,
 					(uint32_t)CTrsp->Explanation,
 					vport->fc_flag);
@@ -1295,7 +1295,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				lpfc_debugfs_disc_trc(
 				vport, LPFC_DISC_TRC_CT,
 				"GID_PT rsp err1  cmd:x%x rsn:x%x exp:x%x",
-				(uint32_t)CTrsp->CommandResponse.bits.CmdRsp,
+				be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 				(uint32_t)CTrsp->ReasonCode,
 				(uint32_t)CTrsp->Explanation);
 			}
@@ -1304,7 +1304,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 					 "4109 NameServer Rsp Error "
 					 "Data: x%x x%x x%x x%x\n",
-					 CTrsp->CommandResponse.bits.CmdRsp,
+					 be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 					 (uint32_t)CTrsp->ReasonCode,
 					 (uint32_t)CTrsp->Explanation,
 					 vport->fc_flag);
@@ -1312,7 +1312,7 @@ lpfc_cmpl_ct_cmd_gid_pt(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			lpfc_debugfs_disc_trc(
 				vport, LPFC_DISC_TRC_CT,
 				"GID_PT rsp err2  cmd:x%x rsn:x%x exp:x%x",
-				(uint32_t)CTrsp->CommandResponse.bits.CmdRsp,
+				be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 				(uint32_t)CTrsp->ReasonCode,
 				(uint32_t)CTrsp->Explanation);
 		}
@@ -1391,8 +1391,8 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				 (fbits & FC4_FEATURE_INIT) ? "Initiator" : " ",
 				 (fbits & FC4_FEATURE_TARGET) ? "Target" : " ");
 
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    be16_to_cpu(SLI_CT_RESPONSE_FS_ACC)) {
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC) {
 			if ((fbits & FC4_FEATURE_INIT) &&
 			    !(fbits & FC4_FEATURE_TARGET)) {
 				lpfc_printf_vlog(vport, KERN_INFO,
@@ -1631,7 +1631,7 @@ lpfc_cmpl_ct(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 "0209 CT Request completes, latt %d, "
 			 "ulp_status x%x CmdRsp x%x, Context x%x, Tag x%x\n",
 			 latt, ulp_status,
-			 CTrsp->CommandResponse.bits.CmdRsp,
+			 be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp),
 			 get_job_ulpcontext(phba, cmdiocb), cmdiocb->iotag);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_CT,
@@ -1681,8 +1681,8 @@ lpfc_cmpl_ct_cmd_rft_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		outp = cmdiocb->rsp_dmabuf;
 		CTrsp = (struct lpfc_sli_ct_request *)outp->virt;
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    be16_to_cpu(SLI_CT_RESPONSE_FS_ACC))
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC)
 			vport->ct_flags |= FC_CT_RFT_ID;
 	}
 	lpfc_cmpl_ct(phba, cmdiocb, rspiocb);
@@ -1702,8 +1702,8 @@ lpfc_cmpl_ct_cmd_rnn_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		outp = cmdiocb->rsp_dmabuf;
 		CTrsp = (struct lpfc_sli_ct_request *) outp->virt;
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    be16_to_cpu(SLI_CT_RESPONSE_FS_ACC))
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC)
 			vport->ct_flags |= FC_CT_RNN_ID;
 	}
 	lpfc_cmpl_ct(phba, cmdiocb, rspiocb);
@@ -1723,8 +1723,8 @@ lpfc_cmpl_ct_cmd_rspn_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		outp = cmdiocb->rsp_dmabuf;
 		CTrsp = (struct lpfc_sli_ct_request *)outp->virt;
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    be16_to_cpu(SLI_CT_RESPONSE_FS_ACC))
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC)
 			vport->ct_flags |= FC_CT_RSPN_ID;
 	}
 	lpfc_cmpl_ct(phba, cmdiocb, rspiocb);
@@ -1744,8 +1744,8 @@ lpfc_cmpl_ct_cmd_rsnn_nn(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		outp = cmdiocb->rsp_dmabuf;
 		CTrsp = (struct lpfc_sli_ct_request *) outp->virt;
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    be16_to_cpu(SLI_CT_RESPONSE_FS_ACC))
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC)
 			vport->ct_flags |= FC_CT_RSNN_NN;
 	}
 	lpfc_cmpl_ct(phba, cmdiocb, rspiocb);
@@ -1777,8 +1777,8 @@ lpfc_cmpl_ct_cmd_rff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		outp = cmdiocb->rsp_dmabuf;
 		CTrsp = (struct lpfc_sli_ct_request *)outp->virt;
-		if (CTrsp->CommandResponse.bits.CmdRsp ==
-		    be16_to_cpu(SLI_CT_RESPONSE_FS_ACC))
+		if (be16_to_cpu(CTrsp->CommandResponse.bits.CmdRsp) ==
+		    SLI_CT_RESPONSE_FS_ACC)
 			vport->ct_flags |= FC_CT_RFF_ID;
 	}
 	lpfc_cmpl_ct(phba, cmdiocb, rspiocb);
@@ -2217,8 +2217,8 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *outp = cmdiocb->rsp_dmabuf;
 	struct lpfc_sli_ct_request *CTcmd = inp->virt;
 	struct lpfc_sli_ct_request *CTrsp = outp->virt;
-	uint16_t fdmi_cmd = CTcmd->CommandResponse.bits.CmdRsp;
-	uint16_t fdmi_rsp = CTrsp->CommandResponse.bits.CmdRsp;
+	__be16 fdmi_cmd = CTcmd->CommandResponse.bits.CmdRsp;
+	__be16 fdmi_rsp = CTrsp->CommandResponse.bits.CmdRsp;
 	struct lpfc_nodelist *ndlp, *free_ndlp = NULL;
 	uint32_t latt, cmd, err;
 	u32 ulp_status = get_job_ulpstatus(phba, rspiocb);
@@ -2278,7 +2278,7 @@ lpfc_cmpl_ct_disc_fdmi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check for a CT LS_RJT response */
 	cmd =  be16_to_cpu(fdmi_cmd);
-	if (fdmi_rsp == cpu_to_be16(SLI_CT_RESPONSE_FS_RJT)) {
+	if (be16_to_cpu(fdmi_rsp) == SLI_CT_RESPONSE_FS_RJT) {
 		/* FDMI rsp failed */
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY | LOG_ELS,
 				 "0220 FDMI cmd failed FS_RJT Data: x%x", cmd);
@@ -3110,7 +3110,7 @@ lpfc_fdmi_vendor_attr_mi(struct lpfc_vport *vport, void *attr)
 }
 
 /* RHBA attribute jump table */
-int (*lpfc_fdmi_hba_action[])
+static int (*lpfc_fdmi_hba_action[])
 	(struct lpfc_vport *vport, void *attrbuf) = {
 	/* Action routine                 Mask bit     Attribute type */
 	lpfc_fdmi_hba_attr_wwnn,	  /* bit0     RHBA_NODENAME           */
@@ -3134,7 +3134,7 @@ int (*lpfc_fdmi_hba_action[])
 };
 
 /* RPA / RPRT attribute jump table */
-int (*lpfc_fdmi_port_action[])
+static int (*lpfc_fdmi_port_action[])
 	(struct lpfc_vport *vport, void *attrbuf) = {
 	/* Action routine                   Mask bit   Attribute type */
 	lpfc_fdmi_port_attr_fc4type,        /* bit0   RPRT_SUPPORT_FC4_TYPES  */
@@ -3570,7 +3570,7 @@ lpfc_cmpl_ct_cmd_vmid(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_dmabuf *outp = cmdiocb->rsp_dmabuf;
 	struct lpfc_sli_ct_request *ctcmd = inp->virt;
 	struct lpfc_sli_ct_request *ctrsp = outp->virt;
-	u16 rsp = ctrsp->CommandResponse.bits.CmdRsp;
+	__be16 rsp = ctrsp->CommandResponse.bits.CmdRsp;
 	struct app_id_object *app;
 	struct lpfc_nodelist *ndlp = cmdiocb->ndlp;
 	u32 cmd, hash, bucket;
@@ -3587,7 +3587,7 @@ lpfc_cmpl_ct_cmd_vmid(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			goto free_res;
 	}
 	/* Check for a CT LS_RJT response */
-	if (rsp == be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
+	if (be16_to_cpu(rsp) == SLI_CT_RESPONSE_FS_RJT) {
 		if (cmd != SLI_CTAS_DALLAPP_ID)
 			lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
 					 "3306 VMID FS_RJT Data: x%x x%x x%x\n",
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index b2123ec4df88..663755842e4a 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -86,8 +86,8 @@ union CtRevisionId {
 union CtCommandResponse {
 	/* Structure is in Big Endian format */
 	struct {
-		uint32_t CmdRsp:16;
-		uint32_t Size:16;
+		__be16 CmdRsp;
+		__be16 Size;
 	} bits;
 	uint32_t word;
 };
@@ -124,7 +124,7 @@ struct lpfc_sli_ct_request {
 #define LPFC_CT_PREAMBLE	20	/* Size of CTReq + 4 up to here */
 
 	union {
-		uint32_t PortID;
+		__be32 PortID;
 		struct gid {
 			uint8_t PortType;	/* for GID_PT requests */
 #define GID_PT_N_PORT	1
@@ -1408,18 +1408,18 @@ struct entity_id_object {
 };
 
 struct app_id_object {
-	uint32_t port_id;
-	uint32_t app_id;
+	__be32 port_id;
+	__be32 app_id;
 	struct entity_id_object obj;
 };
 
 struct lpfc_vmid_rapp_ident_list {
-	uint32_t no_of_objects;
+	__be32 no_of_objects;
 	struct entity_id_object obj[];
 };
 
 struct lpfc_vmid_dapp_ident_list {
-	uint32_t no_of_objects;
+	__be32 no_of_objects;
 	struct entity_id_object obj[];
 };
 
@@ -1512,7 +1512,7 @@ struct lpfc_fdmi_hba_ident {
  * Registered Port List Format
  */
 struct lpfc_fdmi_reg_port_list {
-	uint32_t EntryCnt;
+	__be32 EntryCnt;
 	struct lpfc_fdmi_port_entry pe;
 } __packed;
 
-- 
2.38.0

