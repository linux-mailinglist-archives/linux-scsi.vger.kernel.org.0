Return-Path: <linux-scsi+bounces-24929-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gbVbCD3ELGrBWAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24929-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2026 04:45:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1FA67D8E4
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2026 04:45:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z3k18OAN;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24929-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24929-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DE83311172F
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2026 02:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43843783AE;
	Sat, 13 Jun 2026 02:45:12 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A7CA52;
	Sat, 13 Jun 2026 02:45:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781318712; cv=none; b=H8oCdmX0GsmSc20YzrwlO8u1ILO+reOEiC6hMy4qPq6O/zZa8J+5BbrVd/UkVdfo/wAhrci5tHCLWnC2bBxFw9vW2Rb4gzOGetvwSsjaBQgjq+Vze4PoXqq0ZuP5zbMecjdev3FzSkt3mftDg+d0U+3JF3STr6X/8Fw+xC8EJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781318712; c=relaxed/simple;
	bh=vL7+6ZbG1u7MCa9GJSLl+EhznIBkZ1ggrTbJIK1pfFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dlGOnCKKBqJQ5CDGJYTSg82Rem6WxKODl/kMo/pW/RwFk8w0t5UIBDsE+f4Wukzs7v028NKTJCvxAEAx7RcJnJkxmWvhf2LBb0Cxa33qLlOpUHqPOxrP+En01O3T4JGu/L3LsAScivnc5E+ipnKzXJUi250s0rjK9FyJ/yh8gIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3k18OAN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFE51F000E9;
	Sat, 13 Jun 2026 02:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781318710;
	bh=vL7+6ZbG1u7MCa9GJSLl+EhznIBkZ1ggrTbJIK1pfFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z3k18OAN8+83cP016JSXhoU1Pe7pdodtfcfw/j/de8ktjm2+YMwXImGKpU1hhPEka
	 zF1T48UgqP2kshy+9dp4+p6Zujv2xzt+5E6cgMop+QpIswVDadTYVR+S3TLD9LyHTA
	 bXMkVraFHke/08sJN89BgU1BDPmOaAfbWlMMCt6DWfsf36c25N2JB15fOWS1ZfvPxi
	 BBrLFZWvOs2pPLsFi36QmVdJNHYCM18aEi1n7DgUx2+KuTWzDl6GayeErQ0YIpdl3L
	 1ioOxQstDYtVnpDacNX8BrjRBRuuSvhn05Z6bich/Uugusdy6DrQNVImEWMJwDWpSU
	 kGobUcetcgv1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] scsi: mpt3sas: add IO Unit Page 7 config
 accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis Sautier" <sautier.louis@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260613023833.3163507-2-sautier.louis@gmail.com>
References: <20260613023833.3163507-2-sautier.louis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 02:45:10 +0000
Message-Id: <20260613024510.ACFE51F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24929-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sautier.louis@gmail.com,m:linux-scsi@vger.kernel.org,m:linux-hwmon@vger.kernel.org,m:sautierlouis@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B1FA67D8E4

> Add mpt3sas_config_get_iounit_pg7(), mirroring the existing iounit
> page accessors. Used by the hwmon driver added in the following patch
> to read the IOC and board temperatures.
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Louis Sautier <sautier.louis@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613023833.3163=
507-1-sautier.louis@gmail.com?part=3D1


