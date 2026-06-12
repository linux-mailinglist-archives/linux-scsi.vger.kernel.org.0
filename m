Return-Path: <linux-scsi+bounces-24847-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5dGJW/rK2obHwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24847-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:20:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8B678F01
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=LrxMSsBB;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24847-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24847-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71E593196C28
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A039DBE4;
	Fri, 12 Jun 2026 11:19:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DA3A5431
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 11:19:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263195; cv=none; b=dk0TjJgGrPojtWV9Q3wPbIyEbyUUujGZGPjCuHYWlaFkuFJfWkGV1Y2Atzkjg6fhCwtiPLA40xp2Wxob+RMQ0IhdN6oC4rl6Bn9tHyNyohPAYFyLR8G7ZVHA2Pph4yUMZjkmRy5CVhsesuqpPEQR5AFUlk3WB5C8DQtBL1CIwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263195; c=relaxed/simple;
	bh=iGpcTPvYEx2bUHaY/dIdNgKt9yvrAAoVHQ5couhtdcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmVQmDGc3R9YGOzsNODJpggGjzZ6xtDVEx8oVWMXjGalH4emEymUgcD6yV37JKRmYxFRjM7pqsq6r8UXrCurdeJDQ4oyAFPSf3Q5kicFHe085mdamJ1NcpR3d3QC2Dg5E3pJE9akwXhwrRxJkDNKyH62M1Xidh16+24ndGiy9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LrxMSsBB; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so637648f8f.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781263189; x=1781867989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEnzw5bgMGXMrix/weYp1azNDbc0k8ZrvX5+LwT8e3Y=;
        b=LrxMSsBB0ezPFhw0rswDQwdt1+gNJx/aa/EOPSqJXsUfB6W8TzXyDUYgDvblaJsPMo
         L9eJOuM2V4sBI4tNYNWuJYYvd8RbHUhRj6rZWn6qFvfpt49uDL7NMolKOoyfHVyKraWa
         B2nVO4L/8p2jBjv0orFhALUu6VAbC19rNlpd5du6/dgIo/x7CZjCiBHUFQiywMGGSe6B
         78HXr8lD2dKvL1qw4t8bQsf/Mhz3B906WvpTMCFipfty3YOM67kWsdnRQaUa1te441s9
         w9TZofgIIGhbu2T7flCZ7ZVNrcDdDLxseuUd7iavnKU1V8Sk0O+sbQ9bjdiyL+5CIEvI
         PIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781263189; x=1781867989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEnzw5bgMGXMrix/weYp1azNDbc0k8ZrvX5+LwT8e3Y=;
        b=lav863+OvKn/zSdQJAaLknYnxIpeWsEm0Pki9hvGkMAA8WsT8BtUjJlj1zSOzN/mz3
         vkTTw0qRksoiIv4oN+wjdNEXscU++LyYhafD+CJ8QeZVTh0fZX4vOkSK5hLHzWxB8EUM
         jzDFHr5WuSfSRiWnQYQ+BjRyEe8cBlGB9btPPX5P7ye7534HFMZLMBo8q8e/iKf/tE4j
         VTkaH1qDZJLKmAyNiF/dgYw4XB65hpQt9dFZfFwWVmzCA3NZreZ0/+v4VeDmns7eLE7u
         Qkc59LSaAijboM984Bcto7yq3ndWx4zXt7uupzYZo/nkszfwEIwYmdmmc18XQ8E78UWt
         Vctw==
X-Gm-Message-State: AOJu0Yxad/0wqro/t8X65NlRQve1cNPLw0EGNTpcznJLl246/DpgK2SW
	XZ1FeinTfkUeNpQNRzqDrj1xnSy3dpYbAb0f8i+PjzVIVy4cuNknMKfVoYf9kr046RU=
X-Gm-Gg: Acq92OG+4tTlhzBcbNdzu4ibPFKxDpv0D0w2TigNzHnp3eLcUNWwGpOy49IwuWo3m0M
	kCimali881YpTIL8UGASIYlB48OpotuXZkMHmF5GUZdw+D7cOdQjgPcC/j04glqhjM9jIDqaxfe
	s6JRmF8/6TolyZJB3DUa2uT7XlifMK5Q6tUhwqrDEuFDGUgYKoLUbxlzaoBC7D/cLPnGj7RhYue
	DWG8rXHc6fGjOypilKjE4z0xIBXNhv8C3eX5wYxtcKINEZtxVOy1v38p+BQqmL2zJxXguZb4RVy
	9NtYzymmjYC8XAQ34r3AJIcyAiDwL0lBJlinuXPVfu48tmXdDXIvBJ+booYlZZbbx5M/OLD53rn
	yj4Z4IKKm2wQflxhetGlKVJBljzL6j9U1/2jhXMNfRuUGkuuPk7fZdGtnnQwQepc1Tkzw5F0mhZ
	+yhLx2v2vw5oYrCid6u/AVXRQapnTDJYmffS1g24BNsvUwDuisqhGvlzzGBAg1Z5ieh6U=
X-Received: by 2002:a05:6000:2798:b0:45e:f266:f4cb with SMTP id ffacd0b85a97d-4606db9ca0amr2335050f8f.22.1781263187415;
        Fri, 12 Jun 2026 04:19:47 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d4fsm5335176f8f.24.2026.06.12.04.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 04:19:47 -0700 (PDT)
Message-ID: <7f40a19d-0b9a-400f-b486-638d31a0956d@suse.com>
Date: Fri, 12 Jun 2026 13:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/60] scsi: qla2xxx: Enable serdes, resource count and
 FCE trace for 29xx
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-22-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-22-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24847-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BF8B678F01

On 6/12/26 11:52, Nilesh Javali wrote:
> The 29xx adapters share the diagnostic and management interfaces
> already supported on ISP27xx/28xx, but several family capability
> gates still omitted IS_QLA29XX(), leaving these paths unreachable
> on 29xx.
> 
> Add IS_QLA29XX() to the relevant checks so the following work on
> 29xx adapters:
> 
>    - read/write SerDes word mailbox commands for PHY register access.
>    - get_resource_cnts requests MBX_12 to report the extended
>      firmware resource counts.
>    - FCE trace: the enable-FCE mailbox command, the "fce" and
>      "fw_resource_count" debugfs nodes in qla2x00_dfs_setup(), the
>      debugfs enable write in qla2x00_dfs_fce_write(), and the FCE DMA
>      buffer allocation in qla2x00_alloc_fce_trace().
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_dfs.c  |  4 ++--
>   drivers/scsi/qla2xxx/qla_init.c |  2 +-
>   drivers/scsi/qla2xxx/qla_mbx.c  | 11 +++++++----
>   3 files changed, 10 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

