Return-Path: <linux-scsi+bounces-25155-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PbNJOcLnOWqsywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25155-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:56:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAEB6B3714
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:56:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iAaiVX9c;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25155-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25155-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F5AE304DFD9
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D30379C2F;
	Tue, 23 Jun 2026 01:51:03 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861C370AC7
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:51:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179463; cv=none; b=Q+pGA+3bvyYgMekE4Wd8chKSa4cIEMqt3yPnet+h6KVXW2HepCp4Y6oWk4qe2qBrnuJXkc2zKjrzgjJAEYCxpvDtpTfB6H/4CLRFnY8NRjL2TcSyayU0ySJ/natmpuRpvrBs+3qzeIE2gZNhpXwBRklMZ5h/EBxu0NNBD+aFsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179463; c=relaxed/simple;
	bh=pla9Mw1Cb53gbubsX6mS+25ADI5tSVTUe0ci4sI+vgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q74C3F7K4t3T3ATevALWMEf9yMXaZEOaxwVvSZbyjminFqC0wDfmyKAcOmUYUKo9PPuDZC4Sw86K7YDSq8Ymx+Iv4eluzCLgvMleJdEeIJIL7Sli04zoQPpi1Q5wMK8HPr/dajDLwakzWk7umBHSHGxvdBrIVW8YDhTooGEBiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAaiVX9c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCBF1F000E9;
	Tue, 23 Jun 2026 01:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179462;
	bh=x2VTV3E9/Z40anRuC0Mvac9006BiFQMgREWTeF2Hf9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAaiVX9cWNBfe5JwozSEXz36VHyQIdUeHJj5Qr5WvbyjaZhpCFtt8qnEfG81XUnvx
	 GP8p1bYUYeYFPufrRblEXDs8zVXS/SdhfvEC/leXlHpUmaMCovaEzKGqMRmykeG0Nm
	 9QmqT2oGuiBZTFHpFUTCmbRO/Av36ah3mU4AwuS6S4WQO6DXXSkxCObdXW/c3xMiKd
	 CMnaNpSuFlcMKhJVTsNXV5hQnuRgbblkJuXJNrZXnJi7PsCWwCZytHonL3bewMgZ9E
	 gg5ocBBbhnVlOAcz5sQE5QuLBKAEQDtYFnTxPo9VwFxg1MmtpNjowFeVggIqKg1Ckh
	 jsdftxg2Zzo/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/29] ibmvfc: implement NVMe/FC stubs for local/remote
 port registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-20-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-20-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:51:01 +0000
Message-Id: <20260623015101.EBCBF1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25155-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tyreld@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CAEB6B3714

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional NULL pointer dereference in NVMe-FC local and remote=
 port unregistration paths.
--

commit 70b1c2d3d0ca257b156db2ba118e3a6f944e519d
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: implement NVMe/FC stubs for local/remote port registration

Implement the initial NVMe/FC local-port and remote-port registration
functions that notify the NVMe-FC midlayr of port discovery and loss.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/=
ibmvfc-nvme.c
> index 4a66cde8a8d20..202e8d0b00813 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
> @@ -14,10 +14,18 @@
> =20
>  static void ibmvfc_nvme_localport_delete(struct nvme_fc_local_port *lpor=
t)
>  {
> +	struct ibmvfc_host *vhost =3D lport->private;
> +
> +	vhost->nvme_local_port =3D NULL;
> +	complete(&vhost->nvme_delete_done);
>  }
> =20
>  static void ibmvfc_nvme_remoteport_delete(struct nvme_fc_remote_port *rp=
ort)
>  {
> +	struct ibmvfc_target *tgt =3D rport->private;
> +
> +	tgt->nvme_remote_port =3D NULL;
> +	complete(&tgt->nvme_delete_done);
>  }

[ ... ]

> @@ -70,18 +78,85 @@ static struct nvme_fc_port_template ibmvfc_nvme_fc_tr=
ansport =3D {
> =20
>  int ibmvfc_nvme_register_remoteport(struct ibmvfc_target *tgt)
>  {

[ ... ]

>  void ibmvfc_nvme_unregister_remoteport(struct ibmvfc_target *tgt)
>  {
> +	struct ibmvfc_host *vhost =3D tgt->vhost;
> +	struct nvme_fc_remote_port *rport =3D tgt->nvme_remote_port;
> +	int rc;
> +
> +	if (!tgt->nvme_remote_port)
> +		return;
> +
> +	ibmvfc_log(vhost, 2, "unregister_remoteport: traddr=3Dnn-0x%llx:pn-0x%l=
lx PortID:%x\n",
> +		   rport->node_name, rport->port_name, rport->port_id);
> +	init_completion(&tgt->nvme_delete_done);
> +	rc =3D nvme_fc_unregister_remoteport(tgt->nvme_remote_port);
> +
> +	if (!rc) {
> +		wait_for_completion(&tgt->nvme_delete_done);
> +		tgt->nvme_remote_port->private =3D NULL;

[Severity: High]
Does this code unconditionally dereference a NULL pointer?

When nvme_fc_unregister_remoteport() finishes, the asynchronous delete
callback ibmvfc_nvme_remoteport_delete() is called. This callback executes:

    tgt->nvme_remote_port =3D NULL;
    complete(&tgt->nvme_delete_done);

After waking up from wait_for_completion(), tgt->nvme_remote_port will
always be NULL, meaning the access to tgt->nvme_remote_port->private will
cause a kernel panic.

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D19

