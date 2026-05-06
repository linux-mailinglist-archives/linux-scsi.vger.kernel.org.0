Return-Path: <linux-scsi+bounces-23661-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFigOkfZ+ml8TQMAu9opvQ
	(envelope-from <linux-scsi+bounces-23661-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 06 May 2026 08:01:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF24D66D5
	for <lists+linux-scsi@lfdr.de>; Wed, 06 May 2026 08:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375693010531
	for <lists+linux-scsi@lfdr.de>; Wed,  6 May 2026 06:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB11FF1B4;
	Wed,  6 May 2026 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i1VMmVvB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0A131E49;
	Wed,  6 May 2026 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778047300; cv=none; b=s3Waxzy8KdLsKqtlHHfIYqDgwcg3t3DGTqYPV0TTGHNIBeHRtuRzdQTSOpcQjw0fsO2hGe9bfjP5t/Plp2VvSCp32eAEUIQ+ZJHcRgrATac3fpdw58mrsnQx+htm9/de85Zwyb1IhIYWO1fkNRX3nPO3JKX0znkuaFZwhx/YoC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778047300; c=relaxed/simple;
	bh=tW1UnMnTmnUZd3utF1f+eapS/pK7VY1auoihHDD3K2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4vPzlSc2ecpSjtkUZQf/ArqwggvwrbYnjdeFcEEPgdmN+tCywwkgyx/dNyZuDjQc7V1LKeOzsogsAvBllCIjOpI8P74s0dYDtDB2jV/KX7qrTzrAIn72yd3Kx/UBwkGUwRz6On4yTuqlftMHwetTiybXa1Df09j4KrIrOWsMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i1VMmVvB; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g9Ps82Swpz1XM5kY;
	Wed,  6 May 2026 06:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778047290; x=1780639291; bh=0xew0wuaLuZsYXm6l62fWFq1
	GwkD2k94KAlYolfwuSE=; b=i1VMmVvBbT32h0sN5dnFXQEtlwBXRuhTLBW2qXtD
	vCjA2e2vgNrsvwkJqggrzUhUM5Ym8bfu2/W6mMbMJGI8WW+CBqoPXnYkr50ObKCj
	P5j0fLt/LFaShC5ghTKU1sbx8wT2dzS/inKIJtLkIE1VhMSaRW+xXlmVgGNDxeUB
	EzJfPfdXzhzF6Og4vBT65LRAoJ8O0eAOUgLN2h7XpkhmJlBMdelNNfjiXlg/fVtz
	+soGEWSX1TBUYGRqlcHq8alUR/YHrjrz07xmrYBEsmIOuPvdQITlDKsqyAH9Z5cH
	d9UL50n1BTiBveCCJCMQYJVBj4YZN0+/IEbawfOB2gaSlA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hIPgY8DZYAU5; Wed,  6 May 2026 06:01:30 +0000 (UTC)
Received: from [10.211.9.52] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g9Ps3662fz1XM5jn;
	Wed,  6 May 2026 06:01:27 +0000 (UTC)
Message-ID: <632b8db8-4e22-4681-be52-31bd33adaca3@acm.org>
Date: Wed, 6 May 2026 08:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: scsi_scan: Fix typo in comment
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-scsi@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-kernel@vger.kernel.org
References: <20260505223338.5694-1-shofiqtest@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260505223338.5694-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 05EF24D66D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23661-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]

On 5/6/26 12:33 AM, Md Shofiqul Islam wrote:
> Fix spelling mistake in comment:
>   - initialze -> initialize

Your Signed-off-by is missing.

See also Documentation/devicetree/bindings/submitting-patches.rst.

Bart.

