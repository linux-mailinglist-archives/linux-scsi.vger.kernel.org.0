Return-Path: <linux-scsi+bounces-25483-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lQ83AduxRmoqbwsAu9opvQ
	(envelope-from <linux-scsi+bounces-25483-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:45:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1D6FC43E
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dJUAhIJ/";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25483-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25483-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36D9630483E7
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2ED347FFE;
	Thu,  2 Jul 2026 18:11:37 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599F539DBF7
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 18:11:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015897; cv=none; b=eTu/pU81YS0HBO5XYklsu9o9PoxPQI+x2ynDWyHQCKUA5ahS+kXayZYvE0ynzL8QvprBCcSTlZDcXAjUdr0YqAiKrggY4AK6AIceoLV3NP9/nDAhKfnltMxz5yGQ1gEqx8YePqmOZkSguM5DcpUbBGfLPDESD7zFLJUcQa7RDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015897; c=relaxed/simple;
	bh=VKmDJYcixLqKm9xmJ7RpWcEZGft7Vw0NIa8x9ETs6yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lnSPdUjPsAr2CeSJDocwGGbvbgJzivGxoJrhTvB5MSA2PiYwUgzaEGdFpgz/TOGksXwFXStw8prCa48ZYBg8u8v34s7eMtUxoabevj8VXMr2s23MPvB4lpKlwhRWT+r9lflcKQ5OSN497b1Gsw40TPV0iFEw+1cs5pk45qMN/tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJUAhIJ/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E1D1F000E9;
	Thu,  2 Jul 2026 18:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783015896;
	bh=BrvLD9+rn1M5/Cbrj3q/7qlFjMmdGd7VWKGrxwHLfwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJUAhIJ/wX2L21RtjZ3+tOHVcGsm15eGoFyGQjPHTDfH7xNXS+ZmfVlo0dbIbxV2Q
	 i8yLl6swzBbwa/uYi+ms98eTH8lgXkIwIWzJY4LngiOqj/GyrPsRGf/RY03KpCkGKz
	 /vP5hdHMaZ0KKeenljDrzNSFvtOXIf3Vp5lbejAkxka8yrNEooHUc0Q+ZXMUh5dcDy
	 VPaFfeHXXUOZLxwwH+32hIH9GlVTmHgj/bk07ZRRwaayAc67rWlQjIctD8S1P/DNRZ
	 zFrUIPrORsCr5IXom0XUz+ULOIDY7Hvd7O7Gw60ROXnvdMNzOOmQ1Dx/RVGfgeNHkk
	 ddUxfvWaNDDgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] ibmvfc: Add NOOP command support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Marquardt" <davemarq@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260702-ibmvfc-fpin-support-v3-2-d95b9547cf88@linux.ibm.com>
References: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
 <20260702-ibmvfc-fpin-support-v3-2-d95b9547cf88@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:11:35 +0000
Message-Id: <20260702181135.D2E1D1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25483-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davemarq@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBB1D6FC43E

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incomplete and insecure VFC_NOOP handling in `ibmvfc_handle_scrq` =
leads to protocol bypass and potential data corruption.

Pre-existing issues:
- [High] Untrusted Pointer Dereference in `ibmvfc_handle_scrq` leading to k=
ernel panic.
--

commit 026aa88f6415105823a4b94ede2214dbab9c0f42
Author: Dave Marquardt <davemarq@linux.ibm.com>

    ibmvfc: Add NOOP command support
   =20
    This patch adds support for receiving and recognizing VFC_NOOP
    messages from VIOS. This is done by defining the VFC_NOOP CRQ format,
    recognizing the VFC_NOOP CRQ format in the CRQ handler, and setting
    the "can use VFC_NOOP" bit in the capabilities sent during NPIV login.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvf=
c.c
> index b63f41a6cfffd..110d77b9aac32 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c

[ ... ]

> @@ -4099,6 +4109,10 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *=
crq, struct ibmvfc_host *vhost
>  		return;
>  	}
> =20
> +	/* Some CRQs, e.g. a VFC_NOOP command CRQ, do not have an ioba, so evt =
is NULL. */
> +	if (!evt)
> +		return;
> +

[Severity: High]
Does this blanket check safely handle VFC_NOOP messages?

If the VIOS sends a VFC_NOOP message with a valid, non-zero ioba that
corresponds to an active SCSI command, the sub-CRQ handler bypasses the
if (!evt) check. It will proceed to validate the event and erroneously
complete the active SCSI command using the NOOP's payload.

Additionally, this blanket check silently drops any other malformed zero-io=
ba
CRQs without logging them, and bypasses the IBMVFC_SUPPORT_NOOP_CMD capabil=
ity
validation that is explicitly implemented in the main ibmvfc_handle_crq()
handler.=20

Should the Sub-CRQ handler explicitly verify crq->format =3D=3D IBMVFC_VFC_=
NOOP
exactly like the main handler does?

[Severity: High]
This is a pre-existing issue, but can the event validation later in
ibmvfc_handle_scrq() cause a kernel panic due to a wild pointer dereference?

The ioba is cast directly to the evt pointer. If the hypervisor or VIOS sen=
ds
a Sub-CRQ message with a malicious or uninitialized non-zero ioba value, evt
is dereferenced before it is validated:

drivers/scsi/ibmvscsi/ibmvfc.c:ibmvfc_handle_scrq() {
    ...
	if (unlikely(!ibmvfc_valid_event(&evt->queue->evt_pool, evt))) {
    ...
}

Could the struct ibmvfc_queue be passed directly to the handler so
scrq->evt_pool can be used for validation without dereferencing the
untrusted evt pointer?

>  	/* The only kind of payload CRQs we should get are responses to
>  	 * things we send. Make sure this response is to something we
>  	 * actually sent

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-ibmvfc-fpi=
n-support-v3-0-d95b9547cf88@linux.ibm.com?part=3D2

