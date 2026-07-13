Return-Path: <linux-scsi+bounces-26051-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7bfXNN2wVGpFpgMAu9opvQ
	(envelope-from <linux-scsi+bounces-26051-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:33:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B7749595
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 11:33:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pPu/+Nys";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2zrRRxgj;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="pPu/+Nys";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2zrRRxgj;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26051-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26051-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA6FF3027310
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 09:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A83655C9;
	Mon, 13 Jul 2026 09:31:09 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229F3043BE
	for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 09:31:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935069; cv=none; b=Z/3PxA6WVA4mH5uKd2wabTxpGJ0aGVcyh8kY3ezmUExKqqLvB1yd+YVNKOvaqH2fhGC6SQp/Xg1sjuRWEUuVdOfO+xUyzlJPINSfE1nMMLJ0Sqhti4kp4E48c705yyRhY6fGDeIWQIA300pbcQrttRxny9HU5Lz6W7ZEHU13o5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935069; c=relaxed/simple;
	bh=Lt9CbKHM2dEyt8pJFUtYtECqcJs2AWJuEaFHZmUtwFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y51bZNhDdjY4Idp1ZMlo5wzOfU5MbnBcY5lUhtuLPazqNAxqIYtz0gT8B/F1rLTsC9Bdi7X9YH+Ciug/iaKYudYA6eSRi22W6PESle9+iwlJBFCAAJ6d2+Tc0J79cu3OqjQKhC4u6yvpuVwzNExJmHgrVUcuBCumsw596a7f5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pPu/+Nys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2zrRRxgj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pPu/+Nys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2zrRRxgj; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0ACE67585D;
	Mon, 13 Jul 2026 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsUdVrwUrMhswX+8JA+Xpt+8ICU4YT00IedOjZersEo=;
	b=pPu/+NysXok8fPf/GYbPNgefWx2mt035Oj1eNUcJurT2l3IxqygBhdBHSLlWpIXkjargCE
	vTlQNV0Wg2pQfkumGUM5Bx21mMGh64N3gvyuCDixAHh9Tdibfvh3WXKIPI62XOzgnzkvZR
	+oebGdDNIt2M1O1SsN9ePVFH92WHAjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsUdVrwUrMhswX+8JA+Xpt+8ICU4YT00IedOjZersEo=;
	b=2zrRRxgjbuR45buCjjWE13fC5gfMP7p7JghSgzgEHqkjdorrshInTCc6dq1YNYgIDWTdcd
	INtrwFUSVmZviUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783935065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsUdVrwUrMhswX+8JA+Xpt+8ICU4YT00IedOjZersEo=;
	b=pPu/+NysXok8fPf/GYbPNgefWx2mt035Oj1eNUcJurT2l3IxqygBhdBHSLlWpIXkjargCE
	vTlQNV0Wg2pQfkumGUM5Bx21mMGh64N3gvyuCDixAHh9Tdibfvh3WXKIPI62XOzgnzkvZR
	+oebGdDNIt2M1O1SsN9ePVFH92WHAjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783935065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsUdVrwUrMhswX+8JA+Xpt+8ICU4YT00IedOjZersEo=;
	b=2zrRRxgjbuR45buCjjWE13fC5gfMP7p7JghSgzgEHqkjdorrshInTCc6dq1YNYgIDWTdcd
	INtrwFUSVmZviUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEAE3779AE;
	Mon, 13 Jul 2026 09:31:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tO/YOViwVGqdeQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 09:31:04 +0000
Message-ID: <5f934a87-d87b-4f64-b915-5c39c391c56b@suse.de>
Date: Mon, 13 Jul 2026 11:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] scsi: define depopulation capabilities related
 service actions
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260706065610.3559692-1-dlemoal@kernel.org>
 <20260706065610.3559692-3-dlemoal@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260706065610.3559692-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26051-lists,linux-scsi=lfdr.de];
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
X-Rspamd-Queue-Id: 889B7749595

On 7/6/26 8:56 AM, Damien Le Moal wrote:
> Add to include/scsi/scsi_proto.h the definition of the four service
> actions of the SERVICE ACTION IN (16) command for the storage element
> depopulation and restoration capabilities, as defined in the SBC5 and
> ZBC2 specifications. These are:
>   - SAI_GET_PHYSICAL_ELEMENT_STATUS (GET PHYSICAL ELEMENT STATUS command)
>   - SAI_REMOVE_ELEMENT_AND_TRUNCATE (REMOVE ELEMENT AND TRUNCATE command)
>   - SAI_RESTORE_ELEMENTS_AND_REBUILD (RESTORE ELEMENTS AND REBUILD command)
>   - SAI_REMOVE_ELEMENT_AND_MODIFY_ZONES (REMOVE ELEMENT AND MODIFY ZONES
>     command)
> 
> The physical element types and physical element health values reported by
> the GET PHYSICAL ELEMENT STATUS command are also defined.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   include/scsi/scsi_proto.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

