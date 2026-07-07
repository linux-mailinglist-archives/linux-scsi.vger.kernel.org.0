Return-Path: <linux-scsi+bounces-25865-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UdtFKbILTWqQuAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25865-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:22:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331871C897
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:22:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ig139JRf;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25865-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25865-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B526D30C0692
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D759542641A;
	Tue,  7 Jul 2026 14:12:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54342315B;
	Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433542; cv=none; b=UmejuSZGIWMjR5vEOgUiXda1ChfMeeGlpYW+EcNI4A0IO3PMNXg2oJXb0k8OQfy7M65E5m0RDPfmeJHb9zuOtlXy3VbrNH92kdU6m/nT6sLag5jnWRNDyg/QKoqKi4J3pWFa4GiuZMBlM8FBHEgDF2SFNBJhotWgI4vrQ81K7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433542; c=relaxed/simple;
	bh=+Q8bsBDe/NPd3jPzAf281UsX9sWgZa/fkzVNcKGpaGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hIZ2IxuQ3pB/39iwYtxfzDxps+wf3nMizIFp5GjaycqxDQ9atPvfxk1lcgPubURkrEVWufy+O7+bGa4VbLcml6Bc8NRFFB8xSIH57zLr4qs+h2oC+ls8HzfzOoMz+EnL34yGSsjdp73vp7bl3jMy7wYkU0D39a43jUybpGzR2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig139JRf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929C91F00ACA;
	Tue,  7 Jul 2026 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433538;
	bh=+Q8bsBDe/NPd3jPzAf281UsX9sWgZa/fkzVNcKGpaGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ig139JRfu1SsHtLD/2CqUoX+sR1iL+JWLycuQ54NG3jIc6EfG/OLqzcUJ90VDAsDv
	 N7QhOF7tkFzEN8yVg2vzpzHYvmKwydMnu64BXpUxTTMhZTaIM/TcvISYuzZfvE0FxC
	 kdc1R8QtMsy/hGvikB47Phpvlke1bSJe3a27PnGGJgWRzhqlGZRAqRjQrNj0UJ7iXE
	 yNPQ3zup4TXVy0L7NMwYSwVsF9RBkGhxrW31zvhz1Gnz/fvU+sxVN1X10W0rVKtZpx
	 49hPNYUbOkkhGgjTNPtvbcFI8Hh6yqpgL5S/9rstz9UyR5QBOGFWXieBe2Hofd0cDW
	 zqv6yK6NFfCFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] agp/amd-k7: don't rely on address of
 pci_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-6-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-6-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:17 +0000
Message-Id: <20260707141217.929C91F00ACA@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-25865-lists,linux-scsi=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:cassel@kernel.org,m:dlemoal@kernel.org,m:linux-pci@vger.kernel.org,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6331871C897

> Address of pci_device_id cannot be relied on due to presence of dynamic ID
> and driver_override. Use driver_data instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D6


