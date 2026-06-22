Return-Path: <linux-scsi+bounces-25105-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h8ecN3/rOGpRkAcAu9opvQ
	(envelope-from <linux-scsi+bounces-25105-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 09:59:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DCB6AD776
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 09:59:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=eMhbPW4A;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25105-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25105-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D787A3006513
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B0383328;
	Mon, 22 Jun 2026 07:59:56 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537B361675;
	Mon, 22 Jun 2026 07:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115196; cv=none; b=CrQzYctDzrVNcOkWXjFrmgydp7+Yo4Id4eqDtQefs4D5vXDf0x7GVUILGwvWlUkEx94njY9Q+7PEb7Du61AN5rjw2mAAGpkRcI46Hr+h71EkF+sqvDeU82LT0NevtCsvh2d2quabQfU2oe/P6CbWlAPdvD6HYoaoas3Zy8pa0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115196; c=relaxed/simple;
	bh=qyBaaWnYRbK7XCAbAJbWuep5cFL9E/JUZL/x+Cq/CYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8J1oS0Lt7aJz/4Dirv89V0Dlu5GRzMGmOUAZG4WFCqKsjQbxD33IwskofsNqpsT6dxDkK+N3E7pHtFzkbPZTkC7POGgmL900stt4PEqpuFWHCvU3ksrkjPzdmUaws2b/dzh7xn1haQJTIu3eJ7KxgaVc2MYegQK0a77eFlurBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eMhbPW4A; arc=none smtp.client-ip=220.197.31.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ws
	C9plxLC49dLoH7qzqis/G3QGv01+Xrfj7bJMYdBtE=; b=eMhbPW4A+xpCxezzUb
	p6ljtzbsufNBos05mhI+GMooS5VAAhvcSSUFadlUkiBynfiv0VnjrpK7Tn6kTPLv
	qx0P0ckt66X/RXdHE0KCxW2oVGZf6ELA9RcA39pefdqSvQsVuieig0BgCD/HvbQR
	19BfYNXvrMbSdPiCnBucelB5E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnNwU16zhqBIo_FA--.7653S2;
	Mon, 22 Jun 2026 15:58:47 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: ram.vegesna@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	dwagner@suse.de,
	jsmart2021@gmail.com,
	hare@suse.de
Cc: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: Fix IO leak on unsupported additional CDB
Date: Mon, 22 Jun 2026 15:58:44 +0800
Message-Id: <20260622075844.832871-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnNwU16zhqBIo_FA--.7653S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF17ZF4fur4rtr18tr4xJFb_yoWDCrg_ur
	4rXryfZrnYkF1kGF4rtF4fZayaka1Duwn7ZF1Fg34Fgr47ZrWUCw1DArZag3yUJrZ2yFZ5
	Ww17ZFWUCr17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRPfHUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hewH2o46zdBawAA3y
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25105-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ram.vegesna@broadcom.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:dwagner@suse.de,m:jsmart2021@gmail.com,m:hare@suse.de,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[broadcom.com,HansenPartnership.com,oracle.com,suse.de,gmail.com];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0DCB6AD776

efct_dispatch_fcp_cmd() allocates an efct_io before dispatching an
unsolicited FCP command. If the command has an unsupported additional
CDB, the function returns -EIO before handing the IO to the SCSI layer.

Free the allocated IO before returning from this error path.

Fixes: f45ae6aac0a0 ("scsi: elx: efct: Unsolicited FC frame processing routines")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/scsi/elx/efct/efct_unsol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/elx/efct/efct_unsol.c b/drivers/scsi/elx/efct/efct_unsol.c
index e6addab66a60..6a871a59c909 100644
--- a/drivers/scsi/elx/efct/efct_unsol.c
+++ b/drivers/scsi/elx/efct/efct_unsol.c
@@ -385,6 +385,7 @@ efct_dispatch_fcp_cmd(struct efct_node *node, struct efc_hw_sequence *seq)
 
 		if (cmnd->fc_flags & FCP_CFL_LEN_MASK) {
 			efc_log_err(efct, "Additional CDB not supported\n");
+			efct_scsi_io_free(io);
 			return -EIO;
 		}
 		/*
-- 
2.25.1


