Return-Path: <linux-scsi+bounces-25314-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ljA0LshlP2oOSwkAu9opvQ
	(envelope-from <linux-scsi+bounces-25314-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 07:55:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 228426D13CC
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 07:55:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KV1TV8yY;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25314-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25314-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2989D301D316
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED89317144;
	Sat, 27 Jun 2026 05:55:18 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F913AA2D
	for <linux-scsi@vger.kernel.org>; Sat, 27 Jun 2026 05:55:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782539718; cv=none; b=u/TI8RzP+HLn0bGrT0eJNKKg+xLRkkMk9Vv4Fuhfh05YaDXeCWFGswHJbXYgFN6qggI4vZgHF3GmNmbEf8bLGjRi7VAceq74H6KSZf5KD2q/1XdSPKmBLSXphZTPi0bB0g8VLmmCMybN40oU3VwfrOX9EDDh5bVs02lDNuTHZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782539718; c=relaxed/simple;
	bh=51wnL9Oc7n6HgU42OQPc+cVez3/v3vs9oj+VIZ9fy8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQ6vq2PADXPJw+ciDIXv2SrCLJbVoQfvvqwXHzc9J9Nk43aHlE3Oa17uw4qGz9mBbL9f17mkmfVF60CJudhAL5g4r5HWzxoDQ6ooeRsMX+NFE2xgFrBR8WXQcBRHuqSwhvbDopxnvX7WjDyMwIZn6m4DOsR1iORSuNTjV/pLZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV1TV8yY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92931F000E9;
	Sat, 27 Jun 2026 05:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782539717;
	bh=2SiBj7RG+opXbHe2Rrj7BXmZ5dbZq+LGsWZ6ysQsMgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KV1TV8yYRyyyGZnKxfH1Yay8FBVg8wLcUgs4xSOypBdhDB50ZVqw5L/DqyZwvUhpB
	 AdzQ7/ONmFjTM2TvEXh+HBmOchaQvcdKL8ygJWZbDf1uXPH3+p1ZchfcwnOQvLl3+x
	 ayOZdByKJfsuO/ebKQQvSojJi+YWuGH6I8kHsbpYuBFOxkaRNbD+gtHxBWWcXi26Ga
	 VptcKnLJQkHNybSRRFcDFx1QGBZYkE7dLG9Nmu4Z02tfzno7JktfD2fKcS7gt+oVa/
	 G17mZtPMinkYw4TJ8TdT9ue/DfM4Fk1QuQ8K6tsnAfVbpWOa+jQX+P3/Hsvx/NLiXR
	 BO0/P9tGuDWjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] bio-integrity-fs: use integrity interval instead
 of sector as seed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb Sander Mateos" <csander@purestorage.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260627054220.2174166-4-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
 <20260627054220.2174166-4-csander@purestorage.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 05:55:16 +0000
Message-Id: <20260627055516.D92931F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25314-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:csander@purestorage.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,purestorage.com:email,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 228426D13CC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional dereference of `bip` and `bi` in `fs_bio_integrity_v=
erify` and `fs_bio_integrity_free` causing a kernel panic.
--

commit 1da3b7d905f7d5c0c600e7d3a5fbf3cb0dc853c7
Author: Caleb Sander Mateos <csander@purestorage.com>

bio-integrity-fs: use integrity interval instead of sector as seed
   =20
bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

> diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
> index 9c5fe5fa8f0da..770eacb2220ff 100644
> --- a/block/bio-integrity-fs.c
> +++ b/block/bio-integrity-fs.c
> @@ -67,7 +67,7 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t s=
ector, unsigned int size)
>  	 * bio.  Requires the submitter to remember the sector and the size.
>  	 */
>  	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
> -	bip->bip_iter.bi_sector =3D sector;
> +	bip->bip_iter.bi_sector =3D bio_integrity_intervals(bi, sector);

[Severity: High]
This is a pre-existing issue, but can this unconditionally dereference bip
and bi?

Looking at iomap_bio_read_folio_range_sync() in fs/iomap/bio.c, it calls
fs_bio_integrity_verify() and fs_bio_integrity_free() without validating if
the integrity payload was actually allocated:

fs/iomap/bio.c:iomap_bio_read_folio_range_sync() {
    ...
    if (!error)
        error =3D fs_bio_integrity_verify(&bio, sector, len);
    fs_bio_integrity_free(&bio);
    ...
}

If fs_bio_integrity_alloc() returns 0 without actually allocating a
bio_integrity_payload, bio_integrity(bio) will be NULL. This can happen if
the device's integrity profile is unregistered concurrently, or if the
operation doesn't require integrity checks.

When that happens, fs_bio_integrity_verify() would dereference a NULL bip
during the memset(&bip->bip_iter, 0, ...) call, and a NULL bi at the call to
bio_integrity_intervals(bi, sector). Similarly, fs_bio_integrity_free() wou=
ld
subsequently dereference bip on the same path.

Could we add a check for a valid bip and bi before these accesses?

>  	bip->bip_iter.bi_size =3D bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
>  	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627054220.2174=
166-1-csander@purestorage.com?part=3D3

