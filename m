Return-Path: <linux-scsi+bounces-4444-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509489FFE1
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Apr 2024 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E988B2497A
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Apr 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494B168CC;
	Wed, 10 Apr 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWR5Y3wJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DBAD4E
	for <linux-scsi@vger.kernel.org>; Wed, 10 Apr 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774034; cv=none; b=AmfWCjaW7F9KZGl5lLAtsSG8isfgeU3Ks3FVgWfzT28vZEWouMqnvy80Op6I/Cb6hupWlWbtVo7ioZuh3nV1V1kJtBJbFcTYFOmA5dV8Xb23BIG+SOosKxmDS2thjSYTzrTf9xFTqK1ZxK6CbHUYQgNdmmMYCXq8F70Fo3YgxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774034; c=relaxed/simple;
	bh=AXG6RJVXKDt+/DjwiwTtJ2dE7tTZOrDLGSw7IO1r/+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRXzHMy3wYfE7O2ehkZYAPzxRS/RhXLW/bOtf2ugWMm5rTZhC6hPieto6SnyOLcoiVYzQx66BfsHEhRfkefE74cTwOesZPvUjb703usV7tx9IJKRV+L1EQIUbeRyUe13Qnm87o7uengtGApqub7OTWEwbrireeh0HWUKSBZzcq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VWR5Y3wJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so3901416b3a.0
        for <linux-scsi@vger.kernel.org>; Wed, 10 Apr 2024 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712774032; x=1713378832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hVCerfmQhkum0yIRABrdvwqbTpQW1aJkY1zYTHRoGBE=;
        b=VWR5Y3wJ+xp9jDf40vXWpj/h8dt6K5tZdr21vslB207blGuHt5PyaFDsFCfao1D9PG
         EWmb3J+ghTxgfG89ERErGbi4a/nYPxm/eevNkvDqQ9k5blgGqbgJHNUMQ97ujRBo/Fnp
         7guhFJAuHPUKUWnZvjmaL501yFemF8vc8eYZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712774032; x=1713378832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVCerfmQhkum0yIRABrdvwqbTpQW1aJkY1zYTHRoGBE=;
        b=CyfVLpp+SOv88HqVg+7i816PNa8gIGBmwDf3/xUAIZZ1z/4+8emL400YJKdxWTz/tJ
         EBR2rf5567iLZpeyjaqrkUAcYcBxVALtV1o9HBhe9yPmoEtWjFkeM2LZDjXu2UV6C2Ow
         EySN/lxX9QTVRgo3iZlOwlZMfJefXLfCdsDkH8y6nXy5AMzxM254sp4lP5XzjMcYocKA
         INiosGxCxRrbCN4jJ6RJqiBcgjYBctW3BmVLAzK6HUM1tIqYoegZNoNv75GfMlrTEIZg
         t8v/8/Qf3FJcc8vROjD7WNiPRcHkn4TX6aCBTCNDbNSSAU7A8aidARhgec8C9hLYM1yj
         lhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcmM0vxOWxAgi3q0kkF4XMALRBtIhjfa5M4LOZ7AtEvNSBUGsFIhtk+/5EFbjRF6WHtkS+Cnfc3jT7Kt95iuadjKNADDdSstCVgA==
X-Gm-Message-State: AOJu0Yy4e84YWN1ND4ZWNRL/+FDzA6JNOtBwNbeckXCAm4n4VQDiB221
	tp8CtxhKdjUrH0V6Eilia5U92JS1Qhv5f6Hnp+vs6H4qrDCHAe2NO5tJk8BjNg==
X-Google-Smtp-Source: AGHT+IG7MfM1fYKWn8ghxeYU/65fuLZA+NPjkKP9uCGydgjLdCYH2Vdfb9Q7ZcXytxDQ7da1w5ozew==
X-Received: by 2002:a05:6a00:9288:b0:6ea:d794:ccee with SMTP id jw8-20020a056a00928800b006ead794cceemr3862401pfb.17.1712774031421;
        Wed, 10 Apr 2024 11:33:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i6-20020a056a00004600b006ead618c010sm10352691pfk.192.2024.04.10.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:33:50 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:33:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Charles Bertsch <cbertsch@cox.net>,
	Bart Van Assche <bvanassche@acm.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/5] string.h: Introduce memtostr() and memtostr_pad()
Message-ID: <202404101132.7D845EF323@keescook>
References: <20240410021833.work.750-kees@kernel.org>
 <20240410023155.2100422-1-keescook@chromium.org>
 <CAHp75VeOQ+x3WgFeG89X=kGUo=w=ztkdBkA3_K6yy+2mWV83AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeOQ+x3WgFeG89X=kGUo=w=ztkdBkA3_K6yy+2mWV83AA@mail.gmail.com>

On Wed, Apr 10, 2024 at 07:08:10AM +0300, Andy Shevchenko wrote:
> On Wed, Apr 10, 2024 at 5:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Another ambiguous use of strncpy() is to copy from strings that may not
> > be NUL-terminated. These cases depend on having the destination buffer
> > be explicitly larger than the source buffer's maximum size, having
> > the size of the copy exactly match the source buffer's maximum size,
> > and for the destination buffer to get explicitly NUL terminated.
> >
> > This usually happens when parsing protocols or hardware character arrays
> > that are not guaranteed to be NUL-terminated. The code pattern is
> > effectively this:
> >
> >         char dest[sizeof(src) + 1];
> >
> >         strncpy(dest, src, sizeof(src));
> >         dest[sizeof(dest) - 1] = '\0';
> >
> > In practice it usually looks like:
> >
> > struct from_hardware {
> >         ...
> >         char name[HW_NAME_SIZE] __nonstring;
> >         ...
> > };
> >
> >         struct from_hardware *p = ...;
> >         char name[HW_NAME_SIZE + 1];
> >
> >         strncpy(name, p->name, HW_NAME_SIZE);
> >         name[NW_NAME_SIZE] = '\0';
> >
> > This cannot be replaced with:
> >
> >         strscpy(name, p->name, sizeof(name));
> >
> > because p->name is smaller and not NUL-terminated, so FORTIFY will
> > trigger when strnlen(p->name, sizeof(name)) is used. And it cannot be
> > replaced with:
> >
> >         strscpy(name, p->name, sizeof(p->name));
> >
> > because then "name" may contain a 1 character early truncation of
> > p->name.
> >
> > Provide an unambiguous interface for converting a maybe not-NUL-terminated
> > string to a NUL-terminated string, with compile-time buffer size checking
> > so that it can never fail at runtime: memtostr() and memtostr_pad(). Also
> > add KUnit tests for both.
> 
> Obvious question, why can't strscpy() be fixed for this corner case?

We would lose the ability to detect normal out-of-bounds reads, or at
least make them ambiguous. I really want these APIs to have distinct and
dependable semantics/behaviors.

-- 
Kees Cook

