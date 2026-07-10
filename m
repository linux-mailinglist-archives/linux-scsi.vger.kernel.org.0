Return-Path: <linux-scsi+bounces-25952-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gRabL9GKUGpE1AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25952-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 08:01:53 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A87377C5
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 08:01:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=f6fCsdee;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25952-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25952-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58CE6300C39E
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1B3AA1B6;
	Fri, 10 Jul 2026 06:00:24 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from sender-op-o19.zoho.eu (sender-op-o19.zoho.eu [136.143.169.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5E3A6B65;
	Fri, 10 Jul 2026 06:00:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663223; cv=pass; b=KA4qkWwM8Sj1KZI4iTDnoTN661MdSfGgqzzFMsqKrRe8l739K72oizZPIoySn8i4/TvMKglCeJKxSHGmKuVB5/oMCNz4avTzbx8etn3zpPk0ij65enSLwcpGJW5LDhtMXyarRYrJpv0/BWUVZQnPWIx47DjmN9mdTY+UJLg6Yfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663223; c=relaxed/simple;
	bh=tD6TZE/kwQWjwKbbrRp1eqmr8Sgu8ZeazqdhSkPbUsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGOi8sc71ATwqjdItaz4oSSN0ZFv00Ynq7yO8W+LsGRS04reEf5qT6H3DWA0rYTnG4ikzWmwxBms8zb5tWjjAIlObq6d8yxlDuLcoCVSDbSinXpDsKfGLPauwFbsYuCQMHH/5ESMTrfh3sbS0zsukunpxCVbkoqf3RIPhcN/MLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=f6fCsdee; arc=pass smtp.client-ip=136.143.169.19
ARC-Seal: i=1; a=rsa-sha256; t=1783663205; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=d5ZHixgDiq/JUvNACt/Kjm+JuSiTMPDM33V7qQuRb0S9DFFw57gGePahVKWGpm306xZShRVs/rnDn6eDZu6JX3BAIG3TfowrNjH009OO3msfy/536UT5rAKsiRV5EH7pk6Lppl4LqkPbQWq9yunI7kvvj5ONkiF5hqz6JClJ44g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783663205; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tD6TZE/kwQWjwKbbrRp1eqmr8Sgu8ZeazqdhSkPbUsU=; 
	b=Wny2A+KL+njumKGatLKpcfnhBpkvwEdxalJTKCU869geSY3Df/yhEUaKJKZKBHVbV/SYIqB8T2pKEMHYx9rJajgiPRob0OfvqJkA0Pkpjwv0ZANgFRCyWFAQQYFuC8v9u4xF+7OSHgL4cF6UTRanJ9oJAJJDooXUUDfNFklWvaw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783663205;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tD6TZE/kwQWjwKbbrRp1eqmr8Sgu8ZeazqdhSkPbUsU=;
	b=f6fCsdeeCV4CeWPxmYqfj1atFgyRc7kxu8xutOFwoltpvolNyZJ30THN0m22L07P
	eKAovvHal3MBkNuuuISB1W3rvTnUxnXOdEpH5meL4k+Rk9mqQBf/3z1SFh2eCdJo9dK
	/P/g1Yk3jgpkhkx3xyuhnkQuXDbnJc1oyvXYbYzk=
Received: by mx.zoho.eu with SMTPS id 1783663203363639.8937187519509;
	Fri, 10 Jul 2026 08:00:03 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: dlemoal@kernel.org
Cc: martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	shinichiro.kawasaki@wdc.com,
	damien.lemoal@opensource.wdc.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: scsi_debug: fix REPORT ZONES alloc_len underflow OOB write
Date: Fri, 10 Jul 2026 07:59:59 +0200
Message-ID: <20260710060000.53909-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <1357dbf9-e135-4ba3-896d-1472a208f82f@kernel.org>
References: <1357dbf9-e135-4ba3-896d-1472a208f82f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25952-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:shinichiro.kawasaki@wdc.com,m:damien.lemoal@opensource.wdc.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auditcode.ai:from_mime,auditcode.ai:dkim,auditcode.ai:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B81A87377C5

On 2026/07/10 09:58, Damien Le Moal wrote:
> Yes, but this only partly address the issue. E.g. if the command has an
> allocation length of 64+32, rep_max_zones will incorrectly be 0, leaving
> the 32B after the header unfilled. Sure, that is a "useless" case since no
> one wants a partial zone descriptor. But the SCSI specs allow this, so
> let's do it correctly.
>
> I have a patch in my local queue that I was about to send to fix this, but
> you where faster :) What I did is:
> [...]

Thanks Damien, that makes sense. v3 adopts your ALIGN-based sizing, so a
partial trailing zone descriptor is now built and returned correctly
(Suggested-by: you).

While verifying it I noticed one corner in that snippet: ALIGN(alloc_len, 64)
and the 64 * (rep_max_zones + 1) size product are both evaluated in 32-bit.
alloc_len is the full 32-bit CDB allocation length, so a value just below
U32_MAX (e.g. 0xFFFFFFF0) wraps the aligned length and the size back down to a
tiny/zero value: kzalloc() then returns a ZERO_SIZE_PTR / tiny buffer while
rep_max_zones is huge, which reintroduces the same out-of-bounds write. v3
does the ALIGN and the size computation in 64-bit (cast alloc_len to u64, u64
block size), so that case just fails the large allocation and returns a check
condition instead.

Verified under KASAN: alloc_len=96 now returns the header plus a 32-byte
partial descriptor, and alloc_len=0xFFFFFFF0 returns INSUFF_RES with no KASAN
report.

Flagging it in case the copy of this pattern in your queued patch has the same
corner.

Thanks again for the review,
Ibrahim

