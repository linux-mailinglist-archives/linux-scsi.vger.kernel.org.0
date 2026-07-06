Return-Path: <linux-scsi+bounces-25661-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qY0gDrzFS2oZaAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25661-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 17:11:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0518712693
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 17:11:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=iDLBtxiz;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25661-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25661-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D45430409C8
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905CA38837C;
	Mon,  6 Jul 2026 14:36:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225D385D70;
	Mon,  6 Jul 2026 14:36:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348586; cv=none; b=tyuOirvCl8c8aPmh1YzDAy4kKeURWJ8DcgFWAqIlF8hAVL2hMSV/I2NbJHz4wJTuLfi8uxPcG3Kn1fiqztUJKy9VYOcXWRQMqAv/tFdxk00Li1iigDvDCZmmXk4F1tCstjom++NR4WIcs7jhePAYeUh4RZcQQujJhEl/isqWGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348586; c=relaxed/simple;
	bh=DgK4DmyUkiXtPIumJrm5A39C5bExfICoZNYmIFe4mKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAa34hL3n46j/gg6/XIBgyrOBYKth2qSxR9GWYkPI3sWxdBn1nMWrIPMHF2gxaeUtgU61LrniJV60R730SejYIQ5SeUaN7gte1+uYmeO74RrEsGiIo5Zdi30iYU8mOQP1DOlKd3jufUsS36X+p3AZGM4Yl7FddrxlZ9PwgVIdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iDLBtxiz; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gv6P46Rlkz1XM6JX;
	Mon,  6 Jul 2026 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783348581; x=1785940582; bh=h8MocHFFKvqgIk5OWIFgXY4E
	iQwjNBAaf8nHwptNO2A=; b=iDLBtxizuUqYzfgUeni8nAlDoNqjBBU2WSjvnu7V
	uczZc9emSSEYRHASBi+VSxZ/7ftg0OkX81yZCM6j2tYR3nYFrTIfy0sB0//MI6V9
	5t+6ktiGw+XUOWPktza/jm72g4tB2EMAgTCyF4qyDM2E/U3IloCKKP73Wj8Gg8lk
	g7k8Plzpxd6AaaTnsHF441tgbRcmzmfsosssjtFDeFfut+az/1WqwIxzR6qm0CKm
	SDqhKAd0XB1lmCU68osPyBjh75C/iYQAdFEYtIb2vI8Hwa6do2pcviHv5wFrmnRl
	ASfX54LDnj5RIoWNW8cbzK8IvD+s3nxP1lsmWeDRyHl2RA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HskJwa86eB1F; Mon,  6 Jul 2026 14:36:21 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gv6Nz1yk1z1XM6JQ;
	Mon,  6 Jul 2026 14:36:18 +0000 (UTC)
Message-ID: <8dca295e-9c39-4707-bdd6-e4aeadbf780c@acm.org>
Date: Mon, 6 Jul 2026 07:36:18 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: switch WriteBooster missing free space message as
 warn_once
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-topic-ufs-wb-empty-warn-v1-1-ec744a153e0e@linaro.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260618-topic-ufs-wb-empty-warn-v1-1-ec744a153e0e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25661-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil.armstrong@linaro.org,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:from_mime,acm.org:email,acm.org:mid,acm.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0518712693

On 6/18/26 12:52 AM, Neil Armstrong wrote:
> Once the UFS WriteBooster fails to allocate memory, the situation
> will stay until fstrim or equivalent is ran.
> 
> Mark is as a warning since it impacts the performance but only
> print it once for the lifetime of the kernel since it's not fatal.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>


