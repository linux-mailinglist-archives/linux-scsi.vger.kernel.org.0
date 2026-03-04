Return-Path: <linux-scsi+bounces-21430-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OX1DbtIqGnysQAAu9opvQ
	(envelope-from <linux-scsi+bounces-21430-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Mar 2026 15:59:07 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3904202186
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Mar 2026 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03AE43029E61
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Mar 2026 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400C3B3BE6;
	Wed,  4 Mar 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DNYvJYyK"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDA6FC3
	for <linux-scsi@vger.kernel.org>; Wed,  4 Mar 2026 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635767; cv=none; b=bimUNEFAxJuPTRXbz6qUdC4T2H31YRwPqemmuqdmIMSowFHpkzXbgRLiz/X4+hvRMfrleKOPlpq7snGUqUfT8kZS012hv58UHyL0KoLU7KSXVd41FK72mdeLdbtSXxNb0R4oiu5D0C7Z55Z53dfpXuvSnRsteXtC3UFQiyywx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635767; c=relaxed/simple;
	bh=BKI2QIbr+g1lW3u3Qa4fW/ypTlasuNqqD82pEtBdJjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDMWHtN2EGEaaCsbaUaXmUWHVnQf0TQmg+ToRdRwICLa9jUsgcAPGA4FoC+fJ3RPw5tFQwHk6MHoFCwys/Fvoy1CE8b3z9BB1rEjb8XX+a31m5oPKuDmyn5Smk/2McHEnz6+qWARf1jlhq5N9atDaMDe1x8Vllpf+FwxnKOSXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DNYvJYyK; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fQwYJ4L64zlfpMC;
	Wed,  4 Mar 2026 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772635761; x=1775227762; bh=BKI2QIbr+g1lW3u3Qa4fW/yp
	TlasuNqqD82pEtBdJjs=; b=DNYvJYyKRgFACLQs87aAhuSc8xybTURAQU4syhqP
	T/BdAK95QdGkmZ3C+74GxQkLzOh9oaYsebmX4+VGGYqHVKOtuOqI3iOm3G1ttcWs
	nfRN/iHLwZJhHt2pxyH4SaOCLGVfSmPkUPIMNhgriFC2XQObp6c6coufzbjZkd0S
	IIdndxfO5/bY72NP8ZlsdCbeZ+ZyeHgybEgm9W/IkEMRix2r1CrHSQoIBP13GRxT
	O32C/aSfquJEVlVEp5swlwUuouZBfLgHXnWIbEyZMY5bw5ek/03404rZx48f6XhW
	FyMcynMAEMHVMCQYVEvgOlfnTXBYCPZz/lsvzxYL+gK9FQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1CjT3ML-oGW6; Wed,  4 Mar 2026 14:49:21 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fQwYC59jzzlfvpL;
	Wed,  4 Mar 2026 14:49:19 +0000 (UTC)
Message-ID: <4396a908-a205-4473-b26f-d4f1aaa52673@acm.org>
Date: Wed, 4 Mar 2026 08:49:17 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0/scsi-fixes] scsi: core: fix error handling for
 scsi_alloc_sdev()
To: Junxiao Bi <junxiao.bi@oracle.com>, linux-scsi@vger.kernel.org
Cc: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
 michael.christie@oracle.com, john.g.garry@oracle.com
References: <20260303213233.43166-1-junxiao.bi@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260303213233.43166-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D3904202186
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21430-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,acm.org:dkim,acm.org:mid]
X-Rspamd-Action: no action

On 3/3/26 3:32 PM, Junxiao Bi wrote:
> scsi_sysfs_device_initialize() was already invoked when
> scsi_realloc_sdev_budget_map() fail, it will need invoke
> __scsi_remove_device() to do the error handling.

That's too vague. The description should mention that after
scsi_sysfs_device_initialize() has been called,
error paths must call __scsi_remove_device().

Otherwise this patch looks good to me.

Thanks,

Bart.

