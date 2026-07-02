Return-Path: <linux-scsi+bounces-25484-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tFD8ORqqRmoQbQsAu9opvQ
	(envelope-from <linux-scsi+bounces-25484-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:12:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D96FBE1A
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:12:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lrTX3K+9;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25484-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25484-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A804301DC21
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC14349AE6;
	Thu,  2 Jul 2026 18:12:40 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44A339844
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 18:12:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015960; cv=none; b=P4cCQdOHVynWswGAgCx7qMX3gePKWNeB8745N/fFU4bbl13mQki+IE+6NasNMSWP14a0rpiYGt4dpWib1+XXZoLRvF8S32wjSzzcc+2trbxmVH0Swnm8zEMESZ9reae5G492MuHOF2i9xrBHIBrkDgLSQKsx3gRZip9fHm6OLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015960; c=relaxed/simple;
	bh=CIZn3dO5QhDJHu+kv56fAnzazmnxF80XAtWODXedGx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bLUG1a/8qkot6Fduok8o/P+KLmGZpxbBrala2khkwL95RYkxvHyg8CUJqqrLzyUaBtXShUL/NYsHiP8ldPzCX4WJ/vj+9MWiLcgvijX/ZZfweIwPFs/nJXAQAoIa+HHKrr8FqMi5wxFw4l5PhXIRZJwidGc5otsR8T/6bSnQwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrTX3K+9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22AF1F000E9;
	Thu,  2 Jul 2026 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783015959;
	bh=e8XcgFjZpAWEq9zbP/2tdrVEIEAq7zbK3BppP/QpJQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrTX3K+9Dz7yEiMEDatS+E/+mQlN36gOGsfLmhlS19zSaLBqDvCcNcYTQp/k4KUdG
	 WiUDcNNGGPG5GPIXhMbuUJcpNsHSAYLUOfmdzYxV9yd2ojomAMIlMA4dYKlM9VjCDI
	 aMTGBhdGENUOOnb1C2ylsuWP3/BdDezdzl32lJeXxfMsVTnZRNONNrdIC9t1gUkwWC
	 oCAg1E9GR9UmQ6cweImlMfAxufnkG/otb712LTjbAPrhcvceMV7ZS/bYhZoBggS1KD
	 XIn4XL+GlLKB2H5jCXEUigK/HhffTWhAhPec32ckDzC9q97iyIgOP6dYfgqkcUsxe8
	 W0KwocqkMhIxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] ibmvfc: define asynchronous sub-queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Marquardt" <davemarq@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260702-ibmvfc-fpin-support-v3-4-d95b9547cf88@linux.ibm.com>
References: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
 <20260702-ibmvfc-fpin-support-v3-4-d95b9547cf88@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:12:38 +0000
Message-Id: <20260702181238.C22AF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25484-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davemarq@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 568D96FBE1A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the driver reads=
 `setup->num_scsi_subq_channels` directly from a hypervisor-modified DMA bu=
ffer without validating it against the allocated size of the internal queue=
 array, leading to a potential heap buffer overflow.
--

commit caceab058540895b7bcd0e5a48d2dfd281f362ec
Author: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc: define asynchronous sub-queue

Defines the asynchronous sub-queue structure, modifies the existing
channel setup structure, adds the asynchronous sub-queue to the
channels structure, and adds flags needed to tell VIOS to use the
sub-queue.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvf=
c.h
> index adfd67e85af86..f38dfae9924ca 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.h
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.h
[ ... ]
> @@ -579,6 +581,7 @@ struct ibmvfc_channel_setup {
>  	struct srp_direct_buf buffer;
>  	__be64 reserved2[5];
>  	__be64 channel_handles[IBMVFC_MAX_CHANNELS];
> +	__be64 async_subq_handle;

[Severity: High]
This isn't a bug introduced by this patch, but since the driver reads
setup->num_scsi_subq_channels directly from a hypervisor-modified DMA buffe=
r,
could this lead to a potential heap buffer overflow?

Looking at drivers/scsi/ibmvscsi/ibmvfc.c:ibmvfc_channel_setup_done():

	active_queues =3D be32_to_cpu(setup->num_scsi_subq_channels);
	scrqs->active_queues =3D active_queues;
	...
		for (i =3D 0; i < active_queues; i++)
			scrqs->scrqs[i].vios_cookie =3D
				be64_to_cpu(setup->channel_handles[i]);

If the VIOS partition responds with an unexpectedly large value for
setup->num_scsi_subq_channels, would the driver write out of bounds into the
queue array without validating against the allocated size?

>  } __packed __aligned(8);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-ibmvfc-fpi=
n-support-v3-0-d95b9547cf88@linux.ibm.com?part=3D4

