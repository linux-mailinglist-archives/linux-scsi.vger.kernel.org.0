Return-Path: <linux-scsi+bounces-23777-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG6rOId4BGqiKQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23777-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 15:11:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80718533BC6
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 15:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FBD2305918E
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CC027C162;
	Wed, 13 May 2026 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wY+yLra3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LD1Z/9m3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wY+yLra3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LD1Z/9m3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A2286D57
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677665; cv=none; b=bR2NhxeM8uPR6Kjm/P6yfitZlreOT+YgiwIa8zC/lI/j2cC6ELjaogr3AGzMNJPRf6JLlPTgr4Cv3DGNbOlpmrB9loG8ZsWbS9mXuG8rYRUW6K21866xoN9jpRbKSWCux+mmqW+BrW1/v+lEerNfU2xOI4APvkEQ82XZrxsuzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677665; c=relaxed/simple;
	bh=jpJ8jiK9qSPMmtsxq7fGXJiJpUt1/XcLckJgMei7/8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OESIvqxFrt5M0HE5j75glMBcp9LCuc9bGuKT0vrZPBPIhEMjHzIPUAmSszza/0EBua8r112sc5qWbtr0jBHqvJofS56AjjbTT4sfnWxeQQKAjrXyOnJObV2vaZKKBe0e/Vq3NHR6vPMic9x56laEyXTjrgjI0EzAt32B9YQtNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wY+yLra3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LD1Z/9m3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wY+yLra3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LD1Z/9m3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38B9D6A9A5;
	Wed, 13 May 2026 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778677661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNWGbcmeBE1N0Cw7hhgmCqKp1+dV7l6/0y+bdpcAjdA=;
	b=wY+yLra3UZ8MsA44i4RXugSBm3tUf80U//spY1Udhy1v+2x0RfIdrdp78j+AKY7gWMjg2O
	hxxWvTG3XvqHxP3tSKa6swL9iak2wolIgry+h0YKIYLkxybUK+kYt5VV1RM4SjX3Ml8j+v
	FFia/VULsiZl1HuxZiEWRqaKzhFygoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778677661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNWGbcmeBE1N0Cw7hhgmCqKp1+dV7l6/0y+bdpcAjdA=;
	b=LD1Z/9m3L/ZaIqoonfZlgB3lGlWWOhegk1FTsRDh67lVCGGybnsz9XmOk2IPVGSJnEaxue
	NWb1G6QM5hv1CfCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778677661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNWGbcmeBE1N0Cw7hhgmCqKp1+dV7l6/0y+bdpcAjdA=;
	b=wY+yLra3UZ8MsA44i4RXugSBm3tUf80U//spY1Udhy1v+2x0RfIdrdp78j+AKY7gWMjg2O
	hxxWvTG3XvqHxP3tSKa6swL9iak2wolIgry+h0YKIYLkxybUK+kYt5VV1RM4SjX3Ml8j+v
	FFia/VULsiZl1HuxZiEWRqaKzhFygoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778677661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNWGbcmeBE1N0Cw7hhgmCqKp1+dV7l6/0y+bdpcAjdA=;
	b=LD1Z/9m3L/ZaIqoonfZlgB3lGlWWOhegk1FTsRDh67lVCGGybnsz9XmOk2IPVGSJnEaxue
	NWb1G6QM5hv1CfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12023593A9;
	Wed, 13 May 2026 13:07:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hhX0A513BGrESAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 13 May 2026 13:07:41 +0000
Message-ID: <3ac8578f-e6c4-4655-ac1e-5e61763ab023@suse.de>
Date: Wed, 13 May 2026 15:07:40 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] ata: libata-scsi: convert dev->sdev to per-LUN
 array
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260512202728.299414-1-philpem@philpem.me.uk>
 <20260512202728.299414-3-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260512202728.299414-3-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Rspamd-Queue-Id: 80718533BC6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23777-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,philpem.me.uk:email]
X-Rspamd-Action: no action

On 5/12/26 22:27, Phil Pemberton wrote:
> Multi-LUN ATAPI devices (PD/CD combos, CD changers) share a single
> ata_device but expose multiple scsi_devices.  The previous single
> dev->sdev pointer could only track one LUN, making all other LUNs
> invisible to code that operates on sdevs: port detach, suspend/resume,
> ACPI uevent, ZPODD, media change notification, and EH teardown.
> 
> Replace the scalar struct scsi_device *sdev with a fixed-size array
> dev->sdev[ATAPI_MAX_LUN] indexed by LUN number, where ATAPI_MAX_LUN
> is 8 (the SCSI-2 ceiling, LUN values 0..7).  Add a companion field
> dev->nr_luns recording the number of valid entries -- defaults to 1
> during ata_dev_init() and is bumped during multi-LUN probe -- so the
> common single-LUN case iterates one slot, not eight.
> 
> Add an inline helper ata_dev_scsi_device(dev, lun) that returns
> dev->sdev[lun] guarded by a WARN_ON_ONCE(lun >= dev->nr_luns) bounds
> check.  Use it for the hardcoded LUN-0 references in libata-acpi
> (uevent kobj), libata-zpodd (disk events, wake notify), and the
> door-lock and OF-node paths in libata-scsi.
> 
> Key changes per call site:
>    - ata_scsi_dev_config:  assign sdev to dev->sdev[sdev->lun]
>    - ata_scsi_sdev_destroy: clear dev->sdev[sdev->lun]; only trigger
>      ATA-level detach when LUN 0 is destroyed, since removing a higher
>      LUN should not tear down the underlying ATA device
>    - ata_port_detach:  iterate dev->nr_luns slots (high->low)
>    - ata_scsi_offline_dev:  iterate dev->nr_luns slots
>    - ata_scsi_remove_dev:  snapshot and remove all LUN slots, then
>      scsi_remove_device each one outside the lock
>    - ata_scsi_media_change_notify:  send event to all populated LUNs
>    - ata_scsi_dev_rescan:  resume and rescan each populated LUN
>    - ACPI, ZPODD, ofnode, door-lock:  use ata_dev_scsi_device(dev, 0)
> 
> For single-LUN devices (the vast majority) only dev->sdev[0] is ever
> populated and dev->nr_luns stays at 1, so existing call paths see no
> change in behaviour.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/ata/libata-acpi.c  |   6 +-
>   drivers/ata/libata-core.c  |  11 ++-
>   drivers/ata/libata-scsi.c  | 151 +++++++++++++++++++------------------
>   drivers/ata/libata-zpodd.c |   6 +-
>   include/linux/libata.h     |  11 ++-
>   5 files changed, 103 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 4433f626246b..8af35d0b1053 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -153,8 +153,10 @@ static void ata_acpi_uevent(struct ata_port *ap, struct ata_device *dev,
>   	char *envp[] = { event_string, NULL };
>   
>   	if (dev) {
> -		if (dev->sdev)
> -			kobj = &dev->sdev->sdev_gendev.kobj;
> +		struct scsi_device *sdev = ata_dev_scsi_device(dev, 0);
> +
> +		if (sdev)
> +			kobj = &sdev->sdev_gendev.kobj;
>   	} else
>   		kobj = &ap->dev->kobj;
>   
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4408b1fb48c7..1cb159d9dbc7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5564,6 +5564,7 @@ void ata_dev_init(struct ata_device *dev)
>   	dev->pio_mask = UINT_MAX;
>   	dev->mwdma_mask = UINT_MAX;
>   	dev->udma_mask = UINT_MAX;
> +	dev->nr_luns = 1;
>   }
>   
>   /**
> @@ -6275,11 +6276,15 @@ static void ata_port_detach(struct ata_port *ap)
>   	/* Remove scsi devices */
>   	ata_for_each_link(link, ap, HOST_FIRST) {
>   		ata_for_each_dev(dev, link, ALL) {
> -			if (dev->sdev) {
> +			int lun;
> +
> +			for (lun = dev->nr_luns - 1; lun >= 0; lun--) {
 > +				if (!dev->sdev[lun])> +					continue;

That looks so weird.
The 'sdev' array has the size ATAPI_MAX_LUN, so ->nr_luns should
never be larger than that.
_And_ you are checking for the pointer directly.
So why do you have 'dev->nr_luns'?
Wouldn't it be easier to use ATAPI_MAX_LUN as the upper limit,
and do away with 'nr_luns' completely?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

