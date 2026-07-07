Return-Path: <linux-scsi+bounces-25786-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ey74BWiZTGqFmwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25786-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:15:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 668FB717D8D
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:15:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g9J+6vfh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25786-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25786-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3A0E3018C06
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 06:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D1388E43;
	Tue,  7 Jul 2026 06:12:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1CE388878
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 06:12:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404771; cv=none; b=gotv/AfNq0ylKX/Wyx0gBeY8mroYvx2wla/hSg8e9YThjJbDckunsutv2vATxNQvdoPIxb7AKwo9LbdHgBxPg2saEZeXM7z6t9pjIiAoSnd5SYigU7VrCflaaF35I9OUTtRuQiKVA0yJvXGTxz11l3had3zFhCqiWbO4zqT2tx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404771; c=relaxed/simple;
	bh=ydNhD55MpG3pvcSAmDOY0Ioq9Ftz+rBUfnOB3COqR1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o/Qap5j85f2swwkIpD6wAkJEebyqYzrxZxNJEavPQ6XQamL/IYzYL+FtocubKMNKpQA7BSGkciphLdDw/tkfl5TMGcIC9rXFxzVgM3cFzqAjwyByExs+pcTWPQt0Xf+QMcUvkJdHfJH7i6oVTdppeHya839M4FS5WRz8GSBC+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9J+6vfh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C7B1F000E9;
	Tue,  7 Jul 2026 06:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783404770;
	bh=OaFMIWUbh8fHOIkz1z58ENRQ3boNVgwYb74XsTB/078=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9J+6vfhnpptjZLqhatpxzfk6H8GtzV+kOzFIGMnZxn6fM/B0RUONNn7V1BxJj9wW
	 YByE2tgubhh3PslaXMS9A/9kug/WfP4gIxyUqSbDmpxZ3HYnWh4q1rhKYQ8F7Vcy+E
	 ZW8ihQmMP+Ms0l0SZSPHy5bOPOiGezw89xypj3r9vfrLAPaY3gjwf0/XRwDaUBaLaA
	 nAFnVR7MoyDwjAulHoy6a0lFay3OTvuzEeHulOiUuttKTPLeTGWeAtjf/tRU5fNyxt
	 oSnEBNl+8TswZTAKnNz+CsbPeMMMG2lUD/my/IaXjeJz5EFOl423eiBkp2kBJhY9gj
	 X5I6wDsy+Igyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/88] scsi: qla2xxx: Enable get_fw_version mailbox
 for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-15-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-15-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 06:12:49 +0000
Message-Id: <20260707061250.34C7B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25786-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 668FB717D8D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mpi_version and pep_version sysfs attributes return empty string=
s for 29xx adapters.
- [Medium] EDIF enablement logic for 29xx adapters is unreachable dead code.
--

--- Patch [14]: [PATCH v3 14/88] scsi: qla2xxx: Enable get_fw_version mailb=
ox for 29xx ---
commit 2382364dd411bb453d1411f7e7ec1a1bea0e802e
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Enable get_fw_version mailbox for 29xx

The serdes_version and several firmware capability fields were not
populated for 29xx because the get_fw_version mailbox path excluded
it from the 27xx/28xx checks. This commit adds IS_QLA29XX() to the
relevant conditionals so that firmware version, EDIF, and serdes
information are correctly retrieved on 29xx adapters.

> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_a=
ttr.c
> index e8755ab86b6ac..c44f5282abb39 100644
> --- a/drivers/scsi/qla2xxx/qla_attr.c
> +++ b/drivers/scsi/qla2xxx/qla_attr.c
> @@ -1526,7 +1526,7 @@ qla2x00_serdes_version_show(struct device *dev, str=
uct device_attribute *attr,
>  	scsi_qla_host_t *vha =3D shost_priv(class_to_shost(dev));
>  	struct qla_hw_data *ha =3D vha->hw;
> =20
> -	if (!IS_QLA27XX(ha) && !IS_QLA28XX(ha))
> +	if (!IS_QLA27XX(ha) && !IS_QLA28XX(ha) && !IS_QLA29XX(ha))
>  		return scnprintf(buf, PAGE_SIZE, "\n");

[Severity: Medium]
Since IS_QLA29XX() is being added here to expose the serdes version, should=
 it
also be added to qla2x00_mpi_version_show() and qla2x00_pep_version_show() =
in
the same file?

Without it, userspace tools querying the mpi_version and pep_version sysfs
attributes for 29xx adapters will receive empty strings instead of the actu=
al
firmware version data:

drivers/scsi/qla2xxx/qla_attr.c:qla2x00_mpi_version_show() {
    ...
    if (!IS_QLA81XX(ha) && !IS_QLA8031(ha) && !IS_QLA8044(ha) &&
        !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
        return scnprintf(buf, PAGE_SIZE, "\n");
    ...
}

[ ... ]

> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mb=
x.c
> index 9c2633ca5036c..0feb98b83293a 100644
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c
[ ... ]
> @@ -1212,7 +1212,7 @@ qla2x00_get_fw_version(scsi_qla_host_t *vha)
>  			vha->flags.nvme2_enabled =3D 1;
>  		}
> =20
> -		if (IS_QLA28XX(ha) && ha->flags.edif_hw && ql2xsecenable &&
> +		if ((IS_QLA28XX(ha) || IS_QLA29XX(ha)) && ha->flags.edif_hw && ql2xsec=
enable &&
>  		    (ha->fw_attributes_ext[0] & FW_ATTR_EXT0_EDIF)) {
>  			ha->flags.edif_enabled =3D 1;
>  			ql_log(ql_log_info, vha, 0xffff,

[Severity: Medium]
Will this EDIF enablement logic ever execute for 29xx adapters?

Looking at qla2x00_execute_fw() in the same file, ha->flags.edif_hw is only
initialized for 28xx adapters:

drivers/scsi/qla2xxx/qla_mbx.c:qla2x00_execute_fw() {
    ...
    if (IS_QLA28XX(ha) && (mcp->mb[5] & EDIF_HW_SUPPORT)) {
        ha->flags.edif_hw =3D 1;
    ...
}

Because ha->flags.edif_hw is never set for 29xx adapters, this patched
condition will always evaluate to false, leaving EDIF permanently disabled
on 29xx hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D14

