Return-Path: <linux-scsi+bounces-24677-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pPmFAQgjKmqijAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24677-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 04:52:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C8766DE43
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 04:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RL6e7rmi;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24677-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24677-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AA7830067BA
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 02:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B526F293;
	Thu, 11 Jun 2026 02:52:51 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A87190473;
	Thu, 11 Jun 2026 02:52:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146371; cv=none; b=a7Xe8mXSzIG5GUChLER7VIE4gNaqFPbZ9FwePfaziUZjescL7RUnoSX7elodC1Wrf/ifgj6azzJxsIyY6Ce3MBZlSNCuxOIdomGR3oo4zheCcclJAO0j7XEfwVTd+bqUQ5exEWAwWhrSFtCXaWEf4zTEfVQjphcQmDUnOjgZmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146371; c=relaxed/simple;
	bh=/bOhZ+e5Q2WoqqzgteCdUd+4m539oypcuLRm+OhHfl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Al35pS7PgN+hVI6ZHvhz5LVmWwGr4OoP3M4SW3xcMZ9mVOS3m/d3spdAv2XY9sN1dgOOZ/wYXnWuFcS62rrY3AUZ4SUxs4at5SMUKD1o9Jge10DSzGgF7E15CCF04j7ieg2a8HOM/Y3odGHQ35vCAxAPj5N175e1guhjp71gOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL6e7rmi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23191F00893;
	Thu, 11 Jun 2026 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781146370;
	bh=9t+JS9WkWIKNurhG2LeEssq5g6+xg+k1pfMAGvKfh74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RL6e7rmip+/xhv10j2/RlkdddiCljkmXRxuEd+YSvVN+vGqRXSaQ22ifSxxzc6ls0
	 r55zRHUUJdLwxILlWvwEv1t5PMkaCkGhTySGA1N+A7eoBH12StvIXzz63OPZYK8YFm
	 IwaWtU88eOVwxwHc0UIv39OTSNIKxMjv77hKQ4yP7pVam7UD6wh04XFCMZL2ynqjR9
	 un/IxlSOtOYrJruLdBtkN74MuwBufrYJTxnTnwpOfM5mssNb4vP0m53kTsLeuAIeN6
	 LZW5F2zFQ6dj8phj2Ksq2cbzR5IDY2NQO3uI05Spnv71mvPsYpnlVS8rtyLL6t1J72
	 2pOUjSoIKmynQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN
 ATAPI device quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260611024356.2769320-7-philpem@philpem.me.uk>
References: <20260611024356.2769320-7-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 02:52:49 +0000
Message-Id: <20260611025249.D23191F00893@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24677-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:philpem@philpem.me.uk,m:cassel@kernel.org,m:dlemoal@kernel.org,m:linux-scsi@vger.kernel.org,m:linux-ide@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0C8766DE43

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Max-length vendor (8 characters) and model (16 characters) static =
quirks are silently ignored due to forced null-termination by `strscpy_pad`.
--

commit 5a65a1f1e5d686dcd28440ac5645f5a5b22ab1ae
Author: Phil Pemberton <philpem@philpem.me.uk>

scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN ATAPI device quirk

The Compaq PD-1 (and equivalent Panasonic LF-1195C) is a combination
PD/CD-ROM drive that exposes two LUNs: LUN 0 is the CD-ROM and LUN 1
is the PD (Phase-change rewritable) drive.

Add a scsi_devinfo entry with BLIST_FORCELUN to enable multi-LUN
scanning, BLIST_SINGLELUN to prevent issuing LUN-aware commands
simultaneously, and BLIST_NO_LUN_1F to suppress spurious "No Device"
entries for unpopulated LUNs (which respond with PQ=3D0/PDT=3D0x1f).

> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
> index 68a992494b121..bfc2cbd438975 100644
> --- a/drivers/scsi/scsi_devinfo.c
> +++ b/drivers/scsi/scsi_devinfo.c
> @@ -150,6 +150,8 @@ static struct {
>  	{"COMPAQ", "MSA1000", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD},
>  	{"COMPAQ", "MSA1000 VOLUME", NULL, BLIST_SPARSELUN | BLIST_NOSTARTONADD=
},
>  	{"COMPAQ", "HSV110", NULL, BLIST_REPORTLUN2 | BLIST_NOSTARTONADD},
> +	{"COMPAQ", "PD-1", NULL, BLIST_FORCELUN | BLIST_SINGLELUN |
> +				 BLIST_NO_LUN_1F},
[Severity: High]
This isn't a bug introduced by this patch, but max-length vendor (8
characters) and model (16 characters) static quirks in this list are
silently ignored due to forced null-termination by strscpy_pad().

While this specific COMPAQ quirk is short enough to avoid the issue, the use
of strscpy_pad() in scsi_strcpy_devinfo() forces a null-terminator for
string lengths exactly equal to the maximum array size:

drivers/scsi/scsi_devinfo.c:scsi_strcpy_devinfo() {
	...
	strscpy_pad(to, from, to_length);
	...
}

If a vendor string is 8 characters long (e.g. MATSHITA, transtec) or a model
is 16 characters long (e.g. ARRAY CONTROLLER, ImageMate CF-SD1),
strscpy_pad() truncates the string to leave room for the null byte.

In scsi_dev_info_list_find(), the matching logic compares the length of the
device's INQUIRY data (vmax) against strnlen(devinfo->vendor, 8):

drivers/scsi/scsi_devinfo.c:scsi_dev_info_list_find() {
	...
	if (vmax !=3D strnlen(devinfo->vendor,
			    sizeof(devinfo->vendor)) ||
	...
}

Since vmax is 8 but strnlen() returns 7 for truncated strings, the length
comparison fails. This silently breaks critical SCSI quirks. Without these
quirks, devices like the Compaq ARRAY CONTROLLER fail to report LUNs
correctly (leading to missing disks or unbootable systems), or devices could
lock up the SCSI bus.

Could the truncation logic be revised to safely handle exact length strings
without null-termination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611024356.2769=
320-1-philpem@philpem.me.uk?part=3D6

