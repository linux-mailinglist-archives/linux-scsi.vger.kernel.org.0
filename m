Return-Path: <linux-scsi+bounces-25912-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZQ3fLlOwTmraSQIAu9opvQ
	(envelope-from <linux-scsi+bounces-25912-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 22:17:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB972A274
	for <lists+linux-scsi@lfdr.de>; Wed, 08 Jul 2026 22:17:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kdTMI7kr;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25912-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25912-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A46183037F50
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jul 2026 20:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30B3E3148;
	Wed,  8 Jul 2026 20:12:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471B3E5EC2
	for <linux-scsi@vger.kernel.org>; Wed,  8 Jul 2026 20:12:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541542; cv=none; b=gN4Wr8WL4ttZ/dwMhnP4zppcMeJv/Mhew3WuiiSLSOd5ZTMyzyX6UEpC1emW3zixP9SLfpFe6+GmkeLUlw8CTZCDtmKkuvCPw5fUX6mSAT2NhrgXjWeQYu2nlRtKQQTxvKAK3ZAshsfVThHA6n0YslPKcuN1cB1ZGJ5d2GWCgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541542; c=relaxed/simple;
	bh=TtNtqXn1qTS6GE9YCfI3+7bcZuBto0FmOet+eQEcqYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+RCo/0YqO95s8BC0SPQTUWRra6u2gIfQK+uUohE7dHVH6m7WyPVZ70wxoInpH2ouTggAnj0q6EdE97G1nBqjI57v75V8j6DEJw5pgxVHwTlLucMpO4BMB5E1xPUy2jo22su9cVGaiTIHfIw9WuTSTV1RZgXjsjxalkMOgU7ybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdTMI7kr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9951F000E9;
	Wed,  8 Jul 2026 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783541538;
	bh=fem8GazO4+4VG4LlbfmRLbQ9JzJE91P9xAEBlZtgcSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdTMI7krOyMUzmVpTAnU7/VP/yPrIYHCnStky3RZSGUFqNGvKAEUDTAHjRaru4anU
	 A8CIl5oix3MOiAwiQ1002tfdoL6+kj63Qp2Bauv3IY1/alG1pHxY+IOXON9KUjbgPw
	 6+Cwozm5kQyuQh6Kva2ufakY2FXp/ywe1kFLKoy5F4mLVwUnmPuGjow6PH1Rhy2OgD
	 OPe+UBK/82kFWezVCsYaxqQLqs5T4zeOwFscinA0vqBWiLjyvmlsCrO5fGNh0HUJ1n
	 iP8tyHXtL0NiDcUU79EY/EPkVa+fMFoL2qOBGazhUA+iXjxMCj0RTO3IevUtLQpx5n
	 ac7uXZHkui1pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] mpi3mr: Fix SAS port allocation and
 registration error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ranjan Kumar" <ranjan.kumar@broadcom.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260708183305.244485-9-ranjan.kumar@broadcom.com>
References: <20260708183305.244485-1-ranjan.kumar@broadcom.com>
 <20260708183305.244485-9-ranjan.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:12:17 +0000
Message-Id: <20260708201217.EE9951F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25912-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11EB972A274

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Double free of `rphy` on `sas_rphy_add` failure path.
--

--- Patch [8]: [PATCH v2 08/10] mpi3mr: Fix SAS port allocation and registr=
ation error handling ---
commit e4e396e6a24625afa6491df657cf719648b0c2a2
Author: Ranjan Kumar <ranjan.kumar@broadcom.com>

mpi3mr: Fix SAS port allocation and registration error handling

This commit adds NULL checks for SAS port and rphy allocations to prevent
potential NULL pointer dereferences. It also introduces cleanup logic on
the error paths to prevent memory leaks when registration fails.

Closes: https://sashiko.dev/#/patchset/20260626114109.43685-1-ranjan.kumar@=
broadcom.com?part=3D8

> diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr=
/mpi3mr_transport.c
> index 240f67a8e2e3b..b51edbb921ebb 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c

[ ... ]

> @@ -1463,6 +1481,9 @@ static struct mpi3mr_sas_port *mpi3mr_sas_port_add(=
struct mpi3mr_ioc *mrioc,
>  	if ((sas_rphy_add(rphy))) {
>  		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
>  		    __FILE__, __LINE__, __func__);
> +		sas_port_delete(port);
> +		sas_rphy_free(rphy);

[Severity: High]
Does this code introduce a double free?  When sas_rphy_add() fails, port->r=
phy
still points to the newly allocated rphy object.=20

Calling sas_port_delete(port) automatically invokes sas_rphy_delete(port->r=
phy):

drivers/scsi/scsi_transport_sas.c:sas_port_delete() {
    ...
	if (port->rphy) {
		sas_rphy_delete(port->rphy);
		port->rphy =3D NULL;
	}
    ...
}

Since sas_rphy_delete() will free the rphy, executing sas_rphy_free(rphy)
immediately afterward appears to operate on an already-freed pointer.

> +		goto out_fail;
>  	}
>  	if (mr_sas_port->remote_identify.device_type =3D=3D SAS_END_DEVICE) {
>  		tgtdev->dev_spec.sas_sata_inf.pend_sas_rphy_add =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708183305.2444=
85-1-ranjan.kumar@broadcom.com?part=3D8

