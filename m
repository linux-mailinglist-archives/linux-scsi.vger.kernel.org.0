Return-Path: <linux-scsi+bounces-25797-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id imQJJHWbTGrrmwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25797-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:23:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCE717E9C
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:23:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DQVoixns;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25797-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25797-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 039BF3026220
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E2376A09;
	Tue,  7 Jul 2026 06:23:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F9334C08
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 06:23:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405425; cv=none; b=JjpaKVOyPPipKyhPx5C8cRUAybswPlgK/HGlTE6Khvrt1I8j2mLwQ0X2YuBG39kcQuItQmxDDu2JML2HvXzBz1cZKTU7eB4izfyyxPt0p0m1ZpYzW95jjJMpz4rp4mY/+L101zEe2gQsQUoT0Rw1ZM7x06+bFu5g0/0qs0ZnC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405425; c=relaxed/simple;
	bh=sCjHrZ+2gDUgkk9pGcS2Ow1+H/bVijj5fEJ2wZpv2h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BOaKY7Yo/0bETrilgK0EfE3R7LyqnXNX2E4a0z27I246i4JafHsa2H7OJAAD9pIhhbsEbZXlkoVuJsKfO59F7GDRjwiOELafe2H6tvrMBGNtY3dcgLIjGyLZbLf07afU2ELbBtgzdk/IPumRPpVYlq1lWdahZfxIXNG2FPJ7JEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQVoixns; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DC01F000E9;
	Tue,  7 Jul 2026 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783405424;
	bh=7kTApiD/TSZDK//XWKQdKgqxYQLlNIgPEXr6Odk9DFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQVoixnsUQtk6wJzaTXyYfUjdS3yKCWObVV8k9v43JgeXmvRhDVoVEvKtMgzpefhM
	 YtdXPB+CbXbkHAWEE3Jezp2n8DLuiW13UwnLKtKhK5raJA1Ro2tRUMHe/XjcVn/Yrv
	 /g/XDCiPAfhkAWH6+z+B++SLfafUbSt58hWGK/JbhYBTGkpn2Fw0OWZk4GsZ+cXue6
	 ahN1tQSCzv+hKbrPzm5prQWxSuZxsTyI4J8TpkstF4/C0zb7r0oj6O/FErLvC2SXUO
	 /3r8XtWw19iErHtb5p3imdfbN8oZRGrRIe65Vit0wPC7+s7a86M/6mnBIUoz+3C5f/
	 8A5baL9cgOSHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/88] scsi: qla2xxx: Extend execute_fw mailbox to
 include 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-16-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-16-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 06:23:43 +0000
Message-Id: <20260707062344.18DC01F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25797-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,marvell.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0DCE717E9C

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Structure mismatch when preparing CT/FDMI MS IOCBs for QLA29XX=
 adapters results in firmware executing wild DMAs using uninitialized garba=
ge addresses.
--

--- Patch [15]: [PATCH v3 15/88] scsi: qla2xxx: Extend execute_fw mailbox t=
o include 29xx ---
commit 29bbcde0cc31e2b4641ba7302984a3c7980dc0ef
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Extend execute_fw mailbox to include 29xx

Add IS_QLA29XX() to the BPM capability macros and to the
execute-firmware mailbox command so that NVMe enable, minimum
speed negotiation, 128 Gbps speed reporting, EDIF hardware
detection, and FW-semaphore retry logic all apply to 29xx
adapters.

> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mb=
x.c
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c

[ ... ]

> @@ -727,14 +728,13 @@ qla2x00_execute_fw(scsi_qla_host_t *vha, uint32_t r=
isc_addr)
>  				    ha->lr_distance << LR_DIST_FW_POS;
>  		}
> =20
> -		if (ql2xnvmeenable && (IS_QLA27XX(ha) || IS_QLA28XX(ha)))
> +		if (ql2xnvmeenable && (IS_QLA27XX(ha) || IS_QLA28XX(ha) || IS_QLA29XX(=
ha)))
>  			mcp->mb[4] |=3D NVME_ENABLE_FLAG;
> =20
> -		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
> -			struct nvram_81xx *nv =3D ha->nvram;
> +		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha) || IS_QLA29XX(h=
a)) {

[Severity: Critical]
Since this patch enables initialization and capabilities for 29xx adapters,
does it also need to update CT/FDMI MS IOCB preparation to use the 128-byte
extended format required by QLA29XX hardware?

When the driver sends FDMI registrations or CT pass-through commands on
QLA29xx hardware, it unconditionally prepares the buffer using the legacy
64-byte struct ct_entry_24xx format. For example, in
qla24xx_prep_ms_fdmi_iocb():

drivers/scsi/qla2xxx/qla_gs.c:qla24xx_prep_ms_fdmi_iocb() {
    ...
    ct_pkt =3D (struct ct_entry_24xx *)ha->ms_iocb;
    memset(ct_pkt, 0, sizeof(struct ct_entry_24xx));
    ...
}

And similarly in qla24xx_prep_ms_iocb():

drivers/scsi/qla2xxx/qla_gs.c:qla24xx_prep_ms_iocb() {
    ...
    ct_pkt =3D (struct ct_entry_24xx *)arg->iocb;
    memset(ct_pkt, 0, sizeof(struct ct_entry_24xx));
    ...
}

QLA29XX firmware expects the 128-byte struct ct_entry_24xx_ext format,
where lengths are at offsets 64/68 and DSDs begin at offset 72. Because
ha->ms_iocb is allocated via dma_pool_alloc without __GFP_ZERO, offsets
beyond 64 contain uninitialized memory.=20

Can this cause the 29xx firmware to read garbage lengths and DSD DMA addres=
ses
and perform wild DMAs, leading to arbitrary memory corruption or HBA firmwa=
re
panics during adapter initialization?

>  			/* set minimum speed if specified in nvram */
>  			if (nv->min_supported_speed >=3D 2 &&
> -			    nv->min_supported_speed <=3D 5) {
> +			    nv->min_supported_speed <=3D 7) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D15

