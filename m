Return-Path: <linux-scsi+bounces-25986-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q2hYNtpJUWrZBwMAu9opvQ
	(envelope-from <linux-scsi+bounces-25986-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:36:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1073DD9D
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:36:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="cyU1/CJP";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25986-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25986-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D5793006F26
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B62857FA;
	Fri, 10 Jul 2026 19:36:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20E233920
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 19:36:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712214; cv=none; b=NmfTfoj8Mr6n9uhrDJ3CO08056QIEf6smi4XBIs0UBjlimxTM10Llpe2epJzqi3tmDcKqrqLFzYOBSykKzYxunC6HmP70JAzLkzxUw+3FeIqVumyGWP/a2GaivCS5n1O9k0LsU7TUBdl54lqmY3q0dvergCDPunCdiGKKNMjWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712214; c=relaxed/simple;
	bh=0Ptd+Bmm/nxpEShgJVGF8I3IQU0Zku0OEXl9jqSJYGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaWhVbmx1WLPX7Gh7xA/P0N9s8Zun06R9Fd6hkCBjq1eFPdMbjfSGc/T6bPF8TCX4/GJytn4mrNBkK3UHYArfasul7ceUjXvLd0Iy1tv49eY8boJq+K4Vj1h3H1pfHyEeVyuhax2zUHTrVI6FrNuViRcz0rIKNFM6/RJePUM2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyU1/CJP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482921F000E9;
	Fri, 10 Jul 2026 19:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712213;
	bh=oDioHje5rJ5p23dzw7/aYB5pJJBEbcwUErxMAl8dFXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyU1/CJPfIjMVxZ+7X47dN3r+4WpUCtUzAS2D6T7MJNT8DeuGtKxr7u1FPvogqnHb
	 2flIiw4/GQzhznnh/Hs2X32rtakBmyhB6Q4YPjSMQuOGNSQiNtFSgj0CTa5z0fQIh8
	 T3qPC2lHn7mROUpO080sIQhW7e4Hh1Gd72bYzsCzOuOEGiKgaoi0CmNuqvaRDlbhFL
	 eikrSWxoCXcJu+Mi6q2KeZXW/Rzt407j2j0SsCcZAsKGY63BNW5fhrNKFUrebcsBZQ
	 GTpHPREdgUIFFfpZ7dsNQd1pGGPRpwlXcrfqAqk97qb2WW2Nck4AQsBsH1I5ML1H2W
	 mZFyf7x2cIRYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/8] ibmvfc: allocate asynchronous sub-queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Marquardt" <davemarq@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260710-ibmvfc-fpin-support-v4-5-ef031ac19520@linux.ibm.com>
References: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
 <20260710-ibmvfc-fpin-support-v4-5-ef031ac19520@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 19:36:52 +0000
Message-Id: <20260710193653.482921F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25986-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BD1073DD9D

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly allocated asynchronous sub-queue (`async_scrq`) is never=
 registered with the hypervisor, leaving its cookie uninitialized and the q=
ueue non-functional.

Pre-existing issues:
- [High] Unprotected dereference of queue pointers in `ibmvfc_channel_setup=
()` leads to a kernel panic if MQ is disabled or if queue allocation fails.
--

--- Patch [5]: [PATCH v4 5/8] ibmvfc: allocate asynchronous sub-queue ---
commit d243c6fd5b265f83cb24c3737fb1dfe6fd989a93
Author: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc: allocate asynchronous sub-queue

This commit allocates and initializes an asynchronous sub-queue required for
receiving full and extended FPIN events from the VIOS.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvf=
c.c
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c

[ ... ]

> @@ -5425,6 +5428,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host=
 *vhost)
>  		setup_buf->num_scsi_subq_channels =3D cpu_to_be32(num_channels);
>  		for (i =3D 0; i < num_channels; i++)
>  			setup_buf->channel_handles[i] =3D cpu_to_be64(scrqs->scrqs[i].cookie);
> +		setup_buf->async_subq_handle =3D cpu_to_be64(scrqs->async_scrq->cookie=
);

[Severity: High]
This is a pre-existing issue, but does this code unconditionally dereference
the queue pointers?

If MQ is disabled or if queue allocation fails in ibmvfc_alloc_channels(),
scrqs->scrqs and scrqs->async_scrq are left as NULL.

If the VIOS subsequently indicates channel support in its capabilities,
ibmvfc_channel_setup() is called and these unallocated pointers are
dereferenced here, which would result in a kernel panic.

Could we add a check to ensure the queues were successfully allocated before
dereferencing them during channel setup?

[ ... ]

> @@ -6392,6 +6396,17 @@ static int ibmvfc_alloc_channels(struct ibmvfc_hos=
t *vhost,
>  	if (!channels->scrqs)
>  		return -ENOMEM;
> =20
> +	channels->async_scrq =3D kzalloc_obj(*channels->async_scrq, GFP_KERNEL);
> +	if (!channels->async_scrq) {
> +		rc =3D -ENOMEM;
> +		goto free_scrqs;
> +	}
> +
> +	rc =3D ibmvfc_alloc_queue(vhost, channels->async_scrq,
> +				IBMVFC_SUB_CRQ_FMT);
> +	if (rc)
> +		goto free_async;

[Severity: High]
Is this missing a step to register the asynchronous sub-queue with the
hypervisor?

The queue is allocated here and mapped in memory, but it doesn't appear to
be registered via h_reg_sub_crq() anywhere.

Because it is never registered, its cookie remains 0, meaning an
uninitialized handle is sent to the VIOS during ibmvfc_channel_setup(),
and no hardware IRQ is mapped or requested, which renders the async queue
non-functional.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-ibmvfc-fpi=
n-support-v4-0-ef031ac19520@linux.ibm.com?part=3D5

