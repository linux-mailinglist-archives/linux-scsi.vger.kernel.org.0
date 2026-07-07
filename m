Return-Path: <linux-scsi+bounces-25862-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ca2TAzcKTWoguAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25862-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:16:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299C71C728
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k2N4TQ+V;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25862-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25862-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4D4D30A9DBA
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7E423798;
	Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE293E1CED;
	Tue,  7 Jul 2026 14:12:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433540; cv=none; b=U8kkv0YiKtkdHAv6Ye9rpZRzEPE2WWy9s34fZ67Q+/VwPlVz93TMeznZr26nAdoUzwiSjH0i+7lRFR7vvCAby+joHiYzBAClPCSM6zNJIR1iQmLoH7ZZ0d++qge96asIQQS677vp4Bke6jgny2QLkoAgs8LgcGMRyYiRI0kYGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433540; c=relaxed/simple;
	bh=p0mQel9DC1hPpIN8aHPoXJhvg1E/GYDsq2Z3kIl22ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBAxYUwunlsymwStYNQsuHdn9PJv1R4uUf9PyNFqNAl42y3aYpqeqfns7t6FtpOX8AX1BboE80ZK8dYc8+CAF7jfxBRNP33FpG2Soae4joSTZg2WB9lFdJdy/BBgeWpmfQsoxThSiB+SYlaU1P79EmNnPHhMjYN8negcQ38gW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2N4TQ+V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9E61F00A3E;
	Tue,  7 Jul 2026 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433535;
	bh=Gt09LEKUndiVYYYMJSzo6DYkKsxFB07zGbnbbg4BCQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2N4TQ+V4vLr6mOUnpMtQHmPAprYeJFQ2iNsLHJYinxKfP5omKlH9iCok7V0cRUPX
	 Q/K5GPxdb6N5GpgE3OBcNriMI9r4ecgpYuupYEhSG6LJU4Q076cEznDHyif7YHa0k6
	 onDBM/OBpWIoDGxWnjcbnkmvWZiVwOEpezhG6mfpnIlF+m+QlUIReg9sP2E+fd+g2J
	 FpEUG/M5LXJoX5jYvvQfRd4kSpZZp8kSoGCacizsg80GZLoD83SRzDXh1DZbt0kyCe
	 pHAA/4MbZ6OxnQ7QF0suYeD4lK2MF9//veQhFQNbXfGNVgYtrzCXEHbyHLKno3ShDV
	 UxjaIKdStOCaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] ipack: tpci200: don't store pci_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, cassel@kernel.org, dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org, dlemoal@kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-3-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-3-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:14 +0000
Message-Id: <20260707141214.CE9E61F00A3E@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-25862-lists,linux-scsi=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-pci@vger.kernel.org,m:cassel@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-ide@vger.kernel.org,m:dlemoal@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,garyguo.net:email,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9299C71C728

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional return of 1 in `ipack_unregister_bus_member` halts b=
us device iteration prematurely, leaving most devices orphaned but still re=
gistered.
--

commit 6023ba18e50f5578e133a944842fdee804f479b0
Author: Gary Guo <gary@garyguo.net>

    ipack: tpci200: don't store pci_device_id
   =20
    pci_device_id is not guaranteed to live longer than probe due to presen=
ce
    of dynamic ID. This stored ID is unused so remove it.

> diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tp=
ci200.c
> index 05dcb6675cd66..1cf51f7632932 100644
> --- a/drivers/ipack/carriers/tpci200.c
> +++ b/drivers/ipack/carriers/tpci200.c
> @@ -562,7 +562,6 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
> =20
>  	/* Save struct pci_dev pointer */
>  	tpci200->info->pdev =3D pdev;
> -	tpci200->info->id_table =3D (struct pci_device_id *)id;
> =20
>  	/* register the device and initialize it */
>  	ret =3D tpci200_install(tpci200);

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free duri=
ng
bus unregistration that I wanted to ask about.

When a carrier driver is unbound and calls ipack_bus_unregister(), it uses
bus_for_each_dev() to iterate and unregister child devices:

drivers/ipack/ipack.c:ipack_bus_unregister() {
    ...
	bus_for_each_dev(&ipack_bus_type, NULL, bus,
		ipack_unregister_bus_member);
	ida_free(&ipack_ida, bus->bus_nr);
	kfree(bus);
    ...
}

However, the callback unconditionally returns 1:

drivers/ipack/ipack.c:ipack_unregister_bus_member() {
    ...
	if (idev->bus =3D=3D bus)
		ipack_device_del(idev);

	return 1;
}

Since bus_for_each_dev() halts iteration on any non-zero return value, does
this stop after evaluating only the first device in the bus list?

If the iteration stops prematurely, the remaining devices would be orphaned=
 but
stay registered. Because ipack_bus_unregister() immediately frees the bus
structure after the iteration, could this result in a use-after-free if an
ipack client driver later binds to one of these orphaned devices or their s=
ysfs
attributes are accessed?

> diff --git a/drivers/ipack/carriers/tpci200.h b/drivers/ipack/carriers/tp=
ci200.h
> index e79ac64abcffa..a2bf3125794b7 100644
> --- a/drivers/ipack/carriers/tpci200.h
> +++ b/drivers/ipack/carriers/tpci200.h
> @@ -145,7 +145,6 @@ struct tpci200_slot {
>   */
>  struct tpci200_infos {
>  	struct pci_dev			*pdev;
> -	struct pci_device_id		*id_table;
>  	struct tpci200_regs __iomem	*interface_regs;
>  	void __iomem			*cfg_regs;
>  	struct ipack_bus_device		*ipack_bus;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D3

