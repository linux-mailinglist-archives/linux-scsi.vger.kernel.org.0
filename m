Return-Path: <linux-scsi+bounces-1105-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B9817C45
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Dec 2023 21:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B778E1F24599
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Dec 2023 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B07346C;
	Mon, 18 Dec 2023 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nY+BpKP5"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8A7346D
	for <linux-scsi@vger.kernel.org>; Mon, 18 Dec 2023 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28baeccddb4so423211a91.2
        for <linux-scsi@vger.kernel.org>; Mon, 18 Dec 2023 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702932620; x=1703537420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VYuhGNACrh4RxyK7vwhYZLcFzB1f10C6T9YQ9W4h0I=;
        b=nY+BpKP5a7NV8lBnYEvh6u9ZeBnp/zbTuylqEjJNVDUQB0d1I4HvQmFJBIoeqXik18
         H/bYy1bZGe85sLtmQ4JYggNYHT9ZzHGf+AfAFA2Qr+9nF4Q6pbMSeu9xekx9sbQ/gKag
         hCco2a5m62y6x8EGd4Zs25pcpKIxBiwlUQwMiuGzcwXOOLuSBx8as+OEtQ2f2BP6H1GW
         uKjoaD5KZTmuqJEYzKelEdy9WoWmgJdA/qCU5I6SVxCijtYbZ391gZrKfSoEdaiiI3ZU
         BS5CZG/rHB6PTaxldUyy0OJiWZrU0IX9I5uQ33l3lkYUqxS7hOtf/8/0atu7ITVKVcAY
         6ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932620; x=1703537420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VYuhGNACrh4RxyK7vwhYZLcFzB1f10C6T9YQ9W4h0I=;
        b=pk5laOBgdQQkx6EluEM4h+i7TL128o0+iVQa/FXv/XyyFMOi8gh6VSYsjzTb3z8/YC
         xNZwz0zYtMC9VF9aCaDuwD/LmuRTKr9FjykKLjs5kWEC760riR0xUnKnwdj7gUNcOZI1
         OE3ZU3ASyeK1NVMPrRaTqXN2KgqNqlkRl8syIOimykT5JOwPA16uetWa78v6R/5IfODx
         qPBe2ToXg6HVC7kU55imO4wxxRsCi1035xO+ye/55aGrqmajxt0irsdMB2rCkZapV2bN
         KeiBPJRIPCuKEZ0kdRZS01/fJW/4wyCOz5hRlq6O4Zb/09umN4OPJwVv9fXjwCzBAV4X
         h/ug==
X-Gm-Message-State: AOJu0YxcBhPIN4OyQc2o993bSENmMOuIpGg9w+7MWMWxnEBA200eA3ht
	U8e9pfuFM/Z0HZEUTFqe70iJ2w==
X-Google-Smtp-Source: AGHT+IEcehJB+ZsazS59hM/1fa/WGZjE8Vnyh7uwh2p3+WD/I5U+59Kjmr50pBpBUNXzLwVtu1jPKg==
X-Received: by 2002:a17:90b:3b87:b0:28b:7643:e65c with SMTP id pc7-20020a17090b3b8700b0028b7643e65cmr1027749pjb.56.1702932620479;
        Mon, 18 Dec 2023 12:50:20 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id jv14-20020a17090b31ce00b0028aecd6b29fsm10415331pjb.3.2023.12.18.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:50:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rFKZ5-00A8Va-2x;
	Tue, 19 Dec 2023 07:50:15 +1100
Date: Tue, 19 Dec 2023 07:50:15 +1100
From: Dave Chinner <david@fromorbit.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 05/19] block, fs: Restore the per-bio/request data
 lifetime fields
Message-ID: <ZYCwh7RJ4EpXD+7X@dread.disaster.area>
References: <20231218185705.2002516-1-bvanassche@acm.org>
 <20231218185705.2002516-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218185705.2002516-6-bvanassche@acm.org>

On Mon, Dec 18, 2023 at 10:56:28AM -0800, Bart Van Assche wrote:
> Restore support for passing data lifetime information from filesystems to
> block drivers. This patch reverts commit b179c98f7697 ("block: Remove
> request.write_hint") and commit c75e707fe1aa ("block: remove the
> per-bio/request write hint").
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

...

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..97e20911b45f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -380,6 +380,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> +		bio->bi_write_hint =
> +			file_inode(dio->iocb->ki_filp)->i_write_hint;

We already have an inode pointer in this function (from
iter->inode), so:

		bio->bi_write_hint = inode->i_write_hint;

-Dave.
-- 
Dave Chinner
david@fromorbit.com

