Return-Path: <linux-scsi+bounces-24548-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kBUPBF4NJ2plqwIAu9opvQ
	(envelope-from <linux-scsi+bounces-24548-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 20:43:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD7659D15
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 20:43:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="jkT/QsPt";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24548-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24548-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19B1303C3C8
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2026 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D503E0C50;
	Mon,  8 Jun 2026 18:30:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBE3E00B0;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943425; cv=none; b=iGwIkvnkcOJ/yDYW1JKRx8LkcrssnAWwATjm/zbYJ+1ZWu7uJauX1gMfyxqs4Ibq9N2aQ4j5aTex/2go2LR8IiKJssjrwGyli2ztGxiOhIHFYi1uSZV5kaxQxiA313uQXT85ufq3x3jLyf36w6gGIGXcO2Vp+CNge9Sq7Ue2QDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943425; c=relaxed/simple;
	bh=syQ2Gyfc9rjR++Qbi/B4XF6b6fWOAKQxLqM1f57Ohlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKyHzphh5bOnuw52wFudpnxixFQncE8LOl+0Wrn62hV43/aWY2FAwjrrvsCCg8DGnXjplzLvPjG7vzdgWTU/XsG6rQ0g4rOxANomd2ZE3giHD/uFOWsr9seoIA1ZQsDwo9yzqoYWte1FN5p2cma10Q5Jomr9rK9wGwowORkyPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkT/QsPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B22DEC4AF0F;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780943424;
	bh=syQ2Gyfc9rjR++Qbi/B4XF6b6fWOAKQxLqM1f57Ohlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jkT/QsPt64fc0GVg3HR+FVFRCf3Jm/T+AlX3p7nnpGtRnkabla6vYZsA65iuzIzu1
	 wmjySUNAMQjNXaW5Ju9+CPIwoGBO8+pyBCuSwXLjS01xSsb7/6moGIm6R8k/FhQUYs
	 9kgRxz6JGR9TIsUZ0cQ2WO8jVfj10Tm9NDXRESt8bDxYXr2ZiKUUWyuesv0356Q9qs
	 11en16v+KFndvm6d+rE5O04SPZ5JbCaGIJvtKciAtOrWf0LiK30ewSTwM22LxoxKl8
	 pAgSt8Q5coIbdart0BLfRX2t9DqW4QzSiGAvPY+qUPoGBE61vyR8MKuqZLvozKTNml
	 ZHO6UoUrLigUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A296BCD8CA7;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 08 Jun 2026 13:30:17 -0500
Subject: [PATCH v2 2/7] ibmvfc: Add NOOP command support
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ibmvfc-fpin-support-v2-2-d41f540fba5c@linux.ibm.com>
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
In-Reply-To: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780943423; l=2828;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=Yeji3bKeI5rUvEPYFGrDZIoKZAiKRNWAIVzz/y+TjH0=;
 b=VISqN10F2dbrQ3+yRvqjDLLI5tfZWHem+gzHw4ZulDCgFQqdO7n8bKyUJjNaJT/w2R0JwFRuZ
 zMo+gv4n7MCDyDj7KGi9yUX0Rp4cpQcXwOux1E1k70ri4LDTb6+kP0z
X-Developer-Key: i=davemarq@linux.ibm.com; a=ed25519;
 pk=vy0/nfobrje6EqZxuyw6a3ZstytG8WK2vf5Y3xtGrEg=
X-Endpoint-Received: by B4 Relay for davemarq@linux.ibm.com/20260216 with
 auth_id=689
X-Original-From: Dave Marquardt <davemarq@linux.ibm.com>
Reply-To: davemarq@linux.ibm.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tyreld@linux.ibm.com,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:brking@linux.ibm.com,m:gjoyce@linux.ibm.com,m:kmahlkuc@linux.ibm.com,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	FREEMAIL_TO(0.00)[HansenPartnership.com,oracle.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24548-lists,linux-scsi=lfdr.de,davemarq.linux.ibm.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	HAS_REPLYTO(0.00)[davemarq@linux.ibm.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:replyto,linux.ibm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BFD7659D15

From: Dave Marquardt <davemarq@linux.ibm.com>

This patch adds support for receiving and recognizing VFC_NOOP
messages from VIOS. This is done by
- defining the VFC_NOOP CRQ format
- recognizing the VFC_NOOP CRQ format in the CRQ handler. If the VIOS
  has not provided the "support VFC_NOOP" bit in its capabilities on
  NPIV login, note that the VFC_NOOP is unexpected
- setting the "can use VFC_NOOP" bit in the capabilities sent during
  NPIV login
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 11 ++++++++++-
 drivers/scsi/ibmvscsi/ibmvfc.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 9e5f0c0f0369..88386d7c9106 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1512,7 +1512,9 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 		login_info->flags |= cpu_to_be16(IBMVFC_CLIENT_MIGRATED);
 
 	login_info->max_cmds = cpu_to_be32(max_cmds);
-	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
+	login_info->capabilities =
+		cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN |
+			    IBMVFC_CAN_USE_NOOP_CMD);
 
 	if (vhost->mq_enabled || vhost->using_channels)
 		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
@@ -3555,6 +3557,13 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 	if (crq->format == IBMVFC_ASYNC_EVENT)
 		return;
 
+	if (crq->format == IBMVFC_VFC_NOOP) {
+		if (!ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
+			dev_err_ratelimited(vhost->dev,
+					    "Received unexpected NOOP command from partner\n");
+		return;
+	}
+
 	/* The only kind of payload CRQs we should get are responses to
 	 * things we send. Make sure this response is to something we
 	 * actually sent
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index 8eb1493cbac8..dd26248cac3e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -180,6 +180,7 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_HANDLE_FPIN		0x04
 #define IBMVFC_CAN_USE_MAD_VERSION	0x08
 #define IBMVFC_CAN_SEND_VF_WWPN		0x10
+#define IBMVFC_CAN_USE_NOOP_CMD		0x200
 	__be64 node_name;
 	struct srp_direct_buf async;
 	u8 partition_name[IBMVFC_MAX_NAME];
@@ -226,6 +227,7 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_MAD_VERSION_CAP		0x20
 #define IBMVFC_HANDLE_VF_WWPN		0x40
 #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
+#define IBMVFC_SUPPORT_NOOP_CMD		0x1000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
 	__be64 max_dma_len;
@@ -621,6 +623,7 @@ struct ibmvfc_trace_entry {
 enum ibmvfc_crq_formats {
 	IBMVFC_CMD_FORMAT		= 0x01,
 	IBMVFC_ASYNC_EVENT	= 0x02,
+	IBMVFC_VFC_NOOP		= 0x03,
 	IBMVFC_MAD_FORMAT		= 0x04,
 };
 

-- 
2.54.0



