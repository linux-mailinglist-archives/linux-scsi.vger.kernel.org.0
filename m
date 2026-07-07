Return-Path: <linux-scsi+bounces-25864-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bocTHlwKTWoquAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25864-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:17:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DB71C73F
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:17:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=erjAGEwi;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25864-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25864-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A140830B73B9
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DE426410;
	Tue,  7 Jul 2026 14:12:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE699383310;
	Tue,  7 Jul 2026 14:12:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433542; cv=none; b=BYyFxqGzZMRE2ZB6JUO/AqgQGU+siovPIPeNjn0h2qGZdsd7Y7Brx02Wgvz4Rx7WOYfl9tD906qem6oMZRNW06M0VqssVPBGivwRz4GQg+rISX8Vw1SJ3TXbNC5dVV9uTqF8DcqJTKDMXJ0JlfoKTJdpV99OdwwdPNxenvekTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433542; c=relaxed/simple;
	bh=eyDgeJF51paQKpDoILd8CGhbNI4Uaxh0TsSiULTfk8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shtq3Tfc8KdjuUwfOxe/DX8s+3x55itlexs2rNTlZzWRb/PrcVmZkCsFbx631RkrlMuPXNDRFctQO9UWOD2I2v/g6rYLCCun2KZeMteW47JQMEFVTRrzHYMiV7/iHbrSnLkEPCWb9DsM6xx2nGJSKEqjmUSx5YkOqYilToqUicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erjAGEwi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3991F00AC4;
	Tue,  7 Jul 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433536;
	bh=eyDgeJF51paQKpDoILd8CGhbNI4Uaxh0TsSiULTfk8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erjAGEwiejadxQ7ohbGW/96YMylj6W/A2WCbZ6MXSH9f836pRgXyv3aymOsKTfVsi
	 KeaMvO3G+cIQpu0lwfPvatqtzVIqqfurk7wHMs5kYOavLU7lv1SJ54GaDmYI+oirq+
	 NQVIjHhMKr6iH4jN3wvMepxe2dDIhkRhkmLBbBhlvXy1QsRNd26XEKTXTkKCFwXN6N
	 piL4fZ4ebmJGA4DqmXwn48Bcvl6Rsu8FZ1gyKXpJlRRMSGJfDY1Z7mZdY++EWx/hZg
	 Sn+uHMjtbDbK1ZypURU5O1K8CSaDK577IZbETbvzd2D38+CaA+8Eb/Qd9rF9QS3pvs
	 KvdZsSes8qs5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] mlxsw: don't store pci_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-4-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-4-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:15 +0000
Message-Id: <20260707141215.BA3991F00AC4@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25864-lists,linux-scsi=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:dri-devel@lists.freedesktop.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:linux-ide@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 258DB71C73F

> pci_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. This stored ID is unused so remove it.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D4


