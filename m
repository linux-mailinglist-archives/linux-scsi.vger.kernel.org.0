Return-Path: <linux-scsi+bounces-25015-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xRRPDvtJMWqFgAUAu9opvQ
	(envelope-from <linux-scsi+bounces-25015-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:04:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEE668FB8E
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 15:04:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eZPfcOHI;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25015-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25015-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8C733018CC8
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F96B36A375;
	Tue, 16 Jun 2026 13:04:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42C3644A2
	for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 13:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615065; cv=none; b=es3VDd+QoWfuk0UIX242RWn5wl1ZJIeU+rZKOYOaRhmERMd5Xgb8pNFeWC7JVRRa6Nhdey/FHvaxz1OSvTbKDWi6kFy6RTlVpreNR4hyMQN00zkSMcfMfhMno+91VKm8KFyxeI4AW2HDd3OeuNm0FSCPnrHFXC4lZunHdpx+na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615065; c=relaxed/simple;
	bh=4frCmTcGUF3HPN8NKDf4JMPM6hBHx22d9LlAnO999ig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VPaE0VJSGngibuVQtTQD8Q9dCV6mlExSmSAHi7EJkkK0JpFJNG9Cs9osmtvV8J/8RioQcoaYbQWVSFpkYhsDQfYQl+pTBmWkVbOc80Z6TRqveWBDlQxgNjuK2vjVgLTbCTYvHv5pXa63ZwYdgFspIeJYCOu6mOc6LI+TUEVeWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZPfcOHI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A220B1F000E9;
	Tue, 16 Jun 2026 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781615063;
	bh=tnshd8CkiOmhxlzjGYK//CXXCKt3z9PEAhqofPX1AZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZPfcOHIeAJQqyYahwtULVN9V6FG8JqSrG7dPdzho95aXW/olZKwS3h4sbwb2bIGi
	 zHSeCEvJOH5jfoT48XWkLUIqe79puyksFms0fDLm3MM90u4iE6Kt9D3T2qDKmv8ix6
	 kgAd+lOmrBij4nAAbBcAx1tv9tlcK0sGtYdu2zllIQEWDfqr96TJcqAapYMLj7ElR/
	 KSDABs797lxvaQx3W96zPbpF1zgdebu8mFXl26mkzlEdWbEodypO4ei5gbXpozJhsh
	 e9Yezd+av4XevmXnXgK0TEJ1s40l7oRnHyWdfzHDtmkt+CVfdKLuzfPlwNRVUrg7g7
	 IBE19L6hUSRgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: mptfusion: Fix array out of bounds error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Gladkov" <legion@kernel.org>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260616124528.319527-1-legion@kernel.org>
References: <20260616124528.319527-1-legion@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 13:04:22 +0000
Message-Id: <20260616130423.A220B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sashiko.dev:server fail,sin.lore.kernel.org:server fail,smtp.kernel.org:server fail,lists.linux.dev:server fail];
	TAGGED_FROM(0.00)[bounces-25015-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:legion@kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FEE668FB8E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete fix: Out-of-bounds array access in fusion sub-drive=
rs due to unclamped ioc->facts.NumberOfPorts
--

commit c993313579593bc432c039b88b1e748a26bc690c
Author: Alexey Gladkov <legion@kernel.org>

scsi: mptfusion: Fix array out of bounds error

The driver retrieves the number of ports from the hardware. However, the
driver can handle no more than two such ports. It uses a fixed array for
them.

> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mp=
tbase.c
> index 3a431ffd3e2eb..05bd556bb9383 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -3257,6 +3257,8 @@ GetPortFacts(MPT_ADAPTER *ioc, int portnum, int sle=
epFlag)
>  		return -4;
>  	}
> =20
> +	BUG_ON(portnum < 0 || portnum >=3D ARRAY_SIZE(ioc->pfacts));
> +
>  	pfacts =3D &ioc->pfacts[portnum];

[ ... ]

> @@ -6701,6 +6703,7 @@ static int mpt_iocinfo_proc_show(struct seq_file *m=
, void *v)
>  	char		 expVer[32];
>  	int		 sz;
>  	int		 p;
> +	int		 numberOfPorts =3D MIN(ioc->facts.NumberOfPorts, ARRAY_SIZE(ioc->p=
facts));
> =20
>  	mpt_get_fw_exp_ver(expVer, ioc);
> =20
> @@ -6755,7 +6758,7 @@ static int mpt_iocinfo_proc_show(struct seq_file *m=
, void *v)
>  	seq_printf(m, "  MaxBuses =3D %d\n", ioc->facts.MaxBuses);
> =20
>  	/* per-port info */
> -	for (p=3D0; p < ioc->facts.NumberOfPorts; p++) {
> +	for (p =3D 0; p < numberOfPorts; p++) {

[Severity: Critical]
This is a pre-existing issue, but by only capping numberOfPorts locally her=
e,
does this leave the rest of the fusion sub-drivers vulnerable to out-of-bou=
nds
accesses?

The unclamped ioc->facts.NumberOfPorts is still used in several loops across
the driver, where the bounds of statically sized arrays (like pfacts or
fc_port_page1, both size 2) are exceeded if hardware reports more than 2
ports.

For instance, in drivers/message/fusion/mptfc.c:mptfc_remove():

	for (ii=3D0; ii<ioc->facts.NumberOfPorts; ii++) {
		if (ioc->fc_data.fc_port_page1[ii].data) {
			dma_free_coherent(&ioc->pcidev->dev,
					  ioc->fc_data.fc_port_page1[ii].pg_sz,
					  ioc->fc_data.fc_port_page1[ii].data,
					  ioc->fc_data.fc_port_page1[ii].dma);

Since fc_port_page1 is size 2, if NumberOfPorts is 8, could this read
adjacent struct members of MPT_ADAPTER and pass them to dma_free_coherent(),
leading to arbitrary invalid frees and a kernel panic?

Similar loops iterating over pfacts exist in mptfc_probe(), mptsas_probe(),
mptspi_probe(), and mptlan_probe().

Would it be safer to clamp ioc->facts.NumberOfPorts directly after retrievi=
ng
it from firmware, so all sub-drivers are protected?

>  		seq_printf(m, "  PortNumber =3D %d (of %d)\n",
>  				p+1,
>  				ioc->facts.NumberOfPorts);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616124528.3195=
27-1-legion@kernel.org?part=3D1

