Return-Path: <linux-scsi+bounces-25266-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zI7/HQUaPWoZxAgAu9opvQ
	(envelope-from <linux-scsi+bounces-25266-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 14:07:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C38426C5639
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 14:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b="WhnGL/5l";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25266-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25266-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C64C3009174
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B883DEAD8;
	Thu, 25 Jun 2026 12:06:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F83DE452
	for <linux-scsi@vger.kernel.org>; Thu, 25 Jun 2026 12:06:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389190; cv=none; b=h9Pia4T5QV+8Xe3w/MI1n7EB2rDgnGCK2lBscfkJwtfGYpnYnW0ng7y5vhBd9C/xY7jzcOiucTzqqcptRpwHB40sga/hKUYKUQevwxi6dhIyZOdZ0LuAKKLeN5rsrdX6HcbyOdQZgdjXvc7orb8FA2iq9SRmZtMCAMtZ4kOHeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389190; c=relaxed/simple;
	bh=sQ3IvhVlv89cPfQzS65J1lmyYHPFIWi8Shbctwx9fz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPzADvixUF0n8ur1dz1Eax+AjRa6mA44aHc87CNlQUGF7jPdUCcdjBYSZoqQpoU975Wywhx+5ja5YyRaBYEadx58nBieecRRKwScROqXKZsPT/V+77R6XfWF97gICD3HIS7OcGChgQNyJ70Rm42UYvv94uYLcc1lCLOVxGysh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WhnGL/5l; arc=none smtp.client-ip=209.85.161.51
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso939747eaf.2
        for <linux-scsi@vger.kernel.org>; Thu, 25 Jun 2026 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782389188; x=1782993988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FU2klxnBMUg0uA7ws6NxiqTBs9+/KNmY1E7rkk8xrBI=;
        b=WhnGL/5lNXW3Xow0yfnvN9Rk5Zd5XHrgvaMsBD/L80tA1KI7WDhzPbQ+RHoyqAprU7
         jPtv1YmpuJ1Dyp//RMkusH4ay/ac4rjRF3iosf69MeaTkit1Y6Qi3sxtzzTMQhLx6CGN
         lhydn1gxcAdnOxs53Wv9FpuDYU4TBZdHVewQCOXQzJIO/B2vOjwp9oHZQm/TaAij08HO
         cp5sKf3XBoG3yeBAmiaHYw2o5OEI+ap62GpeyfInLJI2twbRA0sADB7DmdYiFmtBwDYD
         1b7IMzpR0RXNtz1yxRLuJpm5F6xgbexvKiFDZA5K16VEz+xWQ2DbNUkf2l01qFt6YKGq
         s6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389188; x=1782993988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU2klxnBMUg0uA7ws6NxiqTBs9+/KNmY1E7rkk8xrBI=;
        b=afO8sBOd4YJPmBIOtq4C9SyNJ01XYuI3BnMNkoSAwzPbuV20GNt5+8jsfr/a1e/oqU
         5ecQOn6xNnYCKyi3h/tCUKWD/0XSOditeVchrYPlJMASIhZjK3VcwTkBZK1BbpxKLgLd
         pvH0tE1YyzW1jaeafldCC5kvnP9FyZSxmSfFEaGxe0Mmmi/k3Ri2/KrIeoBYNU5h9Ytc
         dslT6qufoGgHu3yb+iOSLY61/GzENV1Y8TJGRQYAUtxlRj+oQmU9sPmSOIhXR/hgcVpZ
         K7BkNEM98LSXdgXEeAxgGRi9cTsc7Ofj1nkBfiw4QuAZFDYvSygGjy7F0OSizG8t0gdP
         vjJA==
X-Forwarded-Encrypted: i=1; AFNElJ+0CgGu3iTV4ATnRIsdBZ01A9NX2hDoTFs4HYtr7yz/K0OyKyA5fW7mKWzel1UmFKmRJ8XxctgGDAAR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xTLuuXnksfp4C/52QsMqyGfN8TnKOQgVsgd6TRh6MtRJKV14
	d0K89qfs1wQp2RsYGSZc/D7bk69NOfVmZ6+KbUn0APhHr/1C+Ry3cL8ywVUPFnpM/pM=
X-Gm-Gg: AfdE7cn5LvX20xXGmoCNJTHaIUfuyh594E/AJsBaDp6WRW8YdZDuz9NLajAP5+ysTcY
	E9bgGV0XQfRzdMlpvgeeePE78/969L1wO81T6OQ2wRDi6nw1iQLwqFsCl64GOy4kCOiCT2qKTSI
	BzXJFcwsMF2MtzEKllrVzBSkWX2F6PnC0HajEz8AKE4L3uD/YqLrCqrT1iX83cgBKSm/ELb4zw0
	cuAscDppkBJ/hKCgKTY5Km2LqOly6+MmKzEsWF7S5wHRm5zfOEuqm44EfcsFaJlV52GcCyMr0Mj
	UiE2cO72x/vtW3cprARbACBmzhaItO7+cduI7tElizhV6h1pNeQPKQKjQvSN7HpO9I2VdtqNPs+
	BKbPhmCeI7K3JME3PyTn8EuFmTiqmuhfnTnKLMduawNIR0aEdeRudmLR/ImcQQ4TA1vtO2JbW9G
	7ljqLaitTDIcKT83SmGDdN4hQKHBbM5wYSsg2OCa+W+L1gK/OtpcWtPBoXpzpjlXtpwA2JV/4=
X-Received: by 2002:a05:6820:f015:b0:69e:39c9:c6ec with SMTP id 006d021491bc7-6a135171776mr1548990eaf.13.1782389187712;
        Thu, 25 Jun 2026 05:06:27 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-447ec359d9csm3002077fac.12.2026.06.25.05.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 05:06:27 -0700 (PDT)
Message-ID: <55f36cc5-a013-4960-8787-fbdf4b4d0c20@kernel.dk>
Date: Thu, 25 Jun 2026 06:06:25 -0600
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: bsg: read io_uring command fields once
To: Yang Xiuwei <yangxiuwei@kylinos.cn>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Rahul Chandelkar <rc@rexion.ai>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20260527191817.142769-1-rc@rexion.ai>
 <20260626020000.0000000-1-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260626020000.0000000-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[axboe@kernel.dk,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25266-lists,linux-scsi=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yangxiuwei@kylinos.cn,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:rc@rexion.ai,m:fujita.tomonori@lab.ntt.co.jp,m:linux-scsi@vger.kernel.org,m:linux-block@vger.kernel.org,m:io-uring@vger.kernel.org,m:bvanassche@acm.org,m:csander@purestorage.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid,kernel.dk:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C38426C5639

On 6/24/26 9:25 PM, Yang Xiuwei wrote:
> Hi James, Martin,
> 
> Friendly ping on v2 ? anything else needed before pick-up?

It'll fix the issue, but it also just applies READ_ONCE() everywhere.
Which is fine, but most of them don't really matter. For example, yes
you could race on the timeout if the application is being stupid or
silly, but it doesn't matter one bit. Similarly with a bunch of others.

I'll leave that up to the SCSI folks to decide how they want to do it.

-- 
Jens Axboe

