Return-Path: <linux-scsi+bounces-25488-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SBSHJh2sRmpvbQsAu9opvQ
	(envelope-from <linux-scsi+bounces-25488-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:21:17 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FE6FBF28
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 20:21:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BvRtq572;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25488-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25488-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BFA53042309
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979C394498;
	Thu,  2 Jul 2026 18:20:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE683A5438
	for <linux-scsi@vger.kernel.org>; Thu,  2 Jul 2026 18:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783016445; cv=none; b=d2iNWYut3YRXvhMWhxupAwkAhKiTG6SMoMdaHh0me0Gdr9UqUvtjkJrA0kV6NHWud5EEQykF6lNDVZcZDXeDnUjCUz9tqPiNOd6H/+VvO8yl5ZQZ9siLBb9v3vgECXuyaxLGBq3WqU1XBTcTvzmu3cqDpdzDaNFG1iYUznn5Rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783016445; c=relaxed/simple;
	bh=tNwu2yQvH4DNYCLyg0jlWZ5zlzJSpgJ8GZaXnkmlLHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H2qASn7CFw1igVDzIqT8zN+plMTbKcmleGRcF2iAX4te9V9fgkhijBYAJEbMkPXCpq7EUv8JPiPSE+q/FVyDuhORGrFXkbFpJN3mNxCS1zThfJZmkKRw7qJTbgjpsj/yXvGV4gTx/rMeFxgMJ16gHgVau9YL5wHhs8YusPYt7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvRtq572; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F991F000E9;
	Thu,  2 Jul 2026 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783016443;
	bh=SLLeDXBNN7c6/oEPwapgAu/C3Jhf2XPlvpPCwcIWn4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BvRtq572FIWaYD+TMsy4AFdLWFiaQ9o/bLN5/MXyO4VMag+7tpDbf9GMDmc4WIWYN
	 cildLOCgHLjeeoXPVMIAlBQAT22eeDphzXIZ9Puuz4B53jKzRvOLIybWcm5dVsboJ1
	 8/RutVIvwdyoZbGRNSjLr0Npk1RADs8cviun5lWEwbhwwwTJiD27hQmnqZeMMIYTyL
	 +Sol/9ycS7Ia5a198fAj9lmq+FyzgzxiW+mOVozjORC+hM4pfKNWNu8UvHEvRdMfA4
	 5XfnEVGBSwRKFRvXfVirLndzGa8fF3FZz8iryZz38A9Vby1p9n/FSwVwC7EbqdRfvN
	 H+t3nFaU1XAEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] ibmvfc: allocate asynchronous sub-queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Marquardt" <davemarq@linux.ibm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260702-ibmvfc-fpin-support-v3-5-d95b9547cf88@linux.ibm.com>
References: <20260702-ibmvfc-fpin-support-v3-0-d95b9547cf88@linux.ibm.com>
 <20260702-ibmvfc-fpin-support-v3-5-d95b9547cf88@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:20:42 +0000
Message-Id: <20260702182043.78F991F000E9@smtp.kernel.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25488-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davemarq@linux.ibm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D72FE6FBF28

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The dynamically allocated `channels->async_scrq` structure is leak=
ed during channel release in `ibmvfc_release_channels()`.
- [High] Potential unconditional dereference of `async_scrq` in `ibmvfc_cha=
nnel_setup_done()` when handling unexpected VIOS responses with MQ disabled.
--

commit ef672833546c2244a424ddb37eeea81b2e000303
Author: Dave Marquardt <davemarq@linux.ibm.com>

ibmvfc: allocate asynchronous sub-queue

Allocate and set up the asynchronous sub-queue for asynchronous
events, as required for full and extended FPIN support.

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvf=
c.c
> index 6dd1e726d9b94..804887fb56357 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc.c
> @@ -5371,6 +5371,8 @@ static void ibmvfc_channel_setup_done(struct ibmvfc=
_event *evt)
>  			for (i =3D 0; i < active_queues; i++)
>  				scrqs->scrqs[i].vios_cookie =3D
>  					be64_to_cpu(setup->channel_handles[i]);
> +			scrqs->async_scrq->vios_cookie =3D
> +				be64_to_cpu(setup->async_subq_handle);

[Severity: High]
Does this code dereference a NULL pointer when MQ is disabled?

If vhost->mq_enabled is false, ibmvfc_alloc_channels() is skipped, leaving
scrqs->async_scrq as NULL. However, vhost->do_enquiry remains 1.

If the VIOS returns the IBMVFC_CAN_SUPPORT_CHANNELS capability,
ibmvfc_channel_setup() will be invoked with 0 channels and send
IBMVFC_CANCEL_CHANNELS. If the VIOS returns a success status but
unexpectedly omits the IBMVFC_CHANNELS_CANCELED flag in its response,
the driver falls through to the block containing this assignment.

Could this crash the kernel if the VIOS firmware responds unexpectedly?

[ ... ]

> @@ -6437,6 +6459,10 @@ static void ibmvfc_release_channels(struct ibmvfc_=
host *vhost,
> =20
>  		kfree(channels->scrqs);
>  		channels->scrqs =3D NULL;
> +
> +		ibmvfc_free_queue(vhost, channels->async_scrq);
> +		channels->async_scrq =3D NULL;
> +

[Severity: High]
Does this code leak the memory allocated for async_scrq?

In ibmvfc_alloc_channels(), async_scrq is allocated with kzalloc_obj().
During teardown here, ibmvfc_free_queue() correctly releases internal queue
resources, but kfree() is missing before setting the pointer to NULL.

Should kfree(channels->async_scrq) be called here similar to how
kfree(channels->scrqs) is handled above?

>  		channels->active_queues =3D 0;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-ibmvfc-fpi=
n-support-v3-0-d95b9547cf88@linux.ibm.com?part=3D5

