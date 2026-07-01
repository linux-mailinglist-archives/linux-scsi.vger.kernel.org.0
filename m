Return-Path: <linux-scsi+bounces-25409-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uKOYInT3RGrL4AoAu9opvQ
	(envelope-from <linux-scsi+bounces-25409-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:18:12 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 621476ECB03
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yg75O4Cl;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25409-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25409-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B45733047AB2
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62232470E;
	Wed,  1 Jul 2026 11:10:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B042E013;
	Wed,  1 Jul 2026 11:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904245; cv=none; b=Yk8DRWplhv1BDgKU4vRT7vz4YJrtOeGSCyGHE/nL9SMTiH1iZTsjNd5Te9BYHNfGUKtY+q6+fE3Bj7JQhrLi4nEqvQllyD6oYd1r5ZUDtPdzNVgYlEV2mBn9GXyOS0iQz21C0mV3bT3rHGoHeZAs88CpUJIJL0bfoHlIyafGQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904245; c=relaxed/simple;
	bh=+u23qtiZt76rD7qndJUltV2kmHMy7lEDI9QQIr3yqbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f8DFbIY+Sx6tD3lR4X6vVz6LCtskyXVQa/4kKgOkk2ZSBRHXeqDj26H29A5iNVECpHdn/I2y4TzeF38RpK5z5sgvKUa/vziBvQaUSlZSjBaewYYu2jOWj/G3G2gw2dwHwUsgNliHAIzFmslItjz5lz9gy2ZNcDycXmRd/UwDrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg75O4Cl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5531F00A3D;
	Wed,  1 Jul 2026 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904243;
	bh=Ruizv5TGUcD2EmKkjBTlXrQBcF9RrjMUFNa7drTCWEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yg75O4ClPAX/gq/LeNhn19TpMcozkYPSck05sVJmz7gBgXHd9CLDTo4mo+JGNCEEq
	 bA/T5idf3tH8S6rZ7eXZlyyqZRTwyd8azcpu6KBBirXPMSzv0C9GwIDFBIC9ZJdEBa
	 iX1+qxinlJJtu0nVG3xGMpd9V9sKA7ZYieaJYQ48h1cVO6gZPRylaILTjCFnMnf+Y8
	 f2U/fC2pGMXsDlNhmaUlgyxuf86QlQZycX0dyEYP+rb5zFZC8TwOmASCRhZsJ4qJJz
	 nAl2gJ2cXgF7pyjEDHQIdrivmg0prXdD84fZsZWOwB9e3TXoZnww1qGxcjfscSb1IE
	 LH5mq4qKkEeXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] nsp32: don't keep pci_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20260630-pci_id_fix-v2-2-b834a98c0af2@garyguo.net>
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-2-b834a98c0af2@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:10:42 +0000
Message-Id: <20260701111043.5E5531F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25409-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,garyguo.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:cassel@kernel.org,m:linux-ide@vger.kernel.org,m:dlemoal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 621476ECB03

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Probe failure incorrectly treated as success leading to NULL p=
ointer dereferences.
- [High] Unvalidated `driver_data` from dynamic PCI IDs causes out-of-bound=
s reads on the `nsp32_model` array.
- [High] Race condition in `nsp32_probe` due to use of a shared global vari=
able for instance data.
- [High] Double endianness swap in MMIO read/write functions.
--

commit 68e40f6c7308e7ebef3fc97b6095ad0f3e42988d
Author: Gary Guo <gary@garyguo.net>

nsp32: don't keep pci_device_id

pci_device_id is not guaranteed to live longer than probe due to presence
of dynamic ID. All information apart from driver_data can be easily
retrieved from pci_dev, so just store driver_data.

> diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
> index e893d56772417..9c9281222a0ac 100644
> --- a/drivers/scsi/nsp32.c
> +++ b/drivers/scsi/nsp32.c

[ ... ]

> @@ -3340,7 +3340,7 @@ static int nsp32_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
>  	}
> =20
>  	data->Pci	  =3D pdev;
> -	data->pci_devid   =3D id;
> +	data->model       =3D id->driver_data;

[Severity: High]
This is a pre-existing issue, but I have a question about how driver_data
is used.

If a user with root privileges writes a dynamic PCI ID to
/sys/bus/pci/drivers/nsp32/new_id with an arbitrary, large driver_data
value, the driver unconditionally uses this value as an index into the
7-element nsp32_model string array here in nsp32_probe() via
id->driver_data, and later in nsp32_show_info().

Could this unvalidated driver_data from dynamic PCI IDs cause an
out-of-bounds read?


[Severity: High]
This isn't a bug introduced by this patch, but I have a concern about
the global nsp32_data_base variable.

If two nsp32 PCI devices are probed concurrently, for example via concurrent
sysfs bind operations, both threads will concurrently modify the single
global static variable nsp32_data_base at the start of nsp32_probe() before
it is copied into the per-device host structure in nsp32_detect().

Does using this shared global variable for instance data create a race
condition in nsp32_probe()?


[Severity: Critical]
This is a pre-existing issue, but there might be an issue with the error
handling path.

If nsp32_detect() fails, it returns 1, and nsp32_probe() blindly propagates
this positive value to the PCI core. The PCI core treats positive return
values from probe() as a success, meaning the device successfully binds to
the driver even though initialization completely failed.

Because pci_set_drvdata() is not called on the error path, subsequent driver
callbacks like nsp32_remove() will receive a NULL pointer from
pci_get_drvdata(), causing a NULL pointer dereference.

Does nsp32_probe() incorrectly treat probe failures as success?

>  	data->IrqNumber   =3D pdev->irq;
>  	data->BaseAddress =3D pci_resource_start(pdev, 0);
>  	data->NumAddress  =3D pci_resource_len  (pdev, 0);

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed something in the
MMIO accessors.

In drivers/scsi/nsp32_io.h, nsp32_mmio_write4() explicitly uses cpu_to_le32=
()
in combination with writel(), and nsp32_mmio_read4() uses le32_to_cpu() with
readl(). Because writel() and readl() intrinsically perform the correct
host-to-PCI byte swapping, manually adding the byte-swap macros results in a
double byte-swap.

Do the MMIO read and write functions perform a double endianness swap on
big-endian architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-pci_id_fix=
-v2-0-b834a98c0af2@garyguo.net?part=3D2

