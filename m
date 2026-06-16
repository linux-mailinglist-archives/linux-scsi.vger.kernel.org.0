Return-Path: <linux-scsi+bounces-25031-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BYd3Bg1wMWo/jQUAu9opvQ
	(envelope-from <linux-scsi+bounces-25031-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 17:47:25 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B718369162F
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 17:47:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MuQ7sgrO;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25031-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25031-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93C8330DBA68
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593344CAE0;
	Tue, 16 Jun 2026 15:38:55 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A544CF22;
	Tue, 16 Jun 2026 15:38:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624335; cv=none; b=N2z7KWH3cLwcKF5klZf8md0iY/uPL36hNZklGND33O/j81BgniI36H9EDrgb9Ar9QFWmUihD/0pDomFZHxUNRG+iZ8Q6orRP7Tgkf2wIKKpabR9ARCHRHe0HcTcuqxBnZBfKDF8pVu204T/1KKd8tIOMHtuFjJrvYuxNzZj+4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624335; c=relaxed/simple;
	bh=exK1k8NcnKoIq/DYOEbdI/NGJHT2oZvKc+VN6nlWA2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hHlTBX1f4/AT254iBa9JSaDU7PukBVFAk8YqJ1w4hRYuWWY5GaDwZlQ6SIMpcdu0bmjZ7jNWZIiAnx48psfQdBdtWi47DD88c+08c0/1ZgrAt5m1fQavp9Ytm0Pw2jIrgnzhOfTC9OYPIEXfvitCXwIaWaxeq+LTeVJ0t9bfA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuQ7sgrO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F91F00A3A;
	Tue, 16 Jun 2026 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624334;
	bh=AEV25Es/unYEegHRevp+4yg7tjnp0C8UcNakfNoeZeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MuQ7sgrOuROdDnRgo5ZIWaCLhUbXfL1duv/NBOegzfhKS1Q3mdgQQLr+3CSe0gKbm
	 qA2jgCnw+QpVAJb5kQCopoS2brxPpbMgZDzpmAXZn8+JQZ7HtxuQcDtauUcohMDEOG
	 ZVv6F6xeqwUIVxGWNMwBHvBVdziKNRFJY/lfebfT/lNOyTS8uScfq7HXhDI4o118GR
	 EFTH9cLiqZ3RBrt45Qauu7RuFyfaLWG5EFzdQPe2careGEW72hmxRsmdsmV/nOijSo
	 oSj3881nyBK/gxgwwDKoPKYjbZCCHWePbVNnAUvnIgnkyn1UliowFzrnYyBoi0qTnP
	 8DQubCa6tqZ6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] PCI: Enable async shutdown support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260616152219.6268-5-djeffery@redhat.com>
References: <20260616152219.6268-5-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:38:53 +0000
Message-Id: <20260616153853.EC8F91F00A3A@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25031-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:djeffery@redhat.com,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B718369162F

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double `put_device()` on `bridge->dev` in the `pci_register_ho=
st_bridge()` error path leads to use-after-free.
- [High] Unlocked read-modify-write of C bitfields in `dev_pm_info` via sys=
fs can clobber PM core states like `in_dpm_list`.
--

commit 5968194913e4b5e2b73a45e8bbc2ab20340b2cfe
Author: David Jeffery <djeffery@redhat.com>

PCI: Enable async shutdown support

This commit allows PCI device shutdown to be performed asynchronously.
It introduces calls to dev_set_async_shutdown() during host bridge
registration and device addition to reduce overall shutdown time.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b3cefec25f518..4782b4d5306b6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1046,6 +1046,7 @@ static int pci_register_host_bridge(struct pci_host=
_bridge *bridge)
> =20
>  	bus->bridge =3D get_device(&bridge->dev);
>  	device_enable_async_suspend(bus->bridge);

[Severity: High]
This is a pre-existing issue, but does writing to the power/async sysfs
file trigger an unlocked read-modify-write that can clobber PM core states?

struct dev_pm_info declares adjacent bitfields async_suspend:1 and
in_dpm_list:1 that share a memory word.

device_pm_add() performs a locked read-modify-write under dpm_list_mtx to s=
et
dev->power.in_dpm_list =3D true.

Because dpm_sysfs_add(dev) executes before device_pm_add(dev) during
initialization, userspace can immediately trigger a concurrent lockless
read-modify-write by writing to the power/async sysfs file. This calls
async_store() -> device_enable_async_suspend() and sets
dev->power.async_suspend =3D true without holding any locks.

If this lockless RMW races with device_pm_add(), can it overwrite in_dpm_li=
st
back to false after it was set, breaking PM dependency chains and aborting
device linking?

[Severity: Critical]
This is a pre-existing issue, but does the error path in
pci_register_host_bridge() trigger a double put_device() on bridge->dev?

If device_register(&bus->dev) fails, execution jumps to the unregister label
which explicitly drops the bridge->dev reference:

unregister:
	put_device(&bridge->dev);
	device_del(&bridge->dev);
free:
	...
	if (bus_registered)
		put_device(&bus->dev);

However, the release function for the bus, release_pcibus_dev(), also
unconditionally drops the bridge reference:

static void release_pcibus_dev(struct device *dev)
{
	struct pci_bus *pci_bus =3D to_pci_bus(dev);

	put_device(pci_bus->bridge);
	...
}

When the execution falls through to the free label and calls
put_device(&bus->dev), will release_pcibus_dev() drop the bridge->dev
reference a second time, potentially causing a use-after-free when the call=
er
handles the registration error?

> +	dev_set_async_shutdown(bus->bridge);
>  	pci_set_bus_of_node(bus);
>  	pci_set_bus_msi_domain(bus);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616152219.6268=
-1-djeffery@redhat.com?part=3D4

