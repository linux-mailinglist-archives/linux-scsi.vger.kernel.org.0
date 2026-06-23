Return-Path: <linux-scsi+bounces-25164-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eFsWCa7nOWqnywcAu9opvQ
	(envelope-from <linux-scsi+bounces-25164-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:55:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC66B36FD
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b+pb9h9x;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25164-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25164-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF5430607A0
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21303386C15;
	Tue, 23 Jun 2026 01:55:06 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AC385D99
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jun 2026 01:55:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179705; cv=none; b=T+YuYLBWm4qsLWYF90Lg8rqBCwEIG/1BaKpiHoytr3q7j+GYbd0JbjMGQqCyVbCOf8B4ItYTd4xCwdXbxFnm11/SKpSh02cUFgetvkGS4WZdgecj+hbMDzSpgChlKUQnTw49FryRBW6iTvuH4QcnzEuJ7uFsJ1FQaNT5Rej6dq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179705; c=relaxed/simple;
	bh=P3Ibs+YEPwCWN4Olq/7LvGWInWZh+WqvE0RxNtGa5D0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hFqPeNLVNZVS8dad2HtmVaAyN8tfGi8I8NphZrpcuhWZJ5lziAPiMvkroDgEZXvJfXpDsbDrdP8eZZ5GfecVgGp9PJPPBWimDq4Dv8hTyx2TwddBEea0HIHGp91BL61JkCcJtM+9PUVAS4+xfbGO6tNRBpl8wkVdlLxkSL6IRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+pb9h9x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F02A1F000E9;
	Tue, 23 Jun 2026 01:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179704;
	bh=xAMDvAKDiuPTE2XsiG3pVnO6dvj48OSykmPNRn4PKng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+pb9h9xnvpU6AxK6UqmWtbsGex2Vyul5cGrDwgrwafPcappse3eqVHNS51HBXNg/
	 v7Zdtx2YAmJRgPI9aA0htdf/08kCIy/kjeOmbVkavGKXpF5HjN+Mhl+zXbOufnuGdO
	 mYK9WjPyE284+Stq4zgJ7DoyqPFgUWNMwZlgYc47QXWhV+/Y4NY5ED7ccVJnzPYNNJ
	 5m0z7I0iWRGB6OG86f9WmNtVxLzFrj9Bioz5P9pMiGlgMEVJcfbBsOVJgC1mdN5FMH
	 v2DhsEEyYfSqTuKydmvwct+3fg/VR8UmrcYP7fXBR/+reKv4ErLYPlRqGxVZRyz9hA
	 A17oNhZbtp66w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/29] ibmvfc: alloc/dealloc sub-queues for nvme
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tyrel Datwyler" <tyreld@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260623013035.3436640-6-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
 <20260623013035.3436640-6-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 01:55:04 +0000
Message-Id: <20260623015504.9F02A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25164-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DFC66B36FD

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Failure to register NVMe sub-queues silently disables SCSI multiqu=
eue support due to a shared state flag.
--

commit 6eb0f2ef7c51067f6c97ea8c13211afa2e19dcc4
Author: Tyrel Datwyler <tyreld@linux.ibm.com>

ibmvfc: alloc/dealloc sub-queues for nvme channels

This patch allocates, registers, deregisters, and releases NVMe subordinate
CRQs alongside the existing SCSI sub-CRQs. It integrates the NVMe queue
lifecycle with the existing SCSI queue lifecycle to ensure both protocols
are reset consistently.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/=
ibmvfc-core.c
> index 5732ccf2ac1c0..6f5e8b3cbfc82 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c

[ ... ]

> @@ -6109,6 +6113,13 @@ static void ibmvfc_init_sub_crqs(struct ibmvfc_hos=
t *vhost)
> =20
>  	ibmvfc_reg_sub_crqs(vhost, &vhost->scsi_scrqs);
> =20
> +	if (vhost->nvme_enabled) {
> +		if (ibmvfc_alloc_channels(vhost, &vhost->nvme_scrqs))
> +			vhost->nvme_enabled =3D 0;
> +		else
> +			ibmvfc_reg_sub_crqs(vhost, &vhost->nvme_scrqs);

[Severity: High]
Does a failure to register NVMe sub-queues unintentionally disable SCSI
multiqueue support here?

If ibmvfc_reg_sub_crqs() fails while registering the NVMe channels, it hand=
les
the error by unregistering the partial channels and setting a shared host f=
lag:

ibmvfc_reg_sub_crqs() {
    ...
    if (ibmvfc_register_channel(vhost, channels, i)) {
        for (j =3D i; j > 0; j--)
            ...
        vhost->do_enquiry =3D 0;
        return;
    }
}

Since ibmvfc_reg_sub_crqs() is now called for NVMe right after successfully
registering the SCSI sub-queues, setting vhost->do_enquiry to 0 upon an NVMe
registration failure will cause the driver to skip channel enquiry during t=
he
NPIV login sequence.=20

Will this cause the successfully registered SCSI channels to be silently
ignored if the hypervisor rejects the NVMe sub-crqs allocation?

> +	}
> +
>  	LEAVE;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623013035.3436=
640-1-tyreld@linux.ibm.com?part=3D5

