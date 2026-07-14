Return-Path: <linux-scsi+bounces-26175-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8JGE8cLVmr7yQAAu9opvQ
	(envelope-from <linux-scsi+bounces-26175-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 12:13:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D4753475
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 12:13:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VGTCNNQa;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26175-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26175-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB3F30179EB
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877263630B7;
	Tue, 14 Jul 2026 10:12:01 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A1350285
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 10:11:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023921; cv=none; b=ElN0bwzD3jZsu9Rr5MzjpILGe2DIcXKASbOBZ/gxUO09x4rgAcKilBRX5DhOGgDUs4w+PvdqzhZqCypj652K1C4Uxvi1RZnJogRJMvHMuc4bOl9Gy79HpNNOnw8w6PWGguL9YJmTxE31rvMBpXiB+UYrW6tQmFehPHmpKrGTgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023921; c=relaxed/simple;
	bh=tXClJFbbAVRwQdXE0awnqACZ8OxrQjaiDHcBSBiimsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aplln8a3Lylu4679ORIOXy+LXn0TwRRdreUo3JK9a1cxpXJBjhU8Wr/K79CYREJ1d1AwgZV88FtUh5L9pAOtP9mvYAnaHmeJ7YMqYGIu4fL4QT7kpzbgB/P5sxb4idrfx7Hlck2CZoWeRVaPFz/h59uQrhL5WoetlLCwYDRowt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGTCNNQa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93781F00A3D;
	Tue, 14 Jul 2026 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784023919;
	bh=ZtEqfUUozpGOEEv+V5n1hoc7C8sRNQN9VdqjBmK06tM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGTCNNQaAqwvncsNrxhjiLQ51essVA2J3k1mfSJkJoT9JcLt8mrbqqg8G8YFxaNCg
	 uHNxd41TV7wV4QC9mrMledWvj/uUK7kk2k1UkkZO7TVYnVn0GKTW6PssAWpb+VjU6M
	 4FABPj0eswtHZrJOcOV1kHHp1wcAkFsvnqX1h626ZAN83Jupt09p+xZnhhEBf4wbRP
	 jITZcsH5H0B9GHU6IrcHlK9hJ1nqv9ccqigcu8K+m5aaUVSTC1tpG2HMqgVdssWFTd
	 J0VIHImpqOAMhbTYwAaHek3vVsOlcv/YOTSDebO+8lF7EamZmPuumVzkkdCUWoF3Lf
	 3gEFt7KP8xkkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/56] scsi: qla2xxx: Add NVRAM config support for
 29xx adapters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714095353.289460-4-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
 <20260714095353.289460-4-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:11:59 +0000
Message-Id: <20260714101159.A93781F00A3D@smtp.kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-26175-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 855D4753475

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing assignment `ha->fiv =3D NULL` when `qla29xx_read_optrom_=
data` fails to read the Flash Image Version (FMB).
--

--- Patch [3]: [PATCH v4 03/56] scsi: qla2xxx: Add NVRAM config support for=
 29xx adapters ---
commit 9423305e2fdeec148901334c684199e074dc7d5b
Author: Manish Rangankar <mrangankar@marvell.com>

scsi: qla2xxx: Add NVRAM config support for 29xx adapters

Extend the NVRAM read and configuration-apply paths to handle the
29xx series.  The 29xx NVRAM layout is similar to the 81xx family,
so reuse the existing nvram_81xx parsing while adding
29xx-specific fields and init-sequence integration.

> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_i=
nit.c
> index e23e7ac48ae26..f5d230fc3642d 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c

[ ... ]

> @@ -9306,34 +9306,97 @@ qla81xx_nvram_config(scsi_qla_host_t *vha)

[ ... ]

> +		ha->fiv =3D (struct qla_flash_memo_block *)
> +			((char *)ha->vpd + ha->vpd_size);
> +
> +		buf =3D qla29xx_read_optrom_data(vha, FLT_REG_FMB_PRI,
> +					       fw_options, ha->fiv, 0,
> +					       sizeof(struct qla_flash_memo_block));
> +		if (!buf) {
> +			ql_log(ql_log_info, vha, 0x01be,
> +			    "Unable to read Flash Image Version.\n");

[Severity: Medium]
Does this code leave ha->fiv pointing to an uninitialized buffer if the
qla29xx_read_optrom_data() read fails?

In the invalid signature check immediately below, ha->fiv is explicitly set
to NULL. If ha->fiv isn't also set to NULL here on a read failure, any futu=
re
code checking if ha->fiv is populated might falsely assume the FMB data is
available and attempt to operate on the uninitialized buffer.

> +		} else if (ha->fiv->signature !=3D QLFC_FMB_SIG) {
> +			ql_log(ql_log_warn, vha, 0x01bf,
> +			    "Invalid FMB signature %#x, expected %#x.\n",
> +			    le32_to_cpu(ha->fiv->signature),
> +			    le32_to_cpu(QLFC_FMB_SIG));
> +			ha->fiv =3D NULL;
> +		} else {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714095353.2894=
60-1-njavali@marvell.com?part=3D3

