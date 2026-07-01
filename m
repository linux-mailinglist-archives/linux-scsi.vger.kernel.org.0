Return-Path: <linux-scsi+bounces-25432-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5+QaKRskRWrh7goAu9opvQ
	(envelope-from <linux-scsi+bounces-25432-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 16:28:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5766EEBD2
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 16:28:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aNU7wFzQ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25432-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25432-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 730403035B95
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16286254B18;
	Wed,  1 Jul 2026 14:06:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F128C5B1;
	Wed,  1 Jul 2026 14:06:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914803; cv=none; b=VA5Ounpc/t30xpY2y8llXrCXs70EnmFXR5bkh1O7kF9nxU0h7+0badR96aqGK6d8kwjVpaWftApCGXTHjVmqjb40cwEPQsOWmmC2j/IA28tF/kubSkQdJMzmN227tsJB78kgTqjGFpIwQXhlDQLSSnCbkMJ0oV7ezLqO9rp1DJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914803; c=relaxed/simple;
	bh=YATV+YBlZaNE4GbvzOfUO1mOCw5qxp5qqOFyfjbKW3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQzn5UE7aPLr2679wGMz+p0lowch9vKJn3OjHhxYP5ObLRkORroCeLevKSPF58l4scx+j04cqNT/L3QaViyyWRaYObInT6nYYOUC2GcY+Ps6BJYu5DL4LRh0rRP46Wvri9r5qLmO28DpcvSVZVg1lGhvSoCAu0u1zXuHlYO7WAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNU7wFzQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE91F000E9;
	Wed,  1 Jul 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914801;
	bh=w4t4QcP8bkYGzv6rUeaVCuONCB/QC3Zl8EinkdjLQkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aNU7wFzQsMWXQUhdQ8JlEfQnFduhGxlXSZKidv9YYV09n/bRMq0TUS7SLS/VwKves
	 dp7CkaCVSEWJ7udMf+l3jnG4OoeK0Ycxzcm2EWqgCM3996rITv2j+ESZaRdMTKL7Jt
	 fslUucGLNM53U8Q62VmfoYxDPdRf8suhLV28DAcKQ93xmVHxMMSb93KJ+G6nMJywia
	 TM0/yPI4xgwF3qRymPj5B3fkS3z7ySyDGClqrlHBa35YsAOZ4RHlFVVOg/wsXMYswv
	 sWlJ+6/20XqrTQpLKFkKQmE2RWdu0VT0jmKy8Agp/PvErazAcdZLpxnleab81naaYZ
	 sN1w28Po9Wc5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] scsi: Enable async shutdown support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260701135015.81937-6-djeffery@redhat.com>
References: <20260701135015.81937-1-djeffery@redhat.com>
 <20260701135015.81937-6-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:06:41 +0000
Message-Id: <20260701140641.92EE91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25432-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:djeffery@redhat.com,m:linux-scsi@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E5766EEBD2

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Runtime PM usage counter and PM state leak on device_add error pat=
h.
- [High] Concurrent lockless bitfield mutations cause Data Race and PM stat=
e corruption.
--

commit 10ebc4309581b7d74ed1d3564b5f1af2a5cf5785
Author: David Jeffery <djeffery@redhat.com>

scsi: Enable async shutdown support

Like scsi's async suspend support, allow scsi devices to be shut down
asynchronously to reduce system shutdown time.

> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index dfc3559e7e04f..8fd317aef37b4 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1386,6 +1386,7 @@ static int scsi_target_add(struct scsi_target *star=
get)
>  	pm_runtime_set_active(&starget->dev);
>  	pm_runtime_enable(&starget->dev);
>  	device_enable_async_suspend(&starget->dev);
> +	dev_set_async_shutdown(&starget->dev);

[Severity: High]
This is a pre-existing issue, but does adding dev_set_async_shutdown() here
exacerbate a data race with system suspend?

In scsi_target_add(), device_add() is called earlier, exposing the device
to the PM core. If a system-wide suspend happens concurrently,
device_prepare() may lock the device and set the is_prepared bitfield.

Since device_enable_async_suspend() and dev_set_async_shutdown() locklessly
mutate bitfields in dev->power in the same memory word, couldn't the
resulting read-modify-write instructions overwrite and clear the is_prepared
flag set by the PM core?

>  	return 0;
>  }

[ ... ]

> @@ -1412,6 +1413,7 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
>  	transport_configure_device(&starget->dev);
> =20
>  	device_enable_async_suspend(&sdev->sdev_gendev);
> +	dev_set_async_shutdown(&sdev->sdev_gendev);

[Severity: High]
This isn't a bug introduced by this patch, but could the error path for
device_add(&sdev->sdev_gendev) leak the PM usage counter and runtime state?

When scsi_sysfs_add_sdev() is called, it increments the PM usage count via
scsi_autopm_get_device(sdev) and enables runtime PM. If the subsequent
device_add(&sdev->sdev_gendev) fails, the function returns the error direct=
ly
without dropping the usage counter or disabling runtime PM:

scsi_sysfs_add_sdev() {
    ...
    scsi_autopm_get_device(sdev);
    ...
    error =3D device_add(&sdev->sdev_gendev);
    if (error) {
        sdev_printk(...);
        return error;
    }
}

Would this prevent the device and its parent target from ever entering
runtime suspend, causing unbounded power drain?

>  	scsi_autopm_get_target(starget);
>  	pm_runtime_set_active(&sdev->sdev_gendev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701135015.8193=
7-1-djeffery@redhat.com?part=3D5

