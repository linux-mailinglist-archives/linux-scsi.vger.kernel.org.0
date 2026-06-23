Return-Path: <linux-scsi+bounces-25203-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +vFiM216Omqr9wcAu9opvQ
	(envelope-from <linux-scsi+bounces-25203-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 14:22:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA96B7092
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 14:22:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KhFTRDHh;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25203-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25203-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345063041A0F
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A803D45CF;
	Tue, 23 Jun 2026 12:18:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6C3CF962
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 12:18:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217121; cv=none; b=DHGObkPsuk2kaB6lXluMi92UrjsULXHJR6KWR1Osn7jft9quYpohEpyGjmP9ErJZ+3akehqIDmMavOKJtnkzsyt/63j4wMSnQh9mRt7zKsoDgOxk0BUao70ek6kjPVBXdxWdnvCQiMfUM8Hxw1OmJJ2yO1O4n9eh0itZngHVgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217121; c=relaxed/simple;
	bh=mImXQ1+6+lsVgc/M++SPUP4s6R7iuhG3GaN+BgJF4pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKRrcuwsiE0QzVuJvSM4Y+Brdy+KHF20l45HP5RrMWjpkRzl+gQCP1A2bTdZihDArPAyrbX//TLq1fwsi4G4DMa86CRTqatytT18qjdPhZn1y4ZMW6Dji7n7KKxmG6bagXSxthmEk6KaR6k76WdbPNKXHNldFscI548nlB78vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhFTRDHh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300121F000E9;
	Tue, 23 Jun 2026 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217120;
	bh=cX+H8RQowmdU6XU1xJKeZPLxeb49tCJu0cH5KvOEm/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KhFTRDHhKC4U3D56xIFf31eib3jEQDUAuzqCIaq62ooJRFi9BatohmCxTtmmXw58R
	 1V7EfTJJ3VIL7UjqZwf6+CE8RZlBGblFQwcGDireWMIbrNfFIYUzdoj8OwQ9TCqnPv
	 OxNKXkydkQ8wq++nbTR7XfeQxuCte8u//xlL4c9AxVI0/vuWDEG6RR7BvAUfF+l1bV
	 LB/PqC6xYr9v4S1QqBWwV5FhxLs7K5xiB/k93U48t/+Q9g/1YxRow0M8nOxka80MHw
	 kESGrmKHFFadf6MgTbE54e69cpalLDWlBW2LzZkgOTyhDwyK8VpyC+j8JXt8sIok2F
	 9nvEGmlguA5Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Fix UFS RPMB device teardown order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ao Sun" <ao.sun@transsion.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623120440.13883-1-ao.sun@transsion.com>
References: <20260623120440.13883-1-ao.sun@transsion.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 12:18:39 +0000
Message-Id: <20260623121840.300121F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25203-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ao.sun@transsion.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,transsion.com:email,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AEA96B7092

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Allocating a structure embedding a `struct device` via `devm_kzall=
oc()` creates a fundamental lifetime mismatch. The patch exacerbates this b=
y adding `devm_kfree()` to the `release` callback, triggering a fatal Use-A=
fter-Free if the device release is delayed.
- [High] If `ufs_rpmb_probe()` exits early, `hba->rpmbs` is never initializ=
ed, leading to a guaranteed NULL-pointer dereference in `ufs_rpmb_remove()`=
 during driver teardown.
--

commit 79815281175f9750b2f8b1eccd86223bc783c72a
Author: Ao Sun <ao.sun@transsion.com>

scsi: ufs: core: Fix UFS RPMB device teardown order

This commit modifies the teardown order of the UFS RPMB device by
unregistering the child RPMB device ahead of the parent device in the
remove path. It also moves the memory deallocation for the ufs_rpmb
structure to the parent release callback.

Link: https://lore.kernel.org/all/20260618064142.8C30E1F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
> index ffad049872b9a..dcb7e521284f1 100644
> --- a/drivers/ufs/core/ufs-rpmb.c
> +++ b/drivers/ufs/core/ufs-rpmb.c
> @@ -128,7 +128,7 @@ static void ufs_rpmb_device_release(struct device *de=
v)
>  {
>  	struct ufs_rpmb_dev *ufs_rpmb =3D dev_get_drvdata(dev);
> =20
> -	rpmb_dev_unregister(ufs_rpmb->rdev);
> +	devm_kfree(ufs_rpmb->hba->dev, ufs_rpmb);

[Severity: High]
This is a pre-existing issue, but does allocating a structure embedding a
struct device via devm_kzalloc() create a lifetime mismatch?

This patch exacerbates the issue by adding devm_kfree() to the release
callback. If a user holds a sysfs attribute open during driver unbind,
devres will automatically free ufs_rpmb. Later, when the sysfs file is
closed and the final kobject reference is dropped, ufs_rpmb_device_release()
executes and dereferences the already-freed ufs_rpmb pointer to read
ufs_rpmb->hba->dev, leading to a use-after-free.

>  }

[ ... ]

> @@ -244,6 +245,7 @@ void ufs_rpmb_remove(struct ufs_hba *hba)
>  		/* Remove from list first */
>  		list_del(&ufs_rpmb->node);
>  		/* Unregister device */
> +		rpmb_dev_unregister(ufs_rpmb->rdev);
>  		device_unregister(&ufs_rpmb->dev);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but if ufs_rpmb_probe() exits
early before calling INIT_LIST_HEAD(&hba->rpmbs), won't hba->rpmbs remain
zero-initialized?

If the driver is unbound later, ufs_rpmb_remove() is called on that
zero-initialized list:

drivers/ufs/core/ufs-rpmb.c:ufs_rpmb_remove() {
        if (list_empty(&hba->rpmbs))
                return;

        list_for_each_entry_safe(ufs_rpmb, tmp, &hba->rpmbs, node) {
...

Since head->next is NULL on a zero-initialized list, list_empty()
evaluates to false. This means list_for_each_entry_safe() will dereference
NULL->next during initialization, causing an immediate kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623120440.1388=
3-1-ao.sun@transsion.com?part=3D1

