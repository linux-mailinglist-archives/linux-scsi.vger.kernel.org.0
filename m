Return-Path: <linux-scsi+bounces-25167-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WiAwMhroOWq6ywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25167-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:57:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AFB6B373F
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gzq9EmsW;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25167-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25167-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB7BB3004DB0
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A037B40E;
	Tue, 23 Jun 2026 01:57:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99622256F
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:57:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179861; cv=none; b=hzzncXrfc94OggnUqSskSrhajCbS9vmkPwerGeP9ktHrjvGDjh9KD1bgXl+1iI8rT0qxmoqyftDyckQI/3bzSQJITmhq5OkR/V8pN8/MQLDCSC+vngLEg2qfRZCHcdX5FupIoGhEgF8EBiopFozjOOyF6+7/rg9zDKQgASS4FWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179861; c=relaxed/simple;
	bh=fuBm59fsVLDgjFePmg7GQgHAUp34Dp9Q3fwxUqTJ3Qg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ahzz2Q0SF7Li5kgl6m7DVfU/u8vTKiipwsG/R26Si5syR9cfuygs3fplronCyldBx5tsOMWxHDcFE5Q9taHqooO5ddEiQwC4Ne3FDXpN2YRMiPRrl79ODdwfurM1EASNI+XXwXBXLCzmpxordqRUEKU1d8CbpKW0gXmoAvgLMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzq9EmsW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54E41F000E9;
	Tue, 23 Jun 2026 01:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179860;
	bh=hTc7ysipV2p1wPeNWto+I2gmEd2M52GvmesaD4A23ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gzq9EmsWSqXz20aO/bwbfOJC3X5HSNdDXi7X2sCxsLSaBy1x9AjFRPJeAzJa4uA7M
	 qk4PXUcw/YgbbagKfK337sMKYlpTDhUUsYT5MX9esawOnCDHqbm/PHFhGmA1q9szU1
	 CTZGHcdGcNtKiVlunWlJ7s0omzRqnztWNB/nJhJ53OaigBMyAlg8x0O4Lqy0ZKTCV9
	 Q9Fq+DD2ywS6/pzlZ8SHCPTEqn5WittQnOol9IsTh6G762gNayeJY6/1xHECVTxtyv
	 XB/78TO7ZRwuH3Lvfzvit3gL6cWhUTwvFhG4xgMt5Juu6riqWbL+NHYe6nS9g2Xxrt
	 w1k6eWkcaVfNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/29] ibmvfc: register local nvme fc port after fabric
 login
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-21-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-21-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:57:38 +0000
Message-Id: <20260623015739.E54E41F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25167-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tyreld@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5AFB6B373F

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Guaranteed NULL pointer dereference in `ibmvfc_nvme_unregister()` =
upon successful local port unregistration.
- [High] Permanent memory, device reference, and state leak due to uncondit=
ional NVMe local port registration without teardown.
- [High] Sleeping in atomic context bug by calling `nvme_fc_register_localp=
ort()` from a CRQ response handler.

Pre-existing issues:
- [High] Guaranteed NULL pointer dereference in `ibmvfc_nvme_unregister_rem=
oteport()`.
--

commit 84b5a798e09cfb51baf820040579b6001b3aae40
Author: Tyrel Datwyler <tyreld@linux.ibm.com>
Date:   Tue Jun 23 01:30:26 2026 +0000

ibmvfc: register local nvme fc port after fabric login

Register the local NVMe/FC port only after fabric login has completed.
The VIOS returns the client port ID in the fabric login response, and
that port ID is required to populate the local-port information passed
to the NVMe-FC midlayer.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/=
ibmvfc-core.c
> index 9a6a885aa57ed..2c7ecf7bdde93 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> @@ -5184,6 +5184,8 @@ static void ibmvfc_fabric_login_nvme_done(struct ib=
mvfc_event *evt)
> =20
>  	switch (mad_status) {
>  	case IBMVFC_MAD_SUCCESS:
> +		fc_host_port_id(vhost->host) =3D be64_to_cpu(rsp->nport_id);
> +		ibmvfc_nvme_register(vhost);

[Severity: High]
Does this code sleep in atomic context?

It looks like ibmvfc_fabric_login_nvme_done() is executed as a callback
from ibmvfc_locked_done(), which holds the host_lock spinlock with
interrupts disabled:

ibmvfc_locked_done() {
    spin_lock_irqsave(evt->vhost->host->host_lock, flags);
    evt->_done(evt);
    spin_unlock_irqrestore(evt->vhost->host->host_lock, flags);
}

The callback invokes ibmvfc_nvme_register(), which calls the NVMe FC midlay=
er
function nvme_fc_register_localport(). This midlayer function makes GFP_KER=
NEL
allocations, which could lead to deadlocks or panics when atomic sleep chec=
ks
are enabled.

Additionally, does this introduce a permanent resource leak?

This function unconditionally registers a new NVMe local port upon every
successful fabric login. These logins can happen repeatedly during probe,
adapter resets, or network link flaps. Since it never unregisters the
previously registered port before grabbing a new device reference, it
appears the memory, device references, and NVMe transport state will leak.

>  		ibmvfc_dbg(vhost, "NVMe fabric login succeeded\n");
>  		break;
>  	case IBMVFC_MAD_FAILED:

[ ... ]

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/=
ibmvfc-nvme.c
> index 202e8d0b00813..fc4337fc9b3fb 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c

[ ... ]

> @@ -154,9 +157,18 @@ void ibmvfc_nvme_unregister(struct ibmvfc_host *vhos=
t)
>  	int rc;
> =20
>  	if (vhost->nvme_local_port) {
> +		ibmvfc_log(vhost, 2, "unregister_localport: host-traddr=3Dnn-0x%llx:pn=
-0x%llx on portID:%x\n",
> +			   vhost->nvme_local_port->node_name,
> +			   vhost->nvme_local_port->port_name,
> +			   vhost->nvme_local_port->port_id);
>  		init_completion(&vhost->nvme_delete_done);
>  		rc =3D nvme_fc_unregister_localport(vhost->nvme_local_port);
> -		if (!rc)
> +		if (!rc) {
>  			wait_for_completion(&vhost->nvme_delete_done);
> +			vhost->nvme_local_port->private =3D NULL;

[Severity: High]
Can this dereference a NULL pointer?

The completion for port deletion is signaled by the midlayer callback
ibmvfc_nvme_localport_delete(), which explicitly clears the local port
pointer:

ibmvfc_nvme_localport_delete() {
    vhost->nvme_local_port =3D NULL;
    complete(&vhost->nvme_delete_done);
}

When wait_for_completion() returns here, vhost->nvme_local_port is
guaranteed to be NULL, meaning the assignment to private will
unconditionally cause a crash.

> +		} else
> +			dev_err(vhost->dev, "Failed to unregister NVMe fc localport (%d)\n", =
rc);
> +
> +		put_device(vhost->dev);
>  	}
>  }

[ ... ]

> static void ibmvfc_nvme_unregister_remoteport(struct ibmvfc_target *tgt)
> {
> 	if (tgt->nvme_remote_port) {
> 		init_completion(&tgt->nvme_delete_done);
> 		nvme_fc_unregister_remoteport(tgt->nvme_remote_port);
> 		wait_for_completion(&tgt->nvme_delete_done);
> 		tgt->nvme_remote_port->private =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this suffer from the same NULL
pointer dereference issue as the local port unregister function?

Similar to the local port, the completion is signaled by
ibmvfc_nvme_remoteport_delete(), which sets tgt->nvme_remote_port =3D NULL
before completing. This means tgt->nvme_remote_port will be NULL when the
wait finishes, leading to an unconditional crash here during target teardow=
n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D20

