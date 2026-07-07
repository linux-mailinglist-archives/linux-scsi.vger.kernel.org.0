Return-Path: <linux-scsi+bounces-25834-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hiedMkGpTGopnwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25834-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:22:41 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E30AE7186A5
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:22:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c9fX0OT1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25834-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25834-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82B533013D58
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18B3D6CCF;
	Tue,  7 Jul 2026 07:21:52 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736833ACA43
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:21:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408909; cv=none; b=PlTvtdvIoZWiQEe1LOOzOwJeZDD47TCs1LmhY4Tba96nRuyxxuya6GieI/Hq5YgLt7jal4lJAwSnbF+98kQ01CK517XzUB9xm0sRMqMgpsy3w5GL+Yhs/lWPMAJiS7hVHQL+3AywB2PJ/gZ8qNJSH8EhfaXxH1Oa81vbSxsXRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408909; c=relaxed/simple;
	bh=NGbUWvRj4fhe66zt0q3+4tko5yJPvB4+Wj53fQc27Y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=boyv5vK//iUZrZCUCOCy6Ds7q5iIgraZa3sxM3C43AASA08zvxdzoPfsgWSTMM2AgXI9KHinN2wHn1MagOaqqns5JALs3R67M7GXEEPMAyhlxGKvSejvKgNdvxbMmYQ76o1Rb92eueLxcNgfTVzu1ERNUzKGE4ctXvQVPsKxf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9fX0OT1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63E1F00ACA;
	Tue,  7 Jul 2026 07:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783408896;
	bh=AbU2MhciiCTyv+gPvqzycwdA7yqAPhNzeLqdeMSvNjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9fX0OT1uSGw05535Gurux1JLD3rou58SKhjXiq46rdevNxfw46aLnK/ZgvM2F7xQ
	 000DDEcQY/G31RX/7WGtilXhOIlsaTCZQpWOcV6chU0va9XB8CAXOrgnnetQTpvNuf
	 j48/BEgw+YMhSUrCE7R+skrNk0J2O1WWEGEvrRxsf/ulwvbLIEBdm2KvPhy/0s7eus
	 H041W8Jj3Gq7MRlg43KwBBMmffdIM+ruT9UQGnXkZAjxxjO+yNampufgZX1cWNUV94
	 FifJ3fs51VJjbnIhGrP86r7lfg85mLOw3XBGEdCWMNKrLdmLaxGO5Z2zoq29XygB7j
	 B4HTS4sWoPYfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 71/88] scsi: qla2xxx: Avoid req_q_map double-read in
 qla2x00_error_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-72-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-72-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:21:35 +0000
Message-Id: <20260707072136.5B63E1F00ACA@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25834-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E30AE7186A5

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds and NULL pointer checks on hardware-supplied qu=
eue index in QLAFX00 handlers lead to OOB reads and wild pointer dereferenc=
es.
- [High] The patch transforms a NULL pointer dereference into a Use-After-F=
ree and fails to prevent compiler reloads due to a missing READ_ONCE().
- [High] Out-of-bounds array access on `req_q_map` before validation in `ql=
a2x00_status_entry`.
- [High] Lack of bounds checking for target QID index on `req_q_map` array =
access in `qlt_ctio_to_cmd`.
--

--- Patch [71]: [PATCH v3 71/88] scsi: qla2xxx: Avoid req_q_map double-read=
 in qla2x00_error_entry() ---
commit c14818342918ef21459d32bbecb1126af60c505c
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Avoid req_q_map double-read in qla2x00_error_entry()

This patch attempts to fix a potential double-read of the request queue map
in the error entry ISR. It caches the map slot into a local variable to
perform the NULL check and subsequent use. The issue was observed during
queue teardown when the map slot is cleared concurrently.

> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_is=
r.c
> index 91a8344fea6c7..829671937f92e 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -3927,10 +3927,12 @@ qla2x00_error_entry(scsi_qla_host_t *vha, struct =
rsp_que *rsp, sts_entry_t *pkt)
[ ... ]
> =20
> -	if (que >=3D ha->max_req_queues || !ha->req_q_map[que])
> +	if (que >=3D ha->max_req_queues)
>  		goto fatal;
> =20
>  	req =3D ha->req_q_map[que];
> +	if (!req)
> +		goto fatal;

[Severity: High]
This isn't a bug introduced by this patch, but caching the pointer without
READ_ONCE() might allow the compiler to reload the pointer from memory,
potentially re-introducing the NULL dereference.

Additionally, does this code allow a use-after-free?

As mentioned in the commit message, qla25xx_free_req_que() runs concurrently
and clears the slot before freeing the queue:

> drivers/scsi/qla2xxx/qla_mid.c:qla25xx_free_req_que() {
> ...
>         mutex_lock(&ha->mq_lock);
>         ha->req_q_map[que_id] =3D NULL;
>         clear_bit(que_id, ha->req_qid_map);
>         mutex_unlock(&ha->mq_lock);
>     }
>     kfree(req->outstanding_cmds);
>     kfree(req);
> }

Since this ISR does not synchronize with the teardown, could the ISR fetch
the pointer just before it is cleared, pass the NULL check, and then access
req after it has been freed by the other CPU?


[Severity: Critical]
This is a pre-existing issue, but does qlafx00_status_entry() lack bounds
and NULL pointer checks on the hardware-supplied queue index?

> drivers/scsi/qla2xxx/qla_mr.c:qlafx00_status_entry() {
>     ...
>     que =3D MSW(hindex);
>     req =3D ha->req_q_map[que];
>=20
>     /* Validate handle. */
>     if (handle < req->num_outstanding_cmds)
>     ...
> }

Could a malformed hardware response trigger an out-of-bounds read and
subsequent wild pointer dereference if que exceeds max_req_queues or req
is NULL?

This same pattern appears to be present in qlafx00_multistatus_entry()
and qlafx00_error_entry().


[Severity: High]
This is a pre-existing issue, but does qla2x00_status_entry() access the
array before validating the index bounds?

> drivers/scsi/qla2xxx/qla_isr.c:qla2x00_status_entry() {
>     ...
>     que =3D MSW(sts->handle);
>     req =3D ha->req_q_map[que];
>=20
>     /* Check for invalid queue pointer */
>     if (req =3D=3D NULL ||
>         que >=3D find_first_zero_bit(ha->req_qid_map, ha->max_req_queues)=
) {
>     ...
> }

Can a corrupted hardware input cause an out-of-bounds memory read during
the assignment to req, before the bounds check evaluates?


[Severity: High]
This is a pre-existing issue, but does qlt_ctio_to_cmd() access the
req_q_map array without bounds checking?

> drivers/scsi/qla2xxx/qla_target.c:qlt_ctio_to_cmd() {
>     ...
>     int qid =3D GET_QID(handle);
>     ...
>     } else if (vha->hw->req_q_map[qid]) {
>         ql_dbg(ql_dbg_tgt_mgt, vha, 0x1000a,
>             "qla_target(%d): CTIO completion with different QID %d handle=
 %x\n",
>             vha->vp_idx, rsp->id, handle);
>         req =3D vha->hw->req_q_map[qid];
>     ...
> }

Could an untrusted hardware handle with a qid exceeding max_req_queues
cause an out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D71

