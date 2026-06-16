Return-Path: <linux-scsi+bounces-25018-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Ql+LUpUMWqigwUAu9opvQ
	(envelope-from <linux-scsi+bounces-25018-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:48:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34918690172
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:48:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Zyi5ABER;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25018-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25018-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 681B230C5F34
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E53382C3;
	Tue, 16 Jun 2026 13:45:00 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9532D0FC
	for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 13:44:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617499; cv=none; b=fZd7k+VuQ1U6Zf0iOELvH5eT9zC++piVPWCHllfhoEe6iBzaiVwx0uEnx+Uh6dvdCeNtKP/qzWPKyEGerQ83lGgLU7hWgpmB1Knx+Eq0ETKdXsdunNf6HtvTIhcjuXXWz97oGyMRje9iszVR/NFZaO2lUszoFnmW/WaBgW/mY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617499; c=relaxed/simple;
	bh=dTzICpsGPS7NuOsXSCG3bMHbYDCMwogEE6Q9J9dqPqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOPJGlezN+EdhkQIRrXAtLttzgJjEaIVcSlT5OJkfRddPt5r70Ikn5zj0XuB2dbvIq3OrM7raXLrUoRIeGSoual21tjHcyWfPv9w496vnR2a3n5TZw534gc8s76gQFG3JH88kWBCzL5tlEp5X8ZmS7Qj3t3101+9RMn3ocde3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zyi5ABER; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gfpBr4HQsz1XM6JB;
	Tue, 16 Jun 2026 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781617488; x=1784209489; bh=KsnuTHhErHwm/T60sIuMjO3h
	vTONldrIFAIYObbJKKs=; b=Zyi5ABERcHllXvCQJ7mGXVA+5zv4hVAQoI4nBh02
	j/hE5453DtxxthOSLCH2zMNzD7L/sces5hkO7zD8QrA7UkX0J7VsG3OY9LPmIBev
	s+Kacv3fxHhNZEntBBSyUGdpfwKj5fH/B/AwnfYXcjdAhcCcZVvI4c9aiKXjuZKn
	6hgvmYPAR0NJuSrSr5YoHIIxHtOS7YvdRIUIfMWGTQd3tVCVYZj5Kzkmw2pm4MsT
	RI0Epo993uQXyarZMTNNRv69pyOJnFys/7UN+aliC0DhFY8gA/925baAVwTqrh/1
	3IvyWffq+GDs23YN30iuARtr/JBlhVGo0tVLosxzKaEViA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CZDxJfF2cITc; Tue, 16 Jun 2026 13:44:48 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gfpBk08khz1XM31H;
	Tue, 16 Jun 2026 13:44:45 +0000 (UTC)
Message-ID: <f690a0c4-0351-4769-ac56-9b59e5cf9c5d@acm.org>
Date: Tue, 16 Jun 2026 06:44:40 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] scsi: ufs: core: Add support for static TX
 Equalization settings
To: Can Guo <can.guo@oss.qualcomm.com>, krzk@kernel.org, beanhuo@micron.com,
 peter.wang@mediatek.com, martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org
References: <20260616113348.1168248-1-can.guo@oss.qualcomm.com>
 <20260616113348.1168248-3-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260616113348.1168248-3-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25018-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:can.guo@oss.qualcomm.com,m:krzk@kernel.org,m:beanhuo@micron.com,m:peter.wang@mediatek.com,m:martin.petersen@oracle.com,m:mani@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,acm.org:dkim,acm.org:email,acm.org:mid,acm.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34918690172

On 6/16/26 4:33 AM, Can Guo wrote:
> Parse board-specific static TX Equalization settings from Device Tree for
> each HS gear and store them in hba->tx_eq_params.
> 
> Parse txeq-preshoot-g[1-6] and txeq-deemphasis-g[1-6] as per-lane tuples:
> <Host_Lane0 Device_Lane0>, [<Host_Lane1 Device_Lane1>].
> 
> For HS-G6, parse optional tx-precode-enable-g6 using the same per-lane
> Host/Device tuple format. If provided, it must contain values for all
> active lanes, and each value must be 0 or 1.
> 
> Introduce from_dt in struct ufshcd_tx_eq_params to track whether TX EQ
> values came from static Device Tree data.
> 
> When adaptive TX Equalization is used, these static settings are not final:
> - If valid settings are retrieved from qTxEQGnSettings/wTxEQGnSettingsExt,
>    those retrieved settings override static Device Tree settings.
> - If retrieval is not available/valid, TX EQTR runs and trained settings
>    override static Device Tree settings.
> 
> So static Device Tree settings are a fallback for cases where adaptive TX
> Equalization is not enabled or not used. Adaptive TX Equalization remains
> the primary path when enabled.
> 
> No behavior changes for platforms that do not provide these properties.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

In the future, please wait at least 24 hours before posting a new
version of a patch series. For this patch series it has happened that a
new version was posted before I had the chance to comment on a previous
version.

Thanks,

Bart.

