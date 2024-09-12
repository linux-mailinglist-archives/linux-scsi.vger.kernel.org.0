Return-Path: <linux-scsi+bounces-8207-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D48976330
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Sep 2024 09:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CFAB23FA1
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Sep 2024 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67418FDD7;
	Thu, 12 Sep 2024 07:44:12 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898C18FDCE;
	Thu, 12 Sep 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127052; cv=none; b=kPwCI2mL4TR+aeCDblpmHZvD3lgdDWADi8NRhwEkpHc7jNfmX8nefopjloj1lVKc5h7pXmIF5Ru4H+HeoGlrmp/RYX2JIu7iDiuGczgA9wq+yK08pgeInKv08qKiLL9qihdT9yXONImRKwuZSgm2hTso3A2PSEk0b7EFsaZJn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127052; c=relaxed/simple;
	bh=8TTTrmbUCsbV78XKKVkeNxEBWVMJxaaYdxaMDZVnPp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL0usxfi/hsQn7O6J4OzHb8/qBg4pK+oNOxhk5wBQqBtpGs5geh8/IOsTN2xdm6wTt9wrzoKIFcwzoO1L0Smq7R9v6gt1I4PnPYKzVl1gEWklMxuAf9FC4M2XS5H9GNen35hGzsGHUL4Fj2oOw7vV3ze3nfhPJE+lUqxhVTiX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8694D68AFE; Thu, 12 Sep 2024 09:44:07 +0200 (CEST)
Date: Thu, 12 Sep 2024 09:44:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 06/10] block: provide helper for nr_integrity_segments
Message-ID: <20240912074407.GB8375@lst.de>
References: <20240911201240.3982856-1-kbusch@meta.com> <20240911201240.3982856-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911201240.3982856-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 11, 2024 at 01:12:36PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Provide an integrity equivalent to blk_rq_nr_phys_segments().

Now that the field is unconditional the helper seems a bit pointless.
blk_rq_nr_phys_segments is mostly need for the special payload magic
for discard.


