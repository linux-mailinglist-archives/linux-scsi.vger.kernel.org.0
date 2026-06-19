Return-Path: <linux-scsi+bounces-25090-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OWscEizbNGqdigYAu9opvQ
	(envelope-from <linux-scsi+bounces-25090-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 08:01:16 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B56A4076
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 08:01:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NYxhlSwz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uZmm69lv;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NYxhlSwz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uZmm69lv;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25090-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25090-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 187723021580
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 06:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E643E47B;
	Fri, 19 Jun 2026 06:01:14 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B13469FC
	for <linux-scsi@vger.kernel.org>; Fri, 19 Jun 2026 06:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848874; cv=none; b=N3ehLUpgALL3a2p7fEx16xoC2fURhz9N0neqPUwFhZlQRfwxJuT4Zs42fREpOzGzdwktXvWT5N76ASyBmaTGSi61kStqFPRSoY7dMCJqWm2u0NGbxoqpsb1/UAv+RZoiJtj1kIr0KgwJc3PweYrt5x25IWwYhN3qmjYMqZjgvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848874; c=relaxed/simple;
	bh=hipFTjcGzG3DkImMOReZVjtrLoYDHsw7tH1W0l2ropM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JspI+hN9fKK4iJWXvXERihapJcvAu968OVK0eNYIwcVzWN5iUYe7kRccl7UouFPrzBTnCWnJ+/GR7NsySBiheQo8712zPemjk8YG6b8sfTo5nU03JLgTRSL6pIxXPvIl76Y8vwjlG2oJRcHrX3xk1labTHc3Djbec542OZun1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NYxhlSwz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uZmm69lv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NYxhlSwz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uZmm69lv; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E0236D898;
	Fri, 19 Jun 2026 06:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0wZnjaktOP/FaCoTr+UzkdJdnQ1GP1gIg5OhfCnGcw=;
	b=NYxhlSwzku0DP2KcxQ9qem9t5USbYjIPNbJfQFAMYshO0qGVm6M/69NgrT9kPfW5KPMXdb
	12G9fNssSZZIzKvrvNhwuxncbYZVfnNhLfaTRUnYiuRqUHJRV6XFZyGb4gvzpUXvWKmtoi
	cflstZelzOwEK9jJM58Mw5CbR36jaUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0wZnjaktOP/FaCoTr+UzkdJdnQ1GP1gIg5OhfCnGcw=;
	b=uZmm69lvPcnYjCbqS6Gz3Wdq1RiC1csl0HPLWQWm2IP0vLNlWCK7u5WcK32ji8Gru9cevw
	BRvw7BcPk2z3ujDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0wZnjaktOP/FaCoTr+UzkdJdnQ1GP1gIg5OhfCnGcw=;
	b=NYxhlSwzku0DP2KcxQ9qem9t5USbYjIPNbJfQFAMYshO0qGVm6M/69NgrT9kPfW5KPMXdb
	12G9fNssSZZIzKvrvNhwuxncbYZVfnNhLfaTRUnYiuRqUHJRV6XFZyGb4gvzpUXvWKmtoi
	cflstZelzOwEK9jJM58Mw5CbR36jaUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0wZnjaktOP/FaCoTr+UzkdJdnQ1GP1gIg5OhfCnGcw=;
	b=uZmm69lvPcnYjCbqS6Gz3Wdq1RiC1csl0HPLWQWm2IP0vLNlWCK7u5WcK32ji8Gru9cevw
	BRvw7BcPk2z3ujDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39348779A8;
	Fri, 19 Jun 2026 06:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UVNPDCfbNGp7FwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jun 2026 06:01:11 +0000
Message-ID: <020fbf65-35f6-468e-8465-c05ab5738aa7@suse.de>
Date: Fri, 19 Jun 2026 08:01:10 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] scsi: core: Add device reprobe support to
 scsi_rescan_device()
To: Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 bvanassche@acm.org, krishna.kant@purestorage.com
References: <20260618233508.97960-1-brian@purestorage.com>
 <20260618233508.97960-5-brian@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260618233508.97960-5-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25090-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brian@purestorage.com,m:linux-scsi@vger.kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:bvanassche@acm.org,m:krishna.kant@purestorage.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C26B56A4076

On 6/19/26 01:35, Brian Bunker wrote:
> Update INQUIRY data on rescan and call device_reprobe() if PQ or type
> changed. Critical for ALUA unavailable state handling (SPC-4 5.15.2.4.4).
> 
> Co-developed-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Brian Bunker <brian@purestorage.com>
> ---
>   drivers/scsi/scsi_scan.c | 135 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 125 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

