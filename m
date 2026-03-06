Return-Path: <linux-scsi+bounces-21528-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Iw+LRQ5qmnUNQEAu9opvQ
	(envelope-from <linux-scsi+bounces-21528-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 03:16:52 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB621A84E
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 03:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BA77302418E
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2026 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D532E68F;
	Fri,  6 Mar 2026 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Fmb6MmUO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1CD2C237C;
	Fri,  6 Mar 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763408; cv=none; b=F2v0CLcKwQZVRlanEBj3KSKlV0YVKm0gk+DQpHPzf4ynIP/9yDgK9zTbJ2oi0xM2du1ucGvcR8nxgL6dxvRKlLYUOCeGJ0fNfWqRgQkYcsbmLzgytoEifxZgzdFGJaqynp6FZusb0BfhrUXBCzoPw8OFyjFiDNwYzH5xIgPluEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763408; c=relaxed/simple;
	bh=TgGMYh2DP+ijYv+4mXIdHZZry/vv5D3g9hz3pz4gUUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbnf4v4liHXeq3QfnAHs+GbGsMIGGXAtHhH8op1UqlZXMrG+pQALBpyJJ5QVJAO5KLtmelOPzi06wXLH1k999hiqG9sgw/YcIP8PvUQ7muR0UiHojMPlTHDukCotxFKGIrjTyA+A52f35i+rS9yiSN45M8SaeQYiMZFMH0qwCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Fmb6MmUO; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fRqlz0NRJzlh1TC;
	Fri,  6 Mar 2026 02:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772763403; x=1775355404; bh=TgGMYh2DP+ijYv+4mXIdHZZr
	y/vv5D3g9hz3pz4gUUg=; b=Fmb6MmUO9RTAb/zAArlRKoTXh9EVLjQQzSsAWOQX
	hslDxghfplk0YRi2ns3vbTRjmbfnlpQ0LTJ4v6vGFvOy4/3BTRybHKm6AKIOqltW
	RtXPOJIerQqy0HkY4hdpNGvXK1c41t20+3Hc9HHM1EA03h1Xgya7FPx9+qAY5Krb
	Ux/78eLp4OSGk14UMrsd3p8Y+VEY/NPhnJ8RQa9c/XmvXE2gcFBrXRTDwRQ+Hbh/
	xzqDxnhzm3ixaVNOJ/sTzdMbTudP9sd/takMpHJRuXozGZiOdW+W4bcLykgRFMIE
	KirPeiOul0KqYwrY3r6+YlIcGWyony6nwL7/+qKDvOWN/g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OMO8-5YPHm93; Fri,  6 Mar 2026 02:16:43 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fRqlr0VCrzlh1TF;
	Fri,  6 Mar 2026 02:16:39 +0000 (UTC)
Message-ID: <fee27e1f-ce3f-4a32-9eb1-4b97f6cde0fc@acm.org>
Date: Thu, 5 Mar 2026 20:16:38 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ufs: core: Add quriks for VCC ramp-up delay
To: ed.tsai@mediatek.com, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260305083610.2672344-1-ed.tsai@mediatek.com>
 <20260305083610.2672344-2-ed.tsai@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260305083610.2672344-2-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2FFB621A84E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,samsung.com,wdc.com,HansenPartnership.com,oracle.com,gmail.com,collabora.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21528-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:email,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Action: no action

On 3/5/26 2:29 AM, ed.tsai@mediatek.com wrote:
> On some platforms, the VCC regulator has a slow ramp-up time. Add a
> delay after enabling VCC to ensure voltage has fully stabilized before
> we enable the clocks.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


