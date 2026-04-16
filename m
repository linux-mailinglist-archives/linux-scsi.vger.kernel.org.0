Return-Path: <linux-scsi+bounces-22976-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFCwBedx4GlkgwAAu9opvQ
	(envelope-from <linux-scsi+bounces-22976-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 07:21:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5D40A548
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 07:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB81F30B333C
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 05:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BD36655C;
	Thu, 16 Apr 2026 05:21:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AF33BBD1;
	Thu, 16 Apr 2026 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316876; cv=none; b=iisx76OKDvSxUJfth+GWo8In6ExGwzOJ3JmvlFeSxmM+wxhdmuH4+VZkTAD1NKYoghHIxbBWVjU7Uzr5aNy1GsTWRKskdHKSqJ/q7xmscfu8Pa5U5NgG2HoNCjlFlMHa/IxJ21GaBXc434SgEiRpbvz6HSuUqs9Y/mk/4kh3l0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316876; c=relaxed/simple;
	bh=+gnSsKJCf4YO5Rok3xZqh8d8Ev4Hfer3gYB4oJlksn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8B/ytGYgMTqGVAE605dtOe4ar7b9LVQ3DGeuSrqaJIpXle37C80sHFQDNIubYFlFlIL7T+hPpC4aLDxL9nUUhC12ce5P5Zi84xe5QZGsc2NjG2RamRAl2l7nP4cUljh0o5wvURDfj+a380dpGq95AAZo0FYb+reeYsIrQ/Q5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 916966732A; Thu, 16 Apr 2026 07:21:12 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:21:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] bio-integrity-fs: pass data iter to
 bio_integrity_verify()
Message-ID: <20260416052111.GB14950@lst.de>
References: <20260416002214.2048150-1-csander@purestorage.com> <20260416002214.2048150-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416002214.2048150-3-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22976-lists,linux-scsi=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email,samsung.com:email,purestorage.com:email]
X-Rspamd-Queue-Id: A5B5D40A548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 06:22:10PM -0600, Caleb Sander Mateos wrote:
> bio_integrity_verify() expects the passed struct bvec_iter to be an
> iterator over bio data, not integrity. So construct a separate data
> bvec_iter without the bio_integrity_bytes() conversion and pass it to
> bio_integrity_verify() instead of bip_iter.
> 
> Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity-fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
> index acb1e5f270d2..389372803b38 100644
> --- a/block/bio-integrity-fs.c
> +++ b/block/bio-integrity-fs.c
> @@ -53,21 +53,22 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
>  
>  int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
> +	struct bvec_iter data_iter = {.bi_sector = sector, .bi_size = size};

Missing spaces and too condensed.  We normally use one line per field in
struct initializers:

	struct bvec_iter data_iter = {
		.bi_sector	= sector,
		.bi_size	= size,
	};

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

