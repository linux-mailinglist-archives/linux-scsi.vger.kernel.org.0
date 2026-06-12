Return-Path: <linux-scsi+bounces-24851-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XFNsAVXsK2pOHwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24851-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:24:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC29678F43
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=WTpM7Ade;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24851-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24851-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 764C431E6707
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53E3BED0C;
	Fri, 12 Jun 2026 11:22:00 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F03C2786
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 11:21:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263320; cv=none; b=SMCMj2afTKmJFZKx8YQJ9VyqOjZD0nV2Cq/pB718O0JVmraxtX5jAf0BqnN2oqNCvWFjRkHhfEzd//jlVxnoD3yTUAjaQIp6Hrzm2MYbxHvDePG1p8G92vEYAefK3FIgA+q6MiQ6+uU+kNjSjBGAc9GoRRUS/7cujmdS+1yIoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263320; c=relaxed/simple;
	bh=wsHUbrS75TZ1nKVBZMoZ91NU0OxmlWwcUu4WX97EwhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIVQx641nbq7lSeG3kvZ3u2D4T9S7WmtyumV3XRUlGBmQT0czwzV+PihAR6141DvCN54eQeOKjcRElGadqFvGn/54N/JZeWco+skegnIe+Smm4vp9ssDJ3TiTetMTu+LR0mV5JwAPcge9p21UBONAiO88bnaPIX2+W7gstlU4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WTpM7Ade; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b9318997so6381905e9.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781263312; x=1781868112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1XgVZ8b/v8lPAQjV16ekZOiCGWBGl+WfmBAsWgRAb0=;
        b=WTpM7AdejdhmKXAjHN9ZtKPI49gLkz50yp17i/YhLAzf7SNu19d66f/Wuh1Gk426wZ
         bBaC39O5YOP9856mjN3E2554YhksG1qUwtO1fRsX0v/bOAePE9rAEACcGiAoU4dZi8Wd
         rmJllPrBXUIIFN0zOR7Bh6lnclwvf72Bg17Mt3WZqWqSKx2nrNFftRsCrMQ9Z0Wutw5d
         wCRlLNuU8CkbAFiozweuzWeYrsujtDaDxCweBjQs63AQq7p0CZ494rsVFxNEE6JoK0Qv
         cGXC1q6yP2S1xa5eruxZzsbDMCgILXGQg4zfNYq6TGsRk2aoXDJJSM+v9E87zoC4w//q
         Mw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781263312; x=1781868112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1XgVZ8b/v8lPAQjV16ekZOiCGWBGl+WfmBAsWgRAb0=;
        b=p0MzvmVkFzIKU5zg+sAU9FArOxkUUdlbA9l/e6zBuSaImo+mmaIxCxbvboZOeDmS1c
         47/L2EXJPvfzNiE4deyG/oCCepcdVtmX0BP4cqq9STnMgVvDHqjo4A8BX4BLnbzqrHkI
         xJ6LC8nqif37gKy3vZOCOi8JIyHZu+gWKivVtuaMwZPUefcmzYlXrh9dMLjlruoFoToI
         kWT6LnWkvSStjFf9R2IExwpYcdxZWjc7PxTpOJEoeeTypunCc5DF94tCDvROVj9jhnrl
         Whhr0L6A4oS7hWIXQyHVccYCoAKTg/FtG2PzB6lyedraWwZVVTCL3e8ZqpyWBqqG+viP
         r4ig==
X-Gm-Message-State: AOJu0YywzMW0j4zRyQO0sYgDK3b5aZd08A5kG9DxXjgqZvnYacysv59u
	mQnZmzpgKG3YDlF9o39+Maa+uIZ7xdC1jQ78Z0dlyg8rxlovvL7Kz6bnkpH1oZR5zrO/hmdEEkx
	AhysV
X-Gm-Gg: Acq92OFnG6vMOVWS2z1ZhAgAQ/8vevP+Ia9kVZlvAAX4JNhUUgPDj1/3U4JhYLmB0J/
	4ey3UOGVrLlmvrj6QMFDhN+Y1zw46vRLZ9FzpNToN66d7V6tcgGXo33WPeP7rJt06KXUtwpAXLB
	lvGgZg8Sn69+/LTDq3WpfCyYlGsfg2pD/xm4tQ2wJgOBU/hQ1qmPiGUS0Uxi7StrvKNRoCNlrXi
	IItZhDUDFB4/2scEfUvLnoRZvdrSp0gf3hnzK8JuLrlAxbSzZo+/jIJAtMUI9YJrR6+2Vn9cDkx
	QpYFuTELLoiwahV7uHJ6105F1d6psc/FpoEbUeY239IifqdB4snB4kdYNnBrqc60Z4Yf4w3+Ef3
	JKSfGYaSRaphnDgs9Az67kCmfYQ5tFN7ZP5VdZck77IcqTtc2g24QwyCRlfqZ1RFrne2y/hXmA2
	zzyakB20KpvEpiwHVE6HRb0H8BfmLZ3ipLO69GElXVe8kmD4KV/dM1YWasWGH89BUOjGo=
X-Received: by 2002:a05:600d:6451:10b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-490ec480989mr21131755e9.4.1781263312596;
        Fri, 12 Jun 2026 04:21:52 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2ce361sm4634513f8f.31.2026.06.12.04.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 04:21:52 -0700 (PDT)
Message-ID: <15a1e40a-5492-46b2-bbbc-6a86094c99a0@suse.com>
Date: Fri, 12 Jun 2026 13:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/60] scsi: qla2xxx: Use ring-slot helpers in
 __qla2x00_alloc_iocbs
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-26-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-26-njavali@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-24851-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CC29678F43

On 6/12/26 11:52, Nilesh Javali wrote:
> __qla2x00_alloc_iocbs() open-codes ring pointer selection and entry
> size based on IS_QLA29XX(ha): 29xx reaches the slot via ring_ext_ptr
> and zeroes REQUEST_ENTRY_SIZE_EXT bytes, while other adapters use
> ring_ptr with REQUEST_ENTRY_SIZE bytes.
> 
> Replace the two branches with the qla_req_ring_slot() and
> qla_req_entry_size() helpers, and initialise pkt at declaration.
> The IS_QLAFX00 register-mapped writes remain guarded because
> IS_QLAFX00 and IS_QLA29XX cannot be true simultaneously.
> 
> No functional change: the bytes written to the firmware-visible IOCB
> are identical.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_iocb.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

