Return-Path: <linux-scsi+bounces-23704-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kApqHgQM/mm2mQAAu9opvQ
	(envelope-from <linux-scsi+bounces-23704-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 08 May 2026 18:15:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA24F949F
	for <lists+linux-scsi@lfdr.de>; Fri, 08 May 2026 18:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E73A6302002C
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2026 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4929C3D6CCF;
	Fri,  8 May 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="In0gZNPA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D94238150;
	Fri,  8 May 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256702; cv=none; b=PJD3IDnHhLZfdjXLfPsUBB/96JEBKMolQwTCmfbrGV/YmUuzNqttLmejSjSM6VCAVILMYs3E3PCSglFBnNsJSSrl0PoQwPuvqxG//1L3MPdodaWOJdweYZph2HTGb2CBoWPznaQvLJZllEGLmb1CwH+DhEvao3b+r0mRi3uEfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256702; c=relaxed/simple;
	bh=cayfImqDZTr/xc0puxBpOA53TgBhP3tBGh1yXq7u9hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3/foGyMsmzTxFfNWyc94ksNkDx9dQ5TbZgciRPi6mjxFQ5sm3mQ7gqtpI2j92lzV+jMUT4nMkqj7ttjIzUKIGSdaY+uL0JkXQ/Vh/cFA9HZrX6vtEgNKijfgoOa6ke3ExrfdC+i5Zc9Y/A76P2OCYf4ddRLJkxJ+uCyotzrvzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=In0gZNPA; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gBvJ56QjXzlfwHM;
	Fri,  8 May 2026 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778256688; x=1780848689; bh=C1mrCW2xfduLae4ExxVch3Wb
	mSvTUGAOgl33Q2rkdjs=; b=In0gZNPAny4m6CXjaiQTjN71VXFx07RsCnmqU37G
	9woPl6vCtRYlaOj0zxrFaVMD+NalMMTKfExRyWwwwqJ65iC/czeoaD4TveEgh6xX
	WgILO1YGUO+pxeiC2z8wh6H8qD9iegCk3SBEMZPY2Bl8E6txqBJmzzV/3Rksye2/
	oRCIDgpmcrt4Z51Tpq03LoUAH4r5eQoZopLWfH1tNttMRRLlLRnovg/vKYz4MKcM
	G0BJ0Y3E2ZISaMbt68L4xe0MbugkdPMaN3KMv8Q4EJ0mnW9fmghzSYO/I/L9x6A8
	niHT/X0N+fQsrKl4iXfHO0aX2KjTh+dd3D+gAN9MIIgYSg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uKCKq5Yfjfv6; Fri,  8 May 2026 16:11:28 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gBvHv0Z5Tzlfl5k;
	Fri,  8 May 2026 16:11:22 +0000 (UTC)
Message-ID: <b0c7c212-c9d9-48bf-9531-9b99b090d4f0@acm.org>
Date: Fri, 8 May 2026 09:11:21 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] scsi: scsi_transport_srp: Move long delayed work on
 system_dfl_long_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260507143410.337267-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260507143410.337267-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7DEA24F949F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,HansenPartnership.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-23704-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 7:34 AM, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>=20
> The function(s) end up calling __queue_delayed_work(), which set a glob=
al
> timer that could fire anywhere, enqueuing the work where the timer fire=
d.
>=20
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a singl=
e
> CPU.
>=20
> Recently, a new unbound workqueue specific for long running work has
> been added:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0c116737e972e ("workqueue: Add system_dfl_long_=
wq for long unbound works")
>=20
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit fro=
m
> scheduler task placement.

This looks like unnecessary churn to me. The motivation for the
introduction of system_dfl_long_wq seems very weak to me. Wouldn't we
all be better off if commit c116737e972e would be reverted and if the
behavior of system_long_wq would be modified from per-CPU into unbound?

Thanks,

Bart.

