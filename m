Return-Path: <linux-scsi+bounces-20671-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PNiDt6OgGkl+wIAu9opvQ
	(envelope-from <linux-scsi+bounces-20671-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 02 Feb 2026 12:47:42 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AAECBE5C
	for <lists+linux-scsi@lfdr.de>; Mon, 02 Feb 2026 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA603014641
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Feb 2026 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733D3624BC;
	Mon,  2 Feb 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qTCNvj/b"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCF35B65F;
	Mon,  2 Feb 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032564; cv=none; b=XdC9PFGJLXybXJ+z20nJR8ePhkisvGDAswIdComWQLBhQLrnCuVFL2YViv4pgKtO+jG2V/cf47uXKnY9+eIK6oweUv5MAF/jHqbwpdSakjyW1oZCekhYDfsbP/ojEr9w6Oy6P+dey2t3owUIHUaDvsF9s0ucwkbiLAET/9XBQ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032564; c=relaxed/simple;
	bh=w7krebU2H1Mpuz4YFi6JBpMGhVX2NYi1AWbumRrPDkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7t8XLgIWQJvuVQ8meWaippPOFKzo9AsoqL4yH8dowu9CpuaN4UNN5nXiG8da64YkEvRPydsteFL2cQwqUM0bl+Plzzvd2YLuZzHKw6JLg1DkddacUALbNfSzuGzZ9Ss9exg6uiHA0C8Ye4imq5pm3PB45KkuD+sLKtwLzO3g+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qTCNvj/b; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770032555;
	bh=w7krebU2H1Mpuz4YFi6JBpMGhVX2NYi1AWbumRrPDkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qTCNvj/bQDmaAHIv567WhqG6RBXfeMpXqP4tocFYidQG+D51ESaH6nkX/efvGvdPt
	 FAMFdBKAlI0892rG877TQ08ZBIQziKgXGoH8z9WXx05HaiLWUy41RwBA+DbVhukuZN
	 ftihXDoqLIzKXn7Vsqy7F6DYnELi/wzLDYtEopioyWQcTLqfjrGwuYhARnXWgIq+WA
	 PMyYgz8QUneYI2UejnZhYGwKkRTpIa+CwCpdzl8JAf5d7Xs4SSX0nJoWKBfGfwrCRu
	 N8j1KPtUyG8iMQXiPvTWvOAQNH5Dy1iGFUF7TeSKWg2k2HBqw0TAjc1XxK/Bgwo9di
	 RHv/Cb/sV+n8Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8202117E130A;
	Mon,  2 Feb 2026 12:42:34 +0100 (CET)
Message-ID: <845cca9d-1912-4f00-8245-3d5293f164db@collabora.com>
Date: Mon, 2 Feb 2026 12:42:33 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: host: mediatek: require CONFIG_PM
To: Arnd Bergmann <arnd@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Peter Wang <peter.wang@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stanley Jhu <chu.stanley@gmail.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Chun-Hung Wu <chun-hung.wu@mediatek.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260202095052.1232703-1-arnd@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260202095052.1232703-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20671-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,HansenPartnership.com,oracle.com,mediatek.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,samsung.com,wdc.com,acm.org,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,collabora.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 95AAECBE5C
X-Rspamd-Action: no action

Il 02/02/26 10:50, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The added print statement from a recent fix causes the
> driver to fail building when CONFIG_PM is disabled:
> 
> drivers/ufs/host/ufs-mediatek.c: In function 'ufs_mtk_resume':
> drivers/ufs/host/ufs-mediatek.c:1890:40: error: 'struct dev_pm_info' has no member named 'request'
>   1890 |                         hba->dev->power.request,
> 
> It seems unlikely that the driver can work at all without
> CONFIG_PM, so just add a dependency and remove the existing
> ifdef checks, rather than adding another ifdef.
> 
> Fixes: 15ef3f5aa822 ("scsi: ufs: host: mediatek: Enhance recovery on resume failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



