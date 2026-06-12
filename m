Return-Path: <linux-scsi+bounces-24822-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1cQHBhbkK2qnHAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24822-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:48:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E5678C99
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:48:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="AaVpO/ec";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24822-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24822-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5E74314914E
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775F3644C9;
	Fri, 12 Jun 2026 10:48:44 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1126CE2D
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:48:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261324; cv=none; b=X5ngoVPd79zg0bqhw++333gMXf/AWdPqexzxcw5Doggv7Wag1E5ev6qTVSJS06JU9nYIosJAQYTr454WEslyPVZ0r4YQvyo/VCTJKuk4df4VWYyZq49kR+C9n5hQqDdU4V/DIr65VL5Kun3+SPPg+w8C/3ljwxi6YJHx72wRniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261324; c=relaxed/simple;
	bh=l3O2lbO4kOuLWqW5GKYCehMFEcAiF2sqSWfLPGqpZDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkmooVtt1ueuHm+DKnNv2RoHHwoOBwfDz+w/moHoToitTHC6LXj8taVdjT5bVUbMB4vDQXsu80cDb5OeIjttqgqjyrak5yIF6m59jcpCIJCgulcTa3+uLEJTSBC5aRQ4jffMJm7UFAu6XVpBhju0He1OZrYXhLSU5KHTxFr6rE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AaVpO/ec; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490afc47455so3401705e9.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781261321; x=1781866121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uw8sP8iSZm4pe2BV+swPTXhm0rIxSH35Bm8ki55Vj8k=;
        b=AaVpO/ecyfvNhgXjdiunRPHZdsstLjko1xQY96/v54HT3mmjEnS1oTXX/jAOPiWBUb
         30b9rvSxQFqPf8upsEZ2/LvAvoRkCyId4RvnkGcncA0EABTPYwWfDh+P0N3MnWCG7KJB
         9XCtC8T/HLXvpUo9ynrTDL8uEr5O2VBEVhvzsDqLXJXRM86IeNy9PULbguIaiGvNfGlZ
         u9496FX/A7OiMBWm124L/CjU7UWhslCgG1FQZrp/8dmXMaokLUEIWLuBA1yctFjf5F39
         hFSXZpVdJwx4Fud2RXa4YxyG45sDxzZ0qAgJGcgRu4kE6KWkfNyhf68tAeZ2AwbOrG3N
         f1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781261321; x=1781866121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw8sP8iSZm4pe2BV+swPTXhm0rIxSH35Bm8ki55Vj8k=;
        b=rSTqasDwrPzeTqREbnnjTTs4tkUE+LAGcyEpdNpNazTKOngniP35KPxOjFx8lxM1J+
         VMABu2n+/GxzlfOoGQ9PxHGohH+3BQ1pQ/1/lLA3M2xYcm72XjBvj94zhXgdP6fkMkwX
         sV1kIayVp9GgINyjbX4nRQx2CHkQl7IAMlzSnwQTz8MXBj+c0oUwnNVYQRKo1U3W1CiR
         D8Cfe1YgVzqlP5TcmikKSorvu25UU8KJCxsFMTacHZomVYRMpmOhw4VPZXT2a4qHzupN
         LcBYLQZ6hWNZfutTvnBSKRrCRqf8l2Kx5iR+/PtzDonImRK/fRr+/ooi3FX2dp7lyK8H
         dLHQ==
X-Gm-Message-State: AOJu0YydJ4dtSobRyITTtOpruclf1blzQ5SQiCN3aI6hN/LSXAlfljZu
	UQ0pnlYeTCXzPKt2f02bsfE1LRBkFC2mSPuiYEgFXCVy9oawqvQkeROcinRDTGbXeLc=
X-Gm-Gg: Acq92OGPKb/RXqe3ZvYqS97QGCDUrYED+7VhOCKxh0ZrFdQPJ2pR+NZ+PupXX8jWFyX
	5OpAJ4rzB/kyuBJkZvEY/wJFn3sFkctScdaOY5R/3nvd+0NqDMTljB5+rEyvaLDdK8w61bG/m+J
	jEH3w6h8t+E7g0RQ7MfBeD98ZXblfZfbTvERdbEThaxptDY5PP+FsfOgkvfEUlxnz90SnWwsf5c
	r0NiZ7stbzpL7tsTc/Im7b7pQ39a0YiqxHi2BCjhBRbMgoUk/W2NCbD3MLl4bto68gkSh2TJFGU
	/+gldtEuCO9Nf+1duh2j8iK4JsKi9ysjZ+lXr96b8jj9V7acMVrvUVob8MAPC7o4Nh6cEJoD1gT
	iZQkyQ67tu1hTjyBcUi/id99A+cNYPPOlcGnrnqN4CPgHphlSPO99iqLiMB2rvVhBvCR6FytrJ3
	EedypjulJGXW6xDfzdSM19pSOQCNoj4aHJww7+00qduSnIKN2Qxm7JRHgT
X-Received: by 2002:a05:600c:2d09:b0:490:b6a4:9f43 with SMTP id 5b1f17b1804b1-490ec4cd294mr16638385e9.7.1781261320895;
        Fri, 12 Jun 2026 03:48:40 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea843d63sm57172775e9.12.2026.06.12.03.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 03:48:40 -0700 (PDT)
Message-ID: <96010277-7b66-45bb-b210-7a5157937923@suse.com>
Date: Fri, 12 Jun 2026 12:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/60] scsi: qla2xxx: Add get_flash_version support for
 29xx adapters
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-5-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-5-njavali@marvell.com>
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
	TAGGED_FROM(0.00)[bounces-24822-lists,linux-scsi=lfdr.de];
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
X-Rspamd-Queue-Id: 5D5E5678C99

On 6/12/26 11:52, Nilesh Javali wrote:
> From: Manish Rangankar <mrangankar@marvell.com>
> 
> Remove the standalone qla29xx_get_flash_version() and fold 29xx
> support directly into qla24xx_get_flash_version():
> 
>    - Firmware version: 29xx reads version metadata from the FLT region
>      via qla29xx_get_flash_region(FLT_REG_FW) rather than parsing the
>      flash image; an early return skips the legacy firmware-image read.
> 
>    - PCI expansion ROM reads (header + data structure): a new
>      file-static helper, qla24xx_read_pci_rom_chunk(), abstracts the
>      per-generation flash access so both read sites are straight-line
>      calls instead of inline if/else twin blocks.  29xx uses
>      qla29xx_read_optrom_data(FLT_REG_BOOT_CODE, byte-offset); 24xx
>      uses qla24xx_read_flash_data(dword-address).
> 
> Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_sup.c | 235 +++++++++++++++------------------
>   1 file changed, 103 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
> index eb10904f14ca..2229c2b084cf 100644
> --- a/drivers/scsi/qla2xxx/qla_sup.c
> +++ b/drivers/scsi/qla2xxx/qla_sup.c
> @@ -527,134 +527,6 @@ qla29xx_read_optrom_data(struct scsi_qla_host *vha, uint16_t reg_code,
>   	return NULL;
>   }
>   
> -/**
> - * qla29xx_get_flash_version - Retrieve flash version information for QLA29xx adapters.
> - * @vha: Pointer to SCSI QLogic host structure.
> - * @mbuf: Buffer to store the flash version information.
> - *
> - * This function retrieves the flash version information for QLA29xx adapters.
> - * It initializes the version fields and prepares for future flash read logic.
> - *
> - * Returns QLA_SUCCESS on success or QLA_FUNCTION_FAILED on failure.
> - */
> -int
> -qla29xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
> -{

You just added this function in patch 2, and now you move it again.
Please consider merging these two patches.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

