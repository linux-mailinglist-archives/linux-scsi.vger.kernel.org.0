Return-Path: <linux-scsi+bounces-25967-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PTkBnX2UGp39AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25967-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 15:41:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6173B57E
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 15:41:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Dci6QSne;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25967-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25967-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B92A93007226
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3E3FBB6A;
	Fri, 10 Jul 2026 13:40:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F0374E5A;
	Fri, 10 Jul 2026 13:40:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690852; cv=none; b=RKDghwdkqkve4LyoUNY7pTLC7OB3Bn48WwXPlXxDnPEdruN5Ym6uY4rLAaldX0a5BA+pwmX+nRCS/dpIDvbq8IL1ii85PjXrNS2Xa9Si9T3OCdV3FL3rDKHOtsWIckgXAEhSj5KozNwhh+QyN25oSFz0r25EFKZ+H6KObADsKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690852; c=relaxed/simple;
	bh=ANhHVphqp97jTNeKfP4QFxWLoHszJCOkWdXOHXSFUSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSIHIU9TGjqHFCnwlbC4ospd//nXO0cCwasP5lMQ/wZG59zEUMr/+9zX0R7PrrtwRrO2aPiELgDSiMGSI1wl5vLP8Ax7WI0uEYyWg27IR4Ik5Js/8bN+Bgxxk5Dvd49ZSo8RfA1xIVpCXnb79ZN+eaMA7pLUjNETkd7tZdIKk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Dci6QSne; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gxXz03VTqz1XM2FS;
	Fri, 10 Jul 2026 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783690839; x=1786282840; bh=ANhHVphqp97jTNeKfP4QFxWL
	oHszJCOkWdXOHXSFUSM=; b=Dci6QSne847wokYf2isHg1NheXKYYVC7b4U9Uh+P
	r5Kj7bAMeHLK8SiafycqFC9selkSN2uHbKsmYmvuhK3b7yhL5JR5luRdPuvBqEMW
	WfdORovLt7eobhcxx+Yb/z1S6k1aK9nlcDBIpVqIDTh4SWXvnUKCGERvULMdA8J+
	FL9xUFONAkCS2AiUiOA4tMIFJoST7dgBhzLWpdI3BaDTRCumn7ZdsZW8PFJfAHE1
	iD4Z+uVkF954iIV/iRhhWj5BSKS0BFThxOW56B2tluSGPvYDlsurmFMRlxer8pGn
	JuBdlAtEfRsHvR9dCK4Uj+rhqwWnJMMZ3d1rcb4aFCHG8g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9JDeUorXncFP; Fri, 10 Jul 2026 13:40:39 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gxXyp62xKz1XM5jn;
	Fri, 10 Jul 2026 13:40:34 +0000 (UTC)
Message-ID: <dacf7681-4af3-4b13-82e0-c17a44fd73af@acm.org>
Date: Fri, 10 Jul 2026 06:40:32 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: Allows the driver to choose the interrupt
 handler type
To: Kui Sun <kui.sun@unisoc.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@sandisk.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 rain.zhang@unisoc.com, yuelin.tang@unisoc.com, wenchao.chen@unisoc.com,
 cixi.geng@linux.dev, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>
References: <20260710065948.467514-1-kui.sun@unisoc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260710065948.467514-1-kui.sun@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25967-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kui.sun@unisoc.com,m:alim.akhtar@samsung.com,m:avri.altman@sandisk.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rain.zhang@unisoc.com,m:yuelin.tang@unisoc.com,m:wenchao.chen@unisoc.com,m:cixi.geng@linux.dev,m:andre.draszik@linaro.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,acm.org:from_mime,acm.org:dkim,acm.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CD6173B57E

On 7/9/26 11:59 PM, Kui Sun wrote:
> This capability allows the host controller driver to choose whether
> To register interrupts in a threaded manner or in a
> Standard (non-threaded) manner

A patch description should not only explain what has been changed but
also why. Why do you want to make this change? Why do you want to change
the default behavior from threaded to not threaded?

Bart.

