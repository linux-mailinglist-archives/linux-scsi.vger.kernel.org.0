Return-Path: <linux-scsi+bounces-23589-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEICDl4N+Gl2pQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23589-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 04 May 2026 05:07:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EC4B8274
	for <lists+linux-scsi@lfdr.de>; Mon, 04 May 2026 05:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE051300159C
	for <lists+linux-scsi@lfdr.de>; Mon,  4 May 2026 03:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA891BBBE5;
	Mon,  4 May 2026 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="u6Q81iJ4"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751782899;
	Mon,  4 May 2026 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777864022; cv=none; b=GxoOmg/TAvK1nixSjNl3awKrAalkVnwba3LpQfOJdlNgKj7kuCIVZveUsQGOCIectmcNOfa2YFhu4JY7aZ9zs3CI6BxUroQaW/BcVQIckc/oX6kGKhiFVDjSiJ7/oc+Ghp/NPnSIV+MYUuxi6+1Yu/qdNAL7C5BQBUWC8rXcEhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777864022; c=relaxed/simple;
	bh=MlZ8DmybwxzfdW+ce9e8Ujj7GDyK4RR6mlOqmitwOVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBoOnCqY7PKpfixYZF5+3IlFeV4zQWYQv3W+GAPitFEsWU0xNfv6KzFfYZFdYhrSqTqE5pUaLnwQ/zfOZW2TuDpECGVtIJG3dFB4tkVpK97PphF6WAVeQ9LBQB3ZF2cNmPs4r52BntvLLtDBS93xnKetF478ntRr92Pr0bGPVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=u6Q81iJ4; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g864j0Sysz1XM6JY;
	Mon,  4 May 2026 03:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777864017; x=1780456018; bh=MlZ8DmybwxzfdW+ce9e8Ujj7
	GDyK4RR6mlOqmitwOVE=; b=u6Q81iJ4oSrLuKkUshaWW4+4ZrG4ze0GIRZ/ffyN
	3j7Ay12dib49XVsg2o3IZf9q19qK1+BoAodrGaue+q9me+c45fXbouJ901aq35Xe
	cN3DiLnE4trLoPgAH99QAwEgJUwmyBOzPWzayCOKm2aKno+Sqnt2vaHWg8N0Tci1
	ZgU/xWNtzSz0+5LFMCVTYnvUTkBQrhwaBvL5NFnGj/Duwy0RgaNBXqhd4w/qiSyJ
	QOdV/CDWDoO3J38sGbdh6X0SHe/iVJJo+3d/iHQGy/05UwzqGxRZfqfMeIDjCIxo
	v4zsa/oNUK4SQe/R/2eeWhpSWmMlHUX0VLhwauEhAhfyZg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u6O9QDUBWCrr; Mon,  4 May 2026 03:06:57 +0000 (UTC)
Received: from [10.211.8.56] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g864X2Hdmz1XM6JR;
	Mon,  4 May 2026 03:06:51 +0000 (UTC)
Message-ID: <f1993d19-1ad1-4e0b-a65d-dca4ebb35736@acm.org>
Date: Mon, 4 May 2026 05:06:49 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: ufs: core: Add a quirk for extended TX EQTR
 Adapt L0L1L2L3 length
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, peter.wang@mediatek.com, martin.petersen@oracle.com,
 mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260501131641.826258-1-can.guo@oss.qualcomm.com>
 <20260501131641.826258-2-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260501131641.826258-2-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 380EC4B8274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23589-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:email,acm.org:dkim,acm.org:mid]

On 5/1/26 3:16 PM, Can Guo wrote:
> Add a quirk to support TX Equalization Training (EQTR) using Adapt L0L1L2L3
> length which is larger than what is allowed by M-PHY spec ver 6.0.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>


