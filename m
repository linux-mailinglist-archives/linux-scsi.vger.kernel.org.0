Return-Path: <linux-scsi+bounces-25469-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id glfgGpNxRmquVAsAu9opvQ
	(envelope-from <linux-scsi+bounces-25469-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 16:11:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E20796F8BB2
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 16:11:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25469-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25469-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0DC5301AC29
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182894C6F1B;
	Thu,  2 Jul 2026 14:11:21 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3406481FB9
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 14:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001481; cv=none; b=gFPSlIwfbQ+aFZWza58i6KvqYlYaOdeJQ7gNnp+x+2JfF+pqpniIlTwoJ5IIvU9m4URUE/zI4I7MuxaFIGKpCDDAKuqbgqo5nH0Wb58OLNLdjY80JTcxWGYPWk8Da2hQCRye30jii+zGGksQesvZTwm7mwyP5xCgEwaqHynqpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001481; c=relaxed/simple;
	bh=MZrfZMqTxJVvhcMmXsDFGzyLGl4iubhbCil/w06E3Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O52ENerp2SKMGwz8HNoWheJhmSYALPedQEZMd4ScIMSYTXG+jI+zQetMMwDskz1xRaUKSogady4N0ceI4Bgm0u6ryjzZmomlVL/rdhPDaXiFMN4YDlCNv+qN0Fym/t7K0jW3A79Cm3nYg7h46ZdVnijqPqdXg+cVWdbZNwh1bm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 712CD68BEB; Thu,  2 Jul 2026 16:11:16 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:11:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: John Garry <john.g.garry@oracle.com>,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	m.szyprowski@samsung.com, hch@lst.de, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, ionut.nechita@windriver.com
Subject: Re: [PATCH 1/2] dma-mapping: make dma_max_mapping_size() return 0
 for no DMA capability
Message-ID: <20260702141116.GA22720@lst.de>
References: <20260629085310.2298552-1-john.g.garry@oracle.com> <20260629085310.2298552-2-john.g.garry@oracle.com> <53d07679-b1bb-469c-acc2-981e75c071c9@arm.com> <d82926fe-4557-401d-ae58-4302fef5657c@oracle.com> <7c9720fd-c615-481c-ba4d-f5e0efbdd7f0@arm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c9720fd-c615-481c-ba4d-f5e0efbdd7f0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25469-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robin.murphy@arm.com,m:john.g.garry@oracle.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:m.szyprowski@samsung.com,m:hch@lst.de,m:linux-scsi@vger.kernel.org,m:iommu@lists.linux.dev,m:ionut.nechita@windriver.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lst.de:mid,lst.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E20796F8BB2

On Mon, Jun 29, 2026 at 12:09:42PM +0100, Robin Murphy wrote:
>>  > Additionally, could this cause invalid zero-sized block layer queue 
>> limits
>>  > in MMC drivers? In drivers/mmc/host/bcm2835.c:bcm2835_add_host(), the
>>  > return value clamps max_req_size:
>>  >
>>  >          mmc->max_req_size = min_t(size_t, 524288, 
>> dma_max_mapping_size(dev));
>>
>> bcm2835.c is a platform device driver, and platform devices have their 
>> dev->dma_mask set in setup_pdev_dma_masks()
>>
>> Indeed, that driver does have a non-DMA mode of operation, but that looks 
>> to be selected independent of whether dev->dma_mask is set.
>
> That one seems pretty bogus already, given that DMA mode is apparently 
> dependent on an external DMA channel, so "dev" is the wrong device to check 
> (should be dmaengine_get_dma_device()), while conversely 
> dma_max_mapping_size(anything) is a questionably meaningless number for PIO 
> mode... :/

Yeah.  It would be good to get this fixed before this change hits mainline,
though.


