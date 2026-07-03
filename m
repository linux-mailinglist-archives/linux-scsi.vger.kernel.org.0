Return-Path: <linux-scsi+bounces-25548-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBwKE6OZR2rCbwAAu9opvQ
	(envelope-from <linux-scsi+bounces-25548-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:14:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFD701B33
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NL3ipNzh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25548-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25548-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B87A0307ADF3
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9683DA5A3;
	Fri,  3 Jul 2026 10:44:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB13BB10C
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 10:44:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075486; cv=none; b=IsOh++1VFJc+7s9XkG16VzQGzaydRQ9B4YXW9wXWXWKBrVuqkV1lg4JmN2zGVnBAKbLbIjtGNKq/kz4hLlNoJoWZfWtPjHTLf1JRQJ5Y7kNlCq5k87GsUCVtVeba29RQWRlBqs7PNmcRNtiW7dUVv3eUnFHq/EWyF+CS1Ss4p/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075486; c=relaxed/simple;
	bh=HEopqKzMioiIPS0t9+HQn4UQrbmGkJKHoUJfKWZ8pE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kz6A01/afu0GR1RiDQQnV9SYwJczKPA5H6yZHUxcYyuQ/8K+LsQ0voboqBnRJ5UXvycQe9aKfgXv9QP3GCVY8wnDvGOcm41t/Ou/qpOSujbFmLvj3hb0/IYw50+JlNLwiWTqOI02UbrekhsdxYSSlwDTWoZak+Lw9IrYKNqc6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL3ipNzh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AA41F000E9;
	Fri,  3 Jul 2026 10:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783075485;
	bh=J2q7mKwrewPFravz8xLdVGeSwb3VSdh2kYA0uG9F8no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NL3ipNzh15S+iQfWZ4sRr9Jzm9YRc04ZwRtlOZv24c8OTlkgeQlD0vV2x0o8a9xC9
	 3N6zflyKmCh1tNceUnlMbN7mA6N5fj+M/g6l/9vpHk0tRIU0TwLSFL7AENolv/H4/Z
	 L2ysSYN2e6adg9EREpE+PL7ax63GyvZscK9Zj4GWjQqvv3+qMiWNN6cCPJhB88Kg9+
	 QZBOXiptwDjggladG1Xa25G2dfc7WCGOswuHE6UX4WX/z23jy+8MizwlGB98IEKsHT
	 w7mg8axsn/w5Sogb/yjzTdT6TVYRmeopENWyW67+/oZUe3V5nJ3LrwXJ4+UjDMpAp1
	 rwcGD3PcqRvzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] nvme-multipath: add initial support for using
 libmultipath
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703103204.3724406-2-john.g.garry@oracle.com>
References: <20260703103204.3724406-1-john.g.garry@oracle.com>
 <20260703103204.3724406-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 10:44:44 +0000
Message-Id: <20260703104444.F0AA41F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25548-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,oracle.com:email,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CCFD701B33

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The commit message claims to add an `mpath_disk` pointer to the =
head structure, but it is entirely missing from the implementation.
- [Low] The patch selects a non-existent Kconfig symbol `LIBMULTIPATH`.
- [Low] The patch references a non-existent header file `<linux/multipath.h=
>` and instantiates undefined, incomplete structure types.
--

commit 733f55d7e9c3919c9123eedece5d53fa4f13cc46
Author: John Garry <john.g.garry@oracle.com>

nvme-multipath: add initial support for using libmultipath

This patch introduces initial structural changes to support libmultipath in
the nvme subsystem. It modifies nvme Kconfig, nvme_ns, and nvme_ns_head
structures to include multipath components.

> Add initial support, as follows:
> - Add mpath_head_template
> - Add mpath_device in nvme_ns
> - Add mpath_disk pointer to head structure

[Severity: Medium]
The commit message states that an mpath_disk pointer is being added to the
head structure, but the actual implementation below adds a struct mpath_head
by value instead. Is the commit message stale, or was this pointer omitted
by mistake?

> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 31974c7dd20c9..1b3f76e781bad 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config NVME_CORE
>  	tristate
> +	select LIBMULTIPATH

[Severity: Low]
Does the LIBMULTIPATH Kconfig symbol exist in the tree? Selecting a
non-existent symbol here will result in Kconfig unmet dependency warnings.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330f..14947736744a5 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c

[ ... ]

> @@ -1496,3 +1496,7 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  	ctrl->ana_log_buf =3D NULL;
>  	ctrl->ana_log_size =3D 0;
>  }
> +
> +__maybe_unused
> +static const struct mpath_head_template mpdt =3D {
> +};

[Severity: Low]
Does this compile? The struct mpath_head_template type does not appear to be
defined anywhere.

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 824651cc898db..3e023948015ac 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -13,6 +13,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/sed-opal.h>
>  #include <linux/fault-inject.h>
> +#include <linux/multipath.h>

[Severity: Low]
Is linux/multipath.h present in the tree? Including a missing header will
cause build failures.

[ ... ]

> @@ -560,6 +561,8 @@ struct nvme_ns_head {
> =20
>  	u16			nr_plids;
>  	u16			*plids;
> +
> +	struct mpath_head	mpath_head;
>  #ifdef CONFIG_NVME_MULTIPATH
>  	struct bio_list		requeue_list;
>  	spinlock_t		requeue_lock;
> @@ -590,6 +593,7 @@ enum nvme_ns_features {
>  };
> =20
>  struct nvme_ns {
> +	struct mpath_device mpath_device;
>  	struct list_head list;

[Severity: Low]
Since linux/multipath.h does not seem to exist, these embed undefined
structures (struct mpath_head and struct mpath_device) directly by value,
which will result in incomplete type errors during compilation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703103204.3724=
406-1-john.g.garry@oracle.com?part=3D1

