Return-Path: <linux-scsi+bounces-25402-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1EArIL+6RGrGzgoAu9opvQ
	(envelope-from <linux-scsi+bounces-25402-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 08:59:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB66EA639
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 08:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=eik3WZ68;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25402-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25402-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 394EA302A9F0
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC13B5826;
	Wed,  1 Jul 2026 06:58:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACA3B4E98
	for <linux-scsi@vger.kernel.org>; Wed,  1 Jul 2026 06:58:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889120; cv=none; b=Tfh/K9U640RUJDoBsusHGG9TY9SumHl2sqjvY/Sx7tkp9ZTY2Cj7/GsXTv5zL8HwROqY3TF5ar8BMKRahbOgz6C/3zaJHrmWjOuZDtb0kv9ix8CmYoCAWHcIQqM7BtSQHxooHV1Rpnn6TFSeQKmBQRwreLQ2KP+Sj3juCVUwY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889120; c=relaxed/simple;
	bh=4/PJ5lsWF3Afw+ToM28IlvUIg6tJ1pzhObLbDR7BvMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTalIQmEikuW0j3BJI9rTk9ZpQiFgpuH/HJrKLcA7qK5zwk6TvXsqh1/VUSCUqE603YIEE8CEBsZZdfhYo9/mxHSciMZbL/BEK5+5h7yCv8dj5eVQvAFBW61P5P+R4T8EDEBmbFrDfxgPpHN21iIw1hvsZEfeJwxlPiR36elv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eik3WZ68; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-470174001a0so215736f8f.0
        for <linux-scsi@vger.kernel.org>; Tue, 30 Jun 2026 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782889117; x=1783493917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E6Htvg5E3KMoFbz7ZumeUAsKal7KTQSoqOUgZpdirn4=;
        b=eik3WZ68aZwuvvJAFOAxtHJVhbCx5343pj2kEwr1pls1NootrMVLmyBnpDZzmE3Wsi
         I9/dbBNuWPV+9X35qY2wUiuYXt6aBfkg6EQxkoE9jBgNyT5sHEJMxyliJVXLTy4ObzO3
         5zTRsequk+bWD0iOrPLihazJ83x/b+eoaZV4l3frRh3s12HwS4DvstylWMcrfBgW/EXY
         SFhzDdAfH2ZT5txtEhgOW2fXY+p/Qd8MJqTVL5EQfw4lbzcBK8vWmq9yyJgBl8/EWMVB
         IL6FeUHM8Z4kUNUfX8E2nWbKVdifvpLHglAqq09yE2ov6YMKh3qxWFqtDrINYS/GGotX
         y1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889117; x=1783493917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6Htvg5E3KMoFbz7ZumeUAsKal7KTQSoqOUgZpdirn4=;
        b=AwRT51+0xMaDT61bl7Fjl5LKxEDDJfYzCnMeBypSQrptuvS1rDDo2YBRrngjr/0gDV
         ggAE+zV3L49KnoZeB6y91atyc0Ry/sDH31VANAWf0eCd1MTtknI8cY86gFtRfeu664yh
         g4C8pchgZj0bsvBG90g3K7Vfxvs7mOtc2YYEHs3j+mhfY4xa/DegjSlvkQILYwsZ7idk
         0ijGibcEIMucdqQNs4Hp+5f+1mtrfiagHDA+M48Fp80yJjVHt9NOq/u3F9GnOO6/Wh7S
         xZWWc/7rmfWd+1qj5ntJ2QJNHp0Xs/Bdf90Ztjfw2cy5TKlSx6lrhtRJybsAM6/seBz6
         MJdw==
X-Forwarded-Encrypted: i=1; AHgh+RpDsrn2jLV2IeDRddjYVmCGZjWs3/NUUSSWeyolatEBrCN36/W0BjLOzk0+J/DyDdUCX9HEwJjoI1ZR@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIAKXAJd+fPn/D8kbHl5MQPWQxPpyxrEYVsBuItl9Xaynrahv
	ZJH5N2UkpP01B2EewP/SdlUkuDgQtujxwNd44trYml9ryaP2H4Xeu1MwRT6GsifvgiM=
X-Gm-Gg: AfdE7ck2dceGL07m4TZqYIOYg0DbFnvCEGvUWWzTMObhg4ikf5cBAdSdR+EfMvi3YwC
	AisYQFfj1Ppr3jpAGnk1rvMHau4+hw513b0PrZi8ebPVVuNNINorkIn3NTPVsQj22J71acCGYPN
	FeNRBjYhZwkinQU8J8KcTnXQyYQmgzoCyOx/3u94tKPdcCXZyXsyTPq/UUHg7aE13b0TjKU99rl
	tKuxHu3Y8xigTqDezJQ++T05DPqZTiF7465FrmDl84+jb//ERYNo8am3wVg5GVNu/KRdyE1KVF3
	pK+jBt0h1TQy7HvYSMK74CZq2kwOQi+6FECgjZGpZEPatdO6ZLk3qIvixCxdMuq5iObQVIMMues
	5V6clzujtRwr2FHfVrgowRYSEkPHddMITyXy1ychlxHt0dk4glOWYaWSi+KEoB6I9gykoRqnaJ+
	Z0AooRPRNTM0bQEf0zazUDvBfZeFBetORv2vAB4+sC1M7FP8w=
X-Received: by 2002:a05:6000:2612:b0:43f:e2b7:7160 with SMTP id ffacd0b85a97d-477574b0599mr505149f8f.4.1782889117243;
        Tue, 30 Jun 2026 23:58:37 -0700 (PDT)
Received: from ?IPV6:2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1? ([2001:a62:1403:d01:fcc2:cfc6:9af3:a0c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-476792758aasm7184096f8f.11.2026.06.30.23.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:58:36 -0700 (PDT)
Message-ID: <a56251e3-0b1c-4844-8b9e-033f77216c63@suse.com>
Date: Wed, 1 Jul 2026 08:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] scsi: proc: use kmalloc() in proc writers
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
 <20260630-b4-scsi-v1-2-494fb37ebe7b@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260630-b4-scsi-v1-2-494fb37ebe7b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25402-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:martin.petersen@oracle.com,m:brking@us.ibm.com,m:James.Bottomley@HansenPartnership.com,m:willy@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FDB66EA639

On 6/30/26 12:54 PM, Mike Rapoport (Microsoft) wrote:
> proc_scsi_host_write(), proc_scsi_write() and proc_scsi_devinfo_write()
> allocate temporary buffers for /proc writes using __get_free_page().
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Replace use of __get_free_page() with kmalloc().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   drivers/scsi/scsi_devinfo.c | 4 ++--
>   drivers/scsi/scsi_proc.c    | 9 +++++----
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

