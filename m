Return-Path: <linux-scsi+bounces-22795-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE2LKH/Z02nUnAcAu9opvQ
	(envelope-from <linux-scsi+bounces-22795-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 18:04:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49E3A50FA
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB55E3015859
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2026 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375A73876C1;
	Mon,  6 Apr 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="l+37lTOT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA2340A62;
	Mon,  6 Apr 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491451; cv=none; b=UpS0w3W/oKDZgK1sYuzh9dbqAxCIjfZOrlO9N14/zyKf5xPtqcLFx0vBkvUcWY4KTc1CYBS/rlVfH+jqljQEfU5B3y1vSWwR6n+Yg6k7SHQf9Iv5gbmAKYqLWCCOy7NK8SEtTBisA7vdbdoJXs0pMlWpjmhyqigRAsLoEDYgNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491451; c=relaxed/simple;
	bh=j6iK8z5Uts6hqkVlgpLdaHhGGSD+75oDEzcdjFI3xUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZivffQUuqFP3jY7ZCs1m1wKX/D5yVObK9mkruOHpZNLzk2Pyz/ajP6kGDNQwoybddhhrowrByFgoJzKziQJb/5D2SzdGAQEA03lYBKIB5hEAAcmgDcM6R3JuII4O3GiRgIUIEEatkJ6a1lg5KYyy/HhA5KYL3EGEeyE/+CwvJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=l+37lTOT; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fqDfJ2cf4z1XM6J4;
	Mon,  6 Apr 2026 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775491442; x=1778083443; bh=j9OD7vqSiCYVvXvuYP1jAJNj
	P20HZctFlPrlHiGTk00=; b=l+37lTOTzq0wjWgpP/s2Q1TsxgWKGbcH9noT94Vr
	dTuFg7O31mOiC1gzV+Zt/g0nKvkNSbnO/EnifWlSnpx/ShHhOpb49mNPZZ4JZfOm
	23HNw88Efpl81AUZB54QwHza+nurnspTZkllKYKjuG/fYz1M33r2P4+vUBbJ8r/4
	P7uO8bEQZnVoBgvDq/FgYW68F+Ge22DAvoQcbPjvxuROK44OQ+8zr8gHs5+/nyeR
	e3NnRG6Mb4SBihnux96lLO+/ltyiDgFs2OKcPYw++LM0qyvwfV3s0wCIpOCrbzNc
	+/FSoWEMf5tnywwDw5xFBMV05lycXfq/u/63qWUwvGooUQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id I7nVtyXFyYmb; Mon,  6 Apr 2026 16:04:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fqDf53nJ3z1XMFjb;
	Mon,  6 Apr 2026 16:03:57 +0000 (UTC)
Message-ID: <17af030c-feea-4ad0-b297-74a5df209e6c@acm.org>
Date: Mon, 6 Apr 2026 09:03:56 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Disable timestamp for Kioxia
 THGJFJT0E25BAIP
To: webgeek1234@gmail.com, Alim Akhtar <alim.akhtar@samsung.com>,
 Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403-thgjfjt0e25baip-no-timestamp-v1-1-1ddb34225133@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260403-thgjfjt0e25baip-no-timestamp-v1-1-1ddb34225133@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22795-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,samsung.com,wdc.com,HansenPartnership.com,oracle.com];
	DKIM_TRACE(0.00)[acm.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: 1B49E3A50FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 11:41 AM, Aaron Kling via B4 Relay wrote:
> Kioxia has another product that does not support the qTimestamp
> attribute.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/ufs/core/ufshcd.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 5c3518f1f97c7f85854b66bf87c86d00b539fba6..4805e40ed4d78cd4b0c07cda0df6bb0f7e172cb1 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -315,6 +315,9 @@ static const struct ufs_dev_quirk ufs_fixups[] = {
>   	{ .wmanufacturerid = UFS_VENDOR_TOSHIBA,
>   	  .model = "THGLF2G9D8KBADG",
>   	  .quirk = UFS_DEVICE_QUIRK_PA_TACTIVATE },
> +	{ .wmanufacturerid = UFS_VENDOR_TOSHIBA,
> +	  .model = "THGJFJT0E25BAIP",
> +	  .quirk = UFS_DEVICE_QUIRK_NO_TIMESTAMP_SUPPORT },
>   	{ .wmanufacturerid = UFS_VENDOR_TOSHIBA,
>   	  .model = "THGJFJT1E45BATP",
>   	  .quirk = UFS_DEVICE_QUIRK_NO_TIMESTAMP_SUPPORT },

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


