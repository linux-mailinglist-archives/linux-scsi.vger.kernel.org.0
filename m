Return-Path: <linux-scsi+bounces-22261-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qODUKVhhvGlxxQIAu9opvQ
	(envelope-from <linux-scsi+bounces-22261-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 21:49:28 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 264812D260C
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 21:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D404B30157F2
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC023FB073;
	Thu, 19 Mar 2026 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koQ8f5bi"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8C3FBEC4;
	Thu, 19 Mar 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953354; cv=none; b=IxG+PKBctJUIsN9ZZLsFw9ma1U0E8DH6HWN+3Y5DuKn2Kjk1pCwSkod/M3iRete6dMgxJATf4PrkPj/Ziw0pEzFhBG2o+oqUxwQ3CnNeSFGNOecqbi7iUWPuGut3iwTWIEMbQO57wBa64e4bkPzHGx8fSL5YIAiZpl2L0tD2kxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953354; c=relaxed/simple;
	bh=TIlMXKSIYtOVPE4A/WzLSzzaAgYLahSnPoAMg98c93M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjGLV7SFZMtY63SxPw/7JVX2NY5Mnoqu8APstEPk6GILhPHUI8L189XUgFDhCUB2I7Qfu4afPQOrg7luhuWmNKbE8QAEtAN6yRveCHeOCKAWfQ8euEmEVREVBaw5yTIYmdDF1d0H6tiMxzq6fKw5mQFVrnmus34uSPwMlljYD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koQ8f5bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31367C19424;
	Thu, 19 Mar 2026 20:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773953354;
	bh=TIlMXKSIYtOVPE4A/WzLSzzaAgYLahSnPoAMg98c93M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=koQ8f5biBYZltOljbmI6VqgQYLcRhTR5il4v/igkS3LC+1tZ8n6KFPleh4FQo/bjj
	 qYSs0vYH/3HD6iCVfqagNGD9yQqWJ8hTQkzHLO+JG/ObcIKku/bt7xCc+vYq/5YOt/
	 HIyTVcP/4itjK+pg0av4+CjIPhiMdRWvS9od37UPiR/8CymrSJsfBB8RybYltSXUSo
	 2p3/XQtl+7uqc0SOErpxlPx6STxsMz2rRe33jn99VdoOkXmWgQS7OACMv3JfazFIoq
	 8XaHOYNDeiO7d51LDI5hNF0EhXUT9YZ+ycZrdiQTRfKj0ADYbe6RyHyVIZfteYFOV+
	 R7jckmUH/LoYw==
Message-ID: <c6aa3d0b-e815-4b73-8677-d8dd2fe1d5ff@kernel.org>
Date: Fri, 20 Mar 2026 05:49:10 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: sas: skip opt_sectors when DMA reports no real
 optimization hint
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: James.Bottomley@HansenPartnership.com, ahuang12@lenovo.com,
 axboe@kernel.dk, hch@lst.de, ionut_n2001@yahoo.com, john.g.garry@oracle.com,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 m.szyprowski@samsung.com, martin.petersen@oracle.com, robin.murphy@arm.com,
 sunlightlinux@gmail.com
References: <6a78fcaa-7a3e-423f-b6f5-84cd66a3c88f@kernel.org>
 <20260319204333.17432-1-ionut.nechita@windriver.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260319204333.17432-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,lenovo.com,kernel.dk,lst.de,yahoo.com,oracle.com,vger.kernel.org,samsung.com,arm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22261-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 264812D260C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 05:43, Ionut Nechita (Wind River) wrote:
> On Wed, 19 Mar 2026 11:07:00 +0000, Damien Le Moal wrote:
>> Why return 0 ? This is a valid case, so this should get through the
>> alignment below.
> 
> Hi Damien,
> 
> Thanks for the review.
> 
> The opt == max case is specifically the bug this patch fixes.
> 
> When the IOMMU is disabled or in passthrough mode and no DMA ops
> provide an opt_mapping_size callback, dma_opt_mapping_size() falls
> back to min(SIZE_MAX, dma_max_mapping_size()), which equals
> dma_max_mapping_size().  So opt == max.
> 
> If we let that value through, rounddown_pow_of_two() produces a
> huge power-of-two, and min_t() caps it at max_sectors (32767).
> That gives opt_sectors = 32767, which is exactly the bogus value
> that breaks mkfs.xfs:
> 
>   swidth = 16773120 / 4096 = 4095
>   sunit  = 8192 / 4096     = 2
>   4095 % 2 != 0  ->  "SB stripe unit sanity check failed"
> 
> The key insight (from Robin Murphy's v1 review) is that when no
> backend provides a real optimization constraint, the DMA core
> returns the largest efficient size == the largest size.  That is
> correct DMA semantics, but it means opt == max signals "no
> preference", not "the optimal size happens to equal the maximum".
> 
> Returning 0 in that case means "no preference", which leaves
> opt_sectors at 0 and lets the disk's own geometry (or lack
> thereof) determine the I/O size.

Thanks for re-explaining this.

The code needs to have all this explanation as comment so that we do not trip on
this again.

> 
> Regarding the Cc list: noted, I will trim it for v5 if needed.
> 
> Thanks,
> Ionut


-- 
Damien Le Moal
Western Digital Research

