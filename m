Return-Path: <linux-scsi+bounces-25645-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DgisCEHBS2rrZgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25645-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 16:52:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB5712376
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 16:52:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Nmo+NKTN;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25645-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25645-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4FA8304DA3B
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD6376BEA;
	Mon,  6 Jul 2026 14:10:48 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEE30DECB;
	Mon,  6 Jul 2026 14:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347048; cv=none; b=BngRy5i0whF/Ih5Qrf6/NdE2h8G1friIeE2pESeFrqLeeO+jgqEhzvQsjLD8mcfb3BKBL3rGwe72D5YcmjgX/XLsiDPl4Lz/7poi8ykC99hrxkF+1oAulHQoVY1Q05XlxzuT2T8mhCk4iTjCDukMBq8dFh490HRRew8aY1Nu9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347048; c=relaxed/simple;
	bh=pR0sfPewLqUjkvilAE3sjmZNNVe5yhV2yVLlfN77kUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7dmcI1jutXJuKqhIMIieiJMDLLcK3qbd6qxt+76oFxxJrGvsrryku4A4YchIF3qA7OZm9O8u2EyYpJjtOBt1QxdpF1vkBFdXtVGY7y/kmT3YB1EcHnXaLWXQ5KXUVR86Aj6xG5JG3X03ih+DEKuq76Nf1q3oZWxVSbbZCnpG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Nmo+NKTN; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gv5qV5QDNzlfpM9;
	Mon,  6 Jul 2026 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783347043; x=1785939044; bh=12uaOnO3hyvTf2UbJyGKDu0v
	KtvT5CdVVK/2N66mqc4=; b=Nmo+NKTN5BKXLj+z2E+lzmzmEZ5Cf6KJLSrdqPT1
	QBooPjD7r86zmhN91GTzJwqQEqu0W/Mi0hObjZXOCi3hD8YvA49oOeNF+5D9w7SO
	bgBwHBGee+JPdIz8zAr5OX3vLvhXR/nz9mFZrIsCy9WqleDbn/BRSF9FTafAhvEj
	qePuTkfXpLM7lonuIfMT9Y7ffuAPhQ1lHFGX6vLzJYl3pb/UL4qfartJimlTeI1C
	DMLKWcVyn9urtKWti1UTeBxfzdfrN8+qYKZDNkSVDYZchq5XZfBjURj/NvJ5NRFR
	l5R6clI0QYoyun6etY2jnmkEERAPPo00npDM7VZz0ZBfYw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pv_wTnKquzXn; Mon,  6 Jul 2026 14:10:43 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gv5qN3fhdzlhH04;
	Mon,  6 Jul 2026 14:10:40 +0000 (UTC)
Message-ID: <8fc64eb4-d4bf-4231-ae0f-2db357b58a0e@acm.org>
Date: Mon, 6 Jul 2026 07:10:38 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: ufshcd: use str_enabled_disabled() for Write
 Booster messages
To: Animesh Rai <animeshrai853@gmail.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: alim.akhtar@samsung.com, avri.altman@sandisk.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260701175152.7446-1-animeshrai853@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260701175152.7446-1-animeshrai853@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25645-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,HansenPartnership.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:animeshrai853@gmail.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:alim.akhtar@samsung.com,m:avri.altman@sandisk.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:from_mime,acm.org:dkim,acm.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95EB5712376

On 7/1/26 10:51 AM, Animesh Rai wrote:
> Replace open-coded ternary expressions of the form
>    enable ? "enabled" : "disabled"
> with the str_enabled_disabled() helper from <linux/string_choices.h>.
> 
> This reduces code duplication and allows the linker to deduplicate the
> constant strings across the kernel image.

This patch doesn't look like an improvement to me. I don't think that we
need this patch.

Bart.

