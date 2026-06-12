Return-Path: <linux-scsi+bounces-24895-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GbdgHVsHLGqdJwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24895-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:19:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B3679B59
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:19:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=NfeUq5ka;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24895-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24895-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60FE3301D84
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE13803D3;
	Fri, 12 Jun 2026 13:13:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C321A352017
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 13:13:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269987; cv=none; b=Lbj5N6syzeOeBs5EITw6EQZg43vLVVh8vvNpr64/nm4RYiJSCWKs5FMoJcT1apJNTNVQGV4q4VN8wpcCi0W+JL9q1d6mcLBkygZWkK2OXMb/p0vtxrm8JvtufoaL1lRI9v47z+wZMn9xNYylvTXGHctx8ObcU/abqm5LGGNBxHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269987; c=relaxed/simple;
	bh=bKtGLqSf81FTul+6JqvOK7EALtOn/jMIhfDXAs10vGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGh1Rf3sI+5f6AsUN82qrNzytHhmLWSZoFbu/yyevVgVTl5A5r6AVKXggZpyS2ynTXFHxSSQ/AkKYr5IIX6ZuYTdlEHsPpfb1eraEpH8c7DU014kRzNNMB7jzfDKej77gEXbyUqDS1Q1gcNHdH7bk3KgL+vFEM5RoyMwouFuPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NfeUq5ka; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b12270b3so5863735e9.1
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781269984; x=1781874784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHauN1ZGQracj16srESicD2QqwIU4wRI0LFT7jmP0nM=;
        b=NfeUq5ka/nYXlXFPOaaQ3pbapZt3whZrwFu5Xe70JPxpvlpDb14Wj1OTqnGKqvDGZ8
         bsywg664ZZNpksoGNsR02nzgqtL6eR/NEKpYBQlq5XIrs/PU13+XsBjvbN21GpdmLm7O
         nz2FlBjrMQ4h8tNTmMsKv3gKsXaDt5AFf5gEHN1UqndlMB2aCrQOf/YdzBGaG4e/IxcN
         9YC0CVSrHU/UHJ8rUGCDHSwFlOw0pSg+79NWXETdPO4v5pD7jLbFSZ6tqqbdgE0qJRJH
         aKQwyydkTL5YbfWGimy49tAGyx/3p4KOO0lIRSYLZLvsCNzBSfzuf+cvC4xEV2DpeXEX
         oxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269984; x=1781874784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHauN1ZGQracj16srESicD2QqwIU4wRI0LFT7jmP0nM=;
        b=dRL4WlaCimayEVY6lRVdU9FVT/KC9mXJz4S+vU0T6BrnjSJWD18Y4UMzdmpI7qqJrR
         /khgBo2LW8rv5W5qtyfNZzyjNbaALb7TbSe3wdv06cEbZ1wlZ4CPr9zRQLZKteCaM0Zx
         bJRFSo/ydwWzGdN2HPF8enCh/3b6fclbFVDXAbdnMhkysHa4BxhM8cWJ5m5KToX1dVZZ
         9LBoa/1NhYdAAc75IW5PY0/rq2+2WDsGivwgOAUTqvyMRx4SeJrzql1U4gihCNd41TIo
         FlNIii2HTa9GGbkxXzf2Qj8ran3ge6ZouZ/0cF7FoECYe6qM7nkr5UBmMJGhDmiumSEG
         L5SQ==
X-Gm-Message-State: AOJu0Yx0VkdMwylnoest6f1mhR03P7/0MKVIzLkPt88UKkjwapaI5pBH
	TxssSaLRWYavyOSDZqKj2TCaXwYJJqlxOwfYi8JDxXSW5HQMYQBFtrSt0wpb1ZHrNr0=
X-Gm-Gg: Acq92OHHEimjlH//oLt2UPq6HR43dIbMIRSY1BKk6iwSsbD/YNL1w9HVAO2EePp7mSA
	bm1ycMXqDNHXp094+OKm9w4bj1u3RoUiUhb1WnTKp19ZL/bGa2xi7zR0NcRok9YSvR6niC2yNH9
	2IbvG3vXLHab9x0tFdtUactb87+kBUlzcXcS203iPFMD2VP7GcFujpRYqnWEHawhfQlAFwI/kSr
	Tar00p6kb8rxYL7Z3MBb4q3IjIGGxn3e+xz9etkCh657Z3brzg2+3Z1veoDWZWqmtXoVjs8UVjt
	9eedcx22j3zE/kA4RFAjEskNL+Daywy21F5KhSkLE6xW6M46NMOwfCczdG0P2rif5yt1pOLLPrc
	Kgd9HQqKZlbMyzKf8AVzA8EZtjnKDYa5cFDILp3BABrSwOmmbyaADsGYIQosdbvon9Dt+E4KMW1
	i97cjyRqkRVXqbEjpIZ9dpbPnVDJSjHRgTSN8XwD376A2Rm3+pK8zBQJUO
X-Received: by 2002:a05:600c:c173:b0:492:1e36:8c4c with SMTP id 5b1f17b1804b1-4921e368cabmr4803505e9.37.1781269984149;
        Fri, 12 Jun 2026 06:13:04 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea94f5b0sm44922505e9.1.2026.06.12.06.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:13:03 -0700 (PDT)
Message-ID: <bceaeeb6-e1f0-47c9-a817-2f6659b12aec@suse.com>
Date: Fri, 12 Jun 2026 15:13:03 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 60/60] scsi: qla2xxx: Bound image count in
 qla2x00_update_fru_versions()
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-61-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-61-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24895-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C71B3679B59

On 6/12/26 11:53, Nilesh Javali wrote:
> qla2x00_update_fru_versions() copies the user-supplied BSG request into
> a fixed 256-byte stack buffer (bsg[DMA_POOL_SIZE]) and then iterates
> list->count times over the qla_image_version array embedded in that
> buffer, advancing the image pointer each iteration. count is taken
> directly from user input with no upper bound, while only
> (DMA_POOL_SIZE - sizeof(list->count)) / sizeof(struct qla_image_version)
> = 6 entries actually fit. A larger count walks the image pointer off the
> end of the stack buffer, reading adjacent kernel stack memory and
> sending it to the device via qla2x00_write_sfp().
> 
> Reject requests whose declared count does not fit in the buffer.
> 
> Fixes: 697a4bc69159 ("[SCSI] qla2xxx: Provide method for updating I2C attached VPD.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_bsg.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
> index 22be6c822dda..bcca4ef3c23e 100644
> --- a/drivers/scsi/qla2xxx/qla_bsg.c
> +++ b/drivers/scsi/qla2xxx/qla_bsg.c
> @@ -1929,6 +1929,13 @@ qla2x00_update_fru_versions(struct bsg_job *bsg_job)
>   
>   	image = list->version;
>   	count = list->count;
> +
> +	if (struct_size(list, version, count) > sizeof(bsg)) {
> +		bsg_reply->reply_data.vendor_reply.vendor_rsp[0] =
> +		    EXT_STATUS_INVALID_PARAM;
> +		goto dealloc;
> +	}
> +
>   	while (count--) {
>   		memcpy(sfp, &image->field_info, sizeof(image->field_info));
>   		rval = qla2x00_write_sfp(vha, sfp_dma, sfp,

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

