Return-Path: <linux-scsi+bounces-22422-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIXEN6JpwWmoSwQAu9opvQ
	(envelope-from <linux-scsi+bounces-22422-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 17:26:10 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A12F812A
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 17:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAA8F30CF48F
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 15:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215B2737EB;
	Mon, 23 Mar 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rw0bnuLh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27319995E;
	Mon, 23 Mar 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281054; cv=none; b=lw4SHDxw0PSkK1XrDqSGZq+erFlFyu/5f/G/XtwNqLiPvg2EFnwAK+P2f6+0g0mgE4XjO2MahJeGdjDNFbCsNSY28XncbSWU9yu55wSC9Ohz7AAHPc9bljsIm4y2ltKrpSvFUrVJvdZ/+8kp1Yiu9gcuqy1jsvyLi5XCahcTJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281054; c=relaxed/simple;
	bh=5cHqT8+iomPvbqIMKaYDCoYgDOBwOolodTXuTfszMac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cC7Ec6+m0g/R/fAQwdr8K22HdwyxR2q27leYa+sYRz/4QbptaU5LO3FmKgdsiHzZtxaIdl94v+NkBNvBEFNwSJSKpPcexgIx7SRppTbKCqUSnpQ6jkDXugRuMr9tZ2cB0SlosJ8GBnEQfy7oL8gmLQYUlNG9bwVAF3p5IFpbXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rw0bnuLh; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4ffd1R0WVNz1XM6Jl;
	Mon, 23 Mar 2026 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774281045; x=1776873046; bh=5cHqT8+iomPvbqIMKaYDCoYg
	DOBwOolodTXuTfszMac=; b=rw0bnuLhNTpygo+LY4T/PmZ4mB3+7caRHdV10+fL
	NBQJ9qVRolo1gi8NnWNBLSCH7KoT212zhTU//Ahcqasxwj/RV16n2uM0B7LsA7Tc
	jbP9+3WrfXlpC1nEzrkN+k8mi289A2Vbj7z5Tq5yyCaB8p/zSCuMX2fb+DiURcQj
	m9l+xgrxBpoZ7tNQC748yVOSDM7/azsRSH0YNPQp0BERcwLJxOHm89ndWD1jrVwg
	C/ByrLQ/UFjspXdLoicvvK2t7nV70Tbkkq/oQND59nZqlVWr7NTIw7ve5I6srzM0
	2GeJIhKwDG/mmf/e0wyeLL/Mfh7jOpq1qCFw5xdmjW4uTQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S-hNqC-8Tm9F; Mon, 23 Mar 2026 15:50:45 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4ffd1F3J3hz1XM6JY;
	Mon, 23 Mar 2026 15:50:41 +0000 (UTC)
Message-ID: <207a4a3c-39ce-4413-a307-586a718746c5@acm.org>
Date: Mon, 23 Mar 2026 08:50:40 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: esas2r: fix __printf annotation on
 esas2r_log_master()
To: Arnd Bergmann <arnd@kernel.org>, Bradley Grove
 <linuxdrivers@attotech.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260323100027.1975646-1-arnd@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260323100027.1975646-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22422-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi,lkml];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:email,acm.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB1A12F812A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 2:57 AM, Arnd Bergmann wrote:
> The warning already got silenced for gcc but not clang in the past.
> Rather than modify that hack to turn it off for both, just add the
> attribute as suggested and remove the pragma again.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

