Return-Path: <linux-scsi+bounces-24696-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RmEaM/xTKmrbnQMAu9opvQ
	(envelope-from <linux-scsi+bounces-24696-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 08:21:48 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C266EFB2
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 08:21:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TwB1Eq45;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3OZnb0oq;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TwB1Eq45;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3OZnb0oq;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24696-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24696-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DBB30D3C2D
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75035C190;
	Thu, 11 Jun 2026 06:21:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8C2BD58A
	for <linux-scsi@vger.kernel.org>; Thu, 11 Jun 2026 06:21:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158898; cv=none; b=U88s3q430oMHL45Mlk/KThH5kku70PiTVOjaX1GyfdaOOoSLnDOk8SKpH1YCdZygkaQZvOKqEwF5adkXIQxUl3zhhs5I6FVvLEAwvZ8gkTwzEbdId5X4NEnmgX6c4iDgLWQxJnsGeBp/waEdWcio1syd+XuG8Q+etAnPR0xEzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158898; c=relaxed/simple;
	bh=RZIWCXDGCxLA6bpVCcimJy+fR/Ifh5AlhmLEVNxUMd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8DreOg/LfFz7tNrIOKlTVcXSJoKUxpM9yxTlgZovcUNiZl/2rt0XDAjMrVnlhOD4L4uaKibIRnHlCaigCnR999eqDsyTad0VOhzu8zyXCeRTuzZVkXfp75aSMDpzwmNC2QH82U6y6D+jbEUG4Q/85HRJFKRAY0hpGphGr8oWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TwB1Eq45; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3OZnb0oq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TwB1Eq45; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3OZnb0oq; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3652B7596A;
	Thu, 11 Jun 2026 06:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781158889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgT3rUnYmtJQrYVp8HCUrtuFBH8fCvf5EqNgZfuewyo=;
	b=TwB1Eq45HxQ074o7OXD+/9UjBJdYDdEcEPzvPLa7D3rhtRbOcCuIpBRSpL8V8NkMqBIYy8
	7Vx3tgYC8B0CiT0bLhlyN0y+1qwKpHUF93PrhcfWndxrD+rumth5k2Jl8Bua6GVwiqb/N/
	iic+W2ki4fkVtJ+HAOUfwLJLZE1/L+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781158889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgT3rUnYmtJQrYVp8HCUrtuFBH8fCvf5EqNgZfuewyo=;
	b=3OZnb0oq7YBcBevd9GsX4MAjmeX8L9qHVPcvQAqeRrQJ9uxgDH0sqETmiaVYlzi0+MK5gw
	lSUEOPmy/+ojItDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781158889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgT3rUnYmtJQrYVp8HCUrtuFBH8fCvf5EqNgZfuewyo=;
	b=TwB1Eq45HxQ074o7OXD+/9UjBJdYDdEcEPzvPLa7D3rhtRbOcCuIpBRSpL8V8NkMqBIYy8
	7Vx3tgYC8B0CiT0bLhlyN0y+1qwKpHUF93PrhcfWndxrD+rumth5k2Jl8Bua6GVwiqb/N/
	iic+W2ki4fkVtJ+HAOUfwLJLZE1/L+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781158889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgT3rUnYmtJQrYVp8HCUrtuFBH8fCvf5EqNgZfuewyo=;
	b=3OZnb0oq7YBcBevd9GsX4MAjmeX8L9qHVPcvQAqeRrQJ9uxgDH0sqETmiaVYlzi0+MK5gw
	lSUEOPmy/+ojItDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D74779A7;
	Thu, 11 Jun 2026 06:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id olJaN+hTKmrybgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 11 Jun 2026 06:21:28 +0000
Message-ID: <1e3c81e4-fd22-49fb-87cf-194705b2d11d@suse.de>
Date: Thu, 11 Jun 2026 08:21:28 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] ata: libata-scsi: convert dev->sdev to per-LUN
 array
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260611024356.2769320-1-philpem@philpem.me.uk>
 <20260611024356.2769320-3-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260611024356.2769320-3-philpem@philpem.me.uk>
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
	TAGGED_FROM(0.00)[bounces-24696-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,philpem.me.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 625C266EFB2

On 6/11/26 04:43, Phil Pemberton wrote:
> Multi-LUN ATAPI devices (PD/CD combos, CD changers) share a single
> ata_device but expose multiple scsi_devices.  The previous single
> dev->sdev pointer could only track one LUN, making all other LUNs
> invisible to code that operates on sdevs: port detach, suspend/resume,
> ACPI uevent, ZPODD, media change notification, and EH teardown.
> 
> Replace the scalar struct scsi_device *sdev with a fixed-size array
> dev->sdev[ATAPI_MAX_LUN] indexed by LUN number, where ATAPI_MAX_LUN
> is 8 (the SCSI-2 ceiling, LUN values 0..7).  All callers are updated
> to iterate the full array and skip NULL slots; only populated LUN slots
> are ever non-NULL so single-LUN devices (the vast majority) see no
> change in behaviour.
> 
> Add an inline helper ata_dev_scsi_device(dev, lun) that returns
> dev->sdev[lun] guarded by a WARN_ON_ONCE(lun >= ATAPI_MAX_LUN) bounds
> check.  Use it for the hardcoded LUN-0 references in libata-acpi
> (uevent kobj), libata-zpodd (disk events, wake notify for all LUNs),
> and the door-lock and OF-node paths in libata-scsi.
> 
> Key changes per call site:
>    - ata_scsi_dev_config:    bounds-check lun, assign sdev to dev->sdev[sdev->lun]
>    - ata_scsi_sdev_destroy:  clear per-LUN slot; trigger ATA detach only
>                              when the last populated LUN is destroyed
>    - ata_port_detach:        iterate all ATAPI_MAX_LUN slots descending;
>                              clear dev->sdev[lun] before unlock to close
>                              the UAF window (Hannes Reinecke)
>    - ata_scsi_offline_dev:   iterate all slots
>    - ata_scsi_remove_dev:    snapshot all LUN slots then remove outside lock
>    - ata_scsi_media_change_notify: send event to all populated LUNs
>    - ata_scsi_dev_rescan:    snapshot all LUNs under lock, then resume and
>                              rescan each; release remaining refs on early exit
>    - ACPI, ZPODD, door-lock: use ata_dev_scsi_device(dev, 0)
>    - ZPODD disk-events:      iterate all LUNs for enable/disable and wake
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/ata/libata-acpi.c  |   9 +-
>   drivers/ata/libata-core.c  |  11 ++-
>   drivers/ata/libata-scsi.c  | 164 +++++++++++++++++++++----------------
>   drivers/ata/libata-zpodd.c |  27 ++++--
>   include/linux/libata.h     |  10 ++-
>   5 files changed, 138 insertions(+), 83 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

