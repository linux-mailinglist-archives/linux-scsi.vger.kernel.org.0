Return-Path: <linux-scsi+bounces-23792-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHGVDizsBGr7QQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23792-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 23:25:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C00153AF6C
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 23:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EFAE301DCDF
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2026 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBF3B388D;
	Wed, 13 May 2026 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s0kFAquk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAA3AF64B
	for <linux-scsi@vger.kernel.org>; Wed, 13 May 2026 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707497; cv=none; b=Te+D3VlUpip+gp/0CmgQLo4ganP7H/d+fTBlyUVCCW68+/N7ZYAJSHkz1HhFbwRb1UTMrAPPYofsM5rhVjDcdrv2vjkFOsvMah/4sdZfa7Y+MNbGvLyFmnm6Vp0TNpJed9xdVJY7oB9pNV6+Adqx+yG8AqN/hXf6xLaQXlwczxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707497; c=relaxed/simple;
	bh=uYGykmdEr2Lwx6NhPemKRyrHazAYZ5oqLqbU2UukICA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prbqOenXYVHIIIV7l/w82mkkn2RZvz/1CBZa5MY8V0Z2r/BC/4tgzWzMOSMOrh86C39aQx0V7+C9yJM8UtzzCDqDM9M0pV2DqJbeQvsllzspghy0bfE/3e/fzIyjqYxu6BeGAB6G36BW8efmLBUTC4wpnrITpcCuZ/cmaxJGj20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s0kFAquk; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gG61M2QqSzlfvq7;
	Wed, 13 May 2026 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778707493; x=1781299494; bh=dQkQ5Btb2vP/4PzJitpMb91G
	suPxbaIYyVPfc42LCRw=; b=s0kFAqukfLfYqRlESMbTa0s4Dke2wJ3wwYgIYwry
	VvDC1+REg4L1/H3shLzT9Z1go7+KpkJduPij6no17wOluG6W6qZ4YgBd9sZlDkUS
	PssFUn74vM+wr2pGa329eYiHxuna3J5aIam3VqwSVOVUI//ZO7i41px9nOH+SWXQ
	sfExz+JPVNFv52l/XSawdpqznttulAYHZMlYlRSAopimV8zquSRe7dgik+eLO7x8
	wrshOJRSNgawVM1GUiCsJWl5/tn6vVXgUoz8BUMTBrjNATaHFlX6AugN1HCTwuQ0
	Kg21Z7tGFzet0KOdKz9yP/ahyY8NS6DkAzOSWXcU3Siq3Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2VJdm7l1QsxA; Wed, 13 May 2026 21:24:53 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gG61J2k0gzlfvq4;
	Wed, 13 May 2026 21:24:52 +0000 (UTC)
Message-ID: <e4b772a6-6e62-4921-ba46-1e3f8ef426e9@acm.org>
Date: Wed, 13 May 2026 14:24:51 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: run queues for all non-SDEV_DEL devices from
 scsi_run_host_queues
To: David Jeffery <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260513173552.9222-1-djeffery@redhat.com>
 <3442d2e5-de1b-4043-97cb-464feda2623f@acm.org>
 <CA+-xHTHN-fjkjc6MUdUxR5Uz-ukG_LG3V7TKtf8j5r1gE8uhrw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CA+-xHTHN-fjkjc6MUdUxR5Uz-ukG_LG3V7TKtf8j5r1gE8uhrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4C00153AF6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23792-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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

On 5/13/26 11:20 AM, David Jeffery wrote:
> SDEV_CANCEL is a scsi_device state while the scsi_host_in_recovery
> macro is looking only at Scsi_Host state. An SDEV_CANCEL scsi_device
> is unrelated to the scsi_host_in_recovery return value.
> 
> I will note that looking at scsi_device state in scsi_mq_requeue_cmd
> in addition to the
> scsi_host_in_recovery call does not fix the issue. The scsi_device can
> be in SDEV_RUNNING state at the time of request requeue with the
> attempted removal and transition of the scsi_device to SDEV_CANCEL
> occurring later while error handling is still unfinished.

Oops, I got confused when I wrote my previous reply. Let me take another
look at your patch.

Bart.

