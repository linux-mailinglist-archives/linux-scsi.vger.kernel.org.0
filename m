Return-Path: <linux-scsi+bounces-25014-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eu9kEb9GMWq+fwUAu9opvQ
	(envelope-from <linux-scsi+bounces-25014-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 14:51:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE868F9C1
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 14:51:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jXcQfX9u;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25014-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25014-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52983202C45
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1291036923B;
	Tue, 16 Jun 2026 12:45:47 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD03655D8;
	Tue, 16 Jun 2026 12:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613946; cv=none; b=akpIg1EnK441w2WE+4ss4wNrtd4HQTMArHfrPV+uJYI/XG+vvUZevWgDSHjFK5NAaCW7mYqE5SLx0abkzOJMHHZltyoR87L2KLyQiaaxGAzs9HAVdPTiF+2MYHZlKhHXP6i8E52BrcYhXqBqaCG4r6ki/q86lhDtxOlLH+C6bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613946; c=relaxed/simple;
	bh=RCyfByUDzPhStHl6hkVEtDGoBP94aW03IdaT8S2ZarU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqbbHd+15cCck0TuYPPleMLG5CYFtNe0/qblWHPNp/PG7PwCp3Bp9dYgtMTbwNJ2b8VzOHpxMOrhcjq3Yd8MxxK3VjTxcPYPmEX1W5PiMQH7YY49wmLWJe/+qSmUY72q24StRVgAEfl3ttVJsfT4LRyLWtHLMWX2z5+g9e9wa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXcQfX9u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4311F00A3D;
	Tue, 16 Jun 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613945;
	bh=yi2pkOagEpTic8aKT6y66IjNwnVguGAI/XjTm6qVQhQ=;
	h=From:To:Cc:Subject:Date;
	b=jXcQfX9uqGgevQJJ9oQIR82ogWWPi37fK/beevtHAtQTD9dRZVgs9kwwSOIOHI6/3
	 NoM0l97i1pda0NLBaIsbubjHlHpEFe5nkSdJOhJZvPp9XRxZ7/Eo8VN3sIT53K5ASM
	 eFv2eP4Qqqu6b/JPBjLfjqSSUk9bu3varcevdJL83gXVhIV0tx8p8vW0xyCQskirHz
	 K4y9BI8J9iGwBCYCwZqzyb1PuW6axoYSyohx4vh77rMfh4BGqe88f3/9oFyVNPqStM
	 PwmgTabnv+XGX1hisQyuhdfaGrOirpwIzDwyhbdT07S5ToOb25aI340QiB3dPr3MVw
	 plfyYxjtEJm6g==
From: Alexey Gladkov <legion@kernel.org>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	legion@kernel.org
Subject: [PATCH] scsi: mptfusion: Fix array out of bounds error
Date: Tue, 16 Jun 2026 14:45:28 +0200
Message-ID: <20260616124528.319527-1-legion@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25014-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sathya.prakash@broadcom.com,m:sreekanth.reddy@broadcom.com,m:suganath-prabu.subramani@broadcom.com,m:MPT-FusionLinux.pdl@broadcom.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:legion@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[legion@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legion@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90AE868F9C1

The driver retrieves the number of ports from the hardware. However, the
driver can handle no more than two such ports. It uses a fixed array for
them.

We use NumberOfPorts without checking, and maybe on actual hardware
there really are never more than two ports, but QEMU passes 8 [1][2].

[1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/mptsas.h?ref_type=heads#L7
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/mptsas.c?ref_type=heads#L619

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/message/fusion/mptbase.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 3a431ffd3e2e..05bd556bb938 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -3257,6 +3257,8 @@ GetPortFacts(MPT_ADAPTER *ioc, int portnum, int sleepFlag)
 		return -4;
 	}
 
+	BUG_ON(portnum < 0 || portnum >= ARRAY_SIZE(ioc->pfacts));
+
 	pfacts = &ioc->pfacts[portnum];
 
 	/* Destination (reply area)...  */
@@ -6701,6 +6703,7 @@ static int mpt_iocinfo_proc_show(struct seq_file *m, void *v)
 	char		 expVer[32];
 	int		 sz;
 	int		 p;
+	int		 numberOfPorts = MIN(ioc->facts.NumberOfPorts, ARRAY_SIZE(ioc->pfacts));
 
 	mpt_get_fw_exp_ver(expVer, ioc);
 
@@ -6755,7 +6758,7 @@ static int mpt_iocinfo_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, "  MaxBuses = %d\n", ioc->facts.MaxBuses);
 
 	/* per-port info */
-	for (p=0; p < ioc->facts.NumberOfPorts; p++) {
+	for (p = 0; p < numberOfPorts; p++) {
 		seq_printf(m, "  PortNumber = %d (of %d)\n",
 				p+1,
 				ioc->facts.NumberOfPorts);
-- 
2.54.0


