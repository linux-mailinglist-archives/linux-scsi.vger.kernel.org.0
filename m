Return-Path: <linux-scsi+bounces-24597-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kxkMNEfBJ2ps1gIAu9opvQ
	(envelope-from <linux-scsi+bounces-24597-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 09:31:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7884E65D38B
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 09:31:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0+mSiSSK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="p/S/nggy";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NhB0sBUS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=panRXV2l;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24597-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24597-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECDB0301CCD1
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jun 2026 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16C3C4574;
	Tue,  9 Jun 2026 07:25:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B3231832
	for <linux-scsi@vger.kernel.org>; Tue,  9 Jun 2026 07:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989951; cv=none; b=cwsnKCSnBOwQ04G3G6e+SW/xf7zKT2LqZnR2QIrgyIA0fMBH71I3IvsWAzgOePcJStBndeSofEhZXeVIq7KTV0+Pah5DlAK7/oNfzPPybzfaQUVCjn+fQ7eTrjnBsBDJziAIKeAdjmynkkB4BX4fP0RjdfdKh5yScBopndflQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989951; c=relaxed/simple;
	bh=q42eXoHCR7YgfO4/3gUva36dm3zZlWYGKQ1tE5CkdSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYbRNGwPOCFNL9kbh1TKOTMIkWY/yaP0QzrQDSmV38dECw/HqZeaiwxeC4Q9qehuQeLWH/LZnQBw/iSRn0t4zU10OLyQbe6yfzPDaLDYTBFnZ1knhK5Bk+YiToY7GkhxpG4J431dR7J7e9CxVtV+u9DQv8JhBdGEfKgic4xmmn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0+mSiSSK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p/S/nggy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NhB0sBUS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=panRXV2l; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8D72758A0;
	Tue,  9 Jun 2026 07:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780989949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1c597nURKM193IqO1P0MsCFlL07GhCIzg4dHpv/0H4=;
	b=0+mSiSSKzNLB0VdVT0bTyg2oLpuG8G074YEFrpSJ6XRjUPibQa6sKN/W8xZZskCX9IAaOT
	nobuxDRb+z01cBvGGxC8BvAkmHII/AXPdA2nB2egIFjQemoe3ATScqzeLv/83b0GSvmwYS
	Ixh+zii6KN3MF4lREUnrIInEn/LiAvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780989949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1c597nURKM193IqO1P0MsCFlL07GhCIzg4dHpv/0H4=;
	b=p/S/nggyX0FAQyt26yxm9HAMYPB1unIsK1ks+W4jtZ3UU+9PXHOn91cdA72V+8pD1FNQHi
	SRVJ5Oi/EFcu7dBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780989948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1c597nURKM193IqO1P0MsCFlL07GhCIzg4dHpv/0H4=;
	b=NhB0sBUSgT1yw/CBF6juJLc326xGC+vTvEyMNFsNtifORkhdwCJWI9/DEkGHLyPucSpbrk
	8iKsWFg+x6n/xMleMUCNb+Wu4kiivcJXUst/u3H9MhofIdgiVHnpoG7NE/tx9MsL+XHtv3
	Lze5l3LlJQwc3YQ5/2MoSQe1yYjMkSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780989948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1c597nURKM193IqO1P0MsCFlL07GhCIzg4dHpv/0H4=;
	b=panRXV2lIZlX9uQ8xzaOTHPDiA3uoEVdwVvEewgeRO8jApgopVyco2ZI5FjF7+7F1yY8Vi
	JrqprB7KGIYabIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A508C779A7;
	Tue,  9 Jun 2026 07:25:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4VfCJvy/J2psHAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 07:25:48 +0000
Message-ID: <36b3d49f-7ad3-4b8d-9d74-a7ee9b9c429f@suse.de>
Date: Tue, 9 Jun 2026 09:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] ata: libata-scsi: probe additional LUNs for
 multi-LUN ATAPI devices
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260608213443.2296614-1-philpem@philpem.me.uk>
 <20260608213443.2296614-6-philpem@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260608213443.2296614-6-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
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
	TAGGED_FROM(0.00)[bounces-24597-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,philpem.me.uk:email,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7884E65D38B

On 6/8/26 23:34, Phil Pemberton wrote:
> After LUN 0 is added for an ATAPI device, check its BLIST_FORCELUN
> flag.  If set, bump dev->nr_luns to the host's max_lun so the LUN
> routing in atapi_xlat() accepts the probe INQUIRYs, then call
> scsi_scan_target() with SCAN_WILD_CARD to trigger the SCSI layer's
> built-in sequential LUN scan for that target only.  This probes
> LUNs 1..shost->max_lun, driven by the libata atapi_max_lun module
> parameter.
> 
> Devices without BLIST_FORCELUN (the vast majority of ATAPI devices)
> are left with only LUN 0 -- no sequential scan is triggered, so
> single-LUN devices like the iHAS124 DVD writer are completely
> unaffected.
> 
> Non-responding LUNs (PQ=0/PDT=0x1f) are silently skipped by
> scsi_probe_and_add_lun() when BLIST_NO_LUN_1F is set on the device
> via scsi_devinfo.
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
> ---
>   drivers/ata/libata-scsi.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

