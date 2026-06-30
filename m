Return-Path: <linux-scsi+bounces-25348-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /HCkIXyZQ2oKdAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25348-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 12:25:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B646E2CD2
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 12:25:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VUtO3xHG;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25348-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25348-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D25A302BB84
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A53A5435;
	Tue, 30 Jun 2026 10:23:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D83EFFA8;
	Tue, 30 Jun 2026 10:23:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815025; cv=none; b=jotq43rAxy3Qy6ioN87B3CGl5jeTrtqR5vr07KVeSymZYxscKoGcJba9S5xtAgBrhDReXvktXrW1rPRhWLpikqGUnXvWOhbhsu4qwYAzJw9QYAsxtRKqO1/LFNUXy929QQbYnpcTDResAnK5jJrVtaVCYh5JT2rYoZ0DN6usWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815025; c=relaxed/simple;
	bh=WdRjO0eDQ3UusCjWkyUljSVzQpBsEPLg5BS23ezl7MY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0bocYqiGcH8JEEBnzjZnZgFkPQdhCLm2A4Yw1fxywi5ayR5the93PXcBemOUJA81xKToc7xWNwA6EU2qaQbA+LaSR2EAVYbTOaW3Npk83Nrz0JMKTvQopvlyqhwULI8+LeWa9rKTOdvuXTq0ihlmQ8LmagDZZlm481jpTbgt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUtO3xHG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728131F000E9;
	Tue, 30 Jun 2026 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782815023;
	bh=Z9oYsVzR7ULnDPAjxduXofUrpgR8OgIYB7eXB5xsjmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUtO3xHG3LZEXOaX5pW15hWpDZU2+bP9JoUz7LCPvBH23X0tj4tw1HjbsvOMXUNfm
	 QEuN0cbg5+gbjMrjlQX1IIMwKBxigEarkUpYEWzVVBouob8ydL1Vpol/MyzseIuCDn
	 avg/JFHKYmLfP+s83NdjXKOT7iZExpra5ozcQYrrmBtuCXfoF2HV+ic91gXAn3Mgm/
	 r0StSM7sOfzfawdV9x0kRxx7Pd/1M5GhpO86X++C/oSGmAS577nF2kTJvz9pTkR/aH
	 FhSmsK5Fn7KerwMekIFBHFPh7jzwOVRxYfineUuo4FKmCMQHgjlbvkhBAAVB1UIBbw
	 2/QFxcSIOjUFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Avoid sleeping in hard interrupt
 context when PREEMP_RT is enabled.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory CLEMENT" <gregory.clement@bootlin.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260630-ufshcd-spinlock-sleep-fix-v1-1-339b05a1c6f4@bootlin.com>
References: <20260630-ufshcd-spinlock-sleep-fix-v1-1-339b05a1c6f4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 10:23:42 +0000
Message-Id: <20260630102343.728131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25348-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregory.clement@bootlin.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30B646E2CD2

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The static function `ufshcd_intr` becomes unused when `CONFIG_PREEM=
PT_RT` is enabled, causing a compiler warning.
- [Low] Typo in the newly added source code comment.
--

commit 6afdc0b243918ce89eb55cea6349f608516d9d03
Author: Gregory CLEMENT <gregory.clement@bootlin.com>

scsi: ufs: core: Avoid sleeping in hard interrupt context when PREEMP_RT is=
 enabled.

This commit addresses a sleeping-in-hard-irq context bug under PREEMPT_RT.=
=20
It mitigates the issue by bypassing the hard IRQ handler and directly=20
registering the threaded interrupt handler when PREEMPT_RT is enabled.

> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index d3044a3089b53..6d82658a1a66b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -11235,9 +11235,17 @@ int ufshcd_init(struct ufs_hba *hba, void __iome=
m *mmio_base, unsigned int irq)
>  	 */
>  	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
> =20
> -	/* IRQ registration */
> +	/* IRQ registration
> +	 * In the case of PREMMP_RT, directly use the threaded

[Severity: Low]
This isn't a bug, but there is a typo in this comment ("PREMMP_RT" instead
of "PREEMPT_RT"). The commit subject also has a small typo ("PREEMP_RT").

> +	 * interrupt to avoid using a spinlock (which could sleep)
> +	 * in the hard IRQ handler.
> +	 */
> +#ifdef CONFIG_PREEMPT_RT
> +	err =3D devm_request_irq(dev, irq, ufshcd_threaded_intr, IRQF_SHARED, U=
FSHCD, hba);
> +#else
>  	err =3D devm_request_threaded_irq(dev, irq, ufshcd_intr, ufshcd_threade=
d_intr,
>  					IRQF_ONESHOT | IRQF_SHARED, UFSHCD, hba);
> +#endif

[Severity: Low]
Will this cause a compiler warning for an unused function when building with
CONFIG_PREEMPT_RT=3Dy?=20

Because the reference to ufshcd_intr() is compiled out in the #else block,=
=20
but its static definition remains unconditionally compiled earlier in the=20
file:

static irqreturn_t ufshcd_intr(int irq, void *__hba)
{
    ...
}

Could this break builds that have CONFIG_WERROR=3Dy enabled due to the=20
-Wunused-function warning?

>  	if (err) {
>  		dev_err(hba->dev, "request irq failed\n");
>  		goto out_disable;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-ufshcd-spi=
nlock-sleep-fix-v1-1-339b05a1c6f4@bootlin.com?part=3D1

