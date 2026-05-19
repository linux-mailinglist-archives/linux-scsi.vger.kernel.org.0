Return-Path: <linux-scsi+bounces-23923-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPwTL9rRDGrImQUAu9opvQ
	(envelope-from <linux-scsi+bounces-23923-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 23:10:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C576A58502E
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 23:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71170305D5C1
	for <lists+linux-scsi@lfdr.de>; Tue, 19 May 2026 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2815F3E2ABF;
	Tue, 19 May 2026 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="O4x250/J"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A53E3C46
	for <linux-scsi@vger.kernel.org>; Tue, 19 May 2026 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224872; cv=none; b=cLW7zXqe2Ugcs6d4V9QwpP3GcJLou4RQ64AjujI27ukmvpusG004la4g1bYPrBRUb/a6W4ahd+wepjZkgCalEi+mFufokXaAEHweNAdkf/+YUWE++FpyAjuB+s7GcvD1hHJoF42X3s9CLPdAArUFweCGwDfFlVg+d9S2o5bUdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224872; c=relaxed/simple;
	bh=c3y1RI0Ifb8ics+JlKUWQ5DENDN84udF6PlUaqcWjaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2MpjBi6VcZt0yk6kpimUu6uRyfW4PMtM87fhPQjvzNUgH/jxybgK/nN0BBmPhywK50j1Nx+9TbFSDJjJH//XwhUwBd1H+fesJdGr726hd3yeiforhbHSIAGBX11J7TAHODPR/RwDF9oifhNn36cXwBz4yr8663YlzUDlxG6TyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=O4x250/J; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gKnLn5wGQzlfgS0;
	Tue, 19 May 2026 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779224864; x=1781816865; bh=yefsolRAAR6ovHixH9nidgEo
	0SlacCFYq9g1nlTEJeA=; b=O4x250/JGeCExgmdDJqJfJqXBCCZ5PILfYIV4ov7
	2P+m7VIP0NSPUs0NC/NGPqouCZgaOId/a5SF4cYtA9kjByCmf3IrHFvR4Mkm26+7
	7LLBDxD/dMOp9wgfeQVNLi1Njyk0Ov1Fz7v9Xg6dyUf4MqtyhLrj0xD5tqsp/k+4
	llOMAbUXpGzTU9YmB49gTuJrlqjJ5qnpAWg4kSdJ6fN7aj/elTlfa38/5wXcFmFz
	4cbMVzqPOe5mqyV6yzO25JJo6bxks0+3TZ/gi4Zf4Y9X1nCXXYveD9IXMelShcV9
	6cphM1pw7sd5OBHTbMovGM2UsPcUbfzmaY2Zneve+vGcEw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dygXnzUaepjv; Tue, 19 May 2026 21:07:44 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gKnLl4pcfzlfgf6;
	Tue, 19 May 2026 21:07:43 +0000 (UTC)
Message-ID: <ec8a26ac-8471-4339-84bd-bbbfdf51bb28@acm.org>
Date: Tue, 19 May 2026 14:07:42 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: scsi_debug: Missing "\n" in sdev_printk() in
 scsi_debug_device_reset()
To: "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org
Cc: john.g.garry@oracle.com
References: <20260519205356.1040855-1-emilne@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260519205356.1040855-1-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23923-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,acm.org:email,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: C576A58502E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 1:53 PM, Ewan D. Milne wrote:
> A "\n" at the end of the sdev_printk() string appears to have been
> inadvertently removed.  Add it back for correct log message formatting.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

