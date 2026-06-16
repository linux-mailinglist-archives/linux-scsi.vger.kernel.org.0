Return-Path: <linux-scsi+bounces-25033-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6lMDHE10MWr4jgUAu9opvQ
	(envelope-from <linux-scsi+bounces-25033-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 18:05:33 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F2691ADC
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 18:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UDAr7ML6;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25033-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25033-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AAE33042F3D
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86894657F1;
	Tue, 16 Jun 2026 15:44:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6424657DA;
	Tue, 16 Jun 2026 15:44:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624686; cv=none; b=M62IJoAU1tQzDZOUrrm/IOoYk1chPCYTu7HCFnzjrLb0lqJUfiYIHHyk01VdW2ztcrzbbijJ0Ye+6FDj+BaFZiMQaqhxby1rFTo3M8k73GtRjDabHF1DEoUJUx79zr2PBZFQmBPsoekRXnZX1Sd+MfuBmaTqYJfhstjfVbfS2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624686; c=relaxed/simple;
	bh=J+qJJA7KpvJIR0RESySPYWW5wX4Z+35apqrixSESdbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NssjcgGDfmiEv/tr2HaQncQC8pBUchi/wMcUGFPs1sp1BEEPbeSKvQXqy7ZYflwiW/ZvRrw18+PyYJz861uoIVUX6Wv4Y/AR7vVompwytAy5EF+vRaCUDgSP3UdLnCei+PSJF8sycJvjbSPNB1F92sj4Khc5R32khre3HCH9ob0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDAr7ML6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0272C1F000E9;
	Tue, 16 Jun 2026 15:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624681;
	bh=J+qJJA7KpvJIR0RESySPYWW5wX4Z+35apqrixSESdbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDAr7ML6Jl2mTDVvMUJFQRZeF1J4sLtn7AD+NG3sP/qTUxDLOZHgE9gnrvNOC7jzm
	 WzapBZPcaos4GboyB8NqrhcPyzuhSdKeQkhRN11qdSCIWIMTxlbhtd7aHNzGTUN4H+
	 QBedkcwD2S+iSF3NF9cV9Uaa+vfmuu7qkdYVFWmdqLwf+WZNN8stD8ZNE7FyrKs4El
	 3lpZEHsace+qFqjgFpLLfAJg2lg0j8WprZ2Tpm2EPqwMe/LR8Xhvhi64Z3VjqT+1oM
	 7vlhQ+iwJ39WyOKMUE9KtACUF42D+Wd89pImUe0mouVJ13mjpDiNk5N17kIpv1M3yb
	 CxERw+ueOBLOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] scsi: Enable async shutdown support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260616152219.6268-6-djeffery@redhat.com>
References: <20260616152219.6268-6-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:44:40 +0000
Message-Id: <20260616154441.0272C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25033-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C11F2691ADC

> Like scsi's async suspend support, allow scsi devices to be shut down
> asynchronously to reduce system shutdown time.
>=20
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616152219.6268=
-1-djeffery@redhat.com?part=3D5


