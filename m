Return-Path: <linux-scsi+bounces-26213-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q0caCKlzVmpW5wAAu9opvQ
	(envelope-from <linux-scsi+bounces-26213-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 19:36:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5E75782E
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 19:36:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eCm4kzmZ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26213-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26213-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D4933015E04
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B32DC791;
	Tue, 14 Jul 2026 17:31:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50762FF66B
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 17:31:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050298; cv=none; b=hvxweh4JkUgFgYJc8MWyFTd3ZyUaEepFv3Yy1HJ5R4EHBwzmj/5unaI8o3hf4di+mwN8S1wD2Ex8/5fBXhcNQLvSl/if3v/34olg8Ar1NFno8hryvgb6RYF+2Hg2GbkVtjfa9UobOJMBXn0Cywor4vWGiBGB2M90SfpIXtlSVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050298; c=relaxed/simple;
	bh=8ey2RU5yrw8n9aN8af4Dv/A8IwnzxppoSAwb/JvaLHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W8C6nk8q8RroFKRuNVngTWSg+AQhkdtTAmneDeHUIVlbQx2M6o3bIpLC0VXD5R0XSb76Sb+ggnsprG1+6J+QXGavsPbEZs491XwqKD7nbjlDWMq40y6v6g1vH4ujfOcmUqMzZ1sCimW/b98tRAcjXaf3Nc5kpP+yyiKJt3lcfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCm4kzmZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCF1F000E9;
	Tue, 14 Jul 2026 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784050296;
	bh=paY9kDrtj/kMlHRSoFAydxsTPpjwVCOQ+9LaVCIRjDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eCm4kzmZhaPGbc/DMEFyN19TAddzkjzkaABaQg/LyO0aq2g5H26PHdvK5NZl0Qyw7
	 u39RYa4SPwfd4Ggp11sgtuacwRXqy1RXfOelhEn+d5EcTSm97crHJdbt+3iZdd6dk7
	 vUwrqctdr/qNUEKcAaiGmODwjgV3o5Z4Px7bFeutBq8ndYquJCr8OGxj6MQkjitMlx
	 S7O4KoM75At82kJkcK9OMqXqb8/M6C1chNKyJv9U0PPmTgjzWwlJzT5m6nBWlU6ABK
	 r98XT3nrYb12XJhlwDjS6ZtgL1tkh4Pg0c2Jt0S0xMBcf4mjcc+9NCzyYz5ZPr0YTP
	 rtDh9nkQcOZFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 48/56] scsi: qla2xxx: Bound VP index against VP_CTRL
 IOCB bitmap size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714095353.289460-49-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
 <20260714095353.289460-49-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:31:35 +0000
Message-Id: <20260714173136.52DCF1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-26213-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49F5E75782E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double completion race between hardware interrupt and timer ti=
meout leads to stack Use-After-Free.
--

--- Patch [48]: [PATCH v4 48/56] scsi: qla2xxx: Bound VP index against VP_C=
TRL IOCB bitmap size ---
commit 2235c7e7d265883847cfc93768add50540a5f374
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Bound VP index against VP_CTRL IOCB bitmap size

The VP control IOCB selects its target virtual port by setting one bit
in vp_idx_map, a fixed 16-byte array. This patch ensures vp_index does
not exceed this capacity to prevent out-of-bounds writes.

> diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mi=
d.c
> --- a/drivers/scsi/qla2xxx/qla_mid.c
> +++ b/drivers/scsi/qla2xxx/qla_mid.c
> @@ -987,6 +987,14 @@ int qla24xx_control_vp(scsi_qla_host_t *vha, int cmd)
>  	if (vp_index =3D=3D 0 || vp_index >=3D ha->max_npiv_vports)
>  		return QLA_PARAMETER_ERROR;
> =20
> +	/*
> +	 * The VP_CTRL IOCB selects the target VP through a fixed 128-bit
> +	 * (16-byte) vp_idx_map bitmap, so vp_index must fit within it even
> +	 * if firmware advertises more NPIV vports.
> +	 */
> +	if (vp_index > sizeof_field(struct vp_ctrl_entry_24xx, vp_idx_map) * 8)
> +		return QLA_PARAMETER_ERROR;
> +
>  	/* ref: INIT */
>  	sp =3D qla2x00_get_sp(base_vha, NULL, GFP_KERNEL);
>  	if (!sp)

[Severity: Critical]
This is a pre-existing issue, but can a double completion race occur between
the hardware interrupt and timer timeout, leading to a stack Use-After-Free?

If qla2x00_sp_timeout() executes concurrently with the hardware completion
interrupt, and qla24xx_async_abort_cmd() fails (for example, due to a full
request queue), the timeout handler calls sp->done() unconditionally:

drivers/scsi/qla2xxx/qla_init.c:qla2x00_async_iocb_timeout() {
    rc =3D qla24xx_async_abort_cmd(sp, false);
    if (rc) {
        // ... lock and clear outstanding_cmds ...
        sp->done(sp, QLA_FUNCTION_TIMEOUT);
    }
}

Concurrently, the interrupt handler can also call sp->done(). Since
timer_delete() returns 0 when the timer is already running, neither thread
aborts in qla2x00_async_done():

drivers/scsi/qla2xxx/qla_iocb.c:qla2x00_async_done() {
    if (timer_delete(&sp->u.iocb_cmd.timer)) {
        ...
    }
    sp->async_done(sp, res);
}

This allows both threads to locklessly read sp->comp and call complete() in
qla_ctrlvp_sp_done().

The first caller wakes up the main thread in qla24xx_control_vp(), which
clears sp->comp locklessly and destroys the stack frame before returning:

drivers/scsi/qla2xxx/qla_mid.c:qla24xx_control_vp() {
    ...
    wait_for_completion(&comp);
    sp->comp =3D NULL;
    ...
}

Does this expose the stack to memory corruption when the second racing thre=
ad
subsequently calls complete() on the destroyed frame?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714095353.2894=
60-1-njavali@marvell.com?part=3D48

