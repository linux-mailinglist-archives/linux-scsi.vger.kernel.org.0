Return-Path: <linux-scsi+bounces-25327-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id myxEBhpGQmrk3QkAu9opvQ
	(envelope-from <linux-scsi+bounces-25327-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 12:16:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ED26D8C8E
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 12:16:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=D54cPJDS;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25327-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25327-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA2C302C5CB
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2823C81B6;
	Mon, 29 Jun 2026 10:12:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6A3E2767
	for <linux-scsi@vger.kernel.org>; Mon, 29 Jun 2026 10:11:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727922; cv=none; b=KlGLb5Yid2EwRBzrUDShbTdSP3hfnvBFU6vnWsUMIxI79N+bIBf4tDIkjbb/mYaMyMpA+pyS2AFBMboXuNxqtj7utKsp99MTVXDHgc3si8NG6T6SUNjgf+V55GsEncs+KAFk0HbWWOqgGUcvLFuETOwfXm5jePmOamBIE6yu12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727922; c=relaxed/simple;
	bh=Au9s+ToVcqhsg1eeBDi2qQsnLGkQDNkDcGytyy/7fmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ8NKKBAFFtnzIXVW1O2vR6OOK0hijRzqmdB5S3YHuWmNjLH3yVNXDQ0zNZqsI/4pQx7OSB/XtdvNDNionXjypkHKfEcB9voBKS7c4TDBmGABy51xjk7EDyEnhSO7GrCWkgHZWRLWafJTXMCxRloYf7uxK8lD4wXqyUeGSVBBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D54cPJDS; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778851595;
	Mon, 29 Jun 2026 03:11:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999553F836;
	Mon, 29 Jun 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782727916; bh=Au9s+ToVcqhsg1eeBDi2qQsnLGkQDNkDcGytyy/7fmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D54cPJDS3Xeh3vPYugL+dVyyzABp8jPfk6Mnbr75X6fbZq1S92zt7sSpVlK8oKy+f
	 JyJOJykSpOWWwmDIGjiq+xYDUwIYJK2+snzfcMFSHvdy4oX+/WPbDwE0xqkxu4FRTL
	 qEDr7lcMF33l6winKpmZXg6NaXBFc5SUXsKcj+6c=
Message-ID: <53d07679-b1bb-469c-acc2-981e75c071c9@arm.com>
Date: Mon, 29 Jun 2026 11:11:53 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-mapping: make dma_max_mapping_size() return 0 for
 no DMA capability
To: John Garry <john.g.garry@oracle.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 m.szyprowski@samsung.com, hch@lst.de
Cc: linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
 ionut.nechita@windriver.com
References: <20260629085310.2298552-1-john.g.garry@oracle.com>
 <20260629085310.2298552-2-john.g.garry@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260629085310.2298552-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25327-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robin.murphy@arm.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:m.szyprowski@samsung.com,m:hch@lst.de,m:linux-scsi@vger.kernel.org,m:iommu@lists.linux.dev,m:ionut.nechita@windriver.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73ED26D8C8E

On 29/06/2026 9:53 am, John Garry wrote:
> For when a device is not DMA capable, the max mapping size would be 0, so
> make dma_max_mapping_size() reflect that.

Seems logical.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   kernel/dma/mapping.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 4fe04669e5e66..7e576e5c6b8be 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -979,6 +979,9 @@ size_t dma_max_mapping_size(struct device *dev)
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	size_t size = SIZE_MAX;
>   
> +	if (!dev->dma_mask)
> +		return 0;
> +
>   	if (dma_map_direct(dev, ops))
>   		size = dma_direct_max_mapping_size(dev);
>   	else if (use_dma_iommu(dev))


