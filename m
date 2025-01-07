Return-Path: <linux-scsi+bounces-11228-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF23A03BC7
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jan 2025 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E401188557A
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jan 2025 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC8D1E47D4;
	Tue,  7 Jan 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIw6BHFN"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF71E411D;
	Tue,  7 Jan 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244325; cv=none; b=u62kYkDvNkbtb2TlgaRF8z1KMY70cDoYTuZ19BZefWZ/wHddEBV1y5y+j6TU8c38n8qnEDnqIDZqDL05fH1jn1E4OG63Kgq8qMaeeX8tl9/5sbG7vYVhnzFuytD/zX84uhgcwulLgnHoVoIO7x9CPK7jHihtXa/Ad4ocKERisv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244325; c=relaxed/simple;
	bh=8jmwATyEWLLwjfjL024kECAWxrvcDtaSF8/ccLUrRk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oo6ywnCWPvVbpTmZZJJKDIS7xIrDyaJelXEmaQHyMMLtvNQpX4bOI6mCE2tlJoC7t7e0doGP7P2Tb+NaKhVK53CYaY4dlZx/l5x0hpLR1wu7NJoFzuTGC+ajHTwxNDAwu7o96MH5BGfLE8vXWK+iYxSnHhqRVIejB4PAOpzCyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIw6BHFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40471C4CED6;
	Tue,  7 Jan 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244324;
	bh=8jmwATyEWLLwjfjL024kECAWxrvcDtaSF8/ccLUrRk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DIw6BHFNgyqts2cNELuVQttSkjcAkkJIgJaA61FIsDemIS6AdCijrFRkuBPWpkx/5
	 XhXPZPpKu4jNf8F3ktCmp532okyjwpacmYaujmIEIY7tqvPxSC/vUkU4mTqPgh11vZ
	 qEBLJ/dv9nxgfP2LKKinCS4zWPgSbTg0EANUofB5h4Wvr0qgnsPDb4Jm2LPBcV4TUX
	 dY4kkhRg6Z+OD+L17EVG5TMpLu58NApwtG91MsrzYJqtyVsnXh6ktikKwLYqjhS23H
	 1+ZkCaZ5vF1vnzJjKeXGEzZilHvOO9Ne+HWM2IDakE0CLmCE3ostPXxHmkaYuoQr7k
	 1ewQaWGyDJo8Q==
Message-ID: <7b657b32-dd25-4826-9c2f-dfd980610de2@kernel.org>
Date: Tue, 7 Jan 2025 19:05:22 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs entries
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 15:30, Christoph Hellwig wrote:
> De-duplicate the code for updating queue limits by adding a store_limit
> method that allows having common code handle the actual queue limits
> update.
> 
> Note that this is a pure refactoring patch and does not address the
> existing freeze vs limits lock order problem in the refactored code,
> which will be addressed next.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

