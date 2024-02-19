Return-Path: <linux-scsi+bounces-2558-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52385AF2E
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Feb 2024 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800111C22B2A
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Feb 2024 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB958208;
	Mon, 19 Feb 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YHO5yy9I"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093458AAA
	for <linux-scsi@vger.kernel.org>; Mon, 19 Feb 2024 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382659; cv=none; b=PFJfkk6ZiFglCZtd7fhJEq2caWLoPLFyHogLUYwImUwzEykZjpNrIb0QKMi7aKA4iUHnZfxxZUwqTNXBcsZ1rZd2kAykdSaOq9Bjh8BcaTqO7k8aM3ZvJrB2uzE9IsVkfIpzMEB6yBhNHl4dtyUPD0MN1UVihOV/ZrWfk5hwspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382659; c=relaxed/simple;
	bh=hYFT0yNn5dbWJ2EEPl3GHhjy/6vfwX/GcDeLgyUfIMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ3ym3w3CgsZRHUUvPg14eO4zwNytBmr3pDnAOBi+25lElSaFE8I6Bo3c7DSY+TdQluDDr8pFkFGls9CMEfVkbXQ1jCeLbJTWHsz3wK+Tg7V5KYnS6TdIdcEy8xr8bYjukosQ41VOnvUP4GBcyEo/UFByQEJX0ubtPh8bZHNC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YHO5yy9I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dba94f9201so29241895ad.0
        for <linux-scsi@vger.kernel.org>; Mon, 19 Feb 2024 14:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708382657; x=1708987457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9Ts2f1R3ZP5ehz4Ryw7qzx5Hb49U9Z/fGb1ezuOXHs=;
        b=YHO5yy9I3R4q9CASkabXvZPm2+4f92cD04z3oKV8IvVqEfou5m/qT7TpOn/dwMqQQA
         U4mah/LR4aQnp8OeGTs3NuATcwFl3+IlasT7WWiXa19kG96O/aX1TdEBqPHiGvEtlHry
         P53pqAzlvlRDPmpDISvaySrwAV2m6G7RtsoEVcyGGSbBpq+oXJ6bx6k08gZBkF8qpNcv
         RwXgAvY3+R2LUm+ZbZQIua5w/46H3QjuMVotHYLEosOMetx7s8Ljk/kiVHZq3N2mUmkF
         IP8E1sMheTk4Nu5qYMuNmB+AmJtEQcKXWANN00ELuziqn1dIdgQa8abZ14Fr08FNhdL7
         dx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382657; x=1708987457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9Ts2f1R3ZP5ehz4Ryw7qzx5Hb49U9Z/fGb1ezuOXHs=;
        b=Rcnm9tKmIDKjl2qI+bXFtSveNS1og1rS0Acx1FDFrpIcguZEiIZVoCj16PMZWEho+M
         tWFasr6YV/KsjnXaFmuAMlpT0nsOk/HiB+iTOGKnfJ/UX8nbLd2KY2QXouTYyDFLkmhn
         hQ6VNdC38diw8Te//2dozSwy9Id0ufwZ76YDnNnG0js0u2ugSfRO2aqvzfqDFRy4EIpY
         TEYYkWjJJWM1QGmY7WUr0DF8VLRxYtft7CoVzMrCdGaVocGZCokPLwfTpD2ixQ6HOoc0
         PjaZC4XW3o1OVSXu51gvATyNcAZ+3y38xYN6srE6P8g5vqnk2PJxXtWzhYKRhAmFV9Uh
         3aKA==
X-Forwarded-Encrypted: i=1; AJvYcCXeL3XhRq1UNbArS3s4ONR7aEglhZ7zny/cvm62yhYI4v7peWtl7KDceSggwrIkvoHqeo/PrzSnFFi+0iJL7cAgGIzga2QVTZcWiQ==
X-Gm-Message-State: AOJu0YwEWAv70sSw6n+/NzPfT/0iM9npw/mGimazXJvf6TqwzmZJUgDr
	9d19egs15b7Bl3ojm10ouBoWis+oLAOus+3wu/AjCtOKf/CsPXVOMKrOU2sLDYE=
X-Google-Smtp-Source: AGHT+IHtkpRXt4t+i6SxwRLeZE82T0JiGotni2ywqDT8XTyF+HxlsLNBTl8TRCMTJinSK3yziLiesQ==
X-Received: by 2002:a17:903:1211:b0:1d9:a609:dd7e with SMTP id l17-20020a170903121100b001d9a609dd7emr16096638plh.55.1708382657159;
        Mon, 19 Feb 2024 14:44:17 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id lw15-20020a1709032acf00b001dbb6fef41asm4880249plb.272.2024.02.19.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:44:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rcCMw-008oFa-1W;
	Tue, 20 Feb 2024 09:44:14 +1100
Date: Tue, 20 Feb 2024 09:44:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 03/11] fs: Initial atomic write support
Message-ID: <ZdPZvqLgwWSP1ppv@dread.disaster.area>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-4-john.g.garry@oracle.com>

On Mon, Feb 19, 2024 at 01:01:01PM +0000, John Garry wrote:
> @@ -3523,4 +3535,26 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>  extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>  			   int advice);
>  
> +static inline bool atomic_write_valid(loff_t pos, struct iov_iter *iter,
> +			   unsigned int unit_min, unsigned int unit_max)
> +{
> +	size_t len = iov_iter_count(iter);
> +
> +	if (!iter_is_ubuf(iter))
> +		return false;
> +
> +	if (len == unit_min || len == unit_max) {
> +		/* ok if exactly min or max */
> +	} else if (len < unit_min || len > unit_max) {
> +		return false;
> +	} else if (!is_power_of_2(len)) {
> +		return false;
> +	}

This doesn't need if else if else if and it doesn't need to check
for exact unit min/max matches. The exact matches require the
length to be a power of 2, so the checks are simply:

	if (len < unit_min || len > unit_max)
		return false;
	if (!is_power_of_2(len))
		return false;

> +	if (pos & (len - 1))
> +		return false;

This has typing issues - 64 bit value, 32 bit mask. probably should
use:

	if (!IS_ALIGNED(pos, len))
		return false;

-Dave.

-- 
Dave Chinner
david@fromorbit.com

