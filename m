Return-Path: <linux-scsi+bounces-23701-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EQhH+h9/WnnegAAu9opvQ
	(envelope-from <linux-scsi+bounces-23701-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 08 May 2026 08:08:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3FA4F23D9
	for <lists+linux-scsi@lfdr.de>; Fri, 08 May 2026 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0095309467E
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2026 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2703783BA;
	Fri,  8 May 2026 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YxtnTZvt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgxH3Etg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YxtnTZvt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgxH3Etg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6F3750A9
	for <linux-scsi@vger.kernel.org>; Fri,  8 May 2026 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220140; cv=none; b=U91GOn+cK2Hf/bU+sKXRonTk3miPcvRwg6WJ3Q7C4VSfXxgHq1291MCnXcKW1EHqcYK0rkQ+ppalcsrf9E8cIjJvt0fy7KfNHDY642aQbiZIGBtXxUuZTP8NaZhKYY0UoZGhmRlwKJDFW/yMKsM9iFli7Z3+gAGeED9gP81hBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220140; c=relaxed/simple;
	bh=FGLpgt0TrLuQTT0/E8yZosrOpE5j6cTvj0aALjoi95s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCaX/IdfP+9NWHPfEfjEoy0Dr5QOV1bTg/yDk7OS5XSDXtnuVhPaCw3A3FctvyZ28dW+LJRhj7iPpUS5CmbT34J6jzz0IVZHinY+Pdf4F/DA1YVDQ/2EyNwpFszVvQaT0jn3LmhyxBURP0WIJbtK29rNsbIdfsd3mMj2LQl9na4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YxtnTZvt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgxH3Etg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YxtnTZvt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgxH3Etg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C43785C4A6;
	Fri,  8 May 2026 06:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778220124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD8IUVBzx1auoJiaeZ5eqa+yq8ovS0R8vwE4HCgBV/M=;
	b=YxtnTZvtXxy33LeyVjcavsAUuIwGKwcPVpRtkzRVsRFusMz3znT3fpJRpzc2a+SkCVxeO2
	ELThfBq4ezODVvtiyZfYL+XzknStgeyb7gegiOaddXE1DMIjovMrFSGdtDj1LijnFNuUqI
	e9+K54ppUM8fcF64i+F3s0XDb3AjAag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778220124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD8IUVBzx1auoJiaeZ5eqa+yq8ovS0R8vwE4HCgBV/M=;
	b=rgxH3EtgtMAjAJYRhRFv0YVV+Y7ehbKMMo7q8mLqr9ZywvXeMH4AoT6L3piyR9ckTi1Ld7
	ppGMVp/ec8acE4Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778220124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD8IUVBzx1auoJiaeZ5eqa+yq8ovS0R8vwE4HCgBV/M=;
	b=YxtnTZvtXxy33LeyVjcavsAUuIwGKwcPVpRtkzRVsRFusMz3znT3fpJRpzc2a+SkCVxeO2
	ELThfBq4ezODVvtiyZfYL+XzknStgeyb7gegiOaddXE1DMIjovMrFSGdtDj1LijnFNuUqI
	e9+K54ppUM8fcF64i+F3s0XDb3AjAag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778220124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD8IUVBzx1auoJiaeZ5eqa+yq8ovS0R8vwE4HCgBV/M=;
	b=rgxH3EtgtMAjAJYRhRFv0YVV+Y7ehbKMMo7q8mLqr9ZywvXeMH4AoT6L3piyR9ckTi1Ld7
	ppGMVp/ec8acE4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74A6E593A7;
	Fri,  8 May 2026 06:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sUNNGlx8/WmJPwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 08 May 2026 06:02:04 +0000
Message-ID: <ea4de81e-4c9b-48d0-bc6d-72f23c7fc831@suse.de>
Date: Fri, 8 May 2026 08:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] scsi: scsi_devinfo: extend BLIST_NO_LUN_1F to
 MATSHITA and NEC PD-1 variants
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260426190920.2051289-1-philpem@philpem.me.uk>
 <20260426190920.2051289-8-philpem@philpem.me.uk>
 <c1db6016-9b7d-454b-a4a8-c8f61391c5ae@suse.de>
 <566ea0c5-3d8b-4ce4-8d42-e97ecabe5f9d@philpem.me.uk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <566ea0c5-3d8b-4ce4-8d42-e97ecabe5f9d@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Rspamd-Queue-Id: EE3FA4F23D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23701-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,philpem.me.uk:email]
X-Rspamd-Action: no action

On 5/6/26 02:52, Phil Pemberton wrote:
> On 27/04/2026 12:56, Hannes Reinecke wrote:
>> On 4/26/26 21:09, Phil Pemberton wrote:
>>> The Panasonic LF-1095/LF-1195 PD/CD combo drive was sold under three
>>> OEM identities: COMPAQ "PD-1", MATSHITA "PD-1", and NEC "PD-1 ODX654P".
>>> All three are the same drive mechanism with the same firmware family,
>>> so they should share the BLIST_NO_LUN_1F quirk that was applied to the
>>> COMPAQ variant: PDT 0x1f / PQ 0 INQUIRY responses on non-existent LUNs
>>> are treated as "LUN not present" rather than as a phantom sdev.
>>>
>>> This patch is offered for completeness.  It has not been tested on the
>>> MATSHITA or NEC variants -- the author only has access to the COMPAQ
>>> unit -- but the drives are functionally identical and the flag is a
>>> no-op on devices that do not exhibit the PDT 0x1f response.  Drop or
>>> hold this patch if confirmation on real hardware is preferred before
>>> extending the quirk.
>>>
>>> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>
>>> ---
>>>   drivers/scsi/scsi_devinfo.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
>>> index bfc2cbd43897..ab1ffa9433b7 100644
>>> --- a/drivers/scsi/scsi_devinfo.c
>>> +++ b/drivers/scsi/scsi_devinfo.c
>>> @@ -201,7 +201,8 @@ static struct {
>>>       {"LASOUND", "CDX7405", "3.10", BLIST_MAX5LUN | BLIST_SINGLELUN},
>>>       {"Marvell", "Console", NULL, BLIST_SKIP_VPD_PAGES},
>>>       {"Marvell", "91xx Config", "1.01", BLIST_SKIP_VPD_PAGES},
>>> -    {"MATSHITA", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
>>> +    {"MATSHITA", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN |
>>> +                   BLIST_NO_LUN_1F},
>>>       {"MATSHITA", "DMC-LC5", NULL, BLIST_NOT_LOCKABLE | 
>>> BLIST_INQUIRY_36},
>>>       {"MATSHITA", "DMC-LC40", NULL, BLIST_NOT_LOCKABLE | 
>>> BLIST_INQUIRY_36},
>>>       {"Medion", "Flash XL  MMC/SD", "2.6D", BLIST_FORCELUN},
>>> @@ -212,7 +213,8 @@ static struct {
>>>       {"nCipher", "Fastness Crypto", NULL, BLIST_FORCELUN},
>>>       {"NAKAMICH", "MJ-4.8S", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
>>>       {"NAKAMICH", "MJ-5.16S", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
>>> -    {"NEC", "PD-1 ODX654P", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
>>> +    {"NEC", "PD-1 ODX654P", NULL, BLIST_FORCELUN | BLIST_SINGLELUN |
>>> +                      BLIST_NO_LUN_1F},
>>>       {"NEC", "iStorage", NULL, BLIST_REPORTLUN2},
>>>       {"NRC", "MBR-7", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
>>>       {"NRC", "MBR-7.4", NULL, BLIST_FORCELUN | BLIST_SINGLELUN},
>>
>> Any specific reason why this patch is not merged with the previous one?
>> Otherwise:
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Only that these are optional to the feature work and untested as I don't 
> have hardware. I believe these drives use the same PD-1 mechanism and 
> firmware so should behave the same, but I can't prove it.
> 
> The intent was to allow the 1-6 set to be merged (as these are tested) 
> without 7/7 (which is not) to minimise the risk of regressions.
> 
So drop it, then.
We can always add it later once someone shows up who actually has the 
hardware.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

