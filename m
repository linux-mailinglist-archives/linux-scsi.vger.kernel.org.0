Return-Path: <linux-scsi+bounces-23528-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJd4G5We82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23528-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:25:25 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C365C4A6E52
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 842643031CD3
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A0421F06;
	Thu, 30 Apr 2026 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pH8su4MC"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4647B425
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573421; cv=none; b=kQ8hsPhrz+km08f6inGZ8GP10dCaaLt+LgkIgJZDIPGHHVJXz6+N1TjCtBTQcOosiZE0ur7jrDIDv2rnf/E/BTmy9z5nUts52aKw3ZjtL4zhrhJ+wYpJF8owRs/Wdp2UeBNiDQ7HfeY6ftUD+2CusgpK74+mH8qC2WtfzastXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573421; c=relaxed/simple;
	bh=WfD1C7BrZ237KCoGnyS1XeW6DyGm2EG9QthAs6D/EcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQ/IrGR9wPnXL63U7pBn56GlEMpfmuGE745dnLdu6eVp6Kc6gkMjn8ac+gKouDaxBd9bQW6rmfXO6qzf3pAIhnN9q4w92PbgBxIqy7d2Vx11xBtvu5w9Uct8AbVdrH4YnPfLxMJYoY6WWDtEOgRd8b785vpXtYnNOryKz3oP8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pH8su4MC; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62cC4hvkzlfvpH;
	Thu, 30 Apr 2026 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573416; x=1780165417; bh=4NRjQ
	IMe6R9Sll0sME7XSFTSdIvnqVLQ0a15bLxeXYA=; b=pH8su4MCvLuOHOrVBJI7w
	fnmhx/Z2dABlJ+NUuj0RBSGiazibIvXk5tb9VmPwPAm90zbMjtQHbsk52eLMIU0z
	HJ1NOFMFvKskczUX2SkxTqivMsggVolSeYIPBC+kVpRd+pKyA6wPJxJdCeRyr+Ff
	1BpIyzdr5Hc3jbo4kuE/T3nnGse7Cjgj58KtDwtf3u7yiaHfndaSROf4s/YiuRTC
	fgOs6D1JXjpab/VN4vz3BxErcVCAi0sDaZREeZ+CaNFBAitUTgM8H7Zx0BP4Y0TN
	BZ8d5M6OYYjgNkyE8CrS7MHPTZSM6QAIc/rmRfklzpJGhwN03SH9f9DhnlCupBb4
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id M4Ax2sSopMqp; Thu, 30 Apr 2026 18:23:36 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62c63gdZzlfl89;
	Thu, 30 Apr 2026 18:23:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 29/56] scsi: ibmvscsi: Enable lock context analysis
Date: Thu, 30 Apr 2026 11:19:59 -0700
Message-ID: <20260430182130.1978347-30-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: C365C4A6E52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23528-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/ibmvscsi/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/Makefile b/drivers/scsi/ibmvscsi/Makef=
ile
index 5eb1cb1a0028..a497c6c0985a 100644
--- a/drivers/scsi/ibmvscsi/Makefile
+++ b/drivers/scsi/ibmvscsi/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_SCSI_IBMVSCSI)	+=3D ibmvscsi.o
 obj-$(CONFIG_SCSI_IBMVFC)	+=3D ibmvfc.o

