Return-Path: <linux-scsi+bounces-25470-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x5fiGMpyRmr4VAsAu9opvQ
	(envelope-from <linux-scsi+bounces-25470-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 16:16:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D085D6F8C78
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 16:16:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25470-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25470-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C5A3079A2B
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2A4C77A4;
	Thu,  2 Jul 2026 14:11:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209794C0424
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 14:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001503; cv=none; b=KoylfKb1gWzpb9WJkbuRKxkt9t5CPMgOMzo5ecdhrSf98Dl8Yx6s7GbKXV1TiRRznNTwnLB5+xQ0DiQDg7++8/MtpcyXRQuU51OnRTliZs/Dcy3UFjjrng4zUZxCcbKWit/wReQaH/2mmc320MT3P+pXoXQuVlDOnReBJoO3TC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001503; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlmiwEL5UUDfQhaU17CtSZjWEqocYL1DijJtmHnytqy04JQqDgn6PjjJYxguRvu0STJIxWa/wTz0CAFsoKocnx3PgDGQXKiMEYJIBeRO+Ne00vjd4TQ8/eDRws24S7RuEMFReTSRqGQfaRi5x+G454ILE1KTHx3EjtULbFlGClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id A019C68C4E; Thu,  2 Jul 2026 16:11:39 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:11:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, hch@lst.de,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	ionut.nechita@windriver.com
Subject: Re: [PATCH 1/2] dma-mapping: make dma_max_mapping_size() return 0
 for no DMA capability
Message-ID: <20260702141139.GB22720@lst.de>
References: <20260629085310.2298552-1-john.g.garry@oracle.com> <20260629085310.2298552-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629085310.2298552-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25470-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email,lst.de:mid,lst.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D085D6F8C78

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


