Return-Path: <linux-scsi+bounces-21085-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CiJOKzsnmk/XwQAu9opvQ
	(envelope-from <linux-scsi+bounces-21085-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 13:35:56 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7919772A
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 13:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B612330429C6
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A563AEF46;
	Wed, 25 Feb 2026 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OET3r2C9"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BDA3AEF23;
	Wed, 25 Feb 2026 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022830; cv=none; b=GbhnKQouDtW1HJkY9oFQ50X6nOzQf28IxHHZN19UoV4y35oLplUUiL5W7DrFqcKW11qj2baZSgfaG7aOo7JYtpGzeluKFQYTSmH6DcuuY/01+pfgFyKMkabAvo4MgnhmIkrOibjxQtlLn0N2c7v+GXtKsxttyOTdRWixzJCg+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022830; c=relaxed/simple;
	bh=5womokAWb7eAtY3yaV7gLf//uGlpLRP7R/I+K3LaXLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2GLMJHmVOHMgD+3yoeYZPzO8+/EhSQ2CT31r1b5C4uks3soxQ9i5HUBlNAxc2C4ML+/sPXxTMlJsmKA0cI4HTM+CWGVQtaY754d2BkGuUHoqmmrhMp6towajh6Ach64z+3eE4zKrJM38gABVVYKuaUnqyd8pk9KFim2tzTXl/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OET3r2C9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1772022827;
	bh=5womokAWb7eAtY3yaV7gLf//uGlpLRP7R/I+K3LaXLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OET3r2C9WUilq/M/+ydIBKk5+9/gWXhe/A/j/DDrLFeoAwxWIaHpb9e15qFoNI0Mx
	 OT8dGrXqGztq+GENRdr8H7noLPvfY7+6Bd/WSSPkjW6v4UarULbA22lrfqDLG01vGF
	 79KkTgtOd1QNKpRY37IpBW2qUQyoKMApGTiUARQMhT5rM5ryMjLhmDlu13gNqnLnuY
	 f6WnYMuOFVYhiBZrS03+L1om2i2evbrPn57s6cHtJeLY24bk8jbAAYWLnmW/sztN6x
	 WBNoMH8+aRZnZS299AQil67vosv68a0DHBX/er1D7RkuPPNPVT/B+AvylFWZWBos1e
	 45lvmVYOJrQbw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 948E317E04DC;
	Wed, 25 Feb 2026 13:33:46 +0100 (CET)
Message-ID: <5e61f0d5-d168-4d28-8a68-eb1369e7cf8b@collabora.com>
Date: Wed, 25 Feb 2026 13:33:46 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/23] scsi: ufs: mediatek: Rework
 ufs_mtk_wait_idle_state
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "chu.stanley@gmail.com" <chu.stanley@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>,
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "kishon@kernel.org" <kishon@kernel.org>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
 <Chaotian.Jing@mediatek.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "nicolas.frattaroli@collabora.com" <nicolas.frattaroli@collabora.com>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "avri.altman@wdc.com" <avri.altman@wdc.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "broonie@kernel.org" <broonie@kernel.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <20260216-mt8196-ufs-v7-0-b5f2907c6da7@collabora.com>
 <20260216-mt8196-ufs-v7-17-b5f2907c6da7@collabora.com>
 <dd895595dbd4cf855ef4ea53aa1b5a0d30169f6c.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <dd895595dbd4cf855ef4ea53aa1b5a0d30169f6c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21085-lists,linux-scsi=lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,gmail.com,kernel.org,HansenPartnership.com,acm.org,linaro.org,collabora.com,pengutronix.de,samsung.com,wdc.com,oracle.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:mid,collabora.com:dkim,collabora.com:email]
X-Rspamd-Queue-Id: 36F7919772A
X-Rspamd-Action: no action

Il 25/02/26 11:32, Peter Wang (王信友) ha scritto:
> On Mon, 2026-02-16 at 14:37 +0100, Nicolas Frattaroli wrote:
>> While ufs_mtk_wait_idle state has some code smells for me (the
>> VS_HCE_BASE early exit seems racey at best), it can still benefit
>> from
>> some general cleanup to make the code flow less convoluted.
>>
>> Use the iopoll helpers, for one, and specifically the one that sleeps
>> and does not busy delay, as it's being done for up to 5ms.
>>
>> The register read is split out to a helper function that branches
>> between new and old style flow.
>>
>> Every called uses the same 5ms timeout value, so there is no point in
>> making this a parameter. Just assume a 5ms timeout in the function.
>>
>> Reviewed-by: AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com>
>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Hi Nicolas,
> 
> The logic is quite different.
> 
> Previously, the check was:
> If (sm >= VS_HIB_ENTER) and (sm <= VS_HIB_EXIT), then wait for sm to
> reach VS_HCE_BASE.
> If not ((val < VS_HIB_ENTER) and (val > VS_HIB_EXIT)), then exit the
> loop directly.
> 
> Now, the logic is:
> If sm == VS_HCE_BASE, return 0.
> If (sm >= VS_HIB_ENTER) and (sm <= VS_HIB_EXIT), then wait for sm to
> transition to any other state and exit the poll.
> 

The logic is practically the same, except it's proper now.

There's no need to wait for `sm = VS_HCE_BASE` if `sm == VS_HCE_BASE`.

In other words, just read the comment that Nicolas has put in the code:
/* If the device is already in the base state after 10us, don't wait. */

...because there's no need to wait for the device to get to BASE state,
if the device is *already* in BASE state. It's pretty obvious stuff here.

Regards,
Angelo

> Thanks
> Peter



