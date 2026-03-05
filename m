Return-Path: <linux-scsi+bounces-21498-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAThC0x2qWl77wAAu9opvQ
	(envelope-from <linux-scsi+bounces-21498-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 13:25:48 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA4211952
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 13:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB433067B08
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2026 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30039A066;
	Thu,  5 Mar 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SZbaEMJQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54E372ED9;
	Thu,  5 Mar 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713261; cv=none; b=A9wAN/FDHO0cKkNspumnwjKOZStV1BotpArtvWj+3KtDeDYVh41NLFd/cQzj3maKIekG1ghMXHNIFDF/IHHASgDrCAYkiqIg4IMsX2UG5EmTjo9q2cLw/wtPfAgTZBuFDi9WEZyD0xUO2P03CLA4trtK/37Jbs/3yf80EvJyjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713261; c=relaxed/simple;
	bh=s2g6Qeaj3tkM2kpJNp/B0QXk+CcvvugYMYtG6LI7uFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecX48INzfTY+zDEjsCdHg87SSC3Qa+QcOSpt4ybFvuTr7o+qoohoImH67HRHnx+/atgAcQ8//ztGoyR5ZagzexiespQL8MRdiwKap5EnAHb380KtpmMkKn5V/qnAx3m0bNpz+9hwOxLnt3iRWH3CzGk84Po6KBED5ZJPCQlihTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SZbaEMJQ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fRTCc0SNFz1XM5kW;
	Thu,  5 Mar 2026 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772713255; x=1775305256; bh=VxlWN5VHxU2836UMOWl//1bZ
	U+D0OzhZKMnKSPhaYT0=; b=SZbaEMJQiSNKvzikXuJEpXYE3IOu9NrxZkkOIQu3
	Z8sRSVIzH4KxGjFNf3F34w+/bJwhaHPTavVGVcjyX2yA6D9XEPwDzGf4Z0jSCT5T
	J9mjFXvogOeF6uzEGdvo1THQ6mjcT3kUSgpxjhny46OfzmPb9kp82CtKc8OLGU+G
	yqYKJe/luExc6OMM6c18dwA8jnt9W+exne8kG3Ht2x0q2Dd9ZrhyhEFnN+DGMdGZ
	mgmZEhnrqVbJgQ1x4XhPA2hsyvFwwtDfqTBengvzCs50dr4II90r4ssu119UxKLl
	PcucoLXwh/PoRob+bSoyOUJrNEQAyyATgWpGvDj2FY10oA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id USyP4OT_KOKZ; Thu,  5 Mar 2026 12:20:55 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fRTCR58TDz1XM5kD;
	Thu,  5 Mar 2026 12:20:51 +0000 (UTC)
Message-ID: <f298d3f3-1382-478d-87f2-ae9b212001da@acm.org>
Date: Thu, 5 Mar 2026 06:20:49 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ufs: host: mediatek: Add VCC on delay for stability
To: ed.tsai@mediatek.com, Peter Wang <peter.wang@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Stanley Jhu <chu.stanley@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260305083610.2672344-1-ed.tsai@mediatek.com>
 <20260305083610.2672344-3-ed.tsai@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260305083610.2672344-3-ed.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C0FA4211952
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21498-lists,linux-scsi=lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,gmail.com,HansenPartnership.com,oracle.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

On 3/5/26 2:29 AM, ed.tsai@mediatek.com wrote:
> Introduced a delay after enabling UFS5 VCC for MT6995 to ensure
> voltage stability before refclk activation.

Patch descriptions should use the imperative mood (Introduced ->
Introduce).

> +	/*
> +	 * Add a delay after enable UFS5 VCC to ensure the voltage is
> +	 * stable before the refclk enable.
> +	 */

after enable -> after enabling
refclk enable -> refclk is enabled

Otherwise this patch looks good to me.

Thanks,

Bart.

