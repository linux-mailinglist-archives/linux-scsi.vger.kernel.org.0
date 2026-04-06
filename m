Return-Path: <linux-scsi+bounces-22788-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H18OS9T02nehAcAu9opvQ
	(envelope-from <linux-scsi+bounces-22788-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 08:31:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD333A1C55
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22750300D950
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2026 06:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D0A356A08;
	Mon,  6 Apr 2026 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IW4cIMXU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DC1A267;
	Mon,  6 Apr 2026 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457065; cv=none; b=l7h+Fe4LsJePebPvzZ7bq8AWtjCOQdFpdWDwqwSZ2iFwSNCSea1tdUM7GBVZ6MyCW2g1HwUeSubzd28+G0BPY8IXUmgsUqNSptOp77Cy1dTWNUA8Eb6n1+VpobdvCpoKFhJYqljv6yUDQMYesfc635u9uyVlADDnHXvZPfirEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457065; c=relaxed/simple;
	bh=6AV9IVS4uMT5kQAVYIFatF/wTITR+iqSHo2xCC6UD64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6yRQsqj2pXx1rWBx6NRpWC0cYo/RUpX6ZX5npE3GOmuO04vo5haZxrH2WHNnnrpXcmm7OfBzg0w224uTOFpUdklBYHixBOjTSOOeYrdhWI8MtC5BQVIwjvw3pm+0RGfy4HEwaRzCoydl1QNvC/B10hfM8TAHci3aAyqwKPPM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IW4cIMXU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wZjNM90OxK1bKf31J1TMpT2H4yds1CcGszVY/6ZlN10=; b=IW4cIMXUztwaXd4rpB/G3UupWC
	BN0EwAFK9ZCbTLfEDF6mI03/sUuBZRlt4atFD3Oad/zTCMvkbVDC8Q1cM9gERL7c8f11AqXjHoJej
	udO6O0PWO75MemxQuqKSDFGKJzAG8Tshq+vQlArzufJXTgkvnqaKASaQEV9UFcNUeIVQUzydu1OvM
	1soIdmZXLjMeQ0dkfLy0IKb+YeQx5fK+501X31aTInrmVj4OYDTJ5t9wWuOXja66DiDEm6+czfWym
	F9PYuP7aXzyhT0kAVg8EPvxHSF4IpxxfVEOWU6fMHUqwetcWRtknNVhr5EGfSz4IGE6VGdRawWDoH
	de9xOwcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dUC-00000004qTN-0YZE;
	Mon, 06 Apr 2026 06:31:00 +0000
Date: Sun, 5 Apr 2026 23:31:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH 1/6] blk-integrity: take sector_t in
 bio_integrity_intervals()
Message-ID: <adNTJEkpIj0wQ--X@infradead.org>
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403194109.2255933-2-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22788-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8AD333A1C55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>  /**
> - * bio_integrity_intervals - Return number of integrity intervals for a bio
> + * bio_integrity_intervals - Convert sectors to integrity intervals
>   * @bi:		blk_integrity profile for device
> - * @sectors:	Size of the bio in 512-byte sectors
> + * @sectors:	Number of 512-byte sectors
>   *
>   * Description: The block layer calculates everything in 512 byte
>   * sectors but integrity metadata is done in terms of the data integrity
>   * interval size of the storage device.  Convert the block layer sectors
>   * to the appropriate number of integrity intervals.
>   */
> -static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
> -						   unsigned int sectors)
> +static inline u64 bio_integrity_intervals(struct blk_integrity *bi,
> +					  sector_t sectors)

sector_t is a sector number, not a number of sectors.  So if you need a
64-bit value here, it should just be a u64.

>  {
>  	return sectors >> (bi->interval_exp - 9);

If you touch this, maybe also replace 9 with SECTOR_SHIFT?


