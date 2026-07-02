Return-Path: <linux-scsi+bounces-25471-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rEmDF9txRmq9VAsAu9opvQ
	(envelope-from <linux-scsi+bounces-25471-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 16:12:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79FE6F8BE1
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 16:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25471-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25471-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 847C4301104C
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096134C77D9;
	Thu,  2 Jul 2026 14:12:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F84C8FEB
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 14:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001560; cv=none; b=C5nKHn/4otom6U1FPt+MsiMJS5VLu5uyOEXBGNAAfqVAOHLyP/9KTu8gwNQcjShfu62Pu4x4c8wT7kx5SK3ff98EzwaHulqV6qyqAWxl9pAHDDgJ+FcYwryDoTqjkkSqFp4p4fSMAd+LphPJOWzmn/P22EvMnxOLmb7mzXNSdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001560; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o50R89dZxl7LaTT6N4WqRU+dJjdMtELrAzOHnGlIUggnw5WNURQrAVIh6AtvC58YOzWs+vYbnl4cQ8nPg3ZUG1bAKvM+1NMM4AB2lrGXUUg3rFLfmb9Gd79t3QQ+QzNDMry59jS6vXnc5din7Cbkt0Vv/ISvOsHXirwQ4n1K0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B4A868C7B; Thu,  2 Jul 2026 16:12:36 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:12:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, hch@lst.de,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	ionut.nechita@windriver.com
Subject: Re: [PATCH 2/2] scsi: core: Drop dev->dma_mask check in evaluating
 max_sectors
Message-ID: <20260702141235.GC22720@lst.de>
References: <20260629085310.2298552-1-john.g.garry@oracle.com> <20260629085310.2298552-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629085310.2298552-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25471-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:hch@lst.de,m:linux-scsi@vger.kernel.org,m:iommu@lists.linux.dev,m:ionut.nechita@windriver.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lst.de:email,lst.de:mid,lst.de:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E79FE6F8BE1

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


