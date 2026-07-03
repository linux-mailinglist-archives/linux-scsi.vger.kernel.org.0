Return-Path: <linux-scsi+bounces-25556-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fy7IFbGYR2pXbwAAu9opvQ
	(envelope-from <linux-scsi+bounces-25556-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:10:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1063701A49
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:10:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UlLYFhG+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25556-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25556-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA7D303641C
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196E3BE16E;
	Fri,  3 Jul 2026 10:51:34 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6703BC664
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 10:51:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075894; cv=none; b=M+Hm4YZHJlxXMTrlzArpOFeNNWWGjEqkz14mCU+5AAKja+XElqKmpjlClHT2H2Uzur/D+gEydYUJzFdgZ2/fZmZtOcOis2AQAUq/69dutpvY12l/7UzKKG9aU3rzqYptQgxnC/S6nBUa6H0dpRO2GssFXJLb17qgzx5VeX+uBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075894; c=relaxed/simple;
	bh=xiPKUtgXtXjy218JDApeE+WjGR2IW2gX8mTpLGUtufw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OTU3EMDTbWrSrAVNnTnl6lU2Kky5f2jcwmY4cMsaWeku4uOzq5SN67Y9QHRc0V6yjmFuV+z58nO+xDQyahTWaEgLwmy3+IOasFRVNSyhHMoAIujH1mK5rHpvb6bGJkzNz4ZiAstEzv0g1NEEOtZmKAvUkLhQG/bqqBugz1vWT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlLYFhG+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EF31F000E9;
	Fri,  3 Jul 2026 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075892;
	bh=5iuMdGXBqUr5r7RvwGrOiX62DPMrH+elbAjPzo/EJVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UlLYFhG+CEGmD2p50PI86Oh7FeKay4ddG3xQIhDvntHSmaGnaaofpuu6H0/mbwfPW
	 0E9/i6tiIiGSSHy4sMonk+G5IY7PZZBlbrNeZvRKT+BLIfwU5fkarcnf7GpPvhEvqB
	 X043N8xFLHDldbdD6rL5oMRvxCn2AOS95mK5y5WR8jCVAWtb7SXokvPjmRqjeArXt+
	 TD3TmDuO/DPlOekdlmM0i2opQguFeZdn8OJNub7PN8yT5Vhaf3Lx1KoumUpE4f8n3j
	 S/DAs76dCzHzSIvc1I3Ty3pV1BKBlyEA90RpjA8bbnhmMpEss0gpgqoIbgNuUj2KPw
	 QNThuZqIArTpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/13] libmultipath: Add basic gendisk support
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703102918.3723667-3-john.g.garry@oracle.com>
References: <20260703102918.3723667-1-john.g.garry@oracle.com>
 <20260703102918.3723667-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:51:31 +0000
Message-Id: <20260703105132.44EF31F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25556-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1063701A49

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `mpath_alloc_head_disk()` leaves `ERR_PTR` in `mpath_head->disk` o=
n failure, causing a kernel panic during cleanup or state updates.
- [High] A TOCTOU race between `mpath_device_set_live()` and `mpath_remove_=
disk()` permanently leaks the gendisk.
- [High] Synchronous wait in `mpath_head_uninit()` allows unprivileged open=
ers to block device teardown indefinitely.
--

commit bba05c007c446cdb19dbac857c9ce717ca5f2a08
Author: John Garry <john.g.garry@oracle.com>
Subject: libmultipath: Add basic gendisk support

This patch adds support to allocate and free a multipath gendisk. It also
introduces struct mpath_head_template as a method for drivers to provide
custom multipath functionality.

> diff --git a/lib/multipath.c b/lib/multipath.c
> index 009d4bb875c6f..79be84d3d4f75 100644
> --- a/lib/multipath.c
> +++ b/lib/multipath.c
> @@ -44,12 +44,111 @@ void mpath_head_uninit(struct mpath_head *mpath_head)
>  }
>  EXPORT_SYMBOL_GPL(mpath_head_uninit);
> =20
> +static int mpath_bdev_open(struct gendisk *disk, blk_mode_t mode)
> +{
> +	struct mpath_head *mpath_head =3D disk->private_data;
> +
> +	return mpath_get_head(mpath_head);
> +}

[Severity: High]
Does this increment the refcount on behalf of userspace openers?

If unprivileged users open the block device, this calls mpath_get_head()
which increments mpath_head->refcount. If the admin later removes the devic=
e,
the driver calls mpath_head_uninit() which synchronously waits for the
refcount to hit zero. Since the user can hold the file descriptor open,
couldn't this allow unprivileged openers to permanently hang the kernel
thread handling device removal?

[ ... ]

> +void mpath_remove_disk(struct mpath_head *mpath_head)
> +{
> +	if (test_and_clear_bit(MPATH_HEAD_DISK_LIVE, &mpath_head->flags)) {
> +		struct gendisk *disk =3D mpath_head->disk;
> +
> +		del_gendisk(disk);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mpath_remove_disk);

[Severity: High]
Is there a race here with mpath_device_set_live() that could permanently
leak the gendisk?

If Thread A calls mpath_device_set_live() and sets MPATH_HEAD_DISK_LIVE
locklessly via test_and_set_bit(), and Thread B concurrently calls
mpath_remove_disk(), Thread B will clear the flag and call del_gendisk().

Because device_add_disk() in Thread A hasn't completed and set GD_ADDED
yet, del_gendisk() observes the disk is not live and returns early without
doing anything.=20

Thread A then completes device_add_disk() making the disk live, but the
flag is now 0. Any subsequent mpath_remove_disk() will do nothing, leaking
the active block device.

> +void mpath_put_disk(struct mpath_head *mpath_head)
> +{
> +	if (!mpath_head->disk)
> +		return;
> +
> +	/* make sure all pending bios are cleaned up */
> +	flush_work(&mpath_head->partition_scan_work);
> +	put_disk(mpath_head->disk);
> +}
> +EXPORT_SYMBOL_GPL(mpath_put_disk);
> +
> +int mpath_alloc_head_disk(struct mpath_head *mpath_head,
> +			struct queue_limits *lim, int numa_node)
> +{
> +	if (!mpath_head->disk_groups || !mpath_head->parent)
> +		return -EINVAL;
> +
> +	mpath_head->disk =3D blk_alloc_disk(lim, numa_node);
> +	if (IS_ERR(mpath_head->disk))
> +		return PTR_ERR(mpath_head->disk);

[Severity: High]
If blk_alloc_disk() fails, does this leave an ERR_PTR in mpath_head->disk?

When the driver cleans up on error and calls mpath_put_disk(), the
if (!mpath_head->disk) check will pass because the ERR_PTR is not NULL.
Will this result in a kernel panic when put_disk() attempts to dereference
the invalid pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703102918.3723=
667-1-john.g.garry@oracle.com?part=3D2

