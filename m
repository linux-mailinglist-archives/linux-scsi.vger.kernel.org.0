Return-Path: <linux-scsi+bounces-25640-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kS1yEPu4S2rcZAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25640-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 16:17:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81194711D82
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 16:17:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uhhaIbwL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K2cG4tuK;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uhhaIbwL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K2cG4tuK;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25640-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25640-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B48132DE0FA
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47342F6EE;
	Mon,  6 Jul 2026 12:43:53 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6542A177
	for <linux-scsi@vger.kernel.org>; Mon,  6 Jul 2026 12:43:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341833; cv=none; b=ZXF6PT6aGfoleWADS/WVy2xg20HrqTbRhxVFoHllPWAejKvkVWNKUYwcDnmnpQlYpK9u86YRwS76WTX6YvWz6ia7Oa6q+6mmJvE55EPd+FdfEYUh2/GEYX90IJsUGWmzHVkagxf4TZxJZeKLd+J6hCnJDUGex25bQYFGDGGVQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341833; c=relaxed/simple;
	bh=4dRnxd4jeDD3ww6VvDzHOmfymloyOPbsCbAT6fIlM7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB9XAQAXzl4xj9Q9NJYJloCiKneCvnOB04c6wLBw/2pQMtQYRysyNdYzOkrZJGWTsaL5TpgJ1pjKv0MZjBN2J1liiI1orByQSdAjPOPtbu0KqfQlVjtKTvMH1elvlqcN4gkAuQpZ0QyezvOsIRCWF++quON4ER5Rydpgn+lV43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uhhaIbwL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K2cG4tuK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uhhaIbwL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K2cG4tuK; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A3F375AC8;
	Mon,  6 Jul 2026 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783341827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuOCh5xk5j7gs/BbNHCpcfq5L+maGDDMedXqu5VV020=;
	b=uhhaIbwLUIJ5epv+ElwPEEIWtVzuKEBl4ILrBx75Tqwe3Z+9KdcZB7sdyKUd06sxH6PSyI
	t1J/bRe+ARwUViqAr3Z91PALQHVwc2Opr4L/5cwTSjBdEpNb4xBZSM5aRJBEz6lt2F/eDS
	JZGHl+rQWU1/plZl9zQqBMDCwrsUPwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783341827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuOCh5xk5j7gs/BbNHCpcfq5L+maGDDMedXqu5VV020=;
	b=K2cG4tuKJzliKc9HNdUNq8/wlxXFz0j10BtipbPjXhFhx4kTGjDbsW+D130vXZ2xRcPrRj
	jxGwVIwxx0nDewAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783341827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuOCh5xk5j7gs/BbNHCpcfq5L+maGDDMedXqu5VV020=;
	b=uhhaIbwLUIJ5epv+ElwPEEIWtVzuKEBl4ILrBx75Tqwe3Z+9KdcZB7sdyKUd06sxH6PSyI
	t1J/bRe+ARwUViqAr3Z91PALQHVwc2Opr4L/5cwTSjBdEpNb4xBZSM5aRJBEz6lt2F/eDS
	JZGHl+rQWU1/plZl9zQqBMDCwrsUPwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783341827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuOCh5xk5j7gs/BbNHCpcfq5L+maGDDMedXqu5VV020=;
	b=K2cG4tuKJzliKc9HNdUNq8/wlxXFz0j10BtipbPjXhFhx4kTGjDbsW+D130vXZ2xRcPrRj
	jxGwVIwxx0nDewAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CCAA779AA;
	Mon,  6 Jul 2026 12:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hJqGHQOjS2oCIQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Jul 2026 12:43:47 +0000
Message-ID: <fcc1a340-0bc2-4dc2-a116-2ebc932b1e90@suse.de>
Date: Mon, 6 Jul 2026 14:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scsi: fc_transport: Fix TOCTOU races and workqueue
To: Kyle Mahlkuch <kmahlkuc@linux.ibm.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.ely@broadcom.com
Cc: thinhtr@linux.ibm.com
References: <f4f4e9a7-e3bd-4cc5-a3df-829b981ae836@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f4f4e9a7-e3bd-4cc5-a3df-829b981ae836@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25640-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kmahlkuc@linux.ibm.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paul.ely@broadcom.com,m:thinhtr@linux.ibm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81194711D82

On 4/9/26 5:12 PM, Kyle Mahlkuch wrote:
> Fix the TOCTOU races in workqueue access, use READ_ONCE() in
> fc_queue_work(), fc_flush_work(), fc_queue_devloss_work(), and
> fc_flush_devloss().
> 
> The workqueue destruction in fc_remove_host() uses WRITE_ONCE() to set
> the pointer to NULL to prevents new work, flushing the work queued
> before NULL, then safely destroying it.
> 
> Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
> Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
> ---
>   drivers/scsi/scsi_transport_fc.c | 36 ++++++++++++++++++++++----------
>   1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/ 
> scsi_transport_fc.c
> index 3a821afee9bc..123b22b52640 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -2774,16 +2774,18 @@ EXPORT_SYMBOL(fc_release_transport);
>   static int
>   fc_queue_work(struct Scsi_Host *shost, struct work_struct *work)
>   {
> -    if (unlikely(!fc_host_work_q(shost))) {
> +    struct workqueue_struct *wq = READ_ONCE(fc_host_work_q(shost));
> +
> +    if (unlikely(!wq)) {
>           printk(KERN_ERR
>               "ERROR: FC host '%s' attempted to queue work, "
>               "when no workqueue created.\n", shost->hostt->name);
>           dump_stack();
> -
>           return -EINVAL;
>       }
> 
> -    return queue_work(fc_host_work_q(shost), work);
> +    /* Use local copy to prevent TOCTOU race */
> +    return queue_work(wq, work);
>   }
> 
This is wrong. The only way when this will become an issue is
if someone calls fc_queue_work() after the queue has been deleted,
ie when the Scsi Host is in the process of being shutdown.

And I would argue that it's a programming error if some driver would
scheduled workqueue elements at that time; the driver should know that
the host is about to be terminated, and should not try to schedule
anything here.

Seeing that every driver is using this sequence:

fc_remove_host()
scsi_remove_host()

and scsi_remove_host() is setting the 'SHOST_CANCEL' state
it would be far better to set the 'SHOST_CANCEL' state first and
then call fc_remove_host().
Then we can have an easy check in fc_queue_work() to disallow any
new elements when the host state is SHOST_CANCEL (or SHOST_DELETE).

I'll send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

