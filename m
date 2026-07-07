Return-Path: <linux-scsi+bounces-25873-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HVyGOk0sTWqHwAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25873-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 18:41:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0771DF2C
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 18:41:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=EeEb4OUg;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25873-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25873-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 594E9300C0C4
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55131F9B4;
	Tue,  7 Jul 2026 16:41:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8A25A655
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 16:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442505; cv=none; b=sRDhU+hgBPZtLzI15CRH0Cta4iqS9Eo9rA4nNRsZ8n9Asmc1xMny6lCQHv3ZHZ1hc5JWoX3G2OmDe3lLUurfqr0l5uGfxAbu3UNUTQZD1m9dxycyvK6FB6sf77cPCpJZ/ELPgWLUa6gr2EOlWYRVI72qk/edn1rnHgwXw0N/rTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442505; c=relaxed/simple;
	bh=hBIxdwpKX6b0iYcFLLWOGESCEK+hJn9fX1uXUnoatdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGyRivuiBDj+x3VZYZyfcxXvB0VvYE2oNcA1PrKD8RtpRV8kaQLrQTxW/hmEVUIK40DhZYwh+ub3zBTgGkFE6TzCaBHJ7D48CTErtuEcGXpW3i8aVlRxvtEA7yIskUOENPFs2ZeElpLcvsD3bUMQ0d8rvzSzeanOLdJf/zEThto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EeEb4OUg; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gvn763Nxzz1XM6JN;
	Tue,  7 Jul 2026 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783442496; x=1786034497; bh=lgeAsz2Fv4jmxWdZ+UVQ8cym
	UNPH3QB9TNqvFSHwQd8=; b=EeEb4OUgSgFwpAl/929B50PzA1yWfTepm/9OgIcf
	QxSuVcnHpbfPXAIvSreyUojgVPWPvlEP4QjguYUSymnygKCqGwa0yK0Z4C4uE4bX
	wrcHM497yhowzkwNp5w+z/p69zFcymW19OWgw3Htpxu19Lc4Bxltveonke4smFS8
	T2pR9EiB8+RCeIAnWUSKV9QNU2U2Fui94glg2Invm7qfuHiACAsSFQXxJR6+uiBk
	Mzsoud6AlB4g5Jt2mKpKluOjGyFW2NwCP9uD+A4HJB9/kU/HZUC/8CSOK7GvMbUw
	58mu0R03owr9A34EGLx7PQl59U1zd/YXtTATdg2+Ivf+yQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id L9k2Bqgk7Dtq; Tue,  7 Jul 2026 16:41:36 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gvn735jpdz1XM6JH;
	Tue,  7 Jul 2026 16:41:35 +0000 (UTC)
Message-ID: <20f076dd-636a-49f9-9a02-0046af2db0e2@acm.org>
Date: Tue, 7 Jul 2026 09:41:34 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Undeliverable: Re: [PATCH v2] scsi: ufs: core: Avoid possible
 memory reclaim deadlock in TX EQTR context
To: Manivannan Sadhasivam <mani@kernel.org>,
 Avri Altman <avri.altman@sandisk.com>
Cc: linux-scsi@vger.kernel.org
References: <20260618140941.902000-1-can.guo@oss.qualcomm.com>
 <h5lsilzmxhu3jyujladib3w75nsute7yrkr4t5sg57nwzwb2ek@d4btnbylvrvu>
 <f1960bd5-b583-4104-a343-e217ef7ed63d@SJ0PR04MB7504.namprd04.prod.outlook.com>
 <ucn5winjeqnixycuxldp3wgysrasrah4ie5egs4vo4prvy7e5c@6ef4y2gqqd7x>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ucn5winjeqnixycuxldp3wgysrasrah4ie5egs4vo4prvy7e5c@6ef4y2gqqd7x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJ_BOUNCE_WORDS(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-25873-lists,linux-scsi=lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:avri.altman@sandisk.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:from_mime,acm.org:dkim,acm.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CE0771DF2C

On 7/7/26 9:29 AM, Manivannan Sadhasivam wrote:
> Are you willing to continue your role as UFS reviewer? If so, could you please
> fix your email address to avoid bouncing?
> 
> I can also send a patch for that if you want. Let me know!

Please take a look at upstream commit b65b608eb8ff ("scsi: mailmap:
Update Avri Altman's email address").

Bart.

