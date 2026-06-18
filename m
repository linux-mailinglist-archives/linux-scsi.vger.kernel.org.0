Return-Path: <linux-scsi+bounces-25072-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZhyhNRfxM2ryJQYAu9opvQ
	(envelope-from <linux-scsi+bounces-25072-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 15:22:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD946A0724
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 15:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hGMWibO/";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25072-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25072-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7A00301426D
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC25B2BDC28;
	Thu, 18 Jun 2026 13:22:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966BA280A56
	for <linux-scsi@vger.kernel.org>; Thu, 18 Jun 2026 13:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788942; cv=none; b=lRtMAqumPAFXKWwpbmGZcsId2ie+8Ub9GmScYx/XXfMgqgB9Bzbo1Solj35kHResqkBOsZb+eUa5U0jjXeKL5MIkrxoEb8gBD1+U/JMhTI5khhUMA1m0J4fISyn3Ysp7z1ZgZiqlRQxptlA0VqNqN0mCtlJaZqYEm5yVh7IteGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788942; c=relaxed/simple;
	bh=BXR+B0SvxcgDPXvP2gM0Ba0NVZrxbaXZEgFLFsvoyC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHu4xlJVVhJtn2azGISuCUsPzrTcDtk9s9gtdG8m6daEeZuQJU/F/p0xbUKkOTPzXfD71OdMtQbg/fLOJrCU+/uSh/5HJCtdrizG1Xkci/7kI82X8V0hEwJSnPRadeHwOkwiLPmr+vxnsRRqby2az/EU6O5Q1U3vSvqQVEwdkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGMWibO/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150FA1F000E9;
	Thu, 18 Jun 2026 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781788941;
	bh=BXR+B0SvxcgDPXvP2gM0Ba0NVZrxbaXZEgFLFsvoyC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGMWibO/x2QwqrH+9Gihpx5UEAlJgpb0VbhU6B4etg+yk41ZQL2uhYpZXzBGyBxsN
	 rlALj/cBaAa6/n1mXSoLpwCsqM6/9XHa4obfB28Oko7B/YtaCj7gJT9Y6AG4duN/SW
	 3GTZyvMDKWkH9Gmrdlsfp8yagZpy1/wKrIRk7Qr5SmuDSDGZuIitaOYfSGtjENtkCr
	 3+aVQMKhij/QZDnGk7EMFYqIxdkHANg2fttW6E0XKiChkGr0rhxC5inCSYeLcyi0bF
	 HFK/eJwNez2Vi8XzAX2SNdF+DQqbylFCl/v2QfOixiQ3M7fKet9kK7RHmRlqVTy8CP
	 n5QaEs1nypC0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] scsi: leapraid: Add driver documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongdong Hao" <doubled@leap-io-kernel.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <bab9637bf1646c6d0c5d82c22328f120e02cc4c6.1781767278.git.doubled@leap-io-kernel.com>
References: <cover.1781767278.git.doubled@leap-io-kernel.com>
 <bab9637bf1646c6d0c5d82c22328f120e02cc4c6.1781767278.git.doubled@leap-io-kernel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 13:22:20 +0000
Message-Id: <20260618132221.150FA1F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25072-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doubled@leap-io-kernel.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,leap-io-kernel.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BD946A0724

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The documentation incorrectly names the module parameter for mul=
tipath support as `enable_mpio` instead of `enable_mp`.
--

commit 958c37a9e9c4054d4110e1b080f8c3be25877cb6
Author: Dongdong Hao <doubled@leap-io-kernel.com>

scsi: leapraid: Add driver documentation

This patch adds the necessary documentation for the LeapRAID SCSI driver
to the kernel's documentation tree.

> diff --git a/Documentation/scsi/leapraid.rst b/Documentation/scsi/leaprai=
d.rst
> new file mode 100644
> index 0000000000000..e4a6a61c13f8e
> --- /dev/null
> +++ b/Documentation/scsi/leapraid.rst
[ ... ]
> +2. enable_mpio
> +--------------
> +
> +This parameter enables or disables multipath support for target devices.

[Severity: Medium]
Should this module parameter be documented as enable_mp instead of
enable_mpio?

If users attempt to configure multipath support using enable_mpio via the
kernel command line or modprobe config, they will encounter unknown
parameter errors.

> +When set to 1, multipath functionality is enabled (default), allowing
> +multiple paths to be established. Setting it to 0 disables multipath
> +handling.
> +
> +3. msix_disable

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781767278.gi=
t.doubled@leap-io-kernel.com?part=3D2

