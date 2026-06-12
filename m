Return-Path: <linux-scsi+bounces-24853-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BsPYHYzsK2pfHwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24853-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:25:00 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69AA678F51
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:24:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UesUbwcH;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24853-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24853-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D447335730E
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AC38655D;
	Fri, 12 Jun 2026 11:23:00 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFE3C454F
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 11:22:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263379; cv=none; b=KbvbneImBA5w4X9LqOmy6xAob9E3U0qXUNBOYHeJ7WhWJ4Dt9RtSSO41Qr5CrrgZ7VADciCkL6TQt+jKzhvShq5T4yhqSch9Pl0um+5y/kTQToUBK8Hr+IwRk5C1rDVNGSCZTfPUeN0oiHgFL/OyHUVcHypsZQnVppWDFWCmktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263379; c=relaxed/simple;
	bh=R6ZT1F1EGW0g0JYL1ak+gsnDOpVwIN3J8qWm4L6bTRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=be1ty3DjQMSj32eNJJHeCfVym/zU3AcQs1hEXQcDj2u8TxM8QNx7PobXaUSkZ7ilrSeTncweKcsiky+HGSVj5i3RtCMzVQsYwbGVRG1c4KaJdlyUPFTqUKR0307CxqnP2vKVOnN3b98iFjkahJjwn5BQM0bV7vBGYlzKzDGDJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UesUbwcH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64F71F000E9;
	Fri, 12 Jun 2026 11:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781263376;
	bh=PUCcxklApmrWFF/jWFmAxHWxNK+j+PJMdaaPPmaOOeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UesUbwcHLfvT3JrLSKXRSFLeYzDQBmnZktVL6hxWlrRMpW0RBip2BSIa7UxcACO2j
	 FHsLytu+2Is55OFHUjj5WWDKatSRQWcq+KAmZDV7XACA/cSNX78siz0loNnUOvcRga
	 IZREi8Uc8uYdO4KyDktlrh7noQg6Dy8/Cba1wLlhck5B+dagCML2jU4whsMZmHUJhY
	 TdVtDutCK1DMtIuGOS/1ruxqKrG8377BpEI6tjG4E5EMxf5qNw3aoJu7ohZxPbPW1z
	 El/PTo8EFAsZMND/XMaHzaRg0QRHmjMvYRt+wsAzoXXQ5qlRjW7ZmmgXFqsu7PoPmB
	 vHwQWc+zqHPow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/60] scsi: qla2xxx: Enable get_firmware_state for
 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260612095333.1666592-21-njavali@marvell.com>
References: <20260612095333.1666592-21-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:22:56 +0000
Message-Id: <20260612112256.A64F71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24853-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C69AA678F51

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack memory is leaked to userspace because `qla2x00_get_fi=
rmware_state()` copies uninitialized stack variables into the `states` arra=
y on error, which is then exposed via sysfs.
- [High] The `qla2x00_fw_state_show()` function attempts to bypass retrievi=
ng the firmware state when the chip is down or EEH is busy, but due to a lo=
gic flaw, it unconditionally executes the command anyway outside the safety=
 lock.
--

commit 9c27dc0c2250c56e44cb02cf37c800f20ca12033
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Enable get_firmware_state for 29xx

This commit enables the get_firmware_state mailbox command for 29xx
adapters. It adds IS_QLA29XX() checks to ensure MBX_12 is properly
set up and reported.

> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_a=
ttr.c
> index 742becc0dadf7..ee6bf83029911 100644
> --- a/drivers/scsi/qla2xxx/qla_attr.c
> +++ b/drivers/scsi/qla2xxx/qla_attr.c
> @@ -2436,7 +2436,7 @@ qla2x00_mpi_fw_state_show(struct device *dev, struc=
t device_attribute *attr,
>  	u16 mpi_state;
>  	struct qla_hw_data *ha =3D vha->hw;
> =20
> -	if (!(IS_QLA27XX(ha) || IS_QLA28XX(ha)))
> +	if (!(IS_QLA27XX(ha) || IS_QLA28XX(ha) || IS_QLA29XX(ha)))
>  		return scnprintf(buf, PAGE_SIZE,
>  				"MPI state reporting is not supported for this HBA.\n");

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a logic flaw in
qla2x00_fw_state_show() in this same file. When the chip is down, it unlocks
the mutex and jumps to the out label, but then unconditionally executes the
mailbox command again outside the lock:

qla2x00_fw_state_show()
    if (qla2x00_chip_is_down(vha)) {
        mutex_unlock(&vha->hw->optrom_mutex);
        ql_log(ql_log_warn, vha, 0x707c, "ISP reset active.\n");
        goto out;
    }
    ...
out:
    if (rval !=3D QLA_SUCCESS) {
        memset(state, -1, sizeof(state));
        rval =3D qla2x00_get_firmware_state(vha, state);
    }

Since rval is initialized to QLA_FUNCTION_FAILED, does this bypass the safe=
ty
checks and execute qla2x00_get_firmware_state() anyway, potentially causing=
 a
firmware hang?

> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mb=
x.c
> index 9c78aa66e12b3..a91ac59dd9c06 100644
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c
[ ... ]
> @@ -2301,7 +2301,7 @@ qla2x00_get_firmware_state(scsi_qla_host_t *vha, ui=
nt16_t *states)
>  		states[3] =3D mcp->mb[4];
>  		states[4] =3D mcp->mb[5];
>  		states[5] =3D mcp->mb[6];  /* DPORT status */
> -		if (IS_QLA27XX(ha) || IS_QLA28XX(ha))
> +		if (IS_QLA27XX(ha) || IS_QLA28XX(ha) || IS_QLA29XX(ha))
>  			states[11] =3D mcp->mb[12]; /* MPI state. */
>  	}

[Severity: High]
This is a pre-existing issue, but it looks like there is a kernel stack mem=
ory
leak in qla2x00_get_firmware_state() affecting the states array.

The mailbox command structure mbx_cmd_t mc is allocated on the stack but not
zero-initialized. If qla2x00_mailbox_command() fails early and returns
without modifying mc.mb, the code unconditionally copies the uninitialized
variables into the states array:

    states[0] =3D mcp->mb[1];
    if (IS_FWI2_CAPABLE(vha->hw)) {
        states[1] =3D mcp->mb[2];
        ...

The sysfs handler then formats this state array directly into its output and
ignores the error return value.

Could this expose uninitialized kernel stack memory to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095333.1666=
592-1-njavali@marvell.com?part=3D20

