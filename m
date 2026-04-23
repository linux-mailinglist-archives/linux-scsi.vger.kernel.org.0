Return-Path: <linux-scsi+bounces-23246-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMjRGjP96WmeqwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23246-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 13:06:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481B451112
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2F2F300A59D
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B643E6395;
	Thu, 23 Apr 2026 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0+9HFVa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yt4k+6RQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0+9HFVa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yt4k+6RQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC273E639D
	for <linux-scsi@vger.kernel.org>; Thu, 23 Apr 2026 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942345; cv=none; b=FYZU1Y2EhIsNP+mFuNvTWYjLGx800UybW+MZmXmcFNO+VtMkmmvwLr9WpwuWT5cUBLJPoN3DY+KUstiX9AfIfOXT+XVrLn44CLtRwH4LWwbB2CojYHaoeFksGhUVsDHf1b3LZEaTGpJoqSC8Hd325aRkINFr903xXufWHFy4Gmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942345; c=relaxed/simple;
	bh=TB4qv1ufwgwJ5ybIvgbNqEd60mC47tEzdvKtBn2ehHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANvQz70ZlnB6CR4S233/BBgobBX9TvVQ/1tG/AIyZb3h0i4U2wDbbiqwlKHdITGtSeyjfbzoqO6tSR33IhVTdkeg+hN+TPmmh2tdt9LJb2hw5Cs548j5khxljI4aggEFke1xNk1pl+eep7GP/qdv5ggqnqpn1J4uN3FVdDT39m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B0+9HFVa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yt4k+6RQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B0+9HFVa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yt4k+6RQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 600476A86B;
	Thu, 23 Apr 2026 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776942341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf1zE//fsK8osnu1ShK7FXVgyPC2ySY76VAWwtNQ9dI=;
	b=B0+9HFVa/+NdbBwz8IEiQfNyTMOLdt1Lms/JBqT9zIbk8QjIOToqXEnlwhXidPGnxzOsC2
	lYk7WKnfgsRS9FCEV0fNJnNdUbB8qqER1rssL4Y3mvwRvnR0BRoRKlGsxoG5HUI+PGuWeE
	2BbDflyZeeJRlNzJF9Vsw5x2ALdCc3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776942341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf1zE//fsK8osnu1ShK7FXVgyPC2ySY76VAWwtNQ9dI=;
	b=yt4k+6RQ6Wcoc50gE6tBV5LmQ4i09e5JErhzoeShe4HJZATIh+kopN8QqIjT1aIOemjDq3
	zgN52SfInU74FQDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776942341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf1zE//fsK8osnu1ShK7FXVgyPC2ySY76VAWwtNQ9dI=;
	b=B0+9HFVa/+NdbBwz8IEiQfNyTMOLdt1Lms/JBqT9zIbk8QjIOToqXEnlwhXidPGnxzOsC2
	lYk7WKnfgsRS9FCEV0fNJnNdUbB8qqER1rssL4Y3mvwRvnR0BRoRKlGsxoG5HUI+PGuWeE
	2BbDflyZeeJRlNzJF9Vsw5x2ALdCc3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776942341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bf1zE//fsK8osnu1ShK7FXVgyPC2ySY76VAWwtNQ9dI=;
	b=yt4k+6RQ6Wcoc50gE6tBV5LmQ4i09e5JErhzoeShe4HJZATIh+kopN8QqIjT1aIOemjDq3
	zgN52SfInU74FQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31C5C593A3;
	Thu, 23 Apr 2026 11:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2b3ACwX96WlzFwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 23 Apr 2026 11:05:41 +0000
Message-ID: <fe6fd073-c32f-4c1f-b240-b02c94e74c3e@suse.de>
Date: Thu, 23 Apr 2026 13:05:40 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: convert dev->sdev to per-LUN
 array
To: Phil Pemberton <philpem@philpem.me.uk>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260420122321.4161027-1-philpem@philpem.me.uk>
 <20260420122321.4161027-3-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260420122321.4161027-3-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23246-lists,linux-scsi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,philpem.me.uk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7481B451112
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 14:23, Phil Pemberton wrote:
> Multi-LUN ATAPI devices (PD/CD combos, CD changers) share a single
> ata_device but expose multiple scsi_devices.  The previous single
> dev->sdev pointer could only track one LUN, making all other LUNs
> invisible to code that operates on sdevs: port detach, suspend/resume,
> ACPI uevent, ZPODD, media change notification, and EH teardown.
> 
> Replace the scalar struct scsi_device *sdev with a fixed-size array
> dev->sdev[ATAPI_MAX_LUN] indexed by LUN number, where ATAPI_MAX_LUN
> is 8 (the SCSI-2 ceiling, LUN values 0..7).
> 
> Key changes per call site:
>    - ata_scsi_dev_config:  assign sdev to dev->sdev[sdev->lun]
>    - ata_scsi_sdev_destroy: clear dev->sdev[sdev->lun]; only trigger
>      ATA-level detach when LUN 0 is destroyed, since removing a higher
>      LUN should not tear down the underlying ATA device
>    - ata_port_detach:  iterate all LUN slots (high→low)
>    - ata_scsi_offline_dev:  iterate all LUN slots
>    - ata_scsi_remove_dev:  snapshot and remove all LUN slots, then
>      scsi_remove_device each one outside the lock
>    - ata_scsi_media_change_notify:  send event to all populated LUNs
>    - ata_scsi_dev_rescan:  resume and rescan each populated LUN
>    - ACPI, ZPODD, ofnode, door-lock:  use dev->sdev[0] (LUN 0 remains
>      canonical for ATA-level operations)
>    - ata_scsi_scan_host:  uses dev->sdev[0] for the existing LUN-0
>      add/retry path
> 
> For single-LUN devices (the vast majority), only dev->sdev[0] is ever
> populated and the additional slots remain NULL.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/ata/libata-acpi.c  |   4 +-
>   drivers/ata/libata-core.c  |  10 ++-
>   drivers/ata/libata-scsi.c  | 146 ++++++++++++++++++-------------------
>   drivers/ata/libata-zpodd.c |   6 +-
>   include/linux/libata.h     |   2 +-
>   5 files changed, 86 insertions(+), 82 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

