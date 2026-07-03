Return-Path: <linux-scsi+bounces-25570-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jk3bEMiiR2rHcgAAu9opvQ
	(envelope-from <linux-scsi+bounces-25570-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:53:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B4702112
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 13:53:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Ubeae/8c";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25570-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25570-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92723002B49
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956937DE89;
	Fri,  3 Jul 2026 11:42:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429DB386440
	for <linux-scsi@vger.kernel.org>; Fri,  3 Jul 2026 11:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078942; cv=none; b=iH27F/K3bcKSoY4slOOL/At3wPzYeQSPbnJyzNOqmM+dX1uyGt/teRS99wOzvIZ6IYPVWWsG12MdH3/bkjvU+j5iNis76j+n1Blc1idLe/a1YLaOtyiNnwhy3RbV9dFzGgOa6zOWOFeWS7UGMzSupU+GAHsTPukgT+ljDPyTyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078942; c=relaxed/simple;
	bh=LfQKv78NwcWyhK5Yurw19RGdv9SG0JjB8mTtw8hGCk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzngEH/TCuNt5LakgZn9rGNhCfBRrGH56UeO4qCyvvhKH/wYsfrulXqqu2oqON9od0lWUV+1wx1niVusHqgEZ3gkgsu/V7hGrLxQ/LFWNy5mUQhCCuBUDTrDmEEuNChnRAnRjPgH2suQPWkGws/+jq5hOl/Xt0Ii4DOVohgw16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubeae/8c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56E01F000E9;
	Fri,  3 Jul 2026 11:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078940;
	bh=soVM2wfBLWuubQIVT5vB0V8D/vu51HzOoQ5Ol2Lvlkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ubeae/8c9T91vx5RHdQJIjXgM4P4gPwUGjVHw+iF7wZaq2u/Tg4Nk60IVXpOVGw7g
	 g8iYHE704DY/Gygwh3KoC9wY8AJWdnndLfTPrLRj73vRfJBlFy76kFNV/XSF3gRiVh
	 GuBVBGjdVQm6hrAtO/laMnbSVlMjbtohPCMBTHADlyk6PBxODJsrV8Fd0XsTG0T/n3
	 CWyZ1105zXzL0pxEdHJdL+PvcR9JMhlO3Spjea1J+iIxUlKYRdMUz9fhw3TtJI8Vvi
	 BT61ZKJUNJ/8pulhm3HA2Od57menmI0xoEE3mE6W6qxNp6usK5nUhNQEW3GfmOObaC
	 Xc/6D9esLasFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] nvme-multipath: add uring_cmd support
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Garry" <john.g.garry@oracle.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260703103204.3724406-7-john.g.garry@oracle.com>
References: <20260703103204.3724406-1-john.g.garry@oracle.com>
 <20260703103204.3724406-7-john.g.garry@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:42:20 +0000
Message-Id: <20260703114220.B56E01F000E9@smtp.kernel.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25570-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oracle.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 364B4702112

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Polling thread accesses a freed request if it completes asynchrono=
usly via a timeout or abortion.
--

commit 26f589fad741b01889fb3c28f4f60f8b1eb60783
Author: John Garry <john.g.garry@oracle.com>

nvme-multipath: add uring_cmd support

This commit adds uring_cmd support to NVMe multipath devices by introducing
the nvme_mpath_chr_uring_cmd callback. It also wires up the existing
nvme_ns_chr_uring_cmd_iopoll for io_uring polling.

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9a1703f01ef60..b27b45c59c883 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
[ ... ]
> @@ -1554,4 +1554,6 @@ static const struct mpath_head_template mpdt =3D {
>  	.cdev_ioctl =3D nvme_mpath_cdev_ioctl,
>  	.ioctl_begin =3D nvme_mpath_ioctl_begin,
>  	.ioctl_finish =3D nvme_mpath_ioctl_finish,
> +	.chr_uring_cmd =3D nvme_mpath_chr_uring_cmd,
> +	.chr_uring_cmd_iopoll =3D nvme_ns_chr_uring_cmd_iopoll,

[Severity: High]
This is a pre-existing issue, but does assigning nvme_ns_chr_uring_cmd_iopo=
ll()
here expose a use-after-free for multipath devices if a command times out?

Looking at nvme_uring_cmd_end_io(), if a command completes asynchronously
or times out, the handler frees the request by returning RQ_END_IO_FREE,
but it appears to leave pdu->req set:

nvme_uring_cmd_end_io() {
    ...
    } else {
        io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
    }
    return RQ_END_IO_FREE;
}

Since pdu->req isn't cleared, if the polling thread continues to spin in
nvme_ns_chr_uring_cmd_iopoll(), won't it dereference the freed request?

nvme_ns_chr_uring_cmd_iopoll() {
    ...
    struct request *req =3D pdu->req;

    if (req && blk_rq_is_poll(req))
        return blk_rq_poll(req, iob, poll_flags);
    ...
}

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703103204.3724=
406-1-john.g.garry@oracle.com?part=3D6

