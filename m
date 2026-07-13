Return-Path: <linux-scsi+bounces-26055-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WlEJLTOyVGqZpgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26055-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:38:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D5574963C
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:38:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VOfxKR6J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NSxna5mK;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VOfxKR6J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NSxna5mK;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26055-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26055-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC3B7303318D
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE53E3C41;
	Mon, 13 Jul 2026 09:38:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15173E3166
	for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 09:38:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935501; cv=none; b=FlIt0vmqmnXqIuvCpY59O07g4isMG/pAStWpCx6XyAwbgKWBE/y1t20mg1JrI7W+frF5hBbTe3bdpM3fay06p31O+tkS7swt80kizLXWiEajYFVP4rRKK85QaDlF0WQoNnleJjIZhsvmQ2qvzElnQaieAwwyCQm4GtNZLAFzry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935501; c=relaxed/simple;
	bh=K5r9zAqxhtvhHmuWkTrEL5oWatv7OYoBUdZrHKq+ggI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ME2YmS9zCKa6uNQevg1UFRivSRS80PuSGY2XU125gtUoqRFawUKlchmXU+OVucHd/7BfZ8A4WCQ1MPAY6Q8DU7pDQwvH64FLGELpqB7vsXznCC+6zf+mlvOUwvhGSFaIE6Dum4v14Br9+LQmkvvtPHBKH74u+CsvWI54JYHisLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VOfxKR6J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NSxna5mK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VOfxKR6J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NSxna5mK; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC33077829;
	Mon, 13 Jul 2026 09:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPd0PleSyawSGeiDJc7sZTHtyLwgFe/pJN/Ylkmgi/Q=;
	b=VOfxKR6Ju4op//++aShP8frFirhYwVlNps8w6U6XcSD+IfU7bNAM5ct1Hltftel3yTHKyh
	drmGUmIXwNTumfB0IeAQWr/te08Vn8DCeXaeOw6IAxTr8rlENeFcRd6pg0ZXZHfBkZ4qY/
	LNrv12PwU/FReDLlDLiscZUd6gK5z8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPd0PleSyawSGeiDJc7sZTHtyLwgFe/pJN/Ylkmgi/Q=;
	b=NSxna5mK4CBkLXba4YoWTpkMMOkqREMmN3bssO/FVHivERvk8m4/SZRixlW/FuybV6OTeG
	jRwQxMcfH14YtBDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPd0PleSyawSGeiDJc7sZTHtyLwgFe/pJN/Ylkmgi/Q=;
	b=VOfxKR6Ju4op//++aShP8frFirhYwVlNps8w6U6XcSD+IfU7bNAM5ct1Hltftel3yTHKyh
	drmGUmIXwNTumfB0IeAQWr/te08Vn8DCeXaeOw6IAxTr8rlENeFcRd6pg0ZXZHfBkZ4qY/
	LNrv12PwU/FReDLlDLiscZUd6gK5z8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPd0PleSyawSGeiDJc7sZTHtyLwgFe/pJN/Ylkmgi/Q=;
	b=NSxna5mK4CBkLXba4YoWTpkMMOkqREMmN3bssO/FVHivERvk8m4/SZRixlW/FuybV6OTeG
	jRwQxMcfH14YtBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3976779AE;
	Mon, 13 Jul 2026 09:38:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TWUZKwiyVGpfAgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 09:38:16 +0000
Message-ID: <85f404ba-c55e-4a38-9caf-a9626823f594@suse.de>
Date: Mon, 13 Jul 2026 11:38:16 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] ata: libata-scsi: add support for the GET PHYSICAL
 ELEMENT STATUS command
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
 <20260706065610.3559692-7-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260706065610.3559692-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26055-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27D5574963C

On 7/6/26 8:56 AM, Damien Le Moal wrote:
> Define the translation for the GET PHYSICAL ELEMENT STATUS command
> (SERVICE ACTION IN command with service action
> SAI_GET_PHYSICAL_ELEMENT_STATUS) into the ATA command
> ATA_CMD_GET_PHYS_ELEMENT_STATUS with the new function
> ata_scsi_get_phys_element_status_xlat(). The reply of this function also
> needs translation from little endian to big endian. This is done with the
> completion callback ata_scsi_get_phys_element_status_complete().
> 
> The array of supported commands ata_supported_cmds is modified to add a
> new entry for this command. ata_scsi_cmd_is_supported() is also modified
> to correctly handle this new entry depending on the target device flag
> ATA_DFLAG_DEPOP being set.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 141 ++++++++++++++++++++++++++++++++++++++
>   include/linux/ata.h       |   1 +
>   2 files changed, 142 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

