Return-Path: <linux-scsi+bounces-25365-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jAd+EI2uQ2oEfAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25365-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 13:54:53 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ACD6E3DE7
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 13:54:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HJLBjod7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25365-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25365-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AE2D318A7E7
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A0403E96;
	Tue, 30 Jun 2026 11:29:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E23F9F5C
	for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 11:29:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818942; cv=none; b=QfcCskwZrf9opg2qWS60C7JmMJW4sgq2WPT+FFo1CJhvz9BoJ3MQAOjPIl0GAoWJJyX/LsTNzB0Xq5/AgdtgmbRZG0kbHIa0j4H+y6Uup3OAgwvNAqMkHarjGRTrPAX76qKEcmcV0bKtKpszkT2BltBpzBNYJNQP30iQ6EcLIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818942; c=relaxed/simple;
	bh=zmyxxcTJA6W5g6rX0uHMww3KMbc2ml7hirriUEBiVYI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=szQ4Kt2+JyJmcVJs5Lsm50vBM6myLvQQjIOKKGpkbC6ByxPcXmVp/Ez8kQUaYVfqqkHe3hEXs909zjBX1JwD9F545Okl8F/is7EV7mT45b0iOsaWYgj+KlU7k2n19zQwMeT/vKt4oQXWgwo4977wAxora6B94C85EBafB+KR/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJLBjod7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1E1F00A3D
	for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818941;
	bh=ylGC0+Oip17ozsvHhF7WwoR4T3rLELa+rHAon2G/TLE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HJLBjod746S8Hnf2OxINiPBX4fHpTAKndktK8faUSXHoF8HylXY0g2D5zyo3M82f1
	 vR6tUk0UTdc1CC+6frpZkKsXHhd7YOJ3NYE0h61p33CBBVsS8uAH9MVQ8aufDPgXo/
	 wGbD5DPy8OrVrgXh8lA36DxctvPOdRqCtlKMyN/ff4/DLSij0oOwLqPmKbDEi3oznt
	 oY5992D4RDNjz3Afmhn2p63JV0eiL3pNS6sHWdfTiNeWJX9c69IOkHVgtRCLjA/Xz3
	 ZsuzlG8ThaI+fUdPwW+vNpkolz0wICXnxmC9z4xtAY1XXKx4/1S3PHzMIZhJn2hM+O
	 g/fbSRpNVFaSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] scsi: ipr: use kmalloc() to allocate IPR dump
 buffer memory
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260630-b4-scsi-v1-3-494fb37ebe7b@kernel.org>
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
 <20260630-b4-scsi-v1-3-494fb37ebe7b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:28:59 +0000
Message-Id: <20260630112901.0DD1E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_TO(2.00)[];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25365-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90ACD6E3DE7

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Switching from __get_free_page() to kmalloc() for bulk PAGE_SIZE a=
llocations worsens memory fragmentation resilience and increases the likeli=
hood of allocation failure.

Pre-existing issues:
- [High] Unnecessary use of GFP_ATOMIC in a fully sleepable context drains =
atomic memory reserves and causes large allocations to fail.
--

commit 031dbb9ad5b7614bab879909db8f301be9752516
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

scsi: ipr: use kmalloc() to allocate IPR dump buffer memory

This commit replaces __get_free_page() and free_page() with kmalloc() and
kfree() for allocating the IPR dump buffer. The goal is to provide a cleaner
API without requiring casts or tracking the allocation size during free.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index d207e5e81afe0..5a212bfdeec2b 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -2893,7 +2893,7 @@ static int ipr_sdt_copy(struct ipr_ioa_cfg *ioa_cfg,
>  	       (ioa_dump->hdr.len + bytes_copied) < max_dump_size) {
>  		if (ioa_dump->page_offset >=3D PAGE_SIZE ||
>  		    ioa_dump->page_offset =3D=3D 0) {
> -			page =3D (__be32 *)__get_free_page(GFP_ATOMIC);
> +			page =3D kmalloc(PAGE_SIZE, GFP_ATOMIC);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does this allocation actually need to use
GFP_ATOMIC?

Looking at ipr_sdt_copy(), the allocation happens in a loop that explicitly
yields the CPU by calling schedule() at the end of each iteration. No spinl=
ocks
are held across the allocation (host_lock is acquired later). Since the con=
text
appears to be fully sleepable, using GFP_ATOMIC to allocate up to 80MB of m=
emory
unnecessarily drains emergency reserves, potentially starving actual atomic
contexts like interrupt handlers.

[Severity: High]
Does switching to kmalloc() for PAGE_SIZE chunks increase the likelihood of
allocation failures under memory fragmentation?

If memory debugging options like KASAN or SLUB debugging are enabled, the S=
LUB
allocator inflates the requested PAGE_SIZE with metadata. This pushes the
allocation into a larger size class (e.g., kmalloc-8k), requiring higher-or=
der
page allocations (order-1 or more) from the page allocator. Since the
allocation still uses GFP_ATOMIC, which cannot sleep or wait for direct rec=
laim,
requesting order-1+ pages is far more likely to fail under memory fragmenta=
tion
compared to the original order-0 requests.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-b4-scsi-v1=
-0-494fb37ebe7b@kernel.org?part=3D3

