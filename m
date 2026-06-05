Return-Path: <linux-scsi+bounces-24500-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ZoIKMUMI2qohAEAu9opvQ
	(envelope-from <linux-scsi+bounces-24500-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 19:52:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3E64A53C
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 19:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hUYrd6NS;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24500-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24500-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28BC3306887E
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 17:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C2369207;
	Fri,  5 Jun 2026 17:45:24 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419263955E0
	for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2026 17:45:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681523; cv=none; b=QykS0VqBYLMqhLPzIdlWsvu2hbtWQa2IsnrSqWVDqZY9MLMko5XhqI9EtU7UznxWyxyZwHBOdVV1YlRGNnKjqSDcXM0OoKZfCYaQ2VCvxzMS00a16xxURxgZC21gUcwFut0D/XIkxPpqU2Wsm0vm4tBXJNsqB4wexYuvNQ2jfxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681523; c=relaxed/simple;
	bh=irg10sguo4P4opu9kJcLyizUCQpfPHL3o+kaCIFIOT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Km/1iR+sikaBzQpvXtZ+RGXwZpY3hok0GGTVo8qDpFCuMX+QWUoCooGQ874sqnobcFMM/mnqxp/YFuSYLJL1S93yGDbSjxDHD9A4SLnEsv43c1CoknIxbnJ6W8QemMWGB3GXl6CD4KfcgIj2NmzHgG6DEg4qJZZnKdsiZuaofow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUYrd6NS; arc=none smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5176d4c14f5so18177511cf.0
        for <linux-scsi@vger.kernel.org>; Fri, 05 Jun 2026 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681516; x=1781286316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXy7x2vQ5tNMNKJfcBjpaaGItqniXr9jZaa22LwaNSE=;
        b=hUYrd6NSBVgfRSch2/xk9CD23dlmX804Vfq5nHFQY3C0HWVB/gtDCeNzA2fv0BMeQk
         bSjG8EnZA5JVO+Bi/yeNPT2e9VJuDGAkVVX3xawyI7LVI8jRpOb1ulYuQS4kCaB7tV32
         XiZkm8cXqv/Oyk+TzFacbYRnLoGCITeUw4vTefy+BRYKQgs70sqHyUZc/9102I0Uq7OL
         XC+ggGO4m6/t+otrFPF80MfVhjHqdDdNw55QocL7GBEgJpSUWoekk1frLpac/xko6sPe
         g+4sym+TpafdPC2CqXFL/yXIPBngoeLcG/FdnWAB//sCenW6uX1gCtmnDQXDO/A/rAq5
         tsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681516; x=1781286316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXy7x2vQ5tNMNKJfcBjpaaGItqniXr9jZaa22LwaNSE=;
        b=b4TM/8on1bGzmP7yBYNHVR/bewCT76/Ny/G3GNIxM+H1sDoTZ4oANn+7NBkRT59yqP
         dTc8FkU75BhM/aWaPwZLeNc41G2pSSuM+xKZac64B1VO3Zy2OHgkF8ybwZC6G9YgndmW
         QW4aT9k7VvhCHJPdnw1yYIwezxsKkDEmsrvORnjyHzi0a5WITpzwyNRxLyvMxvqLKDO2
         4FG0C8pP+kObSRVotKYOCBF6F8jd0WEZpR4YYILAIcH2kaMP20spRD16p1lwFP6uO9jo
         GdX3TNXOPHnI1totz0oDxNcdl9namy6yUjCDWIHQEa+hJQuxZo/d1ZuUZlvEW0BeOtI2
         4gXw==
X-Gm-Message-State: AOJu0Ywi5THZRWsv1xS82lWr7H5b7Qpw76JYNRQia4dMOuWKCQYAELa/
	N4YN6IrrY0nUC9FuVHWBrTsdpKTUAwAmgSfbKcOKAMM7xfZF41B64p3qWhlDYfJN
X-Gm-Gg: Acq92OFF02HEbYZq9W/87mOn2/HXxzvlsPxksgGMttDhdQyt5nYv1oV/A9Yi3WWEiIx
	mn2Luej/K+XX/g4ZhzQCSeQp8YTsGyp2XfButtMtEEiqSiXC06vsxU8KfqeIwJ91evYnNOk5PTw
	6VvNqbjogqtcSHMiTQ5Y8+Irne1+g48Ys5UT29+oWFwrCqG7HJLioqjk8ZcLbghLuDvtFLXeIDe
	etIdwMU+GOwhQX/CxU2FFd5vLm2SZaSJKav+ggEP77NjFHBUinfkMO3ejEhxrpWpoV4LKKOor8G
	Y7Lxd/+rzsfp9ZKUQ319B9VTvTvEdbxD6PwSGocAHRgKtdYYKbPAApHjD3pliDtUQhuAhP17NPV
	3fBcuKzbzwcL8++68RY0ePb1rJnH/KfK7YARh3A6fvsij9H/qzxR00ZlbbpeisPiwl1KONhiViO
	HhuCIbVrQgqhHuWMpJPkAwKaC5Ot4dqpZNPC673VCQcJ8uK3LcjPplNc5ZzEsatywlFfBTaB3Tj
	64QvucSX3Un7v7kM5Nd9H1E90kuQzsNMPuNyTZQqHoa0kHHgc7Blg==
X-Received: by 2002:a05:622a:6115:b0:50e:ca38:e219 with SMTP id d75a77b69052e-51795c0b2cbmr61072211cf.45.1780681505866;
        Fri, 05 Jun 2026 10:45:05 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm53376171cf.19.2026.06.05.10.45.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:45:05 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart833426@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH v2 08/14] lpfc: Improve PLOGI retry handling for large SAN configurations
Date: Fri,  5 Jun 2026 11:23:30 -0700
Message-Id: <20260605182336.134919-9-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20260605182336.134919-1-justintee8345@gmail.com>
References: <20260605182336.134919-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-24500-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,m:jsmart833426@gmail.com,m:justin.tee@broadcom.com,m:justintee8345@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15A3E64A53C

In large SAN configurations with link perturbations, rediscovery of target
ports is problematic due to PLOGI retry race conditions.

This patch improves target rediscovery by ensuring PLOGI retries are
serialized in unregistration and retry handler paths.

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c       | 62 +++++++++++++++++++--
 drivers/scsi/lpfc/lpfc_nportdisc.c | 58 ++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_sli.c       | 87 +++++++++++++++++-------------
 3 files changed, 167 insertions(+), 40 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index c67f8581f584..056d63a3d166 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -2159,6 +2159,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out_freeiocb;
 	}
 
+	clear_bit(NLP_PLOGI_SND, &ndlp->nlp_flag);
+
 	/* Since ndlp can be freed in the disc state machine, note if this node
 	 * is being used during discovery.
 	 */
@@ -2329,17 +2331,43 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 	     test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) &&
 	    ((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
 	    !test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
+		lpfc_printf_vlog(vport, KERN_INFO,
+				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
 				 "4110 Issue PLOGI x%x deferred "
 				 "on NPort x%x rpi x%x flg x%lx Data:"
 				 " x%px\n",
 				 ndlp->nlp_defer_did, ndlp->nlp_DID,
 				 ndlp->nlp_rpi, ndlp->nlp_flag, ndlp);
 
-		/* We can only defer 1st PLOGI */
-		if (ndlp->nlp_defer_did == NLP_EVT_NOTHING_PENDING)
+		/* Don't defer a PLOGI that is already in that condition.
+		 * Also set the nlp_last_elscmd to PLOGI to get the retry.
+		 */
+		if (ndlp->nlp_defer_did == NLP_EVT_NOTHING_PENDING) {
 			ndlp->nlp_defer_did = did;
-		return 0;
+			ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
+		}
+		return 1;
+	}
+
+	if (test_bit(NLP_PLOGI_SND, &ndlp->nlp_flag)) {
+		lpfc_printf_vlog(vport, KERN_INFO,
+				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
+				 "4113 Reject PLOGI issue, PLOGI in-flight "
+				 "x%px, DID x%x nflag x%lx\n",
+				 ndlp, ndlp->nlp_DID, ndlp->nlp_flag);
+		return 1;
+	}
+
+	if (ndlp->nlp_state > NLP_STE_PLOGI_ISSUE &&
+	    ndlp->nlp_state <= NLP_STE_MAPPED_NODE) {
+		lpfc_printf_vlog(vport, KERN_INFO,
+				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
+				 "4114 Reject PLOGI issue, Node in "
+				 "unexpected state x%px, DID x%x nflag x%lx "
+				 "in State x%x\n",
+				 ndlp, ndlp->nlp_DID,
+				 ndlp->nlp_flag, ndlp->nlp_state);
+		return 1;
 	}
 
 	cmdsize = (sizeof(uint32_t) + sizeof(struct serv_parm));
@@ -2415,6 +2443,7 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 		return 1;
 	}
 
+	set_bit(NLP_PLOGI_SND, &ndlp->nlp_flag);
 	return 0;
 }
 
@@ -4614,6 +4643,31 @@ lpfc_els_retry_delay_handler(struct lpfc_nodelist *ndlp)
 		lpfc_issue_els_flogi(vport, ndlp, retry);
 		break;
 	case ELS_CMD_PLOGI:
+		/* The driver delayed a PLOGI via the nlp_delayfunc, but
+		 * it's possible the PLOGI is already on a deferred retry.
+		 * Catch this case and skip this delayed PLOGI. This prevents
+		 * multiple PLOGIs in flight. The defer code flow cleans
+		 * up.
+		 */
+		if ((test_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag) ||
+		     test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) &&
+		    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING &&
+		    ((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
+		    !test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
+			/* When UNREG_RPI completes we need to have the
+			 * nlp_last_elscmd set.
+			 */
+			ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
+			lpfc_printf_vlog(vport, KERN_INFO,
+					 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
+					 "4112 Skip delayed PLOGI x%x deferred "
+					 "on NPort x%x rpi x%x flg x%lx Data:"
+					 " x%px\n",
+					 ndlp->nlp_defer_did, ndlp->nlp_DID,
+					 ndlp->nlp_rpi, ndlp->nlp_flag, ndlp);
+			break;
+		}
+
 		if (!lpfc_issue_els_plogi(vport, ndlp->nlp_DID, retry)) {
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index f917a5bcfd02..0270ab7e602f 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -920,6 +920,64 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_type, vport->fc_flag);
 
+		/* The driver wants to schedule a delayed PLOGI to recover
+		 * the remote Nport.  However, there are two cases that
+		 * stop this so that multiple PLOGI are not inflight to
+		 * the same NPortID
+		 *
+		 * Do not schedule a delayed PLOGI if the deferred PLOGI
+		 * code already set up a PLOGI retry after an UNREG_RPI
+		 * mailbox completes.
+		 */
+		if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag) &&
+		    ndlp->nlp_defer_did == ndlp->nlp_DID &&
+		    ndlp->nlp_last_elscmd == ELS_CMD_PLOGI) {
+			lpfc_printf_vlog(vport, KERN_INFO,
+					 LOG_NODE | LOG_ELS | LOG_DISCOVERY,
+					 "3206 No PLOGI delay, defer PLOGI "
+					 "waiting on DID x%06x UNREG_RPI "
+					 "nflag x%lx state x%x lastels x%x "
+					 "defer_did x%x\n",
+					 ndlp->nlp_DID, ndlp->nlp_flag,
+					 ndlp->nlp_state, ndlp->nlp_last_elscmd,
+					 ndlp->nlp_defer_did);
+			goto out;
+		}
+
+		/* A delayed PLOGI retry is not required if the ndlp's delay
+		 * timer is running and the last command was PLOGI.
+		 */
+		if (test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+		    ndlp->nlp_last_elscmd == ELS_CMD_PLOGI) {
+			lpfc_printf_vlog(vport, KERN_INFO,
+					 LOG_NODE | LOG_ELS | LOG_DISCOVERY,
+					 "3207 No PLOGI delay, PLOGI_DELAY_TMO "
+					 "active on DID x%06x "
+					 "nflag x%lx state x%x lastels x%x "
+					 "defer_did x%x\n",
+					 ndlp->nlp_DID, ndlp->nlp_flag,
+					 ndlp->nlp_state, ndlp->nlp_last_elscmd,
+					 ndlp->nlp_defer_did);
+			goto out;
+		}
+
+		/* Do not schedule a PLOGI retry if the ndlp state is NPR
+		 * and vport has received an RSCN
+		 */
+		if (ndlp->nlp_state == NLP_STE_NPR_NODE &&
+		    test_bit(FC_RSCN_MODE, &vport->fc_flag)) {
+			lpfc_printf_vlog(vport, KERN_INFO,
+					 LOG_NODE | LOG_ELS | LOG_DISCOVERY,
+					 "3939 No PLOGI delay, RSCN in "
+					 "progress for NPR DID x%06x "
+					 "nflag x%lx state x%x last_els x%x "
+					 "defer_did x%06x\n",
+					 ndlp->nlp_DID, ndlp->nlp_flag,
+					 ndlp->nlp_state, ndlp->nlp_last_elscmd,
+					 ndlp->nlp_defer_did);
+			goto out;
+		}
+
 		/* Special cases for rports that recover post LOGO. */
 		if ((!(ndlp->nlp_type == NLP_FABRIC) &&
 		     (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET) ||
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 20ee8171e31f..efde944a2693 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2914,7 +2914,19 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING) {
 				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
-				lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
+
+				if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+				    ndlp->nlp_last_elscmd == ELS_CMD_PLOGI) {
+					rc = lpfc_issue_els_plogi(vport,
+								  ndlp->nlp_DID,
+								  0);
+					if (!rc) {
+						ndlp->nlp_prev_state =
+							ndlp->nlp_state;
+						lpfc_nlp_set_state(vport, ndlp,
+							   NLP_STE_PLOGI_ISSUE);
+					}
+				}
 			} else {
 				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 			}
@@ -2967,52 +2979,55 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	bool unreg_inp;
 
 	ndlp = pmb->ctx_ndlp;
-	if (pmb->u.mb.mbxCommand == MBX_UNREG_LOGIN) {
+	if (pmb->u.mb.mbxCommand == MBX_UNREG_LOGIN && ndlp) {
 		if (phba->sli_rev == LPFC_SLI_REV4 &&
 		    (bf_get(lpfc_sli_intf_if_type,
 		     &phba->sli4_hba.sli_intf) >=
 		     LPFC_SLI_INTF_IF_TYPE_2)) {
-			if (ndlp) {
-				lpfc_printf_vlog(
-					 vport, KERN_INFO,
+			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_MBOX | LOG_SLI | LOG_NODE,
-					 "0010 UNREG_LOGIN vpi:x%x "
-					 "rpi:%x DID:%x defer x%x flg x%lx "
-					 "x%px\n",
+					 "0010 UNREG_LOGIN vpi:x%x rpi:%x "
+					 "DID:%x defer x%x flg x%lx x%px\n",
 					 vport->vpi, ndlp->nlp_rpi,
 					 ndlp->nlp_DID, ndlp->nlp_defer_did,
-					 ndlp->nlp_flag,
-					 ndlp);
+					 ndlp->nlp_flag, ndlp);
 
-				/* Cleanup the nlp_flag now that the UNREG RPI
-				 * has completed.
-				 */
-				unreg_inp = test_and_clear_bit(NLP_UNREG_INP,
-							       &ndlp->nlp_flag);
-				clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
+			/* Cleanup the nlp_flag now that the UNREG RPI
+			 * has completed.
+			 */
+			unreg_inp = test_and_clear_bit(NLP_UNREG_INP,
+						       &ndlp->nlp_flag);
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 
-				/* Check to see if there are any deferred
-				 * events to process
-				 */
-				if (unreg_inp &&
-				    ndlp->nlp_defer_did !=
-				    NLP_EVT_NOTHING_PENDING) {
-					lpfc_printf_vlog(
-						vport, KERN_INFO,
-						LOG_MBOX | LOG_SLI | LOG_NODE,
-						"4111 UNREG cmpl deferred "
-						"clr x%x on "
-						"NPort x%x Data: x%x x%px\n",
-						ndlp->nlp_rpi, ndlp->nlp_DID,
-						ndlp->nlp_defer_did, ndlp);
-					ndlp->nlp_defer_did =
-						NLP_EVT_NOTHING_PENDING;
-					lpfc_issue_els_plogi(
-						vport, ndlp->nlp_DID, 0);
-				}
+			/* Check to see if there are any deferred
+			 * events to process
+			 */
+			if (unreg_inp &&
+			    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING) {
+				lpfc_printf_vlog(vport, KERN_INFO,
+						 LOG_MBOX | LOG_SLI | LOG_NODE,
+						 "4111 UNREG cmpl deferred "
+						 "clr x%x on  NPort x%x "
+						 "Data: x%x x%x x%px\n",
+						 ndlp->nlp_rpi, ndlp->nlp_DID,
+						 ndlp->nlp_defer_did,
+						 ndlp->nlp_last_elscmd, ndlp);
+				ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
 
-				lpfc_nlp_put(ndlp);
+				if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+				    ndlp->nlp_last_elscmd == ELS_CMD_PLOGI) {
+					if (lpfc_issue_els_plogi(vport,
+								 ndlp->nlp_DID,
+								 0))
+						goto out;
+
+					ndlp->nlp_prev_state = ndlp->nlp_state;
+					lpfc_nlp_set_state(vport, ndlp,
+							   NLP_STE_PLOGI_ISSUE);
+				}
 			}
+out:
+			lpfc_nlp_put(ndlp);
 		}
 	}
 
-- 
2.38.0


