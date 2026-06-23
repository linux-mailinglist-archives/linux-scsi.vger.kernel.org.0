Return-Path: <linux-scsi+bounces-25172-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xwu7JhLqOWoDzAcAu9opvQ
	(envelope-from <linux-scsi+bounces-25172-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 04:06:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A97C6B37CC
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 04:06:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HFTmy1K6;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25172-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25172-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0833D30391D0
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 02:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A2B386553;
	Tue, 23 Jun 2026 02:05:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8F36F413
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 02:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180353; cv=none; b=A7KzjEbVrILIClNki5nmoj6yioJrSLRLZ2xiLqIZlZ+8ZWIehgZ6pcoEdc+lMek5Hpyx8CO/Tx9/gOogWNKwZ0gTjCExRaXetgBmnoOukBp5qn3xTI2y46AE4kFy5WqYfLbxwaO+zTvk8foNfjdd68g0XnrPwFKg1fSpcLHxlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180353; c=relaxed/simple;
	bh=6EX+XlSEhB82pzP96BUPZJAeYa7SmmB083lkDW2j2/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HpzM7pN8LJm1mSaLmDAGWZB8aOunploQ3dVTkf3luDQpQYky+EeetUbLStXgy0Ei39wUTT8cUXZHfz7JARbBFSFKwfED+ROT/kcQJDgs5/72wdkx9C2i6lmAglN9AKnTxwqGR6Panf/Zz8q9Dv0qGxvFHOG08YF+iWf5VRJgSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFTmy1K6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E57F1F00A3A;
	Tue, 23 Jun 2026 02:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782180352;
	bh=Riht7YZPphbCRVjjawQNFz70Q1GZCDcXzUOxS3QeVbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFTmy1K6LVy8c8uS8WpMmwHVnqrytuCEpjEW2hGkYat8Zy3Hk9zicQDiK547F7dPl
	 FUMyFHgsar4o5Fy/18RDt2zIa2lXf9XMPqNFy/BAwN+Pp/9zOZP/JIO4b133Ip2w1y
	 mMWwjmtu+6JsbsLk/MY9nI4zb1VrTkm5XxRQ+R1dHDKhviSFB3HJI6FUgWDPKmA6kE
	 gObZL4ZLop1pI3P1Hm0v/obrej/JZXYZdSeG3vWj2iyYbZo4HC0GgvsFN1D171G9uN
	 uMle45+NKV19dQDEpF339ebiFT/TWNcE76Yv2wbrfV/FzQ0RRYKW6hi+13DJCtgnPm
	 8YITsgp+Rbt6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/29] ibmvfc: implement LLDD callbacks for mapping
 nvme-fc queues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-25-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-25-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 02:05:52 +0000
Message-Id: <20260623020552.6E57F1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25172-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A97C6B37CC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless double-read of `vhost->nvme_scrqs.active_queues` can caus=
e a division-by-zero kernel panic.
--

commit fd68a3e765846c041d31997c784f4e4a733bb8aa
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: implement LLDD callbacks for mapping nvme-fc queues

This commit implements the NVMe-FC queue create and delete callbacks. It ma=
ps
NVMe controller queues onto ibmvfc hardware queues using the qidx.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/=
ibmvfc-nvme.c
> index fc4337fc9b3fb..1108d11d6b2db 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c

[ ... ]

> @@ -28,6 +28,40 @@ static void ibmvfc_nvme_remoteport_delete(struct nvme_=
fc_remote_port *rport)
>  	complete(&tgt->nvme_delete_done);
>  }
> =20
> +static int ibmvfc_nvme_create_queue(struct nvme_fc_local_port *lport, un=
signed int qidx,
> +				    u16 qsize, void **handle)
> +{
> +	struct ibmvfc_host *vhost =3D lport->private;
> +	struct ibmvfc_nvme_qhandle *qhandle;
> +
> +	if (!vhost->nvme_scrqs.active_queues)
> +		return -ENODEV;
> +
> +	qhandle =3D kzalloc_obj(struct ibmvfc_nvme_qhandle);
> +	if (!qhandle)
> +		return -ENOMEM;
> +
> +	qhandle->cpu_id =3D raw_smp_processor_id();
> +	qhandle->qidx =3D qidx;
> +
> +	/* Admin and first IO queue are both mapped to index 0 */
> +	if (qidx)
> +		qhandle->index =3D (qidx - 1) % vhost->nvme_scrqs.active_queues;

[Severity: High]
Could a lockless double-read of vhost->nvme_scrqs.active_queues lead to a
division by zero?

If a concurrent host reset or channel setup failure sets active_queues to 0,
it seems the compiler could reload the value for the modulo operation since
the memory allocation acts as a compiler barrier.

Would reading active_queues once into a local variable prevent a potential
kernel panic here?

> +	else
> +		qhandle->index =3D qidx;
> +
> +	qhandle->queue =3D &vhost->nvme_scrqs.scrqs[qhandle->index];
> +
> +	*handle =3D qhandle;
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D24

