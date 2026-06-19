Return-Path: <linux-scsi+bounces-25091-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRBUDmzbNGq8igYAu9opvQ
	(envelope-from <linux-scsi+bounces-25091-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 08:02:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B76A4082
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 08:02:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yWRtBJto;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=24eIJs2e;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yWRtBJto;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=24eIJs2e;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25091-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25091-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CA4E30557C8
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F403469FC;
	Fri, 19 Jun 2026 06:01:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5021E4AF
	for <linux-scsi@vger.kernel.org>; Fri, 19 Jun 2026 06:01:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848903; cv=none; b=kQ9VHZCzWf3V6wVaQyLiIN7Ov/G8kjI4QBLl0UO9tZyFQMwXw4XNjlwhO+RIct0DmRz/2l+MvzXFqyxrHQj8J+EJEoa4AOvsykpEP5ga4LKQK70EfbGNlejC1Dsnh7qOr/qmaaxzd4ECKKNvWSKKs/c2l/EOyc9Ztc9gApqSzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848903; c=relaxed/simple;
	bh=bSev8Ho6wXz1oDAR97voFjVx3LTRc7AQTSi4KYorbnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvQkUXoIpVJwLPsQe8m7IHMAxxIedxbEbmc4fi9mVf3DxWfGhoFCNPpefVNapunEZFvNhHqTHtQnQrGBwwp+Hp8qJr69GodnJnWLcujHKw1nD05igRnhPtbVubu909ZwN07ewUOw6jnigY0RZnfdtUbtGstkgm36Q4pvFgLBmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yWRtBJto; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=24eIJs2e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yWRtBJto; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=24eIJs2e; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65DFC76099;
	Fri, 19 Jun 2026 06:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlkgWw1+S3GWQ34axZ/hy1O9oQlycY9Q7+uBSMBu15w=;
	b=yWRtBJtonD1py4w2LQaEgzwN4h8Q5+TC4UR857KTMAiIPhzNeEZF+gpjFxYKamsgvkwdOf
	+TI0qGKwErfpY3RPeYQfLX9TqJdXCtptFS3SFKgJNsE8cRXTWcrUFpB4jwEp6jD+6xSPrs
	fqewVa0ghymSy/bnrItRuP7Tiw4cJXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlkgWw1+S3GWQ34axZ/hy1O9oQlycY9Q7+uBSMBu15w=;
	b=24eIJs2egWsX1TDAY0cAMpZoRg5M3S7o7o8yfizUFd76NH5i+WRRAdpwjg57eEgZGf9WTz
	4RBkcP8vwbUwG2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781848900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlkgWw1+S3GWQ34axZ/hy1O9oQlycY9Q7+uBSMBu15w=;
	b=yWRtBJtonD1py4w2LQaEgzwN4h8Q5+TC4UR857KTMAiIPhzNeEZF+gpjFxYKamsgvkwdOf
	+TI0qGKwErfpY3RPeYQfLX9TqJdXCtptFS3SFKgJNsE8cRXTWcrUFpB4jwEp6jD+6xSPrs
	fqewVa0ghymSy/bnrItRuP7Tiw4cJXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781848900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlkgWw1+S3GWQ34axZ/hy1O9oQlycY9Q7+uBSMBu15w=;
	b=24eIJs2egWsX1TDAY0cAMpZoRg5M3S7o7o8yfizUFd76NH5i+WRRAdpwjg57eEgZGf9WTz
	4RBkcP8vwbUwG2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32A1D779A8;
	Fri, 19 Jun 2026 06:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KvbfCkTbNGqqFwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 19 Jun 2026 06:01:40 +0000
Message-ID: <0adf2cae-d9a3-4ac1-b794-d850c77bf67b@suse.de>
Date: Fri, 19 Jun 2026 08:01:39 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] scsi: core: Handle reprobe for existing devices
 during SCSI scan
To: Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 bvanassche@acm.org, krishna.kant@purestorage.com
References: <20260618233508.97960-1-brian@purestorage.com>
 <20260618233508.97960-6-brian@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260618233508.97960-6-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25091-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F6B76A4082

On 6/19/26 01:35, Brian Bunker wrote:
> Complement scsi_rescan_device() reprobe by handling the scan path.
> Update INQUIRY data and reprobe existing devices when standard INQUIRY
> data changed.
> 
> Co-developed-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Krishna Kant <krishna.kant@purestorage.com>
> Signed-off-by: Brian Bunker <brian@purestorage.com>
> ---
>   drivers/scsi/scsi_scan.c | 91 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 83 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

