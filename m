Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63363EAE66
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 04:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhHMCJU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Aug 2021 22:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhHMCJR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Aug 2021 22:09:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB33BC061756
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so18401554pji.5
        for <linux-scsi@vger.kernel.org>; Thu, 12 Aug 2021 19:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGKNdJ89ylg0AP+9Ko+8q/ExG+56dWz3dDRW6iBXN2M=;
        b=nBJWUuKUv3XB1icW6er8TKpQL+LXGWyFD6Cyq/pcx3gYW8o1829cDPiSrgUPERiOtr
         RbArzrNoZv/raEG4vcwfikW2SOzt4nIhODMbafSP5Dc7jPQQSkOyxcdT3pbvcMBWAzRs
         40Rq8OLuxAegaEEBinSrN3+Cdgeyk1n2cxFgnt/ZGaUtzY+THqpdeoiocDsK85XmNvQY
         eSuGlQVY7z15sVKLwH2O1qCKR7L6ELVsXeV6X3CoauCl8mbbx2qzTPoCZ7R4qVJV7tIh
         tiOwshs8ymKaeMqsFCybuInq8wtR6lZ0w5YTthfXXn3lVBgfKwjln2sMrc5oOgemRxk8
         b1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGKNdJ89ylg0AP+9Ko+8q/ExG+56dWz3dDRW6iBXN2M=;
        b=s3GZnfl8IR1HO0tv2tfim+8foTtvysO+G8K5HGjAVfYWsj0Jsxfj/eiWTWL8rONKgR
         aQ8VQvGCbQHd3aNxsI9nzBYdubh8Wqc7JcBtUNRL0V/1XTQnPUS+zFzvyQ91ckhkTptX
         znwuTwKi8rz85AQGrg7+RcvE9gPbCICFv/01XKH0aTLGcv63C1uhocECxarc0YJlpAto
         JQFB2qkB2NLYTlrhRfPyeF0br+VP/X3n80Wq7AVgIujdtL7GLaDkw9E01DbLbG3v/S4z
         dDjy2uy6JaHDLtofJIDchFTi9eAABsO2YtDM2C5rKLjd/yJZP/nQ3UvVPpyezrHKMCmN
         B+gQ==
X-Gm-Message-State: AOAM5339qe5ABuMce255lDt1jSPREDUxddmw8WnsuAldDmJvnbWXQYDC
        6tu9cZMuVlyUzDq8H5KZ6KP8Ne5Mm2k=
X-Google-Smtp-Source: ABdhPJyNBxzM/Tn89bD0HISq84kmU1ZYhRjIVHHFe3fSFBtIB4moFWa9RNHtsHnMPXY/Kyi+t0rTLw==
X-Received: by 2002:a62:ee11:0:b029:3e0:88dc:193f with SMTP id e17-20020a62ee110000b02903e088dc193fmr137233pfi.78.1628820531087;
        Thu, 12 Aug 2021 19:08:51 -0700 (PDT)
Received: from localhost.localdomain (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id ca7sm102619pjb.11.2021.08.12.19.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 19:08:50 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 04/16] lpfc: Expand FPIN and RDF receive logging
Date:   Thu, 12 Aug 2021 19:08:00 -0700
Message-Id: <20210813020812.99014-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813020812.99014-1-jsmart2021@gmail.com>
References: <20210813020812.99014-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Expand FPIN logging:
- Display Attached Port Names for Link Integrity and Peer Congestion
  events
- Log Delivery, Peer Congestion, and Congestion events
- Sanity check FPIN descriptor lengths when processing FPIN descriptors.

Log RDF events when congestion logging is enabled

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 349 +++++++++++++++++++++++++++++++----
 drivers/scsi/lpfc/lpfc_hw4.h |  14 ++
 2 files changed, 322 insertions(+), 41 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 08ae2b12b92c..097f132fc35b 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -3260,7 +3260,7 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		irsp->ulpStatus, irsp->un.ulpWord[4],
 		irsp->un.elsreq64.remoteID);
 	/* ELS cmd tag <ulpIoTag> completes */
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 			 "0217 ELS cmd tag x%x completes Data: x%x x%x x%x "
 			 "x%x\n",
 			 irsp->ulpIoTag, irsp->ulpStatus,
@@ -3319,11 +3319,12 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 		for (i = 0; i < ELS_RDF_REG_TAG_CNT &&
 			    i < be32_to_cpu(prdf->reg_d1.reg_desc.count); i++)
-			lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-				 "4677 Fabric RDF Notification Grant Data: "
-				 "0x%08x\n",
-				 be32_to_cpu(
-					prdf->reg_d1.desc_tags[i]));
+			lpfc_printf_vlog(vport, KERN_INFO,
+					 LOG_ELS | LOG_CGN_MGMT,
+					 "4677 Fabric RDF Notification Grant "
+					 "Data: 0x%08x\n",
+					 be32_to_cpu(
+						prdf->reg_d1.desc_tags[i]));
 	}
 
 out:
@@ -3689,7 +3690,7 @@ lpfc_issue_els_rdf(struct lpfc_vport *vport, uint8_t retry)
 	prdf->reg_d1.desc_tags[2] = cpu_to_be32(ELS_DTAG_PEER_CONGEST);
 	prdf->reg_d1.desc_tags[3] = cpu_to_be32(ELS_DTAG_CONGESTION);
 
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 			 "6444 Xmit RDF to remote NPORT x%x\n",
 			 ndlp->nlp_DID);
 
@@ -3733,7 +3734,7 @@ lpfc_els_rcv_rdf(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 {
 	/* Send LS_ACC */
 	if (lpfc_els_rsp_acc(vport, ELS_CMD_RDF, cmdiocb, ndlp, NULL)) {
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 				 "1623 Failed to RDF_ACC from x%x for x%x\n",
 				 ndlp->nlp_DID, vport->fc_myDID);
 		return -EIO;
@@ -3741,7 +3742,7 @@ lpfc_els_rcv_rdf(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 	/* Issue new RDF for reregistering */
 	if (lpfc_issue_els_rdf(vport, 0)) {
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_CGN_MGMT,
 				 "2623 Failed to re register RDF for x%x\n",
 				 vport->fc_myDID);
 		return -EIO;
@@ -8693,44 +8694,254 @@ DECLARE_ENUM2STR_LOOKUP(lpfc_get_tlv_dtag_nm, fc_ls_tlv_dtag,
 DECLARE_ENUM2STR_LOOKUP(lpfc_get_fpin_li_event_nm, fc_fpin_li_event_types,
 			FC_FPIN_LI_EVT_TYPES_INIT);
 
+DECLARE_ENUM2STR_LOOKUP(lpfc_get_fpin_deli_event_nm, fc_fpin_deli_event_types,
+			FC_FPIN_DELI_EVT_TYPES_INIT);
+
+DECLARE_ENUM2STR_LOOKUP(lpfc_get_fpin_congn_event_nm, fc_fpin_congn_event_types,
+			FC_FPIN_CONGN_EVT_TYPES_INIT);
+
+DECLARE_ENUM2STR_LOOKUP(lpfc_get_fpin_congn_severity_nm,
+			fc_fpin_congn_severity_types,
+			FC_FPIN_CONGN_SEVERITY_INIT);
+
+
+/**
+ * lpfc_display_fpin_wwpn - Display WWPNs accessible by the attached port
+ * @phba: Pointer to phba object.
+ * @wwnlist: Pointer to list of WWPNs in FPIN payload
+ * @cnt: count of WWPNs in FPIN payload
+ *
+ * This routine is called by LI and PC descriptors.
+ * Limit the number of WWPNs displayed to 6 log messages, 6 per log message
+ */
+static void
+lpfc_display_fpin_wwpn(struct lpfc_hba *phba, __be64 *wwnlist, u32 cnt)
+{
+	char buf[LPFC_FPIN_WWPN_LINE_SZ];
+	__be64 wwn;
+	u64 wwpn;
+	int i, len;
+	int line = 0;
+	int wcnt = 0;
+	bool endit = false;
+
+	len = scnprintf(buf, LPFC_FPIN_WWPN_LINE_SZ, "Accessible WWPNs:");
+	for (i = 0; i < cnt; i++) {
+		/* Are we on the last WWPN */
+		if (i == (cnt - 1))
+			endit = true;
+
+		/* Extract the next WWPN from the payload */
+		wwn = *wwnlist++;
+		wwpn = be64_to_cpu(wwn);
+		len += scnprintf(buf + len, LPFC_FPIN_WWPN_LINE_SZ,
+				 " %016llx", wwpn);
+
+		/* Log a message if we are on the last WWPN
+		 * or if we hit the max allowed per message.
+		 */
+		wcnt++;
+		if (wcnt == LPFC_FPIN_WWPN_LINE_CNT || endit) {
+			buf[len] = 0;
+			lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
+					"4686 %s\n", buf);
+
+			/* Check if we reached the last WWPN */
+			if (endit)
+				return;
+
+			/* Limit the number of log message displayed per FPIN */
+			line++;
+			if (line == LPFC_FPIN_WWPN_NUM_LINE) {
+				lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
+						"4687 %d WWPNs Truncated\n",
+						cnt - i - 1);
+				return;
+			}
+
+			/* Start over with next log message */
+			wcnt = 0;
+			len = scnprintf(buf, LPFC_FPIN_WWPN_LINE_SZ,
+					"Additional WWPNs:");
+		}
+	}
+}
+
 /**
  * lpfc_els_rcv_fpin_li - Process an FPIN Link Integrity Event.
- * @vport: Pointer to vport object.
+ * @phba: Pointer to phba object.
  * @tlv:  Pointer to the Link Integrity Notification Descriptor.
  *
- * This function processes a link integrity FPIN event by
- * logging a message
+ * This function processes a Link Integrity FPIN event by logging a message.
  **/
 static void
-lpfc_els_rcv_fpin_li(struct lpfc_vport *vport, struct fc_tlv_desc *tlv)
+lpfc_els_rcv_fpin_li(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 {
 	struct fc_fn_li_desc *li = (struct fc_fn_li_desc *)tlv;
 	const char *li_evt_str;
-	u32 li_evt;
+	u32 li_evt, cnt;
 
 	li_evt = be16_to_cpu(li->event_type);
 	li_evt_str = lpfc_get_fpin_li_event_nm(li_evt);
+	cnt = be32_to_cpu(li->pname_count);
 
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "4680 FPIN Link Integrity %s (x%x) "
-			 "Detecting PN x%016llx Attached PN x%016llx "
-			 "Duration %d mSecs Count %d Port Cnt %d\n",
-			 li_evt_str, li_evt,
-			 be64_to_cpu(li->detecting_wwpn),
-			 be64_to_cpu(li->attached_wwpn),
-			 be32_to_cpu(li->event_threshold),
-			 be32_to_cpu(li->event_count),
-			 be32_to_cpu(li->pname_count));
+	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
+			"4680 FPIN Link Integrity %s (x%x) "
+			"Detecting PN x%016llx Attached PN x%016llx "
+			"Duration %d mSecs Count %d Port Cnt %d\n",
+			li_evt_str, li_evt,
+			be64_to_cpu(li->detecting_wwpn),
+			be64_to_cpu(li->attached_wwpn),
+			be32_to_cpu(li->event_threshold),
+			be32_to_cpu(li->event_count), cnt);
+
+	lpfc_display_fpin_wwpn(phba, (__be64 *)&li->pname_list, cnt);
+}
+
+/**
+ * lpfc_els_rcv_fpin_del - Process an FPIN Delivery Event.
+ * @phba: Pointer to hba object.
+ * @tlv:  Pointer to the Delivery Notification Descriptor TLV
+ *
+ * This function processes a Delivery FPIN event by logging a message.
+ **/
+static void
+lpfc_els_rcv_fpin_del(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+{
+	struct fc_fn_deli_desc *del = (struct fc_fn_deli_desc *)tlv;
+	const char *del_rsn_str;
+	u32 del_rsn;
+	__be32 *frame;
+
+	del_rsn = be16_to_cpu(del->deli_reason_code);
+	del_rsn_str = lpfc_get_fpin_deli_event_nm(del_rsn);
+
+	/* Skip over desc_tag/desc_len header to payload */
+	frame = (__be32 *)(del + 1);
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_ELS,
+			"4681 FPIN Delivery %s (x%x) "
+			"Detecting PN x%016llx Attached PN x%016llx "
+			"DiscHdr0  x%08x "
+			"DiscHdr1 x%08x DiscHdr2 x%08x DiscHdr3 x%08x "
+			"DiscHdr4 x%08x DiscHdr5 x%08x\n",
+			del_rsn_str, del_rsn,
+			be64_to_cpu(del->detecting_wwpn),
+			be64_to_cpu(del->attached_wwpn),
+			be32_to_cpu(frame[0]),
+			be32_to_cpu(frame[1]),
+			be32_to_cpu(frame[2]),
+			be32_to_cpu(frame[3]),
+			be32_to_cpu(frame[4]),
+			be32_to_cpu(frame[5]));
 }
 
+/**
+ * lpfc_els_rcv_fpin_peer_cgn - Process a FPIN Peer Congestion Event.
+ * @phba: Pointer to hba object.
+ * @tlv:  Pointer to the Peer Congestion Notification Descriptor TLV
+ *
+ * This function processes a Peer Congestion FPIN event by logging a message.
+ **/
 static void
-lpfc_els_rcv_fpin(struct lpfc_vport *vport, struct fc_els_fpin *fpin,
-		  u32 fpin_length)
+lpfc_els_rcv_fpin_peer_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 {
-	struct fc_tlv_desc *tlv;
+	struct fc_fn_peer_congn_desc *pc = (struct fc_fn_peer_congn_desc *)tlv;
+	const char *pc_evt_str;
+	u32 pc_evt, cnt;
+
+	pc_evt = be16_to_cpu(pc->event_type);
+	pc_evt_str = lpfc_get_fpin_congn_event_nm(pc_evt);
+	cnt = be32_to_cpu(pc->pname_count);
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT | LOG_ELS,
+			"4684 FPIN Peer Congestion %s (x%x) "
+			"Duration %d mSecs "
+			"Detecting PN x%016llx Attached PN x%016llx "
+			"Impacted Port Cnt %d\n",
+			pc_evt_str, pc_evt,
+			be32_to_cpu(pc->event_period),
+			be64_to_cpu(pc->detecting_wwpn),
+			be64_to_cpu(pc->attached_wwpn),
+			cnt);
+
+	lpfc_display_fpin_wwpn(phba, (__be64 *)&pc->pname_list, cnt);
+}
+
+/**
+ * lpfc_els_rcv_fpin_cgn - Process an FPIN Congestion notification
+ * @phba: Pointer to hba object.
+ * @tlv:  Pointer to the Congestion Notification Descriptor TLV
+ *
+ * This function processes an FPIN Congestion Notifiction.  The notification
+ * could be an Alarm or Warning.  This routine feeds that data into driver's
+ * running congestion algorithm. It also processes the FPIN by
+ * logging a message. It returns 1 to indicate deliver this message
+ * to the upper layer or 0 to indicate don't deliver it.
+ **/
+static int
+lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
+{
+	struct fc_fn_congn_desc *cgn = (struct fc_fn_congn_desc *)tlv;
+	const char *cgn_evt_str;
+	u32 cgn_evt;
+	const char *cgn_sev_str;
+	u32 cgn_sev;
+	bool nm_log = false;
+	int rc = 1;
+
+	cgn_evt = be16_to_cpu(cgn->event_type);
+	cgn_evt_str = lpfc_get_fpin_congn_event_nm(cgn_evt);
+	cgn_sev = cgn->severity;
+	cgn_sev_str = lpfc_get_fpin_congn_severity_nm(cgn_sev);
+
+	/* The driver only takes action on a Credit Stall or Oversubscription
+	 * event type to engage the IO algorithm.  The driver prints an
+	 * unmaskable message only for Lost Credit and Credit Stall.
+	 * TODO: Still need to have definition of host action on clear,
+	 *       lost credit and device specific event types.
+	 */
+	switch (cgn_evt) {
+	case FPIN_CONGN_LOST_CREDIT:
+		nm_log = true;
+		break;
+	case FPIN_CONGN_CREDIT_STALL:
+		nm_log = true;
+		fallthrough;
+	case FPIN_CONGN_OVERSUBSCRIPTION:
+		if (cgn_evt == FPIN_CONGN_OVERSUBSCRIPTION)
+			nm_log = false;
+		switch (cgn_sev) {
+		case FPIN_CONGN_SEVERITY_ERROR:
+			/* Take action here for an Alarm event */
+			break;
+		case FPIN_CONGN_SEVERITY_WARNING:
+			/* Take action here for a Warning event */
+			break;
+		}
+		break;
+	}
+
+	/* Change the log level to unmaskable for the following event types. */
+	lpfc_printf_log(phba, (nm_log ? KERN_WARNING : KERN_INFO),
+			LOG_CGN_MGMT | LOG_ELS,
+			"4683 FPIN CONGESTION %s type %s (x%x) Event "
+			"Duration %d mSecs\n",
+			cgn_sev_str, cgn_evt_str, cgn_evt,
+			be32_to_cpu(cgn->event_period));
+	return rc;
+}
+
+static void
+lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
+{
+	struct lpfc_hba *phba = vport->phba;
+	struct fc_els_fpin *fpin = (struct fc_els_fpin *)p;
+	struct fc_tlv_desc *tlv, *first_tlv, *current_tlv;
 	const char *dtag_nm;
-	uint32_t desc_cnt = 0, bytes_remain;
-	u32 dtag;
+	int desc_cnt = 0, bytes_remain, cnt;
+	u32 dtag, deliver = 0;
+	int len;
 
 	/* FPINs handled only if we are in the right discovery state */
 	if (vport->port_state < LPFC_DISC_AUTH)
@@ -8740,35 +8951,91 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, struct fc_els_fpin *fpin,
 	if (fpin_length < sizeof(struct fc_els_fpin))
 		return;
 
+	/* Sanity check descriptor length. The desc_len value does not
+	 * include space for the ELS command and the desc_len fields.
+	 */
+	len = be32_to_cpu(fpin->desc_len);
+	if (fpin_length < len + sizeof(struct fc_els_fpin)) {
+		lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+				"4671 Bad ELS FPIN length %d: %d\n",
+				len, fpin_length);
+		return;
+	}
+
 	tlv = (struct fc_tlv_desc *)&fpin->fpin_desc[0];
+	first_tlv = tlv;
 	bytes_remain = fpin_length - offsetof(struct fc_els_fpin, fpin_desc);
 	bytes_remain = min_t(u32, bytes_remain, be32_to_cpu(fpin->desc_len));
 
-	/* process each descriptor */
+	/* process each descriptor separately */
 	while (bytes_remain >= FC_TLV_DESC_HDR_SZ &&
 	       bytes_remain >= FC_TLV_DESC_SZ_FROM_LENGTH(tlv)) {
-
 		dtag = be32_to_cpu(tlv->desc_tag);
 		switch (dtag) {
 		case ELS_DTAG_LNK_INTEGRITY:
-			lpfc_els_rcv_fpin_li(vport, tlv);
+			lpfc_els_rcv_fpin_li(phba, tlv);
+			deliver = 1;
+			break;
+		case ELS_DTAG_DELIVERY:
+			lpfc_els_rcv_fpin_del(phba, tlv);
+			deliver = 1;
+			break;
+		case ELS_DTAG_PEER_CONGEST:
+			lpfc_els_rcv_fpin_peer_cgn(phba, tlv);
+			deliver = 1;
+			break;
+		case ELS_DTAG_CONGESTION:
+			deliver = lpfc_els_rcv_fpin_cgn(phba, tlv);
 			break;
 		default:
 			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
-					 "4678  skipped FPIN descriptor[%d]: "
-					 "tag x%x (%s)\n",
-					 desc_cnt, dtag, dtag_nm);
-			break;
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"4678 unknown FPIN descriptor[%d]: "
+					"tag x%x (%s)\n",
+					desc_cnt, dtag, dtag_nm);
+
+			/* If descriptor is bad, drop the rest of the data */
+			return;
 		}
+		cnt = be32_to_cpu(tlv->desc_len);
 
-		desc_cnt++;
+		/* Sanity check descriptor length. The desc_len value does not
+		 * include space for the desc_tag and the desc_len fields.
+		 */
+		len -= (cnt + sizeof(struct fc_tlv_desc));
+		if (len < 0) {
+			dtag_nm = lpfc_get_tlv_dtag_nm(dtag);
+			lpfc_printf_log(phba, KERN_WARNING, LOG_CGN_MGMT,
+					"4672 Bad FPIN descriptor TLV length "
+					"%d: %d %d %s\n",
+					cnt, len, fpin_length, dtag_nm);
+			return;
+		}
+
+		current_tlv = tlv;
 		bytes_remain -= FC_TLV_DESC_SZ_FROM_LENGTH(tlv);
 		tlv = fc_tlv_next_desc(tlv);
-	}
 
-	fc_host_fpin_rcv(lpfc_shost_from_vport(vport), fpin_length,
-			 (char *)fpin);
+		/* Format payload such that the FPIN delivered to the
+		 * upper layer is a single descriptor FPIN.
+		 */
+		if (desc_cnt)
+			memcpy(first_tlv, current_tlv,
+			       (cnt + sizeof(struct fc_els_fpin)));
+
+		/* Adjust the length so that it only reflects a
+		 * single descriptor FPIN.
+		 */
+		fpin_length = cnt + sizeof(struct fc_els_fpin);
+		fpin->desc_len = cpu_to_be32(fpin_length);
+		fpin_length += sizeof(struct fc_els_fpin); /* the entire FPIN */
+
+		/* Send every descriptor individually to the upper layer */
+		if (deliver)
+			fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
+					 fpin_length, (char *)fpin);
+		desc_cnt++;
+	}
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_hw4.h b/drivers/scsi/lpfc/lpfc_hw4.h
index fdc22e5d5fac..65bb4a66ccf0 100644
--- a/drivers/scsi/lpfc/lpfc_hw4.h
+++ b/drivers/scsi/lpfc/lpfc_hw4.h
@@ -20,6 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
+#include <uapi/scsi/fc/fc_fs.h>
 #include <uapi/scsi/fc/fc_els.h>
 
 /* Macros to deal with bit fields. Each bit field must have 3 #defines
@@ -4813,3 +4814,16 @@ struct lpfc_grp_hdr {
 #define LPFC_FW_DUMP	1
 #define LPFC_FW_RESET	2
 #define LPFC_DV_RESET	3
+
+/*
+ * Initializer useful for decoding FPIN string table.
+ */
+#define FC_FPIN_CONGN_SEVERITY_INIT {				\
+	{ FPIN_CONGN_SEVERITY_WARNING,		"Warning" },	\
+	{ FPIN_CONGN_SEVERITY_ERROR,		"Alarm" },	\
+}
+
+/* Used for logging FPIN messages */
+#define LPFC_FPIN_WWPN_LINE_SZ  128
+#define LPFC_FPIN_WWPN_LINE_CNT 6
+#define LPFC_FPIN_WWPN_NUM_LINE 6
-- 
2.26.2

