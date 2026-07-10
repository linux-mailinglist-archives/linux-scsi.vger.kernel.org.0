Return-Path: <linux-scsi+bounces-25948-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NVXYHCF+UGoS0AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25948-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 07:07:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599037373BA
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 07:07:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DSF7xmFe;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25948-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25948-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB460300E68D
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 05:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E026A1C4;
	Fri, 10 Jul 2026 05:06:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A33750DC
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 05:06:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660018; cv=none; b=iyyp0yqkoicI8RzM0V/PyCA45mkCjP+MGD0d5hNTwZfVXmzT/wt/LJPTuWvhS5z1nxfldRCifJQfWERzA9mTRjjrHZjiiDKSTIMvWH3aI13WXwPPrCO/RfoTsy/Y9fO4YjyfJI2QovV9Jo+KA1OXE2LBKN2kzyCPDP2qVAhIAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660018; c=relaxed/simple;
	bh=CBxJGxNLXTZa+4GkCgJgl7hIUuvDLwrTMXiLlOdjvAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K72lmKTvdCXaSSvzRxrb9cI5IMIhKADixFkGLLthjZqgyc4VPXtfFsEaK484lnhJTuEB6kIDHHHbpYwqrj4+S2b6HAVC37yIbInCdiV+jrMkS6qIsmQRJAzsymGbsVWfAu0VZiDR1oODc4xfh+WXM+gJ0aCwh0s6UQuCOoWOl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSF7xmFe; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacd69a9c0so4543155ad.1
        for <linux-scsi@vger.kernel.org>; Thu, 09 Jul 2026 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783660015; x=1784264815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pWNfAMp36IVbKDCLkOUVS83/PLFc14nRvYbSDKyBhWs=;
        b=DSF7xmFeZ5CcUAKKkxU/UUwQgeytF1puvc+y66yAGfImBexwrFVsV82O3dZqCDmPp0
         SPm+UP/KlmRqHKeQRVvcVN5sjYX/sI49a5p9eQhZA3c68NmncnA0rsQwwmtYFsKj2hIg
         3LWrjyCA/tMZU/p9jycIjrjYMi63D+15r3T44V01bHSQ//yHlJ+bBb9Tu7Kx1HTXtL59
         2HMFFplBIboY9gMRaOFzp8+8sDkxKxpK7lkLg1Owh8EVHEvztI7ek8GP9mQlRQsHHf/q
         l+HtnjDgs84KNMhwdTPpUgVW7If3DoOfVDCCXn5JQvSaJ2YvRlfr4UsjjEU/ve/YhJuu
         YOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783660015; x=1784264815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWNfAMp36IVbKDCLkOUVS83/PLFc14nRvYbSDKyBhWs=;
        b=FSdYw2EoDh4xIDfk+N6m2X1zlj521HWCuFOijOs4o4lgdpxcJNmPRSIJlg5ywoNGLg
         K9sY7qg/shAd09h5W2Z52TM9eneZs2bDryirhK/dHtlFcqCFD4MG815tZxN6aInQOba4
         1JCTSjekuQrRN1pF9TUWvIqBPbmbGxvD3JlbAZcJjq1wgDDwgUXUre3t4Dj7UT0csneO
         eiDsFNbI3iDOszrbbKy7lzEVGRPf3Xxv9y5RoADBhWpnWBJKOsCeknSTEjd9ZjFkZFMo
         5oG5nvvpSAz4ZoIJqRuFW5qHBVpTLlKF1bty0+YPkVZNx9Ut3Z7IBzMZKZAq0axiUa+D
         uI3A==
X-Forwarded-Encrypted: i=1; AHgh+Rq8aAGAocjZN4AMzZBF6w0WXTuJcnSCv5OX5mXGiCZT6tIVYDM6/wXlL/uBFXajmoaE+ivKikrMfm2a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pmDk5t0guNzknqknNbHjBxqnEX+M++gr+htUAR4gPCGv159r
	w7E4QKkXUXg2IPkz9sEXU1JvKxM2pBj5vCcRHjgn1r6t+iL7pdJ4McyN
X-Gm-Gg: AfdE7ckKF8OzCD1qh0x73RXblGDiX5SypwjEeLrcEPkBIRy/CXh9KOOz6Hbzygdv2HS
	Ds/Nv7+qO9sDBQRBWL9VJ/RIgZ4G+5IK0XzP+B/ecwM3BL8f+GNqfntZUKokqvCxA6jDUg9jlGg
	fxAmqP+Piu/5j9dC9ZvYBo0cU4aVS+Yrr02wB51hwDaZbgSSjrhgNcxURzaQDP5qFjhf/zMk35F
	77Adq2QQIm9Kc0JOi7Z2gsqC08JzdlpsywLWjCa0N23DF4niGajRzM5VANa2rq5gdf2w/Jxx3fS
	OeRUWJV/u2zEbnsB9TDP46U1Y63YbZcvxzTWo7PAIKBNS7QVUwJUreU/7bXyZRSeFleERbVkUdF
	K8p+irP44kCfndhuZWupR3ZnS+YGhDuMtIq2nFhs9KtLQo8YB0N5s8VzyKFKjJSYS50jHUR2LXu
	HVkvCHTULz1s5Z6MS+Xd5sLEYrji1RVj/duaN6cvyunMu7kbfwkL/K0zlWLRYAtEsYxMCh2z6zU
	RyfUlKHLyp+HusU
X-Received: by 2002:a17:903:110f:b0:2c9:bd64:8c8b with SMTP id d9443c01a7336-2ccea40dd61mr109250695ad.31.1783660015427;
        Thu, 09 Jul 2026 22:06:55 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3c99fsm53688015ad.68.2026.07.09.22.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:06:54 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Mike Christie <michael.christie@oracle.com>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] scsi: libiscsi_tcp: bound SCSI Response data segment to the connection buffer
Date: Fri, 10 Jul 2026 14:06:45 +0900
Message-ID: <20260710050645.1194212-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,googlegroups.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25948-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.christie@oracle.com,m:lduncan@suse.com,m:cleech@redhat.com,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:open-iscsi@googlegroups.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sammiee5311@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sammiee5311@gmail.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sammiee5311@gmail.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 599037373BA

iscsi_tcp_hdr_dissect() receives the data segment of several PDU types
into the fixed-size conn->data buffer, which is allocated for
ISCSI_DEF_MAX_RECV_SEG_LEN (8192) bytes.  For the LOGIN_RSP, TEXT_RSP,
REJECT and ASYNC_EVENT opcodes the dissect path already rejects a PDU
whose DataSegmentLength exceeds that buffer.

The SCSI Command Response (ISCSI_OP_SCSI_CMD_RSP) path also copies its
data segment (sense/response data) into conn->data via
iscsi_tcp_data_recv_prep(), but it does so without the same check.  The
only upstream bound on in.datalen is conn->max_recv_dlength, the
initiator's advertised MaxRecvDataSegmentLength, which is commonly
negotiated well above 8192 (open-iscsi defaults to 262144).  A target
that returns a SCSI Response with a DataSegmentLength between 8193 and
max_recv_dlength therefore overflows the 8192-byte conn->data buffer.

Apply the same bound used by the sibling opcodes before handing the
data segment to conn->data.

Fixes: a081c13e39b5 ("[SCSI] iscsi_tcp: split module into lib and lld")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/scsi/libiscsi_tcp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index e90805ba868f..790d11ec00bc 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -753,6 +753,18 @@ iscsi_tcp_hdr_dissect(struct iscsi_conn *conn, struct iscsi_hdr *hdr)
 		spin_unlock(&conn->session->back_lock);
 		break;
 	case ISCSI_OP_SCSI_CMD_RSP:
+		/*
+		 * Sense/response data is received into conn->data, so bound
+		 * it to that buffer like the responses handled below.
+		 */
+		if (tcp_conn->in.datalen > ISCSI_DEF_MAX_RECV_SEG_LEN) {
+			iscsi_conn_printk(KERN_ERR, conn,
+					  "iscsi_tcp: received buffer of len %u but conn buffer is only %u (opcode %0x)\n",
+					  tcp_conn->in.datalen,
+					  ISCSI_DEF_MAX_RECV_SEG_LEN, opcode);
+			rc = ISCSI_ERR_PROTO;
+			break;
+		}
 		if (tcp_conn->in.datalen) {
 			iscsi_tcp_data_recv_prep(tcp_conn);
 			return 0;
-- 
2.43.0


