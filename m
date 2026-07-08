Return-Path: <linux-scsi+bounces-25878-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DIqHIcXHTWqN+AEAu9opvQ
	(envelope-from <linux-scsi+bounces-25878-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 05:45:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8772177D
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 05:45:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XCNT8SF9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25878-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25878-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355A1303B7D8
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2026 03:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591B3271FD;
	Wed,  8 Jul 2026 03:39:31 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F78374A06;
	Wed,  8 Jul 2026 03:39:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481971; cv=none; b=E4iTqKNDPnXU/GQYlf8ZY0Vi0UpBXSII0VB7JbDtTn+yyws/QzPgt4bTu4+q5lOWJZ35E36HGAVv+e1UGyaJ81w6dnLjDw7IeOVBvMm4lXh7mEHXOAlKFhd94/0r/3JOwin+Biqeewa2KLHmZEg6Q0OKBZeUtcjnF33IGvp0bSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481971; c=relaxed/simple;
	bh=Kt8tZ/4wO1dXg76E5TlyJ+51bSNyWj52gERhlSa4tuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqWdyFOBlT8ukyNsNDSlxWbULIcxyTF7Zu1wM/sFIklDa/K/2NrkpaWQAldpGPGWC47i+H/Da3RKNTGrdryUuzTc7ps4Nd1ZROECeDlkqLHdZXsjqYBr1c9QbWPWhK5yjXN8l8W4GDyWOel/vrCUt32ZmIhjKGTAUunAGpEVhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCNT8SF9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E9F1F000E9;
	Wed,  8 Jul 2026 03:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783481970;
	bh=BKcHYxFYEx8dif9aiXtS0RTXpU5/aPBrv6j4taiR2Pw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XCNT8SF9KAS2YcXsJorjnW/RZlERe/VXLqeJG8g/erxtMQqnQ00stY0xrVUyxdsgT
	 mh9oiIM8L9HULwDH0Pyk+s4FaM+VcrU5fp5IacLBOQfGbxF/zJKVlnDDBbVCqGgX6t
	 6LnDSkk4wveMdQfB5TDtipjsDmrA8Pp8ZGR3Qt90VQyZXOfPjoF9/VzBmXaXOiB0GL
	 bEEJehC0SbGsYaI5C0CFRlNfSyD3QYz3jJd/k+joZSnCFJqq8Jd63vT2AFDJbugQnp
	 wLQQnklLO3uqKc676VIqV3nKaI/yk90r2D6TL+3gVsOCPR8WjnhUws/YEMLL2eAXCv
	 5xtrNUTC2H5VA==
Message-ID: <a19a428e-9e66-42ea-b95c-f4954b67ac87@kernel.org>
Date: Wed, 8 Jul 2026 12:39:17 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: sd: fix error handling for sd_large_pool_create()
 call failure
To: John Garry <john.garry@linux.dev>, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com
Cc: p.raghav@samsung.com, sw.prabhu6@gmail.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
References: <20260707105555.1382237-1-john.garry@linux.dev>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260707105555.1382237-1-john.garry@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25878-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.garry@linux.dev,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:p.raghav@samsung.com,m:sw.prabhu6@gmail.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:john.g.garry@oracle.com,m:swprabhu6@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,gmail.com,vger.kernel.org,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEF8772177D

On 7/7/26 19:55, John Garry wrote:
> If the sd_probe() -> sd_large_pool_create() call fails, then we incorrectly
> unwind the probe actions.
> 
> Currently for the sd_large_pool_create() failure we do no undo the
> device_add() call.
> 
> Fix this by mimicking the handling of device_add_disk() failure, in calling
> device_unregister() and put_disk(). The device_unregister() call will
> result in scsi_disk_release() being called, which unwinds many actions in
> sd_probe().
> 
> Fixes: 7179e626b76e ("scsi: sd: Enable sector size > PAGE_SIZE in SCSI sd driver")
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Xiuwei posted a series fixing this already:

https://lore.kernel.org/all/20260707030333.22245-1-yangxiuwei@kylinos.cn/

> ---
> I do wonder if it is simpler to always create this pool when we can
> support LBS. We only create a min of two elements in the pool, so
> hardly large.
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 599e75f33334..d18693d390b2 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -4089,7 +4089,9 @@ static int sd_probe(struct scsi_device *sdp)
>  	if (sdp->sector_size > PAGE_SIZE) {
>  		if (sd_large_pool_create()) {
>  			error = -ENOMEM;
> -			goto out_free_index;
> +			device_unregister(&sdkp->disk_dev);
> +			put_disk(gd);
> +			goto out;
>  		}
>  	}
>  


-- 
Damien Le Moal
Western Digital Research

