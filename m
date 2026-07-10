Return-Path: <linux-scsi+bounces-25969-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQQSEVMIUWoR+QIAu9opvQ
	(envelope-from <linux-scsi+bounces-25969-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 16:57:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247E73BFD9
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 16:57:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=J2Pala4i;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25969-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25969-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF44304C07B
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DC8431E56;
	Fri, 10 Jul 2026 14:47:16 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737B5430CC5;
	Fri, 10 Jul 2026 14:47:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694836; cv=none; b=Bpf5GUmqXmw+RMwxhMWnFODlSxj6SvbBaJLuie8UiSXTNHo/sQFSlTsaR+XpyQFERbjYE6bRizJlKIGV7mDYdD8gEHJdPAjA3KhMZnW6k1gUsmD1n4Kq2B8Kk4apBgenkEs9WtUSgnuh/7zmAkRh8u5lATCG2GRxi5msiwjwdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694836; c=relaxed/simple;
	bh=POqwcdHcpscz1y3DezXHaVnEUYftR7WIU2tXLiLnDeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdrxBaQzvoUoRHWvOm6qj1STW1kpF/Zz6uyAU+/ZsH9ap5z8UDwA941czIRkJv8Faa2WUXECBP1ip4lAmoxE+zHta6p5940J+Icr2F/Lg3dlPZOQFws7HfQUEdhcxxNXQadN+opo7iLeYp9JKmys22xzgcIaUP+mncl/LQgCbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J2Pala4i; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gxZRd146Mzlh304;
	Fri, 10 Jul 2026 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783694823; x=1786286824; bh=bdAKnK8os679pGOewYuuhBSP
	yqHJgd6ADT1TQgqo0o8=; b=J2Pala4ijASB/8Q9sh3FiBns86l5UrxT4SjzeKEA
	puCJ9Glv5OrGMhQQVm3HWJZC4HgyEaNPa9X71QfHpSLDBFRRR5o/vu4c8sZ6BYYC
	4a/XhVu5AO4GP1fZcHdVALI7yPA0eTmRk8+/aFMAAhEzA6Vr3E/Fd5ZhNx7rGbM6
	GWLb8F+tkuJ78ApME0I6/f6BzI9XsrSJv8+BI7Fg/UDfomN1AneACa34CjdKbs5B
	LQjAkuH8GU2WhBiki0/Y3FQZSNWApc0wtkwk8+8JpRMvBUUmR4/XxEZjobN8Hizz
	WdC4Ic2yllcCVC5kpd3RrAkn4a+zkAGM8k5E/uyI2V0mww==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v2fkS2rGdq4e; Fri, 10 Jul 2026 14:47:03 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gxZRP16drzlh2fy;
	Fri, 10 Jul 2026 14:46:56 +0000 (UTC)
Message-ID: <6d087f28-5795-4929-b5d3-3f78d9b9bc60@acm.org>
Date: Fri, 10 Jul 2026 07:46:55 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: Add support for the aggregated read query
 opcode
To: hyenc.jeong@samsung.com,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: ALIM AKHTAR <alim.akhtar@samsung.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jinyoung Choi <j-young.choi@samsung.com>,
 Dukhyun Kwon <d_hyun.kwon@samsung.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Keoseong Park <keosung.park@samsung.com>,
 Jaemyung Lee <jaemyung.lee@samsung.com>, Jieon Seol
 <jieon.seol@samsung.com>, Gyusun Lee <gyusun.lee@samsung.com>,
 Yunjae Jo <yunjae00.jo@samsung.com>
References: <CGME20260710053524epcms2p82121eba4240c37112fc5669430035442@epcms2p6>
 <20260710054556epcms2p68986e2af26f42e63c87ab8fde034e450@epcms2p6>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260710054556epcms2p68986e2af26f42e63c87ab8fde034e450@epcms2p6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25969-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hyenc.jeong@samsung.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:alim.akhtar@samsung.com,m:linux-kernel@vger.kernel.org,m:j-young.choi@samsung.com,m:d_hyun.kwon@samsung.com,m:jeuk20.kim@samsung.com,m:keosung.park@samsung.com,m:jaemyung.lee@samsung.com,m:jieon.seol@samsung.com,m:gyusun.lee@samsung.com,m:yunjae00.jo@samsung.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[acm.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,acm.org:from_mime,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9247E73BFD9

On 7/9/26 10:45 PM, Hyeoncheol Jeong wrote:
> struct utp_transfer_cmd_desc {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 command_upiu[ALIGNED_UPIU_SIZE];
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 response_upiu[ALIGNED_UPIU_SIZE];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 response_upiu[ALIGNED_RSP_UPIU_SIZE];
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 prd_table[];
> };

This change increases the size of every CQ entry and also of every LRB
entry by about 4 KiB. This is not acceptable.

Bart.

