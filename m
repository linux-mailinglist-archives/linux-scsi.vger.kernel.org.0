Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC80035639D
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Apr 2021 07:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbhDGF7g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Apr 2021 01:59:36 -0400
Received: from saphodev.broadcom.com ([192.19.232.172]:39354 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345324AbhDGF7a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Apr 2021 01:59:30 -0400
Received: from localhost.localdomain (unknown [10.157.2.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 23B2D24325;
        Tue,  6 Apr 2021 22:59:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 23B2D24325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1617775161;
        bh=mlRW8y4x8AjOlOB3v4n5V3PJtBsay1O/xPoS8bavMUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ov1QHWYupKDX48BbkykQvDBBXX1LTWp7WXUiwShqbWGShQhApWcsdluFC1zX7urTm
         vJwgTtPhVpkgz17AUFjRPCUwAD8tR8kdeaCMAXELBKt/mUmOYZxpzPXNuolEfpsDmB
         eJ5U3wbB02M8LQ2koHXTQCrY/wR6beXbopUPdV68=
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org, hare@suse.de
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v9 09/13] lpfc: vmid: Implements CT commands for appid.
Date:   Wed,  7 Apr 2021 04:36:33 +0530
Message-Id: <1617750397-26466-10-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

The patch implements CT commands for registering and deregistering the
appid for the application. Also, a small change in decrementing the ndlp
ref counter has been added.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v9:
Added Changes related to locking and new hashtable implementation

v8:
modified log messages and fixed the refcount

v7:
No Change

v6:
Added Forward declarations and functions to static

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
Removed redundant code due to changes since last submit
---
 drivers/scsi/lpfc/lpfc_ct.c | 257 +++++++++++++++++++++++++++++++++++-
 1 file changed, 256 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 37b0c2024998..3cac3563f3f9 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -1,7 +1,7 @@
 /*******************************************************************
  * This file is part of the Emulex Linux Device Driver for         *
  * Fibre Channel Host Bus Adapters.                                *
- * Copyright (C) 2017-2020 Broadcom. All Rights Reserved. The term *
+ * Copyright (C) 2017-2021 Broadcom. All Rights Reserved. The term *
  * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.     *
  * Copyright (C) 2004-2016 Emulex.  All rights reserved.           *
  * EMULEX and SLI are trademarks of Emulex.                        *
@@ -75,6 +75,9 @@
 
 
 static char *lpfc_release_version = LPFC_DRIVER_VERSION;
+static void
+lpfc_cmpl_ct_cmd_vmid(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		      struct lpfc_iocbq *rspiocb);
 
 static void
 lpfc_ct_ignore_hbq_buffer(struct lpfc_hba *phba, struct lpfc_iocbq *piocbq,
@@ -3744,3 +3747,255 @@ lpfc_decode_firmware_rev(struct lpfc_hba *phba, char *fwrevision, int flag)
 	}
 	return;
 }
+
+static void
+lpfc_cmpl_ct_cmd_vmid(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		      struct lpfc_iocbq *rspiocb)
+{
+	struct lpfc_vport *vport = cmdiocb->vport;
+	struct lpfc_dmabuf *inp = cmdiocb->context1;
+	struct lpfc_dmabuf *outp = cmdiocb->context2;
+	struct lpfc_sli_ct_request *ctcmd = inp->virt;
+	struct lpfc_sli_ct_request *ctrsp = outp->virt;
+	u16 rsp = ctrsp->CommandResponse.bits.CmdRsp;
+	struct app_id_object *app;
+	u32 cmd, hash, bucket;
+	struct lpfc_vmid *vmp, *cur;
+	u8 *data = outp->virt;
+	int i;
+
+	cmd = be16_to_cpu(ctcmd->CommandResponse.bits.CmdRsp);
+	if (cmd == SLI_CTAS_DALLAPP_ID)
+		lpfc_ct_free_iocb(phba, cmdiocb);
+
+	if (lpfc_els_chk_latt(vport) || rspiocb->iocb.ulpStatus) {
+		if (cmd != SLI_CTAS_DALLAPP_ID)
+			return;
+	}
+	/* Check for a CT LS_RJT response */
+	if (rsp == be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
+		if (cmd != SLI_CTAS_DALLAPP_ID)
+			lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+					 "3306 VMID FS_RJT Data: x%x x%x x%x\n",
+					 cmd, ctrsp->ReasonCode,
+					 ctrsp->Explanation);
+		if ((cmd != SLI_CTAS_DALLAPP_ID) ||
+		    (ctrsp->ReasonCode != SLI_CT_UNABLE_TO_PERFORM_REQ) ||
+		    (ctrsp->Explanation != SLI_CT_APP_ID_NOT_AVAILABLE)) {
+			/* If DALLAPP_ID failed retry later */
+			if (cmd == SLI_CTAS_DALLAPP_ID)
+				vport->load_flag |= FC_DEREGISTER_ALL_APP_ID;
+			return;
+		}
+	}
+
+	switch (cmd) {
+	case SLI_CTAS_RAPP_IDENT:
+		app = (struct app_id_object *)(RAPP_IDENT_OFFSET + data);
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "6712 RAPP_IDENT app id %d  port id x%x id "
+				 "len %d\n", be32_to_cpu(app->app_id),
+				 be32_to_cpu(app->port_id),
+				 app->obj.entity_id_len);
+
+		if (app->obj.entity_id_len == 0 || app->port_id == 0)
+			return;
+
+		hash = lpfc_vmid_hash_fn(app->obj.entity_id,
+					 app->obj.entity_id_len);
+		vmp = lpfc_get_vmid_from_hastable(vport, hash,
+						  app->obj.entity_id);
+		if (vmp) {
+			write_lock(&vport->vmid_lock);
+			vmp->un.app_id = be32_to_cpu(app->app_id);
+			vmp->flag |= LPFC_VMID_REGISTERED;
+			vmp->flag &= ~LPFC_VMID_REQ_REGISTER;
+			write_unlock(&vport->vmid_lock);
+			/* Set IN USE flag */
+			vport->vmid_flag |= LPFC_VMID_IN_USE;
+		} else {
+			lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+					 "6901 No entry found %s hash %d\n",
+					 app->obj.entity_id, hash);
+		}
+		break;
+	case SLI_CTAS_DAPP_IDENT:
+		app = (struct app_id_object *)(DAPP_IDENT_OFFSET + data);
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "6713 DAPP_IDENT app id %d  port id x%x\n",
+				 be32_to_cpu(app->app_id),
+				 be32_to_cpu(app->port_id));
+		break;
+	case SLI_CTAS_DALLAPP_ID:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "8856 Deregistered all app ids\n");
+		read_lock(&vport->vmid_lock);
+		for (i = 0; i < phba->cfg_max_vmid; i++) {
+			vmp = &vport->vmid[i];
+			if (vmp->flag != LPFC_VMID_SLOT_FREE)
+				memset(vmp, 0, sizeof(struct lpfc_vmid));
+		}
+		read_unlock(&vport->vmid_lock);
+		/* for all elements in the hash table */
+		if (!hash_empty(vport->hash_table))
+			hash_for_each(vport->hash_table, bucket, cur, hnode)
+				hash_del(&cur->hnode);
+		vport->load_flag |= FC_ALLOW_VMID;
+		break;
+	default:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "8857 Invalid command code\n");
+	}
+}
+
+/**
+ * lpfc_vmid_cmd - Build and send a FDMI cmd to the specified NPort
+ * @vport: pointer to a host virtual N_Port data structure.
+ * @ndlp: ndlp to send FDMI cmd to (if NULL use FDMI_DID)
+ * cmdcode: FDMI command to send
+ * mask: Mask of HBA or PORT Attributes to send
+ *
+ * Builds and sends a FDMI command using the CT subsystem.
+ */
+int
+lpfc_vmid_cmd(struct lpfc_vport *vport,
+	      int cmdcode, struct lpfc_vmid *vmid)
+{
+	struct lpfc_hba *phba = vport->phba;
+	struct lpfc_dmabuf *mp, *bmp;
+	struct lpfc_sli_ct_request *ctreq;
+	struct ulp_bde64 *bpl;
+	u32 size;
+	u32 rsp_size;
+	u8 *data;
+	struct lpfc_vmid_rapp_ident_list *rap;
+	struct lpfc_vmid_dapp_ident_list *dap;
+	u8 retry = 0;
+	struct lpfc_nodelist *ndlp;
+
+	void (*cmpl)(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		     struct lpfc_iocbq *rspiocb);
+
+	ndlp = lpfc_findnode_did(vport, FDMI_DID);
+	if (!ndlp || ndlp->nlp_state != NLP_STE_UNMAPPED_NODE)
+		return 0;
+
+	cmpl = lpfc_cmpl_ct_cmd_vmid;
+
+	/* fill in BDEs for command */
+	/* Allocate buffer for command payload */
+	mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+	if (!mp)
+		goto vmid_free_mp_exit;
+
+	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
+	if (!mp->virt)
+		goto vmid_free_mp_virt_exit;
+
+	/* Allocate buffer for Buffer ptr list */
+	bmp = kmalloc(sizeof(*bmp), GFP_KERNEL);
+	if (!bmp)
+		goto vmid_free_bmp_exit;
+
+	bmp->virt = lpfc_mbuf_alloc(phba, 0, &bmp->phys);
+	if (!bmp->virt)
+		goto vmid_free_bmp_virt_exit;
+
+	INIT_LIST_HEAD(&mp->list);
+	INIT_LIST_HEAD(&bmp->list);
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
+			 "3275 VMID Request Data: x%x x%x x%x\n",
+			 vport->fc_flag, vport->port_state, cmdcode);
+	ctreq = (struct lpfc_sli_ct_request *)mp->virt;
+	data = mp->virt;
+	/* First populate the CT_IU preamble */
+	memset(data, 0, LPFC_BPL_SIZE);
+	ctreq->RevisionId.bits.Revision = SLI_CT_REVISION;
+	ctreq->RevisionId.bits.InId = 0;
+
+	ctreq->FsType = SLI_CT_MANAGEMENT_SERVICE;
+	ctreq->FsSubType = SLI_CT_APP_SEV_Subtypes;
+
+	ctreq->CommandResponse.bits.CmdRsp = cpu_to_be16(cmdcode);
+	rsp_size = LPFC_BPL_SIZE;
+	size = 0;
+
+	switch (cmdcode) {
+	case SLI_CTAS_RAPP_IDENT:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "1329 RAPP_IDENT for %s\n", vmid->host_vmid);
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		rap = (struct lpfc_vmid_rapp_ident_list *)
+			(DAPP_IDENT_OFFSET + data);
+		rap->no_of_objects = cpu_to_be32(1);
+		rap->obj[0].entity_id_len = vmid->vmid_len;
+		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
+		size = RAPP_IDENT_OFFSET +
+			sizeof(struct lpfc_vmid_rapp_ident_list);
+		retry = 1;
+		break;
+
+	case SLI_CTAS_GALLAPPIA_ID:
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		size = GALLAPPIA_ID_SIZE;
+		break;
+
+	case SLI_CTAS_DAPP_IDENT:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "1469 DAPP_IDENT for %s\n", vmid->host_vmid);
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		dap = (struct lpfc_vmid_dapp_ident_list *)
+			(DAPP_IDENT_OFFSET + data);
+		dap->no_of_objects = cpu_to_be32(1);
+		dap->obj[0].entity_id_len = vmid->vmid_len;
+		memcpy(dap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
+		size = DAPP_IDENT_OFFSET +
+			sizeof(struct lpfc_vmid_dapp_ident_list);
+		write_lock(&vport->vmid_lock);
+		vmid->flag &= ~LPFC_VMID_REGISTERED;
+		write_unlock(&vport->vmid_lock);
+		retry = 1;
+		break;
+
+	case SLI_CTAS_DALLAPP_ID:
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		size = DALLAPP_ID_SIZE;
+		break;
+
+	default:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "7062 VMID cmdcode x%x not supported\n",
+				 cmdcode);
+		goto vmid_free_all_mem;
+	}
+
+	ctreq->CommandResponse.bits.Size = cpu_to_be16(rsp_size);
+
+	bpl = (struct ulp_bde64 *)bmp->virt;
+	bpl->addrHigh = putPaddrHigh(mp->phys);
+	bpl->addrLow = putPaddrLow(mp->phys);
+	bpl->tus.f.bdeFlags = 0;
+	bpl->tus.f.bdeSize = size;
+
+	/* The lpfc_ct_cmd/lpfc_get_req shall increment ndlp reference count
+	 * to hold ndlp reference for the corresponding callback function.
+	 */
+	if (!lpfc_ct_cmd(vport, mp, bmp, ndlp, cmpl, rsp_size, retry))
+		return 0;
+
+ vmid_free_all_mem:
+	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
+ vmid_free_bmp_virt_exit:
+	kfree(bmp);
+ vmid_free_bmp_exit:
+	lpfc_mbuf_free(phba, mp->virt, mp->phys);
+ vmid_free_mp_virt_exit:
+	kfree(mp);
+ vmid_free_mp_exit:
+
+	/* Issue CT request failed */
+	lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+			 "3276 VMID CT request failed Data: x%x\n", cmdcode);
+	return -EIO;
+}
-- 
2.26.2

