Return-Path: <linux-scsi+bounces-22429-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPMFCRyCwWl2TgQAu9opvQ
	(envelope-from <linux-scsi+bounces-22429-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 19:10:36 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B88D2FAF9A
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96DA33FBE9B
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Mar 2026 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9956F3BED24;
	Mon, 23 Mar 2026 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cZmAgSF8"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D6E3B9D9C;
	Mon, 23 Mar 2026 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284629; cv=none; b=rcRaAvVAtwPc51gn/5tBsLyVXiKxdN0l1uY+aMMo8zSTaSojb/I94e9k4ViffmY2aYzClYnR9WpgcKvroBipom+EHwyfmLJg1aFrrWGVFX9VZKdpxc+v1XIIG/vrwNc7cmOd+UpoNGcC8rzaPXaZWKrL7FSVM/D17JCyicrARQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284629; c=relaxed/simple;
	bh=tnYgYuXcIQ+7TyrlpDweAiws5Bn+1gGFhpfnZ5U278M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFvo6wYlyYddzK725DFa+uRRbb3K3mrVN2hqVoh+/zjFlVNn5ECHfQ47XFCPCq9RcnnghMFE2Mqe9Eu+oRss5m9mk+8Hn2buy4WV5x1tB27dFp2iOjwokVal0Kn0Cawk5cqdeWU26HXRlPGsbjLE/QNOrcNV+2JxVkfW5xBa46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cZmAgSF8; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fffLC4TTWzlfgf6;
	Mon, 23 Mar 2026 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774284622; x=1776876623; bh=tnYgYuXcIQ+7TyrlpDweAiws
	5Bn+1gGFhpfnZ5U278M=; b=cZmAgSF8XR0jmYZg+cG2x1O/nIHOVtv1GjfSUfng
	U/2DuCC65H/v4fpjDf0qO8g91kRXtEXS89oIzsztbU6gF3VChoJ3I4xRTeYlcL/v
	RFZavO1PscnkxJr/s10xeECZZZyRFU8Oor+KaPQSmd5R0wggSWkZVFZHO2baftGi
	jr1hdNsOYormjBJi5sPcZNEBsMUhqmfdEhQFAdV8bxXck+TSn0sbM6J3CZ5vVeAl
	GHM6KatjVPa9Szz4Lj2bJMxx1hgLzoWKlrpE0na/Bfg6Mq1pMi6xzLgtSvIV54jJ
	AHEPvjykSZVneZob2VVRwlJ2eVU9PzBQHAiZWB4tUMl3Zg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lPQOGTM2giwg; Mon, 23 Mar 2026 16:50:22 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fffL35kDCzlh2g8;
	Mon, 23 Mar 2026 16:50:19 +0000 (UTC)
Message-ID: <7ab9845d-cb7d-433c-86f5-96b9e48f650d@acm.org>
Date: Mon, 23 Mar 2026 09:50:18 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] scsi: ufs: Add TX Equalization support for UFS
 5.0
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, peter.wang@mediatek.com, martin.petersen@oracle.com,
 mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "open list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-mediatek@lists.infradead.org>
References: <20260321031021.1722459-1-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260321031021.1722459-1-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22429-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,collabora.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: 8B88D2FAF9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 8:10 PM, Can Guo wrote:
> This patch series implements TX Equalization support in the UFS core
> driver as specified in UFSHCI v5.0, along with the necessary vendor
> operations and a reference implementation for Qualcomm UFS host
> controllers.
Once Bean's comments have been addressed, feel free to add the following
to all patches in this series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

