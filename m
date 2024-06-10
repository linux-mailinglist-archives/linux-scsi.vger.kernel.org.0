Return-Path: <linux-scsi+bounces-5495-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE103902192
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2024 14:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28DC1F22A6A
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2024 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15D7FBC5;
	Mon, 10 Jun 2024 12:24:31 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A177113;
	Mon, 10 Jun 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022271; cv=none; b=KJ6pfROsnGJVPtg0A1roohwK2KL3bEzoUjbmCJZwO9VnbDEd8IObKyX2tj1jl2wlocDDG+WdN5LXTQdQGk41zDW/DRkusSJbJvPhU2fF0110sB2H0b7EeBYeN2anicMd/gd7lLMvqOvgsQD+K881essee3ZJPeS4uY2s2PQwtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022271; c=relaxed/simple;
	bh=wPj0ka3smDPj42zAIcmgvSYYGdHRdj8CK45dHg9fLDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NihfTpiwbLbJQt2ZnY2r1aVpMDd1bym8cU8o+Esfl/7VPi3KziVZurHW1P/p118jMseWKforT3isU6FlQmGMbeAzIFSriqG2Bf8GVIDDWXkF5in+nOrZXrVEJEeEz1uxWh1C5jPsqX06j7kOX7qSjQ7htGn6Q/GXEWWPaGtchAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25B3D67373; Mon, 10 Jun 2024 14:24:24 +0200 (CEST)
Date: Mon, 10 Jun 2024 14:24:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
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
	linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 03/11] block: remove the BIP_IP_CHECKSUM flag
Message-ID: <20240610122423.GB21513@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <20240607055912.3586772-4-hch@lst.de> <yq1frtl3tmw.fsf@ca-mkp.ca.oracle.com> <20240610115732.GA19790@lst.de> <yq1bk492dv3.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1bk492dv3.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 10, 2024 at 08:19:33AM -0400, Martin K. Petersen wrote:
> On the wire between controller and target there's only CRC. If I want to
> write a "bad" CRC to disk, I have switch the controller to CRC mode. The
> controller can't convert a "bad" IP checksum to a "bad" CRC. The PI test
> tooling relies heavily on being able to write "bad" things to disk and
> read them back to validate that we detect the error.

But how do you even toggle the flag?  There is no no code to do that.
And if you already have a special kernel module for that it really
should just use a passthrough request to take care of that.

Note that unlike the NOCHECK flag which I just cleaned up because they
were unused, this one actually does get in the way of the architecture
of the whole series :(  We could add a per-bip csum_type but it would
feel really weird.

