Return-Path: <linux-scsi+bounces-20560-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEOUMDmfd2kCjQEAu9opvQ
	(envelope-from <linux-scsi+bounces-20560-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 18:07:05 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D848B476
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D577300D709
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254D348477;
	Mon, 26 Jan 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dVFGLP55"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8A433508F
	for <linux-scsi@vger.kernel.org>; Mon, 26 Jan 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447223; cv=none; b=ajtsJ74D6hG+vyfSLUSq0Hlam1CEJWbG39M68EGXmBKW3WTn0DPWZpkE2ONL76V2P9EphlR8w9JLzO5rm8L46IoUDItHvH0cpoXHdE6iKKAE38RlEzMIrOUQVGY3oQjVTRWFZarPpNZ9QTWdv8woqHuBWm6oYnV0hjkP3Kp0jEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447223; c=relaxed/simple;
	bh=lpvfQTJ9QgMxJJoR0JcXBck12pj91R/OL4I336bTNTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjBVL7Cq9HKWEWYhp5lBjIVviIUbfCVIgSARkuolWbka/JvXXXT5t6xT9wC7kDQeBCVS/ol3vMpm+FHhpqlJypUhvEOkbeCoA5gMIaH52+RwHkBrguBDbco7Zx4P16zgun+uvgjk9oF/Zmbn2S6+2G2QolZVZMMiay6DXPaeMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dVFGLP55; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f0FM95V3wzlfdGT;
	Mon, 26 Jan 2026 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769447220; x=1772039221; bh=lpvfQTJ9QgMxJJoR0JcXBck1
	2pj91R/OL4I336bTNTI=; b=dVFGLP55EhFPSYEtrTzHw2MYVZ/bWoAp+Uc6JfRh
	RNCHf7LNX9UGhGZHMq4JXzgcc9HZPxViwyV7dPY5cesv9sYO8iNKIwjoLGm0jy41
	DoX/zzrHNCDZit0ZUhuCuTEXoz4tPgeVzTeBnsF3kugEfZCS735n40+hUlyq05r6
	SzWCexr0H2RfRsHDANOn3Z7S6LE3KS76iQNu0SI+8WCJ0ZM5zH5RJ9Clh4R3StdI
	wvHE+76cA5dZUCmF5gc528mIzzk3Ze4OCPyabgzZRL/CyrJ+vEHFQoD2i9snC/Wz
	zqGO0znZ1ErzW+t5+zbJbpEocfW9Z+7da49f1CTAdriJ2w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id adO4h9_7BCSS; Mon, 26 Jan 2026 17:07:00 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f0FM65F01zlfdCs;
	Mon, 26 Jan 2026 17:06:58 +0000 (UTC)
Message-ID: <fc0c8b16-2ca1-41c5-8310-e722c68a10cd@acm.org>
Date: Mon, 26 Jan 2026 09:06:57 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scsi: sg: Remove deprecated sg-big-buff
To: Yang Erkun <yangerkun@huawei.com>, dgilbert@interlog.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org
Cc: yangerkun@huaweicloud.com
References: <20260126132745.1830629-1-yangerkun@huawei.com>
 <20260126132745.1830629-4-yangerkun@huawei.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260126132745.1830629-4-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20560-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39D848B476
X-Rspamd-Action: no action

On 1/26/26 5:27 AM, Yang Erkun wrote:
> These deprecated sysctl has been gone since commit 26d1c80fd61e5

gone -> broken

> ("scsi/sg: move sg-big-buff sysctl to scsi/sg.c") and nobody has found
> this. I believe it's time to remove them, which will allow us to clean

them -> it

> up a significant amount of code.

Thanks,

Bart.

