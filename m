Return-Path: <linux-scsi+bounces-24808-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6BbtIfbcK2p+GgQAu9opvQ
	(envelope-from <linux-scsi+bounces-24808-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:18:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF37678A64
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:18:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MCXY7Fii;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24808-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24808-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 018A43167686
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C8383304;
	Fri, 12 Jun 2026 10:18:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13136F91D
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:18:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259505; cv=none; b=pPOoqem+DE2mpAa9v8G5kJ8s4bf1T1dZIHwSYRiZctSiCYCIcw6mzd4ca3vhXAFNlX9V0A+xQyrVSOHayUDacvmU8XueViPD53eFNxiAfB/UkIMJfydQ13lWGFcR/Le0PDgS61hzmweI4repXhfEbulHRtv5m8dzSgQAL0dN6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259505; c=relaxed/simple;
	bh=M2BunIqwPzkCKuIz0bndbfaam9avlwT5DMr3ZX9YIhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jB+DW8wixZam0aU6L363go9vdsaEU3qTcjzp1JO9Y5xjKUJiQiGMKWI0JHs7LyxHxjcCj0rjV2ghBvsrYuKFNHb7wG+HEYofx89W3G6H1J4u3AzndU9enovHPjSe/B+wX1nHwkpSCE7XPGgi99DcpLgx2LKJYCXvFU6aIuUsoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCXY7Fii; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5367E1F000E9;
	Fri, 12 Jun 2026 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781259504;
	bh=vhj43dGBN2+wOToo+sbN7sEiWfVhFRVjEX7QUMRDG2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MCXY7FiiwxY3ROie947+ISRzEnnKe9gmZQ+T8E5MUuyzsYrHcnblerBPjhl4OaYUY
	 29izkgti37EG1ZdNUxLW83nPaHrgXjAvlwbKjheyWlxksEB8jDmPLrdg67672MNpZt
	 YCs+D1HlycIJpxQDgZqp8eRK43hKWBf165j/wMNT+FiE2930NcR2pEy6RI7ACMrbHw
	 sHLbefX+qUnWiDTeMVgiCLvTrNQ8LiCtPGiWxo/dRC6wcquDHwYFnS4ePpP+JwJfR5
	 BjOqkVjXvWi0a2dDQPBi8ShoMvcBA6bHF0xely0y8WMeKcSRT1dRJ769yk8mFM5Na9
	 bkTeNDCKgPW0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/60] scsi: qla2xxx: Add get_flash_version support
 for 29xx adapters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260612095333.1666592-5-njavali@marvell.com>
References: <20260612095333.1666592-5-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:18:23 +0000
Message-Id: <20260612101824.5367E1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24808-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,marvell.com:email,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAF37678A64

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Inconsistent fallback error handling logic and commit message mi=
smatch in `qla24xx_get_flash_version()`.

Pre-existing issues:
- [High] Hardware flash registers are read/written via `qla24xx_read_flash_=
dword` without proper locking, creating a race condition with concurrent sy=
sfs operations.
--

commit 94d10a85b890acf6bb363bf65b3e955e838a9522
Author: Manish Rangankar <mrangankar@marvell.com>

scsi: qla2xxx: Add get_flash_version support for 29xx adapters

This commit removes the standalone qla29xx_get_flash_version() and folds=20
29xx support directly into qla24xx_get_flash_version(). It uses early=20
metadata reads for 29xx firmware and modifies PCI expansion ROM reads.

>   - PCI expansion ROM reads (header + data structure): a new
>     file-static helper, qla24xx_read_pci_rom_chunk(), abstracts the
>     per-generation flash access so both read sites are straight-line
>     calls instead of inline if/else twin blocks.  29xx uses
>     qla29xx_read_optrom_data(FLT_REG_BOOT_CODE, byte-offset); 24xx
>     uses qla24xx_read_flash_data(dword-address).

The commit message mentions a new file-static helper,
qla24xx_read_pci_rom_chunk(), but this function does not appear in the code.
Is the commit message out of sync with the patch?

> diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_su=
p.c
> index eb10904f14caa..2229c2b084cff 100644
> --- a/drivers/scsi/qla2xxx/qla_sup.c
> +++ b/drivers/scsi/qla2xxx/qla_sup.c
[ ... ]
> @@ -4137,7 +4108,7 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, voi=
d *mbuf)
>  		if (ret) {
>  			ql_log(ql_log_info, vha, 0x017d,
>  			    "Unable to read PCI EXP Rom Header(%x).\n", ret);
> -			return QLA_FUNCTION_FAILED;
> +			break;
>  		}

[Severity: High]
This is a pre-existing issue, but can qla24xx_read_flash_data() race with
concurrent sysfs operations?

Hardware flash registers are read/written via qla24xx_read_flash_dword()
without proper locking:

qla24xx_read_flash_dword() {
	wrt_reg_dword(&reg->flash_addr, addr & ~FARX_DATA_FLAG);
	while (cnt--) {
		if (rd_reg_dword(&reg->flash_addr) & FARX_DATA_FLAG) {
        ...
}

When invoked via the sysfs reset handler:

qla2x00_sysfs_write_reset() {
    ...
    ha->isp_ops->get_flash_version(vha, tmp_data);
    ...
}

It doesn't appear to hold ha->optrom_mutex or ha->hardware_lock. Could
concurrent calls interleave their register accesses and corrupt data?

[Severity: Medium]
When qla24xx_read_flash_data() fails, the code now uses break to fall throu=
gh
and read the active firmware image version. However, signature validation
failures later in this loop still return QLA_FUNCTION_FAILED:

		bcode =3D mbuf + (pcihdr % 4);
		if (memcmp(bcode, "\x55\xaa", 2)) {
			/* No signature */
			ql_log(ql_log_fatal, vha, 0x0059,
			    "No matching ROM signature.\n");
			return QLA_FUNCTION_FAILED;
		}

If the flash read succeeds but contains invalid boot code, the function abo=
rts
entirely and skips reading the firmware version, whereas a complete flash r=
ead
failure successfully falls through. Is this inconsistent fallback behavior
intentional?

> =20
>  		bcode =3D mbuf + (pcihdr % 4);
> @@ -4155,7 +4126,7 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, voi=
d *mbuf)
>  		if (ret) {
>  			ql_log(ql_log_info, vha, 0x018e,
>  			    "Unable to read PCI Data Structure (%x).\n", ret);
> -			return QLA_FUNCTION_FAILED;
> +			break;
>  		}
> =20
>  		bcode =3D mbuf + (pcihdr % 4);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095333.1666=
592-1-njavali@marvell.com?part=3D4

