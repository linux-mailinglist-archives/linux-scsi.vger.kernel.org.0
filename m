Return-Path: <linux-scsi+bounces-24411-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pI1bM3QbIGr5vwAAu9opvQ
	(envelope-from <linux-scsi+bounces-24411-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 14:17:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED916376C2
	for <lists+linux-scsi@lfdr.de>; Wed, 03 Jun 2026 14:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24411-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24411-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 945FD311907D
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jun 2026 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2E477985;
	Wed,  3 Jun 2026 12:06:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FF46AF2D
	for <linux-scsi@vger.kernel.org>; Wed,  3 Jun 2026 12:06:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488370; cv=none; b=eBeqMJW9mCa6ycxKWjx5/25Il6m6Mq5lhAv4FR4bPw5xK+NAMzm5l0hWUGcx0O1oMlHDKQpAlIByRQuIFF2huu4jC2ges8aamX4C7F42INmvceWkO01b03bJBBqa5/Vky7H9hzskW4BJgRvCpazh4bv0/Z6ea8Xv0EW13LIFdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488370; c=relaxed/simple;
	bh=9q183NFC9fS2JbtBL36Ugl1YrAbf8Ci2YCyn/eMtdUU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=OyDglrBkAz5DsQJuYkj4bgXQ01kzCF8elfDOQ4aJ0+P3R6BziPI8uL9QuFoTumOIHVx5ctwsrKfVFWFKtRGDNxV37v08LPP0+rQG9R05Taa+oQEbsz4LI2ImEeRvE49++dv3B3hZseAuU9ab49F5dn2BtQAVqomhysdAS9T8Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com; spf=pass smtp.mailfrom=ciaorelated.com; arc=none smtp.client-ip=81.19.149.127
Received: from 89-26-47-193.stat.cablelink.at ([89.26.47.193] helo=[127.0.0.1])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <info@ciaorelated.com>)
	id 1wUkGX-000000006Zi-2rFm
	for linux-scsi@vger.kernel.org;
	Wed, 03 Jun 2026 14:00:09 +0200
From: Dogan Karaarslan <info@ciaorelated.com>
To: linux-scsi@vger.kernel.org
Subject: Open source social media project from Salzburg
Message-ID: <b0ef6779-73f8-87e3-ddbf-016bc0646d60@ciaorelated.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 12:00:08 +0000
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-AV-Do-Run: Yes
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24411-lists,linux-scsi=lfdr.de];
	DMARC_NA(0.00)[ciaorelated.com];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[info@ciaorelated.com,linux-scsi@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@ciaorelated.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ciaorelated.com:from_mime,ciaorelated.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ED916376C2

Hello,

I found your contact through GitHub.

I=E2=80=99m a developer based=
 in Salzburg, and I=E2=80=99ve created an open source social media project =
focused on communities and meaningful connections.

I=E2=80=99d love to share it with you. If you like the idea of an open =
source social media project, I would really appreciate it if you could take=
 a look and maybe star the repository.

I=E2=80=99ve put a lot of heart =
into this project, so any kind of support, feedback, contribution, or =
simply sharing it would mean a lot to me.

Here is the project:
https://github.com/dogankaraarslan1/ciaorelated

Thank you for your time.

Best regards,
Dogan Karaarslan

