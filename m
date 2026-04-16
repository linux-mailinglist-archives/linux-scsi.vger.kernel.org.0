Return-Path: <linux-scsi+bounces-22977-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIFbDv5x4GlkgwAAu9opvQ
	(envelope-from <linux-scsi+bounces-22977-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 07:22:06 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726740A56F
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 07:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66E12304C4C0
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 05:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393D3366823;
	Thu, 16 Apr 2026 05:21:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA733BBD1;
	Thu, 16 Apr 2026 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316898; cv=none; b=r5OKl9YINnWVO1W9xYQz/OyzGSC7mnRLBk+hY+UIdmV7fM3yF40YL2VHQN9EixgLUVFX9pNcAhs0R2XcTp9hm4CBmw2P2Ihq7eedJCv6WL92zjBo1xgpjUWIPbnkIMVgK59HMwD3269eCCrs/CBEEABZCREuxrWVHiHD3rvo1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316898; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMsLlxHFhhlr6by0ObenpZ/44Us06coHPTsyBoj4pNEuJwo4uKUx/2YiMmayeUi9gjIGA+aRMaobClK7d/FpFkdKazcH2Q4yJqeUH2KBfE+ERIcB6XBnEYDYhKBkaPXZnejm5PIfZL1kZrFcKirfer/CsaRQ0QPmAdFpqAK1hqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28E986732A; Thu, 16 Apr 2026 07:21:34 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:21:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] blk-integrity: take u64 in
 bio_integrity_intervals()
Message-ID: <20260416052133.GC14950@lst.de>
References: <20260416002214.2048150-1-csander@purestorage.com> <20260416002214.2048150-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416002214.2048150-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22977-lists,linux-scsi=lfdr.de];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 3726740A56F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


