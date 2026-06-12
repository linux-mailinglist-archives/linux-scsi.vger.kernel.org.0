Return-Path: <linux-scsi+bounces-24842-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cIVxMBvrK2oDHwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24842-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:18:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698A678EC1
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NROq0/S2";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24842-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24842-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B3E331C059
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0F38B13C;
	Fri, 12 Jun 2026 11:16:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C84369D47
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 11:16:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263003; cv=none; b=FjU1kSjEIr+1sRHWP91eqf6+geJxKzWvfwcAgVh9Y+/q2/CRnHNR79vY0QwdR/A4YFfjdEkVLv7ICXpPivJxGHC/DummTT2xUx9nyUJNQn6mgegelhWZ3qVIcOsOXwMMTtJ7Jr6SJgwne8pUZhPr+j6JLfF4GqknPV+fXvRVEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263003; c=relaxed/simple;
	bh=ZOSI329QAw4kV9BNL6bRLXI227tLeqZ/r1VstMyQR9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vAfsLZLcxINlU5goVcgINFzFgIq2pyv+UZmX6/GQfI4qiI8piEO91Vezrifz4ljq+B8Yyjzf1Z09haR7+cc68FrYBlVOanKWJQLyutvtwIGfEB+OP4DueupoXbPGqU+Fa7Kc2FTrP4UkkwPouc3HiSqgodOCwyDTgjDzG8wvlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NROq0/S2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074071F000E9;
	Fri, 12 Jun 2026 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781263002;
	bh=Dem53PfKosay/0T+7nIU7bLOyTOYeqSR5LJaJhBWwmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NROq0/S2CY83kGPA2MSYNA6aB1mEPhaByE+pPmUvb+38uyLJ0wRtE9Zm3M4r25ZXa
	 21Zx8LC9l/5nv6aQ0d/Jw2lh1M8952lj30l05mo2oaUKE6nHTJksUrFFmYgARxRy9i
	 2qknoPsBwKHAbYGWydJk6QlTTNKFsFE2dHzeCnGvXF50K4JxYyg6CEgCQUZJyz+7xs
	 sjCu7X71la2vCwIt8kEQ4+Ph6N9GDdpsWgonsTN9qpVL6PGqc3pWG9z2ytNiqe+wZ+
	 ILaP2l1jHnWt4RILc5MKhUXzjWa5f6yoqDP4vYVmRXSDwpXSXV2URjawpm6+NKuM6A
	 4OoNv9EP73egQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 44/60] scsi: qla2xxx: Adjust feature gating in BSG
 paths for 29xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260612095333.1666592-45-njavali@marvell.com>
References: <20260612095333.1666592-45-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:16:41 +0000
Message-Id: <20260612111642.074071F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24842-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,marvell.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1698A678EC1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] D-port diagnostics remain broken for QLA29xx due to a missing do=
wnstream feature check.
--

commit 8ffa642602cccd0180ae4aedb7562a144e25f71e
Author: Manish Rangankar <mrangankar@marvell.com>

scsi: qla2xxx: Adjust feature gating in BSG paths for 29xx support

This commit extends qla2xxx BSG command handling to recognize QLA29xx
adapters and align feature availability with hardware capabilities.
It updates several feature checks to allow QLA29xx in paths previously
restricted to QLA27xx/28xx.

> diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bs=
g.c
> index 00e980f0cd782..7f4558beee2c3 100644
> --- a/drivers/scsi/qla2xxx/qla_bsg.c
> +++ b/drivers/scsi/qla2xxx/qla_bsg.c
> @@ -2741,7 +2741,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_jo=
b)
>  	struct qla_dport_diag *dd;
> =20
>  	if (!IS_QLA83XX(vha->hw) && !IS_QLA27XX(vha->hw) &&
> -	    !IS_QLA28XX(vha->hw))
> +	    !IS_QLA28XX(vha->hw) && !IS_QLA29XX(vha->hw))

[Severity: Medium]
Does this change miss an update to the underlying mailbox execution functio=
n?

While qla2x00_do_dport_diagnostics() now allows QLA29xx adapters to proceed,
the lower-level function it calls, qla26xx_dport_diagnostics() in qla_mbx.c,
still appears to have the old hardware check:

drivers/scsi/qla2xxx/qla_mbx.c:qla26xx_dport_diagnostics() {
	...
	if (!IS_QLA83XX(vha->hw) && !IS_QLA27XX(vha->hw) &&
	    !IS_QLA28XX(vha->hw))
		return QLA_FUNCTION_FAILED;
	...
}

Will this cause the diagnostic command to unconditionally fail with
EXT_STATUS_MAILBOX for QLA29xx adapters despite the wrapper permitting it?

>  		return -EPERM;
> =20
>  	dd =3D kmalloc_obj(*dd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095333.1666=
592-1-njavali@marvell.com?part=3D44

