Return-Path: <linux-scsi+bounces-24930-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4k/gI7vELGrPWAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24930-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2026 04:47:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDB667D8F3
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2026 04:47:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H519EBxR;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24930-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24930-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55FF43013267
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2026 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5CF33D4F8;
	Sat, 13 Jun 2026 02:47:19 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A47217659;
	Sat, 13 Jun 2026 02:47:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781318839; cv=none; b=cf1LN40AaXfx/yXWhKsQ8x8BmAPwEYJRjzsayGMoTwo5C+M7C0ifA1BcQqYaUTTRGG+TVO8+Dez/XyeOphpo1tha5gGVoVTfnjSBGC+0A64GkaY9xbzdFZE3hGs/V/ITqbpH5UZrM444zvyYCfQNe8KGRu5eqsd1NQyDBG7w8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781318839; c=relaxed/simple;
	bh=RR7GD+hB0AWx9umbn5Anr7yrtN2sWyT7AY9zCJTNEvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9rTYstsYM+XVYNC/2Us1s98cQ7jNTrW/AfMU0YCVh2/zMgsXI/D0RqwpP4UdxOoGgOKoElBY2bkgp3Tkd3U3Ll6kujtY6Dzc5Tfz8jcFy21SPXPQN9UNlSxGSKq2UV2r48/tAXROsWgpD5D0TVtIxvA+4/ctfZEOLO83+hKe+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H519EBxR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969C81F000E9;
	Sat, 13 Jun 2026 02:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781318837;
	bh=neFDneYLdD/pM5i5Y2ON67GLePjC2eyg5XpQQyaScD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H519EBxR53Fig/IQRh/lQLYih36KDND0/nJOiO3RRjVoMejSYShSpx2/Px5mY3uRQ
	 6Br7VlS4/H6ToYujBGzLZLoUgDo87AI/34Y427Fs+IJ4zGhbJZHG94YwKRvmT9U/L1
	 UKjk0Ovrcb5SOBgRLy/7+c/wyyrUGiYgsIlg8r3ibGySWaad6fEuzlVgKfqEnVYSXE
	 MEruJ2hvXfYkMcdaUwaOCmTufQZTnUnNSsZTO62eNtFpsqLK45Io/1/8D953YzgZSJ
	 VlqJP6DRHeAFFwgN/V/qc4+Q+jDuUJ2MEq9/UT9D/67W1iPv6aohkUdYWeVnnlKtEx
	 n4l91jcUrv14g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] scsi: mpt3sas: add hwmon support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis Sautier" <sautier.louis@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260613023833.3163507-3-sautier.louis@gmail.com>
References: <20260613023833.3163507-3-sautier.louis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 02:47:17 +0000
Message-Id: <20260613024717.969C81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24930-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sautier.louis@gmail.com,m:linux-hwmon@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:sautierlouis@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFDB667D8F3

> Expose the IOC and board temperature sensors of LSI / Broadcom SAS
> HBAs through hwmon. Readings come from MPI IO Unit Page 7 via the
> accessor added in the preceding patch.
>=20
> The same fields are exposed by Broadcom's userspace tooling
> through the /dev/mpt[23]ctl ioctl path (typically root-only):
> IOCTemperature and BoardTemperature in lsiutil; ROC and Controller
> in storcli. With this driver, sensors(1) shows them unprivileged:
>=20
>   $ sensors mpt3sas-pci-0200
>   mpt3sas-pci-0200
>   Adapter: PCI adapter
>   IOC:          +42.0=C2=B0C
>=20
> Each channel is gated independently by its *TemperatureUnits field
> through is_visible(); cards that populate only one sensor expose
> only one input file, and cards that populate neither do not register
> an hwmon device.
>=20
> The hwmon code is gated directly on CONFIG_HWMON. IS_REACHABLE() is
> used rather than IS_ENABLED() so that SCSI_MPT3SAS=3Dy with HWMON=3Dm
> still builds; in that configuration, the sensors are not exposed
> (same pattern as i915 and xe).
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Louis Sautier <sautier.louis@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613023833.3163=
507-1-sautier.louis@gmail.com?part=3D2


