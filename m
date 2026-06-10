Return-Path: <linux-scsi+bounces-24662-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v0O/CV/EKWoDdAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24662-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 22:09:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FBA66CB26
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 22:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=2iHalZNc;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24662-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24662-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63A02300FF8B
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 20:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB23803F0;
	Wed, 10 Jun 2026 20:08:59 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED9391825;
	Wed, 10 Jun 2026 20:08:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122138; cv=none; b=DebIicghEKFif8XTuqUroQ+KOvMxIX5pyJjrCBbuN1K1KcJvsQCbrmdcE/w4clY8wvXc9gdJvGR8TZMYCYp0BqPDiMoZS1MiF4fmZ85LwIPjpHwlenT6b6ESBaQGuwqF4jGZ9SXuEo6wIjSAtrRw2mc/z+XASckYSpEfjOtCPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122138; c=relaxed/simple;
	bh=mmgSoLbmkQ3MAV+4HU5DbmmRbFKlFAik0HTHu4PvVfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3eRCEwMjFrOps++m9xzsu+/AMYRN+ViI3GX3dSVbTVm6uiEUQIbPTNWZspCgmbD5obOoRVmxEzIuc82JqIatpo3ygm1sE/A8In9U9dV1jTPuetrAqDDV4R+kc4gpcHhza8vUT3/kMY9IOLKhIUa7qqUTIF0wzz2/9KQubGvjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2iHalZNc; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbH0j1wz8z1XLyhV;
	Wed, 10 Jun 2026 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781122125; x=1783714126; bh=UVqgg+ByZmFKGhttHvOa+/cw
	AR6pVsGBRdbbEY7+k2o=; b=2iHalZNciQXbUUQUmpUTWa30Hc4KNJEn1xvMzPyX
	oAYom6WOL6OZZQFu8I+RA4OG3EYyZK45qof+gH0rPBiwObbPbfeDVpcH6t6kZp+o
	xhbYM1TqpD+v/p2xlqp5ejUG43n5ZGm4om1IComlCoyEebITtTmExTIRe+B+duXe
	xkTlzY+/K1TETHRvnjNFwPC3bzzY1itIRgQLRJ6RVx+zSWHeA87JNrw1F+L9ZMgt
	TjGYi2JYqTGR1edmOHc7SuExTjYEf1LLXNOB+l/CV38cbUee/cA1M4fhijCTc9Ke
	GU2vM2ut2xAL9smf0IAkUG/A+424zyTG5s/i0OiRO+9K3g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QAudmZGHRFRu; Wed, 10 Jun 2026 20:08:45 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbH0V0SxLz1XLyhS;
	Wed, 10 Jun 2026 20:08:41 +0000 (UTC)
Message-ID: <9b304461-2672-470a-91bc-21a5e6935205@acm.org>
Date: Wed, 10 Jun 2026 13:08:40 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] scsi: ufs: core: Add support for static TX
 Equalization settings
To: Can Guo <can.guo@oss.qualcomm.com>, krzk@kernel.org, beanhuo@micron.com,
 peter.wang@mediatek.com, martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260610071516.3763916-1-can.guo@oss.qualcomm.com>
 <20260610071516.3763916-3-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610071516.3763916-3-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24662-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:can.guo@oss.qualcomm.com,m:krzk@kernel.org,m:beanhuo@micron.com,m:peter.wang@mediatek.com,m:martin.petersen@oracle.com,m:mani@kernel.org,m:linux-scsi@vger.kernel.org,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@HansenPartnership.com,m:quic_rdwivedi@quicinc.com,m:quic_nitirawa@quicinc.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,acm.org:dkim,acm.org:mid,acm.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86FBA66CB26

On 6/10/26 12:15 AM, Can Guo wrote:
> Parse board-specific static TX Equalization settings from DT for each HS
> gear and store them in hba->tx_eq_params.

The word "static" means "showing little change". My understanding is
that the settings from the DT tree are used if equalization training is
not performed. If my understanding is correct, I think the use of the
word "static" is misleading. Maybe "default" or "from_dt" reflects the
purpose of these settings better?

> When adaptive TX Equalization is used, these static settings are not final:

What is the meaning of "adaptive" in the above sentence? I haven't found 
that word in the UFSHCI 5.0 standard nor in the UFS 5.0 standard in the
context of TX equalization. Should that word perhaps be left out?

> +	/*
> +	 * TX EQTR must run for the following cases:
> +	 * 1. TX EQ settings are invalid.
> +	 * 2. TX EQ settings are valid but static, i.e., populated from DT.
> +	 * 3. TX EQTR procedure is forced.
> +	 */

What is the difference between "TX EQ" and "TX EQTR"? If both refer to
TX equalization, please use the same acronym for all three bullets.

>   	params->is_valid = true;
> +	params->is_static = false;
>   }

Why is "is_static" changed into false here? A comment might be
appropriate.

> +	ufshcd_parse_static_tx_eq_settings(hba);

Please consider changing "static" into "default" or "dt" (device tree)
in the above function name. I think that will make the code easier to
follow.

Otherwise this patch looks good to me.

Thanks,

Bart.

