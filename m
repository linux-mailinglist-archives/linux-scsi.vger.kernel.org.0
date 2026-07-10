Return-Path: <linux-scsi+bounces-25966-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /B7aE4zpUGpb8QIAu9opvQ
	(envelope-from <linux-scsi+bounces-25966-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 14:46:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE84073AE2D
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 14:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=XkwOS1SD;
	dmarc=pass (policy=none) header.from=linaro.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25966-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25966-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98632300D4F8
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4C042882C;
	Fri, 10 Jul 2026 12:45:57 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F042A785
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 12:45:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687557; cv=none; b=IF7JODSdLaj20whzm2X18dxODu2dFVA1ZBxKk085vIt8h5mxCT2kSkz77zTzpb7M0Qzv+m9JN9bhp/coxEiDLbN5ynXhoVGLYmGPPbQqZG/Ab7gNN19/QZG03y0Qxd8N/j0hpqfP9rfiaJ5qIgnP6RrOqFZn2+Ejk92rxb0ipR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687557; c=relaxed/simple;
	bh=wPtTX7g3+9PWbrRr1aPRHCwPsb/qvj2fX1Va1emEqA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXMCzGOb9MXqNwwN6omUmEvgrMmfJZQ3HHLU4iEw6YQqmjQtj26lV0YHaHcLfXFrpBXwxJ5Awp4JAURiciURp2t/b9iFjRYrDBHHF0WIWpg6xiZdA/mIN3uCAhTBuIyJXHz25H5+48ty/p5S3RY1gZsy5lecBZZQuIDd06E1Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XkwOS1SD; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-699fbcd23ccso1261805a12.1
        for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783687553; x=1784292353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wPtTX7g3+9PWbrRr1aPRHCwPsb/qvj2fX1Va1emEqA0=;
        b=XkwOS1SD8G9uFGe25750D8GD4epGyPN075JJDJJOLbjPXqI1GqUOvmIUXMmCVXSPvb
         chLRUsYoSVxS1qp/AY13ukmNjui6z9IySrp7rgK0DWWcqiBye50arCH421yh80GYmLNF
         pogtTcCnmSIFSpIdMMDLrEmXSLbgk2hQyeOP4cuhqjxhb9PAceeJ5OViX93RiO9wssdU
         nMfgE1jXLiCUosdai1CJoip5Kea5Gk9Ab7akg2RaQelI1JONRpWg71ec/pK4PFmiRpKK
         D61zRyKJpd6HAS/mmeCbKpxjZSCFKPKoCohAbPYkAM2pTs6ICfkgQaOW9VhynESHvcGf
         P0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783687553; x=1784292353;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wPtTX7g3+9PWbrRr1aPRHCwPsb/qvj2fX1Va1emEqA0=;
        b=s0dtlg6mJzwbMkCk0fFsZSlolUWXv718FqtR0YgsaTntmoWDCp+GC89LuuPFs0L3J0
         A+WXaJTau88lx5+b+dwf8Q6YsrWzN91pIy8XO2GzF0fz/hXvG22kZ8U846QnD2Y7wKCH
         T4DVFx9pzYoiKeVk+/xQO1HlmYyCDplJCMt5bWxP77CAKG6kFhiev2qeb7DUPTZn05OW
         vDvYHuo7D++T/JYK4oH8S5PApuUrcZtudW2LIX8mDYCXXky/k2d/Cv6+5TwUm11Shh44
         uvBndtmQknW3d/6ay440SsPcBR/RbcoxU5ryo2zdX1NSQY7/28xgR6KtEyHtxoz0iQmo
         oScg==
X-Gm-Message-State: AOJu0Yz33nmgSKH/WOUQS1zMbb7Wa8p3khdE2KaT/PFtGPvPpDyx3x8W
	z8ioe44pSAliT8CrGyVpTbtyHBo7RzMF+hi9HTfC7UnJM8mZ5bvcUEi+mr8Lm08oWXA=
X-Gm-Gg: AfdE7cmDQthKGICgTOBkPi0EZLe0EyyWotZAzmacOVw7HER3563zSqKE42NhtPS6EG6
	gfSOyvwzsAD7KHSEDHQZ8Z/ti6deOmKaxaOYxhb2hAe8+UJWSWlNppc5xEXp0ZEpx+wh82j6AZ3
	rEY/y0zsa5FPRg5YyNLTp61vr25qPyCTs4gZAfNEX3Hmctjqr+rlb1tTZ4Um9RpMi6QzCxjScqT
	tVJs4TlquAOpKMbt36trLslD9yMIixbgJiLskEbSpTlydKhnCx9Ju0LQ+3TfGzuCdnqCoz/uRJP
	ONoawZbclWn+YE3l2dpOqlK5xwRAO9O5rXccAyLDDqgAmn9OiQlxDyX8XnVr48iO3NRb8D4yKk2
	C5C/4bawiaulfHDxZy2xlXSWNHWns6HM4qeqwJf0vfx97J6Svsjh/m/kbdiy1LR5MvT2gTVjgQg
	ytxBystOfcaadaxsolKxnpXBYl2QtWijKYww==
X-Received: by 2002:a17:907:9496:b0:c15:c203:c778 with SMTP id a640c23a62f3a-c15ce14584amr473342866b.55.1783687552860;
        Fri, 10 Jul 2026 05:45:52 -0700 (PDT)
Received: from [192.168.219.26] ([80.233.75.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15e6286a5csm242341066b.11.2026.07.10.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:45:52 -0700 (PDT)
Message-ID: <57df6de3fa0d2d786db5cdd4d5d25504e6f62bce.camel@linaro.org>
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
Date: Fri, 10 Jul 2026 13:45:50 +0100
In-Reply-To: <1727f508a0b094420b124a1f5c9d4b29ec2cae31.camel@linaro.org>
References: <20260710065948.467514-1-kui.sun@unisoc.com>
	 <1727f508a0b094420b124a1f5c9d4b29ec2cae31.camel@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25966-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE84073AE2D

On Fri, 2026-07-10 at 12:29 +0100, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> On Fri, 2026-07-10 at 14:59 +0800, Kui Sun wrote:
> > This capability allows the host controller driver to choose whether
> > To register interrupts in a threaded manner or in a
> > Standard (non-threaded) manner
>=20
> I believe it should at the least default to the original behaviour to
> avoid the regression on pre-existing platforms out of the box without
> taking additional steps, and make the threaded handling an opt-in until
> a better solution is found for platforms that benefit from it without
> adversely affecting other platforms.

... as done here :-)

A.

