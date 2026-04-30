Return-Path: <linux-scsi+bounces-23490-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOSXDON682nH4QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23490-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 17:53:07 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B574A52A6
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C023014134
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C242427A0B;
	Thu, 30 Apr 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cUFJQ7mt"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34944CAF8
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564206; cv=none; b=C9+qLnPnQXjlCsCCoCc1LWEqxYfEvRzvQQyOftEm8DYNx8cvldfZxVO+qr0DzwNR0fKjw7A1/bTbQAlBRSam1rDowh5uetvhDqoY/+FY25eXDmu8kaWTg7J/4eynX6hApB5ms1t578KdamKEwwoRCswYa1Rsh482EPKQLMdUyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564206; c=relaxed/simple;
	bh=CBOU4FM4gvoqUnSwNJJr4/hstXok6eVkIabJZ4+X/Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btlhEwY7YP+f2XLour9lDRSSALRDy8CaHF47Qvd5jBVLtnXvJfA0j/AGc+zWUfCTb/cZKs1Aw3pX23efb6wSlHKdyR1cpPpqTiCrLLxk9JK59QclnLQaSERbYQHlQa6uA0d9CCnFuJnM8MgkHlhuovT+vTZtuWSFlDpQCAlxRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cUFJQ7mt; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g5zC01jg1zlfpMC;
	Thu, 30 Apr 2026 15:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777564202; x=1780156203; bh=mK1yJ4qzC4BfMhuICukpzxJy
	exHZ1aoiyuqPgBipZu8=; b=cUFJQ7mtCAxmEQktwkkeDb2Uvf6IzMvM+S1ek8UA
	hQWgQeu/6JHQfRCkRdRfBKxuOwyzZq5c5PaTnWpjaZdO4BORFMubuVSqn2nG6psV
	RPdWOcpTMO2u2d+xcJTdgRUmztle9cg+CVDvJ4vuult6So4jl12SnSk9dEGeN9PY
	3KTg7NFm6H0kKkpGNeBgISiF01RD60w3gd65ScjEbutsmrT0nqWIN8RlICeznv8G
	ZwQt+OD43MYPDWhGJa72y8p4IUBAR3Os3Jo1ftF0VRbQaxPEWxnS3eSKfna3oBEW
	aP0httv7dl9sgJ+qbJSTr8brnkS7sjNxx2BxBsffDJpyQg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MUyaQtOBT5gu; Thu, 30 Apr 2026 15:50:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g5zBx1WStzlfvq4;
	Thu, 30 Apr 2026 15:50:00 +0000 (UTC)
Message-ID: <158f88bd-0719-4759-b793-33069c295501@acm.org>
Date: Thu, 30 Apr 2026 08:50:00 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] scsi: Add INQUIRY data field definitions and accessor
 helpers
To: Brian Bunker <brian@purestorage.com>, hare@suse.de,
 linux-scsi@vger.kernel.org
Cc: Krishna Kant <krishna.kant@purestorage.com>
References: <20260424215324.99045-1-brian@purestorage.com>
 <20260424215324.99045-2-brian@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260424215324.99045-2-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A6B574A52A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23490-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]

On 4/24/26 2:53 PM, Brian Bunker wrote:
> +/**
> + * scsi_inq_removable - Extract removable media bit from byte 1
> + * @inq_byte1: INQUIRY data byte 1
> + *
> + * Returns: true if removable, false if not
> + */
> +static inline bool scsi_inq_removable(unsigned char inq_byte1)
> +{
> +	return inq_byte1 & SCSI_INQ_RMB_MASK;
> +}

This type of functions is highly unusual in the Linux kernel. We
typically open-code functions like the above instead of introducing a
function with a name that is almost longer than the function body.

Thanks,

Bart.

