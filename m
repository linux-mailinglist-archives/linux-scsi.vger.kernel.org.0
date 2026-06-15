Return-Path: <linux-scsi+bounces-24961-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qmVlOjUCMGrWLgUAu9opvQ
	(envelope-from <linux-scsi+bounces-24961-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 15:46:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EB686D92
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 15:46:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=DzWHun1z;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24961-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24961-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80A5305F585
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C83F20FA;
	Mon, 15 Jun 2026 13:41:04 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96893E557F;
	Mon, 15 Jun 2026 13:41:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530863; cv=none; b=AIEDZrWqLeoFdEnZwd+AoeVwk/7CqmmBZPWldPJxJSgd4sITKuS8xvInFdo4llHID//IjVUInRyvpzvVhg6QfCPRH5SG1985GGUlLLnu0pEsqVq3YystWcWBmtiR2Ics7tYqmnA0yGdMBjEbmcpi7xFoP6r0/q2AgBqMoEJ0frw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530863; c=relaxed/simple;
	bh=dGVKq3DqkJdswBGgVG+gslnExkfAwrSp65EizBZiGKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcjAa6cGj7XhPgoWu8sLXH4QytnUGfKrP0a7m6SQXtuoSAENZcTlKVQQ0emSWErzxpu1hsjHXJr6vLEXWsCgRs2hvfZbrNPIbDrKWCiA37OvdDiuWsHJFjd9iMsLkyhqVvMrIrzY69uIU6E9mxFoooNmgf9ww6gGdAbyVuiKDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DzWHun1z; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gfB8t2kqszlfl5V;
	Mon, 15 Jun 2026 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781530855; x=1784122856; bh=dGVKq3DqkJdswBGgVG+gslnE
	xkfAwrSp65EizBZiGKM=; b=DzWHun1z/cTIPfcFjYWFAYKfGzApZhmJY3T8Ic1l
	ekMU1Vrdc3A9lkGKQ1cloPe6yfEd/kHkn+ja9LQf3wKTeBF6qomGJhpl/y8FNcNB
	Ibif9KtpeVwA75hxytJTulSkPZyuQJ9H4qZwynVTiS9B7x41yD2jOJBgQaaLizeA
	WJhj6CC/jATxIE0Hpr7pDnSAVhJRu2/mRw5FxwZrn+2cLV5hYF08w5DYDi8fk1yN
	RiAEWcaZFvwBedNbp2H51nQPCvVMJMM3zbTjlhJXbsJN/2QVAeCpzIihhOnMBy7c
	ArvCMhF2WooauWI1qpBRk9gFZ+9uxUl3tyoadkMMhmo5kA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id m8jRUe-O9L6p; Mon, 15 Jun 2026 13:40:55 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gfB8f1dQfzlfvpG;
	Mon, 15 Jun 2026 13:40:49 +0000 (UTC)
Message-ID: <414c9338-0e3e-4d68-941d-18cb83dc78f5@acm.org>
Date: Mon, 15 Jun 2026 06:40:49 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ufs: core: Remove max_num_rtt field from
 ufs_hba_variant_ops
To: ed.tsai@mediatek.com, alim.akhtar@samsung.com, avri.altman@wdc.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
 peter.wang@mediatek.com, alice.chao@mediatek.com, naomi.chu@mediatek.com,
 chun-hung.wu@mediatek.com
References: <20260615055802.105479-1-ed.tsai@mediatek.com>
 <20260615055802.105479-4-ed.tsai@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260615055802.105479-4-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24961-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,samsung.com,wdc.com,HansenPartnership.com,oracle.com,vger.kernel.org,gmail.com,collabora.com];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ed.tsai@mediatek.com,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:wsd_upstream@mediatek.com,m:peter.wang@mediatek.com,m:alice.chao@mediatek.com,m:naomi.chu@mediatek.com,m:chun-hung.wu@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:email,acm.org:mid,acm.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 437EB686D92

On 6/14/26 10:57 PM, ed.tsai@mediatek.com wrote:
> Remove the max_num_rtt field from ufs_hba_variant_ops as it has been
> replaced by the get_hba_nortt() callback which provides more flexible
> platform-specific RTT capability handling.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

