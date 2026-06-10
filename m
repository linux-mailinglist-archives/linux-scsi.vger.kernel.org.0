Return-Path: <linux-scsi+bounces-24654-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AokSI4CQKWquZgMAu9opvQ
	(envelope-from <linux-scsi+bounces-24654-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 18:27:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D48766B767
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 18:27:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=W5lGVwD4;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24654-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24654-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D68316F3E5
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D643306B08;
	Wed, 10 Jun 2026 16:19:16 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BA2FE056;
	Wed, 10 Jun 2026 16:19:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108356; cv=none; b=af5KJtWGSJAkhJrXLXLU8jXotNxIiedVGnFCazq9wkFQ8UkWzjEOsMEOT/bPm3WEoUhkL90BBIqPHuIcm4XYCfh0sRuCxS95+bJdlDL4MxeFfVHBFjDVOCvkntlO65B3e4WnJVDqbZHqqbkzjjrNegYW7+pq30Ud3J35jay5cGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108356; c=relaxed/simple;
	bh=5+iSWpXr2CnR85Fhrd14dIO7ZwkH4DoPjLCETONjDhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8TB1I9bRCw/dDlyzqOwSac6LCYO+9VuGIAas7I7bplXFKboUtufOTEfaaoRGt0CMQT7sxRnQb1vKlzwNUiaiWdbr7S78lvM5rgH3biqZ5FNELt+1nDjKYejF9MO/7OI/UGP6zJ+rMZ7Q3wKFRWZaV7C1FV7fNtkQOmhAhjHcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W5lGVwD4; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gb9vk5yHDz1XLyhV;
	Wed, 10 Jun 2026 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781108350; x=1783700351; bh=xfHa9RuC2nGVQeuWNKXTunXF
	zBkwGqnU+KCmJdSTHR4=; b=W5lGVwD4eJR9E3h/dqFI4fFevnrEqeetxMs8rbwB
	KnkCOMpNG9VJSNJrWjo/AUKkpA/iiXt+bcJsZO7CapnlnLXQvAF7bbA+2oLnHPpF
	BJbVDz5+7qi9JcLZMbnjQIzDmtwFhT5rI9F0jA8lg4hlyfVLt1tiwbBRbKr+yDaP
	YHtaxfbYaY6GhZpQcOn9vXzgNbTg9vZPcvztfV6LagGWaS10ztQnXXec5K5CRfFs
	b5iuUBPVPudCmsOPUJhVBg+FGhmV2X+AbgOxOaZX69gyXEJiYqwIrEM1fLJinqFk
	TElG4GhbyK+7GqO3ITwJaPLh2p5JR87zTu6Rs28VYuSDVA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id naQvPif2iLkO; Wed, 10 Jun 2026 16:19:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gb9vd0Rfyz1XLyhS;
	Wed, 10 Jun 2026 16:19:08 +0000 (UTC)
Message-ID: <8a07bac5-7083-4cf2-966a-2d5281e52a2a@acm.org>
Date: Wed, 10 Jun 2026 09:19:08 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] scsi: Improve style of pnp_device_id array terminator
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Finn Thain <fthain@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <096aaa981c0bf1aaa8be75e675f17b1c9ca0086c.1781102092.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <096aaa981c0bf1aaa8be75e675f17b1c9ca0086c.1781102092.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24654-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,HansenPartnership.com,oracle.com,linux-m68k.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:fthain@linux-m68k.org,m:schmitzmic@gmail.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,acm.org:dkim,acm.org:email,acm.org:mid,acm.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D48766B767

On 6/10/26 7:36 AM, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
> index fd766282d4a4..93dab19c1cb9 100644
> --- a/drivers/scsi/aha1542.c
> +++ b/drivers/scsi/aha1542.c
> @@ -1083,7 +1083,7 @@ static int isa_registered;
>   #ifdef CONFIG_PNP
>   static const struct pnp_device_id aha1542_pnp_ids[] =3D {
>   	{ .id =3D "ADP1542" },
> -	{ .id =3D "" }
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(pnp, aha1542_pnp_ids);
>  =20
> diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
> index 270eae7ac427..41731a7304dd 100644
> --- a/drivers/scsi/g_NCR5380.c
> +++ b/drivers/scsi/g_NCR5380.c
> @@ -739,7 +739,7 @@ static struct isa_driver generic_NCR5380_isa_driver=
 =3D {
>   #ifdef CONFIG_PNP
>   static const struct pnp_device_id generic_NCR5380_pnp_ids[] =3D {
>   	{ .id =3D "DTC436e", .driver_data =3D BOARD_DTC3181E },
> -	{ .id =3D "" }
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(pnp, generic_NCR5380_pnp_ids);

Although in general I'm not a fan of code cleanups for legacy drivers, I
like this change. Hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


