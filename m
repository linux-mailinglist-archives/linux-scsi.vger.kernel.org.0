Return-Path: <linux-scsi+bounces-20559-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNyBELyed2kCjQEAu9opvQ
	(envelope-from <linux-scsi+bounces-20559-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 18:05:00 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226B8B42A
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F6AB300DA47
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CC3451C6;
	Mon, 26 Jan 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aQq8HjPM"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EA33E372
	for <linux-scsi@vger.kernel.org>; Mon, 26 Jan 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447096; cv=none; b=FsWEDE0SCcG7sTI0pO2aN+Fht7mpYgWAaUuqv3HBeZBd6WzpfBpGRWpGbrE8mNFXXGMHO98KpPXVAqfVsOWFrcHcZeSlNngHFz0lWM7PtxjwnZGoJYhINt5vsI9W1JVyo51OCLr7CbiwCzSBURDpulHZDQ1eQH4movlgdrfPzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447096; c=relaxed/simple;
	bh=DzH71sGLTHY/4umdgPz2Kx0QrBrLABDLct1KfBk3znQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISrABUXsq11XPEhCVMN18sf9WINP2bx3xmCOUUMAhnuNnaCFcBJSwvjcFWK1+/Ub4ZSehcFZU9vsK9Shrj+FgWSEnEVHs/QAT1r6PLNu5sK853Baw9fAQo+g7gYi8oCsVbLQqCku/Igm35rV0upt3PStkabDkgn11M7yMs9gAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aQq8HjPM; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f0FJk56Xvz1XM6Jf;
	Mon, 26 Jan 2026 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769447093; x=1772039094; bh=sdASKopwoGV8Tlli2UBc+oPt
	bWwSMfk3K/1cyNX5XMY=; b=aQq8HjPMqlBDgiFixDHNhub9ApJtHBS63dKSnOQ1
	8NIn34KW5BISpgdaZH1BDxAlCULW/zhujBi7tN7mWMu/aMdHxtT3M80u+ENHPrPm
	PRSV2WB5lDe5B6Br8AAJeHxEXcMCG6cZkyotuB+57CLiam12ouytJu8X3tT3BlUm
	wgD+RSytE3fGBeupKDQO3NgngoNSewSoAeTkg6vFkdlwBqQkJZpR2/jT6+uKy6zn
	ZtFJDNF0cid4P7xKI4fXUyedfhOLtB/PfomebhrV8bBCK46bpk71NBKMaZ5TfvSx
	LQ5+kf2lIJgNXVK1OV5RQ/HYWgUm0Q8km45Wn/9rZPhnoQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bl6d10Cmguzz; Mon, 26 Jan 2026 17:04:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f0FJg59tQz1XM5kD;
	Mon, 26 Jan 2026 17:04:51 +0000 (UTC)
Message-ID: <1f5708a2-b00a-4be1-a005-c5137ce5863b@acm.org>
Date: Mon, 26 Jan 2026 09:04:50 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scsi: sg: Resolve soft lockup issue when opening
 /dev/sgX
To: Yang Erkun <yangerkun@huawei.com>, dgilbert@interlog.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org
Cc: yangerkun@huaweicloud.com
References: <20260126132745.1830629-1-yangerkun@huawei.com>
 <20260126132745.1830629-3-yangerkun@huawei.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260126132745.1830629-3-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20559-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: 9226B8B42A
X-Rspamd-Action: no action

On 1/26/26 5:27 AM, Yang Erkun wrote:
> +	/* limit "big buff" to 1 MB */
> +	if (size < 0 || size > 1048576)
> +		return -ERANGE;

Why 1 MB? Please explain this in the patch description.

Thanks,

Bart.

