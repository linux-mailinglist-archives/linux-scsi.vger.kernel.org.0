Return-Path: <linux-scsi+bounces-24415-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kxtyL3lVIGpc1QAAu9opvQ
	(envelope-from <linux-scsi+bounces-24415-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 18:25:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4E639B36
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 18:25:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=kzeDaQCj;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24415-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24415-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C08F3005A95
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jun 2026 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8275E3E5A3F;
	Wed,  3 Jun 2026 16:21:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9203E5597;
	Wed,  3 Jun 2026 16:21:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503703; cv=none; b=uDnvz1MrrAekmPdxk7xSotSGG+AK3lxlMoI/n7ZsDR0iuRnS2m2twpsZbBIWlEFoIVX6KWEdiIV9qVOC2aMJulE/DlHNw7FK2ITWUDHvJ21Wl0RcSMO8ZzVXGzrqwlvKonx879+jbHokPvENnMdbSRkt/x2l6d8dgx9AqqJMZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503703; c=relaxed/simple;
	bh=YKacGXftUpz+Bz+g63upEFrrj4VliZtP90KZstDDdA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luaPTxMcaYRzLa8TWszPuUqMvrM/ZzAldW26xB0ubBi38jeEr1LHb3UxHqpSRDy2JmjNp2bqd0Ndhs4hOMTmN3UIHmQ7BU0oTiLPCKJ2Aau6zfiq0ecwk8rlu4f3SdxFWvoP9xkb4xx+O14MwngCOrOZd89Lyki0NlcIqOQoGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kzeDaQCj; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVtHn4yDlz1XM0pB;
	Wed,  3 Jun 2026 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780503698; x=1783095699; bh=YKacGXftUpz+Bz+g63upEFrr
	j4VliZtP90KZstDDdA0=; b=kzeDaQCjFgTepyltdh5lEN5H1nToXet813SYX8ke
	hw6p3GTsvzU6HVL/S+Mvg3K0VK+ABfAH78MCEC1okgUcmb8ZHF7SfUQtPq2E6Lwd
	3X6oPNiqjAE2SAoX73hZyh8vT5tV1sPF2To3P66m3OF+1yDx6E36ZdMxVCvskr5R
	aw8pJ4HBMf3xPapeSNXqtBXGV/2RXZvB98HuTWr+JROaM4+eTws2bz1TZ3dY8p9L
	3KD22tsZzY5Gkx6qi1xLXOccOaLCLFz2a1S8X1+wOVctGmmuRiejxlQVaBtPMdgG
	DGWRbE1mxMF5GfTh0AaMDkGrSCN1eDPyCU9C22ICHvz4Gg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WeMYgfxfxJle; Wed,  3 Jun 2026 16:21:38 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVtHg6tM9z1XM5kW;
	Wed,  3 Jun 2026 16:21:35 +0000 (UTC)
Message-ID: <6212330e-d9bd-49a9-ac43-86421d20a623@acm.org>
Date: Wed, 3 Jun 2026 09:21:35 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: ufs: core: handle PM commands timeout before
 SCSI EH
To: Hongjie Fang <hongjiefang@asrmicro.com>, alim.akhtar@samsung.com,
 avri.altman@wdc.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, peter.wang@mediatek.com, beanhuo@micron.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602124103.1581617-1-hongjiefang@asrmicro.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260602124103.1581617-1-hongjiefang@asrmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24415-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hongjiefang@asrmicro.com,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:peter.wang@mediatek.com,m:beanhuo@micron.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,acm.org:from_mime,acm.org:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59B4E639B36

On 6/2/26 5:41 AM, Hongjie Fang wrote:
> A PM START STOP sent from the UFS well-known LU resume path can race with
> SCSI EH.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

