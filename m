Return-Path: <linux-scsi+bounces-26058-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BVeOCqKyVGq3pgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26058-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:40:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D43749688
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:40:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n4nQr29G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fhbTqDOz;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n4nQr29G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fhbTqDOz;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26058-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26058-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E5753008772
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25866385519;
	Mon, 13 Jul 2026 09:40:09 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891F324B22
	for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 09:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935609; cv=none; b=Lb5VyV9Puvqy5yRRbadsJS9oMF0NP5IBqGLu3CnPWnlB37Da5FoLjeSdEFSTGIGQKJGwxIOR0WffBdqNoKIoD+DeqOa0OH9kuqJxnCaq5Rj0kAd4s4FpOdzXlQKB9H2S5fc1StOnvQVYE7bQKTtPtMB3PMCtEJECtStdoHMoXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935609; c=relaxed/simple;
	bh=WZV6YgG+WpPiAKPk/A0W/yFsxqi/zkGwGIYdKYTnfLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rQ3+TswoC4Xg+mZFaYVwav+Q3cnRwZ5AyBMaJgV1IBwtbNyvZPF2psKkG0FJ3b8pXFgjJrvjXjr4ha+vqT1bvjR/jnbZEaegFjjFHzFzr4D5Fs3KilPyg2CEnE+asEgrN13F7I0rRZA0lYzSI6/QIkA/ehQvUCzyjutCCAMBoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n4nQr29G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fhbTqDOz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n4nQr29G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fhbTqDOz; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89B8075AD7;
	Mon, 13 Jul 2026 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgRNBZ6eOhyxPXfPIS0NxMEzDxYbtCHx2kgnh8vNGa8=;
	b=n4nQr29GgyJktRZHvm7LigRTvve9gI2nE9eE/Hou8MD2dScPJ/QHGy1XgsqxPvYPXzpVZo
	twRYdgXk6RxBSpNiqduH4S6SW1kcpTvCdHW7gC+Jg1Za+JnmVusNBcnN2aUzbII5GBeiDc
	9r3+cUwWlITtzvrqqRQQtgFlLq16lfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgRNBZ6eOhyxPXfPIS0NxMEzDxYbtCHx2kgnh8vNGa8=;
	b=fhbTqDOzCqW+ALcisdicXA4p9Zo6W+iH3GGhbiolQt5H2OziVS+FhdBFO5h3cBHxc7ETME
	+szNUOMt2tANqDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgRNBZ6eOhyxPXfPIS0NxMEzDxYbtCHx2kgnh8vNGa8=;
	b=n4nQr29GgyJktRZHvm7LigRTvve9gI2nE9eE/Hou8MD2dScPJ/QHGy1XgsqxPvYPXzpVZo
	twRYdgXk6RxBSpNiqduH4S6SW1kcpTvCdHW7gC+Jg1Za+JnmVusNBcnN2aUzbII5GBeiDc
	9r3+cUwWlITtzvrqqRQQtgFlLq16lfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgRNBZ6eOhyxPXfPIS0NxMEzDxYbtCHx2kgnh8vNGa8=;
	b=fhbTqDOzCqW+ALcisdicXA4p9Zo6W+iH3GGhbiolQt5H2OziVS+FhdBFO5h3cBHxc7ETME
	+szNUOMt2tANqDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7540E779AE;
	Mon, 13 Jul 2026 09:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HpswHHWyVGqSBAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 09:40:05 +0000
Message-ID: <bad09ed5-5785-48dd-8454-e054424e6da9@suse.de>
Date: Mon, 13 Jul 2026 11:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] ata: libata-scsi: add support for the REMOVE
 ELEMENT AND MODIFY ZONES command
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
 <20260706065610.3559692-10-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260706065610.3559692-10-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26058-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72D43749688

On 7/6/26 8:56 AM, Damien Le Moal wrote:
> Define the translation for the REMOVE ELEMENT AND MODIFY ZONES command
> (SERVICE ACTION IN command with service action
> SAI_REMOVE_ELEMENT_AND_MODIFY_ZONES) into the ATA command
> ATA_CMD_REMOVE_ELEMENT_AND_MODIFY_ZONES with the new function
> ata_scsi_remove_element_and_modify_zones_xlat()
> 
> The array of supported commands ata_supported_cmds is modified to add a
> new entry for this command. ata_scsi_cmd_is_supported() is also modify to
> correctly handle this new entry depending on the target device flag
> ATA_DFLAG_DEPOP being set, and the target device being a ZAC zoned device.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 39 +++++++++++++++++++++++++++++++++++++++
>   include/linux/ata.h       |  1 +
>   2 files changed, 40 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

