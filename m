Return-Path: <linux-scsi+bounces-8131-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF1C973C07
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Sep 2024 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06BD1C25341
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Sep 2024 15:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F4193081;
	Tue, 10 Sep 2024 15:32:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFEA19597F;
	Tue, 10 Sep 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982342; cv=none; b=lUKFlsNJx9mbG73barzADBYtyRGZN7GJjKQeu8tZuoX/FE9HJfzGE/YQVDOylVNj7VHilY7K/Q+uho8KwkthBu+mTxoPcCceM9ArW0nPOGy/mMaVv6dTiphHFxG2pmkyFMUcR1DLHqKlvFp72/wNIhwPbFri0fRqaQhpHN4nbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982342; c=relaxed/simple;
	bh=ro+IMprw9oMIdzJeOLhee+yVlfImqxWigOQtmXP8hCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FohQ0G8oNdsqR3ysV97yExC6A3R7E9zNq3kUUV6Tra7oT57ERf3wqEYBLJaDRTF+QUzHBP4OGqaNhEsT56i4n0NfqGu0MQR9DI0I/uYBPfSEsMBE8QyXniLzC92mAomVPE1btfRGPZRTHODUgvC5PwdPl2aIRG3PCml64BlkRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 888AD227AAE; Tue, 10 Sep 2024 17:32:18 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:32:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 03/10] scsi: use request helper to get integrity
 segments
Message-ID: <20240910153217.GC23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 3958a6d14bf45..dc1a1644cbc0c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1175,8 +1175,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
>  			goto out_free_sgtables;
>  		}
>  
> -		ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
> -
> +		ivecs = blk_rq_integrity_segments(rq);

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although I'd be tempted to just remove the BUG_ON below (or move
it into blk_rq_map_integrity_sg) and the ivecs variable entirely.


