Return-Path: <linux-scsi+bounces-24962-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ER+KXYBMGqlLgUAu9opvQ
	(envelope-from <linux-scsi+bounces-24962-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 15:43:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AC686D49
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 15:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=EXbibQZN;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24962-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24962-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A82E3034EE2
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Jun 2026 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286AC3F4842;
	Mon, 15 Jun 2026 13:41:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C803F1AA8;
	Mon, 15 Jun 2026 13:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530897; cv=none; b=V8HV0XoSW3rTZj18eWydOqiBpzxWRE1fxHIyOBsDc0iNfqxQLAHUKYH4hfD+IyNIyo8qLhyv75G0wTM3K3Y1P/6vCMT4qAJJkdPUYEwu8wGY97WQ0oZ1yWsv8tl8CHJkB/FYYsQMFD5WNlhebTaW5uCtgnECJimT9e470lyT9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530897; c=relaxed/simple;
	bh=rGTGw5saMfWpogiLdHb3L8tLLsKOpgLzFfOmMVVS1Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZDNinlmOpq3+jt6HHW5brJCGKW6j9F5dW+Pb8kDxQSWukIAhq2p+v3Gw366kUauNyMum6N43u46qfa5objSGQn0b74mUgxAjYr5dNs5UJtTY/f3A13A2DSKZQ+U+sqAT1tDEoOV5kuRoDV1Mo9XPAHIl4IerHSf9waLcJbFh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EXbibQZN; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gfB9Q02Lfz1XM6J5;
	Mon, 15 Jun 2026 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781530882; x=1784122883; bh=/JFdcv43vw4EPbj2pYJuXY1Y
	O+uQmOnZRhQpYncm8gw=; b=EXbibQZNF4hEuQlmCeXwJOs2bhoV87jci/OzDfxH
	zD7i6mpQjepum+hLG6tVbQO83m7U0yYkSpSkDTuekvd5DZEVkxphx7daMUtjSK+1
	mtEYY2+3uLJ1aenJ7OL8sZEP96UqQMfvA6kfaZOgF8I/6VjZURAr1YMjwzZutYAj
	E3wAok4+XrH5QSJ/Ee5PoTmEg8O1x1FsSEUjTp4+TMwUxVYG3Z0xhFZoKRHf+wgf
	CVedIOgcnJKPCYJ5RzFQNWgDuEqlDCK6sukqeKt8Dr7AP6ayjzjTxqFWp+sXIMuZ
	WfMYXN7L/GdBdzAzLFr1+Dc+zCRaIX3AY9U8SFktJEllag==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dnAFi-96rd81; Mon, 15 Jun 2026 13:41:22 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gfB982DHJz1XM5kW;
	Mon, 15 Jun 2026 13:41:15 +0000 (UTC)
Message-ID: <88ccf330-28b9-4101-9f5f-c05130c75636@acm.org>
Date: Mon, 15 Jun 2026 06:41:14 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ufs: core: Add get_hba_nortt callback for
 vendor-specific RTT capability
To: ed.tsai@mediatek.com, alim.akhtar@samsung.com, avri.altman@wdc.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
 peter.wang@mediatek.com, alice.chao@mediatek.com, naomi.chu@mediatek.com,
 chun-hung.wu@mediatek.com
References: <20260615055802.105479-1-ed.tsai@mediatek.com>
 <20260615055802.105479-2-ed.tsai@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260615055802.105479-2-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24962-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,samsung.com,wdc.com,HansenPartnership.com,oracle.com,vger.kernel.org,gmail.com,collabora.com];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ed.tsai@mediatek.com,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:wsd_upstream@mediatek.com,m:peter.wang@mediatek.com,m:alice.chao@mediatek.com,m:naomi.chu@mediatek.com,m:chun-hung.wu@mediatek.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,acm.org:dkim,acm.org:email,acm.org:mid,acm.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 303AC686D49

On 6/14/26 10:57 PM, ed.tsai@mediatek.com wrote:
> The number of outstanding RTTs read from host controller capability
> register is problematic on some platforms. Add a new vendor callback
> get_hba_nortt() to allow platform vendors to override the default RTT
> capability value with platform-specific handling.
> 
> This patch keeps max_num_rtt field for bisectability and will be removed
> in a later patch once all platforms are migrated.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

