Return-Path: <linux-scsi+bounces-24868-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xx2FJ/n8K2pVJAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24868-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:35:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E46795FB
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:35:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=O6LYV5lA;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24868-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24868-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68DB931D27B4
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0463BB9FC;
	Fri, 12 Jun 2026 12:34:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80863DCD99
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 12:34:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267668; cv=none; b=NukneT5XkR+U5UGCfMXrDQTIgfWhU3fa6Jgn/dXpcA8k/F4idAfupcxyMHrwlXIoVfTMsLdoSd6Jq8D6jJGZZiZfwP/XWXCTv8wr4yLxyyZZU4S4Fasi0D4b6DBA6UrPYDHEH0XCemz2r6xCKFcU3leckVbr25oGKesjVFAUZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267668; c=relaxed/simple;
	bh=1HZNt4JWA6JVVq0E9t5MDPNXPW53y/YIxAEeLu8aH40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWL43Fvf5eDUsvDwO5OOKYfLP4Dkd4lASQSbyyTsDtIT7kUxzmmkBPnXsAgHhp4BcR6GvO+NjTPjGFXj5zY8vAWpHiWjN5jrQpVKohjJXbR1perDNAmryotV93cW1NDj8rslxjKbVCRl2mJ0cEMtWu4QwOcvJnJuNNeHondpQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O6LYV5lA; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so10776295e9.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781267665; x=1781872465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZS9encu7C2mlC+JTJCkwP1LKkJe26NH0VcGIRd5kSQU=;
        b=O6LYV5lAxfUk6037ONwU9nEc8ySFcizb+kNlx9nntFHzkcGJjnIdkfVcwaLJNAHeBR
         9P7uYUNn/lWQABbL5P3iYJC3OcFMvP/siLcAnxZ7yTQv/2DcCqzub488Jr3d73Q0BiVC
         4tdj8vosvdtBMb13Ekjp0uBooCkFi7Q52EFosRMay7iOCuQQGaXWeUsNY+xaGoEQ4dJi
         W6QZHDC8EFgKbXhiy5YUqyfABeSSCoWu8puJ2bgp/umBvFNMkMzPtEDweEYlO/f0RMNl
         sOX/ItsjbWoq+ImlX/gVMuddxE3WvJEru0lfLdNb9PIQMyjEzL5NG03kZLg3hBUHpwDK
         cCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267665; x=1781872465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZS9encu7C2mlC+JTJCkwP1LKkJe26NH0VcGIRd5kSQU=;
        b=j0jUOvR6yGHWIR2Ut18axaJ0BdMT2+20w6aXcc/M6cqZPRaBX1zKZoJIfEq6kCLRpf
         FaSNaQNtdZDY40J59Y6gDOm0PQjlHKY/oX0uBsYpN/1dokFY1u8buer6Ktu+LSoP6bx8
         tXhVc1q3267NlYW/HM63vTvCmQ3SHUOHkXrjYPAjtoLz5Su4SX7JwWCVNI9fhsiWShvm
         EQS0migaH6+Mp2FopI0kexQUrOE7WXcow/lbhcb8jX80fBpDpsgh2UKq46yUxfwEizuH
         6C7QlPIBF8PKahetVrKynlQE+E3wNB6WcdOCG5vE9iv3K4rJdLv34KGwtVXmoPM9IqNN
         fHLw==
X-Gm-Message-State: AOJu0YxAGZEFR8M7TaxfVpPYRovZFV+Z4+gANxx0vZb02CwtNBacEpvd
	02uxjeFJo9gM6zuUfuK+P2FeAE2T4O1cxK9kNXQxsBoaHVUDdKK6q3yz482BqZ6klpg=
X-Gm-Gg: Acq92OF0Dr/szFnwqZcY65BwEL+ttaclSOR9zCBf+rs8sBM5sh8I/sYiwL+aKi7Dwm0
	04ouuqdE5/9EzpEdpDItPca/6Ygu2QFNYsCfH60s4JmNAG9Kilx9q2tgNjN2LnjhahNIw8+dSRm
	muklzpfoR8/FeiXkfD6Lo1uuRjUU5DfGJ8lXQxB/2CE0A9cSk+dzG4E9fk5IZyVBCj4g03yKeml
	qqSz/Js3qvSkyZEgjZdK4V4YXmfdtc3APrNwicIGcsR0Xzi4Aq+w0e9X58iM33OnmDirWXazsrY
	q5kPo8pvT+faEnsvFcNfBhEoSvryAmTACUNmqUTmBd8rkTbYj/BAUgxK9ugH0kRB4w3VV+SbwBe
	tNyQly6QbH7Re1fIcVcncXVr3XE3r8LB94PxtX8jvvIkRvmf7eYa/txYUrB9hoSw/sFU7q39UZF
	iCDdhXq4RwXlgJn+KyYywbmmlHFw3YuEQGLIKVAc5QFN+H92b6+CXdx6pr
X-Received: by 2002:a05:600c:354f:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490ec4fe74fmr35134495e9.28.1781267665110;
        Fri, 12 Jun 2026 05:34:25 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7db9c6sm64265975e9.8.2026.06.12.05.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:34:24 -0700 (PDT)
Message-ID: <44ffe19c-5789-4a0f-a466-9b4dc32d7278@suse.com>
Date: Fri, 12 Jun 2026 14:34:24 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/60] scsi: qla2xxx: Add size check for ELS status
 entry layout on 29xx
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-34-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-34-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24868-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 029E46795FB

On 6/12/26 11:53, Nilesh Javali wrote:
> Add a BUILD_BUG_ON in qla2x00_module_init() to validate that struct
> els_sts_entry_24xx_ext is 128 bytes, matching the 29xx firmware IOCB
> size.
> 
> The extended layout (29xx) overlays the base els_sts_entry_24xx for
> every field read in qla24xx_els_ct_entry(): comp_status,
> total_byte_count, error_subcode_1/2, d_id[], s_id[], and
> control_flags all sit at byte-identical offsets in both structs.  Only
> vp_index/sof_type at offset 14-15 differs (bit-packed differently in
> the ext variant), but that field is write-only on the issue path and
> never read in this completion handler.
> 
> Add a docblock at the top of qla24xx_els_ct_entry() documenting this
> layout property.  Improve a few log messages for clarity.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_isr.c | 31 +++++++++++++++++++++++--------
>   drivers/scsi/qla2xxx/qla_os.c  |  1 +
>   2 files changed, 24 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

