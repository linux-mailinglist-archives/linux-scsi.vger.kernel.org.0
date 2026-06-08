Return-Path: <linux-scsi+bounces-24547-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QTYhC0gKJ2qZqgIAu9opvQ
	(envelope-from <linux-scsi+bounces-24547-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 20:30:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E84C659B87
	for <lists+linux-scsi@lfdr.de>; Mon, 08 Jun 2026 20:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=J379PECU;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24547-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24547-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41B2230258BA
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2026 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED83E0C51;
	Mon,  8 Jun 2026 18:30:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0D3D564B;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943425; cv=none; b=UICj2R54mkqnQXNxl8NLWFXIyDgYbUyVBhBJ6lZ6iCXkHRKiVN+Qihx8IX8U3nCMFHDeJ9eryTJ+7l3kjz34YwkZaEKkpZl9BaE96tXSuWXanS9BtB7Bp07h5a7RRa9mRtht3mkvtfkeP5XXlAbZua4DKIJOnsupuxaInCwckTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943425; c=relaxed/simple;
	bh=WN/uN4JdRNJqo5v7zBaxw2Rc3Vdl8fe2Ys3xy2D3LPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJpMvpzJOplVFUiaLGGbcHH/kO47IYXQ0Tn1h2dlayl3sdAgRM+EV5eGrpMXowFayE94xd7Y2ObXf/Fz+lGW+v9HIhQwdCXGKR0dZ3Ecq6i1G4qhXkUpwNJ1hZVeLA1DHPkC7sDKR91me03jxWHNQKaLKp2BMjZD7RErXmuM0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J379PECU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAA07C4AF13;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780943424;
	bh=WN/uN4JdRNJqo5v7zBaxw2Rc3Vdl8fe2Ys3xy2D3LPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J379PECUfuqCe33XlMQCTJscX9efWVmAcjxTnUBdzqbFk0O4ETRy0X0ktHBe3MPFZ
	 HPnhx+vUFAmwhdBjacYKtkQ18jFFyaXGO62Zz9hdlsb0WC25H/Xx56tvKOoGvIiRfH
	 BhGn4dJE8u/CdWvWQ4njJAzCdR4e8fgKca8vIMTuz2maI9mYKC7/bF4HRLK0Nbbmyu
	 LRN4iGnRMuuzCpmaDJ//5e8rGwGN4BBIHZftUq+oS9R+UyWW8oZ0hvihxFUY5+usUS
	 aW+VenLxoRYU6V5/7TpwZvdZ+nV9r7xaQGh7z18Jl2SylIb1pQecF50RMveM5TbZV0
	 4cZXf379VhbPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7046CD8CAA;
	Mon,  8 Jun 2026 18:30:24 +0000 (UTC)
From: Dave Marquardt via B4 Relay <devnull+davemarq.linux.ibm.com@kernel.org>
Date: Mon, 08 Jun 2026 13:30:19 -0500
Subject: [PATCH v2 4/7] ibmvfc: define asynchronous sub-queue
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ibmvfc-fpin-support-v2-4-d41f540fba5c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780943423; l=2517;
 i=davemarq@linux.ibm.com; s=20260216; h=from:subject:message-id;
 bh=yA6tb5h9yHjsRv3RYlRjKBFZQlRZRIaWtxJ2hzF2GyA=;
 b=0zrGohOtPsnfaeBPgoDs9nTfdpfFnt/2uEoXKfYHbtytnom9kUeHBoNyfjGEzkpQAB30mVgTd
 HQfrSUFgk4/B0+KYMqQGg8fth2alskc6gW6XrA6ROFh1/+31hSzAJCM
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-24547-lists,linux-scsi=lfdr.de,davemarq.linux.ibm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:replyto,linux.ibm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E84C659B87

From: Dave Marquardt <davemarq@linux.ibm.com>

Adds the asynchronous sub-queue structure, modifies the existing
channel setup structure, adds the asynchronous sub-queue to the
channels structure, and adds flags needed to tell VIOS to use the
sub-queue.
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index c996b36d335d..f026f30f98d3 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -181,6 +181,8 @@ struct ibmvfc_npiv_login {
 #define IBMVFC_CAN_HANDLE_FPIN		0x04
 #define IBMVFC_CAN_USE_MAD_VERSION	0x08
 #define IBMVFC_CAN_SEND_VF_WWPN		0x10
+#define IBMVFC_YES_SCSI			0x40
+#define IBMVFC_USE_ASYNC_SUBQ		0x100
 #define IBMVFC_CAN_USE_NOOP_CMD		0x200
 	__be64 node_name;
 	struct srp_direct_buf async;
@@ -229,6 +231,7 @@ struct ibmvfc_npiv_login_resp {
 #define IBMVFC_HANDLE_VF_WWPN		0x40
 #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
 #define IBMVFC_SUPPORT_SCSI		0x200
+#define IBMVFC_SUPPORT_ASYNC_SUBQ	0x800
 #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
 	__be32 max_cmds;
 	__be32 scsi_id_sz;
@@ -563,7 +566,7 @@ struct ibmvfc_channel_setup_mad {
 	struct srp_direct_buf buffer;
 } __packed __aligned(8);
 
-#define IBMVFC_MAX_CHANNELS	502
+#define IBMVFC_MAX_CHANNELS	501
 
 struct ibmvfc_channel_setup {
 	__be32 flags;
@@ -578,6 +581,7 @@ struct ibmvfc_channel_setup {
 	struct srp_direct_buf buffer;
 	__be64 reserved2[5];
 	__be64 channel_handles[IBMVFC_MAX_CHANNELS];
+	__be64 asyncSubqHandle;
 } __packed __aligned(8);
 
 struct ibmvfc_connection_info {
@@ -714,6 +718,25 @@ struct ibmvfc_async_work {
 	struct work_struct async_work_s;
 };
 
+struct ibmvfc_async_subq {
+	volatile u8 valid;
+#define IBMVFC_ASYNC_ID_IS_ASSOC_ID	0x01
+#define IBMVFC_FC_EEH			0x04
+#define IBMVFC_FC_FW_UPDATE		0x08
+#define IBMVFC_FC_FW_DUMP		0x10
+	u8 flags;
+	u8 link_state;
+	u8 fpin_status;
+	__be16 event;
+	__be16 pad;
+	volatile __be64 wwpn;
+	volatile __be64 nport_id;
+	union {
+		__be64 node_name;
+		__be64 assoc_id;
+	} id;
+} __packed __aligned(8);
+
 union ibmvfc_iu {
 	struct ibmvfc_mad_common mad_common;
 	struct ibmvfc_npiv_login_mad npiv_login;
@@ -853,6 +876,7 @@ struct ibmvfc_queue {
 
 struct ibmvfc_channels {
 	struct ibmvfc_queue *scrqs;
+	struct ibmvfc_queue *async_scrq;
 	enum ibmvfc_protocol protocol;
 	unsigned int active_queues;
 	unsigned int desired_queues;

-- 
2.54.0



