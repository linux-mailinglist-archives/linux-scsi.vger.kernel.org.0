Return-Path: <linux-scsi+bounces-24383-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id koG9FP0ZH2pKfwAAu9opvQ
	(envelope-from <linux-scsi+bounces-24383-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 02 Jun 2026 19:59:25 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A1630E6A
	for <lists+linux-scsi@lfdr.de>; Tue, 02 Jun 2026 19:59:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=xyO+Asj5;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24383-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24383-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB8093014C1E
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jun 2026 17:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DAE2F7F0B;
	Tue,  2 Jun 2026 17:51:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15E738C2D4
	for <linux-scsi@vger.kernel.org>; Tue,  2 Jun 2026 17:51:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422701; cv=none; b=tgRkM0dG6gvP7D9kpkoNR/pUJ9oOwm3qbsTpD/w+ms6AASlLYs+04DlHyFstHg/YOszhJbAF5D0Bm+IKf2hOHEKpk5HI2F8Hf/kCrgZ2HwmK8uVBs4yrFQ0TuU/hSjcSpp6iFV5kpiQr+SKTMKKho0ZkgxJ46EcylLTv3LgZYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422701; c=relaxed/simple;
	bh=KaG+niRaD7Ir6Mh2s737LKzS3Xej/O3jfbjYmAtdu2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhaxQbYa0e9DWjjye98Uc25OBLJhzuPV5EOwUA+ceMGC0T7krQJQQU2bo8u1ZmDalbKwRhSXaecEQkXhARfzCxN1d+Z6qcPgH4HmdrD/eBFrnWSt7IUywYIN/K7EyOtkhSHa3bQq+64UoqCLVEEsKcpmtsSsda+iZsJiAk0FCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xyO+Asj5; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gVJL22zt6zlfftv;
	Tue,  2 Jun 2026 17:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1780422695; x=1783014696; bh=KaG+niRaD7Ir6Mh2s737LKzS3Xej/O3jfbj
	YmAtdu2E=; b=xyO+Asj5umSRQgLJBxKZVj6f3GnTdMlI9dcNYSYBsdmny0RAPf2
	HZFk2xPi7cYAAkD+4uJeGlUjKVJHGWtz9Kcy/uXEzcr13eMWVnbxYov95qUoxrum
	TRtJazYYfJ7241TydiruFT/DLD7bt5IJnjBdR4HRYDPXI36voiHAHDcRVcu2NhGA
	ekVJq7p6MDQUq78ULNlJm+8HmKQviibzcJo2YQn7xgbUlPzgqEegcN+vD2a+r2Cs
	z5M1HoqTnNOyMdNPsBNeMaRPFkEU00wBikkzqolZVnFqmB4kyXQCWWswuTitDdsH
	ge5nLCMWnqcjRsy8Lj0CsJd7kPaO5WtcF3Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6RR_zOTBazqx; Tue,  2 Jun 2026 17:51:35 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gVJKw6K28zlfftZ;
	Tue,  2 Jun 2026 17:51:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@sandisk.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mailmap: Update Avri Altman's email address
Date: Tue,  2 Jun 2026 10:51:25 -0700
Message-ID: <b71be634e78d3a51048ec28fac2eaedb52d6cb09.1780422652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-24383-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:bvanassche@acm.org,m:avri.altman@sandisk.com,m:avri.altman@wdc.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 985A1630E6A

Avri Altman's email address changed from @wdc.com into @sandisk.com. Add
this information in the .mailmap file such that scripts/get_maintainer.pl
produces the correct email address for UFS kernel patches.

Cc: Avri Altman <avri.altman@sandisk.com>
Cc: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 34acd34bbf9b..d5844d97b3ff 100644
--- a/.mailmap
+++ b/.mailmap
@@ -116,6 +116,7 @@ Asutosh Das <quic_asutoshd@quicinc.com> <asutoshd@cod=
eaurora.org>
 Atish Patra <atish.patra@linux.dev> <atishp@atishpatra.org>
 Atish Patra <atish.patra@linux.dev> <atish.patra@wdc.com>
 Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com> <akdwived@codeaurora.=
org>
+Avri Altman <avri.altman@sandisk.com> <avri.altman@wdc.com>
 Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com> <bgodavar@codeaurora.=
org>

