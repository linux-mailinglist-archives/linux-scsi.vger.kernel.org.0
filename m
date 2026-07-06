Return-Path: <linux-scsi+bounces-25638-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9BTTJYmBS2pMSgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25638-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 12:20:57 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF470F153
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Jul 2026 12:20:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FH/Uhcgx";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25638-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25638-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4904835ED61A
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2026 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53D44CF59;
	Mon,  6 Jul 2026 09:26:31 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CD432BEF
	for <linux-scsi@vger.kernel.org>; Mon,  6 Jul 2026 09:26:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329991; cv=none; b=I11e44DAOpfnj/nlnAYkvXvb4JAv0aUGRjIoINi3VZcQFd/LKmGlcRWxJyXkbZ5PAROptq24mDmX1aAhJ6eUk4OzfANjwzCXtrkx8xWjlOsEezBn4sk0qM5Yk4Tz2a/72yVLkRNoNU8OkWC2Ws8+iudF7jN9J1pWLYrmaCfffes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329991; c=relaxed/simple;
	bh=SK9dXvBszQfpmrNbia0ZZ4frbDv2mo8dk2yj4nOuHXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mdH4d50pcS38inRbvsxeOfnXaPPKZ1DMzevH/QlWjC0l8ed2prDk9TMT7fF2sRolUCJzM2x4T9R0u1w08hDuHBG+MS+LASvgjoxMTepR9fKJd8LmEYyFvyiejomMN4Hzycqq+nz1dKuGMfRgBh4FqfbPoZspD0vIKdGiLXRVQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH/Uhcgx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079EB1F00A3A;
	Mon,  6 Jul 2026 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329986;
	bh=uElGO0QjKq+7BKZk2opehiyUEppxB+zBuZ3IGHLL3/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FH/UhcgxAarsb63VI0SRUuFWL96804BiHeSJXaN7UR5dhlZ3Pl3LDsFq8z1hfmMUc
	 SfNpzEWBd0tJTpzytRcn9VTQK3SkTUFq4BwZlikxIInoKx/uyv36pjrUYTk0RYpvTE
	 mkueXc7nMqr0pX+7MDgcWbt09r0QZE8vXR0lae23ONeGNzdZgAfOQhfeZDCnMb+rGA
	 qRJDVmpWBwlKFKrLg+4B8rwQtHrEf8qc/LwMavR8ajD0OYSaVPGpHcPrN7aKFouVw1
	 dNjJaSBXgfS67XWULrUVqoWImLYpAV4ytY7FnMaaLbELAV6UOlyWqMVeY/WXGVB9WH
	 N4xS2gOKmVcJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: scsi_dh_alua: validate RTPG descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260706091440.77131-1-pengpeng@iscas.ac.cn>
References: <20260706091440.77131-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:26:25 +0000
Message-Id: <20260706092626.079EB1F00A3A@smtp.kernel.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25638-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0DF470F153

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The RTPG parsing logic trusts the `len` field from the RTPG payloa=
d header without verifying the residual transfer length from the SCSI execu=
tion. If a target returns a short read, the un-transferred portion of the b=
uffer (which is zeroed by the SCSI midlayer, or potentially left uninitiali=
zed by a buggy HBA) is blindly parsed as valid ALUA port group descriptors.
--

commit ede42460fc942e5ee60c7349a556d0e7a6fd87bb
Author: Pengpeng <pengpeng@iscas.ac.cn>

scsi: scsi_dh_alua: validate RTPG descriptors

This commit adds validation to the RTPG descriptor parsing loop in
alua_rtpg() to ensure the fixed eight-byte header is present before
reading descriptor fields.

> diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/de=
vice_handler/scsi_dh_alua.c
> index 80ab0ff921d43..f63f32bad12a3 100644
> --- a/drivers/scsi/device_handler/scsi_dh_alua.c
> +++ b/drivers/scsi/device_handler/scsi_dh_alua.c
> @@ -681,7 +681,12 @@ static int alua_rtpg(struct scsi_device *sdev, struc=
t alua_port_group *pg)
>  	for (k =3D tpg_desc_tbl_off, desc =3D buff + tpg_desc_tbl_off;
>  	     k < len;
>  	     k +=3D off, desc +=3D off) {

[Severity: High]
This is a pre-existing issue, but does this loop safely handle short SCSI
transfers?

The RTPG parsing logic appears to trust the len field from the RTPG payload
header without verifying the residual transfer length from the SCSI
execution.

Looking at submit_rtpg(), scsi_execute_cmd() is called without configuring
exec_args.resid to capture the residual count:

drivers/scsi/device_handler/scsi_dh_alua.c:submit_rtpg()
        const struct scsi_exec_args exec_args =3D {
                .sshdr =3D sshdr,
        };

Then in alua_rtpg(), the payload length is blindly trusted:

drivers/scsi/device_handler/scsi_dh_alua.c:alua_rtpg()
        len =3D get_unaligned_be32(&buff[0]) + 4;

        if (len > bufflen) {
                /* Resubmit with the correct length */

If a target returns a short read while specifying a larger length in its
header, could the un-transferred portion of the buffer be parsed as valid
ALUA port group descriptors?=20

This might cause the driver to parse zeroes or uninitialized memory,
deterministically forcing the state of ALUA group 0 to 0=20
(SCSI_ACCESS_STATE_OPTIMAL) or causing random ALUA state corruption. It=20
might also cause the driver to continually reallocate the buffer up to=20
the kmalloc limit if the reported len remains larger than bufflen.

> -		u16 group_id =3D get_unaligned_be16(&desc[2]);
> +		u16 group_id;
> +
> +		if (len - k < 8)
> +			break;
> +
> +		group_id =3D get_unaligned_be16(&desc[2]);
> =20
>  		spin_lock_irqsave(&port_group_lock, flags);
>  		tmp_pg =3D alua_find_get_pg(pg->device_id_str, pg->device_id_len,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706091440.7713=
1-1-pengpeng@iscas.ac.cn?part=3D1

