Return-Path: <linux-scsi+bounces-22196-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKW+Elfquml0dAIAu9opvQ
	(envelope-from <linux-scsi+bounces-22196-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 19:09:27 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D732C1035
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13C7E32EF989
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07BF3101D4;
	Wed, 18 Mar 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="G0tWOye+"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0E30FF3C
	for <linux-scsi@vger.kernel.org>; Wed, 18 Mar 2026 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855169; cv=none; b=VOZQj3mA1SB1y6ZiplkVL9xTHGvVlVRIheBOky53kilqLNKUZK0QK0M5Hvw1qR3bBr+ZVBbtk2qGkLxnpsrQzBVYEei2FErNyTtAhn1w6f/AQBlXRO/0uiJ9PFGdetQbQsBqmmnrULv8UPhwsSaPTOD8RfimiIsnrpMQDWdxqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855169; c=relaxed/simple;
	bh=Kk3w2z5a59qIIHGc9xyYzg77nWP5XQbvjXApo5VCwII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xg8T4wRynRNNHTfa0tqkwgxNWKCKF5RzgDH9MydYj47mYqGV9l/CxrNRU5PEXOjJ5bstF1mgR1A33wKv8EZT13tU3FC49Hnrb4hp625Y0auRB7Do0atRNcJdCgsB8pwerE/tcpPjomz2t/z1Ak2qljG4uhaSFq5y4XeMA2LIrEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=G0tWOye+; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fbbWM4f0xz1XMFjF;
	Wed, 18 Mar 2026 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773855148; x=1776447149; bh=b33qdSFprBgEgqtAwWoqsXIo
	JCWkEftC7WTzR/V4YAw=; b=G0tWOye+IiT3a8ksPwdvfqjMj6DPZl7yYvK7VWKi
	wEJzAWuU7rch8ZKTYxGX2CpjYJPJMKI6Pk9OQFVSfst/nFEWWgapeCCZAz1vVCAw
	fcEz4XSc4OMht1l9AnH/siGrFlJD2J3OTpg1gpioKpnADr2dA+mSZ0IlE44W7x0g
	jycbZgE+p2K2Q93TW/6v7A6E830fzfDF9C4VA46xPSU4RmBSQ6axzbxc8GNPiUf0
	/+yQPxv15m/J60sIfyxLxW90iKMZGDPfPoELtFVOtCoQbCi2gOu++uAoTWETaywE
	II7giEJX0fJbNHa0LrTwGwuRlFqSfGxQCKZZesYtPtYghQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EgntMdz2AOrV; Wed, 18 Mar 2026 17:32:28 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fbbVk5c5Mz1XMG4Z;
	Wed, 18 Mar 2026 17:32:12 +0000 (UTC)
Message-ID: <364d15bf-8d11-46af-bbc6-b4ae45618bf5@acm.org>
Date: Wed, 18 Mar 2026 10:32:11 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ufs: core: Avoid IRQ thread wakeup during active UIC
 command
To: Marek Szyprowski <m.szyprowski@samsung.com>, peter.wang@mediatek.com,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 avri.altman@sandisk.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260306054419.3816557-1-peter.wang@mediatek.com>
 <CGME20260317171131eucas1p25dd55bf1aad6d5b310526d51885b3b7a@eucas1p2.samsung.com>
 <1f88b91c-59e6-4347-84c2-50b7cf106c47@samsung.com>
 <df1d0b3f-6822-4c49-aeea-fc513e2b05cb@acm.org>
 <1b9db59c-f736-4c59-b37a-15a60cfa4f3e@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1b9db59c-f736-4c59-b37a-15a60cfa4f3e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-22196-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: 51D732C1035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 10:13 AM, Marek Szyprowski wrote:
> On 18.03.2026 16:50, Bart Van Assche wrote:
>> On 3/17/26 10:11 AM, Marek Szyprowski wrote:
>>> This patch landed in linux-next as commit 6475cfb81fc4 ("scsi: ufs:
>>> core: Avoid IRQ thread wakeup during active UIC command"). In my test=
s I
>>> found that it causes the following regression on QCom RB5 board
>>> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts):
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>> [ BUG: Invalid wait context ]
>>> 7.0.0-rc4-next-20260316 #16535 Not tainted
>>> -----------------------------
>>> swapper/0/0 is trying to lock:
>>> ffff000089f58048 (shost->host_lock){....}-{3:3}, at:
>>
>> This line is a mystery to me. Are there perhaps any local changes in
>> your kernel tree on top of linux-next? I haven't been able to find the
>> text "shost->host_lock" in the UIC completion path.
>=20
> I don't have any local changes, code is at commit 6475cfb81fc4. After
> looking at the code=C2=A0this 'shost' indeed looks a bit mysterious, bu=
t
> maybe it got that name after some=C2=A0inlining or code optimization.
>=20
>> Instead, this is
>> what I found:
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0guard(spinlock_irqsave)(hba->host->host_lock)=
;
>>
>>> ufshcd_sl_intr+0x3c0/0x6b4
>>
>> Can you please help with translating this information into a line
>> number? Tools like addr2line, llvm-addr2line or llvm-objdump -d -l -S
>> can be used to perform such a conversion.
>=20
> ufshcd_clk_scaling_allow() in drivers/ufs/core/ufshcd.c:6492 (code
> checkout at git commit 6475cfb81fc4)

Hi Marek,

I haven't been able to find any call chain from ufshcd_sl_intr() into
ufshcd_clk_scaling_allow(). Am I perhaps overlooking something?

Thanks,

Bart.

