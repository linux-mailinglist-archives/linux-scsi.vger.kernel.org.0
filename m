Return-Path: <linux-scsi+bounces-24596-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 07nxMyrBJ2ph1gIAu9opvQ
	(envelope-from <linux-scsi+bounces-24596-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 09:30:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8365D365
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 09:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dhIObt66;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="LiXE/eGc";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dhIObt66;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="LiXE/eGc";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24596-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24596-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C5D3309AE0D
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jun 2026 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50D3CF206;
	Tue,  9 Jun 2026 07:24:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E493C0624
	for <linux-scsi@vger.kernel.org>; Tue,  9 Jun 2026 07:24:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989897; cv=none; b=o0sncu4YMp7roT1CGJBqpL4Q+Fmg5caSgShVL8QwJEiNTNeSRjPOSyv6SQZOXfXWQ8U7OyA1ja9Y36Z9uhjczhvGVvJrzmcylkWd7XQsflcVO7tFlYRT5a0WRWpB9+orVHJZqsIy0UInFMDjeZCc+xS2YiWUzPeCl1FAlI1L1dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989897; c=relaxed/simple;
	bh=ewOpURvMIW3LwSKgzIU5K3XIS3Us6h1KQxntwIdikTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvRxJwNMTujfiAyesV05zQ4G+x4rzcV8xaBVecUmnYolkqsSAyPEuirxS6T/JX9S7+QjX4djlKHfmAKpXZszcPgp1NK3ZdMdtrDtVdmF+b926tjHPJMXWnne8UO12SnN5ii0PO8ARZLxyEGHgF8HUwKDTg8VIV6uQsFccNcGzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dhIObt66; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LiXE/eGc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dhIObt66; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LiXE/eGc; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BE8C759CA;
	Tue,  9 Jun 2026 07:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780989895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Urhm98+FLCEkqRXx3L9rWlda4EwBSEFcjvaDVia1hW0=;
	b=dhIObt666HpVekzPwHKkrRk6ELgbf5I1Jr8REs50UO4sTeBxFvNbZZZ6ri1u0VBEwcc8+5
	DWVki+q/CswfcMY5xSfT9w0/SbncGyxK8wU+6jyROoQ6xSG9ceUaQ+Uo5VMKUKiggPYyOL
	vkfwLutgAxoLs1STRlJR86v8W+CBct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780989895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Urhm98+FLCEkqRXx3L9rWlda4EwBSEFcjvaDVia1hW0=;
	b=LiXE/eGcRAsejicky1fixMvYH2N74ht98ZbUB7LZzaIuHO7fpBcolN0i0tRvkhWcAApdnV
	8SGnlQ+NZgTHYeAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780989895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Urhm98+FLCEkqRXx3L9rWlda4EwBSEFcjvaDVia1hW0=;
	b=dhIObt666HpVekzPwHKkrRk6ELgbf5I1Jr8REs50UO4sTeBxFvNbZZZ6ri1u0VBEwcc8+5
	DWVki+q/CswfcMY5xSfT9w0/SbncGyxK8wU+6jyROoQ6xSG9ceUaQ+Uo5VMKUKiggPYyOL
	vkfwLutgAxoLs1STRlJR86v8W+CBct4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780989895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Urhm98+FLCEkqRXx3L9rWlda4EwBSEFcjvaDVia1hW0=;
	b=LiXE/eGcRAsejicky1fixMvYH2N74ht98ZbUB7LZzaIuHO7fpBcolN0i0tRvkhWcAApdnV
	8SGnlQ+NZgTHYeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C684C779A7;
	Tue,  9 Jun 2026 07:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wMKpLsa/J2qeGwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 07:24:54 +0000
Message-ID: <f8d54ab4-3228-46e6-b245-403606cc5b43@suse.de>
Date: Tue, 9 Jun 2026 09:24:54 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] scsi: add BLIST_NO_LUN_1F blacklist flag
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260608213443.2296614-1-philpem@philpem.me.uk>
 <20260608213443.2296614-5-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260608213443.2296614-5-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
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
	TAGGED_FROM(0.00)[bounces-24596-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,philpem.me.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30B8365D365

On 6/8/26 23:34, Phil Pemberton wrote:
> Some multi-LUN devices respond to INQUIRY on unpopulated LUNs with
> PQ=0 / PDT=0x1f instead of the standard PQ=3.  The SCSI scan layer
> normally adds such devices (PQ=0 means "connected"), producing
> spurious "No Device" entries.
> 
> The scsi_target field pdt_1f_for_no_lun already exists to suppress
> this, but was previously only set by the USB UFI driver.
> 
> Add BLIST_NO_LUN_1F so the flag can be set per-device from
> scsi_devinfo, and wire it up in scsi_add_lun() to set
> starget->pdt_1f_for_no_lun from the blacklist flags.  This runs
> during LUN 0 processing, before the sequential LUN scan probes
> higher LUNs.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/scsi/scsi_scan.c    | 2 ++
>   include/scsi/scsi_devinfo.h | 6 +++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

