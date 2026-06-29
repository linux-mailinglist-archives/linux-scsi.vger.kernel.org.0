Return-Path: <linux-scsi+bounces-25336-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aBnTG/eaQmoi+gkAu9opvQ
	(envelope-from <linux-scsi+bounces-25336-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 18:19:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABD6DD3E1
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 18:19:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="FinHKI/c";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25336-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25336-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25B0C300601D
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jun 2026 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD03F5BEE;
	Mon, 29 Jun 2026 16:16:37 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3F44BCAA
	for <linux-scsi@vger.kernel.org>; Mon, 29 Jun 2026 16:16:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749797; cv=none; b=S6Y0AJ3xRsKTevhVe5Qfezlt8ya0MeR8xKStp3IcB7giLF7k4V7SUHM4FBXJL6egTlO0T68shN58qSZc9kKDfV3Yh7qmf2ssdaW9jscYDk3nE6Y5TbILDIIpyynN5fTxmMX2Jtukh6cJRAckz20bJIJ6nKAebQst2d4B7Tc6ZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749797; c=relaxed/simple;
	bh=rlcW7DSb/o3N7xersyrYOLTEWYGAVhb8YF3C/tjcu1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YBf+AzuHHDEl8K8SWQ694ofsGG8Pk7fhuK5yBeBLh7zZbM9qXYA4GKyXgh/7WZwR/Lp/+cYM8QnW9MBfwwZuN07hmPS3RsGxdiiQJTj4thBAN6w6Bk3xUdOX4dUupIhHvOSUYQjPQp2Qy4Qjm78NtGlfxcahqPrpg8ygBjCs/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FinHKI/c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1791F000E9;
	Mon, 29 Jun 2026 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782749796;
	bh=+M+pueJeAvWVlUMuMT40BL4xUC0SiRR0BPWc0sLAq40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FinHKI/c/rqSou/Lhi0dT5onkgp6lNgMeuqioH+2Yee+4p7xRls1/PG13OeeQOkE/
	 tsqG31GBpoicsS9kAhZZaTgydxAAEjlbnPVRFbNiCzjVZ/0oUQRhRecfHq7FXRPFOg
	 As/BaegoJeYIY62bCvJ57yrO+Vn3/sRv63O1tYZwv+IN1jTbLSROwcWnH8D3ZZ+Vm8
	 Ze1umRjJhgZEtb7tnVGTEwaVGxBpVShGCRDj4hulUCwynR3m3PzwdrDbPWk6+PFG7y
	 wc3e2cIDqm1n5n52Qhw8LnuFWS/CC6bPmAuRvUA3YnB7+X4JJZkn/cRghKUqgwqBCM
	 VtRfXCNV4iMig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: lpfc: Add NULL check for vport in
 lpfc_dev_loss_tmo_callbk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Nagare" <nagarevaibhav@gmail.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260629160557.586208-1-vnagare@redhat.com>
References: <20260629160557.586208-1-vnagare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 16:16:34 +0000
Message-Id: <20260629161635.5E1791F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25336-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nagarevaibhav@gmail.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EABD6DD3E1

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch causes a reference count leak for the `ndlp` node list e=
ntry and the remote port device `rport` by clearing their association point=
ers without dropping their respective references.
- [Low] The patch introduces build failures due to an undeclared variable `=
iflags` and a non-existent struct member `ndlp->lock`.

Pre-existing issues:
- [High] The patch misdiagnoses the root cause of a crash as a simple NULL =
pointer dereference and worsens an existing Use-After-Free race condition b=
y attempting to lock and read from an already-freed `ndlp` object.
--

commit 26e4dbf45e788bb3e83d872e9f277d137a11dde1
Author: Vaibhav Nagare <nagarevaibhav@gmail.com>
Subject: scsi: lpfc: Add NULL check for vport in lpfc_dev_loss_tmo_callbk

This commit attempts to fix a kernel NULL pointer dereference in
lpfc_dev_loss_tmo_callbk() when ndlp->vport is NULL during FC remote
port deletion. It adds a NULL check, logs the teardown state, clears
the node pointers, and returns early.

> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hb=
adisc.c
> index bfc2442dd74a5..7c487508916e3 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -118,6 +118,22 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
>  		return;
> =20
>  	vport =3D ndlp->vport;
> +	if (!vport) {
> +		/*
> +		 * Vport is NULL - this can happen during teardown when the
> +		 * vport has been destroyed but the rport final delete is
> +		 * still processing. Clear the association and return.
> +		 */
> +		pr_err("lpfc: Null vport on ndlp %p, DID x%06x rport %p\n",
> +		       ndlp, ndlp->nlp_DID, rport);

[Severity: High]
This isn't a bug introduced by this patch, but if ndlp->vport is NULL, does
that indicate the ndlp object has already been freed?

Since vport is typically set during node allocation and never legitimately
cleared, wouldn't evaluating it as NULL mean we are dealing with freed
memory? If so, does dereferencing ndlp->nlp_DID here log from already-freed
memory, exacerbating the use-after-free race condition?

> +
> +		spin_lock_irqsave(&ndlp->lock, iflags);

[Severity: Low]
Are iflags and ndlp->lock defined in this context?

Looking at lpfc_dev_loss_tmo_callbk(), iflags does not appear to be
declared. Additionally, looking at struct lpfc_nodelist, it doesn't seem to
have a lock member. Could this cause a build failure?

> +		((struct lpfc_rport_data *)rport->dd_data)->pnode =3D NULL;
> +		ndlp->rport =3D NULL;
> +		spin_unlock_irqrestore(&ndlp->lock, iflags);
> +		return;

[Severity: High]
Does returning here leak the references for the ndlp and rport objects?

The existing teardown code lower in this function handles unloading like
this:

    if (vport->load_flag & FC_UNLOADING) {
        put_node =3D rdata->pnode !=3D NULL;
        ...
        rdata->pnode =3D NULL;
        ndlp->rport =3D NULL;
        if (put_node)
            lpfc_nlp_put(ndlp);
        ...
    }

By clearing the association pointers here without invoking
lpfc_nlp_put(ndlp) and put_device(&rport->dev), will we permanently leak
these references?

> +	}
> +
>  	phba  =3D vport->phba;
> =20
>  	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629160557.5862=
08-1-vnagare@redhat.com?part=3D1

