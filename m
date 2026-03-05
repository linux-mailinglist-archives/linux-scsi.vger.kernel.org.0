Return-Path: <linux-scsi+bounces-21497-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCn3AGR1qWnl7wAAu9opvQ
	(envelope-from <linux-scsi+bounces-21497-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 13:21:56 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93021184D
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 13:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69A5A300AEC7
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2026 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211E139A07B;
	Thu,  5 Mar 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W6By8aBD"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208339A045
	for <linux-scsi@vger.kernel.org>; Thu,  5 Mar 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713075; cv=none; b=lU8oNp5T8lVsnPaqz5H2bOGiPVSbFAayTRUZfVEptNgSrH+2rsBqkqELWAy3alJyePRzmQhup2pa9M75G2CS+AGfedZjAmvxetVcL5qfKyp12/a+WSAZXUcppbxR4Ua0ZMlYBHs+Eon0P3pL/3wkOjli3AHdEBfSaKaUVx7PGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713075; c=relaxed/simple;
	bh=kHSIPJIfnwUpOMZlm7i/lE3/Vc+6Ug21lWIRJICzF5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAiVh4d42XMaWEOF/NOBDCiQUmmJi8X+i2JkjYgAmbjfyRboH4NTl+/O911ZCUPXQYahXGK3z4Tsn9vybG+0vyfOICfx1/Phou1zZ5gJnGVfjN1Xx3Xx+bXeUqRrdvGVRIVCnIOw6S9K/TvO8rf3WkjDkPHVKNwYx8ZJ48nsY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W6By8aBD; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fRT7z3M8Yz1XM5kW;
	Thu,  5 Mar 2026 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772713064; x=1775305065; bh=4Rp+9sPntSPjnpvZo0an8fyg
	pRvqZVF/+n4W1+h1feA=; b=W6By8aBDX6dURmH6Py/yLiGvlBaIQGZWS5GAo4wI
	tVNj80eO0C1ijfZ3TPs5mlBSKSPdDxnWZgVE+WGMRskZVMug0BMvNG81ba5SvXEE
	VrROnkxXbW8ZoOrOx9sMcIB1jm2BvdtGICXgzPaxZBDOeMVPRVuTwshHBAFGz7Kg
	Y2CKTOybvwLRrjhBofHD6Q4B4+CIPqvY+Kqxc3VG2lUvhxYePiet//newjiFnM67
	lSE8oFeEJqKKVTOGwgaYU1HbmKfNOmK9l9wX8wnf4Z+9Lfz0ft21zcLAg09e9xNX
	vUC4GaN8cOkuoYaeLTxiq1DJZDfDUrCxn+/+CxUUCtmV/g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nh_vDxGnM4bm; Thu,  5 Mar 2026 12:17:44 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fRT7k31R0z1XM5kD;
	Thu,  5 Mar 2026 12:17:37 +0000 (UTC)
Message-ID: <16a44a0c-1fcf-4e3a-bf9e-d29ca5f62157@acm.org>
Date: Thu, 5 Mar 2026 06:17:36 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: Avoid IRQ thread wakeup during active UIC
 command
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "avri.altman@sandisk.com" <avri.altman@sandisk.com>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: =?UTF-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= <Alice.Chao@mediatek.com>,
 =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= <eddie.huang@mediatek.com>,
 =?UTF-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
 =?UTF-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>,
 wsd_upstream <wsd_upstream@mediatek.com>,
 =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
 <Chaotian.Jing@mediatek.com>, =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
 <Chun-hung.Wu@mediatek.com>, =?UTF-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?=
 <Naomi.Chu@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?VHVuLXl1IFl1ICjmuLjmlabogb8p?= <Tun-yu.Yu@mediatek.com>
References: <20260304071346.1391315-1-peter.wang@mediatek.com>
 <ab2de228-47f0-40b0-b586-c970a9c0652a@acm.org>
 <fa949b2c2f9d23fa112f8b37377ca2f23c5bb258.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fa949b2c2f9d23fa112f8b37377ca2f23c5bb258.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6D93021184D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21497-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,acm.org:dkim,acm.org:mid]
X-Rspamd-Action: no action

On 3/4/26 9:27 PM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> The main reason is not context switch time.
> The problem is that a threaded IRQ handler can be preempted
> by a regular IRQ.
> When the system is busy, for example during kernel boot,
> there are many other module IRQs present in the system.

Spending 500 ms in interrupts without giving the CPU a chance to run is
excessive, isn't it? Anyway, if you really need this patch, please
mention the above information in the patch description and combine the
two if-statements into a single if-statement, e.g. as follows:

if ((!hba->mcq_enabled || !hba->mcq_esi_enabled) &&
     !hba->active_uic_cmd)
	...

Thanks,

Bart.


