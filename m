Return-Path: <linux-scsi+bounces-23539-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ5lOV+e82lg5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23539-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:24:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 947714A6E18
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CDF430073FC
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCF47CC7E;
	Thu, 30 Apr 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JUQKH9xL"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834D47A0CB
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573469; cv=none; b=DXyUrzT87dRIe3NAXJQEBFEOm0XJ0hnq0OXf8FDO4UuEcU4A+VrqmPG3RXex2yTldluNS6a2h1rgTgyoqUN9ajjFg7rgLz+zPr6c3wZoBZonrJXf39QiFIVSaYz4isu0+epxhsZG8O7+Jxm3Gc5tx3Yds4ZI5A4rR3Peivt+4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573469; c=relaxed/simple;
	bh=DmXZG1cfq9Z6xh2EA7NSAPd3Mw/ivsW7C07yq/8f0x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwzgQ+jSkrWZH2vgX4pNu20FDuPHn6nAyPs8Bra0mumVsmPmZPNTjUSYU0YqPP3guBvL98qENEs7eR6wU+tPCP/3K7j+V+Hp+AjPW2mXeiKsc1+9m0EwiMwCucBJcFGzibXljyxJklK6oYDpzxtU4PfpeyvAV6DyQl7bPmZk0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JUQKH9xL; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62d71lqXzlffts;
	Thu, 30 Apr 2026 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1777573463; x=1780165464; bh=mYDY5
	wLSD/qBDImoW5YNaScbDiQY5dFj+/NZ6SMMItg=; b=JUQKH9xLDDtc5pHl8KEO/
	6sKLGd7F2pKeFfEgnHVeGmGikc5It+sc9Awkd5Zc0e1wM3sOQR89heDf7cYJntYB
	q/5LktGHMj0y7f63UaquYGuUMn/YUCHdgQzb7uxhPhu2nZWuMDJJO2SQLm90o+3O
	I2ixJ9HYKMe50+0CIAAwEg+i/E5WXRRRs4xUjS/e5msFr0iVZuM89o3In2oPMSY9
	g9e/thXMjbH/xture+NibBXbrexhTJN3PXkw8QIknK4vp7stKQPl/lqIokf/pRvc
	vAkDanSRRG6dtJej07myWsZHl/KZHGjrvnDN83rjaVGvcTx1Hj91h7Kne+xCAMZp
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aI-AWS0g1F7R; Thu, 30 Apr 2026 18:24:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62d10Fxlzm1W0c;
	Thu, 30 Apr 2026 18:24:20 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 40/56] scsi: megaraid: Enable lock context analysis
Date: Thu, 30 Apr 2026 11:20:10 -0700
Message-ID: <20260430182130.1978347-41-bvanassche@acm.org>
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
X-Rspamd-Queue-Id: 947714A6E18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23539-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email,acm.org:dkim,acm.org:mid]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/megaraid/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/Makefile b/drivers/scsi/megaraid/Makef=
ile
index 12177e4cae65..9a6976a4dc22 100644
--- a/drivers/scsi/megaraid/Makefile
+++ b/drivers/scsi/megaraid/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_MEGARAID_MM)	+=3D megaraid_mm.o
 obj-$(CONFIG_MEGARAID_MAILBOX)	+=3D megaraid_mbox.o
 obj-$(CONFIG_MEGARAID_SAS)	+=3D megaraid_sas.o

