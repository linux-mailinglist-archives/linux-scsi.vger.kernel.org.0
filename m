Return-Path: <linux-scsi+bounces-25562-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7LX9J/+ZR2rfbwAAu9opvQ
	(envelope-from <linux-scsi+bounces-25562-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:16:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE3701B72
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:16:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b7ERPjqh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25562-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25562-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AFB3028827
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593B3B71A6;
	Fri,  3 Jul 2026 11:10:48 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDF306774
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 11:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077048; cv=none; b=hVMvtetoUqK0VNmJVtQVv9BhnprbqzsJY875nc1Mg5BEk8pWe0dY7uVQOEEOFqaJ8M2jO3ZpwAdoXkmSIJAH/XqVk5hv4ykNreAYAMcRnXrct5ueaKejrjjnWNcjoU0X8i9OePm/jxzHZAlilrmej2cIZzEqvo3vUYZSDef9MUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077048; c=relaxed/simple;
	bh=i4f2nRJfU6lFlb4UIfFx5AGh048WGCuQjXCSJkMzjsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YahtvN/Qd39lj2aOlahSkpuuta91EQQuGpTUUmSpD20fpe4WD/zU82EasKA0TDliofiffRgAYnFCNLcQWq8bDqWCLeX9ZHYDUX9mg6yfaZjbivR+WUFvvcHL1rQ/iG8KQHstUJKqTHr/5UgBdPz9a7a0Ekwvyc0wW9l1dXKSqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7ERPjqh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57061F000E9;
	Fri,  3 Jul 2026 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783077046;
	bh=D0ZDc9oZknVyvfZPUH/B0qYHYw4NKKwpWmPzp8WBZN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7ERPjqhQCmbz4kJC8bwNnYpqvE9SoaOY8DXuhG8geO8kgSj/HcEorJdY3ALNAz66
	 LSbkqSZREXqqXzADa74OXuzlwUX7z8Y2YHnlFe9te1pD+Pw59VA4/V2IRAvIE8LSd7
	 MPQdhsjlSscuyalpbQe1ufiJ3XQGm+IBkjU3FmsH4Z4IPc6ccXCEzBLx0sbUUXqxA2
	 jV1HjZs8LJ3Ix2NzHb84Q8kCJmreouiwz0AlFXSvlVPTmdDyzkBquJD4yD43jYEGId
	 fCCEbN/g9SU4RzBlXzlPWh++OKEMlLAUnMGfDto2wQD3qL7VWOSA05D0n221cWHzZV
	 jYoVyPY9obJxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/17] scsi-multipath: support iopolicy
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703103402.3725011-5-john.g.garry@oracle.com>
References: <20260703103402.3725011-1-john.g.garry@oracle.com>
 <20260703103402.3725011-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:10:46 +0000
Message-Id: <20260703111046.C57061F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25562-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[entry.next:url,sashiko.dev:url,lists.linux.dev:replyto,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDFE3701B72

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Newly allocated multipath heads ignore the module parameter defa=
ult for `multipath_iopolicy`.
- [Medium] Lack of synchronization in `scsi_mpath_device_iopolicy_store()` =
allows concurrent writes to race and corrupt state.
- [Low] The patch calls several undefined core `mpath_` functions and uses =
undefined types, causing build failures.

Pre-existing issues:
- [Critical] The error path in `scsi_mpath_alloc_head()` performs manual cl=
eanup after `put_device()`, leading to double-free bugs.
- [High] If `device_add()` fails in `scsi_mpath_dev_alloc()`, the error cle=
anup path crashes due to uninitialized list management and invalid device u=
nregistration.
--

commit dcaa6fb2d7264e46f58295ab1af4b1021442b793
Author: John Garry <john.g.garry@oracle.com>

scsi-multipath: support iopolicy

Add support to set the multipath iopolicy. The iopolicy member is per=20
scsi_mpath_head structure. A module param is added so that the default=20
iopolicy may be set.

> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index cb433a028dbff..6159803d4cbb8 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
[ ... ]
> @@ -95,8 +112,36 @@ static ssize_t scsi_mpath_device_vpd_id_show(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR(vpd_id, S_IRUGO, scsi_mpath_device_vpd_id_show, NULL);
> =20
> +static ssize_t scsi_mpath_device_iopolicy_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct scsi_mpath_head *scsi_mpath_head =3D
> +		container_of(dev, struct scsi_mpath_head, dev);
> +	struct mpath_head *mpath_head =3D &scsi_mpath_head->mpath_head;
> +
> +	if (!mpath_iopolicy_store(&scsi_mpath_head->iopolicy, buf, count))
> +		return -EINVAL;

[Severity: Low]
Are the functions mpath_iopolicy_store(), mpath_clear_paths(), and
mpath_schedule_requeue_work() defined anywhere in the kernel tree?
It looks like calling these will cause build failures.

> +
> +	mpath_clear_paths(mpath_head);
> +	mpath_schedule_requeue_work(mpath_head);

[Severity: Medium]
Are these sequential operations safe from race conditions when called
without holding any locks?

If multiple threads write to the sysfs attribute concurrently, could they
race and potentially duplicate path clearing or corrupt the I/O policy
state?

> +	return count;
> +}
[ ... ]
> @@ -201,7 +246,9 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(=
void)
> =20
>  	if (mpath_head_init(&scsi_mpath_head->mpath_head))
>  		goto out_free;
> +
>  	scsi_mpath_head->mpath_head.mpdt =3D &smpdt;
> +	scsi_mpath_head->mpath_head.iopolicy =3D &scsi_mpath_head->iopolicy;

[Severity: Medium]
Will newly allocated multipath heads ignore the module parameter default
for multipath_iopolicy?

Since scsi_mpath_head is kzalloc'd, iopolicy defaults to zero
(MPATH_IOPOLICY_NUMA). This assignment hooks up the pointer but doesn't
initialize it with the global iopolicy module parameter.

[Severity: Critical]
This is a pre-existing issue, but does the error path in this function
cause a double-free?

If dev_set_name() fails further down in scsi_mpath_alloc_head():

	if (ret) {
		put_device(&scsi_mpath_head->dev);
		goto out_free_ida;
	}

The put_device() call drops the refcount to 0 and synchronously invokes
scsi_mpath_head_release(), which frees the IDA slot, uninitializes the
mpath head, and calls kfree(scsi_mpath_head).

The code then jumps to out_free_ida:

out_free_ida:
	ida_free(&scsi_multipath_dev_ida, scsi_mpath_head->index);
out_put_head:
	mpath_put_head(&scsi_mpath_head->mpath_head);
out_free:
	kfree(scsi_mpath_head);

This manually repeats all of these steps, leading to a double-free and
use-after-free memory corruption.

[Severity: High]
This is a pre-existing issue, but can the device addition error path lead
to a NULL pointer dereference?

If device_add() fails in scsi_mpath_dev_alloc(), it jumps to out_put_head
and calls scsi_mpath_put_head(), which invokes scsi_mpath_free_head():

static void scsi_mpath_free_head(struct kref *ref)
{
	...
	mutex_lock(&scsi_mpath_heads_lock);
	list_del_init(&scsi_mpath_head->entry);

Because device_add() failed, the object was never added to the list via
list_add_tail(). Since scsi_mpath_head was allocated with kzalloc(),
entry.next and entry.prev are NULL, and list_del_init() will dereference
these NULL pointers.

Additionally, device_unregister() is called on a device that failed
device_add(), which violates driver core API expectations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703103402.3725=
011-1-john.g.garry@oracle.com?part=3D4

