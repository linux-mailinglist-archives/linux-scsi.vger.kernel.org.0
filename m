Return-Path: <linux-scsi+bounces-5370-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EB8FDDE4
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2024 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D581F25414
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2024 04:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA0838384;
	Thu,  6 Jun 2024 04:49:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58A28373;
	Thu,  6 Jun 2024 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649353; cv=none; b=GTSkcv7gq1Plu/27OE0vrVUihECA61An22nlyrYVO47/HU0llKhTJWpdZfr9OcE3Uhp973ThnNmXRZ2f7qDwnUE+qEo8CfXW/UKnhBEwgvFhbtJeMFZT9a2Vf4tgzaErKYM4I1HKK9k4FBltFV3SbhrFe1diwazOi+mRP1IhMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649353; c=relaxed/simple;
	bh=c6GvMVP0yu6KTtnXXYAqCdebQm4YZ699GLf9d5FxmMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOc9J7V3WSu3K02RjdWi1tArk0DKIgLT8sAfn9DTOIQbljY5PowkpySlS3ZedO1we82TZFX2Vc4IVUpCDO3DHKPKEwqfpl4mts9YyuaBZPCC/2BlihTFRFIw9PmMAF5bwyNDaDzTsZ+0Uz2tDBHLuq1+2mOmpl7N84CUR4JZJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCAAF68CFE; Thu,  6 Jun 2024 06:49:06 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:49:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
Message-ID: <20240606044906.GB8395@lst.de>
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-5-hch@lst.de> <CA+1E3rJn3uNfkoFtm_am9qwQmwWvhu3nPVMaM63AJ2GBdxZTmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJn3uNfkoFtm_am9qwQmwWvhu3nPVMaM63AJ2GBdxZTmQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 05, 2024 at 08:05:20PM +0530, Kanchan Joshi wrote:
> On Wed, Jun 5, 2024 at 12:01???PM Christoph Hellwig <hch@lst.de> wrote:
> > @@ -446,13 +446,14 @@ bool bio_integrity_prep(struct bio *bio)
> >         if (bio_integrity(bio))
> >                 return true;
> >
> > +       if (!bi->csum_type)
> > +               return true;
> 
> Changes look mostly good, but trigger a behavior change for non-PI
> metadata format.
> 
> Earlier nop profile was registered for that case. And the block-layer
> continued to attach an appropriately sized meta buffer to incoming IO, even
> though it did not generate/verify. Hence, IOs don't fail.
> 
> Now also we show that the nop profile is set, but the above
> "csum_type" check ensures that
> meta buffer is not attached and REQ_INTEGRITY is not set in the bio.
> NVMe will start failing IOs with BLK_STS_NOTSUPP now [*].

Yes.  I didn't remember that odd case and failed to test it, but I can
trivially reproduce it now.

Which brings up another issue: bio_integrity_prep allocates the metadata
buffer using kmalloc, so we'll leak write random kernel memory to the
devices for this case which is ... not good.  I guess for stable fixes
and backports I'll add a real generate_fn that just zeroes all the
memory for now.


