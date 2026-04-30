Return-Path: <linux-scsi+bounces-23553-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L9QJVCf82ly5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23553-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:28:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E654A6F20
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76BA6309C64D
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9447CC69;
	Thu, 30 Apr 2026 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ib4DLHI/"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8D47B425
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573538; cv=none; b=Ll3E4pll1ULAuxRiSesTEABiz2D7ABJ4xRI0wjWrgFMEM6bM38SEXef6vK/DYa5cxFeiahQJHKeK1GcHzK6qopndm/QLPCfkfnUfdrzHpj918FwmNUK7jywjy9nLfnKtAjUUYrrrbX76yvK5JPMQQ5NnXM6q7kcRTZu/XUCmEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573538; c=relaxed/simple;
	bh=OB+HnxD8bXxEIxw9vh0A+aul7O/XOT0PpPT0l6/58Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5RIV9Rn/WMYKxmhp7GrFOlV3WW31NKlkLvESCohTuGZ+l9wDKArFwOhMsmHkdMzH+AhKO/AAcmo0WXNHlsAL+3Nh62KLoyua7Bxcc+GWU0kChFOzzbuPl7ve8IT/BIM8oOhFUB+2IjqkdNqimZ0evR6YnBqP6YvuDDGXnysCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ib4DLHI/; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62fS5m0jzlfdfN;
	Thu, 30 Apr 2026 18:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573534; x=1780165535; bh=OB+Hn
	xD8bXxEIxw9vh0A+aul7O/XOT0PpPT0l6/58Lg=; b=ib4DLHI/y2/ozH+W9TjQX
	D+r3PxslEynB5qldfZxOPBm/NfEOPNtmRJuBwdoP7tsRdSRx11PgcBRK1WSHq+HI
	ZrheasiYUTJc1F85lE0MAcshGYfyx48d+/Kqf40jmLtKuf7sOwEQYAohpg3A8B43
	L7+d/5+X9b36ZlsMtrYGajkIj6vycUvq2xLAgjSXrD1w05bU+bcVURX2u0s863G5
	CMptaG8U38nP06yDmFcl3OZgX8zeAR5y49oTROl/fK3aGJDES6KLQDsbSTMY5bm9
	LxhlzfHDRjO/bYBlglo+xbGI0Kma9UvtCXN4j/ebpSt4Uoztny/TchvM8kuwWudg
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ff7-c7NOP9YK; Thu, 30 Apr 2026 18:25:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62fN54s2zlfvpH;
	Thu, 30 Apr 2026 18:25:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 54/56] scsi: sym53c8xx_2: Enable lock context analysis
Date: Thu, 30 Apr 2026 11:20:24 -0700
Message-ID: <20260430182130.1978347-55-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: D5E654A6F20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23553-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sym53c8xx_2/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sym53c8xx_2/Makefile b/drivers/scsi/sym53c8xx_2=
/Makefile
index 0751e2a0cd82..c28fb2b65622 100644
--- a/drivers/scsi/sym53c8xx_2/Makefile
+++ b/drivers/scsi/sym53c8xx_2/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Makefile for the NCR/SYMBIOS/LSI 53C8XX PCI SCSI controllers driver.
=20
+CONTEXT_ANALYSIS :=3D y
+
 sym53c8xx-objs :=3D sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_nvra=
m.o
 obj-$(CONFIG_SCSI_SYM53C8XX_2) :=3D sym53c8xx.o

