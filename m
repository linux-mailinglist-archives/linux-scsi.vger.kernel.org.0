Return-Path: <linux-scsi+bounces-25907-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QH3iHYWiTmqTRAIAu9opvQ
	(envelope-from <linux-scsi+bounces-25907-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 21:18:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8D729D45
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 21:18:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iGl09Zsp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25907-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25907-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67A88300F5C7
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2026 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222D031282F;
	Wed,  8 Jul 2026 19:18:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241343933C
	for <linux-scsi@vger.kernel.org>; Wed,  8 Jul 2026 19:18:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538306; cv=none; b=ceF7fPZZ5CKO19F8wqvtCVboTsN1Vg9952dXYOfbU8kfafJsI6y4xvxW7Y4MoyUzMs5WcEv1Ck6QQfA0uUr9lxrZEiFt6XSdVTGrZIniJ5HmD3DJh9SYqt1cO1rakuZRUSfzP4/KeSA75clYM7Rvzf9D0lkddZUEyvsiW1rAKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538306; c=relaxed/simple;
	bh=EgHYVyzl2pOBaKjiW9vaLdgz6EdEhpMBNFqEtXbdUOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fyg/cDqdOvf1kGXKC3BGSVv73O1ksy5uFYgQlgqK4CTBKkMmMtkvt2i6qnx2N2ffRqKvTqm3yAXb8YsAhu7f5/TgyeO7nx9PquwwOgDWAYyiO6mFGBzlHz9Z60cpc1HLVwqMp5n5wvPw1DH+1QDDMoAaDAhj45J3qL3S5LqGZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGl09Zsp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5AC1F00A3A;
	Wed,  8 Jul 2026 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538304;
	bh=YbhhdVLfuUVxCEE1+MBGTZnJIbK4C2gt8odeacmzEew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iGl09ZspDKNJuDRSASWrqNSihVH/d1Ce6E8aUKp67o80SCFvuHPCf8/lKIE8pnocZ
	 2GTSDoku6N2PQZg5UVEwgkk5LXfr5viYQF5wHbY+SKc9DjWq3/ogSQBw3IFfcGyjGA
	 nhcL6v5cZi9fa2RcKjJgnysJJrN4gouLyqGh6b9yFZhc9HMwuL5b1qTjc5pOCQqTw9
	 9Ikncw3ITkW1Sl8R24GiYFh3g7p2K0PbXlSl/c8lvsDZIc/8aOgM39iaQxzNynupQD
	 N8KEvRLqWhGj8sYTEPgOu48c2eVox+kYSUk9tpYUSokMjZA1V8/JGrvrcbcrxt2HM9
	 HWo4v2McAFadw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] mpi3mr: Fix NVMe page size caching for
 non-operational devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ranjan Kumar" <ranjan.kumar@broadcom.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260708183305.244485-5-ranjan.kumar@broadcom.com>
References: <20260708183305.244485-1-ranjan.kumar@broadcom.com>
 <20260708183305.244485-5-ranjan.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 19:18:23 +0000
Message-Id: <20260708191824.5C5AC1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25907-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ranjan.kumar@broadcom.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EED8D729D45

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `reset_to` and `abort_to` fields are left uninitialized for PC=
Ie devices in error states, causing task management commands to time out in=
stantly and trigger unintended full controller resets.
--

--- Patch [4]: [PATCH v2 04/10] mpi3mr: Fix NVMe page size caching for non-=
operational devices ---
commit a648ff0d4d5627aa485822e3033940c480028902
Author: Ranjan Kumar <ranjan.kumar@broadcom.com>

mpi3mr: Fix NVMe page size caching for non-operational devices

This patch populates the PCIe page size attribute for NVMe devices regardle=
ss
of their access status, ensuring management IOCTLs can reach the firmware.
It also adds bounds checking for the firmware-provided page size to prevent
undefined shift behavior, falling back to a default size if invalid.

Closes: https://sashiko.dev/#/patchset/20260626114109.43685-1-ranjan.kumar@=
broadcom.com?part=3D4

> diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr=
_os.c
> index d2a20f2721dbf..df7365d19b44a 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> @@ -1354,12 +1354,14 @@ static void mpi3mr_update_tgtdev(struct mpi3mr_io=
c *mrioc,
>  		tgtdev->dev_spec.pcie_inf.capb =3D
>  		    le32_to_cpu(pcieinf->capabilities);
>  		tgtdev->dev_spec.pcie_inf.mdts =3D MPI3MR_DEFAULT_MDTS;
> -		/* 2^12 =3D 4096 */
> -		tgtdev->dev_spec.pcie_inf.pgsz =3D 12;
> +		/* Validate firmware page size to prevent undefined shift behavior */
> +		if (pcieinf->page_size > 0 && pcieinf->page_size < 31)
> +			tgtdev->dev_spec.pcie_inf.pgsz =3D pcieinf->page_size;
> +		else
> +			tgtdev->dev_spec.pcie_inf.pgsz =3D 12; /* Default to 4096 (2^12) */
>  		if (dev_pg0->access_status =3D=3D MPI3_DEVICE0_ASTATUS_NO_ERRORS) {
>  			tgtdev->dev_spec.pcie_inf.mdts =3D
>  			    le32_to_cpu(pcieinf->maximum_data_transfer_size);
> -			tgtdev->dev_spec.pcie_inf.pgsz =3D pcieinf->page_size;
>  			tgtdev->dev_spec.pcie_inf.reset_to =3D
>  			    max_t(u8, pcieinf->controller_reset_to,
>  			     MPI3MR_INTADMCMD_TIMEOUT);

[Severity: High]
This is a pre-existing issue, but does exposing the device to IOCTLs by
setting the page size here unintentionally turn a device error into a full
controller reset?

When an NVMe device is in an error state (e.g., NEEDS_INITIALIZATION),
access_status !=3D NO_ERRORS, so reset_to and abort_to are left uninitializ=
ed (0).

With this patch populating pgsz for these devices, management IOCTLs can pa=
ss
the driver's PRP validation and reach the firmware. If the IOCTL times out
because the device is in an error state, the driver attempts recovery:

drivers/scsi/mpi3mr/mpi3mr_os.c:mpi3mr_issue_tm() {
    ...
	if (tgtdev) {
		if (tgtdev->dev_type =3D=3D MPI3_DEVICE_DEVFORM_PCIE)
			timeout =3D cmd_priv ? tgtdev->dev_spec.pcie_inf.abort_to
					   : tgtdev->dev_spec.pcie_inf.reset_to;
    ...
}

Since reset_to and abort_to are 0, wait_for_completion_timeout() fails
instantly, causing the driver to falsely detect a TM timeout and
unconditionally execute mpi3mr_soft_reset_handler(), resetting the entire
controller.

Should reset_to and abort_to also be initialized with defaults even when the
device is in an error state to prevent routine monitoring tools from trigge=
ring
an HBA reset?

>  			tgtdev->dev_spec.pcie_inf.abort_to =3D
>  			    max_t(u8, pcieinf->nvme_abort_to,
>  			    MPI3MR_INTADMCMD_TIMEOUT);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708183305.2444=
85-1-ranjan.kumar@broadcom.com?part=3D4

