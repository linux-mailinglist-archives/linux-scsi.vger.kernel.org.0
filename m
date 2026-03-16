Return-Path: <linux-scsi+bounces-22041-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE7zDArPt2mDVgEAu9opvQ
	(envelope-from <linux-scsi+bounces-22041-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 10:36:10 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B716C297199
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AEA73036EF8
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Mar 2026 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB23378D96;
	Mon, 16 Mar 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KVh9wOn6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E938911C;
	Mon, 16 Mar 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653689; cv=none; b=W9p/dO2NenHPlIIZAv6ARyuy4eM3gq205mGDnOjtNz7aHeHVmIbtTjTjXInxWVE/K89TBW88fd6IoNYAkYAVoNCbobLFqyYD8yZ44ex0JSTTZoG0SoNEiNwdW+GC5042UHu0ovNLfs8MHuu1dwkKgCXJp4JGAGze3/U2I/5V9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653689; c=relaxed/simple;
	bh=huznZbedhmfKAQ7o1PThsloEGLLlgDE3FaFdxbHkFzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=us2aIcYvyIBfkBXqthdPDsdC0CdPrqAQelbuSU/C4f+AgmWVSszAkquaK6CrgmoZgInlGViLi+0QApIzKYTeTdYmV77rs8S7wzXDHP4G2ncEhhB6xP3xBI5VqDH01GyFB2pwLUFJPDO2UDsMNUVXzG8S41R6CV0cHQEqWH5pm0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KVh9wOn6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773653685;
	bh=huznZbedhmfKAQ7o1PThsloEGLLlgDE3FaFdxbHkFzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KVh9wOn6flNT06ymoubOrhTAc4HQuH2n0xoQOqvRKKGz3l4L4JyXkaQyt/I5gJGHy
	 q1gH4+D44ARcUdx6BB4s2Ls6kxck50Z4lBz9HtwSXt7zl71FDLdy1iLtPgAOjnt8Yw
	 md1peYXCFL5bjCSoTdqA8Ije8wf5cFEZtFrXLqht0jfh0bJyRe/dTl/x77D/M0u1hM
	 qAWf/3Ia48qQkh8e5rxXn1+bcrvjsGDLvM71CwedhfosOI4DErzMw0JRln+49FSkVb
	 gNqx+5UnbTE01bR3Y6zenuTDqRj6Y601tfI731khfggd6ltvBTxXfqMGuzhOPg/1PW
	 4Jkb8AyypdR+w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1986E17E0EF1;
	Mon, 16 Mar 2026 10:34:44 +0100 (CET)
Message-ID: <538cb0a5-046d-4ec1-bd4c-d5a01dae7b06@collabora.com>
Date: Mon, 16 Mar 2026 10:34:43 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/23] dt-bindings: ufs: mediatek,ufs: Add mt8196
 variant
To: Rob Herring <robh@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Peter Wang <peter.wang@mediatek.com>, Stanley Jhu <chu.stanley@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Chaotian Jing <Chaotian.Jing@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 kernel@collabora.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
References: <20260306-mt8196-ufs-v9-0-55b073f7a830@collabora.com>
 <4089450.ElGaqSPkdT@workhorse> <yq14imrwp3z.fsf@ca-mkp.ca.oracle.com>
 <5973984.DvuYhMxLoT@workhorse>
 <CAL_JsqKGxrNuaTb9+n3ZYjAdY=UHC6z-neXK-aieTXeROCN5og@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAL_JsqKGxrNuaTb9+n3ZYjAdY=UHC6z-neXK-aieTXeROCN5og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22041-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,samsung.com,wdc.com,acm.org,kernel.org,gmail.com,mediatek.com,hansenpartnership.com,pengutronix.de,linaro.org,collabora.com,vger.kernel.org,lists.infradead.org,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B716C297199
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il 10/03/26 19:21, Rob Herring ha scritto:
> On Mon, Mar 9, 2026 at 5:04 AM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
>>
>> On Saturday, 7 March 2026 19:01:17 Central European Standard Time Martin K. Petersen wrote:
>>>
>>> Nicolas,
>>>
>>>>> "ufs" is redundant as all the clocks are for UFS. Same comment on prior
>>>>> patch.
>>>>
>>>> Is this naming a big enough concern to block this series with two
>>>> explicit acks on this patch that fixes a wholly broken and useless
>>>> binding?
>>>
>>> It is if it comes from one of the DT maintainers.
>>>
>>>> I am trying to put out this dumpster fire of a downstream turd that
>>>> made its way into mainline as the review process has been completely
>>>> subverted, and is only getting worse with each passing month
>>>
>>> This has to stop. Please read Documentation/process/code-of-conduct.rst.
> 
> I have little doubt that that is an accurate description of
> downstream. And if properties are getting added without bindings, then
> that is certainly a problem that should be complained about.
> 
>>>
>>>
>>
>> I apologise for my tone, it's my frustration getting the better of me.
>>
>> I'll be handing off this series to someone else, so you won't have to
>> deal with me anymore.
>>
>> I do ask however that you don't apply patches from MediaTek blindly;
>> if there's code to read an OF property, and that OF property is not
>> in the binding, then the patch should be rejected, even if there's an
>> Ack from the MediaTek maintainer.
> 
> There's functionality to find undocumented compatibles in kernel code
> (make dt_compatible_check), but not properties. Sounds like I need to
> add that.

Rob: yes please, that would help a lot in general, not just with this UFS driver.

Cheers,
Angelo

> 
> Rob



