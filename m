Return-Path: <linux-scsi+bounces-25412-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id drx9ALT3RGrf4AoAu9opvQ
	(envelope-from <linux-scsi+bounces-25412-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:19:16 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290B6ECB46
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:19:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cU5umbXT;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25412-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25412-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC0FD30E5E73
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402A42EEB7;
	Wed,  1 Jul 2026 11:10:49 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2843E9C3;
	Wed,  1 Jul 2026 11:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904249; cv=none; b=X8MycqMsusfR1Y8a9Ics9K5eNGPvaRG/JrFzLUUGCb1k6ERrpK3D0WIUeFr/SE4dEDGsdYFYsfnrMGEzYkid7faoX/rg45JZYoB80DIRarFo99kdr8M4MZeSmZVdZ2ZkG3Wa201c1Fq83ehj68uFzv6nfWm3I2uvCGO98RRj2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904249; c=relaxed/simple;
	bh=A02OTwuJcFy6IZ6SvzDEM5JmH78Et4AQimvBgHEuDwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rhsySt3ui+MjchZiBGKb3MNVE7czn71xNdyvN2GZrRJYKyptPpJJlkVeIr78fDefdE6BamCUa/W5UzNcU49aEh/B5IoNjVA/YaATmQNO3cBgR9AQKaeAx8aPoMATPDcUpK2raRWN2p+BvAuIVO7FO2J4kWy4GW+EuxboAs1B3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU5umbXT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74681F00A3D;
	Wed,  1 Jul 2026 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904248;
	bh=A02OTwuJcFy6IZ6SvzDEM5JmH78Et4AQimvBgHEuDwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cU5umbXTS2x34USIfXbfxqKudUuSe5Qs9oivgA8zXPFcfnTgHNRZ//RG00r2ql6rS
	 5KzHXklbr0YaFi1qQMT8IpN2GggWafR5meqfalFtJlf/vvQ/4F2dkYafTy+LmvOtby
	 vhm2gRo+dJYpzWP5iIHYj/v2O83/FMtr7jULY/KTeyayei8wcjrlY0+9Uyn1A+CT9y
	 ajpbBTLN0DagAD3l9rGw7s7GNFXh/BNfwD/8pcJ+5nK0coKxSalExUQKqCi02hd63x
	 uhsblcqSmSSG4h1kGAsZ4VWRTxILgQHzvLRT5zT+5WHqsVZv2kUfLQr8FF7ClnBW80
	 WhIAVfGuCoLcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] pci: make pci_match_one_device match on ID
 instead of device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, dlemoal@kernel.org, linux-pci@vger.kernel.org, cassel@kernel.org
In-Reply-To: <20260630-pci_id_fix-v2-5-b834a98c0af2@garyguo.net>
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-5-b834a98c0af2@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:10:47 +0000
Message-Id: <20260701111047.C74681F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25412-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,garyguo.net:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:dlemoal@kernel.org,m:linux-pci@vger.kernel.org,m:cassel@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9290B6ECB46

> There is a need to match just IDs instead of against devices. Thus rename
> this function to pci_match_one_id, and add a pci_id_from_device helper to
> make it easy to convert users.
>=20
> Similar convert pci_match_id to do_pci_match_id, however the existing API
> is kept due to quite a few users.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-pci_id_fix=
-v2-0-b834a98c0af2@garyguo.net?part=3D5


