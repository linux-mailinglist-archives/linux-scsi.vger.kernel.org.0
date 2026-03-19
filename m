Return-Path: <linux-scsi+bounces-22237-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOL3H2kyvGnxuQIAu9opvQ
	(envelope-from <linux-scsi+bounces-22237-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 18:29:13 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727522CFFF5
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 18:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16A1D3085D95
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Mar 2026 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5C0318EEE;
	Thu, 19 Mar 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="H5ne9uKr"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D62750E6;
	Thu, 19 Mar 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940624; cv=none; b=RzH1+5jGzrCOt5QjQMcK72OjJpM3afIO+3zftk0Lz0rlLN0bncEAmsw3MunFftUXGKhOkjFslLzLaQyu5iGx/QGYrEyt0oNwZLkyty/P5JCHEC+4iB8grev3LBjrzFCPz+/nd9b8VBbXclLhmlzJiphO+g0i/o6Beea/Ws6d8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940624; c=relaxed/simple;
	bh=sMs4tbCRE7Y8mRcZnpjGXsMXGLsOdqkSVeqsLVQg8uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBe4Pqe20aoQOx17fslHGzQwbndTNkA5I1Qfm/kVXn/uVARQukQP/Mp4Ey6taGAf6r+17bDiz9vtVxVSTIRFE/F/9HhWkXXxDd+V55xwMu6sz1kdtFKlUAd+f1HHC8E2z8d6DYzFIfLeSKAj2ayXlRu378Xr+Bpsi2iJIUYrv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=H5ne9uKr; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fcC6l29gNz1XM5kW;
	Thu, 19 Mar 2026 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773940619; x=1776532620; bh=sMs4tbCRE7Y8mRcZnpjGXsMX
	GLsOdqkSVeqsLVQg8uc=; b=H5ne9uKr47f+oqrBi0meTojJpIeU2Gm/aFWq+2y5
	N/cl4Vy42hiu5fTfjyiHnaDQZtqs1HEdCNF3AqnS6LKzabchl5mFknv3j2368eLZ
	DPy0mWjuj4iTV4FGIYGKSoeAWdBfWbz7P3CpW5BkrIDzKqzhOxW9Az5NstCLdaRW
	/wHBlZFga+RD1FyXXMcFnBo11aM3N5TU2aweWu32aTlysmSTcIOtgRyQ801sbP8/
	4SuPWvhyYa87EeJPfir44wCPVsNNHdk9M9xhhGXOzRQguGlKK3lq524kwSOqLmMo
	Vjyeoe0Pm5AW388ijsmzaRBeRBwTXLkyhBKLENZ+4mKMpg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id O_tk3I2BQP4i; Thu, 19 Mar 2026 17:16:59 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fcC6d6N65z1XMFx7;
	Thu, 19 Mar 2026 17:16:57 +0000 (UTC)
Message-ID: <21f22aff-afa1-455f-bd0f-3ebb38f6d598@acm.org>
Date: Thu, 19 Mar 2026 10:16:56 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] bsg: add io_uring command support for SCSI
 passthrough
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, axboe@kernel.dk,
 fujita.tomonori@lab.ntt.co.jp, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260317072226.2598233-1-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260317072226.2598233-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-22237-lists,linux-scsi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: 727522CFFF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 12:22 AM, Yang Xiuwei wrote:
> This series adds io_uring command support to the BSG SCSI passthrough path.
For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

