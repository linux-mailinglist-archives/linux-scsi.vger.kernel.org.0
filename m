Return-Path: <linux-scsi+bounces-9337-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528C9B6AC8
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Oct 2024 18:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2981E2817AB
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Oct 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF35217658;
	Wed, 30 Oct 2024 17:14:56 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA4215024;
	Wed, 30 Oct 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308496; cv=none; b=fO14zjZkzWFrn/MhUJt7n2IxMc8Veec3VHaGRQiG2154iiUiNdt8P3U73IFSuI/XBIyBEc0Tm6kStp3ELoBpSad6DgQB7tfUM7PQl7WnYXY0CZYkgZTpaXHAODWPrlTzeM/SWy5CapuJhmiQp16BAIPmgtn3B0z5lUQrDPLIL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308496; c=relaxed/simple;
	bh=4LRhqB3ZMWwpFLlaJG+to9pDJskG6rq16y7aH3UwUOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTq7hW2+CMHc9ip2nvjLz2azUdvHSSsb7o/U49VSX40Xp86RrJ9RQtTZ0xEBSbO1asUJhqMzmeuU4n00ufnnl/u7W61ZDP1E1LexWK5Lc/ahfQg99lOO2ni537IpWfcASW6DaBu5AdqE/65b8FS3p6J5cRCk8+k8zQ3Lcp915II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 634FD227A8E; Wed, 30 Oct 2024 18:14:50 +0100 (CET)
Date: Wed, 30 Oct 2024 18:14:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Hannes Reinecke <hare@suse.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030171450.GA12580@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 09:59:24AM -0700, Bart Van Assche wrote:
>
> On 10/29/24 9:55 PM, Christoph Hellwig wrote:
>> For the temperature hints the only public user I known is rocksdb, and
>> that only started working when Hans fixed a brown paperbag bug in the
>> rocksdb code a while ago.  Given that f2fs interprets the hints I suspect
>> something in the Android world does as well, maybe Bart knows more.
>
> UFS devices typically have less internal memory (SRAM) than the size of a 
> single zone.

That wasn't quite the question.  Do you know what application in android
set the fcntl temperature hints?


