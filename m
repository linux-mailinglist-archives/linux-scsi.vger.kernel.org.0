Return-Path: <linux-scsi+bounces-25326-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zFqrIac2Qmqz1wkAu9opvQ
	(envelope-from <linux-scsi+bounces-25326-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 11:11:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFC6D7E5C
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 11:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JIMCNqIA;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25326-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25326-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63E9D3000FE2
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932013F54C5;
	Mon, 29 Jun 2026 09:11:00 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4202F1FDF
	for <linux-scsi@vger.kernel.org>; Mon, 29 Jun 2026 09:10:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724260; cv=none; b=Tt3KlF2XuoIg8QsHLiUMvEKPgdLw3GeVTqPdExzLRHY3BVIfdze8q1tbyO2BrX0exmtbBXqaroMQ7GCMfy2hNhuq95GyY3hmZAMCvg+5PBnSJVu+72fLMJrb9kA7hzpVdkdF5+hZ/O12vC1lFAU3LG76jOtXrGxaSbeY6VefY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724260; c=relaxed/simple;
	bh=G1stVcbmGMT3nlvloEH1Wj2zY9Y9YVll980qSioKNMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HX/20Oy+RoYW6x4zqo1MuVHbEarHef6oVPUMUGQ9QWy7OXLcQBMEk8PBMZYlrFdMt06eX45Bv0HUgJUhIK7Byaa6zOxwETPT2wvp5Zzzrm8+IuvZy/GFyhiiIngjxjVtl9M0+kniC7Lcmo1Nz/1J+5yr1BW1oFQuzU/6JCMk6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIMCNqIA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA171F000E9;
	Mon, 29 Jun 2026 09:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724259;
	bh=qopkMxVxOiLnPbATi3+xnC06ePf9hKfczuccEaKSqGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIMCNqIAATBro6zKxKqVkeOUFfpkv+/4irUxHN+/xKaiul2oi8z3g8Yv8jnCC9UKF
	 hYXqn+fHFFIeS6XjNuTjdNUVjXX5O8PSz87Pg+WOc/mioi6ICO1cB/s4p05x8fpewZ
	 PeFGpybbBs755JqEXeffNnRSPrVrj5I/cYsNipwYKMIgQGObWE0DwrBphL2JWZEuuf
	 jmknFvWrxoFfjzmmxVDL+8AWaHPU9xAWNp4UDtWjfTrQAeAP1cc8snnmCSr640/Qmp
	 dOqYv7IMrUSk+jtP9vd4ImmsEYOlG+Q4ngcbMwPpWVC+hgUShmhM6XTJZ2u5+oWvL7
	 NB8nClOFhpP4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: make dma_max_mapping_size() return 0
 for no DMA capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260629085310.2298552-2-john.g.garry@oracle.com>
References: <20260629085310.2298552-1-john.g.garry@oracle.com>
 <20260629085310.2298552-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 09:10:57 +0000
Message-Id: <20260629091058.EBA171F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25326-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19AFC6D7E5C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma_max_mapping_size() returning 0 causes division by zero in amdx=
dna_cbuf_map() and invalid zero-sized block layer limits in MMC drivers.
--

commit b19cb5dc0c3fd9b25263f65c9d042ee616692807
Author: John Garry <john.g.garry@oracle.com>

dma-mapping: make dma_max_mapping_size() return 0 for no DMA capability

This commit updates dma_max_mapping_size() to return 0 when a device
is not DMA capable, reflecting that the maximum mapping size for such
devices is 0.

> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 4fe04669e5e66..7e576e5c6b8be 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -979,6 +979,9 @@ size_t dma_max_mapping_size(struct device *dev)
>  	const struct dma_map_ops *ops =3D get_dma_ops(dev);
>  	size_t size =3D SIZE_MAX;
> =20
> +	if (!dev->dma_mask)
> +		return 0;

[Severity: High]
Could this new return value of 0 cause a division by zero in callers that
expect a strictly positive maximum mapping size?

For instance, in drivers/accel/amdxdna/amdxdna_cbuf.c:amdxdna_cbuf_map(),
the returned size is used directly as a divisor:

        max_seg =3D min_t(size_t, UINT_MAX, dma_max_mapping_size(dev));
        n_entries =3D (cbuf->node.size + max_seg - 1) / max_seg;

If a device lacking a dma_mask maps the attachment, max_seg becomes 0,
which would result in an immediate kernel panic.

Additionally, could this cause invalid zero-sized block layer queue limits
in MMC drivers? In drivers/mmc/host/bcm2835.c:bcm2835_add_host(), the
return value clamps max_req_size:

        mmc->max_req_size =3D min_t(size_t, 524288, dma_max_mapping_size(de=
v));

If the device lacks DMA support, max_req_size becomes 0, which propagates
to the block layer and can trigger panics when processing requests.

> +
>  	if (dma_map_direct(dev, ops))
>  		size =3D dma_direct_max_mapping_size(dev);
>  	else if (use_dma_iommu(dev))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629085310.2298=
552-1-john.g.garry@oracle.com?part=3D1

