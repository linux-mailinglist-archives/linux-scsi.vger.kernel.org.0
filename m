Return-Path: <linux-scsi+bounces-16803-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F5B3E696
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Sep 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F261018839B9
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Sep 2025 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B3340D92;
	Mon,  1 Sep 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="v67RJxNk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE61A9FB9;
	Mon,  1 Sep 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735445; cv=none; b=YQ0mCsd/1gUbzzzbXgiiE1uR7Xj6MSDoxbVg8iaAU926qARt7VSmvwJBPmWLP7cZU4WgRETm25edWG5ck3XRvJTwV87mMHBj47Oqznn7K8pgGQTVMWj+EGcTpfCSkYOoMHkhR8iqmGbbo4S2jP4PM0CCJN4iJMKu5QWeyRbbZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735445; c=relaxed/simple;
	bh=+hwP3xG8hny6UJazsfzuu5L1juPTsKDvfJvUA7LZdA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfDy+1MyrZgpsM4qb8r7clKlCAk08GDnTYamCCJOT6r4cLi2YUgf7GnRCkALbj1a5DwOuUl90YwPuH7svWB8OlWRuB/7YCEgk85yvVqSl/ysAGxUXdj84q+0cbd08RJUKdcUrSxZrFl87t25QEHOog1yVplVpfcU6d/kuTYtej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=v67RJxNk; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cFrFt52cczm0ytk;
	Mon,  1 Sep 2025 14:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756735434; x=1759327435; bh=dgHC5+NvmTQCkq0nfHgYdKe4
	UamSLLVPI9XD16xmMcE=; b=v67RJxNk5DmUb/ID4E+4iQSa9hmNGPOZee/x46Rg
	xR+108g//t260r5DlpD3h3U4K4SwfNoQFuRUIDUuiMBN0tVCKDa0XkV956iMmV+y
	E3UcUjPT/c6y/qpVEEtlqkjcD9LdqYBkG5t9On6LnqNPi62LCfVZlcQbfhQxIcvE
	S0WXsT1ZHYZikiTr1t7bxbQUHWkWQkfscnKmD8OeEhdDvWagtyUEd4DOsHSw8VCC
	AuOfPTJ9L1JVUkIiMBC7GeOpf7HmWwG6lP3PLT9mvRMNTOgOCG41XQp2lnNAwyTV
	BGCBSCc7T0Dkjyn2jUkoura9vVDK7aLQzDfJ+ub7hfYzNw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4gL-uVnhvnOO; Mon,  1 Sep 2025 14:03:54 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cFrFJ2wTCzm1743;
	Mon,  1 Sep 2025 14:03:31 +0000 (UTC)
Message-ID: <27882582-58b8-4ac2-9596-3602098e7c1d@acm.org>
Date: Mon, 1 Sep 2025 07:03:27 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: ufs: Add an enum for ufs_trace to check ufs cmd
 error
To: DooHyun Hwang <dh0421.hwang@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 peter.wang@mediatek.com, manivannan.sadhasivam@linaro.org,
 quic_mnaresh@quicinc.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
 jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com,
 sh8267.baek@samsung.com, wkon.kim@samsung.com
References: <20250417023405.6954-1-dh0421.hwang@samsung.com>
 <CGME20250417023417epcas1p31338c05e70e61b0a5e96d0ac0910713d@epcas1p3.samsung.com>
 <20250417023405.6954-2-dh0421.hwang@samsung.com>
 <239ea120-841f-478d-b6b4-9627aa453795@acm.org>
 <093601dc1ae0$2389c460$6a9d4d20$@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <093601dc1ae0$2389c460$6a9d4d20$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/25 6:31 PM, DooHyun Hwang wrote:
> UFS_CMD_ERR stands for "completion error".

No it doesn't. In the UFS driver and also in many other driver "cmd" 
stands for "command" and not for "completion". Please change the
"UFS_CMD_ERR" enum label.

Bart.

