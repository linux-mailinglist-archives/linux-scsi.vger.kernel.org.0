Return-Path: <linux-scsi+bounces-25307-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YutrOAP5PmpsNwkAu9opvQ
	(envelope-from <linux-scsi+bounces-25307-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 00:11:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D96936D068A
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jun 2026 00:11:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jWkHjZCo;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25307-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25307-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DD563006932
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A53C1989;
	Fri, 26 Jun 2026 22:11:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79873AEF50;
	Fri, 26 Jun 2026 22:11:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511870; cv=none; b=sleeoDHi+QDVC7s16khrrbG2IM6uuuOw2tG48w1FlPn4TZKK+qi0MTxT6Xu/Vo66J290DyfbZYp5RCJ4SfvTb9gKt3qPDGuJWCJkUvW7Igu/Hvg7WRYKIWW7LSZIv074jXZTMuN+qbVUMfab0X1/Yp0lXBBnFN+aww4BWwwwaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511870; c=relaxed/simple;
	bh=7M/FugBfskShcz+XtHCrsu3r0ANsIj70ukxI+uLXXks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kE1vVrnutyKfqJ+SdYusVavrZxcnz82/JkuQbhfMDHYvpD/Kkc9hrTslLVpPeyQCcQumsu5BXKun7X826qsCvVf5+zHWDWXQeOUMRrIrOW6SHD7usO3AfbWRCyivEEw88ImWVuIoMV08Ccab3G2BvNbz6rFMM/ZumOFW0jGufHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWkHjZCo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FE31F000E9;
	Fri, 26 Jun 2026 22:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782511869;
	bh=L6FmC3VN1d8NuvhVjp6d49+V8pA1Iapf0CWeIDyTr6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jWkHjZCocYCauAXjfcwIQo7efn4kBoRbdRtZvggAODys47vLNUoGfpOpIG5A4H01C
	 Lcalsshmgv8+j8Iq9ZWuGBSFcIG1kRayTRK1OboKrpiaCUAoaUl2cpl3ug5m9e6FUk
	 L16SfxWl1m4Epk/PWTD/otGnkqcRw35D8Mm4dY9cr0U9OaDMyzlRiyS+6v3t9hzPdu
	 kXYiyG8Z1Opq9d2QkTHQgaVEYdvz+31ex3lws8sSQV+oWEbNvWFaFx/rpLtq/O/UWf
	 WoPVqXq0/g3AfzBuycltfBoDXWerH+5I6bdxBShYV+E8yG6drkvlqqcR+WU1zbQCp2
	 SVCiqe999tVuw==
Message-ID: <218133be-eca7-44ac-a9f6-81283c55185d@kernel.org>
Date: Sat, 27 Jun 2026 07:11:06 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Handle expander discovery allocation
 failures
To: Haoxiang Li <haoxiang_li2024@163.com>, john.g.garry@oracle.com,
 yanaijie@huawei.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, cassel@kernel.org, kees@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260623112909.2172701-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260623112909.2172701-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:cassel@kernel.org,m:kees@kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com,oracle.com,huawei.com,HansenPartnership.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-25307-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D96936D068A

On 6/23/26 20:29, Haoxiang Li wrote:
> sas_ex_discover_expander() allocates a domain device and SAS port before
> allocating the expander rphy, but it does not check all allocation and
> registration failures. In particular, sas_expander_alloc() can return
> NULL and the returned rphy is dereferenced unconditionally.
> 
> Add error handling for sas_port_alloc(), sas_port_add(), and
> sas_expander_alloc(), and unwind the resources allocated on each path.
> Use sas_port_free() before a port has been added and sas_port_delete()
> after it has been added.
> 
> Free the child device directly on these early failures because child->rphy
> has not been initialized yet, and sas_put_device() would dereference it.
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Looks OK. A couple of nits below.

> ---
>  drivers/scsi/libsas/sas_expander.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index f471ab464a78..56c04c4ae818 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -909,9 +909,11 @@ static struct domain_device *sas_ex_discover_expander(
>  		return NULL;
>  
>  	phy->port = sas_port_alloc(&parent->rphy->dev, phy_id);
> -	/* FIXME: better error handling */
> -	BUG_ON(sas_port_add(phy->port) != 0);
> -
> +	if (!phy->port)
> +		goto out_free_child;

For readability, a blank line would be nice here.

> +	res = sas_port_add(phy->port);
> +	if (res)
> +		goto out_free_port;
>  
>  	switch (phy->attached_dev_type) {
>  	case SAS_EDGE_EXPANDER_DEVICE:
> @@ -926,6 +928,9 @@ static struct domain_device *sas_ex_discover_expander(
>  		rphy = NULL;	/* shut gcc up */
>  		BUG();

can we drop this BUG() too so that instead of crashing we properly error unwind?

>  	}
> +	if (!rphy)
> +		goto out_delete_port;
> +
>  	port = parent->port;
>  	child->rphy = rphy;
>  	get_device(&rphy->dev);
> @@ -963,6 +968,19 @@ static struct domain_device *sas_ex_discover_expander(
>  	}
>  	list_add_tail(&child->siblings, &parent->ex_dev.children);
>  	return child;
> +
> +out_delete_port:
> +	sas_port_delete(phy->port);
> +	phy->port = NULL;
> +	kfree(child);
> +	return NULL;
> +
> +out_free_port:
> +	sas_port_free(phy->port);
> +	phy->port = NULL;
> +out_free_child:
> +	kfree(child);
> +	return NULL;
>  }
>  
>  static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)


-- 
Damien Le Moal
Western Digital Research

