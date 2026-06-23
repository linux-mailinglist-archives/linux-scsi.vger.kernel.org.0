Return-Path: <linux-scsi+bounces-25153-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0VmtNmTnOWqYywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25153-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:54:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4676B36CC
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:54:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XjdM7JuP;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25153-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25153-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEDE93052882
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E1336729C;
	Tue, 23 Jun 2026 01:50:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD217BEBF
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:50:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179407; cv=none; b=p9yUQgc1NNne34/HcWVuyaKXeWAvzkx4qVdID07T8QdFY86rK70LwletlyhSIUzODQjlm6htgKZu6sI27Mui0S/T5L9X3pyiXuo9YzlZXQPimLesUP20GUnOUrUb4nRngStneZVnG7TqvzsIlMleH88AQxJUzVoDXtDOa1xZzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179407; c=relaxed/simple;
	bh=vpZ52mvRS1JEAJYjCvvQHlcW4Dm7GZaevGhhSxc/yDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oSUPlTXxFb7ZDuDRwOl3CQZmlpNMTPHp9P1+5KEX8wFu/bFdnz/6eYCJJmco758ntMUHggwUMnglHKkMQVQAfQkTy6e8TpSREpnCE0M0eT0bmAUWyRNKc5wF+szW6qSa7yWvuGXhvLe8tb1CC3AoWs5EY5gehaweFF+nujAwKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjdM7JuP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD4E1F000E9;
	Tue, 23 Jun 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179405;
	bh=mf6UuUAPtwmMoXFNUGbTo0ykNGecPyJEL21VQ6ekln8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjdM7JuPtVSXXzbLgScnR48GaVyVALZuskp1+xRsNkqgMxKAl7US62jdv3JyHkPYk
	 1KiX5f/mKB1xNAtUzyOp0lGCA60AlIkQ04SkCvLEtM0rSUlUL2psgztcI5m2fneG7F
	 7vNaf6OoE+iC4GopWmitmw4rj8Qv2+2/TSHNOTjDhOoQ3yL3FI5WXAr4+n0F7rB0U2
	 Yrhm3ePy6VQaor6fGDQxwzhMnUaffG/cG7UHvBJIT80NpyD5UigTfjYQiXfJozCSHD
	 I+egQBxI381zkLHrDo5lhnxa1eVPmgskITz8W+sEr7Tg+xUzT1odL4XvzicBgY/Yhh
	 O9R4kp1NQK0sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/29] ibmvfc: split NVMe support into separate source
 file and add transport stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-4-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-4-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:50:05 +0000
Message-Id: <20260623015005.9AD4E1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25153-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C4676B36CC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver misuses the NVMe-FC transport private data API by overw=
riting the `fcp_req->private` pointer instead of storing data within the al=
located memory, leading to a kernel panic during AEN teardown.
--

commit ff3f397be994beea2b3c34de8ca81ef76dd5fe89
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: split NVMe support into separate source file and add transport stubs

Rename ibmvfc.c to ibmvfc-core.c as first step in decoupling each
protocol from the core driver logic. Add ibmvfc-nvme.[ch] files, and
register an nvme_fc_port_template with empty callback stubs.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-nvme.c b/drivers/scsi/ibmvscsi/=
ibmvfc-nvme.c
> new file mode 100644
> index 0000000000000..4a66cde8a8d20
> --- /dev/null
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-nvme.c
[ ... ]
> +static struct nvme_fc_port_template ibmvfc_nvme_fc_transport =3D {
> +	.localport_delete	=3D ibmvfc_nvme_localport_delete,
> +	.remoteport_delete	=3D ibmvfc_nvme_remoteport_delete,
> +	.create_queue		=3D NULL,
> +	.delete_queue		=3D NULL,
> +	.ls_req			=3D ibmvfc_nvme_ls_req,
> +	.ls_abort		=3D ibmvfc_nvme_ls_abort,
> +	.fcp_io			=3D ibmvfc_nvme_fcp_io,
> +	.fcp_abort		=3D ibmvfc_nvme_fcp_abort,
> +	.map_queues		=3D NULL,
> +	.max_hw_queues		=3D IBMVFC_NVME_HW_QUEUES,
> +	.max_sgl_segments	=3D 1024,
> +	.max_dif_sgl_segments	=3D 64,
> +	.dma_boundary		=3D 0xFFFFFFFF,
> +	.local_priv_sz		=3D sizeof(struct ibmvfc_host *),
> +	.remote_priv_sz		=3D sizeof(struct ibmvfc_target *),
> +	.lsrqst_priv_sz		=3D sizeof(struct ibmvfc_event *),
> +	.fcprqst_priv_sz	=3D sizeof(struct ibmvfc_event *),

[Severity: High]
Will this misconfigure the transport private data API?

The NVMe-FC core allocates an 8-byte private data area for AEN requests usi=
ng
kzalloc() in nvme_fc_init_aen_ops() based on the fcprqst_priv_sz requested
here.

If the driver later overwrites the fcp_req->private pointer directly with a
statically allocated ibmvfc_event pointer (e.g., fcp_req->private =3D evt;)
instead of storing it inside the allocated memory space, this will lead to a
kernel panic.

During controller teardown (e.g., device removal or transport error recover=
y),
nvme_fc_term_aen_ops() calls kfree(aen_op->fcp_req.private). Because the
pointer would have been overwritten, kfree() is called on the non-kmalloc'd
event pointer, resulting in a SLUB bug and memory leak.

> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D3

