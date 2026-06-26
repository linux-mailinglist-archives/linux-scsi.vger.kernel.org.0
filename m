Return-Path: <linux-scsi+bounces-25295-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VA1DCrpsPmqNFwkAu9opvQ
	(envelope-from <linux-scsi+bounces-25295-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 14:12:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A66CCDF5
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 14:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m0sgvySq;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25295-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25295-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EAA26300FCAF
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CB93F39ED;
	Fri, 26 Jun 2026 12:07:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEC3F413D
	for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 12:07:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475648; cv=none; b=FQT28UjJiJOuCjFUq30xRRqNNIpAIuyWb6I9XRuWRHA1E31eFYUbkcCvV8SrcIcJizGuVy5Qbwvf8gt2UoGJwzFMKf7eTXxrscHqjLqtqDkzYKzqyL0X+Xe6Mgh4m+ZcbBNdt9idt9b6mT2DJiI0a6hXnpHH1+UMaK2tMnACm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475648; c=relaxed/simple;
	bh=IVC82L3GIYG7hkmBSSPL9I/okvtky/0Y+QSAflM3iNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGEya4CA4PY4NmKxSYQ5mk7AFgmJt5pbvlyiBQqtGrhxMQfcECdUDuwAYDid+pXHfly9w6MnyAdtzlYqmOEJZlPeP0hwNybE/OFDy4yMLXdgX2WoRzILSTV+2zA8A/0vIILz+g2U/SXa0ufgCsXd1yi74rrWd05aHaFphr+LD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0sgvySq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD5B1F000E9;
	Fri, 26 Jun 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475647;
	bh=aRPo46ADXPfuuD9gtPrFDIte+nHoKOz/Gbu3SHH+OpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0sgvySqWvHirpAI3S4xUFUV1vz8zidWFHgeLEHeyqyu93Cp3lzmwJ032vsM/Ywzd
	 6OUKtErC3HuY1O3/15aPdBwsJjRHV4zedaRnqAgEMs+ZUy6LmELdB+j6U7IYaSABLe
	 PPCNE6YjyXd5fspTXpnzb+Jq5zQlkJSr0EfEjXWjcHwMFiu1QSoA7CPMyNtG0iTHfJ
	 HS6in4QkTIw9CRtZWe4KIGpsxIeVXTKPv7JAy/OAtE2pafYNCnaimZKbgi1V2Gaebw
	 L6Ejcm3BixO/4l40+PJCpm0zPdsW3AKHLBkISeRDqccB5nxp/hs0NJV7wlct3Manta
	 rTs9Lyf+0Chag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/10] mpi3mr: Fix NVMe page size caching for
 non-operational devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ranjan Kumar" <ranjan.kumar@broadcom.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260626114109.43685-5-ranjan.kumar@broadcom.com>
References: <20260626114109.43685-1-ranjan.kumar@broadcom.com>
 <20260626114109.43685-5-ranjan.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:07:26 +0000
Message-Id: <20260626120727.3CD5B1F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25295-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ranjan.kumar@broadcom.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 208A66CCDF5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated firmware-provided `page_size` used as a shift exponent=
 can lead to Undefined Behavior and a divide-by-zero panic.
--

commit f5cd5ed48fb67b9c92c834f74f43b66abd174677
Author: Ranjan Kumar <ranjan.kumar@broadcom.com>

mpi3mr: Fix NVMe page size caching for non-operational devices

This commit updates the driver to populate the PCIe page size attribute
regardless of the device access status, ensuring management IOCTLs can be
processed for non-operational devices.

> diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr=
_os.c
> --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> @@ -1354,12 +1354,10 @@ static void mpi3mr_update_tgtdev(struct mpi3mr_io=
c *mrioc,
>  		tgtdev->dev_spec.pcie_inf.capb =3D
>  		    le32_to_cpu(pcieinf->capabilities);
>  		tgtdev->dev_spec.pcie_inf.mdts =3D MPI3MR_DEFAULT_MDTS;
> -		/* 2^12 =3D 4096 */
> -		tgtdev->dev_spec.pcie_inf.pgsz =3D 12;
> +		tgtdev->dev_spec.pcie_inf.pgsz =3D pcieinf->page_size;

[Severity: High]
This is a pre-existing issue, but does removing the NO_ERRORS check expose
the driver to undefined behavior if the firmware returns garbage data?

For devices in an error state, the firmware might return uninitialized
data like 0xFF for pcieinf->page_size. This unvalidated value is later
used in shift operations:

drivers/scsi/mpi3mr/mpi3mr_app.c:mpi3mr_build_nvme_prp() {
    ...
    dev_pgsz =3D 1 << (tgtdev->dev_spec.pcie_inf.pgsz);
    ...
}

and

drivers/scsi/mpi3mr/mpi3mr_os.c:mpi3mr_configure_nvme_dev() {
    ...
    lim->virt_boundary_mask =3D (1 << pgsz) - 1;
    ...
}

Since 1 is a 32-bit signed integer, evaluating 1 << pgsz with a value
of 31 or greater results in signed integer overflow or a shift out of
bounds. If the shift evaluates to 0 on some architectures, it could also
cause a divide-by-zero panic when computing MPI3MR_IOCTL_SGE_SIZE % dev_pgsz
later in the code.

Is it possible to add bounds checking for the page_size before assigning
it to tgtdev->dev_spec.pcie_inf.pgsz?

>  		if (dev_pg0->access_status =3D=3D MPI3_DEVICE0_ASTATUS_NO_ERRORS) {
>  			tgtdev->dev_spec.pcie_inf.mdts =3D
>  			    le32_to_cpu(pcieinf->maximum_data_transfer_size);
> -			tgtdev->dev_spec.pcie_inf.pgsz =3D pcieinf->page_size;
>  			tgtdev->dev_spec.pcie_inf.reset_to =3D
>  			    max_t(u8, pcieinf->controller_reset_to,
>  			     MPI3MR_INTADMCMD_TIMEOUT);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626114109.4368=
5-1-ranjan.kumar@broadcom.com?part=3D4

