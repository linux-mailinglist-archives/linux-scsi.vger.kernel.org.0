Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9762AB678
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Nov 2020 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgKILSI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Nov 2020 06:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgKILSI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Nov 2020 06:18:08 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB26C0613CF
        for <linux-scsi@vger.kernel.org>; Mon,  9 Nov 2020 03:18:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id z24so6895911pgk.3
        for <linux-scsi@vger.kernel.org>; Mon, 09 Nov 2020 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eFfqZ72GLU1DMmqJsPAAwCdb+zgetP3CPQfNhJT4TCM=;
        b=RGoLkfZcnfa3I88pLf6jTAlUKe08DwmtmDVnNQCo7oKOooaoRFB/MnNkV/Lbedu3iI
         gmwPZmzBtSg+8OydtU7b65hrSoe0l7heNQA1ejvvuxB02QM8Q7MPZIzUFl1hR18DzIRd
         lRbu3xqDMaW5L65ifgqhgdUCA9vPDYoqELm3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eFfqZ72GLU1DMmqJsPAAwCdb+zgetP3CPQfNhJT4TCM=;
        b=OxVrjqdJWLn7zPS8a/JtudwOy1dDC2SAZbwFDDBQoI7ZLAqrJ6GP6yWxWiqhOS+Ytx
         WK9066W/8oCSpy+8aDs/KBzKzVo8b1kQmlLSHXJaj4rGEFOVRh8WjDINYM0Av+qqIq8P
         TPvakqxUD6li6d34hHrNuahr0U7FG/4u00SKYCWl3myAu74ywfP61a43/4f5q+FuTVVi
         eIqbgwTMuPkAN7YWSS2TjQp29Z2khyNrugQFpy1nIgo6YNN5LSPTDf+csWg3WS2/s1GO
         JVDmmZCUNUUcAgZbtxFp1uNqQ/Sex5JZ1TKT2WoJff4MPIO7MO/ooy77mVcjU968yXSj
         bjyA==
X-Gm-Message-State: AOAM532QZk8R6ZsoKM2mbL3w1eIP2ZaETwSUYTFLExC4AviT+Xta3eZ+
        iuYzn4hScibwFz/55dcad+xBXA==
X-Google-Smtp-Source: ABdhPJzKdCjdDSnxzaedA69o9/9BBgkSZPdZz9+KGgzvHwEqZ15VeEKuU3VVvjwwPYZOOobjRwnk6A==
X-Received: by 2002:a17:90b:4c10:: with SMTP id na16mr10425245pjb.38.1604920687810;
        Mon, 09 Nov 2020 03:18:07 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k9sm10889364pfp.68.2020.11.09.03.18.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:18:07 -0800 (PST)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v4 12/19] lpfc: vmid: Implements ELS commands for appid patch
Date:   Mon,  9 Nov 2020 09:53:58 +0530
Message-Id: <1604895845-2587-13-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000832a5105b3aab71a"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000832a5105b3aab71a

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch implements ELS command like QFPA and UVEM for the priority
tagging appid support. Other supporting functions are also part of this
patch.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_els.c | 356 ++++++++++++++++++++++++++++++++++-
 1 file changed, 349 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index f4e274eb6c9c..4f61d2edb89b 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
@@ -55,6 +56,8 @@ static int lpfc_issue_els_fdisc(struct lpfc_vport *vport,
 				struct lpfc_nodelist *ndlp, uint8_t retry);
 static int lpfc_issue_fabric_iocb(struct lpfc_hba *phba,
 				  struct lpfc_iocbq *iocb);
+static void lpfc_cmpl_els_uvem(struct lpfc_hba *, struct lpfc_iocbq *,
+			       struct lpfc_iocbq *);
 
 static int lpfc_max_els_tries = 3;
 
@@ -316,12 +319,12 @@ lpfc_prep_els_iocb(struct lpfc_vport *vport, uint8_t expectRsp,
 	if (expectRsp) {
 		/* Xmit ELS command <elsCmd> to remote NPORT <did> */
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-				 "0116 Xmit ELS command x%x to remote "
-				 "NPORT x%x I/O tag: x%x, port state:x%x "
-				 "rpi x%x fc_flag:x%x\n",
+				 "0116 Xmit ELS command x%x to remote\n"
+				 "NPORT x%x I/O tag: x%x, port state:x%x\n"
+				 "rpi x%x fc_flag:x%x nlp_flag:x%x vport:x%p\n",
 				 elscmd, did, elsiocb->iotag,
 				 vport->port_state, ndlp->nlp_rpi,
-				 vport->fc_flag);
+				 vport->fc_flag, ndlp->nlp_flag, vport);
 	} else {
 		/* Xmit ELS response <elsCmd> to remote NPORT <did> */
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
@@ -1116,12 +1119,16 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* FLOGI completes successfully */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0101 FLOGI completes successfully, I/O tag:x%x, "
-			 "xri x%x Data: x%x x%x x%x x%x x%x %x\n",
+			 "0101 FLOGI completes successfully, I/O tag:x%x,\n"
+			 "xri x%x Data: x%x x%x x%x x%x x%x %x %x\n",
 			 cmdiocb->iotag, cmdiocb->sli4_xritag,
 			 irsp->un.ulpWord[4], sp->cmn.e_d_tov,
 			 sp->cmn.w2.r_a_tov, sp->cmn.edtovResolution,
-			 vport->port_state, vport->fc_flag);
+			 vport->port_state, vport->fc_flag,
+			 sp->cmn.priority_tagging);
+
+	if (sp->cmn.priority_tagging)
+		vport->vmid_flag |= LPFC_VMID_ISSUE_QFPA;
 
 	if (vport->port_state == LPFC_FLOGI) {
 		/*
@@ -1302,6 +1309,18 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	if (sp->cmn.fcphHigh < FC_PH3)
 		sp->cmn.fcphHigh = FC_PH3;
 
+	/* to deterine if switch supports priority tagging */
+	if (phba->cfg_vmid_priority_tagging) {
+		sp->cmn.priority_tagging = 1;
+		/* lpfc_vmid_host_uuid is combination of wwpn and wwnn */
+		if (vport->lpfc_vmid_host_uuid[0] == 0) {
+			memcpy(vport->lpfc_vmid_host_uuid, phba->wwpn,
+			       sizeof(phba->wwpn));
+			memcpy(&vport->lpfc_vmid_host_uuid[8], phba->wwnn,
+			       sizeof(phba->wwnn));
+		}
+	}
+
 	if  (phba->sli_rev == LPFC_SLI_REV4) {
 		if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) ==
 		    LPFC_SLI_INTF_IF_TYPE_0) {
@@ -1999,6 +2018,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp;
 	struct lpfc_dmabuf *prsp;
 	int disc;
+	struct serv_parm *sp = NULL;
 
 	/* we pass cmdiocb to state machine which needs rspiocb as well */
 	cmdiocb->context_un.rsp_iocb = rspiocb;
@@ -2074,6 +2094,23 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				   cmdiocb->context2)->list.next,
 				  struct lpfc_dmabuf, list);
 		ndlp = lpfc_plogi_confirm_nport(phba, prsp->virt, ndlp);
+
+		sp = (struct serv_parm *)((u8 *)prsp->virt +
+					  sizeof(u32));
+
+		ndlp->vmid_support = 0;
+		if ((phba->cfg_vmid_app_header && sp->cmn.app_hdr_support) ||
+		    (phba->cfg_vmid_priority_tagging &&
+		     sp->cmn.priority_tagging)) {
+			lpfc_printf_log(phba, KERN_DEBUG, LOG_ELS,
+					"4018 app_hdr_support %d tagging %d DID x%x",
+					sp->cmn.app_hdr_support,
+					sp->cmn.priority_tagging,
+					ndlp->nlp_DID);
+			/* if the dest port supports VMID, mark it in ndlp */
+			ndlp->vmid_support = 1;
+		}
+
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					     NLP_EVT_CMPL_PLOGI);
 	}
@@ -2192,6 +2229,14 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 	memset(sp->un.vendorVersion, 0, sizeof(sp->un.vendorVersion));
 	sp->cmn.bbRcvSizeMsb &= 0xF;
 
+	/* check if the destination port supports VMID */
+	ndlp->vmid_support = 0;
+	if (vport->vmid_priority_tagging)
+		sp->cmn.priority_tagging = 1;
+	else if (phba->cfg_vmid_app_header &&
+		 bf_get(lpfc_ftr_ashdr, &phba->sli4_hba.sli4_flags))
+		sp->cmn.app_hdr_support = 1;
+
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
 		"Issue PLOGI:     did:x%x",
 		did, 0, 0);
@@ -10162,3 +10207,300 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 	lpfc_unreg_rpi(vport, ndlp);
 }
 
+void lpfc_init_cs_ctl_bitmap(struct lpfc_vport *vport)
+{
+	bitmap_zero(vport->vmid_priority_range, LPFC_VMID_MAX_PRIORITY_RANGE);
+}
+
+void
+lpfc_vmid_set_cs_ctl_range(struct lpfc_vport *vport, u32 min, u32 max)
+{
+	u32 i;
+
+	if ((min > max) || (max > LPFC_VMID_MAX_PRIORITY_RANGE))
+		return;
+
+	for (i = min; i <= max; i++)
+		set_bit(i, vport->vmid_priority_range);
+}
+
+void lpfc_vmid_put_cs_ctl(struct lpfc_vport *vport, u32 ctcl_vmid)
+{
+	set_bit(ctcl_vmid, vport->vmid_priority_range);
+}
+
+u32 lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport)
+{
+	u32 i;
+
+	i = find_first_bit(vport->vmid_priority_range,
+			   LPFC_VMID_MAX_PRIORITY_RANGE);
+
+	if (i == LPFC_VMID_MAX_PRIORITY_RANGE)
+		return 0;
+
+	clear_bit(i, vport->vmid_priority_range);
+	return i;
+}
+
+#define MAX_PRIORITY_DESC	255
+
+static void
+lpfc_cmpl_els_qfpa(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		   struct lpfc_iocbq *rspiocb)
+{
+	struct lpfc_vport *vport = cmdiocb->vport;
+	struct priority_range_desc *desc;
+	struct lpfc_dmabuf *prsp = NULL;
+	struct lpfc_vmid_priority_range *vmid_range = NULL;
+	u32 *data;
+	struct lpfc_dmabuf *dmabuf = cmdiocb->context2;
+	IOCB_t *irsp = &rspiocb->iocb;
+	u8 *pcmd;
+	u32 len, i;
+
+	prsp = list_get_first(&dmabuf->list, struct lpfc_dmabuf, list);
+	if (!prsp)
+		goto out;
+
+	pcmd = prsp->virt;
+	data = (u32 *)pcmd;
+	if (*((u32 *)(pcmd)) == ELS_CMD_LS_RJT) {
+		lpfc_printf_vlog(vport, KERN_WARNING, LOG_SLI,
+				 "6528 QFPA LS_RJT %x  %x ", data[0], data[1]);
+		goto out;
+	}
+	if (irsp->ulpStatus) {
+		lpfc_printf_vlog(vport, KERN_ERR, LOG_SLI,
+				 "6529 QFPA failed with status %x  %x ",
+				 irsp->ulpStatus, irsp->un.ulpWord[4]);
+		goto out;
+	}
+
+	if (!vport->qfpa_res) {
+		vport->qfpa_res = kmalloc(FCELSSIZE, GFP_KERNEL);
+		if (!vport->qfpa_res)
+			goto out;
+		memset(vport->qfpa_res, 0, FCELSSIZE);
+	}
+
+	len = *((u32 *)(pcmd + 4));
+	len = be32_to_cpu(len);
+	memcpy(vport->qfpa_res, pcmd, len + 8);
+	len = len / LPFC_PRIORITY_RANGE_DESC_SIZE;
+
+	desc = (struct priority_range_desc *)(pcmd + 8);
+	vmid_range = vport->vmid_priority.vmid_range;
+	if (!vmid_range) {
+		vmid_range = kmalloc_array(MAX_PRIORITY_DESC,
+					   sizeof
+					   (struct lpfc_vmid_priority_range),
+					   GFP_KERNEL);
+		if (!vmid_range)
+			goto out;
+		memset(vmid_range, 0, MAX_PRIORITY_DESC *
+		       sizeof(struct lpfc_vmid_priority_range));
+		vport->vmid_priority.vmid_range = vmid_range;
+	}
+	vport->vmid_priority.num_descriptors = len;
+
+	for (i = 0; i < len; i++, vmid_range++, desc++) {
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_ELS,
+				 "6539 vmid values low=%d, high=%d, qos=%d,\n"
+				 " local ve id=%d\n", desc->lo_range,
+				 desc->hi_range, desc->qos_priority,
+				 desc->local_ve_id);
+
+		vmid_range->low = desc->lo_range << 1;
+		if (desc->local_ve_id == QFPA_ODD_ONLY)
+			vmid_range->low++;
+		if (desc->qos_priority)
+			vport->vmid_flag |= LPFC_VMID_QOS_ENABLED;
+		vmid_range->qos = desc->qos_priority;
+
+		vmid_range->high = desc->hi_range << 1;
+		if ((desc->local_ve_id == QFPA_ODD_ONLY) ||
+		    (desc->local_ve_id == QFPA_EVEN_ODD))
+			vmid_range->high++;
+	}
+	lpfc_init_cs_ctl_bitmap(vport);
+	for (i = 0; i < vport->vmid_priority.num_descriptors; i++) {
+		lpfc_vmid_set_cs_ctl_range(vport,
+				vport->vmid_priority.vmid_range[i].low,
+				vport->vmid_priority.vmid_range[i].high);
+	}
+
+	vport->vmid_flag |= LPFC_VMID_QFPA_CMPL;
+ out:
+	lpfc_els_free_iocb(phba, cmdiocb);
+}
+
+int lpfc_issue_els_qfpa(struct lpfc_vport *vport)
+{
+	struct lpfc_hba *phba = vport->phba;
+	IOCB_t *icmd;
+	struct lpfc_nodelist *ndlp;
+	struct lpfc_iocbq *elsiocb;
+	struct lpfc_sli *psli;
+	u8 *pcmd;
+	int ret;
+
+	psli = &phba->sli;
+
+	ndlp = lpfc_findnode_did(phba->pport, Fabric_DID);
+	if (ndlp && !NLP_CHK_NODE_ACT(ndlp))
+		return 1;
+
+	if (!ndlp)
+		return 1;
+
+	elsiocb = lpfc_prep_els_iocb(vport, 1, LPFC_QFPA_SIZE, 2, ndlp,
+				     ndlp->nlp_DID, ELS_CMD_QFPA);
+	if (!elsiocb)
+		return 1;
+
+	icmd = &elsiocb->iocb;
+	pcmd = (u8 *)(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
+
+	*((u32 *)(pcmd)) = ELS_CMD_QFPA;
+	pcmd += 4;
+
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_qfpa;
+	ret = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 2);
+	if (ret != IOCB_SUCCESS) {
+		lpfc_els_free_iocb(phba, elsiocb);
+		return 1;
+	}
+	vport->vmid_flag &= ~LPFC_VMID_QOS_ENABLED;
+	return 0;
+}
+
+int
+lpfc_vmid_uvem(struct lpfc_vport *vport,
+	       struct lpfc_vmid *vmid, bool instantiated)
+{
+	struct lpfc_vem_id_desc *vem_id_desc;
+	struct lpfc_nodelist *ndlp;
+	IOCB_t *icmd;
+	struct lpfc_iocbq *elsiocb;
+	struct instantiated_ve_desc *inst_desc;
+	struct lpfc_vmid_context *vmid_context;
+	u8 *pcmd;
+	u32 *len;
+	int ret = 0;
+
+	ndlp = lpfc_findnode_did(vport, Fabric_DID);
+	if (ndlp && !NLP_CHK_NODE_ACT(ndlp))
+		return 1;
+
+	vmid_context = kmalloc(sizeof(*vmid_context), GFP_KERNEL);
+	if (!vmid_context)
+		return 1;
+	elsiocb = lpfc_prep_els_iocb(vport, 1, LPFC_UVEM_SIZE, 2,
+				     ndlp, Fabric_DID, ELS_CMD_UVEM);
+	if (!elsiocb)
+		goto out;
+
+	lpfc_printf_vlog(vport, KERN_DEBUG, LOG_ELS,
+			 "3427 %s %d", vmid->host_vmid, instantiated);
+	vmid_context->vmp = vmid;
+	vmid_context->nlp = ndlp;
+	vmid_context->instantiated = instantiated;
+	elsiocb->vmid_tag.vmid_context = vmid_context;
+	icmd = &elsiocb->iocb;
+	pcmd = (u8 *)(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
+
+	if (vport->lpfc_vmid_host_uuid[0] == 0)
+		memcpy(vport->lpfc_vmid_host_uuid, vmid->host_vmid,
+		       LPFC_COMPRESS_VMID_SIZE);
+
+	*((u32 *)(pcmd)) = ELS_CMD_UVEM;
+	len = (u32 *)(pcmd + 4);
+	*len = cpu_to_be32(LPFC_UVEM_SIZE - 8);
+
+	vem_id_desc = (struct lpfc_vem_id_desc *)(pcmd + 8);
+	vem_id_desc->tag = be32_to_cpu(VEM_ID_DESC_TAG);
+	vem_id_desc->length = be32_to_cpu(LPFC_UVEM_VEM_ID_DESC_SIZE);
+	memcpy(vem_id_desc->vem_id, vport->lpfc_vmid_host_uuid,
+	       LPFC_COMPRESS_VMID_SIZE);
+
+	inst_desc = (struct instantiated_ve_desc *)(pcmd + 32);
+	inst_desc->tag = be32_to_cpu(INSTANTIATED_VE_DESC_TAG);
+	inst_desc->length = be32_to_cpu(LPFC_UVEM_VE_MAP_DESC_SIZE);
+	memcpy(inst_desc->global_vem_id, vmid->host_vmid,
+	       LPFC_COMPRESS_VMID_SIZE);
+
+	bf_set(lpfc_instantiated_nport_id, inst_desc, vport->fc_myDID);
+	bf_set(lpfc_instantiated_local_id, inst_desc,
+	       vmid->un.cs_ctl_vmid);
+	if (instantiated) {
+		inst_desc->tag = be32_to_cpu(INSTANTIATED_VE_DESC_TAG);
+	} else {
+		inst_desc->tag = be32_to_cpu(DEINSTANTIATED_VE_DESC_TAG);
+		lpfc_vmid_put_cs_ctl(vport, vmid->un.cs_ctl_vmid);
+	}
+	inst_desc->word6 = cpu_to_be32(inst_desc->word6);
+
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_uvem;
+	ret = lpfc_sli_issue_iocb(vport->phba, LPFC_ELS_RING, elsiocb, 0);
+	if (ret != IOCB_SUCCESS) {
+		lpfc_els_free_iocb(vport->phba, elsiocb);
+		goto out;
+	}
+
+	return 0;
+ out:
+	kfree(vmid_context);
+	return 1;
+}
+
+static void
+lpfc_cmpl_els_uvem(struct lpfc_hba *phba, struct lpfc_iocbq *icmdiocb,
+		   struct lpfc_iocbq *rspiocb)
+{
+	struct lpfc_vport *vport = icmdiocb->vport;
+	struct lpfc_dmabuf *prsp = NULL;
+	struct lpfc_vmid_context *vmid_context =
+	    icmdiocb->vmid_tag.vmid_context;
+	struct lpfc_nodelist *ndlp = icmdiocb->context1;
+	u8 *pcmd;
+	u32 *data;
+	IOCB_t *irsp = &rspiocb->iocb;
+	struct lpfc_dmabuf *dmabuf = icmdiocb->context2;
+	struct lpfc_vmid *vmid;
+
+	vmid = vmid_context->vmp;
+	if (ndlp && !NLP_CHK_NODE_ACT(ndlp))
+		ndlp = NULL;
+
+	prsp = list_get_first(&dmabuf->list, struct lpfc_dmabuf, list);
+	if (!prsp)
+		goto out;
+	pcmd = prsp->virt;
+	data = (u32 *)pcmd;
+	if (*((u32 *)(pcmd)) == ELS_CMD_LS_RJT) {
+		lpfc_printf_vlog(vport, KERN_WARNING, LOG_SLI,
+				 "4532 UVEM LS_RJT %x %x ", data[0], data[1]);
+		goto out;
+	}
+	if (irsp->ulpStatus) {
+		lpfc_printf_vlog(vport, KERN_WARNING, LOG_SLI,
+				 "4533 UVEM error status %x: %x ",
+				 irsp->ulpStatus, irsp->un.ulpWord[4]);
+		goto out;
+	}
+	spin_lock(&phba->hbalock);
+	/* Set IN USE flag */
+	vport->vmid_flag |= LPFC_VMID_IN_USE;
+	phba->pport->vmid_flag |= LPFC_VMID_IN_USE;
+	spin_unlock(&phba->hbalock);
+
+	if (vmid_context->instantiated) {
+		vmid->flag |= LPFC_VMID_REGISTERED;
+		vmid->flag &= ~LPFC_VMID_REQ_REGISTER;
+	}
+
+ out:
+	kfree(vmid_context);
+	lpfc_els_free_iocb(phba, icmdiocb);
+}
-- 
2.26.2


--000000000000832a5105b3aab71a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCC8L2pemVf2eTR+L4Me0mmxvRH/vvA+ABThJDzXCLtTWjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMDkxMTE4MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACM4k1qqpJbV68K1L
9KvWDe9hsT5WR85NjcgFNZruLAR4ahrUFv6p0gofsDRibzinf880AK7ivYF+VaJJj3eJSnyufxNh
gXP6fiAn06IuEc0QXlAYLo68OXG9Qb6DeO6zyU6l/EF9/GaK5N5OSV0IB9l0Tbnqs/PeFOEeSuL7
uYbOdFqPUqZ5hdXxBQGfXbdhRfp52S3PBTpdvlQKj1dPvUubkTzf5vwYNnQm42kkX0Gqv7con3Ca
umd7/P7GIMuS7jW/4bMo5HnqFhURLf5ldqxbtdSvY93QG/cFAr24WzmzPSc8J3yKnICYzCBuJaev
L1JesTbRjKfXTovYLNLTcw==
--000000000000832a5105b3aab71a--
