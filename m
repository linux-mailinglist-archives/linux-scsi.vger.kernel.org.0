Return-Path: <linux-scsi+bounces-7768-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210549626AF
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Aug 2024 14:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA4E284AF1
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Aug 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6CD174EEB;
	Wed, 28 Aug 2024 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ykda9fou"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D215ECDF;
	Wed, 28 Aug 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847321; cv=none; b=fDnd4jHel0nOd7TZPzeNuVl3az2qSAT4ugVKx1ZdoENS2MApaVK0X8gfGVq41HSLxYL9OnqudqMd6+FlZ7/xv84GjGkltIhJixrLqQAN2F866LMf/N1muDnsSXRUOq/1ZT0LAbMzxkK/TJXmpfin8+6PJOs0+SsyoKdF0WFNYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847321; c=relaxed/simple;
	bh=u0U0w2KJGk12N/InZ8Kdd8T1U1acO8s0pZrR1LEcIYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InuPbherToL56aaRUxHlUCAiCJvkBIrqLF+e4wJrJNIzTTn66Py8Gck/Hi0DQbq0R4mmnrVZvv4JjGr3Vbtl1G4z6+hD3YOdiZsbgD6ICE4olTK62PqHlAMXmibSPEuKaMwgY3ya6p5ioIHOeUiWasu9VbfVYZqoQ1Wv+75I/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ykda9fou; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wv3Jl6Yh2z6ClY93;
	Wed, 28 Aug 2024 12:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724847316; x=1727439317; bh=u0U0w2KJGk12N/InZ8Kdd8T1
	U1acO8s0pZrR1LEcIYs=; b=Ykda9fouXAtjd/vZd+7+58HYJB8S7L16klwPri8F
	neACtfst2ofpfyv8ECEqVk+NjGtp6cSUvYCAKxNFGdkOnenNbmZjEfbreNSUTaO5
	5eohpu12UrCbyNSXl4CRnPp9FrocV/UTORK8lmQw4YteXK9bpiDJ3EqDKgR/VKye
	1i5XLVU29sPy9X2cPoAl2KfKLGRI56J0Cw8OfLdAAVpgfc2KsWLDnJvULKB1dUbu
	n3hYJFVRCPU2qnJ+DhO8zM5fIBHdGJX9eLC8/qkXvoBnbTqbcmPdgQPyOthSB+qe
	1fUTrXLlTpJRY+E+uveqBlqpghZ6AXGXVyTYNA0biWG6AQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5cruENmqAjIF; Wed, 28 Aug 2024 12:15:16 +0000 (UTC)
Received: from [172.16.58.82] (modemcable170.180-37-24.static.videotron.ca [24.37.180.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wv3Jd4d1wz6ClY92;
	Wed, 28 Aug 2024 12:15:13 +0000 (UTC)
Message-ID: <2cfcaf59-fc6d-4f89-a24f-6bc028956c78@acm.org>
Date: Wed, 28 Aug 2024 08:15:12 -0400
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: update MODE_MAX cfg_bw value
To: Manish Pandey <quic_mapa@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com,
 quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
 quic_rampraka@quicinc.com, quic_cang@quicinc.com, quic_nguyenb@quicinc.com
References: <20240828120502.1439-1-quic_mapa@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240828120502.1439-1-quic_mapa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/24 8:05 AM, Manish Pandey wrote:
> update cfg_bw value for MODE_MAX for Qualcomm SoC.

A patch description should not only explain what has been changed but
also why.

Thanks,

Bart.

