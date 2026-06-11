Return-Path: <linux-scsi+bounces-24716-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7HD4Jd2rKmoGuwMAu9opvQ
	(envelope-from <linux-scsi+bounces-24716-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 14:36:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E39671E7A
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 14:36:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JHnlllGp;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24716-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24716-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2966C306FF32
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 12:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788AB3F787C;
	Thu, 11 Jun 2026 12:34:32 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE73F0763
	for <linux-scsi@vger.kernel.org>; Thu, 11 Jun 2026 12:34:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181272; cv=none; b=eC+rWzINGo1zk3R7HxvuYjuGaIHV2uh9Ck1q5jKOpwmZAozUs4o8SnVEf5w1BWnXG2rSlkntTfG4XmpOL2xuyGdfyC/ENiE9zt9ZaxM1YfvcCwJxTjYEs6TWle8SRq5JARScT97LJnXjYPR1bnNFSLS6xjCdCYzh7PPNI5tShTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181272; c=relaxed/simple;
	bh=sE7LBVFts7GAzHF3y2QXXeMQ18jAu+qCvdJtO+dYjOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5kJT8aNl5ZJmDZIrvi3N/+0Byi6MWYWNMdRbI8USCqXKRS9ZzrO30dBvAdaE2HtCkgSI1/p2S5QwZuKmc79dCxMxY/YhgOT0qUtC8dF8M1tQzUQwCAr/ON8qAzPJVvY0XheurGWjEen/meINvTnxeV5RknzLSl9UnOgHb8ft28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHnlllGp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6F21F00898;
	Thu, 11 Jun 2026 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781181270;
	bh=+qalzoBBT6l0wzrrZblaqr5HJdXooOBLxHakGZJSECo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHnlllGpec4fDYKMYL+HyIhIi3PKVJS5PAM4X5hR1ZrLyKGLMmuZ0oWuMBnNWMnTi
	 49/V5PkXr9JZUZyzMa7FJgRWDXl+lMdjLYGNn47Vx60tPab6as6UTUqqxfIaJeO6UC
	 JDgGAj4/p9ZX7UO2tGrf8UzXANPq3iNxS9gfNG6QSlhwu6oba3uSGzUIGECA6MnYee
	 bKxM43ypoNkDA4oziELBX774ttcJD60ZZv6u1OuHdQ75a9AhluSxwMADH624W15PnC
	 zDWgf1mfnKmkuYLuo7pkJjFez6YOfd8q3maS1DR7ripES3e2AtRhITgf+61vbAiosT
	 oQftrDDGjsoIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: target: cxgbit: fix refcount leak in
 __cxgbit_free_cdev_np
Reply-To: sashiko-reviews@lists.linux.dev
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260611122203.78379-1-vulab@iscas.ac.cn>
References: <20260611122203.78379-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:34:30 +0000
Message-Id: <20260611123430.AB6F21F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24716-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09E39671E7A

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces critical use-after-free and double-free v=
ulnerabilities by unconditionally dropping the `cnp` reference count on bot=
h the success and timeout paths, violating the driver's asynchronous reply =
handling model.

Pre-existing issues:
- [Critical] When `__cxgbit_free_cdev_np()` times out, it aborts cleanup an=
d causes the caller `cxgbit_free_all_np()` to break its loop, leaving dangl=
ing STID references to `cnp` on remaining devices.
--

commit f433423e199b1a3438bcf4e0bc324b24ab3b6629
Author: WenTao Liang <vulab@iscas.ac.cn>

scsi: target: cxgbit: fix refcount leak in __cxgbit_free_cdev_np

__cxgbit_free_cdev_np() calls cxgbit_get_cnp() to take a reference
on cnp for the duration of the firmware remove-server operation.
This patch attempts to release the reference on the timeout and
success paths.

Cc: stable@vger.kernel.org
Fixes: 9730ffcb8957 ("cxgbit: add files for cxgbit.ko")

> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/isc=
si/cxgbit/cxgbit_cm.c
> index 146705845fa3e..f8cd6457666b0 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
> @@ -544,8 +544,10 @@ __cxgbit_free_cdev_np(struct cxgbit_device *cdev, st=
ruct cxgbit_np *cnp)
> =20
>  	ret =3D cxgbit_wait_for_reply(cdev, &cnp->com.wr_wait,
>  				    0, 10, __func__);
> -	if (ret =3D=3D -ETIMEDOUT)
> +	if (ret =3D=3D -ETIMEDOUT) {
> +		cxgbit_put_cnp(cnp);
>  		return ret;
> +	}

[Severity: Critical]
Does this cause a use-after-free and double-free if the firmware
reply is delayed?

In the Chelsio hardware transaction model, the reference acquired by
cxgbit_get_cnp() before sending the remove-server command is strictly
intended to be consumed by the asynchronous firmware reply handler,
cxgbit_close_listsrv_rpl().

If we time out and drop the reference here, the firmware request is
still pending and the STID is not unlinked. When the delayed reply
eventually arrives, cxgbit_close_listsrv_rpl() will look up the STID,
retrieve the already-freed cnp object, dereference it to wake up the
wait queue, and attempt to drop the reference again:

drivers/target/iscsi/cxgbit/cxgbit_cm.c:cxgbit_close_listsrv_rpl() {
    ...
    cxgbit_wake_up(&cnp->com.wr_wait, __func__, rpl->status);
    cxgbit_put_cnp(cnp);
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does this timeout path leave
dangling STID references that lead to a use-after-free on incoming
connections?

If __cxgbit_free_cdev_np() returns -ETIMEDOUT, the caller
cxgbit_free_all_np() will break its loop and abandon the removal
of STIDs on subsequent healthy devices:

drivers/target/iscsi/cxgbit/cxgbit_cm.c:cxgbit_free_all_np() {
    ...
    ret =3D __cxgbit_free_cdev_np(cdev, cnp);
    if (ret =3D=3D -ETIMEDOUT)
        break;
    ...
}

The parent caller cxgbit_free_np() then drops its base reference, freeing
the cnp object. Because the remaining devices still have active STID
registrations pointing to this freed cnp, any incoming connection request
handled by cxgbit_pass_accept_req() will look up the dangling STID and
access the freed cnp.

> =20
>  	if (ipv6 && cnp->com.cdev) {
>  		struct sockaddr_in6 *sin6;
[ ... ]
> @@ -558,6 +560,7 @@ __cxgbit_free_cdev_np(struct cxgbit_device *cdev, str=
uct cxgbit_np *cnp)
> =20
>  	cxgb4_free_stid(cdev->lldi.tids, stid,
>  			cnp->com.local_addr.ss_family);
> +	cxgbit_put_cnp(cnp);

[Severity: Critical]
Does this addition cause an immediate double-free on the success path?

On the success path where cxgbit_wait_for_reply() returns 0, the
asynchronous reply handler cxgbit_close_listsrv_rpl() has already
executed and dropped the reference originally acquired by
cxgbit_get_cnp(). Adding an unconditional cxgbit_put_cnp(cnp) here
will attempt to drop a reference that has already been consumed.

>  	return 0;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611122203.7837=
9-1-vulab@iscas.ac.cn?part=3D1

