Return-Path: <linux-scsi+bounces-21547-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oISJGtXQqmkKXgEAu9opvQ
	(envelope-from <linux-scsi+bounces-21547-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 14:04:21 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58EE221506
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 14:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9301311D236
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2026 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA98392C37;
	Fri,  6 Mar 2026 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Dwe8ijOd"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7E3624B8
	for <linux-scsi@vger.kernel.org>; Fri,  6 Mar 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801895; cv=none; b=q1ubUIEdWxkfsMtmYKwTJux8afbH9pPBkgeia5zVHa3MM4pzTRw6Uv2ZN64xNcBi7+mg+fG1aoaF0f0mikbQ11G0gMIAFMJ5TiWag3lSe1Yy30+5iOqF8cCB8O+zJh5Q1a9VnBNbp3M/ocTCpNxEfemNy5zD9Yc21vM0U9MkzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801895; c=relaxed/simple;
	bh=VZ5cFyA2MVw0U8rC/u4sU/JH5V0Fn9YqLuUXdUOwJRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9xpPeh0XDYMJ+7+93KkOOTeInD7yi/zPkZrKoi0Z5RxDZfOk2Yi48+IMG6BBfX+vyS2L4SCXLvwD2kmCha4dPpEGLrToZbWokL3MOEBvcTAau4UBIi9EiKqtlS5Smd14Od/FqoPsihcxeYlqoF6XKwYMHZdZ7n9/f2lP/5lXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Dwe8ijOd; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fS60565nRz1XLyhj;
	Fri,  6 Mar 2026 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772801890; x=1775393891; bh=L8dnhySjEDJynYBBgN2AtNp8
	Y0QW0/GbC4EJ7QY3xdk=; b=Dwe8ijOd7Q1WxPiJQSrGZfEnXhsh+vcUrulsc0rd
	2W6SBlZxRYtDMBmBzQw09TojLcceF9+xO4H90ANEqRNvAOp3pCNAwHB8qLTCs1/x
	dXtLjIu0svIbDG6A2Cp0ZxucUAXC46EWLxoELV7rhl2Jd/WSlGa7Np8WRecOgSSh
	Z6fpfpo2M7OTia+EL6hAF2n0UjLdqzg+OghDIERP/AE0ngudaFrVTFc40AbD3R8m
	gKiY8MGVfRy+Sn8GpS2VzhkzLscPv0GBndEsXOFi9Rgi8R0ceuABJUc5ipthn4fS
	m213YLi/JUveNPNzDzshDEecQ4mT59ZFrLepqPqkJZItZw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6BsiQVq3ZRjZ; Fri,  6 Mar 2026 12:58:10 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fS60010qSz1XM0p2;
	Fri,  6 Mar 2026 12:58:07 +0000 (UTC)
Message-ID: <f2edf079-111c-4150-8486-ec1791441450@acm.org>
Date: Fri, 6 Mar 2026 06:58:06 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: Fix SError in ufshcd_rtc_work()
 during UFS suspend
To: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, wanghui33@xiaomi.com
References: <20260306072647.2991132-1-wangshuaiwei1@xiaomi.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260306072647.2991132-1-wangshuaiwei1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E58EE221506
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-21547-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,acm.org:dkim,acm.org:email,acm.org:mid,xiaomi.com:email]
X-Rspamd-Action: no action

On 3/6/26 1:26 AM, Wang Shuaiwei wrote:
> Fix this by moving cancel_delayed_work_sync() before the call to
> ufshcd_vops_suspend(hba, pm_op, PRE_CHANGE), ensuring the UFS RTC work is
> fully completed or cancelled at that point.
> 
> Signed-off-by: Wang Shuaiwei <wangshuaiwei1@xiaomi.com>

A "Fixes:" tag is missing. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


