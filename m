Return-Path: <linux-scsi+bounces-22005-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePjfBH2NtGnBpgAAu9opvQ
	(envelope-from <linux-scsi+bounces-22005-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 23:19:41 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B5528A527
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 23:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ED1D30219E8
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 22:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F8331205;
	Fri, 13 Mar 2026 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tu8EEnY0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DA1DA23;
	Fri, 13 Mar 2026 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440376; cv=none; b=enUr7lQSMe3G1JzpQD3/R5TFHq8ibIhArqgsRQ9ZjaBRWZXkv8JFOI7am1hSLcnlpRSt35+0je5dG6i8v/q5LeOkT0hM/BuIq57gB6B60VwsZGPfsoCuBgrOQDbS+ypmKqGUwvhazZhFDdUoGndYA5a88Nbm6lvQxQMsgHkadVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440376; c=relaxed/simple;
	bh=+EVCDe6JuQXWujCNNoyMj/RxkXXFHryjY8u+ZsZjXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdESqHDTzMIlU9hTpV+ud+yAVTfk+BB1ueGZDtJpAwbQ2fzRAMFlQchIJw3xgonRCbYVHVs3KyPyU1nEpjrW9d821/H5RPWtvF8EgIsRIw2UTAn1LYNHYL4LX9AMuCHbq10U1T/fsKhL94YGwQf0wSQ4nkaQG5sZaavnGYdCy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tu8EEnY0; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fXf6Z1pD3z1XM6JB;
	Fri, 13 Mar 2026 22:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773440369; x=1776032370; bh=lurwe/XLfVuRnkfB4SNOiokc
	8CHU01Nk7u7VwOFfngU=; b=tu8EEnY0pyG3ik7Dt4cmZEFXigszrX9aKBI1txgc
	RxhArsWFmlu6QL7FWXK3a7WrVHvCHH19ZJV6sz3gjpBsu40sz1t7gojqGwQnVyHq
	DaWHlXmnFBSxxznHWmjXAkGPHz1jKVd25mrSeqiDBr7TsfurbFOKHdVmQ89EDv7D
	Qt3cxSVxCoYdx+kVTUMwNWXqFuu12Np5F4XFdIT1s5yW3Yr7RYF1+9RMQPYUWzZ7
	g22OzFdVLllLEqi7g68iGbU3+P4mpl/HXgMPqAH3kDw4kfXRTTzCUHaWVUEjudK2
	mJNun8DZcJ++S680ccSZOCKQNYfiJQVxDNwf8ijI448lIw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EWEd8dGzQOnD; Fri, 13 Mar 2026 22:19:29 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fXf6Q1r4Lz1XM5jn;
	Fri, 13 Mar 2026 22:19:25 +0000 (UTC)
Message-ID: <c44cc56f-513e-457b-96de-203d4b534496@acm.org>
Date: Fri, 13 Mar 2026 15:19:25 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] scsi: ufs: core: Add support for TX Equalization
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Peter Wang <peter.wang@mediatek.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260308151409.3779137-1-can.guo@oss.qualcomm.com>
 <20260308151409.3779137-5-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260308151409.3779137-5-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22005-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A7B5528A527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/8/26 8:14 AM, Can Guo wrote:
> +static int txeq_gear_set(const char *val, const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, UFS_HS_G1, UFS_HS_G6);
> +}

Why UFS_HS_G6 instead of UFS_HS_GEAR_MAX?

> @@ -955,6 +1045,11 @@ enum ufshcd_mcq_opr {
> + * @host_preshoot_cap: host TX PreShoot capability
> + * @host_deemphasis_cap: host TX DeEmphasis capability
> + * @device_preshoot_cap: device TX PreShoot capability
> + * @device_deemphasis_cap: device TX DeEmphasis capability

Please either explain the meaning of the bits in the above four new
member variables or add a reference to the standard that defines the
meaning of the bits in these member variables.

> +#define UFS_HS_RATE_STRING(rate) \
> +	((rate) == PA_HS_MODE_A ? "A" : \
> +	 (rate) == PA_HS_MODE_B ? "B" : \
> +	 "Unknown")

Why a #define instead of an inline function? Aren't inline functions
preferred over preprocessor macros?

Thanks,

Bart.

