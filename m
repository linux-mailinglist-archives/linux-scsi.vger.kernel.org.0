Return-Path: <linux-scsi+bounces-23118-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICoLFF5r5mmBwAEAu9opvQ
	(envelope-from <linux-scsi+bounces-23118-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 20:07:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D55432796
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97BA83029B22
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Apr 2026 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC63603FB;
	Mon, 20 Apr 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="byblWIv0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09C379EE4;
	Mon, 20 Apr 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704314; cv=none; b=pVpC8l0yeZsIH5r+cqhK/DP3hiHpv27IwAIXPkHwSJllZ/O/aPqkFi4MXWpcebArGhIrjZq4mMGfWwygOabKPbYZDc12MxIVb+zfQC/hsnp3azQA36z+VOR9U9AMJfkNX82KEmJ3Ao7EiHk3JRt/aIOjM0iHy1sHt2a8+oZlJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704314; c=relaxed/simple;
	bh=267J5lYVPfOLIkD3IZTERG2XE+VdX0sx6jwHWEYbSQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+lK+4lBvhnifaMnBsZ53UsimKK7GY32NfcCd9+UoMUWcRv1Hc5PEVAxUl8pfByHPNF3dtHwByzNMi/AnW6h987g4z4OqxHwrIE8CuT4iYu15i7RkHLq/5ieT83y3d+GGQ5SOYu8Nl/7lFg5d5GDm8rwHlEKssmc4Nwt+RMO4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=byblWIv0; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fzsBc4tyBzlffvG;
	Mon, 20 Apr 2026 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776704304; x=1779296305; bh=dLYm+DhUaFyrsv2woamzU3QH
	TCSe9i0NP8QlYYjwjzI=; b=byblWIv0P0Ebkw4JlwOgYqTaYD7Pkbhr07rvOBeU
	eqeM+CmpALZZYsIa0GDaYsQJRnJegqb8jXa0/o1yYugdkbEDRuc7Zkzcvm1IjSXY
	WtVp+fEGbPvDG6mrjczGhF1wWqncFRVLH49iH29I4EFHhiq+eko7l5XxsaCHzxc4
	GZILKBBB+QNsBD413ToTZAqKt52TMVOEDU4chhqQyrd6StD7QXm2NuYqYwXqI7tg
	0mgKwSteRw6/D7GYeHJZRZowSRp4zwozakvOaf3EHkakZDJAd5ylD2tkrBV5cUKf
	Fc2jFObQEFqUdZAYACBI1OS5NLzkIuAs1qYIpgf4UQd2XA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FkTLZVA9wyJe; Mon, 20 Apr 2026 16:58:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fzsBM61JJzlgtd1;
	Mon, 20 Apr 2026 16:58:19 +0000 (UTC)
Message-ID: <316c8b28-9e93-4d14-b6d6-e8d593b8627c@acm.org>
Date: Mon, 20 Apr 2026 09:58:18 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: ufs: core: Introduce function
 ufshcd_query_attr_qword()
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, peter.wang@mediatek.com, martin.petersen@oracle.com,
 mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Keoseong Park <keosung.park@samsung.com>, Daniel Lee <chullee@google.com>,
 Ram Kumar Dwivedi <ram.dwivedi@oss.qualcomm.com>,
 Huan Tang <tanghuan@vivo.com>, Liu Song <liu.song13@zte.com.cn>,
 Bean Huo <huobean@gmail.com>, vamshi gajjela <vamshigajjela@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260419135229.1036926-1-can.guo@oss.qualcomm.com>
 <20260419135229.1036926-2-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260419135229.1036926-2-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,samsung.com,HansenPartnership.com,google.com,oss.qualcomm.com,vivo.com,zte.com.cn,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-23118-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74D55432796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 6:52 AM, Can Guo wrote:
> +static inline bool ufshcd_is_qword_attrs(enum attr_idn idn)
> +{
> +	return idn == QUERY_ATTR_IDN_TIMESTAMP ||
> +	       idn == QUERY_ATTR_IDN_DEV_LVL_EXCEPTION_ID;
> +}

Please change "ufshcd_is_qword_attrs()" into "ufshcd_is_qword_attr()".

> +/**
> + * ufshcd_query_attr_qword - API function of sending query requests for quad-word attributes
> + * @hba: per-adapter instance
> + * @opcode: attribute opcode
> + * @idn: attribute idn to access
> + * @index: index field
> + * @sel: selector field
> + * @attr_val: the attribute value after the query request completes
> + *
> + * Return: 0 for success, non-zero in case of failure.
> + */

The word "API" is uncommon in the first line of kernel-doc headers.
Please remove it.

Otherwise this patch looks good to me.

Thanks,

Bart.

