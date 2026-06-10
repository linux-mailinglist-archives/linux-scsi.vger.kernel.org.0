Return-Path: <linux-scsi+bounces-24661-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KzQhNle/KWq1cgMAu9opvQ
	(envelope-from <linux-scsi+bounces-24661-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 21:47:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F266C92A
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 21:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=acm.org header.s=mr01 header.b=ZEgvhFh3;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24661-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24661-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=acm.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6DAD300681B
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408829BDBF;
	Wed, 10 Jun 2026 19:47:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC530ACE3
	for <linux-scsi@vger.kernel.org>; Wed, 10 Jun 2026 19:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781120850; cv=none; b=UzAaWd36IZ1vlCyXZOr5lgT9EFt/LMPHbtqMCmLzBCH5YFSv0ZS552evSFirsU+aS4pJVzy7WGsne5nCwD9bqE60AlHbkvNc3YtXkyUzDFHNehmZNQ9iSZJYKnpLEt+6De2Ztn10fyUS4Uf/2PwezNZBoz/XrQyj65/jKytTS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781120850; c=relaxed/simple;
	bh=E7CuLlKDZQznwpaWJphoeGTh2ZPlfY1z5LRT1Dzsgs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poCS46rv3Xp/ssDtvTPz0M0OGdcid5BzmTIxAv5r2H7N9yOQUWpzE9N1cFNdQ+xVcS/AioATfRp7NfuzSIoP/Dfl3JG2efzCkGYgSYJtiwxjKojIL4+o17s+5KooS5hdlOfOSSmF9t4skOwpzWXMsYg+I4in6tF94wCrkwGhOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZEgvhFh3; arc=none smtp.client-ip=199.89.1.14
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbGX05D3nz1XLyhV;
	Wed, 10 Jun 2026 19:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781120842; x=1783712843; bh=E7CuLlKDZQznwpaWJphoeGTh
	2ZPlfY1z5LRT1Dzsgs8=; b=ZEgvhFh3aWTwzPvm/qnW0WCvohpmGvo+U1XLlAs3
	GjdJrtY6HX+CODsE9bCHSxywwBNqilyNA280kb0REZemR5DTwz3jW1AYTtOkV+QU
	IcCAcZCN9uC+YwtF3AvGmf1qvV+Ftsvnjx4nNg3fdFhO8M9xPgJBncASch0/b+2A
	XkwJxx4ilpgKHyAgc+Vq1JiO7PwJX+BPVmZFoA0V/0W8SfUIK4XaI9b+6OfYAkRF
	purUxEZshqtEnBnFzQUtXBRDLxheQrNqqk3DWZjKawpxqovbiCB6Ic4DmVhT9rtp
	i4AYjzQYGybZAXPLO/U7GQQGnPRyDe/lfcqhlmLkXAAgAw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aY3bP3U30VI7; Wed, 10 Jun 2026 19:47:22 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbGWp0ZLdz1XLyhT;
	Wed, 10 Jun 2026 19:47:17 +0000 (UTC)
Message-ID: <42164c06-3c54-4d66-a29c-1e0d46210472@acm.org>
Date: Wed, 10 Jun 2026 12:47:17 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: Remove unnecessary block I/O quiesce for
 clock scaling
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@wdc.com, alim.akhtar@samsung.com,
 jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com
References: <20260604133503.2049288-1-peter.wang@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260604133503.2049288-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24661-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peter.wang@mediatek.com,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:avri.altman@wdc.com,m:alim.akhtar@samsung.com,m:jejb@linux.ibm.com,m:wsd_upstream@mediatek.com,m:linux-mediatek@lists.infradead.org,m:chun-hung.wu@mediatek.com,m:alice.chao@mediatek.com,m:cc.chou@mediatek.com,m:chaotian.jing@mediatek.com,m:tun-yu.yu@mediatek.com,m:eddie.huang@mediatek.com,m:naomi.chu@mediatek.com,m:ed.tsai@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:email,acm.org:mid,acm.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF6F266C92A

On 6/4/26 6:33 AM, peter.wang@mediatek.com wrote:
> Hence, it is not necessary to stop I/O during a power mode change,
> and this step can be removed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


