Return-Path: <linux-scsi+bounces-20745-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG2WGgYaimkjHAAAu9opvQ
	(envelope-from <linux-scsi+bounces-20745-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 18:31:50 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7840113118
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 18:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAF0B301D6B1
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Feb 2026 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009F2E8DEB;
	Mon,  9 Feb 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GM9nAIXw"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AC261B80;
	Mon,  9 Feb 2026 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658303; cv=none; b=dGXIcYDHNbGA6L1iOrDVb3Y6GSgffc2xbZG93JdWbip5HRTVl8YRSs3Zkvlj1NfOEUqw+KXibJLghYmcAsOSjR7WyVbCF5VrTXGEoEuDVU/DS6zNKmTNrPdPA+k3zCYllfFsl/bkMZBd5zZ0yKlefrX9T39rvWDz9M/zj2jYOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658303; c=relaxed/simple;
	bh=xqWWZG+4LPGoXic07LiUFznTB43mpT8s/Joq2mCruvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn6jORUwUaM4NdFtuSJDcvY6Pcjs9fQZ6WQbbfyCSv2vi7FTR1Oa6E+Xf8my1g6jwUB9iR8nOnGXZ4KIQZfKxRzFcsrQTrxCUTzHjTxgaEdsWT+FJ0rE/jB9mlh3LXuY9AHlC4lJeLeiB5K2tK1zYBHAcdrgw1I2fkonS8dRcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GM9nAIXw; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f8sFC1Lmlz1XM6Jf;
	Mon,  9 Feb 2026 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770658301; x=1773250302; bh=8Sa+xfFJ1jTvr91hBYrFDNzy
	c10THbH/9ZVuGBRejzg=; b=GM9nAIXwW4fGHp4TaWAjf4Nqn8t/JBmTQ+wVj4ZX
	AEfNIwoIktOQGmvga971XL1S7pzJzB2xEojek1H1gRNQWvAXAzq3DNHYlsGFvWLE
	AXEwtoy+OQJkr5nhpFb9jHim6HDSEZMoN9Vj9xH4A3/s41PYxjzXMA33y9VgruAf
	MZ0r04JAoHjDQMQcyhdYHt3/2Ey80Eu1dpLun8I5+Ta/89fko/4b6YdSmipqgrFC
	UdZ+POc54HdbKJho2GrnRdTa2IlTtC/A15B7mrLBtsuXWhEeJ3SfKG8UBPo5Q2JR
	4j0CiiNZjPQ8xDdQHabse3i5UFj16E9nCUfQufJyH9eWpA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SnISPSCJOyvN; Mon,  9 Feb 2026 17:31:41 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f8sF82MV4z1XM5jn;
	Mon,  9 Feb 2026 17:31:39 +0000 (UTC)
Message-ID: <430f606d-9305-41d9-9a49-b9ab6894cd61@acm.org>
Date: Mon, 9 Feb 2026 09:31:39 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] scsi: core: Add 'serial' sysfs attribute for
 SCSI/SATA
To: Igor Pylypiv <ipylypiv@google.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205180015.2215143-1-ipylypiv@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260205180015.2215143-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20745-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7840113118
X-Rspamd-Action: no action

On 2/5/26 10:00 AM, Igor Pylypiv wrote:
> +	return sysfs_emit(buf, "%s\n", buf);

Since many snprintf() variants do not allow to specify the output buffer 
as input argument, the above seems risky to me. Has it been considered 
to replace the above statement with the following?

	return sysfs_emit_at(buf, strlen(buf), "\n");

Thanks,

Bart.


