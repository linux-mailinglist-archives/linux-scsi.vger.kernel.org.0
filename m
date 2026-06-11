Return-Path: <linux-scsi+bounces-24697-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UeD4CiBUKmrhnQMAu9opvQ
	(envelope-from <linux-scsi+bounces-24697-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 08:22:24 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37766EFC2
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 08:22:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="q/5s1/KJ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SCyGubdH;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uEAucPak;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N8uM98vE;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24697-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24697-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6076C3049FFC
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 06:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312D35C190;
	Thu, 11 Jun 2026 06:22:16 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD23346AE8
	for <linux-scsi@vger.kernel.org>; Thu, 11 Jun 2026 06:22:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158936; cv=none; b=uRo0E1wKE1KSLtTZh8Is7GPezpQE453B665dImRHHld4mAT1N7uix0QQ9hIku6Kh5oEadJwiJ5mC5MCUJCFwd9rzyoSbFBBiztiJgNIsQInm07+oM0ajEzCeAeWgIwNT+KXqAT2lbb6raqswUfmF3tJrqzTw4M0wN65f8mhZsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158936; c=relaxed/simple;
	bh=OfSFJnsiWpPNdzVOwRUzv6mJVNHRdZFxxejcPMVgGsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRjb4b0Yq6224neOUZ26AIcLBU5NtdhBSsuzb+SgiVAWRrFbQ1ginvYv1hTca8++Cd1UyERdM5DjeTgjkmqRW4xVsV4AL8wlDMNQzZXWqMcGBo4h1MnhMCxQi9NxxtsasbPfOe+2BcQ7uzW5tZnrwQVdrnm3paCOs3Jp2a8RYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q/5s1/KJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SCyGubdH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uEAucPak; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N8uM98vE; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C84956AF23;
	Thu, 11 Jun 2026 06:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781158933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaPVAJKQE+WamK90I3PEnWONi9ufq8nA3zt2PV9zgE0=;
	b=q/5s1/KJT3Rp1JX1LhI6CYkPcyqMXm8UuGGpqMN5fuA4yWOZ9gE1y9uz2EqiQQkv45I7YO
	M/wml8pcLVjTGbmMEVqGQS+27DDAvTP257qzVB/j251KrjJRPPTvvRwUVKciZ4/t2NGGrl
	eYLle68RqLfeQH1blxxusCCFpyZMM2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781158933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaPVAJKQE+WamK90I3PEnWONi9ufq8nA3zt2PV9zgE0=;
	b=SCyGubdH8HzdG0iQ+9DflpBd5gGnmxjjw6Rd7eTYGYlF3c50Arwjd7o4zjl36g+FvuT4dj
	6Sf+Ec5VpVJoYhDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781158931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaPVAJKQE+WamK90I3PEnWONi9ufq8nA3zt2PV9zgE0=;
	b=uEAucPak39hEi4haK/A/nLMETNdwDXjmd+7CvZhN0e4LbY0QYP23/VMbLqqgcVvhG8s9vr
	WwPr8lC+an8zkKNbujSu+L/RPmMpZU89kRAaUNucZvitRY1m1ymDd7yw0hpqlvy5w7JzkP
	Te/wvyWgC/OHMMbUjLCglHhxz8NaeA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781158931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaPVAJKQE+WamK90I3PEnWONi9ufq8nA3zt2PV9zgE0=;
	b=N8uM98vEwDMWKcnfbJOJnE0aM8+pOKnh9MJFa3s34e/LVUfJR5vIZ6DzwCmYmnauONtBU4
	ZPQFth9RqxaMzsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F646779A7;
	Thu, 11 Jun 2026 06:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5GMxHRNUKmoIcAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 11 Jun 2026 06:22:11 +0000
Message-ID: <da054cb5-2899-44f0-91b3-967f12feaa38@suse.de>
Date: Thu, 11 Jun 2026 08:22:11 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN
 ATAPI device quirk
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260611024356.2769320-1-philpem@philpem.me.uk>
 <20260611024356.2769320-7-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260611024356.2769320-7-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24697-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:philpem@philpem.me.uk,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,philpem.me.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB37766EFC2

On 6/11/26 04:43, Phil Pemberton wrote:
> The Compaq PD-1 (and equivalent Panasonic LF-1195C) is a combination
> PD/CD-ROM drive that exposes two LUNs: LUN 0 is the CD-ROM and LUN 1
> is the PD (Phase-change rewritable) drive.
> 
> Add a scsi_devinfo entry with BLIST_FORCELUN to enable multi-LUN
> scanning, BLIST_SINGLELUN to prevent issuing LUN-aware commands
> simultaneously, and BLIST_NO_LUN_1F to suppress spurious "No Device"
> entries for unpopulated LUNs (which respond with PQ=0/PDT=0x1f).
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/scsi/scsi_devinfo.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index 68a992494b12..bfc2cbd43897 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -150,6 +150,8 @@ static struct {
>   	{"COMPAQ", "MSA1000", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD},
>   	{"COMPAQ", "MSA1000 VOLUME", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD},
>   	{"COMPAQ", "HSV110", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
> +	{"COMPAQ", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN |
> +				 BLIST_NO_LUN_1F},
>   	{"DDN", "SAN DataDirector", "*", BLIST_SPARSELUN},
>   	{"DEC", "HSG80", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
>   	{"DELL", "PV660F", NULL, BLIST_SPARSELUN},

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

