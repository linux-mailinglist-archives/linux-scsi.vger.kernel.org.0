Return-Path: <linux-scsi+bounces-24442-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5BLCImGhIWpEKQEAu9opvQ
	(envelope-from <linux-scsi+bounces-24442-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 04 Jun 2026 18:01:37 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCC641A94
	for <lists+linux-scsi@lfdr.de>; Thu, 04 Jun 2026 18:01:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=O5BQm2bv;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24442-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24442-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA2430103B7
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jun 2026 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672C3939A6;
	Thu,  4 Jun 2026 15:51:21 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599A3947AB;
	Thu,  4 Jun 2026 15:51:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588281; cv=none; b=iX5lc1oK+I8GJUQHktwTR8n0kHsp79hfppWoHG0g4F1V1q2q1RRc12lJvWoUDr3wjHQ2AcG4JwHu5Lss/HaFA3Rqx6ZDdi6LBOS2H+gvRWw5wDs3bdlwKV0s19Yu3ZPYfCjhGWEYc53avAVZvMjCvMQJWBrbNGBw22TYSlLPwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588281; c=relaxed/simple;
	bh=qf7BSRzLg3pE6s+V4fZtBGGx2xpaq4OxAFsqiuFjqnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+Q+kC7YTH0hFtXYAw4CHG+Dvwn9yZ3LirSaXTvMTb75lgl/BnGnEJ0axYHGUaMJXMoy13qCmpOjVOeXjypyzyXp78zDwgbO8KbEwlhh1Rq0LVZcbPYfM7Ehh3yXAQdHFgI1MVk9HjOASdOWL8C16lBZaHfJizkYpbqtwCtqm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=O5BQm2bv; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gWTZH38N3z1XM0pG;
	Thu,  4 Jun 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780588270; x=1783180271; bh=qf7BSRzLg3pE6s+V4fZtBGGx
	2xpaq4OxAFsqiuFjqnk=; b=O5BQm2bvIOflduS8ue3Vhs54lkXqxheP5NEQYUix
	BYnUYOGZEZB1F0BkcWsXZWkL3Gj7QuiEN1DEYBsiX9kfWCv8jIMbwQXWebJ14Gv7
	6LXCmOsWlNElQpPL/s1W7MXG388GqFP5WB5CxvHkwlX3xxAlirOUkzicg7/25rof
	+p/Fi+S7RbBtHVD+UgfowNKaEbm10EpOMQw2ZDZhurw3YiaTZsNXIjRU/0ZWKelQ
	9dAesgM8lvsyuUOget83yIauRMNo1ChN84m6DAkkvdHClpvoLNbuopSUeqySyKCX
	4cJ+UFgJM/tgBeK04oJIlbLzqzBZ+i0+IiQRdEb8j6Rjug==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nZ_TMzKG8sVB; Thu,  4 Jun 2026 15:51:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gWTZ14FT0z1XM5kD;
	Thu,  4 Jun 2026 15:51:05 +0000 (UTC)
Message-ID: <88d9bb41-e51d-4b71-a6d9-f1b79eccd496@acm.org>
Date: Thu, 4 Jun 2026 08:51:04 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] scsi: core: Remove remaining reference to the
 pktcdvd driver
To: Catalin Iacob <iacobcatalin@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
 <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-1-e2f06fb4eef4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24442-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,alpha.franken.de,linux.ibm.com,ellerman.id.au,kernel.org,libc.org,physik.fu-berlin.de,davemloft.net,gaisler.com,HansenPartnership.com,oracle.com,kernel.dk,users.sourceforge.jp];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:iacobcatalin@gmail.com,m:tsbogend@alpha.franken.de,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:dalias@libc.org,m:glaubitz@physik.fu-berlin.de,m:davem@davemloft.net,m:andreas@gaisler.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:axboe@kernel.dk,m:ysato@users.sourceforge.jp,m:linux-mips@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-sh@vger.kernel.org,m:sparclinux@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-scsi@vger.kernel.org:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:from_mime,acm.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CDCC641A94

On 6/4/26 6:20 AM, Catalin Iacob wrote:
> Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind an
> export that is now dead code. Remove it.
The subject should say something like "Unexport
scsi_device_from_queue()".

Thanks,

Bart.

