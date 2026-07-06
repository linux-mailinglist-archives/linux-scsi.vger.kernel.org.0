Return-Path: <linux-scsi+bounces-25658-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5UMBfrES2rvZwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25658-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 17:08:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A671262F
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 17:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=WjSeJ9OH;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25658-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25658-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F08B32F668A
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE33E639F;
	Mon,  6 Jul 2026 14:22:48 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CE3A7820;
	Mon,  6 Jul 2026 14:22:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347768; cv=none; b=A/3DEwuDPEcCr33aN/MGKfvy4AN/yAZE604p14TX2cP72XSzj0xf8OPj0C+kpfLCfwCbVFgyRF/mn++GgZtQvK/DoL481u28XYYQgBL3aMV3m44Nq3pS99zi1ZWkVo5/f9DNbiwFPyEsfhtght/5lKAf9Rx/6lBP6kuSfYjqsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347768; c=relaxed/simple;
	bh=l+zxTiyfnQT0eysEB6of4dvMgiahZQ7ChlScDNv1Yiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnLxOXyk5Xrd5GoM7eBSmtS4CJwDK4Bb9SP1onZSj0w0jOppndhOOwB7MTybUtDQQRyVTQ/f/kWB/34HjRzCyKxO6z0UBTmQi2luYK09VpEjfGTy3M3nr/t8MzBWba42kegY5V2J7KNUSGETEvThebYoVaoR09g0KXK9BIr4nAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WjSeJ9OH; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gv65L2C74zlh2rv;
	Mon,  6 Jul 2026 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783347760; x=1785939761; bh=nNBgelGx3mRHB1Sk5a7CnC2Z
	kQzCv7a96N3gJ4wVDB8=; b=WjSeJ9OHxdnhHGFWk9TUUbnt3jX8Ymc6r3jz9TJj
	ez/HdYwTjuedq4ro0I5QZ5x3xgfy22awka48jYZZG1zG19XVpNWJrG+jXrFSsh/T
	gTSCT31A9ErEsasllYzvPabk5wW4iCHMayq7P/RhjDx4HoBPuq2fTOdppotx00Sz
	+HG8GmFS9+At83m9++D/TgFQjyBduHKbpLIH4j1Av9Z4VSumPk3s4zMd5XsiB06W
	Eu4NcW3uBgxyEJw2hbbfJ2hCI0Tgj/HiK5A56GiLo+JxkfGYqNgWv06T9hqDOCvU
	Y9n65NK0RgepmzzIiaCeRC+NSAZsYQvEH1K55nb/+f8ADQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y8tVbxUS7moB; Mon,  6 Jul 2026 14:22:40 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gv6585pJkzlgtd0;
	Mon,  6 Jul 2026 14:22:36 +0000 (UTC)
Message-ID: <a1621138-9051-4845-b74e-a3e9e895133d@acm.org>
Date: Mon, 6 Jul 2026 07:22:35 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: core: tracing: Do not dereference pointers in
 TP_printk()
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-scsi@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman
 <avri.altman@sandisk.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Peter Wang <peter.wang@mediatek.com>
References: <20260630185412.283c26c5@gandalf.local.home>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260630185412.283c26c5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25658-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rostedt@goodmis.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:alim.akhtar@samsung.com,m:avri.altman@sandisk.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:peter.wang@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,acm.org:from_mime,acm.org:email,acm.org:mid,acm.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 851A671262F

On 6/30/26 3:54 PM, Steven Rostedt wrote:
> The trace events in drivers/ufs/core/ufs_trace.h were converted to take a
> pointer to the hba structure as an argument for the tracepoint and then in
> TP_printk() the printing of the dev_name from the ring buffer was
> converted to using the dev dereferenced pointer from the hba saved
> pointer.
> 
> This is not allowed as the TP_printk() is executed at the time the trace
> event is read from /sys/kernel/tracing/trace file. That can happen
> literally, seconds, minutes, hours, weeks, days, or even months later!
> There is no guarantee that the hba pointer will still exist by the time it
> is dereferenced when the "trace" file is read.
> 
> Instead, save the device name from the hba pointer at the time the
> tracepoint is called and place it into the ring buffer event. Then the
> TP_printk() can read the name directly from the ring buffer and remove the
> possibility that it will read a freed pointer and crash the kernel.
> 
> This was detected when testing the trace event code that looks for
> TP_printk() parameters doing illegal derferences[1]
> 
> [1] https://lore.kernel.org/all/20260630184836.74d477b6@gandalf.local.home/

Thanks Steven!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


