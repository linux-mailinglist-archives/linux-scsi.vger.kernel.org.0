Return-Path: <linux-scsi+bounces-23793-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q6o2NP7zBGoTQwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23793-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 23:58:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 383AB53B32B
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 23:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E03B53031137
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 21:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCE3C9885;
	Wed, 13 May 2026 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BAT30BIr"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB73AC0DE
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709499; cv=none; b=Ve1V5B//DdjeKXwr3DazWNgI0QpdG+R4amo/e8X30MDiZfVY6vYnCA6lptv+vsSFgZQSYWb1xBiUQWYrtNYMXX24pKT0PGiceIaNPnheWlLBjCNv+FLsOBQ2Gjw24nJ2Phz1k3BPsolE1ewlBmZYJIP8fVasbTnDHGqfh3IvM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709499; c=relaxed/simple;
	bh=3ZGqfX/XJm6+kW/6aoQQ6C67mHI/BjyyP1/qvEhoZ+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uzTrr116Qe7EOr+Sealedswzpb8RiZWL7nqlKkgiqNERFRgHtvSILYwyZrgghqYKOL3fob7nar8If3KvSGkoMHyepdQuF898MJ/oT03IQE5ZE7JAIxyqalOtndnKJRivNIxhlq1dQ1ewdWH/KTWnNp5J9/YFCuqfeqGEHsYQsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BAT30BIr; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gG6ls40yPz1XM6JX;
	Wed, 13 May 2026 21:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778709495; x=1781301496; bh=04MNijexQ2VdxtfvFtPUEW4g
	5OZCxL22C4joWuxWeuU=; b=BAT30BIrcBeq243PwSxmn62tWaBsz432HBY3RAO4
	U5+sn573B7DWDgf7o8W6ErC/UBV7wETi0SOdf+IlNQssG3BGx/qtlBM1IpRYK/oJ
	Ar6nAIuh3Klsb6snZqyxd0Wv2h5sHNdJLRwqg7xdF0hbk/LclW3duOJix4IevU+5
	GkpdfHeDHlUfsx82EutVGBNXNRfmbJmNkwmS2qX+YQvlz8oQSU//49KvWluKywC2
	azAktDKsvM3PdkeEnZHTC3OFlSS5T4J74xFrrCg3Hpob8OIL3FCD1bxzJnTSQkHc
	V+/WlD009q1nZNFUFfxVSekWeRJoM3plV4GCLFdty8l+6A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZoqKnE-aDfN8; Wed, 13 May 2026 21:58:15 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gG6lp2yyZz1XM6JP;
	Wed, 13 May 2026 21:58:14 +0000 (UTC)
Message-ID: <65a4ac0a-ea6f-4a83-958c-169d4e2a62e8@acm.org>
Date: Wed, 13 May 2026 14:58:12 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: run queues for all non-SDEV_DEL devices from
 scsi_run_host_queues
To: David Jeffery <djeffery@redhat.com>, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260513173552.9222-1-djeffery@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260513173552.9222-1-djeffery@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 383AB53B32B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23793-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Action: no action

On 5/13/26 10:35 AM, David Jeffery wrote:
> +		if (sdev->sdev_state == SDEV_DEL ||
> +		    !get_device(&sdev->sdev_gendev))
> +			continue;
A comment would be welcome above this statement that explains that 
get_device() is called instead of scsi_device_get() because the latter
skips devices that are in the state SDEV_CANCEL state.

Thanks,

Bart.

