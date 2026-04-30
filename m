Return-Path: <linux-scsi+bounces-23518-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLaBBVWe82lg5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23518-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:24:21 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988F4A6E02
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD2AF3040225
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F2477E43;
	Thu, 30 Apr 2026 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SKB9xsvX"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548339D6DE
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573371; cv=none; b=mzNO0M8bW0L0NmTMBPkNYgXEcvhmtTu2KuH1I9xNA8QIC+GhrjIdmqgQPvOiThqeYfumG/5t/A7J/9ycpBRl7DQUMxkvYPc17mbaY6FkahPt6aslkmhvciyugOnpgiyph83nkhXNz8WDmdAOuUlp4YPwUESptSd7gtMnvv9PBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573371; c=relaxed/simple;
	bh=cYafpE8Aagw+72f8xp1S4C/uzFasuohihy5Q8yn3QJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFPUg1Q7U5R92NjSnfrix2nwKGuJhY4GK1Fkd+F5avn0ILr+RwAuelHsioduq8ZRjuH04ww5nrKQPZR7mcyvTSb8jjAA0zAzqvCAt1+qL4Nwek3MLEUoMWUE+NgjRzjZ6Yv0fxMZef0MmLgxohmzjBmH+Sfggpz9eUXM0yu/9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SKB9xsvX; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62bF65DXzlkQLv;
	Thu, 30 Apr 2026 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573366; x=1780165367; bh=cYafp
	E8Aagw+72f8xp1S4C/uzFasuohihy5Q8yn3QJY=; b=SKB9xsvXvYoWBh/7LbN16
	dYdR9NWb3LudAZKUV/B7LER357BCMSicIsGLKD/NkE6dUS6wL9O0/InvUBP+DQuF
	yOZm+5l9wEAsw/ATdkCUVPsec0jeLUjc6EDsVdxc3mkgi33kZ7QZZowwy5xmI1E8
	y58e9en8VxVB737QcjN5gLVkynC6rO8sustaN4aW99+FvXo+BY0fHRFfRu5yslQm
	hPkKthpqRNddl5HaZjblmgRqMJZsp7SPZmNFKLh/0L/DyZ+LH4zM1r+FRuzq63Qj
	U6AcqJS9pb7+RebubBbuxioJSH5Q+AoXRAIhOD6pbJDLWoaeTNWEUszMTL3lEpk6
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Es_w30ddVNMu; Thu, 30 Apr 2026 18:22:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62b82LlQzlhpdP;
	Thu, 30 Apr 2026 18:22:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 18/56] scsi: bfa: Enable lock context analysis
Date: Thu, 30 Apr 2026 11:19:48 -0700
Message-ID: <20260430182130.1978347-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430182130.1978347-1-bvanassche@acm.org>
References: <20260430182130.1978347-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8988F4A6E02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23518-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/bfa/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/bfa/Makefile b/drivers/scsi/bfa/Makefile
index 442fc3db8f1f..50c16fcfb01c 100644
--- a/drivers/scsi/bfa/Makefile
+++ b/drivers/scsi/bfa/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_SCSI_BFA_FC) :=3D bfa.o
=20
 bfa-y :=3D bfad.o bfad_im.o bfad_attr.o bfad_debugfs.o bfad_bsg.o

