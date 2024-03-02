Return-Path: <linux-scsi+bounces-2848-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A9D86F258
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Mar 2024 21:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28C11C2092F
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Mar 2024 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE7405F7;
	Sat,  2 Mar 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEQnPFPG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F783FE5F
	for <linux-scsi@vger.kernel.org>; Sat,  2 Mar 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410840; cv=none; b=FE0qNmZaihD6ECuVBEHJKcO39OmIIQMOeywuoKav9uJi9EXXGnqusY7pmHor3nweqvhtV8YQ3tlIONhXiGWuXedDoc27bv2jpBoaCHTWOKzdkIwpSFmOGtrZAsSG44+5gYHH52Ca0krdyr2/xScJe1+nJUBcXNnR6wbXzAshGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410840; c=relaxed/simple;
	bh=Il4TNeGZ87lBBA6QRmI8wfKgBRijwa3cS1rM+/WJJ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqNeZcht7acf36EqZmaa/Jc2n/LGnHLZUpAlW3O8jA1pQzjmljM/31J1oRPc1xtWwXDowMKOjsMJnScVkPBkXRoJuZ/CakdFFX7eEihn5Wf5qe/2Ti4SN6EcPdrcKXFtlfZh/mGno5pt8PTvZ7YiETmc5Ko6l2p5bgi6aDihw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEQnPFPG; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3650c7e0dd2so12225625ab.2
        for <linux-scsi@vger.kernel.org>; Sat, 02 Mar 2024 12:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709410838; x=1710015638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLDiv6aj5j9bGmsHcUHk2rwN974mAAiIOmfVyl85S3Y=;
        b=pEQnPFPGSYYQzvR7/P6Eq2tmOmpgqbZU/P5R+dtiz5jDj6CfCcNUlybIW0oeF3Mt6Z
         hM39jFXTtG0Tp9XnFgPlYxRS4KtYf8iW3JvNI/K4roBWfQ+j85IzCz1RkHgH0rvRnT9s
         LdN9PuKPPUcj6IFL5SnZh6AoQYPLHYXAuGz+cAnaYi99H7Cg/pYHqi2e8AGItdhk76L2
         Z9rbMFDfN7ZrkbJnrLNfiuxbYB3tFYDjFR3EbRxFZmLAe8J5BIjBAAmx3Fq3cePFzCNg
         EdFFZGFbVz7VFecH5ACQnaeQKFjnumYCMQ17cJB5hJ0OWIEbSrYQTt1eRoyE7RHG9QuW
         i4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709410838; x=1710015638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLDiv6aj5j9bGmsHcUHk2rwN974mAAiIOmfVyl85S3Y=;
        b=Lu9kny1OBHh8+qvLfrDJ+sRy/v35fuCVPK7PiNw4nSfZ8xG0rQwoJ23GrRZg4SkOGX
         UfH2t3lgkmIxwD8adkXkrLS0Lth/b7eXMfJAk/pEt0CqsT6k2SP6TPOeCUlM6aDByUG0
         k32lak7MbjyzC/vBq5kDIowOHWit4Tibo/Qs/qFeKso0IdIRANaNj4bs6oMuStqoNGAE
         IV6U8hwNI/m6XwcKsLuWL8YTKq46gois4e3EmH3F6jEO936TTsiBuvKezHNwkcsVBn0s
         Z89/nxlyp6XpdAsjDy/q0NVgCZWhHeS9OShYGj1WHNQQn+//mMx6gxmHSVi/youDi2lX
         77oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQf3LgTsLNjKvq/WwgvBqs3/XiL2np0gdKwCASlC+6HkpoEa2scuD4aF+sMZp8tJLv9Zc96EzLrYdC8OcHsJgtiJfyXNffq6QvNg==
X-Gm-Message-State: AOJu0YybLhYW3hL43IU4u6NCWU8fjws63a4nIPeNz37CwzbiabZW0a/r
	sEaLyDyTUYFw43PSPSQ5tQEXpIajm2mUR3ntfv4LhbRfLeR3PvtlE2NTTijVaw==
X-Google-Smtp-Source: AGHT+IGWHtZpooNRhjtLGiXDKWHHb3lExF13M/bZvYdKWRjeMnuIBH8ANCqhWwP12f0YF8dMR1h+PA==
X-Received: by 2002:a05:6e02:1564:b0:364:2239:a89b with SMTP id k4-20020a056e02156400b003642239a89bmr7054185ilu.11.1709410837857;
        Sat, 02 Mar 2024 12:20:37 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:41a7:9019:9a7:b404])
        by smtp.gmail.com with ESMTPSA id 7-20020a630107000000b005cf450e91d2sm4984639pgb.52.2024.03.02.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 12:20:37 -0800 (PST)
Date: Sat, 2 Mar 2024 12:20:32 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Jason Yan <yanaijie@huawei.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>, TJ Adams <tadamsjr@google.com>,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZeOKEFC10lD-9Kle@google.com>
References: <20240302001603.1012084-1-ipylypiv@google.com>
 <20240302001603.1012084-6-ipylypiv@google.com>
 <e363a966-46a6-5c19-ea6c-77db43021149@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e363a966-46a6-5c19-ea6c-77db43021149@huawei.com>

On Sat, Mar 02, 2024 at 10:54:14AM +0800, Jason Yan wrote:
> On 2024/3/2 8:16, Igor Pylypiv wrote:
> > The added sysfs attributes group enables the configuration of NCQ Priority
> > feature for HBAs that rely on libsas to manage SATA devices.
> > 
> > Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> > ---
> >   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 6 ++++++
> >   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
> >   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
> >   3 files changed, 18 insertions(+)
> 
> As John pointed out, please check aic94xx and isci driver, they also use
> libsas.

Thank you, Jason. I wasn't sure about these drivers. Added in v3.

Thanks,
Igor

> 
> Thanks,
> Jason

