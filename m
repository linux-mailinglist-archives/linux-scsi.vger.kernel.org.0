Return-Path: <linux-scsi+bounces-21037-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMwAGibYnWk0SQQAu9opvQ
	(envelope-from <linux-scsi+bounces-21037-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 17:56:06 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429D18A271
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C0ED3077152
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AC3A9014;
	Tue, 24 Feb 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3RBnv0ph"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388ED3A7F58
	for <linux-scsi@vger.kernel.org>; Tue, 24 Feb 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951841; cv=none; b=Z+PhqrCsHRGYh525iQwjFTX+yQLZHMGhtlT6oR1D/T2hNFx3R2zeA662E12uliY0ztzpyGiRXPHpi4lxToTIY1NW23RZzwEbjfSdlnhZDXB25TPDadqZ5dDKu4uDaeNKePVIYgO8edDJRcT86vfglQGWqR6durCB2A3DLTyNNJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951841; c=relaxed/simple;
	bh=RuBp3PIqrEuKdsun8ArySbSeNPdeTB2hEN6T+l6gBck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJNoo9GZ27ZLHPR5UF/f4PaRImNqSbDXxt8mAsNcfNGDhhzmyxSU547BgBtBQLdl3bsuR9YcafB39WQtJ6KAe/d1x5LPnWtYfqRxh+AY/DZCYIarcJc7PyDDDMTMsNu57sFGurIeNYOPnKZeuliy/Wv3oohnhmuVTude0Y4Xvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3RBnv0ph; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fL3cv6wzwz1XM6Jk;
	Tue, 24 Feb 2026 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1771951837; x=1774543838; bh=imNE9LSqxAsXf0PLioI06r2r
	MiKPpRxbdmCSUWVbDuA=; b=3RBnv0phPFNDUzCthEXChpqF8rH0l7CNU4FQIbOW
	Qk47J8ay4XZpxAR9dhCwpMjCVioTNqbqNRXuf5f8y44kuBlQ7HXzMJCRyK5YZhWd
	qXhD5gb9zn/GlcFu6PHyawNuQFICxeRhjbroML2/vF3qaB9ZiVO7Z52fadbpPpXp
	KEeYX3PDlcEZp8bSUzWC7SuZUl1xuLgNMRSGSxNChY/AhcUdfxg4XAUhVwHJYRqm
	aK5wXjROXOX+tRqGMRTgKE/6fdQSsRZuIon059AeC1Q0yeWZEDn4kftEzjJBI/bb
	4aciFV5U2e3abltohAAVI7hsLnRjAdIubSJjzIru24Lhjw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id alVYFKGJ_EM7; Tue, 24 Feb 2026 16:50:37 +0000 (UTC)
Received: from [172.20.150.38] (unknown [4.28.11.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fL3cl66qzz1XM6J7;
	Tue, 24 Feb 2026 16:50:31 +0000 (UTC)
Message-ID: <2d37bfc1-fb1b-4bf9-9195-fa02f73c029f@acm.org>
Date: Tue, 24 Feb 2026 08:50:31 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: Fix possible NULL pointer dereference in
 ufshcd_add_command_trace()
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@sandisk.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260223065657.2432447-1-peter.wang@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260223065657.2432447-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-21037-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim,acm.org:email]
X-Rspamd-Queue-Id: 1429D18A271
X-Rspamd-Action: no action

On 2/22/26 10:56 PM, peter.wang@mediatek.com wrote:
> Kernel log excerpt:
> [ ... ]
> 
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>

Bug fixes should have a Fixes: tag. Once that tag has been added, feel
free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


