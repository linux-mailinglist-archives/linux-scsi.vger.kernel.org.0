Return-Path: <linux-scsi+bounces-21427-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDeEM2xFqGlOrwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21427-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Mar 2026 15:45:00 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CA201D99
	for <lists+linux-scsi@lfdr.de>; Wed, 04 Mar 2026 15:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54986306E18E
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Mar 2026 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09C32773F0;
	Wed,  4 Mar 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="klIvLfhE"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC33368AC;
	Wed,  4 Mar 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634330; cv=none; b=cLqlE8ocWAsbLVmVaoX49hRZcle/wHx05UExFxAFBsSbrZ0afxFcVz354alZKc8cO4omYmYmTO40nWP6yxvC8FpfxjicN+SFqvPejTwVTxIoH5ghElhUazMdBvjO3P/mxoXdBYj7F2okbaUreVI38oJuT95kC6Ls6ndOm5PJ0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634330; c=relaxed/simple;
	bh=CYYZFBXwN5hLcJjmD8p9NlVeHj6KIPNb+aqcEn3zFCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5QDoPGFsP+0n5LXy5nn6W0M6eqbi0ujCe/t5V7XxATYHvg4I3IyIf/KorVok0uSilTh5Ad8pUAazPkihE/9bggbpgpWxJgJdN1KM8PrxTl06KZ+cbI/2ks6ebq/2rcZIL2tAMw+i6CegUtKQEw8pC2DZq+dzquaCB4Fdmj73i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=klIvLfhE; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fQw1b5Y0Tz1XM0p0;
	Wed,  4 Mar 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772634320; x=1775226321; bh=qpoPRz9xGGc6k6Tqitayjjgp
	f15CFuUVlTQ3OPtZlN4=; b=klIvLfhEjv06rb2GrjvASjYxqjUjDXTRs/4Z+N0W
	jQnJLLqRb3YI2L+UUWCkvnq+YtTDrKaWAfYHhE7A7g4LNXdfuAwWVRbBMtn4tRSO
	KkKZhG0RTV4CMKgOa6v1A4iP2dE4p66/jssODvnFVCS5WCl99fpq7xebWWS90G6s
	JTgptm06v2eQdBEJNETXhyoAmcX/c2DB5SKNBrGPy+gh2egkGE8x6uKFmTlo+Mgk
	BsSSbit3E0HkL//ERVqRWFS7Jv3D/kpC3jiEY1Gk/8js1g5jKloK+seOIDZPHbP9
	v5YU1szZmNOVtjhrGebnpCyFaE90e1djRc9N3q+ezCh/Gw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6Q-RK_rdm3_S; Wed,  4 Mar 2026 14:25:20 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fQw1V0GThz1XM6JV;
	Wed,  4 Mar 2026 14:25:17 +0000 (UTC)
Message-ID: <3d9c22b4-1b1f-4432-a6ed-eaa2494e4ace@acm.org>
Date: Wed, 4 Mar 2026 08:25:16 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: core: Fix async_scan race condition with
 READ_ONCE/WRITE_ONCE
To: Chaohai Chen <wdhh6@aliyun.com>, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, dlemoal@kernel.org, hch@infradead.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304092939.3092102-1-wdhh6@aliyun.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260304092939.3092102-1-wdhh6@aliyun.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DD5CA201D99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21427-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[aliyun.com,HansenPartnership.com,oracle.com,kernel.org,infradead.org];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,acm.org:dkim,acm.org:mid]
X-Rspamd-Action: no action


On 3/4/26 3:29 AM, Chaohai Chen wrote:
> -	if (!shost->async_scan) {
> +	if (!READ_ONCE(shost->async_scan)) {

Yikes. I'm not aware of any other kernel code that uses READ_ONCE() /
WRITE_ONCE() to access a member variable protected by a mutex. Please
annotate the async_scan member variable with __guarded_by() and drop the
READ_ONCE() and WRITE_ONCE() invocations introduced by this patch.

Bart.

