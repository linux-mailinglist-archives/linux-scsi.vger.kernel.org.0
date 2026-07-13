Return-Path: <linux-scsi+bounces-26062-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TGZ8C7fgVGosgQAAu9opvQ
	(envelope-from <linux-scsi+bounces-26062-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 14:57:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159E74B2AB
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 14:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=tG6QDpcl;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26062-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26062-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04D5E3024C8A
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C4409134;
	Mon, 13 Jul 2026 12:55:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1223B0AD1;
	Mon, 13 Jul 2026 12:55:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947323; cv=none; b=Isfbrxi70/kOOPaoE8BTlOr13oWkeBU6vSx2Ap69wF+OQDdU+IYFjOTPVzJV9FLD4RkU3pmyMH2H9fWSE3Na4asHhB5YuHm2n/0lWpWSA/RWFUX9Zm6HPTWexkEOg/wqrpXdNxLc+Iv3NSH17gZ6xdqNMPbBYEnhrJw6LJau0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947323; c=relaxed/simple;
	bh=cYr1+KwtV4KNwQRSLNKJMkkhT4wWNQ8pYJ9i6VxfJe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6SfDvg9/LLxEPhrbGwWrRkfFHcyKyuBVBtWzHXB1+DIZ1M819vjW7G+eq2OH0T2/ImL6kDiPTxtGrwoIwvzh1Xrw+XDz03B6TuwhS63goGi7sTdWo4/UYxDIMljSAT/dB6fNv4v5DXWoDYIvLlBsX8CQioLEoRC8lWv3bWXtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tG6QDpcl; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gzMq71qr2zlfpM9;
	Mon, 13 Jul 2026 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783947309; x=1786539310; bh=cYr1+KwtV4KNwQRSLNKJMkkh
	T4wWNQ8pYJ9i6VxfJe4=; b=tG6QDpclc3jtoZyK/dILhZSrzED1bWpWYfbRrWV+
	SHPJUg4uH6IsiLreSCdMQnQqpsH6QCCksAH6UbvQACjrZZKGJbzWIENuCTsq0Pc9
	HVOxy3Gj1YRkePYcONgh9f7tSikksrveWfyhFmGlvZ9MRJjzjl7ILbe7sKUOiYup
	KH5IvjpPLYqZlpGdrr8aHje3QpQsDPPpjWmK26qbGjp42o6v1lAXCAS3yVs9hd3v
	nAj19JXgynCKFU/dCRztLf7Ayl/7F/zlrHtyPQoFg5EO2TNzoNmHsMx9JSKKU0G5
	lTKHExn9mlujYlDa2QyON8SjoZ7ZzgYI1otHWG9E9dQhEg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yNl0xkdai_q6; Mon, 13 Jul 2026 12:55:09 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gzMpw0yXCzlfl7l;
	Mon, 13 Jul 2026 12:55:03 +0000 (UTC)
Message-ID: <a0d5f2bc-c343-43c5-93c9-a7b58be13242@acm.org>
Date: Mon, 13 Jul 2026 05:55:02 -0700
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
References: <6d087f28-5795-4929-b5d3-3f78d9b9bc60@acm.org>
 <20260710054556epcms2p68986e2af26f42e63c87ab8fde034e450@epcms2p6>
 <CGME20260710053524epcms2p82121eba4240c37112fc5669430035442@epcms2p4>
 <20260713025227epcms2p41de509bb713eb7a6be2c945073be6b3a@epcms2p4>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260713025227epcms2p41de509bb713eb7a6be2c945073be6b3a@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26062-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hyenc.jeong@samsung.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:alim.akhtar@samsung.com,m:linux-kernel@vger.kernel.org,m:j-young.choi@samsung.com,m:d_hyun.kwon@samsung.com,m:jeuk20.kim@samsung.com,m:keosung.park@samsung.com,m:jaemyung.lee@samsung.com,m:jieon.seol@samsung.com,m:gyusun.lee@samsung.com,m:yunjae00.jo@samsung.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[acm.org:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8159E74B2AB

On 7/12/26 7:52 PM, Hyeoncheol Jeong wrote:
> Would it be okay to keep utp_transfer_cmd_desc as is and give
> just the reserved tag a dedicated 4 KiB response descriptor?
> Regular tags and normal I/O would stay unchanged.

That sounds better to me but how to implement the above proposal
without slowing down the hot path?

Thanks,

Bart.

