Return-Path: <linux-scsi+bounces-25017-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FwZ0F9VRMWrjggUAu9opvQ
	(envelope-from <linux-scsi+bounces-25017-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:38:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ED668FFEC
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:38:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=Mj662X1Y;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25017-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25017-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C427303FB4E
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B768319847;
	Tue, 16 Jun 2026 13:38:05 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71F30B529;
	Tue, 16 Jun 2026 13:38:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617084; cv=none; b=FRCYWd1kwG6SXfIThV9QW6tuzzd9DDHMnGo2b5M5QYUXamWzp+g+cHmq5eZXBXZIUiJRNle2iNs0uQCNgC0Hya9GtN1Dnau7UW5McoqQgbjJ4yYzDBaQZDe5bMVG/uI4Lv5/yfVq4488P8pkld75iADmhdx7JTTpw++k3IqAA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617084; c=relaxed/simple;
	bh=LiMLrj4cuFPiOK244lJKnP5Ht3rcEBebE5gLFRG4qLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnTgGaHbSmRiGVqaP2NLWZQOZT6VEZY4gAi9xqwFEgJqdr31i1zFn+efnXB5ku8EErBD93/iFFrC0AFxkL6fexbTDfy7CdIVKEOelZ2FYOhbW5Bv9vH7WS+dpwKtt5N2CYtLyRMQJjiffls+qDWdI6fxmBRW5XpNKb1MbJ2Pobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mj662X1Y; arc=none smtp.client-ip=199.89.1.16
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gfp2s6g49zlfvq8;
	Tue, 16 Jun 2026 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781617073; x=1784209074; bh=qzdnOS/8bKYKFDfK3PT3Mo5H
	mZfwIr6BF2MF+JM/FUY=; b=Mj662X1YTWfQYs0OV5XZRf5ZJIQJDxmkbKleC87o
	3+N6hYODcASR4VECI7FDe8L4OHuAmsWjHEPaYCjXEsxDh0N8KhzmMLnyQp61s70w
	TDbesq7K+9wO74YE60Yk+nUSaS5iayb8FuFyBuujPVl+yA07Kl6ekK8h/jbu2duN
	66fBI3bXqW2rJrIHrw7WcpcTuoy8/hHoErd948uNGIcAYRNv81yMj7umBPC7msuy
	7kDjzYvbs54BdwlaiA5wkzTt09mL+RI1QqzyQ+YkqEBTphUy0Nfe5eBxK9vUPr1Q
	0s939g0jPlZhDT4a+AY2j4HR1weR6r6q8wqa1sd23RNMIw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GDooQ5cB0UZF; Tue, 16 Jun 2026 13:37:53 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gfp2j3pTyzlgwNJ;
	Tue, 16 Jun 2026 13:37:49 +0000 (UTC)
Message-ID: <c040d167-8747-43f7-ac30-2f5c5bcfbc02@acm.org>
Date: Tue, 16 Jun 2026 06:37:43 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: ufs: sysfs: Add HS_GEAR6 string in
 power_info/gear sysfs output
To: Himanshu Batra <himanshubatra@google.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, vamshigajjela@google.com, manugautam@google.com
References: <2026061659-enjoyer-boogeyman-25c0@gregkh>
 <20260616100121.548759-1-himanshubatra@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260616100121.548759-1-himanshubatra@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25017-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:himanshubatra@google.com,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-serial@vger.kernel.org,m:vamshigajjela@google.com,m:manugautam@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,acm.org:dkim,acm.org:email,acm.org:mid,acm.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3ED668FFEC

On 6/16/26 3:01 AM, Himanshu Batra wrote:
> In power_info/gear sysfs, currently it supports output only till gear 5.
> If operating mode is gear 6, it outputs "UNKNOWN".
> Add support for HS_GEAR6 string in sysfs output when operating mode
> is gear 6.

Some general advice:
- New versions of a patch should be posted as a new email thread instead
   of as a reply to an existing email conversation. Replies to an
   existing email conversation tend to get overlooked.
- At least 24 hours should elapse before a new version of a patch is
   posted. Otherwise reviewers who are in another time zone don't have
   the chance to reply. For large patch series, more time should elapse
   between reposts (e.g. one week).
- The "scsi:" prefix is no longer used for UFS kernel patches.

Since the code changes look good to me:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


