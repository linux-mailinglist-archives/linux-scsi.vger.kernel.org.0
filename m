Return-Path: <linux-scsi+bounces-2984-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE388872B6D
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Mar 2024 01:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A03D1C2644F
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Mar 2024 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD302137901;
	Tue,  5 Mar 2024 23:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOmB7hBU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22238137908
	for <linux-scsi@vger.kernel.org>; Tue,  5 Mar 2024 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683136; cv=none; b=R0CQyqX+a5gKd8pbhWiHnlceUtbWznEEaJidLy8w/3aJvM5z8GBvJJCTDPAcybmOF5/Kuk1+Gip88YKvxCy1ma1K7L4nE3lZIHCV3+Ts1KL1EL2Ws6yK+O7lMSZfZZjICdGrSf0u15DHRXvdN7eTmRDhKFVE842mHcBqvXQyRLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683136; c=relaxed/simple;
	bh=0quR6jT1iSZ5BUKkLzcCS0XyF7BMV8/RZalK9QAAEWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPuXv6c3dm2zNf0QrNdKRgHkK68grCqpHldVK4qr36luzFQAyAcUFXA/b2bpHa6/XXg3evitUG9K3lkCkS4ypVUec432+ChPBv29AlB1kZp4S0H8MY1OTdX6fej8+/4yqFfTvwdtv5Cc5UmuJ2maqK5xyNCQXqpdKtD+qGFjXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOmB7hBU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc139ed11fso2280785ad.0
        for <linux-scsi@vger.kernel.org>; Tue, 05 Mar 2024 15:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709683134; x=1710287934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yoeMjmCuBFOKAs53t5huIMO06TFd6SVXa5LbxptBQg0=;
        b=yOmB7hBUnGgDpMLaksSaAij6gPpATQPwEuwoen7roHm4gqr90Owej/M933wiZbyJBH
         2E/dx+uMRfcG9qdS4C4QVy3ILBuruBJooiRre+FwTjWrTgZyjcNKAC+muoaa1XeJUZwM
         qFzCcCEJRErM3sJFCeHwRQfp4TC8tddpFA6gaRY7L+csCacbor5687Gyg9y1DjoCKer5
         9411C0szysHsnDbFL38wyY7F8VbXkxjMoOcNNLChAhTzbbSYXO4SNC2dDZzzE0bnJ97+
         3pnZ6mWA/t1herrco1Tg8aqgT0k6IcvoiaUaJkaWhn07Wacj3VF43eJuo9hfzCg5W6F/
         HwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683134; x=1710287934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yoeMjmCuBFOKAs53t5huIMO06TFd6SVXa5LbxptBQg0=;
        b=Bxf0bciI85EOIfSlKFaiuOLbU7NiNA3+4qgscHp/J3a3godCy7Ksl7ADmCgu0isFR8
         nPwD6Jyr2mdQXIeEjSYvL2l3y0Qa2wBWvBu8vRtiInlyhOFFz0W3tmqppMxZbRK3nzJd
         gzJpVF2FveEnxTVNcVHZRdCUYw0C9E7CMFpVkxLzgPY9nRcfa08JWVWyOYunKWKygsB9
         QZIySaAWcORFMyH/aXw/NAwZ3VtScfOAMZczS3om8248f19Dbh5pmjxlr9vO7Sb4AAg8
         seBPv9OzXEqXlQ5Coz/RF6WeMt+rVljl1ZeyafmdK6NHLVhTACjvaffOqf4+UwMSIloQ
         jF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVwUxXrY5TV6msrKyqp5G+1bwGnx6pTjdsawaCmpSJD9cE4sllRfCABiCc9hULnkhd6d6OL/NxSbeJTTLeiVXc1Smwx8i9NbpQSvg==
X-Gm-Message-State: AOJu0Yx/1OIGd3wxSLbXgvyKaNvCDATRMynhX5APp8be7eM9dq3oIwd5
	QqpVYWGQJy30Ar5J3nga/OGCHTLHdtlDFoEv4xBSTTHGiA62vEK5bsmD7ZjZXw==
X-Google-Smtp-Source: AGHT+IE1MfSHWIiwGN8h37c7Vg/clchaBXy9FgZ6ivdHBH6i1PR5ZY0IJdVjuGpFO1PZNM0CRrcv6w==
X-Received: by 2002:a17:902:c403:b0:1dc:88bd:64db with SMTP id k3-20020a170902c40300b001dc88bd64dbmr4959704plk.21.1709683134149;
        Tue, 05 Mar 2024 15:58:54 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:69ff:df2c:aa81:7b74])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902e19200b001dc95e7e191sm11153788pla.298.2024.03.05.15.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:58:53 -0800 (PST)
Date: Tue, 5 Mar 2024 15:58:48 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] scsi: libsas: Define NCQ Priority sysfs
 attributes for SATA devices
Message-ID: <ZeexuDYlmaDoDmtv@google.com>
References: <20240305005103.1849325-1-ipylypiv@google.com>
 <20240305005103.1849325-3-ipylypiv@google.com>
 <3fb62749-8c66-47ae-9b8b-7e670ebf4841@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fb62749-8c66-47ae-9b8b-7e670ebf4841@oracle.com>

On Tue, Mar 05, 2024 at 11:29:11AM +0000, John Garry wrote:
> On 05/03/2024 00:50, Igor Pylypiv wrote:
> >   static inline void sas_ata_disabled_notice(void)
> > @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
> >   	sas_ata_disabled_notice();
> >   	return -ENODEV;
> >   }
> > +
> > +static const struct attribute_group sas_ata_sdev_attr_group = {
> > +	.attrs = NULL,
> > +};
> 
> I just noticed a build issue.
> 
> With CONFIG_SCSI_SAS_ATA not set, I get this for W=1 build:
> 
> In file included from drivers/scsi/hisi_sas/hisi_sas.h:29,
>                 from drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:7:
> ./include/scsi/sas_ata.h:129:37: error: ‘sas_ata_sdev_attr_group’
> defined but not used [-Werror=unused-const-variable=]
>  129 | static const struct attribute_group sas_ata_sdev_attr_group = {

Thanks for catching this, John!
For some reason I only get this warning with gcc but not with clang.

> 
> I suppose that marking sas_ata_sdev_attr_group as __maybe_unused is ok, but
> less than ideal. The linker should strip it out of files when unused.

Looks like adding the __maybe_unused attribute is a prefferred way since
it is mentioned in the Linux kernel coding style:
https://www.kernel.org/doc/html/v6.7/process/coding-style.html#conditional-compilation

Added the __maybe_unused attribute in v6. Thank you!

> 
> I think that this is also ok:
> 
> #define sas_ata_sdev_attr_group (struct attribute_group) {}
> 
> The compiler here will create a empty structure and have
> &sas_ata_sdev_attr_group point at it.
> 
> Thanks,
> John

