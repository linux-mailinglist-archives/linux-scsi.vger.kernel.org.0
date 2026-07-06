Return-Path: <linux-scsi+bounces-25631-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pfvBGtdjS2p6QgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25631-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 10:14:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D670DFAB
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 10:14:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KIvkUdqn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25631-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25631-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5237A3066209
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 07:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A63DEACB;
	Mon,  6 Jul 2026 07:42:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A72397B15
	for <linux-scsi@vger.kernel.org>; Mon,  6 Jul 2026 07:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323773; cv=none; b=GqWt1oRSdMUVC7J3BJ40+58v5f5G7HCx+TZrMh1T9DFkgU0QhsUGadNGMdWr4SlgWQrQXjqHIQdNgr4K5wLF0DwuHPA86RpxQhtFZNSxCZd5hcKf/9E/1lGiRZoynlQjOEIh4EwBhoZDSYEHuFJWDkR5aPX6AexIiLtjtbF8tFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323773; c=relaxed/simple;
	bh=niwAlge9L5fgkqo6euxhAO8hLThDkKjRjbkIzPS9bJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOj/dje2pK6wKvipGXbc/WX+uku4WkdN7ORlaR9G6nycbdciiudV9nbUTHRRzOT3h02ACQVrLdsukqCcZpwhkb3ytWne5aD0bY464yM5BbEbjejeoLB25vKg1s+qWMfnvbmo5u1UJE985UagKP9pBNkEQXfEb/au/7zmhF4Elrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIvkUdqn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77281F000E9;
	Mon,  6 Jul 2026 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783323765;
	bh=E0D2WIrkCZ6obwEn3v9eageniG4GwRsYNM5l90qPzAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIvkUdqnENI14evSzLaBdh0r5pN7X3ycCkuOLUrR3hrm0o5HNwSqiU91LKLdKC29Y
	 AbyImfx+URHxde/q8RVq129YMJ0H/M40zQoNq2pzAoJR/QMwgOFLLTz5fW8cKs8LcA
	 Ju2IRaJ5kkys27501VqiH7OCrEcZwEmyfVoT9ZXrsr8LcZRxVkkCpzTcezYIGeJX7T
	 1YiTUqkvZuD6aLBbWgCZoRrvvTu9JMYbQRr6LEnVOnH1Twd0urRn2bWwncEWquWWYj
	 u5h89xBaNR3eeCmhJUwDjvpt8PNym2q1y1/0Sf2oRpCiUnUo1BlDDTiUi9/902d1GD
	 apyfH4lTAbWAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: ses: unregister the enclosure before freeing its
 device state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260706-b4-disp-cf600574-v1-1-be4f324ff44c@proton.me>
References: <20260706-b4-disp-cf600574-v1-1-be4f324ff44c@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:42:44 +0000
Message-Id: <20260706074244.C77281F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25631-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,proton.me:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE0D670DFAB

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The enclosure device is published to sysfs and the global list bef=
ore its private data pointers are initialized, allowing concurrent accesses=
 to trigger a NULL pointer dereference.
--

commit c0db7f74419376e5dfdb039e9a143c3b6a8d01bf
Author: Bryam Vargas <hexlabsecurity@proton.me>

scsi: ses: unregister the enclosure before freeing its device state

ses_intf_remove_enclosure() frees ses_dev and the page1/page2/page10
buffers it owns before calling enclosure_unregister(). This leaves the
component sysfs attributes live over freed memory, meaning a concurrent
read or write could trigger a use-after-free. This patch reorders the
teardown to unregister first, then free.

Fixes: 9927c68864e9 ("[SCSI] ses: add new Enclosure ULD")
Closes: https://sashiko.dev/#/patchset/20260706-b4-disp-29a05ca3-v1-1-49591=
f469f60@proton.me?part=3D1
Cc: stable@vger.kernel.org

> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index 4c348645b04ee..a3039a3ede56c 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -869,18 +870,24 @@ static void ses_intf_remove_enclosure(struct scsi_d=
evice *sdev)
>  		return;
> =20
>  	ses_dev =3D edev->scratch;
> -	edev->scratch =3D NULL;

[Severity: High]
This is a pre-existing issue, but since we are looking at sysfs race
conditions involving edev->scratch, could a similar race occur during
initialization in ses_intf_add()?

When ses_intf_add() registers the enclosure:

drivers/scsi/ses.c:ses_intf_add() {
	edev =3D enclosure_register(cdev->parent, dev_name(&sdev->sdev_gendev),
				  components, &ses_enclosure_callbacks);
	if (IS_ERR(edev)) {
		err =3D PTR_ERR(edev);
		goto err_free;
	}

	kfree(hdr_buf);

	edev->scratch =3D ses_dev;
	...
}

The enclosure_register() call makes the device visible to userspace and
could trigger a read of the id sysfs attribute before edev->scratch is
assigned.

If that happens, would the id_show callback lead to a NULL pointer
dereference here?

drivers/scsi/ses.c:ses_show_id() {
	struct ses_device *ses_dev =3D edev->scratch;
	unsigned long long id =3D get_unaligned_be64(ses_dev->page1+8+4);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-b4-disp-cf=
600574-v1-1-be4f324ff44c@proton.me?part=3D1

