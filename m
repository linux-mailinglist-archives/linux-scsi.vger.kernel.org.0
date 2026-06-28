Return-Path: <linux-scsi+bounces-25317-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9OQ8OKhaQWoNoAkAu9opvQ
	(envelope-from <linux-scsi+bounces-25317-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Jun 2026 19:32:24 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078D6D48C5
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Jun 2026 19:32:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HL3WM06v;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25317-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25317-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE34A300D6AA
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Jun 2026 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4F2D94B0;
	Sun, 28 Jun 2026 17:32:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAA289367
	for <linux-scsi@vger.kernel.org>; Sun, 28 Jun 2026 17:32:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667942; cv=none; b=rUlT2KH9Zz/SukVb4hACT3Ve9oMLXOSDeF4o67nr7tBpKNm3fjWi/adlqXE5Ji1xNpJK1ai4zNWakhwOnTzX9jokac2DK8sX56qy1iSIgrttSXTUKqSGOAb3zxcuubtd8UcjL0cWmsRt/wVQYkwDCauZcQi1345/0CNMkLyNCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667942; c=relaxed/simple;
	bh=UGoepQalpI4Q73I+M+wbYrJxrB16I2rpm1FeSAWH2Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ztk44JgAYdt4Iu0o7QkrCE2hi3KxJBnTgQrx2HumciofN9/XVq7kVdnXtRFC5UTR8+OrDpxJy+WbC4J4KrO2YHnOKzfaYP3IwNRWROhm9BD9MbWZMu98lu1DdkfL6B/Nrd4yo6zAbpvGLzgWnwOhF5Hz/tAqO7o7AM6ZKgLTXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL3WM06v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416271F000E9;
	Sun, 28 Jun 2026 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782667940;
	bh=cJjp+6Y3eKMS0vIxIVXVbF4MJJ0S878oX09qF7VIuLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HL3WM06vy3H4hv1oh57YdbTzoPw9MUOk/SiKJGVOZYSoqPIJb1GiA2W+X6mnLax0b
	 dgT+vbvK0OXWaJOzsxlTgJcNeUEKwGG+OqJar7nOVXcgamFxps3Nr/vFZpRht9eSnW
	 4wdd6ohjgFP3HUb8O/ofKgKBC2FwG0FMlUII276IhmZuUxG/w6GuFIg6CtcX5odWnL
	 CcwCZWU+YS+R8JFARUToG17bH4pwjmtG7C4HgAXB1UAE4FVliJP9TmziWuJIxyt7WH
	 LEGtSOjKxSSj+YT6oJIYF3rASj5vSaIbN3BiaWgHhGXBFt8hwkjNnrbwOZaK/BHREk
	 pNxe0YjvRI0SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] scsi: fill in DMA padding bytes in
 scsi_alloc_sgtables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Vaganov" <p.vaganov@ideco.ru>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260628171348.8613-1-p.vaganov@ideco.ru>
References: <20260628171348.8613-1-p.vaganov@ideco.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 17:32:19 +0000
Message-Id: <20260628173220.416271F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25317-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:p.vaganov@ideco.ru,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,ideco.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3078D6D48C5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Out-of-bounds virtual memory access on highmem systems due to =
single-page `kmap_local_page` mapping combined with multi-page scatterlist =
elements.
--

commit 3b4fc492120b7d6d0be664dd4aa56d3b359efb8f
Author: Petr Vaganov <p.vaganov@ideco.ru>

scsi: fill in DMA padding bytes in scsi_alloc_sgtables

This commit zero-pads the remaining unaligned bytes at the end of the last
scatterlist element to prevent DMAing uninitialized memory. It maps the page
using kmap_local_page() to support highmem configurations.

> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1187,6 +1187,11 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd =
*cmd)
>  	if (blk_rq_bytes(rq) & rq->q->limits.dma_pad_mask) {
>  		unsigned int pad_len =3D
>  			(rq->q->limits.dma_pad_mask & ~blk_rq_bytes(rq)) + 1;
> +		unsigned int pad_offset =3D last_sg->offset + last_sg->length;
> +		void *vaddr =3D kmap_local_page(sg_page(last_sg));
> +
> +		memset(vaddr + pad_offset, 0, pad_len);

[Severity: Critical]
Can this regression cause an out-of-bounds write if the scatterlist element
spans multiple coalesced pages?

If an I/O request has a data buffer spanning multiple physically contiguous
pages, the block layer coalesces them into a single scatterlist entry. When
this happens, last_sg->length will exceed PAGE_SIZE.

If the request length is not aligned to dma_pad_mask, pad_offset (which is
calculated as last_sg->offset + last_sg->length) will be greater than
PAGE_SIZE. Since kmap_local_page() only maps the very first page of the
scatterlist element, the memset() would write past the mapped page and corr=
upt
adjacent memory slots.

> +		kunmap_local(vaddr);
> =20
>  		last_sg->length +=3D pad_len;
>  		cmd->extra_len +=3D pad_len;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628171348.8613=
-1-p.vaganov@ideco.ru?part=3D1

