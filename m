Return-Path: <linux-scsi+bounces-25369-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s9ziLfXQQ2rejAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25369-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 16:21:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1356E55EF
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 16:21:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=MVv7AWxa;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=dgUyY5zd;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25369-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25369-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0FAA30B5677
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D2423158;
	Tue, 30 Jun 2026 14:15:18 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE09419306;
	Tue, 30 Jun 2026 14:15:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828918; cv=none; b=CD5t+S/QTemW6vRunmvOHpMXIpIZHBtLlL6WjH7ZMCmhhlq1KiDoyKHUON7tSMBO53Mteu6T8kqLKr3shIQEgZe9soVQMXA45TZa9Ua0MrkMm4lor7k4sUM/ZM1uMG1TvpZ0twILQdITYLOyMFRBg1VSe+aMZgFvHGxLWmKzyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828918; c=relaxed/simple;
	bh=QnQ9mX5KCDagTYlabMbIcTFzz0A45R41axTb8VjhjIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1fIuZJ/Z3hZYWDVlLFnYLOIJSa7HuV1rqZLK+h4hl3wPChUe4V6iz5c5rvi/STpR8zDd42obS9sPjaUU0nXWmNXpz2ewOEaIx2ORBmPzgYeR9RUIinPfZ/lwKGw562hXRjNYbLunHET6EmjbUZ/VfbfMwcAdkI0/X0wTtaVhX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVv7AWxa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dgUyY5zd; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 30 Jun 2026 16:15:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782828914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwqHhCR7m88UgJlOdirD5ZTnHIhQoiKMHY4r/3MaPiA=;
	b=MVv7AWxaIGvRygdqExq7DxFw9DqO+rTNdpYx0s32u7e/wZ2IE0f5RpwCpnTc9SrNrVt/o9
	5KJFNL2FomIkokVY3FeW3rtPEwB7s+3VuV269tS5VZHun1ZztdvKQ0cZyAsvrSPCwh6DQI
	8x4UStAVl86/m5KyChqaNQVZ2F3vQwneCqwE/mcmAdnV0/kxJxOxbrMjNwzPRimwngvx+K
	285ZdiGXmBBJemM6Zm0zQpoCGYv1NW3NMGSjlZJMptXpTKfUCw2ORKIAz8qGORTzNAfaJ7
	7fK7aLGPjwcZIVJkKMzx/z12jcN2wOXPLn4LxOYoqbLmy2nvKDANIP6nl2u60g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782828914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwqHhCR7m88UgJlOdirD5ZTnHIhQoiKMHY4r/3MaPiA=;
	b=dgUyY5zdQTOm2YEgJnPDMYnhK2jlQMLss+CK1Q8gagloDGSYXndZyI//7VAm+ivxYVFtA+
	ZFTHYkOw/FDAUKDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	=?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] scsi: ufs: core: Avoid sleeping in hard interrupt
 context when PREEMP_RT is enabled.
Message-ID: <20260630141513.ujz0Ef-O@linutronix.de>
References: <20260630-ufshcd-spinlock-sleep-fix-v1-1-339b05a1c6f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260630-ufshcd-spinlock-sleep-fix-v1-1-339b05a1c6f4@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:gregory.clement@bootlin.com,m:alim.akhtar@samsung.com,m:avri.altman@sandisk.com,m:bvanassche@acm.org,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:thomas.petazzoni@bootlin.com,m:vladimir.kondratiev@mobileye.com,m:benoit.monin@bootlin.com,m:theo.lebrun@bootlin.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25369-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[193.142.43.55:received];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A1356E55EF

On 2026-06-30 11:55:23 [+0200], Gregory CLEMENT wrote:
> PREEMPT_RT turns spinlock in a mutex that cannot be used in interrupt

it is a spinlock_t and a sleeping lock. Also hard interrupt context not
interrupt.

> context. Since commit 3c7ac40d7322 ("scsi: ufs: core: Delegate the
> interrupt service routine to a threaded IRQ handler"), the hard
> interrupt handler is not converted into a threaded interrupt handler
> (due to the IRQF_ONESHOT flag). This can lead to the use of a sleeping
> function inside the interrupt context.
>=20
=E2=80=A6
>=20
> This commit mitigates the issue by directly registering the thread
> interrupt handler without involving a hard IRQ handler. This will only
> be done when PREEMP_RT is enabled, which automatically turns all
> interrupt handlers into threaded interrupt handlers.

This sounds like threadirqs is still broken.

> Fixes: 3c7ac40d7322 ("scsi: ufs: core: Delegate the interrupt service rou=
tine to a threaded IRQ handler")
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/ufs/core/ufshcd.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
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

No. No ifdefery this needs to be addressed properly.

=46rom ufshcd_intr():
|         intr_status =3D ufshcd_readl(hba, REG_INTERRUPT_STATUS);
|         enabled_intr_status =3D intr_status & ufshcd_readl(hba, REG_INTER=
RUPT_ENABLE);
|
|         ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);

What does this do? Does it disable the IRQ source? If so then
IRQF_ONESHOT should be removed.

|         /* Directly handle interrupts since MCQ ESI handlers does the har=
d job */
|         return ufshcd_sl_intr(hba, enabled_intr_status);

If not, why is this not part of the threaded handler?

>  	if (err) {
>  		dev_err(hba->dev, "request irq failed\n");
>  		goto out_disable;
>=20

Sebastian

