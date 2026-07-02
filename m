Return-Path: <linux-scsi+bounces-25480-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hpgBkGnRmpJbAsAu9opvQ
	(envelope-from <linux-scsi+bounces-25480-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:00:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19CB6FBC82
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:00:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Ar02VsBg;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25480-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25480-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F6073030C9D
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303663A71A8;
	Thu,  2 Jul 2026 17:59:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1239EF0F;
	Thu,  2 Jul 2026 17:59:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015179; cv=none; b=ff6Y80K6hjTwddDCTHgmaPkzu57LWRzlZmCtNm10B2n6oQNr/hpGaUl1w9ZyU0q/0Zrc3c9B7nJORugvvPHAekMjfC6z0ueoT+VXtJeh/qaZMZBViWTflANLKWgZVJuvUDjblqwXJcubcYLGAJI67vUAAkUUvWOqhTK3ybfSg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015179; c=relaxed/simple;
	bh=iso8GO64FYYaS8yHK9cbp/pESUirZ3qgkGYLQa+x0X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPSrB+oQr7xoPmE/hF88EHv5J8UxpXsqsa9C7qT+LHvlUDrTi2kCIrvVrp6+OtkmknYBb2tTpao87NzDG7ZhD1f46sRjWD1LF6f8b7ZD63TJL73DWwFJiLjj+17Knmz9dvgDPWWNb6QYMIjBvQFjISaky2n47S9HxoGM5gGa0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar02VsBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 803A6C2BCF4;
	Thu,  2 Jul 2026 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783015179;
	bh=iso8GO64FYYaS8yHK9cbp/pESUirZ3qgkGYLQa+x0X8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ar02VsBgh4E1u6AuRels/+ovinyz5tKMYo2o9lkgVOL/EjcTGjuHFBqQrSeSfQkFn
	 20J4emz6B5SVaBTtTXUwZnhzbwsihU/fz9a+ZTdoiJhpNTRILh5dIGCdG1mk9p/xrR
	 Nk8adQsN4oAYHpr7smqJcrj9vAdQVM0ac35TvDXrqx/EBB/2nxpiGB5HJStpcGHYUW
	 n+Pkdb91Bl+DhVNjmq1QIcAwPTxj8bDvXCirCrRcfOTMqJHcmu6f4sYUhRlKAY7wct
	 oNJdo1ZngNDAFcOUIenXUe4gDbqJzbBigEwhJ1l0i1vJZNVlP2s33s66P6aXrOHuV3
	 ITgZFS5t5AlAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D530C43458;
	Thu,  2 Jul 2026 17:59:39 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Thu, 02 Jul 2026 12:59:36 -0500
Subject: [PATCH v3 6/8] ibmvfc: extend async event handlers to handle async
 sub queue events
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-ibmvfc-fpin-support-v3-6-d95b9547cf88@linux.ibm.com>
References: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
In-Reply-To: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>, 
 Greg Joyce <gjoyce@linux.ibm.com>, Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, 
 Dave Marquardt <davemarq@linux.ibm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783015177; l=12011;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=TGKfNyGbOqjpabBs8wC1jz9JAgWE7OngsIIrumszrc4=;
 b=83kpVYQN9ESorVFMD3yuDiQwu/RVkMGdRaDkAWKR1CRosHCrP0rJJtV0U8tbNSiBqT4uRsXsK
 cQE85RE1X3nBRM0he51i4N7oRQK5uvJVNUNa4EX2l1U+QKm5YfmqX96
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[HansenPartnership.com,oracle.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tyreld@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@linux.ibm.com,m:gjoyce@linux.ibm.com,m:kmahlkuc@linux.ibm.com,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25480-lists,linux-scsi=lfdr.de,davemarq.linux.ibm.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[davemarq@linux.ibm.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:replyto,linux.ibm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A19CB6FBC82

From: Dave Marquardt <davemarq@linux.ibm.com>

Make ibmvfc_handle_async and ibmvfc_process_async_work handle both
async CRQs and the new asynchronous sub-queue CRQs.

Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c       | 156 +++++++++++++++++++++++++++--------
 drivers/scsi/ibmvscsi/ibmvfc.h       |  17 ++--
 drivers/scsi/ibmvscsi/ibmvfc_kunit.c |  10 +--
 3 files changed, 136 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 804887fb5635..4678d76c84fe 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3349,6 +3349,27 @@ ibmvfc_basic_fpin_to_desc(struct ibmvfc_async_crq *crq, u64 wwpn)
 					  cpu_to_be32(1));
 }
 
+/**
+ * ibmvfc_full_fpin_to_desc(): allocate and populate a struct fc_els_fpin struct
+ * containing a descriptor.
+ * @ibmvfc_fpin: Pointer to async subq FPIN data
+ *
+ * Allocate a struct fc_els_fpin containing a descriptor and populate
+ * based on data from *ibmvfc_fpin.
+ *
+ * Return:
+ * NULL     - unable to allocate structure
+ * non-NULL - pointer to populated struct fc_els_fpin
+ */
+static struct fc_els_fpin *
+ibmvfc_full_fpin_to_desc(struct ibmvfc_async_subq *ibmvfc_fpin)
+{
+	return ibmvfc_common_fpin_to_desc(ibmvfc_fpin->fpin_status, ibmvfc_fpin->wwpn,
+					  cpu_to_be16(0), cpu_to_be16(0),
+					  cpu_to_be32(IBMVFC_FPIN_DEFAULT_EVENT_THRESHOLD),
+					  cpu_to_be32(1));
+}
+
 /**
  * ibmvfc_process_async_work - Process IBMVFC_AE_FPIN async CRQ from work queue
  * @work: pointer to work_struct
@@ -3356,26 +3377,51 @@ ibmvfc_basic_fpin_to_desc(struct ibmvfc_async_crq *crq, u64 wwpn)
 static void ibmvfc_process_async_work(struct work_struct *work)
 {
 	struct ibmvfc_target *tgt, *next;
+	struct ibmvfc_async_subq *subq = NULL;
 	struct ibmvfc_async_work *aw;
-	struct ibmvfc_async_crq *crq;
+	struct ibmvfc_async_crq *crq = NULL;
 	struct ibmvfc_host *vhost;
-	struct fc_els_fpin *fpin;
+	struct fc_els_fpin *fpin = NULL;
 	unsigned long flags;
+	__be64 node_name;
+	__be64 scsi_id;
+	bool is_subq;
+	__be64 wwpn;
 
 	aw = container_of(work, struct ibmvfc_async_work, async_work_s);
-	crq = &aw->crq;
 	vhost = aw->vhost;
+	is_subq = aw->is_subq;
+	if (is_subq)
+		subq = &aw->crq.subq;
+	else
+		crq = &aw->crq.async_crq;
 
-	if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
+	if (!crq && !subq) {
+		dev_err_ratelimited(vhost->dev,
+				    "FPIN event received, unable to process\n");
+		goto end;
+	}
+
+	if (crq) {
+		wwpn = crq->wwpn;
+		node_name = crq->node_name;
+		scsi_id = crq->scsi_id;
+	} else {
+		wwpn = subq->wwpn;
+		node_name = subq->id.node_name;
+		scsi_id = 0;
+	}
+
+	if (!scsi_id && !wwpn && !node_name)
 		goto end;
 
 	spin_lock_irqsave(vhost->host->host_lock, flags);
 	list_for_each_entry_safe(tgt, next, &vhost->targets, queue) {
-		if (crq->scsi_id && cpu_to_be64(tgt->scsi_id) != crq->scsi_id)
+		if (scsi_id && cpu_to_be64(tgt->scsi_id) != scsi_id)
 			continue;
-		if (crq->wwpn && cpu_to_be64(tgt->ids.port_name) != crq->wwpn)
+		if (wwpn && cpu_to_be64(tgt->ids.port_name) != wwpn)
 			continue;
-		if (crq->node_name && cpu_to_be64(tgt->ids.node_name) != crq->node_name)
+		if (node_name && cpu_to_be64(tgt->ids.node_name) != node_name)
 			continue;
 		if (!tgt->rport)
 			continue;
@@ -3388,41 +3434,71 @@ static void ibmvfc_process_async_work(struct work_struct *work)
 		goto end;
 	}
 
-	fpin = ibmvfc_basic_fpin_to_desc(crq, tgt->wwpn);
+	if (crq)
+		fpin = ibmvfc_basic_fpin_to_desc(crq, tgt->wwpn);
+	else
+		fpin = ibmvfc_full_fpin_to_desc(subq);
+
 	if (fpin) {
 		fc_host_fpin_rcv(tgt->vhost->host,
 				 sizeof(*fpin) + be32_to_cpu(fpin->desc_len),
 				 (char *)fpin, 0);
 		kfree(fpin);
 	} else
-		dev_err_ratelimited(vhost->dev,
-				    "FPIN event %u received, unable to process\n",
-				    crq->fpin_status);
+		dev_err_ratelimited(vhost->dev, "FPIN event received, unable to process\n");
+
  end:
 	kfree(aw);
 }
 
 /**
  * ibmvfc_handle_async - Handle an async event from the adapter
- * @crq:	crq to process
+ * @crq:	ibmvfc_async_crq or ibmvfc_async_subq
  * @vhost:	ibmvfc host struct
+ * @is_subq:	indicates whether the crq points to a struct ibmvfc_async_subq
  *
  **/
-VISIBLE_IF_KUNIT void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
-					  struct ibmvfc_host *vhost)
+VISIBLE_IF_KUNIT void ibmvfc_handle_async(void *crq,
+					  struct ibmvfc_host *vhost,
+					  bool is_subq)
 {
-	const struct ibmvfc_async_desc *desc = ibmvfc_get_ae_desc(be64_to_cpu(crq->event));
+	struct ibmvfc_async_crq *async_crq = NULL;
+	struct ibmvfc_async_subq *subq = NULL;
+	const struct ibmvfc_async_desc *desc;
+	struct ibmvfc_target *tgt, *next;
 	struct ibmvfc_async_work *aw;
-	struct ibmvfc_target *tgt;
-
-	ibmvfc_log(vhost, desc->log_level, "%s event received. scsi_id: %llx, wwpn: %llx,"
-		   " node_name: %llx%s\n", desc->desc, be64_to_cpu(crq->scsi_id),
-		   be64_to_cpu(crq->wwpn), be64_to_cpu(crq->node_name),
-		   ibmvfc_get_link_state(crq->link_state));
-
-	switch (be64_to_cpu(crq->event)) {
+	__be64 node_name;
+	__be64 scsi_id;
+	u8 link_state;
+	__be64 wwpn;
+	u64 event;
+
+	if (is_subq) {
+		subq = crq;
+		event = be16_to_cpu(subq->event);
+		link_state = subq->link_state;
+		scsi_id = 0;
+		wwpn = subq->wwpn;
+		node_name = subq->id.node_name;
+	} else {
+		async_crq = crq;
+		event = be64_to_cpu(async_crq->event);
+		link_state = async_crq->link_state;
+		scsi_id = async_crq->scsi_id;
+		wwpn = async_crq->wwpn;
+		node_name = async_crq->node_name;
+	}
+
+	desc = ibmvfc_get_ae_desc(event);
+	ibmvfc_log(vhost, desc->log_level,
+		   "%s event received. scsi_id: %llx, wwpn: %llx, node_name: %llx, event %llx%s\n",
+		   desc->desc, be64_to_cpu(scsi_id),
+		   be64_to_cpu(wwpn), be64_to_cpu(node_name), event,
+		   ibmvfc_get_link_state(link_state));
+
+	switch (event) {
 	case IBMVFC_AE_RESUME:
-		switch (crq->link_state) {
+		switch (link_state) {
 		case IBMVFC_AE_LS_LINK_DOWN:
 			ibmvfc_link_down(vhost, IBMVFC_LINK_DOWN);
 			break;
@@ -3460,18 +3536,18 @@ VISIBLE_IF_KUNIT void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
 	case IBMVFC_AE_ELS_LOGO:
 	case IBMVFC_AE_ELS_PRLO:
 	case IBMVFC_AE_ELS_PLOGI:
-		list_for_each_entry(tgt, &vhost->targets, queue) {
-			if (!crq->scsi_id && !crq->wwpn && !crq->node_name)
+		list_for_each_entry_safe(tgt, next, &vhost->targets, queue) {
+			if (!scsi_id && !wwpn && !node_name)
 				break;
-			if (crq->scsi_id && cpu_to_be64(tgt->scsi_id) != crq->scsi_id)
+			if (scsi_id && cpu_to_be64(tgt->scsi_id) != scsi_id)
 				continue;
-			if (crq->wwpn && cpu_to_be64(tgt->ids.port_name) != crq->wwpn)
+			if (wwpn && cpu_to_be64(tgt->ids.port_name) != wwpn)
 				continue;
-			if (crq->node_name && cpu_to_be64(tgt->ids.node_name) != crq->node_name)
+			if (node_name && cpu_to_be64(tgt->ids.node_name) != node_name)
 				continue;
-			if (tgt->need_login && be64_to_cpu(crq->event) == IBMVFC_AE_ELS_LOGO)
+			if (tgt->need_login && event == IBMVFC_AE_ELS_LOGO)
 				tgt->logo_rcvd = 1;
-			if (!tgt->need_login || be64_to_cpu(crq->event) == IBMVFC_AE_ELS_PLOGI) {
+			if (!tgt->need_login || event == IBMVFC_AE_ELS_PLOGI) {
 				ibmvfc_del_tgt(tgt);
 				ibmvfc_reinit_host(vhost);
 			}
@@ -3492,16 +3568,26 @@ VISIBLE_IF_KUNIT void ibmvfc_handle_async(struct ibmvfc_async_crq *crq,
 		if (aw) {
 			INIT_WORK(&aw->async_work_s, ibmvfc_process_async_work);
 			aw->vhost = vhost;
-			aw->crq = *crq;
+			aw->is_subq = is_subq;
+			if (is_subq)
+				aw->crq.subq = *subq;
+			else
+				aw->crq.async_crq = *async_crq;
 			queue_work(vhost->fpin_workq, &aw->async_work_s);
 		} else
 			dev_err_ratelimited(vhost->dev,
 					    "can't offload async CRQ to work queue\n");
 		break;
 	default:
-		dev_err(vhost->dev, "Unknown async event received: %lld\n", crq->event);
+		dev_err(vhost->dev, "Unknown async event received: %llu\n", event);
 		break;
 	}
+
+	if (is_subq)
+		subq->valid = 0;
+	else
+		async_crq->valid = 0;
+	wmb();
 }
 EXPORT_SYMBOL_IF_KUNIT(ibmvfc_handle_async);
 
@@ -4040,7 +4126,7 @@ static void ibmvfc_tasklet(void *data)
 	while (!done) {
 		/* Pull all the valid messages off the async CRQ */
 		while ((async = ibmvfc_next_async_crq(vhost)) != NULL) {
-			ibmvfc_handle_async(async, vhost);
+			ibmvfc_handle_async(async, vhost, false);
 		}
 
 		/* Pull all the valid messages off the CRQ */
@@ -4053,7 +4139,7 @@ static void ibmvfc_tasklet(void *data)
 		vio_enable_interrupts(vdev);
 		if ((async = ibmvfc_next_async_crq(vhost)) != NULL) {
 			vio_disable_interrupts(vdev);
-			ibmvfc_handle_async(async, vhost);
+			ibmvfc_handle_async(async, vhost, false);
 		} else if ((crq = ibmvfc_next_crq(vhost)) != NULL) {
 			vio_disable_interrupts(vdev);
 			ibmvfc_handle_crq(crq, vhost, &evt_doneq);
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index f38dfae9924c..bbf19220af70 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -712,12 +712,6 @@ struct ibmvfc_async_crq {
 	__be64 reserved;
 } __packed __aligned(8);
 
-struct ibmvfc_async_work {
-	struct ibmvfc_host *vhost;
-	struct ibmvfc_async_crq crq;
-	struct work_struct async_work_s;
-};
-
 struct ibmvfc_async_subq {
 	volatile u8 valid;
 #define IBMVFC_ASYNC_ID_IS_ASSOC_ID	0x01
@@ -737,6 +731,15 @@ struct ibmvfc_async_subq {
 	} id;
 } __packed __aligned(8);
 
+struct ibmvfc_async_work {
+	struct ibmvfc_host *vhost;
+	bool is_subq;
+	union {
+		struct ibmvfc_async_crq async_crq;
+		struct ibmvfc_async_subq subq;
+	} crq;
+	struct work_struct async_work_s;
+};
 union ibmvfc_iu {
 	struct ibmvfc_mad_common mad_common;
 	struct ibmvfc_npiv_login_mad npiv_login;
@@ -1008,7 +1011,7 @@ struct ibmvfc_host {
 #endif
 
 #ifdef VISIBLE_IF_KUNIT
-VISIBLE_IF_KUNIT void ibmvfc_handle_async(struct ibmvfc_async_crq *crq, struct ibmvfc_host *vhost);
+VISIBLE_IF_KUNIT void ibmvfc_handle_async(void *crq, struct ibmvfc_host *vhost, bool is_subq);
 VISIBLE_IF_KUNIT struct list_head *ibmvfc_get_headp(void);
 #endif
 
diff --git a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
index e41e2a49e549..6bde92197549 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc_kunit.c
@@ -44,7 +44,7 @@ static void ibmvfc_async_fpin_test(struct kunit *test)
 	fc_host = shost_to_fc_host(vhost->host);
 
 	pre[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
-	pre[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(tgt->rport->fpin_stats.cn);
+	pre[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(tgt->rport->fpin_stats.cn_device_specific);
 	pre[IBMVFC_AE_FPIN_PORT_CLEARED] = READ_ONCE(tgt->rport->fpin_stats.cn_clear);
 	pre[IBMVFC_AE_FPIN_PORT_DEGRADED] = READ_ONCE(tgt->rport->fpin_stats.li_failure_unknown);
 	pre[IBMVFC_AE_FPIN_CONGESTION_CLEARED] = READ_ONCE(fc_host->fpin_stats.cn_clear);
@@ -57,7 +57,8 @@ static void ibmvfc_async_fpin_test(struct kunit *test)
 		crq[fs].scsi_id = cpu_to_be64(tgt->scsi_id);
 		crq[fs].wwpn = cpu_to_be64(tgt->wwpn);
 		crq[fs].node_name = cpu_to_be64(tgt->ids.node_name);
-		ibmvfc_handle_async(&crq[fs], vhost);
+		ibmvfc_handle_async(&crq[fs], vhost, false);
+		msleep(1U);
 	}
 
 	msleep(500U);
@@ -93,9 +94,8 @@ static void ibmvfc_async_fpin_test(struct kunit *test)
 	crq[0].scsi_id = cpu_to_be64(tgt->scsi_id);
 	crq[0].wwpn = cpu_to_be64(tgt->wwpn);
 	crq[0].node_name = cpu_to_be64(tgt->ids.node_name);
-	ibmvfc_handle_async(&crq[0], vhost);
-
-	msleep(500U);
+	ibmvfc_handle_async(&crq[0], vhost, false);
+	msleep(1U);
 
 	post[IBMVFC_AE_FPIN_LINK_CONGESTED] = READ_ONCE(fc_host->fpin_stats.cn_device_specific);
 	post[IBMVFC_AE_FPIN_PORT_CONGESTED] = READ_ONCE(tgt->rport->fpin_stats.cn);

-- 
2.54.0



