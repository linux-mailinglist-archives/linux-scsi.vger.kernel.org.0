Return-Path: <linux-scsi+bounces-26056-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gD55ODGyVGqYpgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26056-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:38:57 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D53749636
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:38:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zB3JEr2V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CIStnlJa;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zB3JEr2V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CIStnlJa;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26056-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26056-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F36723013009
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBF03E3158;
	Mon, 13 Jul 2026 09:38:56 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4F3DDDB1
	for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 09:38:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935535; cv=none; b=KHDzAgcFs5HqeBjm/zwuvvSA4lhJRArRxAPyjr9MJPe2QxSH1aHC/yZ8LonDhlbWR5S/4I3xzu82q34z70eAkWbskikK2oRZR6rO4TyKlEDhLM/kG6+CX3qmh9RtIGGRfxFZrJ4r3PiZCCvCMkh7fmVlNjIOZ/XPyr0n17ZbrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935535; c=relaxed/simple;
	bh=RW7NTrl1zwtfiqZMOHXrejchcs8DPQYZ6a2/GOuvS74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dVhkpoO4TRIPmWdomL+lJENjwF4HezLEq4aN3kE+L96Z//oiYL2gqB7VPhBu9iKgrgTcT56Mp7P2aSS/xpB2NZZGJK/jxJ2LMc6djU5VrdK92YEuH3T+gpyY50xWrlBnnYcS04tLOPcU1rZtyvxkeChIUmkFocmsJg7jfLeWdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zB3JEr2V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CIStnlJa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zB3JEr2V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CIStnlJa; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 011DD77424;
	Mon, 13 Jul 2026 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF07VJBjflKrtsDx2iTPKd/xKDoQZCO/iYhUX+WYSP8=;
	b=zB3JEr2Vis+nO+0D48W2j/wUHbzcf8DcdRsQg+ZwzLAHF2Jx5iOB+/SNBvVEA60t/Unevy
	8tEL7OhnxCG2Hh0iIxdlzA1bg1hH68lkRFu9SyFT5HVmoIus4UnN55pzA97J1n4Gw32nmv
	A1oGjUsx8Eoogux61qI76wvrDRrP78g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF07VJBjflKrtsDx2iTPKd/xKDoQZCO/iYhUX+WYSP8=;
	b=CIStnlJayrvE9E6eGhElOEvFlW2jJKPL6ifbUSw+dRbF10+lAdRA3mcG/LPKQrKeqEJEt/
	gNPNP1jqw1NEYrAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF07VJBjflKrtsDx2iTPKd/xKDoQZCO/iYhUX+WYSP8=;
	b=zB3JEr2Vis+nO+0D48W2j/wUHbzcf8DcdRsQg+ZwzLAHF2Jx5iOB+/SNBvVEA60t/Unevy
	8tEL7OhnxCG2Hh0iIxdlzA1bg1hH68lkRFu9SyFT5HVmoIus4UnN55pzA97J1n4Gw32nmv
	A1oGjUsx8Eoogux61qI76wvrDRrP78g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wF07VJBjflKrtsDx2iTPKd/xKDoQZCO/iYhUX+WYSP8=;
	b=CIStnlJayrvE9E6eGhElOEvFlW2jJKPL6ifbUSw+dRbF10+lAdRA3mcG/LPKQrKeqEJEt/
	gNPNP1jqw1NEYrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E815779AE;
	Mon, 13 Jul 2026 09:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I3IwFimyVGosAwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 09:38:49 +0000
Message-ID: <f85126b4-006b-4830-acb4-48ecc717a94b@suse.de>
Date: Mon, 13 Jul 2026 11:38:49 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] ata: libata-scsi: add support for the REMOVE
 ELEMENT AND TRUNCATE command
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
 <20260706065610.3559692-8-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260706065610.3559692-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26056-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87D53749636

On 7/6/26 8:56 AM, Damien Le Moal wrote:
> Define the translation for the REMOVE ELEMENT AND TRUNCATE command
> (SERVICE ACTION IN command with service action
> SAI_REMOVE_ELEMENT_AND_TRUNCATE) into the ATA command
> ATA_CMD_REMOVE_ELEMENT_AND_TRUNCATE with the new function
> ata_scsi_remove_element_and_truncate_xlat()
> 
> The array of supported commands ata_supported_cmds is modified to add a
> new entry for this command. ata_scsi_cmd_is_supported() is also modify to
> correctly handle this new entry depending on the target device flag
> ATA_DFLAG_DEPOP being set.
> 
> The ATA command completion is handled using the function
> ata_scsi_depop_ua_cap_changed_complete() so that on a successful
> completion, a UNIT ATTENTION with the additional sense code set to
> CAPACITY DATA HAS CHANGED is raised.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 73 +++++++++++++++++++++++++++++++++++++++
>   include/linux/ata.h       |  1 +
>   2 files changed, 74 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

