Return-Path: <linux-scsi+bounces-20749-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YID+JUtDimn3IwAAu9opvQ
	(envelope-from <linux-scsi+bounces-20749-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 21:27:55 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009011473C
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 21:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E391301E985
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Feb 2026 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA441335093;
	Mon,  9 Feb 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="er0NwkKT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A9241CB7;
	Mon,  9 Feb 2026 20:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668868; cv=none; b=NZd9AOA6C+x/RGlXAZ/FZ/CWjeTKX+P81YRG+fYTfUZS+puD9m9mMpRqcbo+wf7O8TWYx5uDQ3CsDqe9aRsMLZ0evAuXyr4rnTbTKitY/KUvLtPoJagAbnGcaOdya4LjcOuyPBxexkobSHpo+OT5FuMNrY5kRIvxAGVGZ5sDyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668868; c=relaxed/simple;
	bh=b/ZjCjLRzHXYQrCtrtWoFlbEp06eD/9BAsfirO1gHOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeHEtilor5Mk4IlWkcSRSFsXShOmkwQ/kpMxxv1zfeV7NiTcCXoMbhoPG3xznav1sjI1j3KWgtcEmYLpDM4YdX8faI5xIVW6AoC9EcR+AYq5qrv0Y3z5kF24vSrcjGcQa8HUqzLSwTWfiLbB8lfk3eTAtg1n05lWCCGMw2jSUks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=er0NwkKT; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f8x8L5d5gzlfvq7;
	Mon,  9 Feb 2026 20:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770668865; x=1773260866; bh=77XVaVGDr39DEOntM7SwK7Rj
	gXyKO7W57KNbPux9IeM=; b=er0NwkKTw1q/hBm1Sn3mf1uvAeHC5fvys5jSGBKL
	lE1UjbpcWqtZFgzTMQFKGdsu0/cUuMSmSvJV0Wm4Q8Wa68ep48P2yE/qW7nDIejc
	H5DBzHCLcKtFZ6mcC+d8mDkwOcgNY0WJbhT4dkyjnJI+Pc85XLQTarOwGRvhkxyd
	qzRH1al6eiWv7hsXOybkLIYbkbdu4OA29G43qVHA8xt9uVcO9TvR14nyePwEuDSr
	+ihWVCZLW/rJQIC3DcX/ERfhyYSKbTga7/kWyBVD2dj43+9NNNraGZe75qQF61v0
	44KO/+TTsHbTLW6gzEGoOPE1wUWQdg0EYjgKymNS6AMVEQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id twppR57blbOo; Mon,  9 Feb 2026 20:27:45 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f8x8H5bngzlqh3F;
	Mon,  9 Feb 2026 20:27:43 +0000 (UTC)
Message-ID: <9b4de8bc-273c-48c3-9c26-4055b2a5d306@acm.org>
Date: Mon, 9 Feb 2026 12:27:42 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] scsi: core: Add 'serial' sysfs attribute for
 SCSI/SATA
To: Igor Pylypiv <ipylypiv@google.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205180015.2215143-1-ipylypiv@google.com>
 <430f606d-9305-41d9-9a49-b9ab6894cd61@acm.org> <aYo2JBW76jH44lAU@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aYo2JBW76jH44lAU@google.com>
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
	TAGGED_FROM(0.00)[bounces-20749-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5009011473C
X-Rspamd-Action: no action

On 2/9/26 11:31 AM, Igor Pylypiv wrote:
> Instead, I will put a newline
> manually and return the correct number of characters. PAGE_SIZE is passed
> to scsi_vpd_lun_serial() so we don't sysfs_emit_at() to check it again.
> 
> 	buf[ret] = '\n';
> 	return ret + 1;

This sounds good to me.

Thanks,

Bart.

