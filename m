Return-Path: <linux-scsi+bounces-24718-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5aSqFGuwKmodvAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24718-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 14:56:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D667212F
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 14:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AWy9kMbI;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24718-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24718-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9EA1302EA98
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F33F1659;
	Thu, 11 Jun 2026 12:56:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB18EEBB;
	Thu, 11 Jun 2026 12:56:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182568; cv=none; b=si9sx9CLnTkw6P38vZmYk1CTT4JsyaYBYLuQ2noYfYj83Pv7pDrIs9jow450AZDf17vgqUXFhqXh6Y2Xewwa74m674VhBoPyCRwnkAUU3iHg5JydZTvQib5m3PdEi/Pi85K0JEA4PH7c9JaNoERg3q9NwqUqXWtt6DIvO9U3PdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182568; c=relaxed/simple;
	bh=DmIjU3x/SEAEpCl+gbbBkEz91WrO/E0QgXWGDEvi9CE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AAxJ4mTeD4r8YzLyDwE43J8Bwq0MP9Kty4bMu37tXgLcc/Sb5BQ7oVlBVcaXrzij5aiR8X8wn1lySdiahGy6jR6GB/jSYgrq/zhvNd5pJzt+QQPwhjqU2ReOc8Kj/JFybY/HxmOGko3jMgXdFmwuCDU1vDa3Vq6eF4g7BUPVGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWy9kMbI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1F01F00893;
	Thu, 11 Jun 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182566;
	bh=mqeGLS1xSMHnHuirRJiKVE5d1yFDFFJiKFLcDHcv4Jc=;
	h=From:To:Cc:Subject:Date;
	b=AWy9kMbIfOioVg1b+pKrNwsjvwr5PuYM4HfjzXzUPY597isqyeORxz7DxkadujbDX
	 oZINbe8Ru6xFKT3tuMjBgAjpuNz0xF/t6njNuBiDT1ugNxd3da8jdrU80I9+gU6A/W
	 vO5ttrDPxl/UDl2nnILif1TRiFuHFQ2536WCqtf1hwarJ5kX6nfVaGT+d5MrMOPWWL
	 qZL1e7x0+9dGPQjjQ6hXORWEiLv+4moFxVAoJJm8a/pjPR3EGSaNvgbePw6whHR/yY
	 Wjw1k3mGA+iUpwv1FVfp1HgvTT5t7srkhAozhcJHpouXSI6BgB1t2tkC85skgChiMI
	 4EBP98kHsI0ew==
From: Arnd Bergmann <arnd@kernel.org>
To: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
	Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bfa: reduce kernel stack usage in bfa_fcs_lport_fdmi_build_portattr_block
Date: Thu, 11 Jun 2026 14:55:56 +0200
Message-Id: <20260611125601.3385418-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-24718-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anil.gurumurthy@qlogic.com,m:sudarsana.kalluru@qlogic.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:arnd@arndb.de,m:kees@kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B32D667212F

From: Arnd Bergmann <arnd@arndb.de>

bfa_fcs_fdmi_get_portattr() gets inlined into multiple places and has two
fairly large variables on the stack, to the point of causing a warning
in some randconfig builds:

drivers/scsi/bfa/bfa_fcs_lport.c:2198:1: error: stack frame size (1560) exceeds limit (1280) in 'bfa_fcs_lport_fdmi_build_portattr_block' [-Werror,-Wframe-larger-than]
 2198 | bfa_fcs_lport_fdmi_build_portattr_block(struct bfa_fcs_lport_fdmi_s *fdmi,
      | ^
drivers/scsi/bfa/bfa_fcs_lport.c:1856:1: error: stack frame size (1600) exceeds limit (1280) in 'bfa_fcs_lport_fdmi_build_rhba_pyld' [-Werror,-Wframe-larger-than]
 1856 | bfa_fcs_lport_fdmi_build_rhba_pyld(struct bfa_fcs_lport_fdmi_s *fdmi, u8 *pyld)
      | ^

Mark the inner function as noinline_for_stack to keep it separate from
the other variables and prevent multiple copies of the same variable
to get inlined here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/bfa/bfa_fcs_lport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
index 2df399c537c1..8c9d423129c0 100644
--- a/drivers/scsi/bfa/bfa_fcs_lport.c
+++ b/drivers/scsi/bfa/bfa_fcs_lport.c
@@ -2627,7 +2627,7 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 
 }
 
-static void
+static noinline_for_stack void
 bfa_fcs_fdmi_get_portattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 			  struct bfa_fcs_fdmi_port_attr_s *port_attr)
 {
-- 
2.39.5


