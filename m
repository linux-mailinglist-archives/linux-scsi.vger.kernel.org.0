Return-Path: <linux-scsi+bounces-25577-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ckvULjSrR2r2dAAAu9opvQ
	(envelope-from <linux-scsi+bounces-25577-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 14:29:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E47025BF
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 14:29:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ar6wHRK7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25577-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25577-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 426AB3015700
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464C32AAA0;
	Fri,  3 Jul 2026 12:25:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56833D2FE6
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 12:25:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081517; cv=none; b=SLvMr2U28J89TvgME2VvC4hQWEgMlsrhnpFU1HG7jX0yhVhefHnptUNXpKJ4hhud57QwZtCd1kdxd1VUpvMej7YdbGm11wE6CpBJL7j2v1UJcawOWOcosRmC0mqplo4cpP1yYZ4Q1hGwkk4hfgSH3O6/ZWiIhYq9qeM71hEsKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081517; c=relaxed/simple;
	bh=9oDSVv1FTJYFxu/Rr3rH4gX6ASAjjg+Kpe6bASxR8d8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRO0rLXBiOvKIdIzuVcgkEmShMpY2lIesVx5QMFJ5/cgMPJXF0tuBv1y0Op9qLWor1Hg1McmM7uCvrBfth8eEzl3oIVsw9NhwS6vRLFWgpenSItzc+BITzxuA4FDnaJSorZijuAzaMVf4/jFEY25lVbKRw+YHoonuFbDFAE0pU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar6wHRK7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9AC1F00A3A;
	Fri,  3 Jul 2026 12:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783081515;
	bh=o7cnjRS6Nx+egr8+cSgCyoT1LNMEmUg/ysZ2IFmDJZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ar6wHRK7URRfT1UHZMooDWkWdbiGEBCO9R/v5XocPG+U5eQPJP/1MZg9y8Ozgm2tq
	 cFy9b+FINeP+2tSipvgrzRwLIHDZ8yKuxHrYz2z503smEjqaPNE/JiKrzBwGgltItZ
	 Fl0dyXmhpZy8/lH+ESmsoGhetgVP4cJc4hxkRaJ5jQjOIa61e7U8N7UIN02dIFx1tK
	 fGU8gLKvWgza4xzjz3vHQwxnMtq32nSGIjngfa8tXvfrSZ63FOCfe66S3caXi10xQi
	 TLXVNNikZN/f37Sp8gRze1FKXK03D8WPCpbvH5seST3BaK4s6YI27RUJ2UKHoa4WML
	 pFtlsc/UeioBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/17] scsi: sd: add multipath disk attr groups
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703103402.3725011-15-john.g.garry@oracle.com>
References: <20260703103402.3725011-1-john.g.garry@oracle.com>
 <20260703103402.3725011-15-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:25:14 +0000
Message-Id: <20260703122515.6B9AC1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25577-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D1E47025BF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch references several undeclared identifiers and undefined f=
unctions, which will cause fatal compilation and linker errors.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but error paths in `=
sd_mpath_probe()` incorrectly use `kfree()` instead of `put_device()` after=
 `device_initialize()`, leaking kobject resources. Furthermore, it cannot t=
rivially use `put_device()` without causing a use-after-free and IDA corrup=
tion.
--

commit c032527f31f85b7a1e95cfcc2527fe7e368f3474
Author: John Garry <john.g.garry@oracle.com>

scsi: sd: add multipath disk attr groups

Set multipath disk attr groups, which includes delayed disk removal and
everything from mpath_attr_group.

> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 3df70b24b688e..a9a29e50f5eec 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c

[ ... ]

> @@ -4106,6 +4106,41 @@ static void sd_mpath_add_disk(struct scsi_disk *sd=
kp)
>  	mpath_device_set_live(mpath_device);
>  }
> =20
> +static ssize_t sd_mpath_device_delayed_removal_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct mpath_head *mpath_head =3D mpath_bd_device_to_head(dev);
> +
> +	return mpath_delayed_removal_secs_store(mpath_head, buf, count);
> +}
> +
> +static ssize_t sd_mpath_device_delayed_removal_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct mpath_head *mpath_head =3D mpath_bd_device_to_head(dev);
> +
> +	return mpath_delayed_removal_secs_show(mpath_head, buf);
> +}

[Severity: Low]
Are the functions mpath_bd_device_to_head(), mpath_delayed_removal_secs_sto=
re(),
and mpath_delayed_removal_secs_show() declared anywhere? It looks like they
might be missing, which would cause a build error.

> +
> +static DEVICE_ATTR(delayed_removal_secs, S_IRUGO | S_IWUSR,
> +		sd_mpath_device_delayed_removal_show,
> +		sd_mpath_device_delayed_removal_store);
> +
> +static struct attribute *sd_mpath_disk_attrs[] =3D {
> +	&dev_attr_delayed_removal_secs.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sd_mpath_disk_attr_group =3D {
> +	.attrs		=3D sd_mpath_disk_attrs,
> +};
> +
> +static const struct attribute_group *sd_mpath_disk_attr_groups[] =3D {
> +	&sd_mpath_disk_attr_group,
> +	&mpath_attr_group,

[Severity: Low]
Is the external variable mpath_attr_group declared and defined? Building wi=
th
this patch applied results in an undeclared identifier error.

> +	NULL
> +};
> +
>  static int sd_mpath_probe(struct scsi_disk *sdkp)
>  {
>  	struct scsi_device *sdp =3D sdkp->device;
> @@ -4161,6 +4196,7 @@ static int sd_mpath_probe(struct scsi_disk *sdkp)
> =20
>  	mpath_head->parent =3D &sd_mpath_disk->dev;
>  	mpath_head->drv_module =3D THIS_MODULE;
> +	mpath_head->disk_groups =3D sd_mpath_disk_attr_groups;
>  	error =3D mpath_alloc_head_disk(mpath_head, &lim,
>  				dev_to_node(dma_dev));
>  	if (error)

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying
sd_mpath_probe(), is it safe to use kfree() on error paths after
device_initialize() has been called on sd_mpath_disk->dev?

If mpath_alloc_head_disk() fails, the code jumps to out_free_disk:

drivers/scsi/sd.c:sd_mpath_probe() {
    ...
    device_initialize(&sd_mpath_disk->dev);
    ...
    error =3D mpath_alloc_head_disk(mpath_head, &lim, dev_to_node(dma_dev));
    if (error)
        goto out_free_disk;
    ...
out_free_disk:
    kfree(sd_mpath_disk);
    ...
}

Should this use put_device() instead to ensure the kobject internals are
properly cleaned up?

However, calling put_device() would invoke sd_mpath_disk_release(), which
unconditionally calls ida_free() and scsi_mpath_put_head(). Would
sd_mpath_disk_release() need to be updated to handle partial initialization=
 if
put_device() were used here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703103402.3725=
011-1-john.g.garry@oracle.com?part=3D14

