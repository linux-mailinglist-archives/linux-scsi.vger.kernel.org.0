Return-Path: <linux-scsi+bounces-2756-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04186B712
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Feb 2024 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B521C20C88
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Feb 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565940866;
	Wed, 28 Feb 2024 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YLaLKLZx"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389C40843
	for <linux-scsi@vger.kernel.org>; Wed, 28 Feb 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144474; cv=none; b=bzNagMdgS3OOlyAk4NH6azlQmCvjj2tmUq2NlSyr0OyYW7rMAy1dvkHz6WjUGAjTq88nHUGNgTjusYBhcCAfQVu8EjULdQJuqj0ooIvcu7lhR82hnE8bDYwEO7hZ0t3wt+n4nVN5YQKPywFpE/3qFIv/20/48wc+Lzw/DoJ1Wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144474; c=relaxed/simple;
	bh=IlLz2VfIORUGWPlRUuhRJlF7DR2TU3PjgeFfLjigpBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyKnuoCu3ba7EPVeH2KtXKguQ/1jX0YYpLSpRKm0p4lSTD2GM0UDdWl7Oi6Gj8/D3h7sNYGG9UvnL5omV+P8QeJvIBlb8YrBMh5gAi+2y2mTi6TDvACD8nfQ7kjRSyZP7oXImyntLL0IG+Dps3Jqu0QfiUOiIUq/wrMFqOeiI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YLaLKLZx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso119759a12.2
        for <linux-scsi@vger.kernel.org>; Wed, 28 Feb 2024 10:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709144470; x=1709749270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0Q2VEWLTjS2U6IhLhs8VN1l8yd5YlaS/zs5Osz7AKY=;
        b=YLaLKLZxbZLjz0J1yQCaZVSkRbl4dTTrln5e8BLQBYvNqooIrzhbVXTT5aVj2u2DJg
         gvc4IfuAJZFQSbaByKXEwO+GDn/EVQSaTRm+gillpDSwGDCukQQvfk9xUWVk7EQC704e
         1E1ddx3yrYhm4GdlmzCVjEi9FS28uIyjHCchfc/X36XUQSPck9yLZWlMXp4VXETZOt9d
         5cx2feuJFAVZfT5OpfZ8SzW+WboNCNjKJrv6stM8EnTqJgBJndbljy21eP2mMastbOOU
         EyXzvAhc7KfwW6mYc1yx2Bbc+bJ4lBoBYcIePoHVGgpk4jsTclRXytzD1RNF3FYRy1dz
         GGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144470; x=1709749270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0Q2VEWLTjS2U6IhLhs8VN1l8yd5YlaS/zs5Osz7AKY=;
        b=LXcdpdgzPEpSekeFS4CQ+kApD5a9kUoG2rUPaPKeB+7iA+HCZhJAFtylcyP3neeIKP
         He1y7g23McnU1YgkLbp9e3qfG/d8nLkJ72/7MFhXwasFRW4DV2tUfy3DOi5ayP7072Jr
         dksDqkjt3P75YGbYhy+TvvraDStgcnUxjd9kLChJa/t4LESm55WGkpLp8bWcqB+Cmf88
         NQY/s1OpcmdXyZM7MB7ZPOaMGuW0fCybJxgudc+QA8jzZL1gEbKA8u219a9toB/RCw6A
         aQ10l8n5hKKBLMr0FyNF8WglqaSQ19+/oL+PD37INFBqQ3hzOfq7wIG+44Bw1tvdAnxk
         SDDA==
X-Forwarded-Encrypted: i=1; AJvYcCVq9ph+aEcyFKvZzG1s+qU+P/IyhFUo5FjaBwSE6hZKQ5X8zKW01t8n3RMeXqM4NQMYnoeIggmBQ2lzp0RHOYrvKZYRKtxsjCETGA==
X-Gm-Message-State: AOJu0Yzqd+ePS6gygVQyNvK66HPdcm97nu9eVW2UaQJiRJU4MW0x+vF6
	vWn8r3DxmwyFogpRfFxNBu/771m2NBcK5ZUy36aClnlrNNy3C4DoxKpE2K2V7lUW/qeLdsbAHaM
	1JRUn0mznXSwKqDX4h3570wH2sTtuqgfXq4kGrA==
X-Google-Smtp-Source: AGHT+IGxdXWls/rPfinB0uQQkXKmMgc6r4kLOeAWFd8I9R7QhkQU4gee2PUX9KLBptb/Pw4yWIXjq4Yzyd+hFDFrqcY=
X-Received: by 2002:aa7:cfd1:0:b0:564:151c:747a with SMTP id
 r17-20020aa7cfd1000000b00564151c747amr150661edy.27.1709144469812; Wed, 28 Feb
 2024 10:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201233400.3394996-1-cleech@redhat.com>
In-Reply-To: <20240201233400.3394996-1-cleech@redhat.com>
From: Lee Duncan <lduncan@suse.com>
Date: Wed, 28 Feb 2024 10:20:58 -0800
Message-ID: <CAPj3X_Ve4WgwCdzXiNSC+3ejsD9yc=586=g9kY_zGZXBREx7fA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nilesh Javali <njavali@marvell.com>, 
	Christoph Hellwig <hch@lst.de>, John Meneghini <jmeneghi@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is this series stalled?

I believe the main objections came from Greg earlier in the series,
but I'd gotten the impression Greg accepted the latest version.

On Thu, Feb 1, 2024 at 3:34=E2=80=AFPM Chris Leech <cleech@redhat.com> wrot=
e:
>
> During bnx2i iSCSI testing we ran into page refcounting issues in the
> uio mmaps exported from cnic to the iscsiuio process, and bisected back
> to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.
>
> The cnic uio interface also has issues running with an iommu enabled,
> which these changes correct.
>
> In order to fix these drivers to be able to mmap dma coherent memory via
> a uio device, introduce a new uio mmap type backed by dma_mmap_coherent.
>
> While I understand some complaints about how these drivers have been
> structured, I also don't like letting support bitrot when there's a
> reasonable alternative to re-architecting an existing driver. I believe
> this to be the most sane way to restore these drivers to functioning
> properly.
>
> There are two other uio drivers which are mmaping dma_alloc_coherent
> memory as UIO_MEM_PHYS, uio_dmem_genirq and uio_pruss.
> These drivers are converted in the later patches of this series.
>
> v5:
> - convert uio_pruss and uio_dmem_genirq
> - added dev_warn and comment about not adding more users
> - put some PAGE_ALIGNs back in cnic to keep checks in
>   uio_mmap_dma_coherent matched with uio_mmap_physical.
> - dropped the Fixes trailer
> v4:
> - re-introduce the dma_device member to uio_map,
>   it needs to be passed to dma_mmap_coherent somehow
> - drop patch 3 to focus only on the uio interface,
>   explicit page alignment isn't needed
> - re-add the v1 mail recipients,
>   this isn't something to be handled through linux-scsi
> v3 (Nilesh Javali <njavali@marvell.com>):
> - fix warnings reported by kernel test robot
>   and added base commit
> v2 (Nilesh Javali <njavali@marvell.com>):
> - expose only the dma_addr within uio and cnic.
> - Cleanup newly added unions comprising virtual_addr
>   and struct device
>
> previous threads:
> v1: https://lore.kernel.org/all/20230929170023.1020032-1-cleech@redhat.co=
m/
> attempt at an alternative change: https://lore.kernel.org/all/20231219055=
514.12324-1-njavali@marvell.com/
> v2: https://lore.kernel.org/all/20240103091137.27142-1-njavali@marvell.co=
m/
> v3: https://lore.kernel.org/all/20240109121458.26475-1-njavali@marvell.co=
m/
> v4: https://lore.kernel.org/all/20240131191732.3247996-1-cleech@redhat.co=
m/
>
> Chris Leech (4):
>   uio: introduce UIO_MEM_DMA_COHERENT type
>   cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
>   uio_pruss: UIO_MEM_DMA_COHERENT conversion
>   uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
>
>  drivers/net/ethernet/broadcom/bnx2.c          |  1 +
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 +
>  drivers/net/ethernet/broadcom/cnic.c          | 25 ++++++----
>  drivers/net/ethernet/broadcom/cnic.h          |  1 +
>  drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
>  drivers/uio/uio.c                             | 47 +++++++++++++++++++
>  drivers/uio/uio_dmem_genirq.c                 | 22 ++++-----
>  drivers/uio/uio_pruss.c                       |  6 ++-
>  include/linux/uio_driver.h                    |  8 ++++
>  9 files changed, 89 insertions(+), 24 deletions(-)
>
>
> base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
> --
> 2.43.0
>

