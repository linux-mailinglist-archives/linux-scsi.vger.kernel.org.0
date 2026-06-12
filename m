Return-Path: <linux-scsi+bounces-24875-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tC2qOcwALGp/JQQAu9opvQ
	(envelope-from <linux-scsi+bounces-24875-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:51:24 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 435E36797F8
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:51:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=LQ1fhGJ3;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24875-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24875-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE833010BAE
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48A3E025E;
	Fri, 12 Jun 2026 12:46:36 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379693E023A
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 12:46:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268396; cv=none; b=Agnwae0L2EZDniTEtVywOC+peZaJoi3XuBzDzWqdff0COamWRG9MnVW1aClw1uwOtE56gbN6tZGELN2DRGMKiFRkf6PQJw4J6eXjKDTeDVYTcwodYXFxO7nA+U/W0n8oLpopSdgLrhvVuUpveDiUpIoqlmTZYBMhYji4yPqByRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268396; c=relaxed/simple;
	bh=usgF3aBG1oPS8NdFZ+TznHIMbICHv5vdrJFTOMgKbqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IApEC7IfAQs/jnMBIg0PB8xz+atvT7pCEelpWedy9KIhBEY11ZiaxA4EZgmobLw+OxFvvzspvKsFPD4A9Z7+GyM7+CXBB5hn270VfH8/Ly4H1J7a3nn1DjQ8LUXkPeTKCFwLZBXkeEDp7Lg0fKWB816lTkQQcOtdbuCdYb1tsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LQ1fhGJ3; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso11260225e9.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781268394; x=1781873194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruZ1ZdBmf4fH4rCA0HIeJ9VgpI22M/sOcgdQaGCHK/Y=;
        b=LQ1fhGJ3geiocEr6aPn2yJkAGeD+Eq9Q3YDCESjAsCHAZsUW5fMaWRLzqujpCcRTVv
         B09KHNDbC32pmDLxODxQCNixnL+YgDpXGnHBO17VPAp3LGtkZAWgDAzPzUEBLNC5dXWa
         YvLhkXzXtNwSRRo+5v12TyD7UVn7WnLk2QHtTL8thim2dXB51zx/IfUno+HPzdxwGUzS
         f0OdO5m6k3iOLPGSS1kNJLk+9ob/mRSexFkb4O2ShxskJ+rPo4sk5SeZYkseWDNZ4c+H
         xtwvaS0ihEw/lnsloqLfBYjZoBRCZGGfEq6DtwzpP9plhOC12Bg5U7sQ4m56fH+1yQVf
         1nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268394; x=1781873194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruZ1ZdBmf4fH4rCA0HIeJ9VgpI22M/sOcgdQaGCHK/Y=;
        b=CwIhfWbAKUCGxPtMG8O7X5FRG0taTFHqK/ddGiOu/cgAbdlJ4rHcntyyrT1+OmsHxR
         8yx1ixIdiKZ5sGhHBRB17C4Tm9UlGmRmLw2R/YCHfMisHM6vTcAPmv9zGfRhgOS9pC9J
         XvocsMxKY38yxwTP+CXYv179GlSvdkhD2fOAgp6lylS2RTtKMxjH2F7acebEFgj2MFVl
         6YouxXxzCtZ0tsuaYZRVzaSVMg7yVMZWxwitsIEhSbLkiLkoVk3Ro3cPAG3HS7z9vOyC
         6NgRnhNvEDNWh7lLDeRdfEYrWEnkwgG84YgAtT/L/7mDJpMVGb1J2EJqAXhbIjAa7n3d
         cs1A==
X-Gm-Message-State: AOJu0YxQRVmcYBe+GQRsHORPwmPN7gOFZSCLq+X/UUjK6BlQtXgyJwrV
	CtaWvn4aucZIyecNoRS2YYUAltXBC7f7L+7rXrRskZsfP+i/XCiqs1V8Wy5N4blD40s=
X-Gm-Gg: Acq92OF9N9tZ++vhB8PmYGrNhf/vkIqupBAsFS+s4V5uhonsr5SFCRt43ne8eTbRO2/
	Q/urreTK20j+UYVz8MVpq4bIyIiuYZkYj75P90LWnlkTj8C7v2EhswPEyTizkW4EUjwphtOiN4r
	iO0KCOut6S04V51A2N7rsd9spBrH9UhctW4vym4W5vowhbaDUmOZ+/LSpDG/SZY2fI04KA5KqwG
	VaDm9xIPwc26IsE+slKr1boF/EH9AQ9ZpPAfEkgR6MLJGMoOBBqJO4/ArsEsihldmCH/jIafrLp
	4h9oe/n468rpnw6FroAEeldCg45ZtuNETa/KMcsjv2XXbu03OTcAhrO8onPoWNldiUWkoSlcdxZ
	3+hKsJ0yojlhSXGvTzkpVXorRftNDWeTBF5VzW9/rsK4vogS82az1T8pHhR8xRtDdJP8Qi/Jpul
	Gpr88UmCSmVjg4LL/Mq9OapbI5kr32uEvEobu+15U/Te05EAFCHSYTNETv3JrbogY+i0Q=
X-Received: by 2002:a05:600c:4253:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-490ec4b5edbmr25080575e9.2.1781268393546;
        Fri, 12 Jun 2026 05:46:33 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm5624355f8f.36.2026.06.12.05.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:46:32 -0700 (PDT)
Message-ID: <887c2b47-6103-47bc-ae3a-800421c2fd00@suse.com>
Date: Fri, 12 Jun 2026 14:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 40/60] scsi: qla2xxx: Add size check for extended VP
 report ID entry
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-41-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-41-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24875-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 435E36797F8

On 6/12/26 11:53, Nilesh Javali wrote:
> Add reserved_end[64] padding to bring the struct to 128 bytes, matching
> the hardware IOCB stride.  Change qla24xx_report_id_acquisition() to
> accept a void pointer and extract vp_idx and vp_status from the extended
> structure on 29xx series adapters, maintaining data integrity for the
> larger IOCB format.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_fw29.h |  1 +
>   drivers/scsi/qla2xxx/qla_gbl.h  |  3 +--
>   drivers/scsi/qla2xxx/qla_isr.c  |  3 +--
>   drivers/scsi/qla2xxx/qla_mbx.c  | 32 +++++++++++++++++++++-----------
>   drivers/scsi/qla2xxx/qla_os.c   |  1 +
>   5 files changed, 25 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

