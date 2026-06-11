Return-Path: <linux-scsi+bounces-24679-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95d6K6wkKmrwjAMAu9opvQ
	(envelope-from <linux-scsi+bounces-24679-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 04:59:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635866DE93
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 04:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ukf0KgD7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24679-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24679-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2735B30CF24F
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 02:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01630FC12;
	Thu, 11 Jun 2026 02:59:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3A8307AF0;
	Thu, 11 Jun 2026 02:59:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146765; cv=none; b=BYr+DknAPbXwVmspQ4uPen8jvIjNAZnvWDGg6DhTLjUJutvQDz9CM76f4k2qMbREeuonErlDBspnih2O8Xi+y+U9h8G24Hd5j2in+6+qcCE5av2kLAWGnbucA6BQPmoETZkqSkwvIarudEpqi7g+IJcU8NX9M7QPtnJvKKzFdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146765; c=relaxed/simple;
	bh=D/b5P9Hii0XQwfE+2nQNgfw5JRABfD7HQz4tPY/oajU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9G1+XYC+SxzdBIW1MiFzmm/frKcUu31QE70i0h2OCn6ZqbQrLrji4xQIjE5MeBFBMQnGCQf/JV+ywBrjE9rlCraEdY5eL4kVmH6g8tudnGtn0TE+dAxKJss9t1s4wLq0NdgtUiqPtXlnc/yu7eQ6KK89yMsIoNzsr0ujqbt4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukf0KgD7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A319C1F00893;
	Thu, 11 Jun 2026 02:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781146763;
	bh=AK7brepBhWd/l5+KmrdZVyukL7SJWd59SkYVYwFGzD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ukf0KgD73INb51VoRnkiPbegfHaf4kUXuozacn30e2qX3yJE4G8bfBi+n6WQlwU77
	 mP1W7CqsRyU0CAJGGVu9cQMQN+xgzGD9fwyrSrEyB4G07zHgGEl0yhY7P8kzYGNhkO
	 4nJ0LNJ9msqa6txAOThG/Wadc48wrpqW/jgc+/Cz0LQ0mxLd1vyEQ1Rq9ggCPXH9EM
	 akFBCrRLzUH/vHmJnNWpQsMfbB818AdcBeGRcXvUL5dS40DFAvwks4+0BJT02/O37K
	 n5nUUTd4wbs/wGtgUynfHiODTNz6je+SOzcPiSu9A+0No3uNhGz22eSdk8S87lwQew
	 YIBQNOuy/2aUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] scsi: add BLIST_NO_LUN_1F blacklist flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phil Pemberton" <philpem@philpem.me.uk>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260611024356.2769320-5-philpem@philpem.me.uk>
References: <20260611024356.2769320-5-philpem@philpem.me.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 02:59:23 +0000
Message-Id: <20260611025923.A319C1F00893@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24679-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:philpem@philpem.me.uk,m:linux-ide@vger.kernel.org,m:dlemoal@kernel.org,m:cassel@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5635866DE93

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsynchronized read-modify-write of bitfields in `struct scsi_targ=
et` (`pdt_1f_for_no_lun`) causes a data race that can corrupt concurrent up=
dates to `expecting_lun_change`.
--

commit 22aca9342fbe7619010508e9209d9f91ff554f8a
Author: Phil Pemberton <philpem@philpem.me.uk>

scsi: add BLIST_NO_LUN_1F blacklist flag

This commit adds a new blacklist flag, BLIST_NO_LUN_1F, to handle multi-LUN
devices that respond to INQUIRY on unpopulated LUNs with PQ=3D0 / PDT=3D0x1=
f. It
wires this flag up in scsi_probe_and_add_lun() to set the pdt_1f_for_no_lun
field on the scsi_target.

> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index ef22a4228b855..ef0f5ee6be87d 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -1285,6 +1285,9 @@ static int scsi_probe_and_add_lun(struct scsi_targe=
t *starget,
>  	 * PDT=3D00h Direct-access device (floppy)
>  	 * PDT=3D1Fh none (no FDD connected to the requested logical unit)
>  	 */
> +	if (bflags & BLIST_NO_LUN_1F)
> +		starget->pdt_1f_for_no_lun =3D 1;

[Severity: High]
Does this unprotected bitfield assignment risk a data race?

In include/scsi/scsi_device.h, pdt_1f_for_no_lun shares a memory word with
expecting_lun_change in struct scsi_target.

If this function processes LUN 1 while LUN 0 has already been added and is
processing I/O, a concurrent UNIT_ATTENTION could trigger an update to
expecting_lun_change from softirq context in
drivers/scsi/scsi_error.c:scsi_report_lun_change():

	sdev->sdev_target->expecting_lun_change =3D 1;

Since bitfield assignments are implemented as non-atomic read-modify-write
sequences by the compiler, could this process-context write to
pdt_1f_for_no_lun silently overwrite and drop the softirq's update to
expecting_lun_change?

> +
>  	if (((result[0] >> 5) =3D=3D 1 || starget->pdt_1f_for_no_lun) &&
>  	    (result[0] & 0x1f) =3D=3D 0x1f &&
>  	    !scsi_is_wlun(lun)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611024356.2769=
320-1-philpem@philpem.me.uk?part=3D4

