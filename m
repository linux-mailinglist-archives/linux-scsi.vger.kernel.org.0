Return-Path: <linux-scsi+bounces-23258-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IByvAJRO6mkhxgIAu9opvQ
	(envelope-from <linux-scsi+bounces-23258-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 18:53:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F019E455218
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 18:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E0C3005D0A
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2026 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B9382294;
	Thu, 23 Apr 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UW8D85Bl"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650A149C6F
	for <linux-scsi@vger.kernel.org>; Thu, 23 Apr 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962434; cv=none; b=tL9oNCnbRe8woaerwD+p1TQ5RcnTyWe4RIvWR9H7+Y+LqI2COnd+CLUYQcT/GbH1NxXNb8iDQBg/sDQlBw+0MIoniOar0koMRrTwUYzIpTDRp1xuGWj4iiA4Bah/ix2MXRiglKwvQNd6xMie9alg/EHbvCl2ytmDBXA8ostX1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962434; c=relaxed/simple;
	bh=FCd8q0ui0RatMoIf3cp/KSJipmLmsAAsBg/DgnqasB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ3TFxWP8WgyHpLYMeYbEEXY4XvGf8zHVCTtwcycqBOAgjLOyFGxr8+z6NbMkHkYtKIJoBbvSNYWt9VaaSAkVyr1uVqxG0SitN7QRO5ZQel0pgUp35A4qqcaYSp6JcD0GRE2yQyopHOQGMAHUnAFo6/6sZpIx/aPO+XUi/Kxd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UW8D85Bl; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g1hfL1h2tz1XM0p8;
	Thu, 23 Apr 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776962420; x=1779554421; bh=lfXfw6dfdDqn6LBU+hqAYCfD
	lqdgteGbeOaWZEzlrz0=; b=UW8D85BlVyPiQntzhQovXtcDCOWO0JdaplbhuzUf
	s5Ysl5zGbAmomxEYxg5if9jz5dKAhwm7m2qbj0SJvfQcZZhTTe0SSyI6NgPRmmDu
	AIcHhq6gXER9NMBeIJkRz7ADtvoeohhofAXTZsUCQd9IsE3uyGJtGSQwPHU0yxEW
	wGtFgP0eHHRA9ROQ4kpUxvtxLMDErUxOZrQFeAapEXrz1Ayuokyjf8f+DmAJo5PS
	zuJTHDN5ls4XuBVLzqNSH5Szb1qbFLaVunc7phlyxJs2QQtPGldgNuKfTKoL+Y2Q
	yap9SCFzVRCTJR0j5YFx173UjwD21Fhr5/XB946GC9liiw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N0PcoDKBYp5E; Thu, 23 Apr 2026 16:40:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g1hf94smSz1XM0p7;
	Thu, 23 Apr 2026 16:40:17 +0000 (UTC)
Message-ID: <39585b28-64d8-42a4-afab-a88ca1eb83b6@acm.org>
Date: Thu, 23 Apr 2026 09:40:16 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] scsi: Support devices that don't have a cmd_per_lun
 limit
To: Hannes Reinecke <hare@suse.de>,
 Mike Christie <michael.christie@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, virtualization@lists.linux.dev,
 mst@redhat.com, pbonzini@redhat.com, eperezma@redhat.com
References: <20260417230751.117836-1-michael.christie@oracle.com>
 <20260420173352.GB405461@fedora>
 <603eee86-9914-4ac8-b937-a38922e69a45@oracle.com>
 <9ce439b8-4e56-4a8c-8ef9-d8d9e93ab77a@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9ce439b8-4e56-4a8c-8ef9-d8d9e93ab77a@suse.de>
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
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23258-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F019E455218
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 2:45 AM, Hannes Reinecke wrote:
> Ideally I would kill cmd_per_lun.
> This really is a poor man's fairness algorithm (sole purpose is to
> avoid starvation with many luns), and we really should look at if
> we cannot replace it with tagsets.

Hmm ... isn't cmd_per_lun essential since the introduction of scsi-mq?
Without a host-wide tagset, and with n hardware queues,
blk_mq_alloc_tag_set() allocates (number of hardware queues) *
(shost->can_queue + shost->nr_reserved_cmds) requests. Each request
maps to one SCSI command. Setting cmd_per_lun to shost->can_queue may
be essential to avoid BUSY responses from a SCSI device. Here is an
example from the ib_srp driver (there are many more SCSI LLDs that
follow this pattern):
* During connection establishment, the SCSI target reports the
   maximum queue depth it supports. This response is used to initialize
   can_queue and cmd_per_lun.
* Multiple hardware queues are allocated, all supporting can_queue
   commands.
* cmd_per_lun is set to can_queue to avoid BUSY responses from the SCSI
   target. My experience is that for high performance SCSI targets even
   1% BUSY responses cause a significant performance drop.

Thanks,

Bart.

