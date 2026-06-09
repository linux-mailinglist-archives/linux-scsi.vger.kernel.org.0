Return-Path: <linux-scsi+bounces-24595-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hCLMHx/BJ2pd1gIAu9opvQ
	(envelope-from <linux-scsi+bounces-24595-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 09:30:39 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B665D352
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 09:30:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vnadqrfJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OpDVJd9q;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vnadqrfJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OpDVJd9q;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24595-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24595-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690623093A8C
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jun 2026 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61153CF1FE;
	Tue,  9 Jun 2026 07:24:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474DA231832
	for <linux-scsi@vger.kernel.org>; Tue,  9 Jun 2026 07:24:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989868; cv=none; b=YQWZ95UPTfdwx1z6tplDOvT5SGpkPeWWRoaNUc3TdciJnMWEgzHZ6Gvkr5KS4AQxzgF7ANLokv//1kY7WSsUSApB5U8IS7Tg0MNkNj0Q1e0SM1sCFLn3B5ksxXKpU24siuThgVbItQ8AnxjMxTjiy5nr9Ruw6TEMetyI6NIDTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989868; c=relaxed/simple;
	bh=/1xX/mSfP7lhnse5LhhCb/T4M6x9Ljzm/sNQRLcCr84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5S9Kf5wH6nm4ZwVsf075hOxNToP5At76xIi3LdcMYliZQp53qt3vtRQgB7pg14H/YsY7GmT8Ro+lZ0QEnSlrRvp/iUe7pLwJwbGB/Iws26pKuOvFNtGIvSJGFHGYOHzDSJmFllwtqkKbMHrTlRl89GNdDBB4SR0AMm/7zxrCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vnadqrfJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OpDVJd9q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vnadqrfJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OpDVJd9q; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 773246AA90;
	Tue,  9 Jun 2026 07:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780989865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMfCfS40Ai3puT16C2+IT2mwgHdZjTo+wAh5VddiVPM=;
	b=vnadqrfJwNE+PPW4F+Gu3aCqigr7cw+qyX3Mf3k2siyWZa5IGNLsTkVivgOKh2tt8rvMg5
	Dgmb6RTZBSAJfJ3+siglZjtAdvJIYAyjijrjIzVFDZFbEEQJuY0xlH1JdpQGh2uG+RmpG0
	QADVK2E4dMHX9XDDHjrd9RYlVFtEoHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780989865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMfCfS40Ai3puT16C2+IT2mwgHdZjTo+wAh5VddiVPM=;
	b=OpDVJd9qCUH/WFdiYN2x1B1pyVjx/lUcoqfXmiDNSwe48zyJmxiralZyRtu+MbTUfjP2LW
	6ZuM4Lx3C4s4bCDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780989865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMfCfS40Ai3puT16C2+IT2mwgHdZjTo+wAh5VddiVPM=;
	b=vnadqrfJwNE+PPW4F+Gu3aCqigr7cw+qyX3Mf3k2siyWZa5IGNLsTkVivgOKh2tt8rvMg5
	Dgmb6RTZBSAJfJ3+siglZjtAdvJIYAyjijrjIzVFDZFbEEQJuY0xlH1JdpQGh2uG+RmpG0
	QADVK2E4dMHX9XDDHjrd9RYlVFtEoHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780989865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMfCfS40Ai3puT16C2+IT2mwgHdZjTo+wAh5VddiVPM=;
	b=OpDVJd9qCUH/WFdiYN2x1B1pyVjx/lUcoqfXmiDNSwe48zyJmxiralZyRtu+MbTUfjP2LW
	6ZuM4Lx3C4s4bCDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F5C779A7;
	Tue,  9 Jun 2026 07:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MuBbOai/J2ptGgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 07:24:24 +0000
Message-ID: <57e0e5d9-3663-415a-a5ec-db6b0f597b0b@suse.de>
Date: Tue, 9 Jun 2026 09:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] ata: libata-scsi: route non-zero LUN commands for
 multi-LUN ATAPI
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260608213443.2296614-1-philpem@philpem.me.uk>
 <20260608213443.2296614-4-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260608213443.2296614-4-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24595-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,philpem.me.uk:email,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D62B665D352

On 6/8/26 23:34, Phil Pemberton wrote:
> Two changes are required to route commands to ATAPI LUNs other than 0:
> 
> 1. __ata_scsi_find_dev():  The existing code rejects any scsi_device
>     with a non-zero LUN, returning NULL and dropping the command on
>     the floor.  Hoist a non-zero LUN early-exit ahead of the original
>     channel/id checks: when scsidev->lun is non-zero, allow it through
>     only if the underlying ata_device is ATAPI class.  The original
>     LUN-0 path is left structurally unchanged.
> 
> 2. atapi_xlat():  Older ATAPI devices (SCSI-2 era) expect the LUN in
>     CDB byte 1 bits 7:5 rather than relying on transport-level LUN
>     addressing.  Encode scmd->device->lun into those bits, preserving
>     the existing command-specific bits in 4:0.  This is required by
>     both the Panasonic PD/CD combos and Nakamichi CD changers.
> 
>     The SCSI layer caps the LUN at shost->max_lun, so a value beyond
>     the device's nr_luns should never reach this point; guard with
>     WARN_ON_ONCE() and return AC_ERR_INVALID if it does, since the
>     3-bit CDB field cannot represent it.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/ata/libata-scsi.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

