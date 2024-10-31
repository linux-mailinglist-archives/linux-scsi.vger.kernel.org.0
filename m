Return-Path: <linux-scsi+bounces-9378-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098589B7B4B
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2024 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF281C21918
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2024 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1E19D8AC;
	Thu, 31 Oct 2024 13:03:03 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1419D880;
	Thu, 31 Oct 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379783; cv=none; b=TbX4rFJuot5I6tYC5iFbwRIzoLdSCWFFCX4FyEKTzsglYuGOputlY077pk6N/AbiUBlPgSkEJxKVbPSR5JWj6U+Gbu7N7FHQU36zuQuwgMYjZjS3GK0qzvle2d8CwKIYXcerVoTdmKWqAlNAk74i6RSmnAb8dYnJm9McP8OCGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379783; c=relaxed/simple;
	bh=6umdaaBVSDFxA7EUsJGiuP+5bYHyg1v/riDkNJonScw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6n5jcRVGy1+I9wF+UMxjpF2eYmMDyio7FYbEc3AuX85V2Otm/Imc9PFutKk7RN5j//DZllXgKawAXzvzt9VNDQ6XqT/GzE90SV6bwgW1hMz7DJNDS/w7ieXkWJl+xKCeTdVnnxW52ySpaZnz7iyCTsHcr1WyBywJt3ybRBAUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBFDE68B05; Thu, 31 Oct 2024 14:02:52 +0100 (CET)
Date: Thu, 31 Oct 2024 14:02:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans@owltronix.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241031130251.GA17961@lst.de>
References: <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com> <20241030155052.GA4984@lst.de> <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com> <20241030165708.GA11009@lst.de> <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com> <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> No. The meta data IO is just 0.1% of all writes, so that we use a
> separate device for that in the benchmark really does not matter.
> 
> Since we can achieve a WAF of ~1 for RocksDB on flash, why should we
> be content with another 67% of unwanted device side writes on top of
> that?
> 
> It's of course impossible to compare your benchmark figures and mine
> directly since we are using different devices, but hey, we definitely
> have an opportunity here to make significant gains for FDP if we just
> provide the right kernel interfaces.

I'll write code to do a 1:1 single device comparism over the weekend
and Hans will test it once he is back.


