Return-Path: <linux-scsi+bounces-25413-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5I8qFoL3RGrS4AoAu9opvQ
	(envelope-from <linux-scsi+bounces-25413-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:18:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B51626ECB19
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 13:18:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Iu77rfBj;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25413-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25413-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CED331B6650
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A037436341;
	Wed,  1 Jul 2026 11:10:53 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176F43D4ED;
	Wed,  1 Jul 2026 11:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904253; cv=none; b=OwgkeAEyRYugBbQvbpiNzbTTkDa7smvAtomDYrDg0BUEtIGFBdzk7wtTiDXc6GUsVeMyQgGzYAwR7qX2hf0vMYfXfsqCHwNmLt/7o3vJFjkSarzcJ2ikWUdRel/xMUclqX7Tpb/0pZGyc7TsifuYT30FqLCrJTd2VqJKEaXF5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904253; c=relaxed/simple;
	bh=8j58NSzaBdVS/3GdPoxNe4wUY1K6p+50Vq4owgC13TY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g3YabqpTlPRH7eFZxOzSYG4W54wANN+NWYymq0OvyDMEqhe0hExiZjKCqwcVHjt/VMWFKIZAQD82q7khw7kbkFaG+1zMnwnTeC69lh0ZzZRvKNqZ/QnksskaJT467mCY0ePJJXeoHlK2ckeBs53JWoI+Hw8BwjV4efApNsNBhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu77rfBj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA441F000E9;
	Wed,  1 Jul 2026 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904251;
	bh=8j58NSzaBdVS/3GdPoxNe4wUY1K6p+50Vq4owgC13TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iu77rfBjq4rPzztRCSKNk/mdmuDDyMmbFPUdxigLLGbvPmjMpyCP5dMzzuvCr6IT1
	 sQPc4+HCmtUh9BWBeiG+0xFEp+MAnCDLSBPf7qG7gZB/m5PQWeyEsycdJ6rLEh/XO+
	 97um4RjhmgiFCLR/VWllo7iFv5Dw3Bia3n8rQqvLKPO5vlu26y/Mezr27Dy/lHCD+Y
	 ETA5QpJkln/2ODRmbWGq9BhdrR0ehV8+/mZk0c1CHLKmS4BtmuJA17OuGwhrxLGWbm
	 VaV+Jg8FCqkdR2YZsdSW6N2MHxhYraSwvyN8cNBNd3aKO2ytBZd18AP4ejt6VV5iCo
	 5eOZGYSMJgqog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] pci: fix dyn_id add TOCTOU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20260630-pci_id_fix-v2-6-b834a98c0af2@garyguo.net>
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-6-b834a98c0af2@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:10:49 +0000
Message-Id: <20260701111050.2DA441F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25413-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:email,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B51626ECB19

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-pci_id_fix=
-v2-0-b834a98c0af2@garyguo.net?part=3D6


