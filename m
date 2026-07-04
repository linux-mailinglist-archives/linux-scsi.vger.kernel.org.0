Return-Path: <linux-scsi+bounces-25603-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ibbTOqKmSGozsQAAu9opvQ
	(envelope-from <linux-scsi+bounces-25603-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 08:22:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C971706DBB
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 08:22:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HYxZuY2o;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25603-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25603-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C67300F115
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Jul 2026 06:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52EE1D5174;
	Sat,  4 Jul 2026 06:22:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C10B672
	for <linux-scsi@vger.kernel.org>; Sat,  4 Jul 2026 06:22:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783146143; cv=none; b=ZV+n2ttprLhWLM70UbWXgn+mqEDDPIiU0ACoCUvUr8pTTHFq86l0l3rD27d+7zg3gH3IUP3npvUZeyNMmdYssRnHhO36kNLFvq46zVQq+R4J8YXJb1aNoGcR3Y6qoUtlpr1SxG82zih/XmWoaMeMTGv4QGZiKCKtLpN47p9crK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783146143; c=relaxed/simple;
	bh=LyuLVfrRQcJDpESfE6Gbz8pcRtxEhzqq0pwsU5TutEg=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aaY77mFPJg61CKe39ay9d9sa7OPM5i6dna1bs4Jyq40h/bsVp+6DrsxZGWGHc+d1B23Ab5hCh1EDAJbPA13o9HrXy2+TvC8Xfbh1yhi/uKJFLOmpxUc1LH5JMVv4G9E0nyXjxVgDBqbxYpdh93Q30ZUalCQXA1eufTRFLBUZd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYxZuY2o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130B61F000E9
	for <linux-scsi@vger.kernel.org>; Sat,  4 Jul 2026 06:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783146142;
	bh=AMHm2KwSHwoOfeqygrkeFHQsSw1uSue8JX35i8Ua8D8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HYxZuY2oeNYWWO6RlidqZ9/Dp8gynq7rO2l+RfA9M4OYZrFTZfggI7HAYOLhlphIX
	 N24e5zhZm+LCeq3jzrmGkWIBOynk8ML6JiCWduGfI9Rkj6RJENJtJTBunf68Au5Jhc
	 b6n4LB6U82/Gh17uzk/4iq+0ITh7iFcstWKrmCBt4JyJhlF7NMp5/aZxda7b7CCa3x
	 ZHrhPiPSnZ4cXawOEoz0YC88hmD/3EqWzyaV1ld4+UVqFDNzrdjZGswW7ofDqBkw2W
	 Wt1XoJ2x0BFJRVIQGCIXPD+7w65e3qpW94RWFsV8jB6PR0AJXNVG/RnsZNgGwC3FRp
	 Cj2VV1A5gXaGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] scsi: sym53c8xx_2: replace __get_free_pages()
 with kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260704-b4-scsi-v2-4-7d2d21a810de@kernel.org>
References: <20260704-b4-scsi-v2-0-7d2d21a810de@kernel.org>
 <20260704-b4-scsi-v2-4-7d2d21a810de@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:22:21 +0000
Message-Id: <20260704062222.130B61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25603-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C971706DBB

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `__get_free_pages()` with `kmalloc()` breaks the interna=
l custom buddy allocator because `kmalloc()` does not guarantee page-aligne=
d memory, leading to memory leaks, incorrect block coalescing, and potentia=
l kernel crashes.
--

commit c528e5943bc5d64b931842bf0abd4f0d0100f91e
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

scsi: sym53c8xx_2: replace __get_free_pages() with kmalloc()
   =20
This commit replaces __get_free_pages() and free_pages() with kmalloc() and
kfree() for the internal memory allocator of the sym53c8xx_2 driver. The go=
al
is to improve the API usage, as kfree() does not require knowing the size of
the freed object.
   =20
Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.h b/drivers/scsi/sym53c8xx=
_2/sym_hipd.h
> index 9231a28990643..aa365e8ba66fc 100644
> --- a/drivers/scsi/sym53c8xx_2/sym_hipd.h
> +++ b/drivers/scsi/sym53c8xx_2/sym_hipd.h
> @@ -1110,9 +1110,9 @@ sym_build_sge(struct sym_hcb *np, struct sym_tblmov=
e *data, u64 badd, int len)
>   */
> =20
>  #define sym_get_mem_cluster()	\
> -	(void *) __get_free_pages(GFP_ATOMIC, SYM_MEM_PAGE_ORDER)
> +	kmalloc(PAGE_SIZE << SYM_MEM_PAGE_ORDER, GFP_ATOMIC)

[Severity: High]
Will this break the custom buddy allocator logic in ___sym_mfree?

The custom buddy allocator relies on XOR arithmetic and bitwise AND to find=
 and
coalesce buddy blocks, which fundamentally requires the base address of the=
 root
block (the memory cluster) to be naturally aligned to its size:

drivers/scsi/sym53c8xx_2/sym_malloc.c:___sym_mfree() {
...
		b =3D a ^ s;
		q =3D &h[i];
		while (q->next && q->next !=3D (m_link_p) b) {
			q =3D q->next;
		}
...
		q->next =3D q->next->next;
		a =3D a & b;
...
}

While __get_free_pages guarantees page alignment, kmalloc does not (especia=
lly
when KASAN or SLUB debugging is enabled).

If kmalloc returns an unaligned pointer, the XOR buddy calculation computes
incorrect buddy addresses. This prevents blocks from coalescing properly and
causes a memory leak.

Additionally, if blocks from differently offset clusters happen to merge, t=
he
allocator reconstructs a naturally aligned base address that differs from t=
he
original pointer returned by kmalloc. This can lead to calling kfree on an
invalid pointer, resulting in a kernel crash.

>  #define sym_free_mem_cluster(p)	\
> -	free_pages((unsigned long)p, SYM_MEM_PAGE_ORDER)
> +	kfree(p)
> =20
>  /*
>   *  Link between free memory chunks of a given size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704-b4-scsi-v2=
-0-7d2d21a810de@kernel.org?part=3D4

