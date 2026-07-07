Return-Path: <linux-scsi+bounces-25868-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3mnNK5wKTWpPuAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25868-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:18:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E471C7BA
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 16:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PEozfLmb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25868-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25868-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAF9630CBBDF
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41A13DD875;
	Tue,  7 Jul 2026 14:12:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B642640E;
	Tue,  7 Jul 2026 14:12:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433543; cv=none; b=kNLjV10Aw5O4L2Fxa1YXH3fHbrxQPCpLlWZScKpx8XNTyPTA4mTNywVBHvnB2DKapm4IvR8gXsfjpudXZ6v/bdhmE2/97LGuaVUDTVknI346h6SmkXUjiWGeASozsOwqbW7hsOfvI4PY8lV8Ac8WJC8WOm/4CJOwrWeS9RNODYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433543; c=relaxed/simple;
	bh=jA9Ju4PIhu1ffgguky4STt6TzXMN7ues9/+gqUty3/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PpudfKdDs85AQRWmS3sv/E2kkAtDGL8HdkXgW1b8TQqqHQJgE0pxc5NFhZWv3EWKgMMOF1XXqZLn1BKC0vkgftZJHZCPeKP7xymenEmRifKN6D5KXR8gnI2sfLvrW3GMvAjJsDvIdU3hyhiGzSq/chO2OiZ4UL1b8xRiD+om160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEozfLmb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024481F00A3D;
	Tue,  7 Jul 2026 14:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433541;
	bh=jA9Ju4PIhu1ffgguky4STt6TzXMN7ues9/+gqUty3/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PEozfLmbcNcu9IQcd+7U97REqOs0CUoZKiHeyGMuYGdHwII8G7PriyYvg0bD5wZ1d
	 a4zWQJw5K8fx+cMWk+zfoxjtE6dfa4Xeny0vRi5DOotxtsTd16zFJ2H7YLpwQpDST7
	 8vDAPtwDm7H5Ed0TrssWGZf5PCgpHlkCbVqKIRh+U6Z5sTvRupupvh8IWcf7T4+/80
	 2smlsH/8woTT/s1dcNe4R+3quoqmOU66NN+ufgVUCz489buY6QqtLzK4Mo0MnDwcKv
	 YpsNP6yjEhxsBG+aB4a099ybTyqnr9UBhlPfQj6rXboHmd4H1Hpj53SNG9on9d/5jE
	 1TRnVU6RTjygQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] pci: fix UAF when probe runs concurrent to dyn
 ID removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-scsi@vger.kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org, dlemoal@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-pci_id_fix-v3-9-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-9-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:20 +0000
Message-Id: <20260707141221.024481F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25868-lists,linux-scsi=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:linux-scsi@vger.kernel.org,m:cassel@kernel.org,m:linux-ide@vger.kernel.org,m:dlemoal@kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 128E471C7BA

> Dynamic IDs are only guaranteed to be valid when dynids.lock is held,
> as remove_id_store can free the node. Thus, make a copy in
> pci_match_device. Also, clarify that the id parameter is only valid during
> probe.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel=
.org/
> Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D9


