Return-Path: <linux-scsi+bounces-25565-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aLAdDx2dR2okcQAAu9opvQ
	(envelope-from <linux-scsi+bounces-25565-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:29:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79012701D8F
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RYYo2Lc5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25565-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25565-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519003038BB8
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85563C4171;
	Fri,  3 Jul 2026 11:24:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A534252C
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 11:24:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077867; cv=none; b=uchD4fsjwFC78PZZvaNCCW5wY1a+fUzScp/f0H1rV5Jvi9B8yD9er9rWNNoPrs2vyDU+uHi3isFWPFw9pBjXE1POFiQXKyBKZdSII/dzC2KjlYXOzw2twX9VdOsuHicQmdo1c2Zr7wQKY1MYxXPBBbZHqXQRj7R35DgiJCddjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077867; c=relaxed/simple;
	bh=imwS4tVzJdpkAVeb3y0exh0k5Dssw8K+NmxKXmjgSKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FmaBIWf4bVoqwCw4NaMREmfvTkpY9Mt3xqbpLNo7KgwUIMz27WwnXtMhwFr+D62F+djgqJUTnzR3btcBMXLaitDZgeQAOgSSfw0b9g0lB7UxcmUT3dxipdaQ1BFHmKvTLWmADtPbZr0wlBOGo3krIWEhpAswBPG23MWJdOeqjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYYo2Lc5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E51F000E9;
	Fri,  3 Jul 2026 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783077853;
	bh=EITj1JjU8QbxlSPX3feSsP1M0YwFygBT+oUhzD9B0xI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYYo2Lc5N3XdCdQr9brDZSfDES6DQsT/awhjZrdUWTqytwATPEyLAjd4q97/z40AV
	 5TT5KZZNFdzgczzv9cg5UEIwHFo+VjDZ2TaWB5ZLlASlsUDwQILGaEI8hPXR9btfkp
	 E3tr6TZt7fQv1e1dFr+OrPhyyXzMrc03gOK+JNl12JKDH7XqiIw0RuHvPECbAQpp1I
	 arCIv0KwQo5NESUeaQ9nByFrzsPUb1hpezR+jThdG6DqDBjQVvZ9mwuvYpt2xBgbX3
	 pVs8paYKKYdo7L5Tbkb8rqv6wkSKq8XBrAnDw4W/1MnSX5tVEnn9gkbI40lok5u4vp
	 EYUSSjz+wzA9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/10] nvme-multipath: add nvme_mpath_synchronize()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703103204.3724406-8-john.g.garry@oracle.com>
References: <20260703103204.3724406-1-john.g.garry@oracle.com>
 <20260703103204.3724406-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:24:12 +0000
Message-Id: <20260703112413.083E51F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25565-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,oracle.com:email,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79012701D8F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a wrapper `nvme_mpath_synchronize()` that call=
s an undefined function `mpath_synchronize()`, relying on a missing depende=
ncy (`libmultipath`), which leads to a build failure.
--

commit f655883eea782b4086749f2985502e444177db21
Author: John Garry <john.g.garry@oracle.com>

nvme-multipath: add nvme_mpath_synchronize()

This commit adds a wrapper function which calls into mpath_synchronize
for the NVME multipath subsystem.

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 35618285caf89..292526c9dda29 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1078,6 +1078,11 @@ void nvme_mpath_ioctl_begin(struct mpath_device *m=
path_device,
>  			unsigned int cmd, void **opaque);
>  void nvme_mpath_ioctl_finish(void *opaque);
> =20
> +static inline void nvme_mpath_synchronize(struct nvme_ns_head *head)
> +{
> +	mpath_synchronize(&head->mpath_head);

[Severity: Low]
Does this code build cleanly? It appears that mpath_synchronize() is not=20
declared or defined in the current tree. This seems like it would cause=20
a compiler error due to an implicit function declaration when building=20
with NVME multipath enabled.=20

Is this patch relying on a missing dependency or missing header inclusion?

> +}
> +
>  static inline void nvme_trace_bio_complete(struct request *req)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703103204.3724=
406-1-john.g.garry@oracle.com?part=3D7

