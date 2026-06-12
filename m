Return-Path: <linux-scsi+bounces-24883-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rqmUMe8CLGpbJgQAu9opvQ
	(envelope-from <linux-scsi+bounces-24883-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:00:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF77679973
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:00:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=ZNZlijff;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24883-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24883-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C4F83017E72
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA302A1BF;
	Fri, 12 Jun 2026 13:00:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846393D79F9
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 13:00:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269222; cv=none; b=EI28BQRrfOLkhiWL0hOvU8clEvFOSZGja5X6u4FxYMljgMQ8fwyHxEdTTXuuk+8EQ9yknYtkHumK9xM9QiiUg1lyEmAJLZDglglGnxN8zIKJR6Gtz5lmL/5SJEj9/HBEn7BhAAn7d7kE/J/zzi/VOEPxQ+ymX4fCnxLQESsK2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269222; c=relaxed/simple;
	bh=kLMk7cLFqt8emjPbF8ChpEcVvv3JbS7p+wjpNym3aAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIfnSaWjth+9ZUA0PYsQyKNjTmd2Go3NcWp2hH7jzxcvFH/U1GOByyyvuNU9DG/XdX+CSqye9selq9lUpRvdieFp30NSsXUGxrdgVTKj0H5uqnNqh9ZoF8wTjUAsLmM/K4hHjKRsqUvtdbOh82+ow9J44DeHAbc+1j+ZTcWFfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZNZlijff; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so6533035e9.1
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781269220; x=1781874020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1rqmorXiTwA+GCK5llnpeIsWYTGgAvF4Fp+EjD0HEo=;
        b=ZNZlijffptqIlerx1lkYrGZkKqAx12eJYikyroukXS2K0GL53Y0ErSR+k3aijUpg51
         yK2KdhvYVoXNVb+wmlg7PPXvgYEO2HkcZLkv8aRX/TGnDmj0WW4FzNoyGxHRUNVu9Qsn
         eUOmveML5mJf1LlAgAx3b93rngMCdv37tAFgNLuYtMzaf8k44Z16cY2DoIZ0hG8sVlSh
         0unIE9CmLL3tZ234j0/5s+RL3r1SSRNC0UvSaeCWyPX320NbYz3TFfqURjqTI0ZmYVpw
         qW7MIGZ93Sna5v/nLKc0aIrFRpZfNHNmUIAP5PO0yeNzU6Zpt4rv/CZtfqGJLXjDbqrp
         pVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269220; x=1781874020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1rqmorXiTwA+GCK5llnpeIsWYTGgAvF4Fp+EjD0HEo=;
        b=TPWojQ2YnjUdAO4yqpCGk0ldxQcEd7ANerc+ikxO655whRNcsQOZP0QomUN73OygxE
         makg3hWPNNRGAuwE3NrppAtxZJzcpv3MQZidUAnHvI0Wb0DtDAgiLVg6OTXaBpuPdZcn
         usN/+W8JEMdnmeOR7KNL3eKDStW/qheeaeeKMHOCWUvGkhd+UXz9eMJXMD+ANjkMtiPq
         DLSDCgc6CkbXaJOrJylcYLFerh5NdhSLn6MozKEpJzRz7iAu8EkBhlzcLlMmKROWBmB6
         JgHUom8V4rPoNZTNNu6sYbAh/92SsRAs6wzp1wxCV1Oa0g6+yMjN18HGKa0o8JKsZCyc
         p8MQ==
X-Gm-Message-State: AOJu0YxQbJD771W56ZRNHaCAkM0WPzsRWKrsoL+0oxXrxcdoFA+CmV0v
	X+ID2qo67TiygTqEJmfbT3gNsJFJTwvHLOJDoh20TE0ExlK2+BAmHGogeboskFI/03E=
X-Gm-Gg: Acq92OE+iJy7IKX0uXkJOBhM/uCNFH46nj5wcnbeJUjXXdbdfNZDqwQ4xK4SGQXGGzO
	Dh0bdAaGgs3KlI3pZLBzHodzD9RnlaaAI5jLp4/eIGqj3qHk37lq7llNfkSbDTF9uKG/jYnyuax
	jBBhzj6J7yPtZWUTWeCtSkcfCe3iUx1OEhYClSCBpk4ZSTG64cv21/GHxbnaBQ2N0i4O4GIOzJD
	OBvpymW4J+QU5Shmy0KO9mVz53FMjH+SqZdeO3Vj0A5vdG6+LHoRZ7vj/0xyhEipj1Lm11zX4ap
	ZaYJZQ6J1pFX3dyxFw8OQcn92ztKXwCMnXF6uiEU1eVYgEcjBGRz6kG9qMl6Y89O5M+dEHZtUnD
	vemy7i2uBNoMwXl1PwhBqXA2+tWXfHk5+4Avz6uem/26aIz42IApiHvnEG3Hg9IBi72mcOXh8Z3
	ezF6JOMJPBv4kB5SQnGTUiTzRSl5n04lagEitTQ2THot9mKJKCGRo9IJPc
X-Received: by 2002:a05:600c:4749:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49173253aa3mr25085735e9.34.1781269219614;
        Fri, 12 Jun 2026 06:00:19 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c871dsm73977165e9.5.2026.06.12.06.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:00:19 -0700 (PDT)
Message-ID: <bba3317b-4003-4843-87bb-fd053a010f88@suse.com>
Date: Fri, 12 Jun 2026 15:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 48/60] scsi: qla2xxx: Use 64-bit FPM word counters for
 29xx host stats
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-49-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-49-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24883-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AF77679973

On 6/12/26 11:53, Nilesh Javali wrote:
> 29xx provides the 64-bit FPM transmit/receive word counters in the link
> statistics block, like 83xx/27xx/28xx.  qla2x00_get_fc_host_stats()
> only consumed those counters for the older families and fell back to the
> software approximation (input/output bytes >> 2) on 29xx, reporting less
> accurate rx_words/tx_words.
> 
> Add IS_QLA29XX() to the high-speed branch so 29xx reports the hardware
> word counters.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_attr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

