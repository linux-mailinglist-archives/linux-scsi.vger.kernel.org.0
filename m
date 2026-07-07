Return-Path: <linux-scsi+bounces-25854-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DtlHhm5TGrnogEAu9opvQ
	(envelope-from <linux-scsi+bounces-25854-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 10:30:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B957191E0
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 10:30:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ikDmxl9S;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25854-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25854-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0370A30557F1
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBAE2472AE;
	Tue,  7 Jul 2026 08:24:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DB17A303
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 08:24:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412665; cv=none; b=W1xyN6h1JNsFY5jOF9GqDoCtct7FGqPBZRVaBCCZOyspOA9bwGVNYaL1Xxf/NELTxL9lLxjKEPi1uxuBBnQ5yJjGPFEBmAeB53K5db0GMXKaBdX4VtARLug3DDjXu38yPN8kgf3pqSujLT1ofsFV3sGfv0mvxxG83bbIY9dapEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412665; c=relaxed/simple;
	bh=W7nM2fWuJpwlObkH4HucqMdu5sPGoXMp8fJHqb7t00k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E5zDRTrxqPSL/w1mMJcg1XDMITESzk5Ie+CEzFFnBvNWkWKAwmt718u6QlOOb6/2kSxGXrAyS7Cnr8ho5679OPTspnRJnycqmIrYkifYgMXXq7n2otkANaNMXPXEBdTwX8BDh7/wtxCGpphyr/xLfzbE3o2EZ0g30CR17u2gZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikDmxl9S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175501F000E9;
	Tue,  7 Jul 2026 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412664;
	bh=QRGItC1naocIs1FsadEJFcJ3N68S+AqVisN7bvHMe6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ikDmxl9Sdg3pnsHEGvpxIQSypqscBsLFQqWUXts0dgAjYpTEf31AO6T0xwmNUDWll
	 o+eLwXBOgvyh3RAmDULiB4AXJyNV8+IAPKL4RVm4TB+Fq6lcwR7KzTMN9JmqsMTIzy
	 Vy1vwQsErzoIqWRuvnsnDbPFcYSkjCFPehRgMekCeeO2/ikEXBHXvA9vw2u/fY5SAg
	 s9N3KJSqiaJA8bacSNE8HIkdgu58hGUp0qh7iOaLzzq9vmbKv75JIMWvFCTLalR6hk
	 +HHvN2sTypwZGmH9zPBeAZ4uOdEUtKN0ok4i0dPS+MfpNcoMkkOK47JJ7JdU1wAdki
	 hNn2nZJ3XB7Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/88] scsi: qla2xxx: Add flash read/write interface
 for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-3-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-3-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:24:23 +0000
Message-Id: <20260707082424.175501F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25854-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6B957191E0

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing `isp_ops` hooks for QLA29xx flash operations, causing inte=
ger overflow and broken flash access.
--

--- Patch [2]: [PATCH v3 02/88] scsi: qla2xxx: Add flash read/write interfa=
ce for 29xx ---
commit 2be5c3c775caf216f27f9159429f66a07c2ee89a
Author: Manish Rangankar <mrangankar@marvell.com>

scsi: qla2xxx: Add flash read/write interface for 29xx

This commit introduces new mailbox wrappers and helpers for flash read
and write operations on QLA29xx series adapters. It also aims to hook
these into the existing flash infrastructure via isp_ops.

> diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_su=
p.c
> index b6c36a8a2d60b..6b9938d1a7501 100644
> --- a/drivers/scsi/qla2xxx/qla_sup.c
> +++ b/drivers/scsi/qla2xxx/qla_sup.c
> @@ -10,6 +10,539 @@
[ ... ]
> +int
> +qla29xx_write_optrom_data(struct scsi_qla_host *vha, uint16_t reg_code,
> +			 uint16_t opts, void *buf, uint32_t offset,
> +			 uint32_t length)
> +{
[ ... ]
> +void *
> +qla29xx_read_optrom_data(struct scsi_qla_host *vha, uint16_t reg_code,
> +			 uint16_t opts, void *buf, uint32_t offset,
> +			 uint32_t length)
> +{
[ ... ]
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index c91d2b8bd08e7..ebb97329e6eac 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -3237,6 +3237,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struc=
t pci_device_id *id)
>  		ha->flash_data_off =3D ~0;
>  		ha->nvram_conf_off =3D ~0;
>  		ha->nvram_data_off =3D ~0;
> +		ha->flt_segment_length =3D QLA_SEGMENT_LENGTH;
>  	}

[Severity: High]
Are the newly introduced qla29xx_read_optrom_data() and
qla29xx_write_optrom_data() functions ever assigned to the qla29xx_isp_ops
structure?

If these new handlers are missing from ha->isp_ops->read_optrom and
write_optrom, won't sysfs or BSG flash operations route to the legacy
handlers instead?

Since ha->flash_data_off is explicitly initialized to ~0 (0xFFFFFFFF) for
the 29xx adapters here in qla2x00_probe_one(), using the legacy handlers
would cause an integer overflow when calculating the physical address.

This could route invalid memory addresses to the adapter and lead to
failed operations, timeouts, or firmware crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D2

