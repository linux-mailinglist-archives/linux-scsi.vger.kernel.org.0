Return-Path: <linux-scsi+bounces-25429-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CqJ2CocdRWr+7AoAu9opvQ
	(envelope-from <linux-scsi+bounces-25429-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 16:00:39 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70926EE757
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 16:00:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cEBX8Nmm;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25429-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25429-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3F27300F5CB
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2026 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24A29DB6E;
	Wed,  1 Jul 2026 13:58:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98B27B353;
	Wed,  1 Jul 2026 13:58:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914334; cv=none; b=pp+f5k4lNWt0yxIkC6w2c3HF0vpNHNzLRncB3PocbqVA6IXuLGERT2pgYy4PzSbAD4UzAZ8yO1h5rm2RdapUCQMfCMGt9ahOaODquFx2iaEt2beUFCGBt8lfpFtb58IWrZWoo615ke3sVy0eS/VxnQ8e5OAf9wAjZdRHu6SpS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914334; c=relaxed/simple;
	bh=RjZ/ZIZ+K+wowVDaDuR8b9Ow9kYVVHeMdBCpq21cESI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qv1hBf8Ne0AMW3WoI4zkBjkNpLZo/BIiZlCp4sxYs3ux/uO3A1nXeBqdjtNn91YBzxXCBp9Oo4LLlj0hE0DESt4UiG1kQdRjYdHwuc9BeQUBvAhy7CQVPc88gP7zKMJg/w4EclqHxMRc7vasCamCrcO/Ic7yB1rl5SQdtJR+pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEBX8Nmm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145FC1F00A3A;
	Wed,  1 Jul 2026 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914333;
	bh=M3VWoTmM8jK72GbVHspsaZufdJJVK1r2KEIFBDu4FLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEBX8NmmoZzbQj9qx5kdB4hf6FozrEwXQbN6H0WqBZ+uPmgolertSmviK5x8hVBUQ
	 6Aqw5GA+/iiDzra1U42t7ufhgMJJ0G7PRvo56Eb05NFMK4rWT2vJJjxtGTP0lucREM
	 7l4XxkhyERwsaH/s/nTdpN+grhhNSiwtRe8n5BnjcUv7kqyt4/x30UHEheG/e6AK/X
	 XwwL3Te2kUy5x2oomlFeix7IzwP7u/6m0g10OX4ElWEYfgzpDOZLRMhYm6FEqx8EaW
	 i63i9jtuy012Zsv2XmTB4eFVeOSeFFLdnk5f2VRGvy9owF8j5ySrZhE+VOc2rm0pzo
	 j1WZ3lhUFtLaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] driver core: separate function to shutdown one
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260701135015.81937-2-djeffery@redhat.com>
References: <20260701135015.81937-1-djeffery@redhat.com>
 <20260701135015.81937-2-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:58:52 +0000
Message-Id: <20260701135853.145FC1F00A3A@smtp.kernel.org>
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
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25429-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:djeffery@redhat.com,m:linux-scsi@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B70926EE757

> Make a separate function for the part of device_shutdown() that does the
> shutown for a single device.  This is in preparation for making device
> shutdown asynchronous.
>=20
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701135015.8193=
7-1-djeffery@redhat.com?part=3D1


