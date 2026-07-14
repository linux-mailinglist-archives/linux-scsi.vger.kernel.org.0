Return-Path: <linux-scsi+bounces-26112-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 61/VGLHaVWqKuQAAu9opvQ
	(envelope-from <linux-scsi+bounces-26112-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 08:44:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71B75198F
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 08:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OTAKxwSH;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26112-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26112-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB98E301F997
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD033DCD8A;
	Tue, 14 Jul 2026 06:43:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3002E1722
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 06:43:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011438; cv=none; b=VYFqXI+UkZ1X7Sk9oEyZQ2xJPD2CK5AS0CDMp/AK8fC13Sn5GOwRCv7LZX1bN72lKIosg7KosgwO6A6Cc0K7pi0lBMJv/3Gn34G2B58MKP/krfgpcRElsLefakx0CHjiduOViDD5MA6Patf6CBv3lSuj6+xhDMkIYNORZ4vMAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011438; c=relaxed/simple;
	bh=b1ToAj+9fcuBR3gpjI3vXC1Y5t4nMEsRSuuPF2WIHHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pmILD5cZazIRkv5EMFxbalo81S7pDQIp7JRlh5GG7e4m6yJK25hRqxPsLAD+daxIiIWk+I3qOrsYkySD4yS0iY4Q2Lk9zWzFN5QbLJM2IJ4iXZc5Nzm6NJUXeyvnbn2pXveGwUu2G1GYLX1u5v1Pw0ZppdSV1RpSAW1j3v6u3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTAKxwSH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7101F000E9;
	Tue, 14 Jul 2026 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784011437;
	bh=nQ3VaMk17rBaGFIGc6caFCVlJEv5lDI/44+0s40DczI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTAKxwSHdOnyMfwpGymsF9y8c20gpFFlW+0rizxxfiXqeQMCNau/+Qlmv7vmh2mrc
	 YYQ53zkfo/gNZpYLKEg0C8VrcVhvodKs9plrkZyxKpA3HmF81UzAIc2Y9vcMAAH/Xk
	 FgwvoejO0HGbmZkwNyK/hrTiXzPKhdtNNORzwwNL2KDnYePw2WJQJRLV4oh/spaHtv
	 EvV/nMYKuv3Ot2XpUbu8gnuPfrQU/S/nOb+u68pN9j5ZlV2BWEQktLZs7BZE611FA1
	 69UAdl3WIhlG38SzdDOOQVX9WnaXU2ZctdAq6sh5uS+AkFVSQI4BON6YFZxdJYPWgb
	 QmjxRU0F5Ufvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] scsi: ufs: core: Fix UFS RPMB device teardown order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ao Sun" <ao.sun@transsion.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714061532.167-1-ao.sun@transsion.com>
References: <20260714061532.167-1-ao.sun@transsion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 06:43:56 +0000
Message-Id: <20260714064356.CF7101F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-26112-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ao.sun@transsion.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,transsion.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA71B75198F

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Removing the `release` callback from `ufs_rpmb->dev` directly viol=
ates the driver core API contract and will trigger a loud kernel warning (`=
WARN(1)`) upon device unregistration.

Pre-existing issues:
- [High] Allocating a `struct device` via `devm_kzalloc()` incorrectly ties=
 its memory lifetime to the parent device rather than its own kobject refer=
ence count, risking an exploitable Use-After-Free.
- [High] Moving `INIT_LIST_HEAD(&hba->rpmbs)` to `ufs_rpmb_probe()` is an i=
ncomplete fix and still allows a NULL pointer dereference during teardown i=
f the UFS host initialization fails.
--

--- Patch [1]: [PATCH v2] scsi: ufs: core: Fix UFS RPMB device teardown ord=
er ---
commit 690fc44195b81ef7f3bac92dd785777284387f68
Author: Ao Sun <ao.sun@transsion.com>

scsi: ufs: core: Fix UFS RPMB device teardown order

The child RPMB device holds a reference to its parent, so the parent's
release callback cannot be invoked if the child device is still registered.
Remove the rpmb_dev_unregister() from the parent release handler, and
unregister the child RPMB device ahead of the parent device in the remove
path.

Closes: https://lore.kernel.org/all/20260623121840.300121F000E9@smtp.kernel=
.org/

> diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
> index ffad049872b9a..8c63913f7c397 100644
> --- a/drivers/ufs/core/ufs-rpmb.c
> +++ b/drivers/ufs/core/ufs-rpmb.c
> @@ -141,6 +134,8 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>  	u32 cap;
>  	int ret;
> =20
> +	INIT_LIST_HEAD(&hba->rpmbs);
> +

[Severity: High]
This is a pre-existing issue, but does this still allow a NULL pointer
dereference during driver unbind?

If ufshcd_probe_hba() fails asynchronously after the driver is bound,
ufs_rpmb_probe() might be skipped entirely. This leaves hba->rpmbs
zero-initialized.

Later, if the driver unbinds, ufshcd_remove() calls ufs_rpmb_remove():

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_remove() {
    if (list_empty(&hba->rpmbs))
        return;

    list_for_each_entry_safe(ufs_rpmb, tmp, &hba->rpmbs, node) {
        ...
}

Because &hba->rpmbs points to valid memory but contains NULL pointers,
list_empty() will evaluate to false, and list_for_each_entry_safe() will
dereference the NULL pointer.

[ ... ]

> @@ -174,7 +167,6 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>  		ufs_rpmb->hba =3D hba;
>  		ufs_rpmb->dev.parent =3D &hba->ufs_rpmb_wlun->sdev_gendev;
>  		ufs_rpmb->dev.bus =3D &ufs_rpmb_bus_type;

[Severity: High]
This is a pre-existing issue, but is it safe to use devm_kzalloc() for
ufs_rpmb, which contains a struct device?

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_probe() {
    ...
    ufs_rpmb =3D devm_kzalloc(hba->dev, sizeof(*ufs_rpmb), GFP_KERNEL);
    ...
}

Allocating a struct device using devres ties its memory lifetime to the
parent device rather than its own kobject reference count. If userspace
holds a reference to ufs_rpmb->dev, and the UFS driver unbinds, devres
will free the memory. The subsequent put_device() could then touch
freed memory.

> -		ufs_rpmb->dev.release =3D ufs_rpmb_device_release;

[Severity: High]
Will removing the release callback trigger a kernel warning during device
unregistration?

The driver core requires every dynamically allocated struct device to have
a valid release callback. When ufs_rpmb is unregistered during probe
failure or driver unbind:

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_remove() {
    ...
    device_unregister(&ufs_rpmb->dev);
    ...
}

If no release function is provided directly or via class/type, the driver c=
ore
will trigger a WARN_ON when the kobject reference count reaches zero.

>  		dev_set_name(&ufs_rpmb->dev, "ufs_rpmb%d", region);
> =20
>  		/* Set driver data BEFORE device_register */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714061532.167-=
1-ao.sun@transsion.com?part=3D1

