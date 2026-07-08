Return-Path: <linux-scsi+bounces-25892-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +m82Gsh6TmppNgIAu9opvQ
	(envelope-from <linux-scsi+bounces-25892-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 18:28:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1241728B57
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 18:28:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=SJzDUTvd;
	dmarc=pass (policy=reject) header.from=acm.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25892-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25892-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B22530C1D8A
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2026 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196863C0607;
	Wed,  8 Jul 2026 16:07:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD9439356
	for <linux-scsi@vger.kernel.org>; Wed,  8 Jul 2026 16:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526828; cv=none; b=gf3eV+zFWCfRp+dAvMq4ex4qwHTxnu5yLrEFxMBIMidsd5cYBybr+mc0/C2uMz/hGfUzOVIewXIi7x+KB71Zm01lgZI1ZwCc5d8pzRGeeBHDG+2zgt5f+AlX3s976qrMmPYO3uUDqTQ7WgR1KQINZBt+VnrAJHlTA5JT30F6BuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526828; c=relaxed/simple;
	bh=UFiEBVRS9PROgym+dqqynl7PXTinT+Dwdd8YzHJBk3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP/g9Uobo+x1zRpHAOIQObfVCYLQZ444dzMzchr3bAt1AIOZcscLuDy7qds/zFA7d2EOcWVvULRX8XWbR9QkoWQsX0EsRFl5emosj4OMJn73KtmbPP4OFzEMyAZf+Fd+pa6TXUclsIIL0OtA7lleN1OE4GSSZNG1fW0LEcR9lIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SJzDUTvd; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gwNJp2Vhrz1XM6JZ;
	Wed,  8 Jul 2026 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783526823; x=1786118824; bh=UFiEBVRS9PROgym+dqqynl7P
	XTinT+Dwdd8YzHJBk3w=; b=SJzDUTvdKPeEkEkJJ8S493T0iEJUEQNTlOdG3CbR
	pGaJ0+UimrLqGE/Qr2O93Y+ABXfrCqqO/FniSZYyTRtFeOCCLi+5zI7msgOwgi8e
	FX8r8NBhWOO5ilPLboIWiEm07s+fGXgFDvPOh6ruD64WtGPhFzsggCIqX9WQPcNB
	oPC3Tcil+zgiU4VoasESkWmWvu+deJtR4mLHzu4AfqyC3Mx9SX0kr7/KDKt8vNU/
	4hqWYQVYRMYKWaNCyUT9U3zR8zoYYD5JArzMB9q386xlJC07w1zRiVongvGhiOm5
	ggQnVu/sCVVPNg8g+6OWxsnBkkPzvQyTzuyiA0Nleaqi0A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id H45zpPhacvQf; Wed,  8 Jul 2026 16:07:03 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gwNJk2SQbz1XM5kW;
	Wed,  8 Jul 2026 16:07:01 +0000 (UTC)
Message-ID: <6c176ccd-18df-4704-9082-1cb8de49cec9@acm.org>
Date: Wed, 8 Jul 2026 09:07:01 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] scsi: sd: fix sd_done() sense handling condition
To: Yang Xiuwei <yangxiuwei@kylinos.cn>,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: dlemoal@kernel.org, linux-scsi@vger.kernel.org
References: <20260707030333.22245-1-yangxiuwei@kylinos.cn>
 <20260707030333.22245-4-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260707030333.22245-4-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25892-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yangxiuwei@kylinos.cn,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:dlemoal@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1241728B57

On 7/6/26 8:03 PM, Yang Xiuwei wrote:
> Only enter the sense_key switch when the command returned CHECK
> CONDITION with valid, non-deferred sense. The old condition let
> deferred or invalid sense fall through and mis-handle the I/O.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

