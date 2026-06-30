Return-Path: <linux-scsi+bounces-25387-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1+P4FhBLRGqVsAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25387-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 01:02:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7F6E88FC
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Jul 2026 01:02:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=djl45S7D;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25387-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25387-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009E73079A01
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74533374F;
	Tue, 30 Jun 2026 22:56:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591433D6DD;
	Tue, 30 Jun 2026 22:56:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860210; cv=none; b=uW1J9IKZQVNH/XDTqO9S9D1emHbHyoc1qNvsgxHnKQkyNpEbONSc7g5k/uYiuaBhe12mAIsmBVq22zMbrvpkyi2Y9/GZPXr3NU4ZVVJxpRdgfPh1mzAqH5mn/ujyFP/8kCZTgEg1gDiKaCHmxsGomYhNHyvA1OMZumrSIunU1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860210; c=relaxed/simple;
	bh=zvqcF5f1eGfn1w41feSdZPPmP/1sfTctKQJg9SN7/EA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B9UPLA8b4/bienoPG1UXClnrEq7YG2C0Po3C1E31s2lLcSkK030PRg6YZ0Y5/Af5LNkxXe8P8DkL4mPrQN/JYN4Tpvk2NTMVhP3GU3eRQ09n9xL3VOsRpRQtrsQdLePmLxge0wSulV9hfMaJfXDlzMiFpHqWgOlsfwaWvPS2YOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djl45S7D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEC51F000E9;
	Tue, 30 Jun 2026 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860209;
	bh=zvqcF5f1eGfn1w41feSdZPPmP/1sfTctKQJg9SN7/EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djl45S7DzjjR5q20+a3zvTS8GRExdAGTJ9jQ2mi9hHgahK8cgBGPBIJ5bOVEUhTMK
	 h4M4jga/ZhCKUkVWsDQ7ELwAMzeE1JH4/pEcTid9OZbRzm/hSDOSBFxDD1kUpwb0P8
	 kfwLrknmL2SUsy/UA2oqZmVIC7ilv1GsI8xdUhRDfkZZl+PZiFQgKshYG8YkQ2Reiy
	 UjVYlGSgQXDS1aXwdD7bZG9pKPi6tdwbmQAwpYIiL2AvFqHhCSoX/K/TUC4mXGnIri
	 5qrjtaqTvUN945jpd+R+AXn5a5WozbZTSdlt0Ytu+tftTUpLTsik0LGBiH4lI807XY
	 9wIxa+CwaasVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] scsi: mpt3sas: add IO Unit Page 7 config
 accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Louis Sautier" <sautier.louis@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260630224922.2543096-2-sautier.louis@gmail.com>
References: <20260630224922.2543096-1-sautier.louis@gmail.com>
 <20260630224922.2543096-2-sautier.louis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 22:56:48 +0000
Message-Id: <20260630225648.CAEC51F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25387-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCE7F6E88FC

> Add mpt3sas_config_get_iounit_pg7(), mirroring the existing iounit
> page accessors. Used by the hwmon driver added in the following patch
> to read the IOC and board temperatures.
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Louis Sautier <sautier.louis@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224922.2543=
096-1-sautier.louis@gmail.com?part=3D1


