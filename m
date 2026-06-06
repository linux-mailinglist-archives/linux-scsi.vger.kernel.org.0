Return-Path: <linux-scsi+bounces-24519-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nlFQE2aTJGqi8wEAu9opvQ
	(envelope-from <linux-scsi+bounces-24519-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Jun 2026 23:38:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956864E6AB
	for <lists+linux-scsi@lfdr.de>; Sat, 06 Jun 2026 23:38:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=kb3ZpW1D;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24519-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24519-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF60A30193B3
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Jun 2026 21:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D423101A6;
	Sat,  6 Jun 2026 21:38:42 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129E218ADD;
	Sat,  6 Jun 2026 21:38:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780781922; cv=none; b=fgXZo9A4gNdK7YMFL2vjWhqGd8I8bqn2AzqU/7xvOhi8SZoKhAm2f4MLKN9fOpybRizGsxm8Lz5zLyjvf7GLNhe9WE9F08v3gCY0JEMkha+0EFRx6XhaNeRdbKi9r2bQ8Kba0Z3M4ndiLFBIH/nQGDRKvkwtvcBSi1I5W/iuLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780781922; c=relaxed/simple;
	bh=th2anrzf31Q9eYbbC/St/bnu1dqbxVyP7dAolWSpaNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLgNjaKM5AUgyGHbr+ieMPoGqEdlo+R4fhpe9ZMBanmKK0xKJYtKvQ6Ey4v3Ze3SLw9u1d74LE+3t0EYEu0GKbpEbL4/kX7QI8UyiM7BqKdglRBfQQEGRd6cR8dDe1JTh75YnG+kjB56nFw4KLGB8GBaLGi2cDT1IQSEhQRJ06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kb3ZpW1D; arc=none smtp.client-ip=80.12.242.17
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id VyiqwzoTNPtxAVyiqwYEMg; Sat, 06 Jun 2026 23:38:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1780781911;
	bh=fRopwsI+LtIK+AcPNDztTFYPATnMaepA05vHYWcn6T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kb3ZpW1DJJe6PT6TxLDpSYXTddYxmjIJTffbwn/g+A85wCMcOuprOJJ0HvhXSHM86
	 +VC5zWV2XnFUqBXWQwzWYEdABrjn1+BT9g+rFB09F86UyaX69kYPiOoXicLWQBR2Fv
	 Wj+T0FamAUzPMftTgOvp0/ahiStHNZ/mjQbQKQA6fKM0/MZj40PmyDqS9mc3XPysdV
	 vs0WMpjHDZYrZvwlUDZFVqtaEor3/h+XJylUFbE4o9EzQHZfA5QfgUTZrXHOC9d0Im
	 wB9tcM/wob/6WxhwsRGw2AJTukUCb3IfUsHLDIwCSGeBYufZajEoHTo3MoVTv5gWYT
	 ARIDt6Go3heSg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 Jun 2026 23:38:31 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <1b1d419d-5974-4d15-8f5e-58050a83ce2e@wanadoo.fr>
Date: Sat, 6 Jun 2026 23:38:27 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/scsi/aic7xxx/aic7xxx_osm: Use kstrdup()
 instead of kmalloc() and strcpy()
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260606202633.5018-33-david.laight.linux@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20260606202633.5018-33-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24519-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:hare@suse.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5956864E6AB

Le 06/06/2026 à 22:26, david.laight.linux@gmail.com a écrit :
> From: David Laight <david.laight.linux@gmail.com>
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>   drivers/scsi/aic7xxx/aic7xxx_osm.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> index d93b522695eb..d6237aa5beac 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
> @@ -1101,12 +1101,10 @@ ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *templa
>   	ahc_lock(ahc, &s);
>   	ahc_set_unit(ahc, ahc_linux_unit++);
>   	ahc_unlock(ahc, &s);
> -	sprintf(buf, "scsi%d", host->host_no);
> -	new_name = kmalloc(strlen(buf) + 1, GFP_ATOMIC);
> -	if (new_name != NULL) {
> -		strcpy(new_name, buf);
> +	snprintf(buf, sizeof (buf), "scsi%d", host->host_no);
> +	new_name = kstrdup(buf, GFP_ATOMIC);

I think that kasprintf() would simplify code and do the same.

CJ

> +	if (new_name != NULL)
>   		ahc_set_name(ahc, new_name);
> -	}
>   	host->unique_id = ahc->unit;
>   	ahc_linux_initialize_scsi_bus(ahc);
>   	ahc_intr_enable(ahc, TRUE);


