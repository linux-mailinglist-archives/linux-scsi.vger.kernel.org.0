Return-Path: <linux-scsi+bounces-26189-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 95WkBdgsVmoO0wAAu9opvQ
	(envelope-from <linux-scsi+bounces-26189-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 14:34:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52496754998
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 14:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KouY7i2j;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26189-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26189-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 794E43056679
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC744839C;
	Tue, 14 Jul 2026 12:26:53 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682944A710
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 12:26:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032013; cv=none; b=RYRhhjumh+ddKRDxrTIjw8jLiJPRvI65g5RixwaiaEBito+g0MPU7ksFfadCPwuRGdXmJkkjnj4kYeWd3oZNzI7CMmPclIEd9TNn36+Ld//+H9jD8c41JvO0JiLz5b8bRYk1ZWagwYZ+6/AeKTE+SV3ObIvknPX+FicgtSgu7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032013; c=relaxed/simple;
	bh=5lhOPccrEBznznxKdI+QyTA1JvmkfubyugIUieSI+CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kX8DAkJ68W9NhqGJDoUDR3UYDTluHmEYXDrkz/VIat0vZxqYrIEOXm4LJicCgW0HcyErRNdScMtsv4+gj8tyRBQytRSl//nWbj35CeYpRZv2MjwfERehDGQl/dlpGKghhKCXjWhWunDAW/K1rcoBIdppyWaCMOA+pchmIh8xuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KouY7i2j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662461F000E9;
	Tue, 14 Jul 2026 12:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032006;
	bh=BokWhKEJg2sXlq2vkII3g8JFsSEVp+ycGB+BvENnsm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KouY7i2jciYAyTZWL5ChT3w6lzwmhOuOUVia2NweZVpIXofB+UZr5vWRcv88m8QxY
	 8ZtgGp651q0kJSXO35jXq2Vsf2tTtNYlft94Bg6paD1YkZU2BVC1p0r/uDdzfwYVvg
	 dj6lE+Ig4mP1vIUYkMoKLEXvVm3l1u4s+G2fScR275LF+2DajexiNFYKXT0JtJgVOn
	 DSzQhwPV+1AjhcAdWiPLjtyINpmjqXvbNzu/nh8aNBMm5mx4j4wjmft0e5g0L3F5ez
	 2kAFWMcZtPrBGwrkg3nWtM4YJAAWtSToB2c7La1JcpjJpmiXFvD5TBlrj2a5tmQKsO
	 ML2x6PVlY5iaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/56] scsi: qla2xxx: Add flash read/write interface
 for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714095353.289460-3-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
 <20260714095353.289460-3-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:26:45 +0000
Message-Id: <20260714122646.662461F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-26189-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,marvell.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52496754998

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The newly added qla29xx flash read/write functions are not hooked =
to the isp_ops struct, breaking sysfs/BSG flash access.
- [Medium] Integer overflow in total_chunks and total_segments variables, c=
ausing an infinite loop in flash reads/writes
- [Low] The check_and_set_mbc_bits macro lacks a do { ... } while(0) wrappe=
r, violating coding guidelines and causing potential compilation errors in =
unbraced conditionals.
--

--- Patch [2]: [PATCH v4 02/56] scsi: qla2xxx: Add flash read/write interfa=
ce for 29xx ---
commit cc824b368b84bc7c06a17348bb30ee20ef746c82
Author: Manish Rangankar <mrangankar@marvell.com>

scsi: qla2xxx: Add flash read/write interface for 29xx

This patch adds the mailbox wrappers and helpers needed for flash read and=
=20
write operations on the 29xx series adapters. It provides the infrastructur=
e=20
to parse the flash layout table and execute block reads and writes.

> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_de=
f.h
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
[ ... ]
> @@ -5348,6 +5355,14 @@ static inline bool qla_vha_mark_busy(scsi_qla_host=
_t *vha)
>  /*
>   * Flash support definitions
>   */
> +#define check_and_set_mbc_bits(bopt, dopt, bit_to_check, bit_to_set) {	\
> +	if (bopt & bit_to_check)			\
> +		dopt |=3D bit_to_set;			\
> +}

[Severity: Low]
This isn't a bug, but this macro is defined as a block rather than with a
do-while(0) loop. Could this cause compilation errors if used inside an
unbraced if statement followed by an else?

> +
> +#define SET_FW_BIT(__opts, bit) ((__opts) |=3D (bit))
> +#define CLEAR_FW_BIT(__opts, bit) ((__opts) &=3D ~(bit))
[ ... ]
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -3237,6 +3237,7 @@ qla2x00_probe_one(struct pci_dev *pdev, const struc=
t pci_device_id *id)
>  		ha->flash_data_off =3D ~0;
>  		ha->nvram_conf_off =3D ~0;
>  		ha->nvram_data_off =3D ~0;
> +		ha->flt_segment_length =3D QLA_SEGMENT_LENGTH;
>  	}

[Severity: High]
The commit message mentions adding the necessary hooks in isp_ops so that t=
he
existing flash infrastructure can drive the new hardware. However, it looks
like the patch fails to provide the wrapper functions to map the 6-argument
qla29xx_read_optrom_data to the 4-argument isp_ops->read_optrom.

Does this mean sysfs/BSG flash access will fall back to legacy routines and
break due to ha->flash_data_off being ~0?

[ ... ]
> diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_su=
p.c
> --- a/drivers/scsi/qla2xxx/qla_sup.c
> +++ b/drivers/scsi/qla2xxx/qla_sup.c
[ ... ]
> +qla29xx_write_optrom_data(struct scsi_qla_host *vha, uint16_t reg_code,
> +			 uint16_t opts, void *buf, uint32_t offset,
> +			 uint32_t length)
> +{
[ ... ]
> +	uint16_t total_segments, segment_index =3D 0;
> +	uint16_t chunk_index =3D 0, chunk_count =3D 0;
[ ... ]
> +	while (region_dlen > 0) {
> +		uint32_t segment_size, total_chunks;
> +		uint16_t options =3D 0;
> +
> +		segment_size =3D (region_dlen > seg_dlen) ? seg_dlen : region_dlen;
> +		total_chunks =3D (segment_size + OPTROM_BURST_DWORDS - 1) /
> +				OPTROM_BURST_DWORDS;
[ ... ]
> +		chunk_index++;
> +		chunk_count++;
> +		if (chunk_index >=3D total_chunks) {

[Severity: Medium]
Will this loop ever terminate if total_chunks is greater than 65535?

Because chunk_index is declared as a uint16_t while total_chunks is a=20
uint32_t, chunk_index will wrap around to 0.=20

Could total_segments also suffer from integer truncation since it is=20
declared as a uint16_t?

> +			chunk_index =3D 0;
> +			segment_index++;
> +			region_dlen -=3D segment_size;
> +		}
> +	}
[ ... ]
> +qla29xx_read_optrom_data(struct scsi_qla_host *vha, uint16_t reg_code,
> +			 uint16_t opts, void *buf, uint32_t offset,
> +			 uint32_t length)
> +{
[ ... ]
> +	uint16_t total_segments, segment_index =3D 0;
> +	uint16_t chunk_index =3D 0, chunk_count =3D 0;
[ ... ]
> +	while (region_dlen > 0) {
> +		uint32_t segment_size, total_chunks;
> +		uint16_t options =3D 0;
> +
> +		segment_size =3D (region_dlen > seg_dlen) ? seg_dlen : region_dlen;
> +		total_chunks =3D (segment_size + OPTROM_BURST_DWORDS - 1) /
> +				OPTROM_BURST_DWORDS;
[ ... ]
> +		chunk_index++;
> +		chunk_count++;
> +		if (chunk_index >=3D total_chunks) {

[Severity: Medium]
Similarly, does this read path also suffer from the same uint16_t wrap=20
issue for chunk_index and total_segments?

> +			chunk_index =3D 0;
> +			segment_index++;
> +			region_dlen -=3D segment_size;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714095353.2894=
60-1-njavali@marvell.com?part=3D2

