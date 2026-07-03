Return-Path: <linux-scsi+bounces-25551-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fQAuIkaWR2qtbgAAu9opvQ
	(envelope-from <linux-scsi+bounces-25551-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:00:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E530D70189B
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aDvplC2z;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25551-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25551-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFABE3107BAA
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C03BB671;
	Fri,  3 Jul 2026 10:46:00 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAF3BA253
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 10:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075560; cv=none; b=ISFZNHjo8+TY4DgZeM20bGvlqg4qxMi3DGxn3ZLpn8PDmR83D7XWJ8+evR2WpuKP9qCG0xxlFNDi+rmv4YK9SDmKRm77Hgbe7CZw6rjiW2I0XTYCfylbd+CokHKUHJKVa+rDb6BKOyMVo/an6psTFXPQ/33kexgn7JL4R6tWJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075560; c=relaxed/simple;
	bh=XgUZtbP9w0t6Q2ykhDDEwcI0vUhPQXTVa5iBPKR+hGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aSMRArno+YHnJPZx7hjnnLHn7CZsspvxJHeQ7UQjpSJTTE0BraBlBBgoPHoWqE/fqRKIFmi3sxqt0ygYRAr/dbB5/xOCep0k1fY67V4exX6xn7k9rgQ4mJRYctEqvJUDdhGWcfjdXJepY5ly7nDD8x1kI9kXuj3GFV9qoWlB7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDvplC2z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6B71F000E9;
	Fri,  3 Jul 2026 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075557;
	bh=VUmiubtXSP2oI3Hp29pCTi2EaUvOTqb/gBUygY3Uua4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aDvplC2zQ7PDn9GzSOOQ9wT3AKBPOsNprzTn8Ud+kQeAt7AsE20LJB+3QoW4/Dv3U
	 KjbjlrwNe71M0vgBFev8W9DL7fGVQ8YmeFaOjUHm2C2ycEfRFua7U74B6d0NOm9oF9
	 WwDD/xTkQfNRC6cYaOL3sSJDdC2+q1q00aDHgGIdra+N88nOLCflMjiwSXrmG4cAh8
	 FDnkGOe5NU8e5WHd+oXGFWnQeX7c2WPBAt8oNEKFd9SE6Pn5OEUN4S942rtmVkzbP5
	 1aiKriLnBvKSHtCzvg6zIko7smouP3ObaodO+5fN1BzMCeYyH6ECchfBAnH7k72XG/
	 Sx/JNy3y2gEFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] libmultipath: Add path selection support
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703102918.3723667-4-john.g.garry@oracle.com>
References: <20260703102918.3723667-1-john.g.garry@oracle.com>
 <20260703102918.3723667-4-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:45:55 +0000
Message-Id: <20260703104556.AC6B71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25551-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E530D70189B

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] `mpath_round_robin_path` enters an infinite loop if the current ca=
ched path (`old`) is concurrently removed.
- [High] Unsafe usage of `list_is_singular()` on an RCU list leads to data =
races and routes I/O to a removed path.
- [High] `mpath_numa_path` fails to verify if the cached path is disabled b=
efore returning it, potentially routing I/O to a disabled path.
- [High] `mpath_alloc_head_disk` leaves an ERR_PTR in `mpath_head->disk` on=
 failure, causing cleanup paths to crash.
- [Medium] NULL pointer dereference in `mpath_queue_depth_path` if a device=
 does not provide `nr_active`.
- [Medium] The `.get_access_state` callback is missing from `struct mpath_h=
ead_template`, violating the documented API intent.
--

commit e941f797884516dd9568e0b668984eb3c895248a
Author: John Garry <john.g.garry@oracle.com>

    libmultipath: Add path selection support
   =20
    Add code for path selection.

>     NVMe ANA is abstracted into enum mpath_access_state. The motivation h=
ere is
>     so that SCSI ALUA can be used. Callbacks .is_disabled, .is_optimized,
>     .get_access_state are added to get the path access state.

[Severity: Medium]
The commit message mentions adding a .get_access_state callback, but it app=
ears
to be missing from struct mpath_head_template. Is this intentional, or shou=
ld
it be included in the struct definition to avoid requiring drivers to direc=
tly
modify the access_state field?

[ ... ]
> diff --git a/lib/multipath.c b/lib/multipath.c
> index 79be84d3d4f75..21f7ffdb22d60 100644
> --- a/lib/multipath.c
> +++ b/lib/multipath.c
[ ... ]
> +static struct mpath_device *mpath_round_robin_path(
> +				struct mpath_head *mpath_head)
> +{
> +	struct mpath_device *mpath_device, *found =3D NULL;
> +	int node =3D numa_node_id();
> +	enum mpath_access_state access_state_old;
> +	struct mpath_device *old =3D
> +			srcu_dereference(mpath_head->current_path[node],
> +				&mpath_head->srcu);
> +
> +	if (unlikely(!old))
> +		return __mpath_find_path(mpath_head, node);
> +
> +	if (list_is_singular(&mpath_head->dev_list)) {
> +		if (mpath_path_is_disabled(mpath_head, old))
> +			return NULL;
> +		return old;
> +	}

[Severity: High]
Could using list_is_singular() here lead to data races? Since this list is
managed with RCU, and list_is_singular() evaluates head->next =3D=3D head->=
prev,
it might read inconsistent prev pointers during concurrent updates. Also, i=
f old
was concurrently removed and only one valid path remains, would this return
the removed old path instead of the new remaining path?

> +
> +	for (mpath_device =3D mpath_next_dev(mpath_head, old);
> +	    mpath_device && mpath_device !=3D old;
> +	    mpath_device =3D mpath_next_dev(mpath_head, mpath_device)) {

[Severity: High]
Does this loop terminate safely if old has been concurrently removed from t=
he list?
If old is unlinked via list_del_rcu(), mpath_device !=3D old will always be=
 true.
Could this result in an infinite loop wrapping around the active elements
indefinitely, leading to a lockup if no path is MPATH_STATE_OPTIMIZED?

> +
> +		if (mpath_path_is_disabled(mpath_head, mpath_device))
> +			continue;
[ ... ]
> +static struct mpath_device *mpath_queue_depth_path(
> +				struct mpath_head *mpath_head)
> +{
> +	struct mpath_device *best_opt =3D NULL, *mpath_device;
> +	struct mpath_device *best_nonopt =3D NULL;
> +	unsigned int min_depth_opt =3D UINT_MAX, min_depth_nonopt =3D UINT_MAX;
> +	unsigned int depth;
> +
> +	list_for_each_entry_srcu(mpath_device, &mpath_head->dev_list, siblings,
> +				 srcu_read_lock_held(&mpath_head->srcu)) {
> +
> +		if (mpath_path_is_disabled(mpath_head, mpath_device))
> +			continue;
> +
> +		depth =3D atomic_read(mpath_device->nr_active);

[Severity: Medium]
Could this dereference a NULL pointer if a device was added without providi=
ng
an nr_active atomic counter during mpath_add_device()? If userspace sets the
I/O policy to 'queue-depth' via sysfs, would it crash here?

> +
> +		switch (mpath_device->access_state) {
[ ... ]
> +static struct mpath_device *mpath_numa_path(struct mpath_head *mpath_hea=
d)
> +{
> +	int node =3D numa_node_id();
> +	struct mpath_device *mpath_device;
> +
> +	mpath_device =3D srcu_dereference(mpath_head->current_path[node],
> +					&mpath_head->srcu);
> +	if (unlikely(!mpath_device))
> +		return __mpath_find_path(mpath_head, node);
> +	if (unlikely(!mpath_path_is_optimized(mpath_head, mpath_device)))
> +		return __mpath_find_path(mpath_head, node);
> +	return mpath_device;
> +}

[Severity: High]
Does this correctly validate the cached path before returning it? Unlike ot=
her
path selection functions, this omits checking mpath_path_is_disabled().
If a path transitions to a disabled state but remains marked as optimized, =
could
mpath_numa_path() incorrectly continue to route I/O to it?

[ ... ]
> @@ -103,7 +339,8 @@ EXPORT_SYMBOL_GPL(mpath_put_disk);
>  int mpath_alloc_head_disk(struct mpath_head *mpath_head,
>  			struct queue_limits *lim, int numa_node)
>  {
> -	if (!mpath_head->disk_groups || !mpath_head->parent)
> +	if (!mpath_head->disk_groups || !mpath_head->parent ||
> +	    !mpath_head->iopolicy)
>  		return -EINVAL;
> =20
>  	mpath_head->disk =3D blk_alloc_disk(lim, numa_node);

[Severity: High]
If blk_alloc_disk() fails, it returns an ERR_PTR. If this is assigned direc=
tly
to mpath_head->disk and an error is returned without setting mpath_head->di=
sk
back to NULL, could this cause subsequent cleanup paths (like mpath_put_dis=
k())
to crash when they check if (mpath_head->disk) and attempt to put an ERR_PT=
R?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703102918.3723=
667-1-john.g.garry@oracle.com?part=3D3

