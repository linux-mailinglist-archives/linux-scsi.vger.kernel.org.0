Return-Path: <linux-scsi+bounces-24681-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xjTaLBUlKmoCjQMAu9opvQ
	(envelope-from <linux-scsi+bounces-24681-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 05:01:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07666DEB6
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 05:01:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hsbA10Cj;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24681-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24681-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E446300ADB2
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE7233920;
	Thu, 11 Jun 2026 03:01:33 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF5487BE;
	Thu, 11 Jun 2026 03:01:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146893; cv=none; b=CSPYFTH87KXi34Tynd37vvFM3hWWe8zcr3mRZqQhVwKzMgb3tWfy9BrMaM0ooHWZo+M33NLeZ01ogIlwqdq/vYKelHciTyu/T0DrGG1/49wVx/2RfPTGaqktAkfJ2afdvoGKEZF3CQqjptS/cQTGdE6FF/AytV8u9NJJlQJ/gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146893; c=relaxed/simple;
	bh=GvdyO6pXKH/tnz5EivqwF64AAdB9N1hqE7xhqzDekjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lnyVGrAbAzErb7w8joC/MbmJFq2gkU9q/2WB7/z7VaPJbU7W1ssmZ8894xgSdQUUSGjQb6efr2HMMLZal91T9zcgQ7dkevHGF57jQN7XPq9HqsFtgapWSNN109WF0p79yiU5lRUWVoyqbk2YSf+y3wzQx7UI5H5BqKIWOjlQa5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsbA10Cj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5285D1F00893;
	Thu, 11 Jun 2026 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781146891;
	bh=PBPOE2mDhSNmbSySHR3QqjDsvZG2qZwQ6UzgH5rjgG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hsbA10Cj1B8HxKO69iGtyZ5JLK0ikeL+3xF1G21SPnOdFZu0Vqsp8mjBD27HKu2zj
	 iBFZQKwhGgLU0UvCxnXcyMcNpv5tiu3FuOEtX5qojYavmA9JD4F6XfIKaXFeLU2ctB
	 pt7vmX/tu9KzCOrNf7pIcy2oSp+OJA3y4cNtI5asd+4VealiXPq1DA6jsdfZ9MYlb1
	 3cYGzMNm8wXhAMWkReCJfvPWSXNDC/pHD0M3a4pdF0YUqsjcGDUj/+sSjqa6M3x0Xx
	 O/2CGBb4e9zzLz3WqlaAbPakCsp2YOz26ibc16UOVrtkjs2A6aWZfd8cFblHFRTZsx
	 9v8psVEnbYWBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] ata: libata-scsi: convert dev->sdev to per-LUN
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260611024356.2769320-3-philpem@philpem.me.uk>
References: <20260611024356.2769320-3-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 03:01:30 +0000
Message-Id: <20260611030131.5285D1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24681-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:philpem@philpem.me.uk,m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:cassel@kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C07666DEB6

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Deadlock caused by calling scsi_device_put() while holding an IRQ-=
disabled spinlock.
- [High] Infinite retry loop and LUN starvation due to early loop exit in a=
ta_scsi_dev_rescan().
- [Medium] Denial of Service via WARN_ON_ONCE triggered by malicious device=
 LUN.

Pre-existing issues:
- [High] Use-After-Free in ata_port_detach due to unreferenced scsi_device.
- [High] Use-After-Free in ZPODD wake callbacks racing with concurrent sysf=
s device deletion.
--

commit 49dbde19170ff410a516820c897120bfd39b44b3
Author: Phil Pemberton <philpem@philpem.me.uk>
Subject: ata: libata-scsi: convert dev->sdev to per-LUN array

Multi-LUN ATAPI devices share a single ata_device but expose multiple
scsi_devices. This patch replaces the scalar struct scsi_device *sdev
with a fixed-size array dev->sdev[ATAPI_MAX_LUN] indexed by LUN number,
allowing callers to operate on all populated LUNs.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d39ac4292f818..11f8a341252db 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6275,11 +6275,16 @@ static void ata_port_detach(struct ata_port *ap)
>  	/* Remove scsi devices */
>  	ata_for_each_link(link, ap, HOST_FIRST) {
>  		ata_for_each_dev(dev, link, ALL) {
> -			if (dev->sdev) {
> +			int lun;
> +
> +			for (lun =3D ATAPI_MAX_LUN - 1; lun >=3D 0; lun--) {
> +				struct scsi_device *sdev =3D dev->sdev[lun];
> +				if (!sdev)
> +					continue;
> +				dev->sdev[lun] =3D NULL;
>  				spin_unlock_irqrestore(ap->lock, flags);
> -				scsi_remove_device(dev->sdev);
> +				scsi_remove_device(sdev);
>  				spin_lock_irqsave(ap->lock, flags);
> -				dev->sdev =3D NULL;
>  			}
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does dropping ap->lock witho=
ut
taking a reference to sdev open a race condition in ata_port_detach() in
drivers/ata/libata-core.c?

If a concurrent sysfs device deletion drops the last reference right after
the lock is released, could scsi_remove_device(sdev) trigger a use-after-fr=
ee
when it accesses sdev->host to lock the scan mutex?

Would it be safer to use scsi_device_get() before dropping the lock, and
scsi_device_put() after scsi_remove_device()?

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 32c6a0e497cf9..b65358955cf17 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1131,7 +1131,9 @@ int ata_scsi_dev_config(struct scsi_device *sdev, s=
truct queue_limits *lim,
>  	if (dev->flags & ATA_DFLAG_TRUSTED)
>  		sdev->security_supported =3D 1;
> =20
> -	dev->sdev =3D sdev;
> +	if (WARN_ON_ONCE(sdev->lun >=3D ATAPI_MAX_LUN))
> +		return -EINVAL;
> +	dev->sdev[sdev->lun] =3D sdev;
>  	return 0;
>  }

[Severity: Medium]
In ata_scsi_dev_config() in drivers/ata/libata-scsi.c, can an external devi=
ce
provide an untrusted LUN (for example, via a crafted REPORT LUNS response o=
ver
USB)?

If so, would this WARN_ON_ONCE crash the machine when panic_on_warn is
enabled?

Should this use ata_dev_warn() or ata_dev_err() instead of WARN_ON_ONCE?

[ ... ]

> @@ -5016,28 +5025,43 @@ void ata_scsi_dev_rescan(struct work_struct *work)
>  			if (ap->pflags & ATA_PFLAG_SUSPENDED)
>  				goto unlock_ap;
> =20
> -			if (!sdev)
> -				continue;
> -			if (scsi_device_get(sdev))
> -				continue;
> +			for (lun =3D 0; lun < ATAPI_MAX_LUN; lun++) {
> +				if (dev->sdev[lun] &&
> +				    !scsi_device_get(dev->sdev[lun]))
> +					sdevs[lun] =3D dev->sdev[lun];
> +			}
> =20
>  			do_resume =3D dev->flags & ATA_DFLAG_RESUMING;
> =20
> -			spin_unlock_irqrestore(ap->lock, flags);
> -			if (do_resume) {
> -				ret =3D scsi_resume_device(sdev);
> -				if (ret =3D=3D -EWOULDBLOCK) {
> -					scsi_device_put(sdev);
> -					goto unlock_scan;
> +			for (lun =3D 0; lun < ATAPI_MAX_LUN; lun++) {
> +				if (!sdevs[lun])
> +					continue;
> +
> +				spin_unlock_irqrestore(ap->lock, flags);
> +				if (do_resume) {
> +					ret =3D scsi_resume_device(sdevs[lun]);
> +					if (ret =3D=3D -EWOULDBLOCK) {
> +						scsi_device_put(sdevs[lun]);
> +						while (++lun < ATAPI_MAX_LUN)
> +							if (sdevs[lun])
> +								scsi_device_put(sdevs[lun]);
> +						goto unlock_scan;
> +					}
> +				}
> +				ret =3D scsi_rescan_device(sdevs[lun]);
> +				scsi_device_put(sdevs[lun]);
> +				spin_lock_irqsave(ap->lock, flags);
> +
> +				if (ret) {
> +					while (++lun < ATAPI_MAX_LUN)
> +						if (sdevs[lun])
> +							scsi_device_put(sdevs[lun]);
> +					goto unlock_ap;
>  				}

[Severity: High]
In ata_scsi_dev_rescan() in drivers/ata/libata-scsi.c, could calling
scsi_device_put() here while holding the IRQ-disabled ap->lock cause a
deadlock?

If this drops the last reference to the device, the synchronous release
function ata_scsi_sdev_destroy() will execute. That function attempts to
acquire ap->lock again, which would cause a hard deadlock on the same CPU
since we just acquired it via spin_lock_irqsave(ap->lock, flags).

[Severity: High]
If scsi_rescan_device() returns an error for an early LUN (such as LUN 0), =
we
exit the loop early via goto unlock_ap.

Does this skip the dev->flags &=3D ~ATA_DFLAG_RESUMING clearance that happe=
ns
at the end of the loop?

Since the work item reschedules itself on error, would this cause an infini=
te
loop that repeatedly attempts to scan LUN 0 while permanently starving the
higher LUNs?

> -				dev->flags &=3D ~ATA_DFLAG_RESUMING;
>  			}
> -			ret =3D scsi_rescan_device(sdev);
> -			scsi_device_put(sdev);
> -			spin_lock_irqsave(ap->lock, flags);
> =20
> -			if (ret)
> -				goto unlock_ap;
> +			if (do_resume)
> +				dev->flags &=3D ~ATA_DFLAG_RESUMING;
>  		}
>  	}

> diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
> index 414e7c63bd850..151ae5726aca1 100644
> --- a/drivers/ata/libata-zpodd.c
> +++ b/drivers/ata/libata-zpodd.c
[ ... ]
> @@ -233,18 +239,27 @@ void zpodd_post_poweron(struct ata_device *dev)
>  	zpodd->zp_sampled =3D false;
>  	zpodd->zp_ready =3D false;
> =20
> -	sdev_enable_disk_events(dev->sdev);
> +	for (lun =3D 0; lun < ATAPI_MAX_LUN; lun++) {
> +		struct scsi_device *sdev =3D dev->sdev[lun];
> +		if (sdev)
> +			sdev_enable_disk_events(sdev);
> +	}
>  }
> =20
>  static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
>  {
>  	struct ata_device *ata_dev =3D context;
>  	struct zpodd *zpodd =3D ata_dev->zpodd;
> -	struct device *dev =3D &ata_dev->sdev->sdev_gendev;
> +	int lun;
> =20
> -	if (event =3D=3D ACPI_NOTIFY_DEVICE_WAKE && pm_runtime_suspended(dev)) {
> -		zpodd->from_notify =3D true;
> -		pm_runtime_resume(dev);
> +	if (event !=3D ACPI_NOTIFY_DEVICE_WAKE)
> +		return;
> +	for (lun =3D 0; lun < ATAPI_MAX_LUN; lun++) {
> +		struct scsi_device *sdev =3D ata_dev->sdev[lun];
> +		if (sdev && pm_runtime_suspended(&sdev->sdev_gendev)) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to iterate and
dereference ata_dev->sdev[lun] here in zpodd_wake_dev() in
drivers/ata/libata-zpodd.c without holding ap->lock or acquiring a reference
via scsi_device_get()?

If a SCSI device is concurrently removed (for example, via a sysfs delete
operation), could the scsi_device structure be freed while the ACPI notify
callback is executing?

Would this lead to a use-after-free when pm_runtime_suspended() is called?

> +			zpodd->from_notify =3D true;
> +			pm_runtime_resume(&sdev->sdev_gendev);
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611024356.2769=
320-1-philpem@philpem.me.uk?part=3D2

