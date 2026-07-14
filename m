Return-Path: <linux-scsi+bounces-26183-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id imSSKDcZVmq2zAAAu9opvQ
	(envelope-from <linux-scsi+bounces-26183-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 13:10:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E849753C85
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 13:10:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KJNN54TK;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26183-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26183-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBDD30226BF
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971CA377019;
	Tue, 14 Jul 2026 11:06:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5E3769EF
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 11:06:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027190; cv=none; b=LWuwwEFA1GHf1afOJF6gndUZpQ7vDafwwn7lxf+m112LXGCvI3Ef6r7bDAhc+3vVTuIgYgihHjSOg6jXF3gbm4mEthgGqbgb0qRPzRcgHoIlCfFWwWzhNrbDnUJELsEkQnnxeQwTSUBU7eFqPVBe2d3kIH0zu5AApNN5ZNuM0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027190; c=relaxed/simple;
	bh=gn56do6UymBfQWbwUaGVs9ZuaYzCgOfCgsId/kEnOTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ha00i4LmaNuVE1cg13zp2BacnqMpEpvi5e16GRrYxc6njiqodqX+7cDXsjtuRRt4L7yLP229fZhGhRWB9ds+1fZuCSpm2Z0yaHT0bnKbQbRq4uBHPKu0seORgcPV/097ewIRzskF5zolnIcbZf0L9yS8stF7xzlu9iSZU7OCtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJNN54TK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D101F00A3D;
	Tue, 14 Jul 2026 11:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027189;
	bh=KLrkJxYydpTBDXfIEBOUbJn+4/iRar0Tmc2GClJBY9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJNN54TKY6wn/JRM5ZPTOi51uISqyoaXdbNuMBrzWmLqeFh3ttPn7aiNi6uNvzibG
	 g3LW6BMzwjQN9XQaRZzLiJu5z6c05kSoatQCSecaz8iqh3kyaWMx8OJgp0ikaZxzLR
	 ghJHVYwyz45/mtgh99wuCMiw29tGJJApsRE8VUtPmM1Nza/nCQ6Q5f0KMUWH7na8Y/
	 86IIMntxyWa16QnuQMvUDbjGbeIkMhdCm0c3Yj8T/bn5+1B1DJeQU9Z2Y3AuTMrNNi
	 sdIi9n5lIrPxAx1TbAPDO+SvNdrx5RUwrNhDT86SBTF7S/WURMRAz22XWOtkygmriR
	 EFEft13B5DxHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/56] scsi: qla2xxx: Add extended status
 continuation and marker IOCBs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714095353.289460-11-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
 <20260714095353.289460-11-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:06:28 +0000
Message-Id: <20260714110628.F0D101F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-26183-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,marvell.com:email,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E849753C85

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message explicitly claims to add a structure named `m=
rk_entry_ext_t`, but this structure is completely missing from the patch an=
d the entire codebase.
--

--- Patch [10]: [PATCH v4 10/56] scsi: qla2xxx: Add extended status continu=
ation and marker IOCBs ---
commit 7582f36ee7094ac8210ce81133caf62e1a0ea4c4
Author: Anil Gurumurthy <agurumurthy@marvell.com>

scsi: qla2xxx: Add extended status continuation and marker IOCBs

This commit adds the 128-byte extended status continuation structure for
29xx firmware and includes the qla_fw29.h header. The commit message also
mentions adding a marker IOCB structure.

> Add the 128-byte sts_cont_entry_ext_t and mrk_entry_ext_t
> structures required by 29xx firmware.

> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_de=
f.h
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
[ ... ]
> @@ -2360,6 +2361,15 @@ typedef struct {
>  	uint8_t reserved_2[48];
>  } mrk_entry_t;
> =20
> +/* 29xx definitions */
> +struct sts_cont_entry_ext {
> +	uint8_t entry_type;		/* Entry type. */
> +	uint8_t entry_count;		/* Entry count. */
> +	uint8_t sys_define;		/* System defined. */
> +	uint8_t entry_status;		/* Entry Status. */
> +	uint8_t data[124];		/* data */
> +};
> +

[Severity: Medium]
This isn't a bug, but the commit message states that the mrk_entry_ext_t
structure is being added.

Looking at the changes in qla_def.h above, only the sts_cont_entry_ext
structure is included. Is the mrk_entry_ext_t structure missing from this
patch, or should the commit message be updated to reflect that it is not
included?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714095353.2894=
60-1-njavali@marvell.com?part=3D10

