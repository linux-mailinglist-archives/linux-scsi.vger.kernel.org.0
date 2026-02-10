Return-Path: <linux-scsi+bounces-20780-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC26CKVQi2nwTwAAu9opvQ
	(envelope-from <linux-scsi+bounces-20780-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 16:37:09 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6E11C92B
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEE2C3039803
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Feb 2026 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941862F39AB;
	Tue, 10 Feb 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cZScGban"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B832E2EF9
	for <linux-scsi@vger.kernel.org>; Tue, 10 Feb 2026 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737821; cv=none; b=THCIrObLlSzGZ2t5l+l9Yql1BFzsn+LPOtoJRBjl0cWu/VqvA8e+NTymj9/+3/FHVA4QsvwTgOwZQ4kyJ8tSRv6lK8Y+xGQfexuz6HAb9PPTetyI0OnIhhTnw+LsTO5RfeTPPkdmQa0ic676pwbKwKiZMbpyvGsylVhMbsuLudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737821; c=relaxed/simple;
	bh=1S4hsAn1m49qU3ZXl00mqnrVkIXGIH1xbwj9Vsd8xc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mA6nUChYIGRsOVHwiLpy2Kg904rNcoy9iUtOPz29CpKr+J0au+yMdUnmXU1hXEx4nVHyN0TyVbzfJva4Hpz245prt4ZH/lGFJpkE/YQx6BbFaPJT7COMT8jgKn020bG0FMm/63eHDK14ZpKsLsh8NmsT83mHbmvOxhEsL+8XAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cZScGban; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f9QfM50VZz1XM0p3;
	Tue, 10 Feb 2026 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770737818; x=1773329819; bh=1S4hsAn1m49qU3ZXl00mqnrV
	kIXGIH1xbwj9Vsd8xc8=; b=cZScGbanUXe/t1doVEm/kMCBwHJ4odLQyLCq0fwr
	1Tn8X1C/pf6ifva7M31CHCrzBxLSIEfkmRBXhxhpwskodndEA/Ik0QHylbLuIOFY
	thbxTbziCEEg/SJnhM/IWOjO4Qmy0E0uRwQEcqtxu17EZVsHhBr/oc5XWA8Galga
	Cj5BVrI1KOeS6zuQ/j9wZubz8WqsWQceY/VAroWIFszAo9Hp9fs/TfH3PZcMAOmB
	SuVGK1OV78oMWjRtmoo0siZ37KHGFzk2VOytLF8T0+AwEm8e6HtnwyZfn26hXEbU
	8UxNzguXwBFJ6/qzUI/AAAbmMZdzIwioWdbmXVHR1h/fOw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S-zNJOJ2NipH; Tue, 10 Feb 2026 15:36:58 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f9QfJ5yQbz1XM0p5;
	Tue, 10 Feb 2026 15:36:56 +0000 (UTC)
Message-ID: <2a5ff9d9-62f5-4cdb-8f08-1cf04c20dbfa@acm.org>
Date: Tue, 10 Feb 2026 07:36:55 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: support UFS 4.1 CQ entry tag
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "avri.altman@sandisk.com" <avri.altman@sandisk.com>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20260209122101.1529379-1-peter.wang@mediatek.com>
 <19842000-3d35-4585-903b-2c194efce209@acm.org>
 <e998c4af94010d8951c51027c4a961e5bca26985.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e998c4af94010d8951c51027c4a961e5bca26985.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20780-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CF6E11C92B
X-Rspamd-Action: no action

On 2/9/26 7:39 PM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> By the way, do you think it would be appropriate to create another
> patch to change hba->ufs_version to hba->ufshci_version?

Hi Peter,

I think that would be a welcome improvement.

Thanks,

Bart.

