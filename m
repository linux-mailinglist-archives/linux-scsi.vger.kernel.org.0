Return-Path: <linux-scsi+bounces-25604-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MkUoLwyoSGpasQAAu9opvQ
	(envelope-from <linux-scsi+bounces-25604-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 08:28:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC0706DDE
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 08:28:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IP2u9QXQ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25604-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25604-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A0443009E26
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Jul 2026 06:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41F5B672;
	Sat,  4 Jul 2026 06:28:21 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE40388863
	for <linux-scsi@vger.kernel.org>; Sat,  4 Jul 2026 06:28:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783146501; cv=none; b=N3AJzXDY9saW2rP15ZKA7/QlQuwuoRU0bujmYSRMgOXPaSSVXJ8zHntwP7U4jKBTL0mPFuAonCAmmXO+g8+wUS5m9Zku3sc5JUTae4WN/CHzuuJ1z2wNzEZWz7n2Sex4CJzz5FXCuC8+Ff/PJwOGf+sAWzOUyMC2rK+Banjbtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783146501; c=relaxed/simple;
	bh=nCpk+dxvhnaBzBu7FAPkrTP7DhCCqJmyKPbOPPlHYH8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VQPfkJbbsGk97Qvddk5Usy5jZBg86xLof2E8KapmQ8SKZbLQjqPWgcDLOkMGhb/GU8AMBWEXedL/kaichx7s90jkCbyn6/O6z9MIlGUjZjH6tXA1joWlk3bFZ8LKeh8N5110VwiSUbmyJ3qZ6C2YA+Ki9jcTIamcKrEpZuIFPzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP2u9QXQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC191F000E9
	for <linux-scsi@vger.kernel.org>; Sat,  4 Jul 2026 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783146500;
	bh=k8sSaavbKjYQyxF4ACcDDljqZjskv0WdH9AG/Mx/jbY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IP2u9QXQJW67VWCc+H5F2cnZEayinUiksUmQZABlAfxXZUC9TRl03uUDJldPLyYw6
	 ERfOipwf9lTEm76Tq64YuRK7WRlUnectG0o2nG5/LRRaajYl7uhPUbfZHTCByCMnzj
	 6NNAGKckz4m6474E5Yfn/ZmfFw12KHs7XraWacytkMDPb2q1aCHlzaBjjxNBe6rc6F
	 E6QVeRAPkTk/mc4K1rAMw91DPJgTHTXo2ORrJpCBDocA5Vxu52JHjSjFtQg9VFTk9X
	 sIEazU9obosVBHHWKwK32dbMnnuXmBeSl0PbIqyNW+a6/0UE087af8kNfjWPWH5Pha
	 epAriQAof6VJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] scsi: ipr: use kmalloc() to allocate IPR dump
 buffer memory
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260704-b4-scsi-v2-3-7d2d21a810de@kernel.org>
References: <20260704-b4-scsi-v2-0-7d2d21a810de@kernel.org>
 <20260704-b4-scsi-v2-3-7d2d21a810de@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:28:19 +0000
Message-Id: <20260704062820.5AC191F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25604-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0CC0706DDE

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The sysfs bin attribute read handler `ipr_read_dump` can enter an =
infinite loop in the kernel when reading from the `ioa_data` section at a p=
age-aligned logical offset.
- [High] The sysfs dump read handler (`ipr_read_dump`) uses an untrusted `n=
um_entries_used` value from the adapter firmware to calculate `sdt_end`, al=
lowing an out-of-bounds read past the end of the `ipr_dump` structure.
--

commit c5fdd71b8661a08dfced04b150e6d5fc217eacda
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

scsi: ipr: use kmalloc() to allocate IPR dump buffer memory

This commit replaces the use of __get_free_page() with kmalloc() for
allocating IPR dump buffers. It also relaxes the allocation flag from
GFP_ATOMIC to GFP_NOIO since the allocations happen in a workqueue context.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index d207e5e81afe0..19153dd247363 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
[ ... ]
> @@ -3226,7 +3226,7 @@ static void ipr_release_dump(struct kref *kref)
>  	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
> =20
>  	for (i =3D 0; i < dump->ioa_dump.next_page_index; i++)
> -		free_page((unsigned long) dump->ioa_dump.ioa_data[i]);
> +		kfree(dump->ioa_dump.ioa_data[i]);
> =20
>  	vfree(dump->ioa_dump.ioa_data);
>  	kfree(dump);

[Severity: High]
This isn't a bug introduced by this patch, but the sysfs dump read
handler ipr_read_dump() in drivers/scsi/ipr.c uses an untrusted=20
num_entries_used value from the adapter firmware to calculate sdt_end:

drivers/scsi/ipr.c:ipr_read_dump() {
    ...
	sdt_end =3D offsetof(struct ipr_ioa_dump, sdt.entry) +
			  (be32_to_cpu(dump->ioa_dump.sdt.hdr.num_entries_used) *
			   sizeof(struct ipr_sdt_entry));
    ...
	src =3D (u8 *)&dump->ioa_dump + off;
	memcpy(buf, src, len);
    ...
}

While ipr_get_ioa_dump() caps the local variable num_entries, it leaves
the raw dump->ioa_dump.sdt.hdr.num_entries_used in the struct unchanged.
When ipr_read_dump() calculates sdt_end using this raw uncapped value,
it allows an out-of-bounds read past the end of the ipr_dump structure.

Could this lead to a kernel heap exposure when the adjacent kernel memory
is copied to user-space?

[Severity: High]
This is a pre-existing issue, but the sysfs bin attribute read handler
ipr_read_dump() in drivers/scsi/ipr.c can enter an infinite loop when
reading from the ioa_data section at a page-aligned logical offset:

drivers/scsi/ipr.c:ipr_read_dump() {
    ...
	if ((off & PAGE_MASK) !=3D ((off + count) & PAGE_MASK))
		len =3D PAGE_ALIGN(off) - off;
    ...
}

If a user reads the sysfs dump file such that off starts at a page
boundary and count extends to or past the next page boundary (e.g.,
off =3D 0 and count =3D 4096), PAGE_ALIGN(off) - off evaluates to 0.

This results in a zero-length memcpy and no advancement of off or count.
Since there is no cond_resched(), could this lock up a CPU core in an
infinite loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704-b4-scsi-v2=
-0-7d2d21a810de@kernel.org?part=3D3

