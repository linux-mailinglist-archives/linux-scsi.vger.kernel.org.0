Return-Path: <linux-scsi+bounces-25867-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eb2cC20KTWo6uAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25867-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:17:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C8A71C763
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:17:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gBG3ZsPE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25867-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25867-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96C3630BC6F6
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD504279E9;
	Tue,  7 Jul 2026 14:12:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FF3F4123;
	Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433542; cv=none; b=JEm5T2xPIUb1ZN2vzLfx/eetNss2E8Qwpj+gAUywNnhM5tB1jZdScsnQCcdFyNOle2bZKlEgGTS7uxvbouTze1ESH9tPu4THdad+vAXAgaiUC3XICEiohF8eQ9NMIl3/HIjb53o++QkwJebniqnfkwr/ep9NwLC+8PU/XNx69S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433542; c=relaxed/simple;
	bh=UfmXVhSM5Umjns2A9HvBx2SkFQe8VPlW+QWf63BmQAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQ3huJSl4ZJ2LfReX1GSDBMzvKOoi8LS2b4GpC1a5PvJ8i/RpuWaPZ1OLMytrddZOWTB5qrm0nWouyDLU3K4+tHbb9MySi/saYv1gZ5AY8a2OLqSZ35oMIBRvti7ofVsraOdROa/HzwedBwcKdDeh9TO3tgx5VPVeFtkNCsI6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBG3ZsPE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BE61F000E9;
	Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433540;
	bh=UfmXVhSM5Umjns2A9HvBx2SkFQe8VPlW+QWf63BmQAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBG3ZsPEWjvZExJhMn5eRA+6Oj2wVar8453d1Ihc58vUeC6K1REcnEX1b0GRkajrr
	 4pk98SRWjIkzI0Ut7XnTI9Evd+3AshYw7APhC601CmAn7xVDkr0wgmzt7RJwivIVjj
	 x1wSeulDOE3mlrOmJB+LNeD5y4MUxckboK/JsMRmwvSKa3OUVJiPdAF1m95zYelD1B
	 DgpmEaCok3QPESmRKAy8GyuCyV4GzdcxGaRzvWInTCSpEGkFO9iplD3jPb/pdq8h3t
	 yjA+/6+iDQs55osPHVqW6LW8LWn9GhSQw4/3mCAX2SkvImnXnobrTKKYQt27Rv9bm2
	 GImWhNFWg194A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] pci: fix dyn_id add TOCTOU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org, cassel@kernel.org, dlemoal@kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-8-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-8-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:19 +0000
Message-Id: <20260707141220.10BE61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25867-lists,linux-scsi=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-ide@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-scsi@vger.kernel.org,m:linux-pci@vger.kernel.org,m:cassel@kernel.org,m:dlemoal@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06C8A71C763

> Currently there is a TOCTOU issue in new_id_store as the dyn ID insertion
> in pci_add_dynid and the pci_match_device are in separate critical
> sections.
>=20
> Fix this by moving the existing ID check to inside pci_add_dynid and only
> check against the static ID table outside the critical section.
>=20
> Fixes: 3853f9123c18 ("PCI: Avoid duplicate IDs in driver dynamic IDs list=
")
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D8


