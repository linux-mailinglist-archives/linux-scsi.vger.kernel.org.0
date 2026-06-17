Return-Path: <linux-scsi+bounces-25055-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pKnWBn0GM2qP8gUAu9opvQ
	(envelope-from <linux-scsi+bounces-25055-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2026 22:41:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31769C639
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2026 22:41:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qh17n+AJ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25055-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25055-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27FD83023DC8
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2026 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48737E302;
	Wed, 17 Jun 2026 20:41:29 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ADE340402
	for <linux-scsi@vger.kernel.org>; Wed, 17 Jun 2026 20:41:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728889; cv=none; b=AXcvFWmkoiTv098hpUR6mlU+8S8TEODgs4kZ167lSR06PSTExfPxaZtT614myBToHJErA80uFiqQ0wiHdWKeACfaUGiX5hr0oy71mxAH0/qHYy6fMkoJh0AK6Ll3SDz/364AKl3cB92kGzWarC25lFmKuRxhDSFiCPVVyTgHu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728889; c=relaxed/simple;
	bh=yY5TeCnFp5daSfwZFM9KEl0Dl4rojWDYUABEGQT8/S4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUUE0XEXN9hYVICUUVVCqnL6PHJ08PDcCPL7V6HJc4phx9eDBuxg8lh36QJ9YqcjtNOmmGbHzR7ANFfZZAmKz80Bz3temY4mV4HorWvds+oGlBIRbHT+Ua91WDi0ySKF6tHNIJAGkUkJ36bBcKI1/dWz72tkiNwg+uiZf14TyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh17n+AJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C31F000E9;
	Wed, 17 Jun 2026 20:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728887;
	bh=t8raulfujDmG+GSHaqQLZi/tL4tA3Nn+JDD1Baqe49s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qh17n+AJ90+Y2xhWLSpnUdtu8rPBwZJ4ClJt6cndlPvUZCjEJL1zGTWIheHPCSEpo
	 jdIxDbtdz+PO4VNdU7v+8EKhKwXuZAv6n0QLRB4jQGQB+FfiFgmIsiclWFT/kkueoV
	 tXXaQPaU7+ymUPB9NlUBKq03aaTS43ZpLNt/Xd5giyd3vtk1PMb5aK2/d0y0Qn21bN
	 keN3O2xpz3WGVWtHyXNS13dleZx5jLNEyFlPpniIOwX+/aM5uA79mmvPU03uM1QWsB
	 Hrcp4Heol+W64aEb3NlYtsIDzsVQVaiD35GTV68iEjtjldIQtcHSoOt8k2CMFbv1ng
	 ksb6MYzYlmC4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: ch: publish changer devices after probe setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260617182122.955546-1-ruoyuw560@gmail.com>
References: <20260617182122.955546-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:41:27 +0000
Message-Id: <20260617204127.881C31F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25055-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B31769C639

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Spurious udev open failures (Regression) due to deferred idr_repla=
ce().
- [Medium] Memory leak of the dynamically allocated `ch->dt` array in the `=
idr_replace()` error path.

Pre-existing issues:
- [Critical] Race condition between `ch_open()` and `ch_remove()` leads to =
a Use-After-Free of the `scsi_device` structure.
- [High] Information leak of uninitialized kernel heap memory in the `CHIOG=
ELEM` ioctl handler.
--

commit 63eb67253a3c4a6ab60f598a1642027bbd386913
Author: Ruoyu Wang <ruoyuw560@gmail.com>

scsi: ch: publish changer devices after probe setup

ch_probe() inserts the new changer into ch_index_idr before initializing
the kref, lock and scsi_device pointer. ch_open() looks up the object
directly from the IDR by minor, so a racing open can observe a partially
initialized changer.

Reserve the minor with a NULL IDR entry, finish device setup and element
discovery, then publish the initialized changer with idr_replace().
Early opens continue to fail with -ENXIO until the object is ready.

> diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
> index 4010fdbf813cc..12061e4681ace 100644
> --- a/drivers/scsi/ch.c
> +++ b/drivers/scsi/ch.c

[ ... ]

> @@ -951,6 +952,15 @@ static int ch_probe(struct scsi_device *sd)
>  		ch_init_elem(ch);
> =20
>  	mutex_unlock(&ch->lock);
> +
> +	spin_lock(&ch_index_lock);
> +	old =3D idr_replace(&ch_index_idr, ch, ch->minor);
> +	spin_unlock(&ch_index_lock);

[Severity: High]
Does this change introduce spurious udev open failures?

Looking at ch_probe(), device_create() is called earlier which emits a
KOBJ_ADD uevent, prompting udev to immediately create the device node and
attempt to open it.

Because idr_replace() is now deferred until here, ch_open() will observe a
NULL IDR entry during the udev open attempt and return -ENXIO. Since udev
rules do not automatically retry on -ENXIO, won't this permanently fail
userspace device initialization, whereas previously it would gracefully
block on mutex_lock(&ch->lock)?

> +	if (IS_ERR(old)) {
> +		ret =3D PTR_ERR(old);
> +		goto destroy_dev;

[Severity: Medium]
Does this error path leak the ch->dt array?

If idr_replace() fails, we jump to destroy_dev and eventually to free_ch
where kfree(ch) is called directly. Since ch_readconfig(ch) was
successfully executed earlier in this function, it allocates the ch->dt
array. Does bypassing ch_destroy() leave the ch->dt array permanently
leaked?

> +	}
> +
>  	dev_set_drvdata(dev, ch);
>  	sdev_printk(KERN_INFO, sd, "Attached scsi changer %s\n", ch->name);

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but can a race condition between ch_open()
and ch_remove() lead to a use-after-free of the scsi_device structure?

In ch_open(), after the ch structure is found via the IDR and its kref is
incremented, the ch_index_lock is released:

ch_open() {
    ...
    ch =3D idr_find(&ch_index_idr, minor);
    if (ch =3D=3D NULL || !kref_get_unless_zero(&ch->ref)) {
        spin_unlock(&ch_index_lock);
        return -ENXIO;
    }
    spin_unlock(&ch_index_lock);
    if (scsi_device_get(ch->device)) {
    ...
}

Concurrently, if a device removal occurs, ch_remove() drops the driver's
reference to the scsi_device:

ch_remove() {
    ...
    scsi_device_put(ch->device);
    kref_put(&ch->ref, ch_destroy);
    ...
}

If this drops the final reference to the scsi_device, it can be freed
before the preempted ch_open() resumes and calls
scsi_device_get(ch->device). Could this be triggered by userspace
repeatedly opening the device while it is being hot-unplugged?

[Severity: High]
This is a pre-existing issue, but does the CHIOGELEM ioctl leak
uninitialized kernel heap memory to userspace?

The CHIOGELEM ioctl allocates a buffer using kmalloc() without the
__GFP_ZERO flag:

ch_ioctl() {
    ...
    buffer =3D kmalloc(512, GFP_KERNEL);
    ...
    result =3D ch_do_scsi(ch, ch_cmd, 12, buffer, 256, REQ_OP_DRV_IN);
    ...
    memcpy(cge.cge_pvoltag,buffer+28,36);
    ...
    if (copy_to_user(argp, &cge, sizeof (cge)))
    ...
}

If the SCSI device returns a short read, the trailing bytes of the buffer
retain uninitialized kernel heap memory. The driver then copies from this
buffer into the cge structure and calls copy_to_user(). Can this leak up
to 72 bytes of potentially sensitive uninitialized memory to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617182122.9555=
46-1-ruoyuw560@gmail.com?part=3D1

