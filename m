Return-Path: <linux-scsi+bounces-25835-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZrtVJzOrTGp3nwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25835-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:30:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5B71877E
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:30:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IcxCcPzW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25835-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25835-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B3C3112C9F
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708AE3E9F76;
	Tue,  7 Jul 2026 07:22:18 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA63E5A07
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:22:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408935; cv=none; b=aqXZ4lMZR+K41aMNuAnN/eN/h80Lmug1Tt+0PlW8y09YWPeb/gC6U2j7uM1kRmhiN5t/IIFWMoYtxV8Dw5gfeXNgpt4Yyn81qYuKc7OZPZTrJG6MZ8+IsrnJ4K6vEuHnsbsQk+XrQDef/kyt3HJ8lmMKwxPxgeAFVoj13qjk9DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408935; c=relaxed/simple;
	bh=Kd0jDlMkJ2EBgRA4013BUtNRIy7U2svbfXKeS1ylDSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KfRVSbsUpGTRiHDsqde5BY2kNulRkelLOsn59YuEVX39cFSDRNPD1M+iPJUMOEkd/pT3RA+fT/49ESH6ajtawlhXJ4EVdZ3HeIkvYxS+q8Q3makWsHcLHtJUbqpiU0MIJzdAi7uxmRjEvZ5JAyUqLFmzQiD7jvqg2fd1J6qtCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcxCcPzW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE311F000E9;
	Tue,  7 Jul 2026 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408923;
	bh=RcaqWTvJLY8NvtVFjZA32Hdei+5INZVAq3SsXTpML8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IcxCcPzWYIoW2gd8YROa5NYIzL0P9ZEaEEcOoSXprsDynsNra9Pq0wfuGPWkumw39
	 Ygp74ubqP6hJLPrMzEwO0+q38LXiOy08pQpsXnTR3veZVKGp1tYmIDAuiFX+4P47TC
	 RI03D5pqeM1dju0ZI1dIYbFUhYY2OSk4CChp7OHgEkhNXcT1cjMdvPukIzgXwKr2M2
	 A0R8bwEMGDsrgT2ELAjbKBTwRNRCaVcxhSRg44gmzEGn/cAdosaBYCl0uhxRJ2q8lK
	 nAgWSAJUgGqpgARpAzzjzgzsuOqtiuzhXinUfbZfzGy1Tsun2qil5aKFsb3i9+WE6r
	 oAvHfNaBCt4Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 72/88] scsi: qla2xxx: Quiesce response IRQ before
 freeing request queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-73-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-73-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:22:02 +0000
Message-Id: <20260707072203.3EE311F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25835-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3D5B71877E

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Lockless early clearing of `rsp->msix->in_use` creates a race cond=
ition that leads to an IRQ double-free and cross-qpair interrupt hijacking.

Pre-existing issues:
- [High] Use-after-free of `rsp->req` in the `qla2xxx_create_qpair` error p=
ath.
- [High] Use-after-free on `qp->buf_pool.buf_map` during queue teardown due=
 to early `qla_free_buf_pool`.
--

--- Patch [72]: [PATCH v3 72/88] scsi: qla2xxx: Quiesce response IRQ before=
 freeing request queue ---
commit ae81f8a97822c69143d672e39645c29cff10e16e
Author: Nilesh Javali <njavali@marvell.com>
Subject: scsi: qla2xxx: Quiesce response IRQ before freeing request queue

This patch quiesces the response IRQ and flushes pending work before freeing
the request queue in qla2xxx_delete_qpair(). This prevents a regression whe=
re
late completions could dereference a freed request queue.

Fixes: d74595278f4a ("scsi: qla2xxx: Add multiple queue pair functionality.=
")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>

> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_i=
nit.c
> index 76b7ed501b04e..d678e27213a94 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -10686,11 +10686,28 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *=
vha, struct qla_qpair *qpair)
>  {
>  	int ret =3D QLA_FUNCTION_FAILED;
>  	struct qla_hw_data *ha =3D qpair->hw;
> +	struct rsp_que *rsp =3D qpair->rsp;
> =20
>  	qpair->delete_in_progress =3D 1;
> =20
>  	qla_free_buf_pool(qpair);

[Severity: High]
This is a pre-existing issue, but by calling qla_free_buf_pool() here, the
buf_map and other arrays are freed before the interrupt is disabled and
pending work is flushed. If a late hardware completion arrives during this
window, could qla_do_work() process it and invoke qla_put_buf()?

If that happens, does this code execute clear_bit(dsc->tag,
qp->buf_pool.buf_map) on the freed memory?

> +	/*
> +	 * The response-queue interrupt schedules qla_do_work(), which
[ ... ]
> +	 * firmware queue-delete order (request then response) is kept.
> +	 */
> +	if (rsp && rsp->msix && rsp->msix->have_irq) {
> +		free_irq(rsp->msix->vector, rsp->msix->handle);
> +		rsp->msix->have_irq =3D 0;
> +		rsp->msix->in_use =3D 0;

[Severity: High]
Does clearing rsp->msix->in_use here without holding ha->mq_lock prematurely
expose the msix_entry to reallocation?

If a concurrent qla2xxx_create_qpair() allocates this entry for a new queue
pair and requests the IRQ, it will set msix->have_irq =3D 1.

When this teardown path subsequently reaches qla25xx_free_rsp_que(), it
evaluates the shared struct and could incorrectly execute free_irq() on the
new queue pair's active IRQ handler. Should we wait to clear in_use until t=
he
original teardown path is fully complete?

> +		rsp->msix->handle =3D NULL;
> +	}
> +	if (rsp && ha->wq)
> +		cancel_work_sync(&qpair->q_work);
> +
>  	ret =3D qla25xx_delete_req_que(vha, qpair->req);
>  	if (ret !=3D QLA_SUCCESS)
>  		goto fail;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the
fix for the teardown path, I noticed a similar issue in the error path of
qla2xxx_create_qpair():

drivers/scsi/qla2xxx/qla_init.c:qla2xxx_create_qpair() {
[ ... ]
fail_mempool:
	qla25xx_delete_req_que(vha, qpair->req);
fail_req:
	qla25xx_delete_rsp_que(vha, qpair->rsp);
[ ... ]
}

If a failure occurs after the queues are created, the request queue is freed
while the response queue's interrupt is still active. Can an interrupt fire
here and schedule qla_do_work(), leading to a dereference of the freed
rsp->req in qla24xx_process_response_queue()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D72

