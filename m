Return-Path: <linux-scsi+bounces-6744-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3492A7C8
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jul 2024 19:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FCD1F21977
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jul 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC220146A79;
	Mon,  8 Jul 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="I0lcGot6"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD57A14386F;
	Mon,  8 Jul 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458305; cv=none; b=tEECPoxQ89B+YAW7DGW7ACV9h0VNrF4vWG3Rc3neYkmQ5igNDEmVK9+dQh12jir0djnbQHfAbx7odKbjNY1yoxGdCdzfTSlfIVkSswstMglvBNHddlYrzqVEX86/wjHm0XfLXcOGRHC10DmgYKSABlrrBtRI5BD6STcMbbuQewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458305; c=relaxed/simple;
	bh=qAaHfzoMz22v8vuwkp2AqgWndXU56qIjre0k9Q/gfuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I270cFBQfadW+mNE843D4zSicOy2BMm3H4iJkV9Ph4ii4d6xa6N8THeBmRsBVA99S4IH//gOzi5YejFDQjrD1mhFV8acb6Vjs/qRXyDBCTNlUbdg9pnt4mB0m1TYpG5fp3rk0yiVJjOQMV04E90yrPMfRh6Hx5YvEDFX0IGKiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=I0lcGot6; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WHr8T4fWYz6CmQwN;
	Mon,  8 Jul 2024 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720458295; x=1723050296; bh=zuyi/B7gq4uyWUQDBVD2sZtx
	o+eha2O/tA5K7wBSFn8=; b=I0lcGot6LZ9WvWvZczs6js3gXRn/liMYu7ljTaPS
	gkHMIFSyeXsYtwrD8jg2RYtB84LoAjCQVSA48z3AEHuGe7rh7FLz/gXZ/7p7wnW+
	4A/HuFSzPCsCeJKsNqPUZpNoqAPhAlYNcjI17ZouJ3ZdQfTUHStPHj20e6Mv3bk2
	GVKnOl3U9jZTt6uBTT+pnj0wwK2DSXdvU6ABcqilwHO1wjxugDZc6xdjSbxXn9i8
	JY21Eyh+NDjUUQhmhRojAK4ZreftzsZjis+T4afmxs6Q7MKQAAOQG+LiPZhzOOtU
	XXQIke79sC9QUAkL7JaAVtp2MX0QO3a1RVv+CS3P5+OoXA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Bb4kiBD0BM-R; Mon,  8 Jul 2024 17:04:55 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WHr8Q4sTtz6CmR09;
	Mon,  8 Jul 2024 17:04:54 +0000 (UTC)
Message-ID: <434cb981-b0fe-4dd2-bac1-e80de2e68099@acm.org>
Date: Mon, 8 Jul 2024 10:04:52 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] scsi: ufs: renesas: Refactor init code for other UFS
 controller
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20240708120931.1703956-1-yoshihiro.shimoda.uh@renesas.com>
 <20240708120931.1703956-2-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240708120931.1703956-2-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 5:09 AM, Yoshihiro Shimoda wrote:
> +static void ufs_renesas_param_poll(struct ufs_hba *hba, u32 reg, u32 expected,
> +				   u32 mask)
> +{
> +	struct ufs_renesas_init_param param = { 0 };
> +
> +	param.mode = MODE_POLL;
> +	param.reg = reg;
> +	param.u.expected = expected;
> +	param.mask = mask;

Please combine the above declaration and assignments into a single
statement:

struct ufs_renesas_init_param param = {
         .mode = MODE_POLL,
         .reg = reg,
         .u.expected = expected,
         .mask = mask,
};

Same comment for the other functions below this function.

Thanks,

Bart.

