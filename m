Return-Path: <linux-scsi+bounces-24646-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tdwXNvdPKWrdUgMAu9opvQ
	(envelope-from <linux-scsi+bounces-24646-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 13:52:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC50668F91
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 13:52:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BASUUzo7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24646-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24646-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6773223933
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2026 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05D3E7151;
	Wed, 10 Jun 2026 11:45:31 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D53DB31A
	for <linux-scsi@vger.kernel.org>; Wed, 10 Jun 2026 11:45:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091931; cv=none; b=t8gCemgxOiazaNBLErbwN9mgVlm6FKCbcU4to6ltSc9S1vZRFvCGfKx2ePqfTMyIPqUW+Q2fPfHhC29dDuhmez1gfvir7Zc0/f7siGWgQp/vkwWd9gZVsSQGA+Mfh+nS8KPi+lptz56am8PpNVJuKWu/kgOmE9FHkhA0SuysCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091931; c=relaxed/simple;
	bh=iofbCknlK7p+ercG8I988m1tmILBqBh8o/nYmwyXPcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lu3P8qcQvgtrX/hAp3rfQx/NcW1HO+y93625kf9KLN/AMXpbc76+vKm6vrclvBruVfhp/KQoZ44Gosul+Q1EXxe6yHKvL1uqG7pHW/N7loZY4vyjz1NHEAwbw+z9bmeIAkbWFpdRagrGhZxojQZBfijmjEKtYFP14muC/lDTN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BASUUzo7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3B1F00893;
	Wed, 10 Jun 2026 11:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781091930;
	bh=VXv2RxHDTPsvB7YLxL66eNKBNczmdRxLXgVh2Gm2u0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BASUUzo7TjQ6nq2clu9CIsgxa8/3Oe8KUsPAmaQ8iGxBteroVvQR2rTnecoFANm4d
	 y1HX0f+tGhATEsgbiNWDH3L5THedRdb1ma3e0kG2oPCxljuWCkc6qxkx/7o7OE4k50
	 zSHyBTEk012V1ngRL7qB0sL1pQCeo5qPfPgtBSaY+7G7WgLG0F9f1QDCZuLIhsmvJ+
	 i9oOPf9eYgGA3Mh5gF/EhHtOaj3xSBpsDk2g8x6FPxQwmsOvg6qv685pSSYDEzeiuk
	 Yp+juyeR+q1MKzPUiZSb/PmNBSaRxwnXzFG9n6lApnh5mhTmRTEZRE9kPdfvwMHZ0D
	 Y53LOSmOyqG5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] scsi: core: pair EH runtime PM get/put
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongjie Fang" <hongjiefang@asrmicro.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260610113333.632859-1-hongjiefang@asrmicro.com>
References: <20260610113333.632859-1-hongjiefang@asrmicro.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 11:45:29 +0000
Message-Id: <20260610114529.BFF3B1F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24646-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hongjiefang@asrmicro.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,asrmicro.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DC50668F91

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The SCSI error handler thread enters an infinite, non-sleeping bus=
y-loop (100% CPU lockup) if `scsi_autopm_get_host()` persistently fails.
- [High] Concurrent modification of the `eh_noresume` bitfield without prop=
er locking causes data corruption of adjacent bitfields in `struct Scsi_Hos=
t`.
--

commit 3a9d1cff49c35df0198a4186d8f838a19d67f4d5
Author: Hongjie Fang <hongjiefang@asrmicro.com>

scsi: core: pair EH runtime PM get/put

This patch ensures that the runtime PM put in the SCSI error handler
is only executed if the corresponding get succeeded. It avoids a
runtime PM usage count underflow that can occur when the eh_noresume
flag changes concurrently.

> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 147127fb4db9c..c78ea64641a98 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
[ ... ]
> @@ -2383,12 +2384,16 @@ int scsi_error_handler(void *data)
>  		 * what we need to do to get it up and online again (if we can).
>  		 * If we fail, we end up taking the thing offline.
>  		 */
> -		if (!shost->eh_noresume && scsi_autopm_get_host(shost) !=3D 0) {
> -			SCSI_LOG_ERROR_RECOVERY(1,
> -				shost_printk(KERN_ERR, shost,
> -					     "scsi_eh_%d: unable to autoresume\n",
> -					     shost->host_no));
> -			continue;
> +		autopm_put =3D false;
> +		if (!shost->eh_noresume) {

[Severity: High]
This is a pre-existing issue, but could modifying the eh_noresume flag
without locking cause data corruption?

The eh_noresume flag is defined as a 1-bit bitfield in struct Scsi_Host
alongside other critical bitfields like tmf_in_progress:

include/scsi/scsi_host.h:
	unsigned tmf_in_progress:1;
	unsigned eh_noresume:1;
	unsigned no_write_same:1;

Since bitfield modifications are implemented as non-atomic read-modify-write
operations on the underlying word, modifying eh_noresume locklessly in paths
like ufshcd_set_dev_pwr_mode() can overwrite locked updates to adjacent
bitfields.

For example, if a concurrent thread is modifying tmf_in_progress under
the host_lock in scsi_ioctl_reset():

	spin_lock_irqsave(shost->host_lock, flags);
	shost->tmf_in_progress =3D 1;
	spin_unlock_irqrestore(shost->host_lock, flags);

Will the lockless write to eh_noresume silently drop the locked update
and potentially cause hangs?

> +			if (scsi_autopm_get_host(shost) !=3D 0) {
> +				SCSI_LOG_ERROR_RECOVERY(1,
> +					shost_printk(KERN_ERR, shost,
> +						     "scsi_eh_%d: unable to autoresume\n",
> +						     shost->host_no));
> +				continue;

[Severity: High]
This isn't a bug introduced by this patch, but does this continue statement
cause the error handler thread to spin in an infinite busy-loop if
scsi_autopm_get_host() fails persistently?

When the continue is taken, it bypasses the clearance of shost->host_failed
and the subsequent recovery steps. On the next iteration of
scsi_error_handler(), the condition for going to sleep evaluates to false
because host_failed was never cleared.

The thread then bypasses schedule(), sets its state to TASK_RUNNING, and
retries the autoresume immediately. If the PM failure is persistent, could
this lock up the CPU core at 100% utilization?

> +			}
> +			autopm_put =3D true;
>  		}
> =20
>  		if (shost->transportt->eh_strategy_handler)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610113333.6328=
59-1-hongjiefang@asrmicro.com?part=3D1

