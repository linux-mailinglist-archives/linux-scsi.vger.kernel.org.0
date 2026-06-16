Return-Path: <linux-scsi+bounces-25032-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qhc1CgBwMWo3jQUAu9opvQ
	(envelope-from <linux-scsi+bounces-25032-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 17:47:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C3691617
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 17:47:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G+CSdhVJ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25032-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25032-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB36B30552C3
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C64657FB;
	Tue, 16 Jun 2026 15:39:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD544D011;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624394; cv=none; b=DSWkxwnT5WaexEEWRM4/QAGqPcxashm2FbujVJZzOqCIjxD8SsHycQ1t6p1Vx74A6ZacVXGbX02Z6aPiHNKeqqYOrwE1qEzXaAp5TUxbq9TQ1qrLRCvlyqVCGBWkzxNRvVd7Y1TWsPQiYvRlp1d+MLgzkBd0RPADGx+T3uZ2tc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624394; c=relaxed/simple;
	bh=kf83s73kJhs0IiYSpbbmeW7Hass3DPlD3w44hALcDZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fWBiY4STHz1brH7RQI/rVrTZ5NhKOSli1EwzQsl3bFw9RxAheKx4Mwtoh3TrruJ3p8G/BpM/fCMBqs83SdQD0X5Tmt5BAOOxXTLDqfxiqHZJqZLSZ6OG/148vfQKqn84667IzHN8ybVKg8S8VbdGtrAtP9YieGGtVDygJaIimuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+CSdhVJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CE21F000E9;
	Tue, 16 Jun 2026 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624393;
	bh=Lg27Ytq/9pq/bcgT1G658vUC5fkAyKnQPI+cA3+0ISE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+CSdhVJ15vOA2Cvp2emu04EYcmIVdBdcWaA/7AnlRZnAL1I3FScD4ZKgG6vh+Yh9
	 Zph8TdCAmEPcu/nY8LqeK81/8TVLyM4lLU2ugXQOtadhJ1uWIye3VeN+Q1WZYQU9KY
	 A3R57jEDA4er5Gbv+pmSJ4dPCgcnO4Pqo/p+u5WbzefQ93EglRpDku8ogce3MGjEcd
	 rsFC7KtSYqTUtDZ06t0IOTRZqSFYkJTog8mMZMF7ShGS8ULi4lz+ADGXrVjM4ZYToG
	 iAdUTKf3VGWq6JLyaD4mMQjXITol7rkXyzveLPqh2yQcPmeiXSWS/1B6dHlJ+8/yT6
	 2kyMHgDXJ5mKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] driver core: async device shutdown infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616152219.6268-4-djeffery@redhat.com>
References: <20260616152219.6268-4-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:39:52 +0000
Message-Id: <20260616153952.D2CE21F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25032-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C33C3691617

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unprotected lockless modification of `devices_kset->list` leading =
to list corruption.
--

commit 3c22e8d639c6f39d1755272000b5af82fc85ebc8
Author: David Jeffery <djeffery@redhat.com>

driver core: async device shutdown infrastructure

This commit introduces an asynchronous device shutdown infrastructure. Devi=
ces
marked for async shutdown can be processed in parallel, waiting only for
their dependencies. This helps minimize false dependencies on unrelated
synchronous devices.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3b3d983b17470..751fe2e13b3aa 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c

[ ... ]

> +static void start_async_shutdown_devices(void)
> +{
> +	struct device *dev, *next, *ndev, *needs_put =3D NULL;
> +	bool clear_async =3D false;
> +
> +	if (!async_shutdown)
> +		return;
> +
> +	spin_lock(&devices_kset->list_lock);
> +restart:
> +	list_for_each_entry_safe_reverse(dev, next, &devices_kset->list,
> +					 kobj.entry) {
> +		if (wants_async_shutdown(dev)) {
> +			if (clear_async) {
> +				dev_clear_async_shutdown(dev);
> +				continue;
> +			}
> +			get_device(dev);
> +
> +			if (!list_entry_is_head(next, &devices_kset->list,
> +						kobj.entry))
> +				ndev =3D get_device(next);
> +			else
> +				ndev =3D NULL;
> +			spin_unlock(&devices_kset->list_lock);
> +
> +			if (shutdown_device_async(dev)) {
> +				list_del_init(&dev->kobj.entry);

[Severity: High]
Could this lead to list corruption?

In start_async_shutdown_devices(), the devices_kset->list_lock is released
before calling shutdown_device_async(). If the async schedule succeeds,
list_del_init() is called to remove the device from devices_kset->list
without reacquiring the lock.

Since this is a global doubly-linked list and concurrent device hotplug or
unplug events can still occur during system shutdown, doesn't modifying
this list without the lock risk corrupting the list pointers and causing
memory corruption or a panic?

> +			} else {
> +				/*
> +				 * async failed, clean up extra reference
> +				 * and run shutdown from the sync shutdown loop
> +				 */
> +				clear_async =3D true;
> +				put_device(dev);
> +			}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616152219.6268=
-1-djeffery@redhat.com?part=3D3

