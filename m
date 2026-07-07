Return-Path: <linux-scsi+bounces-25850-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CNKWHWKyTGpEoQEAu9opvQ
	(envelope-from <linux-scsi+bounces-25850-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 10:01:38 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2884718D04
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 10:01:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K9Yi8bJw;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25850-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25850-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C396D3129DD8
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6739769B;
	Tue,  7 Jul 2026 07:38:08 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CA13D53C
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:38:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409888; cv=none; b=Nec+NRwgZZetehEIrs0H9sYIpHnxeLiwW640zoaciCe5fx6Sy+XGKaTxmh7cVVxFZOElzRFugu4T3RXWohmAJUiFzqcZ1qRS0tPB0kqmHMsK9vxbHfgpc4LzJ1b9DtcFhKP/kNzFhMSFTljirPAxLEbjWU0Ezxggnc0pis8iIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409888; c=relaxed/simple;
	bh=Pq8gTWX6YESQQ58mQoXUz2qoz7ECp58m9x5iuG9f9yY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q/BGJpoAqSor2rfFULk4HgLtpQbcO7Q3ejOKo8VjNwN659O016DRDXfYqyyQNrFdyfts+eeVlkK0dXx20Bj6jqzEGcZ8OlIGkPSQxrW941VrnAA8Eb39af3z9ndu+qViRCBmUpB7dt7R3ulrTk3S9nqSBPugBzXwLqdky3zJ3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9Yi8bJw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC5F1F000E9;
	Tue,  7 Jul 2026 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409887;
	bh=KgBWFGnFHqJwIIAVFaJvRuPnkF/MykAzhZrboRXfF4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9Yi8bJwOSspcQKlc5RSuSNyfAT/C87fu/rnJaxcqa+mySKT6vQn72HVr8IkgE5Zn
	 AfgPGFi2jBvGf1IEEoceiWj4Uc/Yd4H6C6aNcWsYd0adDIEWF0CqA4zc/P8hnWPYbc
	 E2/yFUcL/KDBS0j51wX9id5KNj1eUtqWujrYahWXEaQiW2cVbMP4xLSGH1h2wA8i6I
	 fR8ed6n2HAjxbPopLCz+948nqrhh0xrCJZls8M1kPpTLW4KovkvCU0jU0tO9hDd28R
	 oPgopb7DdBI0yIDGfeeX7xjbxhsFp3SLkgzMoUPIpQT0B6lwzkC3m1/2ZEALGBZBUb
	 GsbPcM8AK0Www==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 80/88] scsi: qla2xxx: Skip NVMe LS reject IOCB when
 FW not started
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-81-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-81-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:38:06 +0000
Message-Id: <20260707073806.DBC5F1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25850-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2884718D04

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free and list corruption on NVMe LS response error p=
ath.
- [Critical] Concurrent lockless list manipulation of `fcport->unsol_ctx_he=
ad` across interrupt and process contexts.
- [High] Lockless read-modify-write bitfield race on `ha->flags` corrupts s=
tate and causes lost interrupts.
--

--- Patch [80]: [PATCH v3 80/88] scsi: qla2xxx: Skip NVMe LS reject IOCB wh=
en FW not started ---
commit 4b34d405682300e7feb89bc5e0c5433498c1683d
Author: Nilesh Javali <njavali@marvell.com>
Date:   Tue Jul 7 05:54:27 2026 +0000

scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started

This patch modifies the error paths in qla_nvme_xmt_ls_rsp() and
qla2xxx_process_purls_pkt() to check if the firmware is started before
sending an NVMe LS reject IOCB. This avoids ringing the doorbell and queuing
IOCBs when the firmware is stopped or resetting.

> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_n=
vme.c
> index fc8a344ec7d81..28a04e0ff660b 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -441,9 +441,11 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_=
port *lport,
>  	a.vp_idx =3D vha->vp_idx;
>  	a.nport_handle =3D uctx->nport_handle;
>  	a.xchg_address =3D uctx->exchange_address;
> -	spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
> -	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
> -	spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
> +	if (ha->flags.fw_started) {

[Severity: High]
This is a pre-existing issue, but does using a bitfield for ha->flags cause
read-modify-write races?

Looking at struct qla_hw_data, fw_started and mbox_int share the same 32-bit
word:

drivers/scsi/qla2xxx/qla_def.h:
	volatile struct {
		uint32_t	mbox_int		:1;
...
		uint32_t	fw_started:1;
...
	} flags;

Since qla2x00_abort_isp_cleanup() locklessly clears fw_started in process
context, and qla2x00_mbx_completion() sets mbox_int in interrupt context,
couldn't a concurrent update cause one of the flags to be lost and stall the
firmware initialization?

> +		spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
> +		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
> +		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
> +	}
>  	kfree(uctx);

[Severity: Critical]
This is a pre-existing issue, but does this error path leave a dangling
pointer in the fcport->unsol_ctx_head list?

When kfree(uctx) is called here, it doesn't appear to be removed from the
list via list_del(&uctx->elem). Later unsolicited requests could then attem=
pt
to use list_add_tail() on the corrupted list pointers of the freed block,
potentially leading to slab corruption.

>  	return rval;
>  }

[ ... ]

> @@ -1321,9 +1323,14 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vh=
a, struct purex_item *item)
>  		a.vp_idx =3D vha->vp_idx;
>  		a.nport_handle =3D uctx->nport_handle;
>  		a.xchg_address =3D uctx->exchange_address;
> -		spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr, flags);
> -		qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a, true);
> -		spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr, flags);
> +		if (vha->hw->flags.fw_started) {
> +			spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr,
> +					  flags);
> +			qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a,
> +						true);
> +			spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr,
> +					       flags);
> +		}
>  		list_del(&uctx->elem);

[Severity: Critical]
This is a pre-existing issue, but does this list manipulation require a=20
spinlock to prevent concurrent corruption?

The list_del(&uctx->elem) here executes in a workqueue context. At the same
time, qla2xxx_process_purls_iocb() adds to this list from the hardware
response queue ISR context:

drivers/scsi/qla2xxx/qla_nvme.c:qla2xxx_process_purls_iocb()
    INIT_LIST_HEAD(&uctx->elem);
    list_add_tail(&uctx->elem, &fcport->unsol_ctx_head);

Could overlapping unsolicited requests race between the interrupt and workq=
ueue
contexts and corrupt the prev/next pointers?

>  		kfree(uctx);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D80

