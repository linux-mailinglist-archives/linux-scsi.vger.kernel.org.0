Return-Path: <linux-scsi+bounces-5350-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AAF8FD12E
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2024 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457E8286788
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443F2E83F;
	Wed,  5 Jun 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwsE85Y4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352782746A;
	Wed,  5 Jun 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599152; cv=none; b=W61MrbH47tG6dZ2BUEMy6jed6qJ4vDiMn6tGRIeVKe21B8QYe+K5V4YkCTbkyotcNxqSQ+1qKSnSr2SXLHqsEK2g8LoYR/dl2+NjHE+8aYYeTYzZJa54qhszBL6qd6GOGgQ0M1ef51U9/4ronXq8daRu2QPYsV18vbAZnJj1W8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599152; c=relaxed/simple;
	bh=6YGdcEbu7psY0CECGg/8Hrrfy09dwQCVJnM3252GwPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyk/gsy5cjt1rl9b/z4a2p3TqRfKC1VVxej8mP1zXNuay7M6lAh8uIGT3eUu4kkh9C+gTuJ0Hc15BtnX01IFtmuUvKsNTxtOxJK2QN2mj5u/SqB5DW03B0/850s7h37oPtJ2EAgdjPWc4dz6GYW0YkI/ikZbiW0bmFxJVszx9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwsE85Y4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so5185239a12.0;
        Wed, 05 Jun 2024 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717599149; x=1718203949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6X/f7PPWIX1Kzms7IPH5lwuYJdnB1Eo9TTaF+YUyUl0=;
        b=HwsE85Y4y7Ki2L9V06TqEs7l1WSqd1ItDQ8VI0dwi2Ub/tHs7P4G/R0XALXaBDMQS0
         NEBsUe5ZtQVZEJ7W2w6XXpNW7W1Zgwq7NUXydvte3WLcVDsehC7itCWVNtjKnAJfpcRS
         0Nix4OUa7/MEhlZ2cIPQhCLFhjpLwQxZ98fCsWlYtX/fqzYmWsgycfwJFT0iJwMRh2Tq
         bT9Hr3D/7w+l3igfiTtcEaUGPEVOaZlSmJtW/b07MaF6VluMl8cgje/gua8iFAL8LPrm
         HAPLEGVV9zb8Xqk04HEubmf964D5CbY88IHPN6fb8VebZw4Wg7DslRPclTHjPDGZPCv0
         UULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717599149; x=1718203949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X/f7PPWIX1Kzms7IPH5lwuYJdnB1Eo9TTaF+YUyUl0=;
        b=fR31kEFT4hsQgNmK0RSymVC6saNLWuFN4SKBggoxSYc0gJSHX9V/fXsLFP6vx6oeNF
         PpQP5VnLPMsjb1kHFXcvGxTAVPpjs7eCzqqai90D2nh5QEGMMroeSgTnewnsw4AWgBLa
         TRXsBmS4v+IcaszHF6tMYz569+zoSRertjZsYqIZA6IEl1iSDbrjXXazxbmYYvxMiP9m
         Q+FDz3bXdn7MXCN9yPAfiG34YbAmjCsIKUhvKLPiM0uBET8Q98fmZtIpJP4caVrv4O+6
         ucwj1artlPfWr6deMtiMc37e+PK0/sSR+33RM4199fbM+oWippusOUeMd5SgEZdYAoGi
         a4fg==
X-Forwarded-Encrypted: i=1; AJvYcCXhVOgsl1YM+VI9NI7Kvs4mxlv0nzZ84hZuu1piFy6dOkHx/bAAft9qdA4BrSeBk6Cyl4iDjx+D9HV9F8eTgYdPXB/pgg23t5DwPVPn7HQQ4mcuqL2HMYrjRYIFY4EJ+MRMfXNg9mgYy8XJzNEnbkam4EtB4ondVQDl/3erhUK4eSx7zQ==
X-Gm-Message-State: AOJu0Yz9hjdN5gO5VtzerwB3Jrd9htyyAgCOTxAZlNPUzKm9F0b0LamD
	zNAsjOhkybC6vYDnup91kfzl3ND89usgzQJmAQm+VshS+2lSkLw0
X-Google-Smtp-Source: AGHT+IHfZpY/oJpv1KHxWECam8DBkIhLG621coNQBkTPHDAxVpVXT1v7gNr0xmHExWyRZaSsBNf1Og==
X-Received: by 2002:a50:d4d2:0:b0:57a:2430:67eb with SMTP id 4fb4d7f45d1cf-57a8bc9506dmr1893838a12.28.1717599149183;
        Wed, 05 Jun 2024 07:52:29 -0700 (PDT)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99445sm9334556a12.18.2024.06.05.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:52:28 -0700 (PDT)
Message-ID: <a5570194-920c-45d8-98d5-da99db0d2f8d@gmail.com>
Date: Wed, 5 Jun 2024 16:52:27 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dm-integrity: use the nop integrity profile
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240605063031.3286655-1-hch@lst.de>
 <20240605063031.3286655-2-hch@lst.de>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20240605063031.3286655-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 8:28 AM, Christoph Hellwig wrote:
> Use the block layer built-in nop profile instead of reinventing it.

As this is my "invention", I am pretty sure that "nop" profile was
not available at the time I was prototyping AEAD dmcrypt extension.
(It was months before we submitted it upstream - and then nobody
apparently fixed it.)

So, I am quite happy this hack can go away!

I run full cryptsetup testuite with this patch and everything
works, nice cleanup.

Reviewed-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

> 
> Tested by:
> 
> $ dd if=/dev/urandom of=key.bin bs=512 count=1
> 
> $ cryptsetup luksFormat -q --type luks2 --integrity hmac-sha256 \
>   	--integrity-no-wipe /dev/nvme0n1 key.bin
> $ cryptsetup luksOpen /dev/nvme0n1 luks-integrity --key-file key.bin
> 
> and then doing mkfs.xfs and simple I/O on the mount file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/dm-crypt.c     |  4 ++--
>   drivers/md/dm-integrity.c | 20 --------------------
>   2 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 1b7a97cc377943..1dfc462f29cd6f 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1176,8 +1176,8 @@ static int crypt_integrity_ctr(struct crypt_config *cc, struct dm_target *ti)
>   	struct blk_integrity *bi = blk_get_integrity(cc->dev->bdev->bd_disk);
>   	struct mapped_device *md = dm_table_get_md(ti->table);
>   
> -	/* From now we require underlying device with our integrity profile */
> -	if (!bi || strcasecmp(bi->profile->name, "DM-DIF-EXT-TAG")) {
> +	/* We require an underlying device with non-PI metadata */
> +	if (!bi || strcmp(bi->profile->name, "nop")) {
>   		ti->error = "Integrity profile not supported.";
>   		return -EINVAL;
>   	}
> diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> index 417fddebe367a2..c1cc27541673c7 100644
> --- a/drivers/md/dm-integrity.c
> +++ b/drivers/md/dm-integrity.c
> @@ -350,25 +350,6 @@ static struct kmem_cache *journal_io_cache;
>   #define DEBUG_bytes(bytes, len, msg, ...)	do { } while (0)
>   #endif
>   
> -static void dm_integrity_prepare(struct request *rq)
> -{
> -}
> -
> -static void dm_integrity_complete(struct request *rq, unsigned int nr_bytes)
> -{
> -}
> -
> -/*
> - * DM Integrity profile, protection is performed layer above (dm-crypt)
> - */
> -static const struct blk_integrity_profile dm_integrity_profile = {
> -	.name			= "DM-DIF-EXT-TAG",
> -	.generate_fn		= NULL,
> -	.verify_fn		= NULL,
> -	.prepare_fn		= dm_integrity_prepare,
> -	.complete_fn		= dm_integrity_complete,
> -};
> -
>   static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map);
>   static void integrity_bio_wait(struct work_struct *w);
>   static void dm_integrity_dtr(struct dm_target *ti);
> @@ -3656,7 +3637,6 @@ static void dm_integrity_set(struct dm_target *ti, struct dm_integrity_c *ic)
>   	struct blk_integrity bi;
>   
>   	memset(&bi, 0, sizeof(bi));
> -	bi.profile = &dm_integrity_profile;
>   	bi.tuple_size = ic->tag_size;
>   	bi.tag_size = bi.tuple_size;
>   	bi.interval_exp = ic->sb->log2_sectors_per_block + SECTOR_SHIFT;


