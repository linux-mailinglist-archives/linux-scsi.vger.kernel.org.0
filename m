Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65315816A
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2020 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgBJRcM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Feb 2020 12:32:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41015 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJRcM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 10 Feb 2020 12:32:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so8842900wrw.8
        for <linux-scsi@vger.kernel.org>; Mon, 10 Feb 2020 09:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1TLNBj/nSBTlmciV5KeMxp+ocYjj8HwyOsHk37calEs=;
        b=TDnKN9uEQNynI1ZltrS8dQZi+OOkGBzzGhpkHRERoZjG3wEVRaQWwGD3DeuxW1vGjd
         5WwTBj0Dj/QGndgIh5HTIlhxrmU3rABBBH/hqKXuKu10jnyVD1P4mEg1XddkXdDseA/M
         ynQyLefn98V/L/1biGJuFzcrN5qIepqRU+Oz7hQIwUgZbYaZfGhDHRC3oBYJazvFEOZf
         5c/PkzRIQEyXFH30QSCCfyup7PHaHabEsX1vGViirLPWOyYWRWCA5/IvOmezxRJJZURE
         4P13IQh1WUSdJBAS7Jor7CS24yf1FCYqTx0TYqAFw7hc9ZFFkIs1bK4S7TyKOPrBKnFX
         BM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1TLNBj/nSBTlmciV5KeMxp+ocYjj8HwyOsHk37calEs=;
        b=n7ICuyYPmhvsbWCktyYc0rUhcP7KtMGBH4P7kY7OXb0KuYzBR33lcCc3h19k9a9Eld
         2n5vXF24sJFgoG+a/U0tkhnxb3ZPwvy/vQorH9SfrJd1yJY6HsiN2PreCU3Vdw2ujYYl
         us2BRSpL1hdT6z5uP24sMsWaBPaa0L/HG0x8T/fcItvT8dan+xz7JOiYadmojqFUQ/Lz
         vIO9Fiu8JCLET8PUMjCdop2SGDKVpxi35BCkfEZKBNlSLUbNSUYxY+kDTeDSa0gDbLh2
         eLRIK4ShrxRwo8mnoMhBqsJQCncD9XuRrS/aUltceTZA9qBlN4efz11O9YMgQD4zHYLC
         4Inw==
X-Gm-Message-State: APjAAAWLi6Lf0BLLf49Cu4waHKBCfKJ1Etoyx+WXIW01O6JBSOHmQUOq
        mHwdvvJGLYncRFRVb8DHQMqev5kM
X-Google-Smtp-Source: APXvYqx6uDjGXoO62iX8vZrDVcdgy7lquS8QAn1IvYWOT3PYK3kAHZWNuCzmfAi0+qbypnkIkgVksw==
X-Received: by 2002:adf:8b59:: with SMTP id v25mr3151297wra.419.1581355929489;
        Mon, 10 Feb 2020 09:32:09 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k10sm1402135wrd.68.2020.02.10.09.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 09:32:08 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH v2 2/2] lpfc: add RDF registration and Link Integrity FPIN logging
Date:   Mon, 10 Feb 2020 09:31:55 -0800
Message-Id: <20200210173155.547-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200210173155.547-1-jsmart2021@gmail.com>
References: <20200210173155.547-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch modifies lpfc to register for Link Integrity events via the
use of an RDF ELS and to perform Link Integrity FPIN logging.

Specifically, the driver was modified to:
- Format and issue the RDF ELS immediately following SCR registration.
  This registers the ability of the driver to receive FPIN ELS.
- Adds decoding of the FPIN els into the received descriptors, with
  logging of the Link Integrity event information. After decoding,
  the ELS is delivered to the scsi fc transport to be delivered to
  any user-space applications.
- To aid in logging, simple helpers were added to create enum to name
  string lookup functions that utilize the initialization helpers from
  the fc_els.h header.
- Note: base header definitions for the ELS's don't populate the
  descriptor payloads. As such, lpfc creates it's own version of the
  structures, using the base definitions (mostly headers) and additionally
  declaring the descriptors that will complete the population of the
  ELS.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v2:
  Slight spacing mod
  Reference reg_d1.desc_tags rather than reg_d1.reg_desc.desc_tags. The
    latter is an empty array, and the former is the backing for that
    array. Should be better for code checkers that are comparing against
    array bounds
---
 drivers/scsi/lpfc/lpfc.h         |  29 ++++
 drivers/scsi/lpfc/lpfc_crtn.h    |   3 +-
 drivers/scsi/lpfc/lpfc_els.c     | 324 ++++++++++++++++++++++++++++++++++++---
 drivers/scsi/lpfc/lpfc_hbadisc.c |   4 +-
 drivers/scsi/lpfc/lpfc_hw.h      |   4 +-
 drivers/scsi/lpfc/lpfc_hw4.h     |  19 +++
 drivers/scsi/lpfc/lpfc_sli.c     |   1 +
 7 files changed, 361 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 6abc837b9a33..357fdec06bae 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -1353,3 +1353,32 @@ lpfc_sli4_mod_hba_eq_delay(struct lpfc_hba *phba, struct lpfc_queue *eq,
 	writel(reg_data.word0, phba->sli4_hba.u.if_type2.EQDregaddr);
 	eq->q_mode = delay;
 }
+
+
+/*
+ * Macro that declares tables and a routine to perform enum type to
+ * ascii string lookup.
+ *
+ * Defines a <key,value> table for an enum. Uses xxx_INIT defines for
+ * the enum to populate the table.  Macro defines a routine (named
+ * by caller) that will search all elements of the table for the key
+ * and return the name string if found or "Unrecognized" if not found.
+ */
+#define DECLARE_ENUM2STR_LOOKUP(routine, enum_name, enum_init)		\
+static struct {								\
+	enum enum_name		value;					\
+	char			*name;					\
+} fc_##enum_name##_e2str_names[] = enum_init;				\
+static const char *routine(enum enum_name table_key)			\
+{									\
+	int i;								\
+	char *name = "Unrecognized";					\
+									\
+	for (i = 0; i < ARRAY_SIZE(fc_##enum_name##_e2str_names); i++) {\
+		if (fc_##enum_name##_e2str_names[i].value == table_key) {\
+			name = fc_##enum_name##_e2str_names[i].name;	\
+			break;						\
+		}							\
+	}								\
+	return name;							\
+}
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 25d3dd39bc05..a450477a7e00 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -140,9 +140,10 @@ int lpfc_issue_els_prli(struct lpfc_vport *, struct lpfc_nodelist *, uint8_t);
 int lpfc_issue_els_adisc(struct lpfc_vport *, struct lpfc_nodelist *, uint8_t);
 int lpfc_issue_els_logo(struct lpfc_vport *, struct lpfc_nodelist *, uint8_t);
 int lpfc_issue_els_npiv_logo(struct lpfc_vport *, struct lpfc_nodelist *);
-int lpfc_issue_els_scr(struct lpfc_vport *, uint32_t, uint8_t);
+int lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_issue_els_rscn(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_issue_fabric_reglogin(struct lpfc_vport *);
+int lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry);
 int lpfc_els_free_iocb(struct lpfc_hba *, struct lpfc_iocbq *);
 int lpfc_ct_free_iocb(struct lpfc_hba *, struct lpfc_iocbq *);
 int lpfc_els_rsp_acc(struct lpfc_vport *, uint32_t, struct lpfc_iocbq *,
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 8a38e6f7f853..a712f15bc88c 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -3008,10 +3008,9 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
  * This routine is a generic completion callback function for ELS commands.
  * Specifically, it is the callback function which does not need to perform
  * any command specific operations. It is currently used by the ELS command
- * issuing routines for the ELS State Change  Request (SCR),
- * lpfc_issue_els_scr(), and the ELS Fibre Channel Address Resolution
- * Protocol Response (FARPR) routine, lpfc_issue_els_farpr(). Other than
- * certain debug loggings, this callback function simply invokes the
+ * issuing routines for RSCN, lpfc_issue_els_rscn, and the ELS Fibre Channel
+ * Address Resolution Protocol Response (FARPR) routine, lpfc_issue_els_farpr().
+ * Other than certain debug loggings, this callback function simply invokes the
  * lpfc_els_chk_latt() routine to check whether link went down during the
  * discovery process.
  **/
@@ -3025,14 +3024,117 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	irsp = &rspiocb->iocb;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "ELS cmd cmpl:    status:x%x/x%x did:x%x",
+			      irsp->ulpStatus, irsp->un.ulpWord[4],
+			      irsp->un.elsreq64.remoteID);
+
+	/* ELS cmd tag <ulpIoTag> completes */
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+			 "0106 ELS cmd tag x%x completes Data: x%x x%x x%x\n",
+			 irsp->ulpIoTag, irsp->ulpStatus,
+			 irsp->un.ulpWord[4], irsp->ulpTimeout);
+
+	/* Check to see if link went down during discovery */
+	lpfc_els_chk_latt(vport);
+	lpfc_els_free_iocb(phba, cmdiocb);
+}
+
+/**
+ * lpfc_cmpl_els_disc_cmd - Completion callback function for Discovery ELS cmd
+ * @phba: pointer to lpfc hba data structure.
+ * @cmdiocb: pointer to lpfc command iocb data structure.
+ * @rspiocb: pointer to lpfc response iocb data structure.
+ *
+ * This routine is a generic completion callback function for Discovery ELS cmd.
+ * Currently used by the ELS command issuing routines for the ELS State Change
+ * Request (SCR), lpfc_issue_els_scr() and the ELS RDF, lpfc_issue_els_rdf().
+ * These commands will be retried once only for ELS timeout errors.
+ **/
+static void
+lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		       struct lpfc_iocbq *rspiocb)
+{
+	struct lpfc_vport *vport = cmdiocb->vport;
+	IOCB_t *irsp;
+	struct lpfc_els_rdf_rsp *prdf;
+	struct lpfc_dmabuf *pcmd, *prsp;
+	u32 *pdata;
+	u32 cmd;
+
+	irsp = &rspiocb->iocb;
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
 		"ELS cmd cmpl:    status:x%x/x%x did:x%x",
 		irsp->ulpStatus, irsp->un.ulpWord[4],
 		irsp->un.elsreq64.remoteID);
 	/* ELS cmd tag <ulpIoTag> completes */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0106 ELS cmd tag x%x completes Data: x%x x%x x%x\n",
+			 "0217 ELS cmd tag x%x completes Data: x%x x%x x%x "
+			 "x%x\n",
 			 irsp->ulpIoTag, irsp->ulpStatus,
-			 irsp->un.ulpWord[4], irsp->ulpTimeout);
+			 irsp->un.ulpWord[4], irsp->ulpTimeout,
+			 cmdiocb->retry);
+
+	pcmd = (struct lpfc_dmabuf *)cmdiocb->context2;
+	if (!pcmd)
+		goto out;
+
+	pdata = (u32 *)pcmd->virt;
+	if (!pdata)
+		goto out;
+	cmd = *pdata;
+
+	/* Only 1 retry for ELS Timeout only */
+	if (irsp->ulpStatus == IOSTAT_LOCAL_REJECT &&
+	    ((irsp->un.ulpWord[4] & IOERR_PARAM_MASK) ==
+	    IOERR_SEQUENCE_TIMEOUT)) {
+		cmdiocb->retry++;
+		if (cmdiocb->retry <= 1) {
+			switch (cmd) {
+			case ELS_CMD_SCR:
+				lpfc_issue_els_scr(vport, cmdiocb->retry);
+				break;
+			case ELS_CMD_RDF:
+				cmdiocb->context1 = NULL; /* save ndlp refcnt */
+				lpfc_issue_els_rdf(vport, cmdiocb->retry);
+				break;
+			}
+			goto out;
+		}
+		phba->fc_stat.elsRetryExceeded++;
+	}
+	if (irsp->ulpStatus) {
+		/* ELS discovery cmd completes with error */
+		lpfc_printf_vlog(vport, KERN_WARNING, LOG_ELS,
+				 "4203 ELS cmd x%x error: x%x x%X\n", cmd,
+				 irsp->ulpStatus, irsp->un.ulpWord[4]);
+		goto out;
+	}
+
+	/* The RDF response doesn't have any impact on the running driver
+	 * but the notification descriptors are dumped here for support.
+	 */
+	if (cmd == ELS_CMD_RDF) {
+		int i;
+
+		prsp = list_get_first(&pcmd->list, struct lpfc_dmabuf, list);
+		if (!prsp)
+			goto out;
+
+		prdf = (struct lpfc_els_rdf_rsp *)prsp->virt;
+		if (!prdf)
+			goto out;
+
+		for (i = 0; i < ELS_RDF_REG_TAG_CNT &&
+			    i < be32_to_cpu(prdf->reg_d1.reg_desc.count); i++)
+			lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+				 "4677 Fabric RDF Notication Grant Data: "
+				 "0x%08x\n",
+				 be32_to_cpu(
+					prdf->reg_d1.desc_tags[i]));
+	}
+
+out:
 	/* Check to see if link went down during discovery */
 	lpfc_els_chk_latt(vport);
 	lpfc_els_free_iocb(phba, cmdiocb);
@@ -3042,11 +3144,10 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 /**
  * lpfc_issue_els_scr - Issue a scr to an node on a vport
  * @vport: pointer to a host virtual N_Port data structure.
- * @nportid: N_Port identifier to the remote node.
- * @retry: number of retries to the command IOCB.
+ * @retry: retry counter for the command IOCB.
  *
  * This routine issues a State Change Request (SCR) to a fabric node
- * on a @vport. The remote node @nportid is passed into the function. It
+ * on a @vport. The remote node is Fabric Controller (0xfffffd). It
  * first search the @vport node list to find the matching ndlp. If no such
  * ndlp is found, a new ndlp shall be created for this (SCR) purpose. An
  * IOCB is allocated, payload prepared, and the lpfc_sli_issue_iocb()
@@ -3062,7 +3163,7 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
  *   1 - Failed to issue scr command
  **/
 int
-lpfc_issue_els_scr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
+lpfc_issue_els_scr(struct lpfc_vport *vport, uint8_t retry)
 {
 	struct lpfc_hba  *phba = vport->phba;
 	struct lpfc_iocbq *elsiocb;
@@ -3072,9 +3173,9 @@ lpfc_issue_els_scr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
 
 	cmdsize = (sizeof(uint32_t) + sizeof(SCR));
 
-	ndlp = lpfc_findnode_did(vport, nportid);
+	ndlp = lpfc_findnode_did(vport, Fabric_Cntl_DID);
 	if (!ndlp) {
-		ndlp = lpfc_nlp_init(vport, nportid);
+		ndlp = lpfc_nlp_init(vport, Fabric_Cntl_DID);
 		if (!ndlp)
 			return 1;
 		lpfc_enqueue_node(vport, ndlp);
@@ -3109,7 +3210,7 @@ lpfc_issue_els_scr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
 		ndlp->nlp_DID, 0, 0);
 
 	phba->fc_stat.elsXmitSCR++;
-	elsiocb->iocb_cmpl = lpfc_cmpl_els_cmd;
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_disc_cmd;
 	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
 	    IOCB_ERROR) {
 		/* The additional lpfc_nlp_put will cause the following
@@ -3339,6 +3440,102 @@ lpfc_issue_els_farpr(struct lpfc_vport *vport, uint32_t nportid, uint8_t retry)
 	/* This will cause the callback-function lpfc_cmpl_els_cmd to
 	 * trigger the release of the node.
 	 */
+	/* Don't release reference count as RDF is likely outstanding */
+	return 0;
+}
+
+/**
+ * lpfc_issue_els_rdf - Register for diagnostic functions from the fabric.
+ * @vport: pointer to a host virtual N_Port data structure.
+ * @retry: retry counter for the command IOCB.
+ *
+ * This routine issues an ELS RDF to the Fabric Controller to register
+ * for diagnostic functions.
+ *
+ * Note that, in lpfc_prep_els_iocb() routine, the reference count of ndlp
+ * will be incremented by 1 for holding the ndlp and the reference to ndlp
+ * will be stored into the context1 field of the IOCB for the completion
+ * callback function to the RDF ELS command.
+ *
+ * Return code
+ *   0 - Successfully issued rdf command
+ *   1 - Failed to issue rdf command
+ **/
+int
+lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry)
+{
+	struct lpfc_hba *phba = vport->phba;
+	struct lpfc_iocbq *elsiocb;
+	struct lpfc_els_rdf_req *prdf;
+	struct lpfc_nodelist *ndlp;
+	uint16_t cmdsize;
+
+	cmdsize = sizeof(*prdf);
+
+	ndlp = lpfc_findnode_did(vport, Fabric_Cntl_DID);
+	if (!ndlp) {
+		ndlp = lpfc_nlp_init(vport, Fabric_Cntl_DID);
+		if (!ndlp)
+			return -ENODEV;
+		lpfc_enqueue_node(vport, ndlp);
+	} else if (!NLP_CHK_NODE_ACT(ndlp)) {
+		ndlp = lpfc_enable_node(vport, ndlp, NLP_STE_UNUSED_NODE);
+		if (!ndlp)
+			return -ENODEV;
+	}
+
+	/* RDF ELS is not required on an NPIV VN_Port.  */
+	if (vport->port_type == LPFC_NPIV_PORT) {
+		lpfc_nlp_put(ndlp);
+		return -EACCES;
+	}
+
+	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
+				     ndlp->nlp_DID, ELS_CMD_RDF);
+	if (!elsiocb) {
+		/* This will trigger the release of the node just
+		 * allocated
+		 */
+		lpfc_nlp_put(ndlp);
+		return -ENOMEM;
+	}
+
+	/* Configure the payload for the supported FPIN events. */
+	prdf = (struct lpfc_els_rdf_req *)
+		(((struct lpfc_dmabuf *)elsiocb->context2)->virt);
+	memset(prdf, 0, cmdsize);
+	prdf->rdf.fpin_cmd = ELS_RDF;
+	prdf->rdf.desc_len = cpu_to_be32(sizeof(struct lpfc_els_rdf_req) -
+					 sizeof(struct fc_els_rdf));
+	prdf->reg_d1.reg_desc.desc_tag = cpu_to_be32(ELS_DTAG_FPIN_REGISTER);
+	prdf->reg_d1.reg_desc.desc_len = cpu_to_be32(
+				FC_TLV_DESC_LENGTH_FROM_SZ(prdf->reg_d1));
+	prdf->reg_d1.reg_desc.count = cpu_to_be32(ELS_RDF_REG_TAG_CNT);
+	prdf->reg_d1.desc_tags[0] = cpu_to_be32(ELS_DTAG_LNK_INTEGRITY);
+
+	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
+			      "Issue RDF:       did:x%x",
+			      ndlp->nlp_DID, 0, 0);
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+			 "6444 Xmit RDF to remote NPORT x%x\n",
+			 ndlp->nlp_DID);
+
+	elsiocb->iocb_cmpl = lpfc_cmpl_els_disc_cmd;
+	if (lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0) ==
+	    IOCB_ERROR) {
+		/* The additional lpfc_nlp_put will cause the following
+		 * lpfc_els_free_iocb routine to trigger the rlease of
+		 * the node.
+		 */
+		lpfc_nlp_put(ndlp);
+		lpfc_els_free_iocb(phba, elsiocb);
+		return -EIO;
+	}
+
+	/* An RDF was issued - this put ensures the ndlp is cleaned up
+	 * when the RDF completes.
+	 */
 	lpfc_nlp_put(ndlp);
 	return 0;
 }
@@ -8137,6 +8334,90 @@ lpfc_send_els_event(struct lpfc_vport *vport,
 }
 
 
+DECLARE_ENUM2STR_LOOKUP(lpfc_get_tlv_dtag_nm, fc_ls_tlv_dtag,
+			FC_LS_TLV_DTAG_INIT);
+
+DECLARE_ENUM2STR_LOOKUP(lpfc_get_fpin_li_event_nm, fc_fpin_li_event_types,
+			FC_FPIN_LI_EVT_TYPES_INIT);
+
+/**
+ * lpfc_els_rcv_fpin_li - Process an FPIN Link Integrity Event.
+ * @vport: Pointer to vport object.
+ * @lnk_not:  Pointer to the Link Integrity Notification Descriptor.
+ *
+ * This function processes a link integrity FPIN event by
+ * logging a message
+ **/
+static void
+lpfc_els_rcv_fpin_li(struct lpfc_vport *vport, struct fc_tlv_desc *tlv)
+{
+	struct fc_fn_li_desc *li = (struct fc_fn_li_desc *)tlv;
+	const char *li_evt_str;
+	u32 li_evt;
+
+	li_evt = be16_to_cpu(li->event_type);
+	li_evt_str = lpfc_get_fpin_li_event_nm(li_evt);
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+			 "4680 FPIN Link Integrity %s (x%x) "
+			 "Detecting PN x%016llx Attached PN x%016llx "
+			 "Duration %d mSecs Count %d Port Cnt %d\n",
+			 li_evt_str, li_evt,
+			 be64_to_cpu(li->detecting_wwpn),
+			 be64_to_cpu(li->attached_wwpn),
+			 be32_to_cpu(li->event_threshold),
+			 be32_to_cpu(li->event_count),
+			 be32_to_cpu(li->pname_count));
+}
+
+static void
+lpfc_els_rcv_fpin(struct lpfc_vport *vport, struct fc_els_fpin *fpin,
+		  u32 fpin_length)
+{
+	struct fc_tlv_desc *tlv;
+	const char *dtag_nm;
+	uint32_t desc_cnt = 0, bytes_remain;
+	u32 dtag;
+
+	/* FPINs handled only if we are in the right discovery state */
+	if (vport->port_state < LPFC_DISC_AUTH)
+		return;
+
+	/* make sure there is the full fpin header */
+	if (fpin_length < sizeof(struct fc_els_fpin))
+		return;
+
+	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
+	bytes_remain = fpin_length - offsetof(struct fc_els_fpin, fpin_desc);
+	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
+
+	/* process each descriptor */
+	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
+	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
+
+		dtag = be32_to_cpu(tlv->desc_tag);
+		switch (dtag) {
+		case ELS_DTAG_LNK_INTEGRITY:
+			lpfc_els_rcv_fpin_li(vport, tlv);
+			break;
+		default:
+			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_ELS,
+					 "4678  skipped FPIN descriptor[%d]: "
+					 "tag x%x (%s)\n",
+					 desc_cnt, dtag, dtag_nm);
+			break;
+		}
+
+		desc_cnt++;
+		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
+		tlv = fc_tlv_next_desc(tlv);
+	}
+
+	fc_host_fpin_rcv(lpfc_shost_from_vport(vport), fpin_length,
+			 (char *)fpin);
+}
+
 /**
  * lpfc_els_unsol_buffer - Process an unsolicited event data buffer
  * @phba: pointer to lpfc hba data structure.
@@ -8158,7 +8439,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	struct Scsi_Host  *shost;
 	struct lpfc_nodelist *ndlp;
 	struct ls_rjt stat;
-	uint32_t *payload;
+	uint32_t *payload, payload_len;
 	uint32_t cmd, did, newnode;
 	uint8_t rjt_exp, rjt_err = 0, init_link = 0;
 	IOCB_t *icmd = &elsiocb->iocb;
@@ -8169,6 +8450,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	newnode = 0;
 	payload = ((struct lpfc_dmabuf *)elsiocb->context2)->virt;
+	payload_len = elsiocb->iocb.unsli3.rcvsli3.acc_len;
 	cmd = *payload;
 	if ((phba->sli3_options & LPFC_SLI3_HBQ_ENABLED) == 0)
 		lpfc_post_buffer(phba, pring, 1);
@@ -8514,12 +8796,14 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		rjt_exp = LSEXP_INVALID_OX_RX;
 		break;
 	case ELS_CMD_FPIN:
-		/*
-		 * Received FPIN from fabric - pass it to the
-		 * transport FPIN handler.
-		 */
-		fc_host_fpin_rcv(shost, elsiocb->iocb.unsli3.rcvsli3.acc_len,
-				(char *)payload);
+		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
+				      "RCV FPIN:       did:x%x/ste:x%x flg:x%x",
+				      did, vport->port_state, ndlp->nlp_flag);
+
+		lpfc_els_rcv_fpin(vport, (struct fc_els_fpin *)payload,
+				  payload_len);
+
+		/* There are no replies, so no rjt codes */
 		break;
 	default:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index e8937071c748..789eecbf32eb 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -4089,7 +4089,9 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				    FC_TYPE_NVME);
 
 		/* Issue SCR just before NameServer GID_FT Query */
-		lpfc_issue_els_scr(vport, SCR_DID, 0);
+		lpfc_issue_els_scr(vport, 0);
+
+		lpfc_issue_els_rdf(vport, 0);
 	}
 
 	vport->fc_ns_retry = 0;
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index 68f62ae6ef4f..ae51c0dbba0a 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -22,7 +22,7 @@
 
 #define FDMI_DID        0xfffffaU
 #define NameServer_DID  0xfffffcU
-#define SCR_DID         0xfffffdU
+#define Fabric_Cntl_DID 0xfffffdU
 #define Fabric_DID      0xfffffeU
 #define Bcast_DID       0xffffffU
 #define Mask_DID        0xffffffU
@@ -588,6 +588,7 @@ struct fc_vft_header {
 #define ELS_CMD_RRQ       0x12000000
 #define ELS_CMD_REC       0x13000000
 #define ELS_CMD_RDP       0x18000000
+#define ELS_CMD_RDF       0x19000000
 #define ELS_CMD_PRLI      0x20100014
 #define ELS_CMD_NVMEPRLI  0x20140018
 #define ELS_CMD_PRLO      0x21100014
@@ -629,6 +630,7 @@ struct fc_vft_header {
 #define ELS_CMD_RRQ       0x12
 #define ELS_CMD_REC       0x13
 #define ELS_CMD_RDP	  0x18
+#define ELS_CMD_RDF	  0x19
 #define ELS_CMD_PRLI      0x14001020
 #define ELS_CMD_NVMEPRLI  0x18001420
 #define ELS_CMD_PRLO      0x14001021
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index 9a064b96e570..10c5d1c3122e 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -20,6 +20,8 @@
  * included with this package.                                     *
  *******************************************************************/
 
+#include <uapi/scsi/fc/fc_els.h>
+
 /* Macros to deal with bit fields. Each bit field must have 3 #defines
  * associated with it (_SHIFT, _MASK, and _WORD).
  * EG. For a bit field that is in the 7th bit of the "field4" field of a
@@ -4795,6 +4797,23 @@ struct send_frame_wqe {
 	uint32_t fc_hdr_wd5;           /* word 15 */
 };
 
+#define ELS_RDF_REG_TAG_CNT		1
+struct lpfc_els_rdf_reg_desc {
+	struct fc_df_desc_fpin_reg	reg_desc;	/* descriptor header */
+	__be32				desc_tags[ELS_RDF_REG_TAG_CNT];
+							/* tags in reg_desc */
+};
+
+struct lpfc_els_rdf_req {
+	struct fc_els_rdf		rdf;	   /* hdr up to descriptors */
+	struct lpfc_els_rdf_reg_desc	reg_d1;	/* 1st descriptor */
+};
+
+struct lpfc_els_rdf_rsp {
+	struct fc_els_rdf_resp		rdf_resp;  /* hdr up to descriptors */
+	struct lpfc_els_rdf_reg_desc	reg_d1;	/* 1st descriptor */
+};
+
 union lpfc_wqe {
 	uint32_t words[16];
 	struct lpfc_wqe_generic generic;
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 86ac10ecd65a..0b26b5c0527e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -9459,6 +9459,7 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 		if (if_type >= LPFC_SLI_INTF_IF_TYPE_2) {
 			if (pcmd && (*pcmd == ELS_CMD_FLOGI ||
 				*pcmd == ELS_CMD_SCR ||
+				*pcmd == ELS_CMD_RDF ||
 				*pcmd == ELS_CMD_RSCN_XMT ||
 				*pcmd == ELS_CMD_FDISC ||
 				*pcmd == ELS_CMD_LOGO ||
-- 
2.13.7

