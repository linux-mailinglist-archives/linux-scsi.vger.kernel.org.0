Return-Path: <linux-scsi+bounces-4497-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 854DB8A18CE
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Apr 2024 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3419B29FEA
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Apr 2024 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55124175B6;
	Thu, 11 Apr 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5YRkVIs"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F5171C9
	for <linux-scsi@vger.kernel.org>; Thu, 11 Apr 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849141; cv=none; b=mEJV0SW5o0k0RqFUGhL9BlWw/SUpyi8fVPyQElzK7LFSOlYDc5dRHd0UeNyLgpPdcB3URvWJdV2npJH0Bu+pRVsSsASEwYSN3hAMq+sBwS70m543a3NVElBqkH43n9rulj8qJTGYsi8m42bOciyMt3scBKGwa+TmktXFOQRobxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849141; c=relaxed/simple;
	bh=S0tSkli8JleHY8iE9O2afY6bV3mjLC/eVHPCMEho8Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4MGeXB5ZJu8SyaVG4mmzetcyoZo97xSFgBibT3pDVz0L7Vbp7CmN46IX8Ui2ZF/OKF+aB7tRpXSFeI0vp3vyjmi7HJyo2KTcIt8VfJielRLZd5Tkchu67ESbwew7qOY+SL8YLagS0zC8dtPj5epNtCThYFAvNKHguX6nxjHdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5YRkVIs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a1c8d931so791401166b.0
        for <linux-scsi@vger.kernel.org>; Thu, 11 Apr 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712849138; x=1713453938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=U5YRkVIsfjsdxYrqviqFldW3aGgJpxI95Xx9WtuZtRE4oGNUou/5vryJRC9Fm9mbWI
         0oW0BHPWPWBNjOdKKZtlJlPuSTA7JCxqdpogQMFdoBWF1OD3kPk3rs7hdHqbvgvZDg0g
         FPiIFMNvhw/PbASOX8xkWBMy8iKmqHbZbXdnniQgC1etonGUdgwPRRGtUD4z+eu6vlgb
         Hnq5Ee+6VznM1khG44NboOAIt8kYqj5Q2zDb+onyXfL4pNnVpUZMlB7sfzDCSNFLZ1Ss
         C8s8Fb2FJ1eVCLip9agNb+b1Vd0rUZFWc6akd2nrOheBpdsw0oUWp/Fy5ElLUlEqV/k0
         LcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849138; x=1713453938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=kgIL4NR1mpkFQrqEa5FkuwSYQFaD7N6D0uLcB3XBV5DKGwMpbvviU2VCf+SY+gGVTT
         AF2pXLSNBryZH1D7ZZ57doFg0VBM+llMYf4rmyLne/rvAQI5XVX7zYGYjj3+3OvLbTjB
         Sg+6Ar81Mq/DuccOK8yIF5tpmLnwOjq/f7uRl1RxBksTxQmIFEFBDK/rt1a1ZT/J0EHW
         9O1OQIRx5o4c3ZsOBKZPAmJ3S0GJt2mnSR2GWkFmD6ttlwVziBaDoIwXggEfHDrW2MYH
         ZH3oOaJpXn8IkraUjpd1/W+SQV18I3q76G01/ZEvQEcg9DkYAi5KgQiVlEFqw1s+mXV2
         r+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtiUS/p7uPLtVFb9CMHC6sr9ObyD9pa33NBErmmvmvLfT4Jj6b/HnxQsO09R0olcnvu6zSgAouzb4gq442upQM6icS9EVm713N3w==
X-Gm-Message-State: AOJu0YxTEUoPCmthDdFNwtEtdvHrvmTrgFEmTYDaw/cCfhiF4yrQ1kxM
	lSNb9aSj4jAENZR94V0pzr43fQyL3z6u5CYCvp+beyIclZbsxJvkIM0Bt7uzbDA=
X-Google-Smtp-Source: AGHT+IEEewk7llSPmgrxe/7mA2rySV/OUDonUpYE2d0l2M0z39pI2HKiyjdOd8AbAw/PCbmxmW//Bg==
X-Received: by 2002:a17:906:4f06:b0:a52:3d1:6769 with SMTP id t6-20020a1709064f0600b00a5203d16769mr44591eju.14.1712849137563;
        Thu, 11 Apr 2024 08:25:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906350300b00a522c69f28asm225076eja.216.2024.04.11.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:25:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	speakup@linux-speakup.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-afs@lists.infradead.org, ecryptfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-arch@vger.kernel.org,
	io-uring@vger.kernel.org, cocci@inria.fr,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
Message-ID: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411150437.496153-4-thorsten.blum@toblux.com>

On Thu, Apr 11, 2024 at 05:04:40PM +0200, Thorsten Blum wrote:
> Use `find . -type f -exec sed -i 's/\<the the\>/the/g' {} +` to find all
> occurrences of "the the" and replace them with a single "the".
> 
> Changes only comments and documentation - no code changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

It's tricky to know which tree a patch like this would go through.  We
used to have a trivial tree for this stuff but I guess that didn't work.
It's possible that it could go through linux-doc, but probably it has to
go as a set of patches through each of the trees in the CC list.

regards,
dan carpenter


