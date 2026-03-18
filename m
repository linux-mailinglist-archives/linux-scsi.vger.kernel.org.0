Return-Path: <linux-scsi+bounces-22174-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGA0B/BaumnFUgIAu9opvQ
	(envelope-from <linux-scsi+bounces-22174-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 08:57:36 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A62B7569
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 08:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9217E302D18E
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1337186B;
	Wed, 18 Mar 2026 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UjQ+XETM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="41q6lU5b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e7WUaPlD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZYKWjG1I"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2528640F
	for <linux-scsi@vger.kernel.org>; Wed, 18 Mar 2026 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820628; cv=none; b=klZ+KkzqiVzrRWJmLS7pVNZXGCT6ZSPSMN78ej80/lUOXlnUfnYWvXWh/Lv4D4CZwc15/SFJ6+J8xtr3CvGjJQ/LrN3m67qAnNh5D7CNSikKgdYH+NCURzeDV29QeEw3WiN5O7JqealkjYEf035i7ChExMQ0iZQM0FjH7Nmi5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820628; c=relaxed/simple;
	bh=h9wiWT4m+ucfEpfMJ5QA57mo5G1YfNgrAF2KVTFbyEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKA2uUYFzZX8FYFeD0A36ABKIYvCwK3db1oncdLMcJN0EGkWSanpp2o9nSQRDNgU9QePuzHvOByCJhJIbqIk0E1sWC0rVuUsTxYqRokwuDDrnAtYkWgre9uN4Pm2jjkz3D6XuNRyqJLozPZJWODXeashs1ow6iuBLTOeNayaU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UjQ+XETM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=41q6lU5b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e7WUaPlD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZYKWjG1I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6C1A4D3D4;
	Wed, 18 Mar 2026 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773820624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjUTLZtML9IQaJdC+jLtqgVcdksZAI90z8pRXg7BLco=;
	b=UjQ+XETMkKf2aCDlZlUoGA1lp5yQdgz0BA0WK8I/y0iavcdNMsa2ve+je3sNmeiTTzVLdP
	IVBu2spVgmtuAsPH13rS90599fn5MPqjRhBMz7DAT9P0IMq38SU53+PDrbDKpGge6AVpLK
	UVmo7PB5YmuKScfMv3Ju0+S1nm2Eyjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773820624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjUTLZtML9IQaJdC+jLtqgVcdksZAI90z8pRXg7BLco=;
	b=41q6lU5b5u0D5nrF3IfDkKT/QtrDrwfnuGl4RNuCvPszPylKkpyHF2RtNnNbx4cBio2/bX
	o7fhOk+dXuoovJCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773820623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjUTLZtML9IQaJdC+jLtqgVcdksZAI90z8pRXg7BLco=;
	b=e7WUaPlDZBTVvH4gJp7TGHZIi01JmwJ/Pg/tA3n7JK4R89c6dNgnB98Td+zZ+CxVDbUyKJ
	M0/boW59BopeyfOKR1rNz37zrE0BMipwoXkA3+6YsVX2OOaATLASr/2lUvxfzC3I615ahW
	Ykl5gPONfYU3Fy+uLxptz6VpICHVuQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773820623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjUTLZtML9IQaJdC+jLtqgVcdksZAI90z8pRXg7BLco=;
	b=ZYKWjG1Ik9N8YpqOyfUHXZwmvgoWAeRJBawQ+076mgmBtwbX4FQgYdjH3HJg3OUCGmRGle
	QNuVMlQ+wN4TVTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 649C84273B;
	Wed, 18 Mar 2026 07:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3x/TFc9aumm7TQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Mar 2026 07:57:03 +0000
Message-ID: <1bf4f9c3-7ab9-4be9-9061-0611a41242d3@suse.de>
Date: Wed, 18 Mar 2026 08:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] scsi: alua: Add scsi_alua_stpg_run()
To: John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com, hare@suse.com, bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-scsi@vger.kernel.org,
 michael.christie@oracle.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260317120703.3702387-1-john.g.garry@oracle.com>
 <20260317120703.3702387-8-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260317120703.3702387-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22174-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: B71A62B7569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 13:06, John Garry wrote:
> Add a function to run stpg and handle error codes - it does equivalent
> handling as in alua_rtpg_work() from scsi_dh_alua.c
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_alua.c | 20 +++++++++++++++++++-
>   include/scsi/scsi_alua.h |  5 +++++
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_alua.c b/drivers/scsi/scsi_alua.c
> index e4cb43ba645fa..4e20a537a4ad6 100644
> --- a/drivers/scsi/scsi_alua.c
> +++ b/drivers/scsi/scsi_alua.c
> @@ -428,7 +428,6 @@ EXPORT_SYMBOL_GPL(scsi_alua_rtpg_run);
>    * a re-evaluation of the target group state or SCSI_DH_OK
>    * if no further action needs to be taken.
>    */
> -__maybe_unused
>   static int scsi_alua_stpg(struct scsi_device *sdev, bool optimize)
>   {
>   	struct alua_data *alua = sdev->alua;
> @@ -480,6 +479,25 @@ static int scsi_alua_stpg(struct scsi_device *sdev, bool optimize)
>   	return -EAGAIN;//SCSI_DH_RETRY;
>   }
>   
> +int scsi_alua_stpg_run(struct scsi_device *sdev, bool optimize)
> +{
> +	struct alua_data *alua = sdev->alua;
> +	unsigned long flags;
> +	int err;
> +
> +	err = scsi_alua_stpg(sdev, optimize);
> +	spin_lock_irqsave(&alua->lock, flags);
> +	if (err == EAGAIN) {
> +		alua->interval = 0;
> +		spin_unlock_irqrestore(&alua->lock, flags);
> +		return -EAGAIN;
> +	}
> +	spin_unlock_irqrestore(&alua->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(scsi_alua_stpg_run);
> +
>   int scsi_alua_sdev_init(struct scsi_device *sdev)
>   {
>   	int rel_port, ret, tpgs;
> diff --git a/include/scsi/scsi_alua.h b/include/scsi/scsi_alua.h
> index 1eb5481f40bd4..6e4f262bbfbc0 100644
> --- a/include/scsi/scsi_alua.h
> +++ b/include/scsi/scsi_alua.h
> @@ -31,6 +31,7 @@ int scsi_alua_sdev_init(struct scsi_device *sdev);
>   void scsi_alua_sdev_exit(struct scsi_device *sdev);
>   
>   int scsi_alua_rtpg_run(struct scsi_device *sdev);
> +int scsi_alua_stpg_run(struct scsi_device *sdev, bool optimize);
>   
>   int scsi_alua_init(void);
>   void scsi_exit_alua(void);
> @@ -40,6 +41,10 @@ static inline int scsi_alua_rtpg_run(struct scsi_device *sdev)
>   {
>   	return 0;
>   }
> +static inline int scsi_alua_stpg_run(struct scsi_device *sdev, bool optimize)
> +{
> +	return 0;
> +}
>   static inline int scsi_alua_sdev_init(struct scsi_device *sdev)
>   {
>   	return 0;

No. STPG handling should be done in scsi_dh_alua _only_. We really
should not attempt this in the scsi core.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

