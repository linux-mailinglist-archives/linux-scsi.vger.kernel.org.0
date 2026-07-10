Return-Path: <linux-scsi+bounces-25968-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8E8oAdsGUWqR+AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25968-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 16:51:07 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D4873BEA0
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 16:51:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=ctyfqVxb;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25968-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25968-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC847300088C
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9CF2DC331;
	Fri, 10 Jul 2026 14:37:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7FB349CC2
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 14:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694246; cv=none; b=VBaM1UQuya6qXOqBqnU5KT+32dWjAHqXzuExIO+VUuCRQ3nxlPU/faLjWWrEDOTj1gvoVbauoFFdl2BWuTUuaZY6ojN11VTzHG1NlVCa3UXiQNJ8/SCGqMMPo6639WTLAh2dmLFIKGMm/zqFkwXSgdQ5cuvhhgdHZ8C177Mp30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694246; c=relaxed/simple;
	bh=YdiRV9OZD2/cW1IigQUj9kZwi9NL4a+BOChZpzYEajA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqyNniyutQzGfkQfUf3jBn/+BECdfUpNsWG4VXrx53kONaN8eOFz/Q9srLH9b8j1aeACWErpN3IYJqvLUWoB85DzC9RMbqATiEV+dsb4B3TksWILlWBR4KCn2WwNMNxAbtQizgAUGbrMM1gvnk0iUf+1Ff2+VxXHlR6HEofRLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ctyfqVxb; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gxZDN5cPTz1XM2FS;
	Fri, 10 Jul 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783694243; x=1786286244; bh=YdiRV9OZD2/cW1IigQUj9kZw
	i9NL4a+BOChZpzYEajA=; b=ctyfqVxbzkLc1/vHypgsaGYtQIssqRw2M6ZRtkzC
	0mYDFPJOsCQIOn1Ubu5CV5YdlPFwUwA8ofUhldjr+k0OV3eCtzbfpZL5f+jCxonf
	yrJiow9kX/xGe9jmmELqBGkcOYG7D+Cpn/9cevstzdXawFS32jQFpX+8UKK//r0f
	PDbiBCPdaD5QgNWZjE02L9Pk5nXlBueklIJrAt3Fjw1CNkzjFSn4RjlR4ja+tGcH
	eNIHtIhJPDkRgwAHRi9MJ/Ub17XNt4CBGNCGZad7aVZ5oDT+5NxVb2CL9q+jISb7
	QFTnUVgZ2GoydGHfFpRdXAxlgECuA3j9HONsH/X6dlJe5w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vY_jXKAvSEhZ; Fri, 10 Jul 2026 14:37:23 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gxZDK4pBsz1XM5kW;
	Fri, 10 Jul 2026 14:37:21 +0000 (UTC)
Message-ID: <512639c6-3f18-4577-bc4f-7aa8b7e1caf4@acm.org>
Date: Fri, 10 Jul 2026 07:37:20 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: scsi_debug: fix REPORT ZONES alloc_len underflow
 OOB write
To: sashiko-reviews@lists.linux.dev, Ibrahim Hashimov <security@auditcode.ai>
Cc: linux-scsi@vger.kernel.org
References: <1357dbf9-e135-4ba3-896d-1472a208f82f@kernel.org>
 <20260710055755.53830-1-security@auditcode.ai>
 <20260710060543.621591F000E9@smtp.kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260710060543.621591F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25968-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:security@auditcode.ai,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:from_mime,acm.org:dkim,acm.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6D4873BEA0

On 7/9/26 11:05 PM, sashiko-bot@kernel.org wrote:
> On 32-bit platforms, kzalloc() takes a 32-bit size_t, which silently
> truncates 0x100000000 to 0. Calling kzalloc(0) returns ZERO_SIZE_PTR, which
> bypasses the (!arr) NULL check.

Ibrahim, do you plan to address this finding?

Thanks,

Bart.

