Return-Path: <linux-scsi+bounces-25964-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L5XuBmrZUGr36AIAu9opvQ
	(envelope-from <linux-scsi+bounces-25964-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 13:37:14 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BBE73A4EC
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 13:37:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=k2uQSGQM;
	dmarc=pass (policy=none) header.from=linaro.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25964-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25964-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A23593023F9B
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 11:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0843141CB28;
	Fri, 10 Jul 2026 11:30:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A164192E5
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 11:29:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683005; cv=none; b=CFMCS9p+vSdeqxeSZnIyOHvrN8tPiWlhtjD7WAvZuyIfJvSFSeqAyVUm2+HpKqwgqPB+6X+WbBa/oGlr4GLxxCXPitYpXIYwC9AL3QXiUqGABaIf51mo/dPbPL2/VsZf+oMzajjO05DeOHP+5Tj+QwS5yTBgGlpcyNc549+14bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683005; c=relaxed/simple;
	bh=2bWfOB8zLsqouUHUyGgIFM171hx48ZbaM0XewOGdQ1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugGyXdGwx+eWV9o8AbheX+tsXp42eICYxmDm67ZdAwkfrkz/0bYZlS/LMwfoFdBe6RsOkyIbOxE0KqE6NYb/LWPqI5gLJS6ZGcVEw+295KJ42PZjp6Nc9ev7a3FNi1fLkpPxqnTe5hXxp1fHPRE8MMqnHDR00Chvmz4GmqdNztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2uQSGQM; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b27c7451so23656175e9.0
        for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 04:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783682991; x=1784287791; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2bWfOB8zLsqouUHUyGgIFM171hx48ZbaM0XewOGdQ1I=;
        b=k2uQSGQMrprrNiJdzRJR0egfM5wMlHfuHbpxd9fMcCOd3i6Prj8MNj90FLsvEL0IDa
         /K32qrcwDv5i9CYLZd5ivrql9aV69uObJiQlmV6TVpxsi/zoAoIGHDZmes2UMd7ApjmR
         893MVQ2+cbJ/R2kVyURMHNAO01CNXstGpsizEsUjbmrrnqGo9xZMw3q/6kL7Sym6r5MU
         yXyOVPu6NoQXNRAqA6yD7+EfcEmZKdk/ux5uQyjWsqagBMyRD6HbLaaNTFbfBnqF9h25
         V4JS+BQjG6k55rtsm+Q4vd7yj+hVj+f5Wb8MpXKaLxegSuQglr1rWNBjsCvkOxumd7K7
         b/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682991; x=1784287791;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bWfOB8zLsqouUHUyGgIFM171hx48ZbaM0XewOGdQ1I=;
        b=F+Xvt+aVdU6CLPIeeSlb94xoGGdyD2Wj+YDO46C0Uw04vz8uYsr8qPKTZae3fJfMMk
         uW1vs/RDoXe1iiOtv8kR/gts3/yzcLe16JVBJgdbEnnEDrdEjSF3m2M19GRJONEQLWNB
         +bLrwsseBRG97mekUS9YhRGHq1a0v+q7E9LbUg9k+6/I7a1uALGegbCQw1iFOemTj32O
         6eUGjkmW8I3nrlopPisSk1EBxS+BgHaOpOlH8JHzXEqHZnQNzhYl74vGOX0xDLpnX77N
         uLsDU/bhSItrh/gr3BsLQrXvQoYt9Tl+WYSaHtaZQzZZCUriHQYToHehW+GXBcURLWMq
         /dLg==
X-Gm-Message-State: AOJu0Yzj8FZHymxC7BUmdlnvv7kNx8LAnlrnpjXNb+Uddyvae9CNXXKW
	nVBPyy0cZuXhahWmJtfKfP2TVpTFCZJYsGvSYLAJZBwddz9ICvHYh9/KfHC2/VG6WRNMk5JfldE
	2aCFA5YQ=
X-Gm-Gg: AfdE7clThqu/T1jMqCg1S8bYlKPT0hTxNuQSciocxe7mlPF+isTntnUs/rqMf3ZIN0m
	Pt+/wfC7yHjQoV52+YO5+EwDJwqJDm2JwOMQVMU3PWP6TVZwep+dlbzX2tmnsDWs43BYUapOAZN
	vRBdZwLvM4SMk5NconkmmrJLD6bvRdDrH1SZMxo6vFJsNSSlxhLYRYC/FHdz1J4Q9GbgT4qtCv7
	HOtTmkELNxqqC4BP9woOK8l44b5a5sWS2K6ZgRnnq6kQJExowUhe2VF2EgEzGM2XWp8/qcAYFYu
	jgDIkAE1SdaQIWMO2vslQDx0xyw9asc5PQW06wOjr7uGlEk3FgYGEKY88Xupd0iCt2ugwEuJOp6
	Gr1I+IIZw76zr4mzyCrnIVRDIIanIP93trr5zk18Z3iCkMx/kDoZUwRwmt4Rbg9h3hz+JU33I0C
	1GdRQa70zJvXwhvjJwu6moRfc=
X-Received: by 2002:a05:600c:4858:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f2b2ece3mr17817755e9.8.1783682991282;
        Fri, 10 Jul 2026 04:29:51 -0700 (PDT)
Received: from [192.168.219.26] ([80.233.74.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73ae14sm128808635e9.11.2026.07.10.04.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:29:50 -0700 (PDT)
Message-ID: <1727f508a0b094420b124a1f5c9d4b29ec2cae31.camel@linaro.org>
Subject: Re: [PATCH] scsi: ufs: Allows the driver to choose the interrupt
 handler type
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Kui Sun <kui.sun@unisoc.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@sandisk.com>, Bart Van Assche
 <bvanassche@acm.org>, "James E . J . Bottomley"	
 <James.Bottomley@HansenPartnership.com>, "Martin K . Petersen"	
 <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rain.zhang@unisoc.com, yuelin.tang@unisoc.com, wenchao.chen@unisoc.com, 
	cixi.geng@linux.dev
Date: Fri, 10 Jul 2026 12:29:48 +0100
In-Reply-To: <20260710065948.467514-1-kui.sun@unisoc.com>
References: <20260710065948.467514-1-kui.sun@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25964-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kui.sun@unisoc.com,m:alim.akhtar@samsung.com,m:avri.altman@sandisk.com,m:bvanassche@acm.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rain.zhang@unisoc.com,m:yuelin.tang@unisoc.com,m:wenchao.chen@unisoc.com,m:cixi.geng@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andre.draszik@linaro.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linaro.org:from_mime,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69BBE73A4EC

Hi,

On Fri, 2026-07-10 at 14:59 +0800, Kui Sun wrote:
> This capability allows the host controller driver to choose whether
> To register interrupts in a threaded manner or in a
> Standard (non-threaded) manner

I believe it should at the least default to the original behaviour to
avoid the regression on pre-existing platforms out of the box without
taking additional steps, and make the threaded handling an opt-in until
a better solution is found for platforms that benefit from it without
adversely affecting other platforms.

Alternatively, I suggest to drop the threaded handler altogether (making it=
 a
full revert).

For context:

https://lore.kernel.org/all/4enen7mopxtx4ijl5qyrd2gnxvv3kygtlnhxpr64egckpvk=
ja4@hjli25ndhxwc/#t
and
https://lore.kernel.org/all/a4003ac352f382fa4ff329acdfa561eb06e77289.camel@=
linaro.org/
and related.

Cheers,
Andre'

