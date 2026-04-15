Return-Path: <linux-scsi+bounces-22947-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPePDnwp32lpPgAAu9opvQ
	(envelope-from <linux-scsi+bounces-22947-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 08:00:28 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8A400AE3
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 08:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B9030146AD
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2026 05:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3BF37E2ED;
	Wed, 15 Apr 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YkG31NkV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZT2OEXPI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R99UzCJN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s2AdUE6W"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230D37CD30
	for <linux-scsi@vger.kernel.org>; Wed, 15 Apr 2026 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232753; cv=none; b=fMESBFMAFhjcFTB6vRs5OLjTB5jp5VeJjiDl35aGtJAmdezl5P9NYs0LsUcm+IXedCx3aqBxiiD3QS8eaUPE9uGXDMRNLKjE4hfWZC2SEehSAKudVua+l88vyClscMqsLpynKcwopB22raxtV2tH5EpX4v1H6bf1/lTIzHoBtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232753; c=relaxed/simple;
	bh=+aQUgpth2K0VSlPTTfZn91PO5QwEHsnNMWcgmU+D3SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vd7bkFtFCRqOtx/OFjCEvcn6EhgiFUTGG8mR75H2KUUxwfcjVHv7hVcHXLpqi1/QbaCpODb6RQnvfffH0VlZUAZ8dELTVk/sY4BDoXZLq+HiIx63/R8gwgeYQYd4SWgpCHTaSlKq3YCMyK0TBtpmPJpE4V5uCHNtMipknBqWM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YkG31NkV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZT2OEXPI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R99UzCJN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s2AdUE6W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E422C5BDF5;
	Wed, 15 Apr 2026 05:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776232750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we83c8/6pxZKoQi2d03X8jso2xvHps599CakTu+F7nc=;
	b=YkG31NkV9ysQgAGJpJx+zql4yskP1DEjlQL1VtsSdj8B70SkMf80hChw5kzmmgKMP+Y2fQ
	DpAVISNkX8VqB/PsPAxP2eZfiDmcLqW8L0zFoUpwxNfju97h/2GqbYE2n1isj4vK3fDIrT
	T3jBhv+83s/mq9t0EM3NAdXgxCmZ2mI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776232750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we83c8/6pxZKoQi2d03X8jso2xvHps599CakTu+F7nc=;
	b=ZT2OEXPI+zmOh4M7SitEjr24Zz0NIcJqRj8SaBbBINaF/sZT9ZMMXWkVXrQOZxDTd8IZGc
	wxfKKSpBdZcDASBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R99UzCJN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s2AdUE6W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776232749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we83c8/6pxZKoQi2d03X8jso2xvHps599CakTu+F7nc=;
	b=R99UzCJNR5dgZBoIYxM+/L3xXGXjCpkG47PhZ0VttClNn0wvfjr9WuZFNv905/PKtrYC0r
	YsD68UPQ/geTjcq6X4ezeUegaUO5ZXKYpVxZ0biuoUNzclY+d6jV1DmXhnIRgaH7M6AmVI
	wJyCW4KbBTIxZWQEvW9Jw9ElUHlFa0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776232749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we83c8/6pxZKoQi2d03X8jso2xvHps599CakTu+F7nc=;
	b=s2AdUE6WhTBxxHZ3kyVaXhtSlV6in5NMNIfI3BL1tOohIYLLeojGk+sUScGB35UrG6iD10
	8kkJvXwdWNlYFnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B124B860;
	Wed, 15 Apr 2026 05:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PzOCKi0p32mVJwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 15 Apr 2026 05:59:09 +0000
Message-ID: <26877b12-7c19-40af-9c1a-e96a84975acb@suse.de>
Date: Wed, 15 Apr 2026 07:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] scsi: scsi_dh_alua: increase default ALUA timeout
 to maximum spec value
To: Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc: Krishna Kant <krishna.kant@purestorage.com>,
 Riya Savla <rsavla@purestorage.com>
References: <20260414182748.39776-1-brian@purestorage.com>
 <20260414182748.39776-2-brian@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260414182748.39776-2-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22947-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,purestorage.com:email]
X-Rspamd-Queue-Id: 23B8A400AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 20:27, Brian Bunker wrote:
> The ALUA handler maps a 0 value (no implicit transition timeout provided
> by the target) to the ALUA_FAILOVER_TIMEOUT constant, currently 60
> seconds. This means the kernel already does not accept an infinite
> transition time.
> 
> However, 60 seconds is insufficient for some arrays that may take
> longer to complete ALUA transitions. Since the highest value allowed
> by the SCSI specification for the implicit transition timeout is a
> single byte (255 seconds), change the default to U8_MAX. This way,
> when a target does not provide an explicit transition timeout, we
> default to the maximum value the spec allows rather than an arbitrary
> 60 second limit.
> 
> Signed-off-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Riya Savla <rsavla@purestorage.com>
> Signed-off-by: Brian Bunker <brian@purestorage.com>
> ---
>   drivers/scsi/device_handler/scsi_dh_alua.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
> index efb08b9b145a1..8ef1eecf9f9c3 100644
> --- a/drivers/scsi/device_handler/scsi_dh_alua.c
> +++ b/drivers/scsi/device_handler/scsi_dh_alua.c
> @@ -37,7 +37,7 @@
>   #define TPGS_MODE_EXPLICIT		0x2
>   
>   #define ALUA_RTPG_SIZE			128
> -#define ALUA_FAILOVER_TIMEOUT		60
> +#define ALUA_FAILOVER_TIMEOUT		U8_MAX
>   #define ALUA_FAILOVER_RETRIES		5
>   #define ALUA_RTPG_DELAY_MSECS		5
>   #define ALUA_RTPG_RETRY_DELAY		2

I'd rather use the numerical value (ie 255), and add a comment that
the timeout is an 8-bit value to deter people from raising it
further.

Otherwise looks good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

