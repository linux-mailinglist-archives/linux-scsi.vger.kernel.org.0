Return-Path: <linux-scsi+bounces-25274-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1GG1IbU5PWr6zQgAu9opvQ
	(envelope-from <linux-scsi+bounces-25274-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 16:22:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C356C694B
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 16:22:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=llNiAWw2;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25274-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25274-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730523054F7A
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7634A796;
	Thu, 25 Jun 2026 14:15:13 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92161332EC1
	for <linux-scsi@vger.kernel.org>; Thu, 25 Jun 2026 14:15:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396913; cv=none; b=nM/OreThtKNSbN+vjSn6eRYdEtO+BkgZ8fgSI2nDtZYbY+QLiijovJZwwPAu0XokmG9k7+XxlS6VyJ1puefD9yFqrQcxTWqbA+lFbggIreQ7Z4A3nwWoNDdZYIqahocImpSlFYDwGqRhtkPiWDRAsWic9k+IxderuscDFHKyNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396913; c=relaxed/simple;
	bh=Hgwi6XWYq2ea0alQiEk/9kukVPYKrv0jUeE96jTyCac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ftBeKhCEsSgtj1x2ENPTNjncrzCsIU9195486t4BC/6LJIL5VaNQ368FU/4/5QeaySByz/p9RYY57O8/oFgvdRXbcN+ion2wIKh7ZSwjmlI2fo+w5a3jn6Ws6tsBEcxYBFZTQhBHKlvV+wwonQZX8mOTAUc/mJalW88ld0tLlqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llNiAWw2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948671F000E9;
	Thu, 25 Jun 2026 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396911;
	bh=NZokH0hDwyNp51zm7pGiQGKZN7NwDgPkGS1rITbWyfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llNiAWw2GIH4W4QhKgbrPJnaWZKTI3aLTRd9+4RNQUgSNR9ARGP7jArwJ6ER0wiHR
	 rz1aUnCMXWtKYGTGSy0ECjQAMR+G2M53Vd21at5+ktSO/ieDCggemozfX/oiY95cXO
	 YpIhBYVZPkCX8UqGO8svPrkujETwkQxDnhDsE0W0zfFBCcB6mxvcaj+R5gLU32FezL
	 04A7xi6l9M7VT7xsrQMPJwBGIdA2P0el8xuCvKw510dePOc0youADAbV+Zgprn5EJb
	 4jUF91DdT1WZs7vXnMnMX8BA1Y9sQZJavtD5Xx36MA/oPZFPTDbUC6o26z/oaCUs0w
	 zp99irf3sha+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] scsi: 3w-9xxx: sanitize passthrough SGLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260625135746.1639-1-alhouseenyousef@gmail.com>
References: <20260625085842.4522-1-alhouseenyousef@gmail.com>
 <20260625135746.1639-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 14:15:10 +0000
Message-Id: <20260625141511.948671F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25274-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8C356C694B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of `driver_command.buffer_length` allows out-of=
-bounds writes on the DMA-allocated bounce buffer during various ioctls.
--

commit 13bf465bbd4ac1f90fcf8616ebc1740e8a86ac93
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

scsi: 3w-9xxx: sanitize passthrough SGLs

TW_IOCTL_FIRMWARE_PASS_THROUGH copies a full command packet from userspace
and then overwrites the first SGL entry. The SGL location and command
size remain user-controlled for legacy commands.

> diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
> index 9b93a2440af8f..c27c7b632ec6a 100644
> --- a/drivers/scsi/3w-9xxx.c
> +++ b/drivers/scsi/3w-9xxx.c
> @@ -686,6 +688,8 @@ static long twa_chrdev_ioctl(struct file *file, unsig=
ned int cmd, unsigned long
>  	}
> =20
>  	tw_ioctl =3D (TW_Ioctl_Buf_Apache *)cpu_addr;
> +	memset(tw_ioctl, 0, sizeof(TW_Ioctl_Buf_Apache) +
> +	       data_buffer_length_adjusted);

[Severity: High]
This is a pre-existing issue, but does twa_chrdev_ioctl() missing a minimum
size check for driver_command.buffer_length allow out-of-bounds writes?

If a user supplies a buffer_length of 0, data_buffer_length_adjusted
evaluates to 0, which allocates no extra space for the flexible array member
data_buffer.

However, several ioctls blindly write fixed-size structures into this buffe=
r.
For example, TW_IOCTL_GET_COMPATIBILITY_INFO:

	case TW_IOCTL_GET_COMPATIBILITY_INFO:
		tw_ioctl->driver_command.status =3D 0;
		/* Copy compatibility struct into ioctl data buffer */
		tw_compat_info =3D (TW_Compatibility_Info *)tw_ioctl->data_buffer;
		memcpy(tw_compat_info, &tw_dev->tw_compat_info, sizeof(TW_Compatibility_I=
nfo));
		break;

Does this result in out-of-bounds writes that corrupt neighboring memory on
the DMA heap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625085842.4522=
-1-alhouseenyousef@gmail.com?part=3D1

