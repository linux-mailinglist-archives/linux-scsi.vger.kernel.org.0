Return-Path: <linux-scsi+bounces-26071-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ZmJMcYgVWopkQAAu9opvQ
	(envelope-from <linux-scsi+bounces-26071-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 19:30:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649C74E072
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 19:30:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=v2+y2nZB;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26071-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26071-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5FA8303E8C4
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C2346E60;
	Mon, 13 Jul 2026 17:27:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043893537F7
	for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 17:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963633; cv=none; b=UHNgmA0EqrN8PhevgEMro/h3FOe4V2Type/d7T2Xo9hD5y6+loSp3ZFdBfy9eqEk5ta1gNWMAQpgfUfRi1Rzsaf0jSmNaKAojUsGoi89tiJf13g+VvKfPFUh5U+WT6SpUDojvoCh2b0ASQzz0zKAEWczL5ftK/IreMCymamWnb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963633; c=relaxed/simple;
	bh=qXr3esOiGouSblxay/VM+vjsfO/JEhG1cUi6SCkc8QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daXUqPO2niyOjeH3atbCFSWNTQIHM6qSVvNDqh592mQdNIxbJ117lh9dAM1GueebqTSCZ//u0im5iFTPf0VHNNUML34FcrCPNuvKky6Ga0E3239/cK+ftk7iZ1JvLHlVVhtjS8Y9Q71kVXoeiCeNrUpzAdR5neVdbtx1lS7Mi1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=v2+y2nZB; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gzTrj3n4jz1XM6J6;
	Mon, 13 Jul 2026 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783963618; x=1786555619; bh=qXr3esOiGouSblxay/VM+vjs
	fO/JEhG1cUi6SCkc8QM=; b=v2+y2nZBsFWN/Ydl6yxWF6KCxZquwdmj2x/5kdA0
	lOnUSDpBlfnFtUbbrMFVaSoJbQGLQmxDXPHPFtcyplPxUT0JXUFT13pjj9+CDC/I
	eKo7HVxyj/aL9fy+z2I27IODUAI0+YVBXqvuxI4jFTM0+d+ssorDmAUG3VUdV7EB
	h2wC/j5Y7octcScPlRW1DDGFIYrjVMKQ6gbXHrZrdgss79ONGpWgVY+h8eVAgGeE
	kTrT4Ajf7rdWmG33S9u5heZ6qf3vtDaWOvANinT3+q/ZEBqbMcc/Ml1X/naBt+qA
	wlnRYCq05OfUtawRv8F0d5Lc2Chk7GF4+4cK9RL/6OPEXQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N9_JBl7vuATG; Mon, 13 Jul 2026 17:26:58 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gzTrc4DHtz1XM5kW;
	Mon, 13 Jul 2026 17:26:56 +0000 (UTC)
Message-ID: <60f358dd-82b7-486d-baba-a51c3fa5e9d5@acm.org>
Date: Mon, 13 Jul 2026 10:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1JGQ10gU2lnbmlmaWNhbnQgUmFuZG9tIEkvTyBQ?=
 =?UTF-8?Q?erformance_Regression_in_Linux_Kernel_6=2E18_=28Up_to_27=2E7=25?=
 =?UTF-8?Q?=29_Likely_Caused_by_Commit_3c7ac40d7322?=
To: =?UTF-8?B?5a2Z6a2BIChLdWkgU3VuKQ==?= <kui.sun@unisoc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "andre.draszik@linaro.org" <andre.draszik@linaro.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 =?UTF-8?B?5ZSQ5pyI5p6XIChZdWVsaW4gVGFuZyk=?= <yuelin.tang@unisoc.com>,
 =?UTF-8?B?6ZmI5paH6LaFIChXZW5jaGFvIENoZW4p?= <Wenchao.Chen@unisoc.com>
References: <12a8417dc8644a71b9cb25c53c93805a@zeshmbx08.spreadtrum.com>
 <d426b4d5-cdf5-4090-8e94-62e652f712dc@acm.org>
 <7863f3e51a8e4d52acdd24a6aea9cf5f@zeshmbx08.spreadtrum.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7863f3e51a8e4d52acdd24a6aea9cf5f@zeshmbx08.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-26071-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kui.sun@unisoc.com,m:neil.armstrong@linaro.org,m:alim.akhtar@samsung.com,m:andre.draszik@linaro.org,m:linux-scsi@vger.kernel.org,m:yuelin.tang@unisoc.com,m:Wenchao.Chen@unisoc.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,acm.org:from_mime,acm.org:dkim,acm.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5649C74E072

On 7/11/26 4:21 AM, =E5=AD=99=E9=AD=81 (Kui Sun) wrote:
> We have already included these two fixes, which are related to
> stability. The issue we're encountering is performance-related.
Does this patch series fix the performance regression? Please note that=20
patch 4/4 of this series is not yet present in the upstream kernel:
[f2fs-dev] [PATCH 0/4] Reduce the time spent in interrupt context
(https://sourceforge.net/p/linux-f2fs/mailman/linux-f2fs-devel/thread/4b3=
37c7f-2fbd-47b6-9c8c-587e7b5513f1%40kernel.org/#msg59345049).

Thanks,

Bart.

