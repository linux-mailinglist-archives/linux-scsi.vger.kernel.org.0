Return-Path: <linux-scsi+bounces-24813-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4+IzLCPgK2ptGwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24813-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:32:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC5678B4A
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:32:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MoK585Xc;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24813-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24813-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D400030570C3
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C03403F8;
	Fri, 12 Jun 2026 10:31:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6432C94A
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 10:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260286; cv=none; b=R+T6wQpf3qGQDziPmUbTknMo6lvPLwhsWcZlO+d4G9dp/TKv9XwgaSxnT9+eYGZ6nTi+htsRy4/RXR3cXQnc+dYwIxWZVuWrRGCuvvRQB2mQm8j03s7b+MouKFOj0uMCefy0EeM8WiR8wRqb7CEVR7nObSwqHk7zHM/MMKxh99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260286; c=relaxed/simple;
	bh=I+CN31V87DubDqac+c0H8gIx9bdv6GZIhM5IxxddeW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OGuvaaY3VUynPG1iuIquIOoHGD9HFvqcqFkfkalhVBgcvthDocNYo0afgMWX8cASuzoJzjkRdnr9d5acOSeDmtryFZGsrhRBvx0VDnx7HuJwMFChkPeJbzdMtaD9/YJFuYatpJzgKyfZe6NsECkftXLV6/WtGw4xmMi2MsIIAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoK585Xc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73A71F000E9;
	Fri, 12 Jun 2026 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781260284;
	bh=b/xwQZ567t2VHYKO+ag4PogFhKCw1aKLejMYGFAIBKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoK585Xc5c/a6xQh9+W4FQZqpmSoez8DYcnhSvXFwWmb6naxLA2kaPkFzGDlannf+
	 pQcciXLLFc7uYds4123rXJpmEJNzsF20Pd8NzgOIeBUItogjD/nHmdnTuv4aNE3i+T
	 HAgP0QSCdHNLhKuf2x0JOnN3yoXAo2kO/CSVi9+OrRxkZaUX9c0Xl2+zQz/sibF7Wn
	 lpIim+/nnqPx4AJVUgZL2AMJ9YjIFKymlGRxjuHw73cvUaodPOLwY9yYyFLSCgrKxa
	 DE3h3cOQZdUPxMhzfuJwBhL+foS/WWi2GkU3KMzxbiOMex/ODq3mJ7OWEIEYbOCTDJ
	 glnK9rV/dfpzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/60] scsi: qla2xxx: Enable get_fw_version mailbox
 for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260612095333.1666592-17-njavali@marvell.com>
References: <20260612095333.1666592-17-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:31:24 +0000
Message-Id: <20260612103124.C73A71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24813-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,marvell.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BDC5678B4A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `fw_attr` sysfs attribute is not exposed for 29xx adapters d=
ue to a missing IS_QLA29XX check.
--

commit 87a8bb4cf363158a780d18c48d9c990e59d3d1aa
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Enable get_fw_version mailbox for 29xx

The serdes_version and several firmware capability fields were not
populated for 29xx because the get_fw_version mailbox path
excluded it from the 27xx/28xx checks.  Add IS_QLA29XX() to
the relevant conditionals so that firmware version, EDIF, and
serdes information are correctly retrieved on 29xx adapters.

> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_a=
ttr.c
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
Since this sysfs attribute export is updated to include 29xx, should
qla2x00_fw_attr_show() be updated as well?

It looks like qla2x00_fw_attr_show() still has a hardcoded check that
will hide the fw_attr sysfs attribute for 29xx adapters:

drivers/scsi/qla2xxx/qla_attr.c:qla2x00_fw_attr_show() {
	...
	if (!IS_QLA27XX(ha) && !IS_QLA28XX(ha))
		return scnprintf(buf, PAGE_SIZE, "\n");
	...
}

I noticed that similar omissions for mpi_version and pep_version were fixed=
 by
subsequent patches later in the series, but it appears the fix for fw_attr =
was
missed and it remains broken at the end of the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095333.1666=
592-1-njavali@marvell.com?part=3D16

