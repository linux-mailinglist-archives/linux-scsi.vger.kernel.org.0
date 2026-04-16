Return-Path: <linux-scsi+bounces-22979-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDxoBIJy4GlkgwAAu9opvQ
	(envelope-from <linux-scsi+bounces-22979-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 07:24:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A529E40A5CB
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 07:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD5093037DD0
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 05:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8983366823;
	Thu, 16 Apr 2026 05:23:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF1364E96;
	Thu, 16 Apr 2026 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317010; cv=none; b=jmZ6Zy8ADhW/GfKcwlErxUYQsnaWRCapac1mJn2B8k2vVem5IEBeOw3X8X4bdhNXRY5DY7ms+UqiV8tvu3XhCEm1WqaOyifq++eQ+HJexbJhy/L84FzlISSOk9LEQasnlUSAFvahDmiy83HITIS+j80n9dRS+PrQ5X2hqppuw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317010; c=relaxed/simple;
	bh=J9eNPp2+NId5+4/lXrYfhpWxIcVpkia+bExPRs37KE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEiQZe3cb4x1YWmQUeSzwGP84Wfu8KGfQdpnooifSJMam0aZz5lWcpMnk3VioKBCkAXI639jH4kscNC1q0YTCYRMN2yHdqWgrJU66pD6og4zkMoYe2X/1gSbzUvFB4jmoZDgPxQ5Y2naIrn0F+/i4bHDE4pqMmEGEBSriXYd4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E5616732A; Thu, 16 Apr 2026 07:23:26 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:23:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 6/6] blk-integrity: avoid sector_t in
 bip_{get,set}_seed()
Message-ID: <20260416052325.GE14950@lst.de>
References: <20260416002214.2048150-1-csander@purestorage.com> <20260416002214.2048150-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416002214.2048150-7-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22979-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A529E40A5CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 06:22:14PM -0600, Caleb Sander Mateos wrote:
> bip_set_seed() and big_get_seed() take/return a sector_t value that's
> actually an integrity interval number. This is confusing, so pass
> struct blk_integrity and struct bio instead to bip_set_seed() and
> convert the bio's device address to integrity intervals.
> 
> Open-code the access to bip->bip_iter.bi_sector in the one caller of
> bip_set_seed() that doesn't use the bio device address for the seed.
> Open-code bip_get_seed() in its one caller.
> 
> Add a comment to struct bvec_iter's bi_sector field explaining its
> alternate use for bip_iter.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> ---
>  block/bio-integrity.c               |  5 ++---
>  block/t10-pi.c                      |  2 +-
>  drivers/nvme/target/io-cmd-bdev.c   |  3 +--
>  drivers/target/target_core_iblock.c |  3 +--
>  include/linux/bio-integrity.h       | 11 -----------
>  include/linux/blk-integrity.h       | 14 ++++++++++++++
>  include/linux/bvec.h                |  1 +
>  7 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 3ad6a6799f17..e9ae5db99f64 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -103,13 +103,12 @@ void bio_integrity_free_buf(struct bio_integrity_payload *bip)
>  
>  void bio_integrity_setup_default(struct bio *bio)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
> -	u64 seed = bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR_SHIFT);
>  
> -	bip_set_seed(bip, seed);
> +	bip_set_seed(bip, bi, bio);
>  
>  	if (bi->csum_type) {
>  		bip->bip_flags |= BIP_CHECK_GUARD;
>  		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
>  			bip->bip_flags |= BIP_IP_CHECKSUM;
> @@ -472,11 +471,11 @@ int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
>  
>  	it.count = integrity_bytes;
>  	ret = bio_integrity_map_user(bio, &it);
>  	if (!ret) {
>  		bio_uio_meta_to_bip(bio, meta);
> -		bip_set_seed(bio_integrity(bio), meta->seed);
> +		bio_integrity(bio)->bip_iter.bi_sector = meta->seed;
>  		iov_iter_advance(&meta->iter, integrity_bytes);
>  		meta->seed += bio_integrity_intervals(bi, bio_sectors(bio));
>  	}
>  	return ret;
>  }
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index 787950dec50a..71367fd082bd 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -510,11 +510,11 @@ static void blk_reftag_remap_prepare(struct blk_integrity *bi,
>  static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
>  			       unsigned *intervals, u64 *ref, bool prep)
>  {
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  	struct bvec_iter iter = bip->bip_iter;
> -	u64 virt = bip_get_seed(bip);
> +	u64 virt = bip->bip_iter.bi_sector;
>  	union pi_tuple *ptuple;
>  	union pi_tuple tuple;
>  
>  	if (prep && bip->bip_flags & BIP_MAPPED_INTEGRITY) {
>  		*ref += bio->bi_iter.bi_size >> bi->interval_exp;
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index f2d9e8901df4..2c4b312f2f55 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -218,12 +218,11 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
>  		pr_err("Unable to allocate bio_integrity_payload\n");
>  		return PTR_ERR(bip);
>  	}
>  
>  	/* virtual start sector must be in integrity interval units */
> -	bip_set_seed(bip, bio->bi_iter.bi_sector >>
> -		     (bi->interval_exp - SECTOR_SHIFT));
> +	bip_set_seed(bip, bi, bio);
>  
>  	resid = bio_integrity_bytes(bi, bio_sectors(bio));
>  	while (resid > 0 && sg_miter_next(miter)) {
>  		len = min_t(size_t, miter->length, resid);
>  		rc = bio_integrity_add_page(bio, miter->page, len,
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index 1087d1d17c36..4e0fa91a08fd 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -706,12 +706,11 @@ iblock_alloc_bip(struct se_cmd *cmd, struct bio *bio,
>  		pr_err("Unable to allocate bio_integrity_payload\n");
>  		return PTR_ERR(bip);
>  	}
>  
>  	/* virtual start sector must be in integrity interval units */
> -	bip_set_seed(bip, bio->bi_iter.bi_sector >>
> -				  (bi->interval_exp - SECTOR_SHIFT));
> +	bip_set_seed(bip, bi, bio);
>  
>  	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
>  		 (unsigned long long)bip->bip_iter.bi_sector);
>  
>  	resid = bio_integrity_bytes(bi, bio_sectors(bio));
> diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
> index af5178434ec6..edcd0855abba 100644
> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -56,21 +56,10 @@ static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
>  		return bip->bip_flags & flag;
>  
>  	return false;
>  }
>  
> -static inline sector_t bip_get_seed(struct bio_integrity_payload *bip)
> -{
> -	return bip->bip_iter.bi_sector;
> -}
> -
> -static inline void bip_set_seed(struct bio_integrity_payload *bip,
> -				sector_t seed)
> -{
> -	bip->bip_iter.bi_sector = seed;
> -}
> -
>  void bio_integrity_init(struct bio *bio, struct bio_integrity_payload *bip,
>  		struct bio_vec *bvecs, unsigned int nr_vecs);
>  struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio, gfp_t gfp,
>  		unsigned int nr);
>  int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
> diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> index 825d777c078b..3a2e55e809c5 100644
> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -85,10 +85,24 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
>  					       unsigned int sectors)
>  {
>  	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
>  }
>  
> +/**
> + * bip_set_seed - Set bip reference tag seed from bio device address
> + * @bip:	struct bio_integrity_payload whose ref tag seed to set
> + * @bi:		struct blk_integrity profile for device
> + * @bio:	struct bio whose device address to use for the ref tag seed
> + */
> +static inline void bip_set_seed(struct bio_integrity_payload *bip,
> +				const struct blk_integrity *bi,
> +				const struct bio *bio)
> +{
> +	bip->bip_iter.bi_sector =
> +		bio_integrity_intervals(bi, bio->bi_iter.bi_sector);

The bip is pointed to by the bio, so we don't need to pass it separately.
Same for struct blk_integrity.


