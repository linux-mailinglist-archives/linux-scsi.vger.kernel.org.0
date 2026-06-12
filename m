Return-Path: <linux-scsi+bounces-24877-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sZftJo8ALGpvJQQAu9opvQ
	(envelope-from <linux-scsi+bounces-24877-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:50:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376876797DA
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 14:50:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Wf+zYHjn;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24877-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24877-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A50C93007513
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB4D3BA244;
	Fri, 12 Jun 2026 12:50:19 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FF37104A
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 12:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268619; cv=none; b=kya3Zqxavmx9NyF4nxy9vjvu9pMxKUZVNQWrE4p/EgeTJXcyE+avaDnp1mHR5A9E7xgOFfZxYLfhdDgYMppyw5qgymxElZ7Pe3lok8QLQYKwgbhS5zDRKmvZ5T/mMET74P3GXA8TGfjiQMWnZGRcxlzNXe9OCO8peWLC3XTTE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268619; c=relaxed/simple;
	bh=WhJ4+eB/G4FRY9ghckJVEPCj1HX3m11Cq9+kTsY6IOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngdbT1XqEN+YxEYpZXnhZ6SahzL9VXIvU1oDcQ6HiTiVsxXcdXaA/S8Hsp8MF988tJZPuj4W9MVTTF8DUxA7ksw/Tnizab1GIaKcaQegMkKaABe6qyro2UaYevo3QXFnlpJzop8eSyzq33SlBlWvxdhcfq6VjAR2MlLukQCfAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wf+zYHjn; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490afc47455so4054775e9.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781268617; x=1781873417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGPLAY+JVR5kAWZBFN4HlrHiMcmGHLbv8SP5XCKbz2M=;
        b=Wf+zYHjncYhx4pyjV6yavNB+7voMoXmy3ibLgewj5NSQ8Jz1rG2klSXd/Fvzmefhm4
         ggsjA31xx7/NnaOkziJT0CYswuJOu6vMaKcSY+Ly/YE1XIwB7ytfTHF5cl2QjY1w8KWL
         iR+M4dxDeluWnI5pxMc5RdP3nF990cHz+bPiMlbZz/JJ8xos2AkftOe0ooeZO4RdfHZA
         5KxG/JVrGfgT1vbL75LjDMi5bejugvokAyLLPe1yReHdtRB1NYI/MW+bwsj8jxHvVw4i
         qdFDGJizbr1PO9X1VKJ10L9lpe6KtQ62wThED+ly6a18CPpT42ibbWu39v2NrMOJkQ1H
         urNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268617; x=1781873417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGPLAY+JVR5kAWZBFN4HlrHiMcmGHLbv8SP5XCKbz2M=;
        b=jfiZkg0k6GWxd84IegRrRufR2D/fGB8zYCKQxln094hWhTLhs8BdbxSFYZbWPuO/UR
         oSr0qXHv0hyr6k273h3WAmYzmrVxx62HTJtdjIescGejQojqfvyw21v43FU1zA2yiqZN
         YXCJKR0KD0gzXuHdOxMnqwuNg8e5zTaapP36j+MKUJAyIam5x8JUr4WU7Q6Vzt90+hHq
         KFW8ig1IAzZS26Thk0BBRclw0AKcPnAJp8tGxdhxm7YmJCSFA3f3z8UyWQF4q1YlbzAw
         l2JvpX75Sm2Ua5w4940G6z/HYLPuzpHcPQDiBcDso5ee4QeUUEqScIbSvliJPMJ704Kt
         JXwg==
X-Gm-Message-State: AOJu0YyhSo7qs0Y+nf9ooMnHysdN5apavRyRgUam46YVlgsn/kt5GBt9
	2xJAIei2/22EIHfDv3UWfW7szM6/ZulCXPtMQ1P1FBEXIa314T8tZayJYsgDzjmnO04=
X-Gm-Gg: Acq92OGPoLIEVotnU30HjDpWZR/P5O76nWinsHcAYd1fKIjI9vc38/Ihel6A9J13biU
	8Oldk5a72C++Dp8JvCRtiNP+ceDwMUpNxfymvgJMESlwYHudnWII/44CLFYHpgPLeq0jrM56vk3
	u0qLuKYO/6f5ZsgUOR4+m60LIUzUioAYJG/AAk0uArkGBTXD1t/WEiwg999I/gU+gtxLxoSpcAw
	Q8hE5NXETaBpk7W7McdTCcqrtVVVG0d3tefQ6X4K7/XzxJ5YR+ItBfpKcrG1GAkR89frQTeE6fH
	0bm1mlfQtX4dhepqiMkUZ+VMGPaFixec70UvsOVBlU12gyv2fWqqOfxFCYfZMSjxA9bCk3W2ZBh
	6XjammiorHO84VPLvTP5biCx21DL91nzwYSozJ0XhhK0Eo0ezjJPGuA34e1EUOMBSzK7LjZTwFn
	+5qEjUQgn2/JQrF99bv7pTxDpWBZXAybeZ+nAmerC/CYNVg4NZvwUNr9u/
X-Received: by 2002:a05:600c:4444:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-490ec50ccb2mr35904035e9.28.1781268616775;
        Fri, 12 Jun 2026 05:50:16 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c9057bsm167346425e9.5.2026.06.12.05.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 05:50:16 -0700 (PDT)
Message-ID: <df973d7f-b3c7-4def-99a6-74594c189431@suse.com>
Date: Fri, 12 Jun 2026 14:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/60] scsi: qla2xxx: Add LS4 pass-through IOCB
 handling for 29xx series
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-43-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-43-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24877-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 376876797DA

On 6/12/26 11:53, Nilesh Javali wrote:
> From: Manish Rangankar <mrangankar@marvell.com>
> 
> Extend the LS4 pass-through IOCB handling to support the 128-byte
> pt_ls4_request_ext layout used by 29xx series adapters.  The extension
> grows inline DSD capacity from 2 to 5 entries.  Function signatures are
> widened to void * so both layouts can be passed without casts.
> 
> pt_ls4_request_ext overlays pt_ls4_request through exchange_address
> (offsets 0-27 are byte-identical), so common-header writes go through a
> single struct pt_ls4_request * view; only the divergent fields
> (vp_index width, tx_/rx_byte_count offset, dsd[] base) are branched.
> 
> Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_fw29.h | 37 +++++++++++++++++
>   drivers/scsi/qla2xxx/qla_iocb.c | 73 ++++++++++++++++++++++-----------
>   drivers/scsi/qla2xxx/qla_isr.c  |  9 ++--
>   drivers/scsi/qla2xxx/qla_nvme.c | 64 +++++++++++++++++++----------
>   drivers/scsi/qla2xxx/qla_nvme.h |  4 +-
>   drivers/scsi/qla2xxx/qla_os.c   |  1 +
>   6 files changed, 137 insertions(+), 51 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

