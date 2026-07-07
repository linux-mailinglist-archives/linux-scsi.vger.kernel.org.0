Return-Path: <linux-scsi+bounces-25828-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FoAYB6ynTGrMngEAu9opvQ
	(envelope-from <linux-scsi+bounces-25828-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:15:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F042718598
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:15:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gLKiAK2q;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25828-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25828-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83EF63022ABE
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13623B2D1D;
	Tue,  7 Jul 2026 07:10:01 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBE38C415
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:10:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408201; cv=none; b=fTACrqq6m6x+k5Sqvq7Vq5Zv3W3gYg5iPaAFtWeCXq/Ds1jOyrUE+TY1v9J591KPFXVqvbSYJ7ioJyY03Hgw1l8/9+GhR8A1V5IAzvxvO9xqzDT6v9cfPo2/yEtj9Ez8e6zFhkKYksWxonMZvE1ewER1vNQ5NNPZq0HLeQlz5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408201; c=relaxed/simple;
	bh=n/d6UU/yvaDgFmIqAsW/o/DBZVZ/S/VswnWezSV1gKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uY6AHNi1qwmJY9zGjEAboN53xLYCC/D90L1cTlOIIakSc2qeyLyJI4/JdUiMKNpuD4Cl5kLvLuCYTiBjSE3wpQAKG6y71uGtJILClDbGYuKt4JR5ueRbZnRGKZIbfZnxmIZ3/TqzmMEcqCG7DX6NVSpfZc81KaEYEUBDi7GU0tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLKiAK2q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD21F000E9;
	Tue,  7 Jul 2026 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408200;
	bh=p6Q4SSI3GkVMLHcVY8AQtCRNJjut5LEI5Nsgn/Pfars=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLKiAK2qLDzQa/sMKZtDA5yc7IvH6PjaHfYHLXOzocAluGskjeN+V6vEhKaZi9C9d
	 b4q7Q/KQ1wv4uM9NKzUDzunK1h2BslPtPalrz+Fr/ZQUUON2oSgrjO1KVr0mFEEFPi
	 lH4VaITqDZAWoRxS5HVHe9HL5N8jTle9RTJzwi7FwKBXSpxrVSMANikQQ/WGes/rgV
	 I9/W3k155F1zPHc09jcP3ZJ5Dxzh6UnblVAZTA8pgXWOMgOnFF5x5z2gCuS3iSBMMB
	 KdwC/uneMGem541TjFgFXf2QQdlC+H5gdfqd0qXEAmnbDYRni0X0Ai3/QfSeSA2v6W
	 Zvb0eXtWFGrOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 46/88] scsi: qla2xxx: edif: Fix NULL pointer deref in
 RX SA delete check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-47-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-47-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:09:59 +0000
Message-Id: <20260707070959.EEAD21F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25828-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,marvell.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F042718598

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch adds a NULL check for `cmd` to prevent a crash, assu=
ming an aborted command leaves `cmd` as NULL. However, `cmd` can only be NU=
LL due to an ABA race condition where `req->outstanding_cmds[handle]` has b=
een reallocated to a new SRB. The patch fails to prevent type confusion if =
the handle is reused for non-SCSI commands (like `SRB_SA_UPDATE` or `SRB_LO=
GIN_CMD`) where `GET_CMD_SP(sp)` aliases with non-NULL union members.
--

--- Patch [46]: [PATCH v3 46/88] scsi: qla2xxx: edif: Fix NULL pointer dere=
f in RX SA delete check ---
commit edde2908b0e57558092f680fc5317a31b4bd99de
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: edif: Fix NULL pointer deref in RX SA delete check

This commit addresses a NULL pointer dereference in
qla_chk_edif_rx_sa_delete_pending() by adding an early return when the
command pointer is NULL. The pointer can be NULL if the firmware posts a
status completion for an already returned or aborted command.

> diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_e=
dif.c
> index ade1d81785736..bfa520f936a24 100644
> --- a/drivers/scsi/qla2xxx/qla_edif.c
> +++ b/drivers/scsi/qla2xxx/qla_edif.c
> @@ -3540,6 +3540,9 @@ void qla_chk_edif_rx_sa_delete_pending(scsi_qla_hos=
t_t *vha,
>  	uint32_t handle;
>  	uint16_t sa_index;
> =20
> +	if (!cmd)
> +		return;
> +

[Severity: Critical]
This is a pre-existing issue, but does this NULL check completely prevent
type confusion if the handle is reused for non-SCSI commands?

Due to an ABA race condition where req->outstanding_cmds[handle] can be
reallocated to a new SRB without a generation counter check, a late
firmware completion for a freed handle could map to a reused SRB:

drivers/scsi/qla2xxx/qla_isr.c:qla2x00_status_entry() {
    ...
	/* Validate handle. */
	if (handle < req->num_outstanding_cmds) {
		sp =3D req->outstanding_cmds[handle];
		if (!sp) {
    ...
}

If the handle is reused for a non-SCSI command like SRB_SA_UPDATE or
SRB_LOGIN_CMD, GET_CMD_SP(sp) might alias with non-NULL union members
such as the bsg_job pointer.

In that case, cmd would evaluate to a non-NULL value, bypassing this check
and potentially leading to an out-of-bounds read or invalid pointer
dereference when accessing cmd->sc_data_direction.

Could the underlying handle reuse race in qla2x00_status_entry() be
addressed to prevent late completions from mapping to the wrong command
type?

>  	handle =3D (uint32_t)LSW(sts24->handle);
> =20
>  	/* find out if this status iosb is for a scsi read */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D46

