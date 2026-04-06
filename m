Return-Path: <linux-scsi+bounces-22789-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME5nJBxU02nehAcAu9opvQ
	(envelope-from <linux-scsi+bounces-22789-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 08:35:08 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EADA3A1CA3
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 08:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB26300DF53
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2026 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880D359A82;
	Mon,  6 Apr 2026 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eBNMMC1w"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADB7262B;
	Mon,  6 Apr 2026 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775457302; cv=none; b=ia4uPcgmta7uL8w66eNBP5sySv3aJEXLQrJfpqZEAYpiT9SpNdIjgw78N9tgTxm8H4cr8k+6RtQhCet7rXaA0kZOC3W7B46vt+F1mGCSKlo45xOOSHpRSWU6vQOMV9eZ3fPj+NTrscBmtk8Vjpb45ujz0Lye5evDtpP2cAbuj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775457302; c=relaxed/simple;
	bh=0YwMkg24oDK7iA/ok9fnvBBU00v6ACDGi4jyzlEHdns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4BuF/MunNVwiVzM6Wy7vYqveIoNvZcoIFk+Za5kph4R3DLuF5qNvh8vpg3+LPPZ+7y/3RCeFkZ3xQOne210zSIXUpOc5EDPAcbigVQfT+G6e0ViZFyMQL4aM/YrEUBC/Z/OPZ8WSlmX6/fVbMFBGQo62lnVfcm9MA+u6xUEmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eBNMMC1w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pc9vbImn4CtvOflywsnq4PoTH5Yj0zoYEc5yjB2C9Dc=; b=eBNMMC1w9cud1TJNJa4Qg3HIaU
	dkCoqEiLOVw8ycmse+tgxslySANIXoLBlQnvOAfdvoICkSFNX+uxJgN86uZYs3ZstQiD9YPWMa+51
	W9k9xFWE+VCRPRsrrmiUZCsFFAYS+S7OINBown4+PmbDR0VztzcxTi8uhuxGijiF69Yga61/+5+FQ
	tEpVw9ieqo1vDW6p18MKih3ojxuEQJEODoPV9IiptRFkLoUkR9n3bDQpEY0jPMIEEpQqrF43LJLWo
	1MiGY2CNbDOVpkznjFekO+n3K/c3GOqnB6f3YMi+aGaEHxfT31kIVm3Hy7utymfHE0YlsRcP2A7Jp
	W11548Lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dY3-00000004qke-3jr6;
	Mon, 06 Apr 2026 06:34:59 +0000
Date: Sun, 5 Apr 2026 23:34:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as
 seed
Message-ID: <adNUE67FpIGF_x7Q@infradead.org>
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403194109.2255933-3-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22789-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3EADA3A1CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 01:41:05PM -0600, Caleb Sander Mateos wrote:
>  void bio_integrity_setup_default(struct bio *bio)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  
> -	bip_set_seed(bip, bio->bi_iter.bi_sector);
> +	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));

Should we simply switch bip_set_seed to take a bio bvec_iter argument and
lift all this logic into it?  That feels a lot less fragile.

Bonus points for writing useful documentation for the new bip_set_seed.


