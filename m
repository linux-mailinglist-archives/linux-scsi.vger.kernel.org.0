Return-Path: <linux-scsi+bounces-25984-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oR/QCUpJUWqbBwMAu9opvQ
	(envelope-from <linux-scsi+bounces-25984-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:34:34 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EF73DD3E
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 21:34:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HrpjKqEP;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25984-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25984-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A0473056CB6
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D02E7394;
	Fri, 10 Jul 2026 19:31:11 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82342C11CA
	for <linux-scsi@vger.kernel.org>; Fri, 10 Jul 2026 19:31:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711871; cv=none; b=Ha3kAz2P5PR6ky4MHAQV7uHDlQgLkHsB0zROxcgKKJwb4t37rejg/um4VuzRvVXurt+MvUA4bqiB+lGkeg3Gg2VR3ojRWhf4F4kko8mNoEiT+irVLTnbJNe8tnMOuJCNzih32gKrePQtakJ/hbz27tI7UUYz/TfUKA9KZmshQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711871; c=relaxed/simple;
	bh=N3FvxSwW4WXFJ+t3hq1tnWh3KDwCwI73QJQsuRnwo68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dET8GSNcjRWYyzY7h7z5N0aGbZaAjRaDfQSTthK0AGKEOsZsZGg8v0KsQCOTGU7r5EvnHEeBUd8aQ199bcN2U3gXlq+NQYgVa79RaXYofbc2D15j3w4ps8BG+Imm9qc/yxCXw3J7fgxlh8Njn0zamTwJHrEcPEKX1R7NqQwAjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrpjKqEP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540AA1F000E9;
	Fri, 10 Jul 2026 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783711870;
	bh=pjkpytcZrf1vAWkND8GzNPXLQACBvxrKINIQm5bawRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HrpjKqEPc410bkiBKHp1kpQVvGBD4FJBDyLHM1LdXs0y674T94f+WyfZlqloro9o0
	 sVeh6zP6V90p0oS+msqt6BVujWUEbB/J+IRUxq+l+WcAXF1yHxEXHtWVyfqrgGL6IB
	 YhiYp0cSBf/7KZDBuyjiCIfGC29NE4wVqiD6lILSZUEwFIUaWvcPYYRh2cpnmyQhu7
	 aljsTjsXIfxylWEnzWuto5U/HUhQHGyeuZN+1uT+0cEDUkSNy6HlB/X0DmJwBx23d0
	 qqjGh++nEVvU111jClJ9O3QWggtawvkJdUzHVoTaPT5Si4mc7yyZeLPuYbwT2zM7Mo
	 vjvo2atUYGQtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/8] ibmvfc: Add NOOP command support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Marquardt" <davemarq@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260710-ibmvfc-fpin-support-v4-2-ef031ac19520@linux.ibm.com>
References: <20260710-ibmvfc-fpin-support-v4-0-ef031ac19520@linux.ibm.com>
 <20260710-ibmvfc-fpin-support-v4-2-ef031ac19520@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 19:31:09 +0000
Message-Id: <20260710193110.540AA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25984-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davemarq@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D26EF73DD3E

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The logic for logging unexpected NOOP messages contradicts the c=
ommit message due to a state check that suppresses early NOOP logs.

Pre-existing issues:
- [Critical] In `ibmvfc_handle_scrq`, an unvalidated or forged `crq->ioba` =
token from the VIOS causes a kernel panic or arbitrary code execution becau=
se it is cast to an `evt` pointer and dereferenced before validation.
--

--- Patch [2]: [PATCH v4 2/8] ibmvfc: Add NOOP command support ---
commit 06afd3b464e63134568df7f26e9d5bc73cb9e427
Author: Dave Marquardt <davemarq@linux.ibm.com>
Subject: ibmvfc: Add NOOP command support

This commit adds support for VFC_NOOP messages from VIOS to enable keep-ali=
ve
functionality between the client and server. It sets the
IBMVFC_CAN_USE_NOOP_CMD capability bit during NPIV login and defines the
VFC_NOOP CRQ format handling.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvf=
c.c
> index d3fd1d3437c69..a7e3b7ee06835 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -3569,6 +3571,14 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *c=
rq, struct ibmvfc_host *vhost,
>  	if (crq->format =3D=3D IBMVFC_ASYNC_EVENT)
>  		return;
> =20
> +	if (crq->format =3D=3D IBMVFC_VFC_NOOP) {
> +		if (vhost->state =3D=3D IBMVFC_ACTIVE &&
> +		    !ibmvfc_check_caps(vhost, IBMVFC_SUPPORT_NOOP_CMD))
> +			dev_err_ratelimited(vhost->dev,
> +					    "Received unexpected NOOP command from partner\n");

[Severity: Medium]
Does this logic contradict the commit message? The commit message states we
should log unexpected NOOP messages if received before VIOS advertises
support during NPIV login.=20

However, checking if the host state is IBMVFC_ACTIVE appears to actively
suppress the error log if the host is still initializing during NPIV login.
Any NOOP messages received in the pre-login window would silently fail this
check and be dropped without logging.

> +		return;
> +	}
> +
> [ ... ]
> @@ -4095,7 +4105,15 @@ static void ibmvfc_handle_scrq(struct ibmvfc_crq *=
crq, struct ibmvfc_host *vhost
>  	case IBMVFC_CRQ_XPORT_EVENT:
>  		return;
>  	default:
> -		dev_err(vhost->dev, "Got and invalid message type 0x%02x\n", crq->vali=
d);
> +		dev_err(vhost->dev, "Got an invalid message type 0x%02x\n", crq->valid=
);
> +		return;
> +	}
> +
> +	if (crq->format =3D=3D IBMVFC_VFC_NOOP)
> +		return;
> +
> +	if (unlikely(!evt)) {
> +		dev_err(vhost->dev, "Received null event\n");
>  		return;
>  	}

[Severity: Critical]
This is a pre-existing issue, but can an unvalidated or forged token from
the VIOS cause a kernel panic or arbitrary code execution here?

In ibmvfc_handle_scrq(), the token is cast directly to an evt pointer.
Before evt is validated using ibmvfc_valid_event(), it appears the code
accesses evt->queue->evt_pool.

If the token is maliciously crafted, could dereferencing evt->queue cause a
page fault? Furthermore, could a fake queue structure in guest memory bypass
the bounds check, allowing a forged event to be placed on the queue and
executing arbitrary code when evt->done(evt) is called later in
ibmvfc_drain_sub_crq()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-ibmvfc-fpi=
n-support-v4-0-ef031ac19520@linux.ibm.com?part=3D2

