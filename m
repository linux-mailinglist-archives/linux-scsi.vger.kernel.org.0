Return-Path: <linux-scsi+bounces-22173-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOPPLt1aumnFUgIAu9opvQ
	(envelope-from <linux-scsi+bounces-22173-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 08:57:17 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C02912B755B
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 081F0302146F
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Mar 2026 07:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4736CE16;
	Wed, 18 Mar 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D4Nl2jvr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iEWyVhxb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D4Nl2jvr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iEWyVhxb"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AB36CDFD
	for <linux-scsi@vger.kernel.org>; Wed, 18 Mar 2026 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820489; cv=none; b=XpAl43y5LEoR/uOZwHlL2Hi0YItcyawu/MMgxNEPNtZitzDJHqMbHVDeKU/zGbKCejWuGl34f3j1nAFjCCDK1PmdX5PQ2rZSkwY7//CkKdOPW1G5jOdXJz2X7XoBxMl+zWc5qcEOYPUMz6F2m1Dv4355kCxYFbrG0opT59TfWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820489; c=relaxed/simple;
	bh=Gfvn9/4iQuPes6+N9m89xJJuADX2R/mN4RfePaiU3mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RelbP0M4yceL1hQ79DKTQZA9FhU/m69HnSvjgJQKi9n8QtN9NxFg7i9D7Sl8ZN2AeVDacH2nkr52+AZX99C8En0PF2xXCwB0BMNU41EdrmYHTJCUFUhkWoWlRcgJviAx7W/3wCkHt00d0IM+v2FPeMcHSh3BfLXmOcqo/Jpdl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D4Nl2jvr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iEWyVhxb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D4Nl2jvr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iEWyVhxb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7900D5BDBC;
	Wed, 18 Mar 2026 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773820485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y02w+KYB2r2I35Tj3o3JNMp85F+AODVYfNJIF4bHbU=;
	b=D4Nl2jvroKNUpUFdAgBeYbv6gpYb7OH8iDT8Bi4ixCsuM17UfLbMrkD6gV4pkT+qizip2u
	q/TYXvTl0QiF5T8JMdIM0izqpESLE+YRPHyEzsZv9r4alRh13xzVyWW1Ayu7AgikqfvUqG
	2z8Auy53cg+FetdTcO4Q43EU8suzTQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773820485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y02w+KYB2r2I35Tj3o3JNMp85F+AODVYfNJIF4bHbU=;
	b=iEWyVhxbrK4pDDkLUJ+c58tc8TvhdARaQG4BPKKnCJKHxevbWOHUTcF4PQY8Cv51o9d+Xx
	w1B9VM8CbfpjDeDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773820485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y02w+KYB2r2I35Tj3o3JNMp85F+AODVYfNJIF4bHbU=;
	b=D4Nl2jvroKNUpUFdAgBeYbv6gpYb7OH8iDT8Bi4ixCsuM17UfLbMrkD6gV4pkT+qizip2u
	q/TYXvTl0QiF5T8JMdIM0izqpESLE+YRPHyEzsZv9r4alRh13xzVyWW1Ayu7AgikqfvUqG
	2z8Auy53cg+FetdTcO4Q43EU8suzTQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773820485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y02w+KYB2r2I35Tj3o3JNMp85F+AODVYfNJIF4bHbU=;
	b=iEWyVhxbrK4pDDkLUJ+c58tc8TvhdARaQG4BPKKnCJKHxevbWOHUTcF4PQY8Cv51o9d+Xx
	w1B9VM8CbfpjDeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D32C4273C;
	Wed, 18 Mar 2026 07:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9pHpBEVaumnKSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Mar 2026 07:54:45 +0000
Message-ID: <692a4803-743e-4146-a48b-2a9e65326907@suse.de>
Date: Wed, 18 Mar 2026 08:54:44 +0100
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] scsi: alua: Add scsi_alua_tur()
To: John Garry <john.g.garry@oracle.com>, martin.petersen@oracle.com,
 james.bottomley@hansenpartnership.com, hare@suse.com, bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-scsi@vger.kernel.org,
 michael.christie@oracle.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260317120703.3702387-1-john.g.garry@oracle.com>
 <20260317120703.3702387-6-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260317120703.3702387-6-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22173-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: C02912B755B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 13:06, John Garry wrote:
> Add same as alua_tur() from scsi_dh_alua.c
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/scsi_alua.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_alua.c b/drivers/scsi/scsi_alua.c
> index 1045885f74169..d8825ad7a1672 100644
> --- a/drivers/scsi/scsi_alua.c
> +++ b/drivers/scsi/scsi_alua.c
> @@ -40,6 +40,32 @@ static struct workqueue_struct *kalua_wq;
>   #define ALUA_RTPG_DELAY_MSECS		5
>   #define ALUA_RTPG_RETRY_DELAY		2
>   
> +/*
> + * alua_tur - Send a TEST UNIT READY
> + * @sdev: device to which the TEST UNIT READY command should be send
> + *
> + * Send a TEST UNIT READY to @sdev to figure out the device state
> + * Returns SCSI_DH_RETRY if the sense code is NOT READY/ALUA TRANSITIONING,
> + * SCSI_DH_OK if no error occurred, and SCSI_DH_IO otherwise.
> + */
> +__maybe_unused
> +static int scsi_alua_tur(struct scsi_device *sdev)
> +{
> +	struct scsi_sense_hdr sense_hdr;
> +	int retval;
> +
> +	retval = scsi_test_unit_ready(sdev, ALUA_FAILOVER_TIMEOUT * HZ,
> +				      ALUA_FAILOVER_RETRIES, &sense_hdr);
> +	if ((sense_hdr.sense_key == NOT_READY ||
> +	     sense_hdr.sense_key == UNIT_ATTENTION) &&
> +	    sense_hdr.asc == 0x04 && sense_hdr.ascq == 0x0a)
> +		return -EAGAIN;//SCSI_DH_RETRY;
> +	else if (retval)
> +		return -EIO;//SCSI_DH_IO;
> +	else
> +		return 0;//SCSI_DH_OK;
> +}
> +
>   /*
>    * submit_rtpg - Issue a REPORT TARGET GROUP STATES command
>    * @sdev: sdev the command should be sent to

???
And this function is useful _why_?
We're just sending a normal 'TEST UNIT READY', it has nothing to
do with ALUA. Why do we have a special function here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

