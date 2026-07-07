Return-Path: <linux-scsi+bounces-25860-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o/ygOCMKTWobuAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25860-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:16:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E3D71C716
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:16:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=je+MHiFg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25860-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25860-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5989309F8BA
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9794229D9;
	Tue,  7 Jul 2026 14:12:18 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C9346AED;
	Tue,  7 Jul 2026 14:12:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433537; cv=none; b=kI2k2skEDefDUhV5O+o/uj16SM08jQl4MzF4F0QXHZg/1xf5lS3NiiXxTbgIvBVtVe7p/r0uX13G8Z3IfNjs3TEb6RSjbWfzdd+aqqoFm9WX4rcfjUKLDxOkuQHzxTRO8bpUE7PyATbdSBImwT0EnHh9GBvVJWJVrSG97nWca08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433537; c=relaxed/simple;
	bh=IUpvRC9wcs1dCUCuTPSKS6N90kwfuNsOcY+hxN9a/+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NzdRsXDqxo1eYVso1JQVLWawvMOWNuaAyUkIvBY5n7ErIIqEgQ44nKiSAoo60UBgu60Qeq0+CakfAiXSEk7nKm70vZjTsoR9l2tYAMF88RiwSX4gojsOJgrbu+r3OAhUpD9eCPw6McTCz79hatN9t+2bCU1QXeHncRkzZKuqR4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je+MHiFg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F51F00A3A;
	Tue,  7 Jul 2026 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433532;
	bh=IUpvRC9wcs1dCUCuTPSKS6N90kwfuNsOcY+hxN9a/+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=je+MHiFgYHsOBg91S1REa9sghrqxq1jVQGvqjbExLoTLl/mz0zk5uF1L1HbzkKC50
	 MbTSCczlK1IuCadfNh6jcvgBORPY+pSQfvZ2pqnCd/CvEvC6OXwJmyVt1MmcXAouvR
	 KxNAfqbzmav/tZI/FHOJOBhoq5uZZdJQueOv74fjpmjloEJ7bYh+vUkoBVqrPfIDYM
	 8glIVgKG6SoB0SKOtcQXeJ0ps+aLB1SZ8BNDuCSY2iLaHhckKMrhgWAyTVr3cUX3RY
	 G1EFE/0nBfX+hDxReXUfs6YEjF52Ov6MlMOr6UwfCKEiCsCi3F534QGsShMsp9QOgk
	 CXTbF4i3rivNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] ata: don't store pci_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: cassel@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-1-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-1-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:12 +0000
Message-Id: <20260707141212.856F51F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25860-lists,linux-scsi=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:cassel@kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48E3D71C716

> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from pci_dev, so just store driver_data.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D1


