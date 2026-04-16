Return-Path: <linux-scsi+bounces-22984-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILt9OCqB4GkDigAAu9opvQ
	(envelope-from <linux-scsi+bounces-22984-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 08:26:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B440AA84
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45E293025C51
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Apr 2026 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43B837A496;
	Thu, 16 Apr 2026 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YHAjhWLF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oLgbVCXX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YHAjhWLF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oLgbVCXX"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5ED1E0DD8
	for <linux-scsi@vger.kernel.org>; Thu, 16 Apr 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320777; cv=none; b=n0zf9Kep6+K4HA6o106OXr/xXo8y4OhJCZkhY3tAwIKAdUl1we7BSMqqlbTDD51UaGqfUYF1F5b8JOpbNBrbqpEtaTcQ2QjBUT01tbvKXp/SRwggDqUdLgL79CcDeTOWYKzChBSDnhD3KuX7M+P2k3oyHdQzZ34V1zOZ+1NS5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320777; c=relaxed/simple;
	bh=LIqlC0gUgW4OUoYrx1PFWgV3chB0sOARpyP36HjSBxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYncYIlLEwRw+109oAWQO8JUNeQ2ocSyhgljRdveG/BJrlR2USXVGbykfU0knMoFvBiMgEbWHnDlmQDKv/ZvCKVgjyrZmhdCk3heyj8VvmFe7ViVjgb8PA0nKuP+fouOxgLPs3Hb8CfThZV/NSuUblkk89TNO4WAkMLUDsrvrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YHAjhWLF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oLgbVCXX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YHAjhWLF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oLgbVCXX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BCDA5BD23;
	Thu, 16 Apr 2026 06:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776320774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG5D7Y2NQUjMdI+74Ep7H45YWMdM/GOCOX0YUv67LB4=;
	b=YHAjhWLFb48zGxmb/CsSTiSxLWOD2HyjQNTfY85DET4CkA9dcjgIffv23Us/U+/OJyJ6WO
	Qb5JdV3Dw0oOgsuEJaum30k51oTtjlCrMdBbq1S5wuXbcSsX9pCJi55vI/NHiCvqarxnrE
	z1tgzjIfbHRHt18nbkdy2dt6gkXbl3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776320774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG5D7Y2NQUjMdI+74Ep7H45YWMdM/GOCOX0YUv67LB4=;
	b=oLgbVCXXDAYb2V8tSx6qNrnWHyhwbL9qhbtPnayze1Ag/2Bc5wkCNTnRrnagDWAAVshfpO
	vvtC7yT5sNawBKAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776320774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG5D7Y2NQUjMdI+74Ep7H45YWMdM/GOCOX0YUv67LB4=;
	b=YHAjhWLFb48zGxmb/CsSTiSxLWOD2HyjQNTfY85DET4CkA9dcjgIffv23Us/U+/OJyJ6WO
	Qb5JdV3Dw0oOgsuEJaum30k51oTtjlCrMdBbq1S5wuXbcSsX9pCJi55vI/NHiCvqarxnrE
	z1tgzjIfbHRHt18nbkdy2dt6gkXbl3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776320774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG5D7Y2NQUjMdI+74Ep7H45YWMdM/GOCOX0YUv67LB4=;
	b=oLgbVCXXDAYb2V8tSx6qNrnWHyhwbL9qhbtPnayze1Ag/2Bc5wkCNTnRrnagDWAAVshfpO
	vvtC7yT5sNawBKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B74E4BE00;
	Thu, 16 Apr 2026 06:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NdonEQaB4Gm0MgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 16 Apr 2026 06:26:14 +0000
Message-ID: <e3fcf3b7-f1b4-49a7-a55a-6bfa648aea33@suse.de>
Date: Thu, 16 Apr 2026 08:26:13 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: only restrict bio allocation gfp mask asked to
 block
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Doug Gilbert <dgilbert@interlog.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260415060813.807659-1-hch@lst.de>
 <20260415060813.807659-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260415060813.807659-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-22984-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: B33B440AA84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 08:08, Christoph Hellwig wrote:
> If the caller is asking for a non-blocking allocation, we should not
> further restrict the gfp mask, which just increases the likelihood
> of failures.
> 
> Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 641ef0928d73..12341f760b9a 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -544,7 +544,8 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>   	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
>   		return NULL;
>   
> -	gfp = try_alloc_gfp(gfp);
> +	if (saved_gfp & __GFP_DIRECT_RECLAIM)
> +		gfp = try_alloc_gfp(gfp);
>   	if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
>   		/*
>   		 * Set REQ_ALLOC_CACHE even if no cached bio is available to

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

