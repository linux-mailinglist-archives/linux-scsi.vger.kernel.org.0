Return-Path: <linux-scsi+bounces-22215-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMq8J9PZu2k6pAIAu9opvQ
	(envelope-from <linux-scsi+bounces-22215-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 12:11:15 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F36652CA17F
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DC9130DB4B2
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834103C3435;
	Thu, 19 Mar 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv/hPJlu"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488C3ACF16;
	Thu, 19 Mar 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918431; cv=none; b=nlgFctWo/7i//oLZJcvzo52wmfrEMFUpb5gPqgFQCnnjcpBDF/7dg6ebhZvJPpQXADHm2UKAM3mT7BkHcN7nG/YThSdKdp/drrdsUrJLw0Fotq+Yd/Gbes07WKbA0h624bmYY0x6VLOsSqiEJLIjjiidCW4DbozzQGKFmRf4+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918431; c=relaxed/simple;
	bh=d+AJOiDuQJDfnt3iYqZ+1afaE7nwYUax5zKgGgxWn7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDqIDVpryRMyGscN/iT5o8PLH3cTE13PT4TLjxgdalonG939Lvnw6DhX1Gt5JIyPK35NP15CKPobo3ePXsKukIbmypAeGvjBV3ron5NHgdLe39iCg95WuQjVanh6DdkrzR/Krql5AhedyGtPlop9GDiDH2qRfcpbeuRvDznqEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv/hPJlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF796C19424;
	Thu, 19 Mar 2026 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773918430;
	bh=d+AJOiDuQJDfnt3iYqZ+1afaE7nwYUax5zKgGgxWn7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cv/hPJlua64GSjb35XUhLuo8MGoU2r2Uj+KQ+FQ5AixyiE7P02wWhe/4afp5pOmdf
	 1AKTYTj/ETlPuzKz4hmhjsers3l0MLoSSeyWpvD0emzhmzDYdlStCnmWg3AoJE2ZNt
	 q/20rAbNMBPA29OlFnHcGtCwzX1repGdx5TZH/5gJ8Pruf1ncPbjJBrruPwKrlkk7C
	 sdtp9l6e+hS5KwsKyAscu9nWBcWHe48Ht9wGkmjcmolAvAnPCJqLXuvXSP3+pheNte
	 J08mMZc0H9fMWbV6qhWnQqFFl2oXOzpd6WFvcrYmBcs7nlo1CZpzYTrMA1GnylBrA7
	 aKw2JflaH6iEw==
Message-ID: <6a78fcaa-7a3e-423f-b6f5-84cd66a3c88f@kernel.org>
Date: Thu, 19 Mar 2026 20:07:07 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: sas: skip opt_sectors when DMA reports no real
 optimization hint
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 linux-scsi@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, ahuang12@lenovo.com,
 axboe@kernel.dk, hch@lst.de, ionut_n2001@yahoo.com, john.g.garry@oracle.com,
 linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
 martin.petersen@oracle.com, robin.murphy@arm.com, sunlightlinux@gmail.com
References: <20260319083954.21056-1-ionut.nechita@windriver.com>
 <20260319083954.21056-2-ionut.nechita@windriver.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260319083954.21056-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,lenovo.com,kernel.dk,lst.de,yahoo.com,oracle.com,vger.kernel.org,samsung.com,arm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22215-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F36652CA17F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 17:39, Ionut Nechita (Wind River) wrote:
> +static unsigned int sas_dma_opt_sectors(struct device *dma_dev,
> +					unsigned int max_sectors)
> +{
> +	size_t opt = dma_opt_mapping_size(dma_dev);
> +	size_t max = dma_max_mapping_size(dma_dev);
> +
> +	if (WARN_ONCE(opt > max,
> +		      "dma_opt_mapping_size (%zu) > dma_max_mapping_size (%zu)\n",
> +		      opt, max))
> +		return 0;
> +
> +	if (opt == max)
> +		return 0;

Why return 0 ? This is a valid case, so this should get through the alignment below.

> +
> +	opt = rounddown_pow_of_two(opt);
> +
> +	return min_t(unsigned int, opt >> SECTOR_SHIFT, max_sectors);
> +}
> +


-- 
Damien Le Moal
Western Digital Research

