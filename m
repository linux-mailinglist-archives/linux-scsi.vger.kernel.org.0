Return-Path: <linux-scsi+bounces-25954-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iiccLOSLUGqZ1AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25954-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 08:06:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03524737853
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 08:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nZNeORpu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25954-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25954-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380BC301C3C3
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43C3254A2;
	Fri, 10 Jul 2026 06:05:44 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DE384248
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 06:05:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663544; cv=none; b=ajgu6UXRnBYlvPSJDzjXpYYgcAK+O7mWsDoSnxeEgtd4TYZVpSoH9ygnu4UA7JdIyw29jdSAvTtk2KufcCzs/2/zHWB1gQJeM1qK+7nfoCG9eSlTGF8fSKtUVdnW3q/R3tOw0dhuPyfXmI7mwCJe+rSY4L1kEB/d4avb5gygfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663544; c=relaxed/simple;
	bh=nRlunw+cFVKJZy8CK/YR6vl+H4a6LD4tA08A8KF9jrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a1y3D9gvXLSiHtTQGWD5Ym2V89Eg2DYZkAkVGhcvWMxxg0R6BDsFgSoqPRXheRmjOPuj7MYRYhoPV7u0icFeF4Dvr2oAbhizbQnuSGvuCja5YfpdFqQ/w7pizjDOZJb5puSmzk1a4orMAbnkcZRAAyjohmxFkTA+PjWya6+rcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZNeORpu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621591F000E9;
	Fri, 10 Jul 2026 06:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783663543;
	bh=AK3mdKx4nxFf8STZGvgtfw+QqlBol2EZRLMqaLgaRP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZNeORpuGuxEbdxQnOARXXJD8Dh3y9U4RsT80tnXArPr0bJnyarwTiVAjuMlY+IcG
	 xpkSbF0Ydby7Sa7F9YQDzV755KVprzyXdrmjmB7vYLhRnE3zmN6LfQK6zwQ+/pzhdB
	 OJg4ZFP59pTL6BMP2+OwY4GLYtGG2DOS6O1MRFF6KI2Yyg3NcZDYYWWRx7H1wxDB5f
	 HhklWyb7My4HxFzwN/TEDBDjaGvNWGef0xYNE4RdI9jWNDY3rex/jsbE8wZzjmAQ2O
	 9xqZu2pjN8LiE2Uw91R0trDrytBRopTqxI4OI8chKis2UuzQ+aWDkFUPaSI4GUTVxq
	 nUKge46iaNewA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] scsi: scsi_debug: fix REPORT ZONES alloc_len
 underflow OOB write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260710055755.53830-1-security@auditcode.ai>
References: <1357dbf9-e135-4ba3-896d-1472a208f82f@kernel.org>
 <20260710055755.53830-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 06:05:42 +0000
Message-Id: <20260710060543.621591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25954-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:security@auditcode.ai,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,auditcode.ai:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03524737853

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer truncation on 32-bit platforms leads to ZERO_SIZE_PTR out-=
of-bounds write and kernel panic
--

--- Patch [1]: [PATCH v3] scsi: scsi_debug: fix REPORT ZONES alloc_len unde=
rflow OOB write ---
commit 1e0d50f19491d296aa99221a898bda21deff84db
Author: Ibrahim Hashimov <security@auditcode.ai>

scsi: scsi_debug: fix REPORT ZONES alloc_len underflow OOB write

This commit fixes an out-of-bounds write in resp_report_zones() by sizing
the buffer to a whole number of 64-byte blocks that cover the requested
allocation length. It aligns the length and computes the buffer size in
64-bit to avoid a u32 wrap.

> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -5911,9 +5912,11 @@ static int resp_report_zones(struct scsi_cmnd *scp,
>  		return check_condition_result;
>  	}
> =20
> -	rep_max_zones =3D (alloc_len - 64) >> ilog2(RZONES_DESC_HD);
> +	rep_max_zones =3D (ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_=
HD) >>
> +			ilog2(RZONES_DESC_HD);
> +	arr_len =3D (u64)RZONES_DESC_HD * (rep_max_zones + 1);
> =20
> -	arr =3D kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
> +	arr =3D kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);

[Severity: High]
Does this code cause a truncation and kernel panic on 32-bit systems?

If a user with raw IO access sends a REPORT ZONES SCSI command with an
alloc_len between 0xFFFFFFC1 and 0xFFFFFFFF, ALIGN() rounds it up to exactly
0x100000000 (4 GB) making arr_len exactly 0x100000000.

On 32-bit platforms, kzalloc() takes a 32-bit size_t, which silently
truncates 0x100000000 to 0. Calling kzalloc(0) returns ZERO_SIZE_PTR, which
bypasses the (!arr) NULL check.

>  	if (!arr) {
>  		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
>  				INSUFF_RES_ASCQ);
>  		return check_condition_result;
>  	}
> =20
>  	sdeb_meta_read_lock(sip);
> =20
>  	desc =3D arr + 64;

Since arr is ZERO_SIZE_PTR (typically 0x10), desc becomes an unmapped
address (0x50).

[ ... ]

>  		if (nrz < rep_max_zones) {
>  			/* Fill zone descriptor */
>  			desc[0] =3D zsp->z_type;
>  			desc[1] =3D zsp->z_cond << 4;

The driver unconditionally dereferences the unmapped memory here, which
will trigger a deterministic kernel panic.=20

Could we add a bounds check for alloc_len to ensure it doesn't exceed 32-bit
bounds or a reasonable maximum allocation size before passing it to kzalloc=
()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710055755.5383=
0-1-security@auditcode.ai?part=3D1

