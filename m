Return-Path: <linux-scsi+bounces-3138-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3D87785F
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Mar 2024 21:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD0281101
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Mar 2024 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF83A1AB;
	Sun, 10 Mar 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ct9vcta"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F91E51E
	for <linux-scsi@vger.kernel.org>; Sun, 10 Mar 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710101153; cv=none; b=jvK700xAvFXQJUHLAZxL+WoDOvhzRidsEdpU9RmrHsBBAVdwTYvAxFgq4fXIoWc35fpDNm2xHZNhYFEzQaNyh7j3NSyO7sMqXT1Sc/g+cO7cLD3eUaEin4REGeZNs5PG05qQ+AFW5xkrd/rwGi5QGYGGe0KCpr5rjrIu6n2XiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710101153; c=relaxed/simple;
	bh=axkdLd7QmlW/nS3h7kOIMAbn+TRaZ9Z5Zq5yBjNkkI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrfpDvsiK7EiKPPwyIatZm8Ogz2V2gxcvZvGt93d/VPAkvSswApOuLaOMuLedszERZNSpJpjwBcP0qRvxFKb5xQwSo41weP+pYifceR7gBjtCVDySDhDgs8f/FGVVn+B8+J4G+N1ROq5nbKjSqz/VCUtBvuvSfI+136Tczl+o20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ct9vcta; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29bf7fdd5dbso247221a91.2
        for <linux-scsi@vger.kernel.org>; Sun, 10 Mar 2024 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710101151; x=1710705951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNuLk/SmJZe+3FEWgsu7CWQfjCzjRMTWkCyyZXjE1jU=;
        b=4ct9vctaGlegl7QokrpgmpwiUM1fCgzCdzr904BzpwNUOkgmXQFLqwm0rlas1sIu3T
         6Uf+8dhdu5XUd+bsxy7SF8UA/P376CAar+FI8AJMEM15fGs6uuQmVw9sEI+Fn6flgZGT
         zCJ7QvrpU+yoAMmiSGWliAqlLZ4DqJDlbHU//TpmjKtowOPseG4j5njmfzoKTlfW0l/O
         kT13qjGrfHNqeB1DYFNAECCoqTL07YJ/urkRcF98SQG94qbRPmCdsGCDOqwJjN2SJA66
         MTpmp1PKVNJww6ICZ9AhnlO79mz4SqANjQT1hsfxMRzpkzQyz4f55AoWY3jbLtI01tVC
         PZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710101151; x=1710705951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNuLk/SmJZe+3FEWgsu7CWQfjCzjRMTWkCyyZXjE1jU=;
        b=idREO9ZishWZ19L/zm1/3L85uW3tnm/QD/CsFADXydkjCbqIV7uSvaZkx4at/cMq+7
         EWsoolCBL9XJY5QX4k8E7XARa4c00bVlir7qFix/SXkGMAVSI0bRagPyIFhelKDCb4gT
         4sHip7UnS+06EZzK4jwQUrkzn9MbOz66tbIkBSB4vqIqfAzybWafhzunci2R22/6TrpD
         8SXWg9qnawlR9z4aDOhFx/gpXZQF6U4DlXbGave2RO5bdJcnEbHyKgu6PdHzgL54i8Sl
         YDDFHxJCjh+cOBLJ+BWt07nMHo5LlfdYt9Q7fF5q6TpQg0D7DKOnfBCbYd2q7pmfo3Al
         yU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUbvBqFiM3P3f2/qLUcLl16DI6DX+nax2P7Zp5FytFHLYIVBQHrn91Xkh/sO1jgNTovnm2qXo1633qVmiYgf8J80n+KnHDIRF917w==
X-Gm-Message-State: AOJu0YxdXG3n4MTn6V6EKCl3p+Z/66GU7T1rj5qY5NVaqm5PNonNfKz3
	F8salF+OAAEL50ovSJABJ3Q9V0tRwdeZpv3CEO3XSlqS+TFJdOSZ8RvdHSOfsA==
X-Google-Smtp-Source: AGHT+IH4tB7A0OdNI4gElwDpV2Geq+cGOnRhpOkDsCxu0fQh7Jd5vbI1iIoYcRe7nnVIfgqGRG5syA==
X-Received: by 2002:a17:902:7b95:b0:1dd:611d:3be0 with SMTP id w21-20020a1709027b9500b001dd611d3be0mr4491939pll.27.1710101151153;
        Sun, 10 Mar 2024 13:05:51 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:d1de:e5bb:fcf:1314])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001dd7d66ac95sm2716210plg.78.2024.03.10.13.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:05:50 -0700 (PDT)
Date: Sun, 10 Mar 2024 13:05:45 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] scsi: libsas: Add LIBSAS_SHT_BASE
Message-ID: <Ze4SmVLprCrJi59W@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-2-john.g.garry@oracle.com>
 <Zetp8ufVfxxo6DOF@google.com>
 <3c343fde-01cb-4cda-bf20-9df0ece94359@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c343fde-01cb-4cda-bf20-9df0ece94359@oracle.com>

On Sun, Mar 10, 2024 at 10:02:42AM +0000, John Garry wrote:
> On 08/03/2024 19:41, Igor Pylypiv wrote:
> > > Even though some drivers don't set proc_name, it won't make much difference
> > > to set as DRV_NAME.
> > > 
> > > Also add LIBSAS_SHT_BASE_NO_SLAVE_INIT for the hisi_sas drivers which have
> > > custom .slave_alloc and .slave_configure methods.
> > Looks like libata drivers have no problem overriding default values that were
> > set by __ATA_BASE_SHT. For example __ATA_BASE_SHT sets .can_queue .sdev_attrs
> > and then AHCI_SHT overrides those with AHCI specific values:
> > 
> > #define AHCI_SHT(drv_name)                                              \
> >          ATA_NCQ_SHT(drv_name),                                          \
> 
> which tag are you looking at here?
> 
> That looks like an old definition of AHCI_SHT().
> 
> There was a significant change for this in the following:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/ata/ahci.h?h=v5.14&id=071e86fe2872e7442e42ad26f71cd6bde55344f8

Oh, my bad. I had some old kernel version checked out. Please disregard.

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> 
> Thanks,
> John

