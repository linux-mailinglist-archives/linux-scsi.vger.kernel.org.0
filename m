Return-Path: <linux-scsi+bounces-25087-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cfJRLuu8NGqjfwYAu9opvQ
	(envelope-from <linux-scsi+bounces-25087-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 05:52:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1C6A3B3D
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 05:52:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nr5Td5lo;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25087-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25087-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85CB53007C9F
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Jun 2026 03:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84C330D4C;
	Fri, 19 Jun 2026 03:51:53 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1E306743
	for <linux-scsi@vger.kernel.org>; Fri, 19 Jun 2026 03:51:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841113; cv=none; b=IWkavupKB6jLQQFfsQYpXGUKX/lcamD6jwLHZ8ZlNksqJJckt+sfrfXPzwXIEncWIBShESbDFKmcPMOM43u8kf4ki8+Qt93Wqjj4t8SGQu3rO5tYSgmqAw5vj+gO/DBMUyxipigmcFWWNJ6BDElVmobRLGcFurmm9vcEINXyHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841113; c=relaxed/simple;
	bh=s3i3Te7rMWHQIE0EcbNVmBnSgWlod9a/t6N/Solx7eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zwj7unV4bMvy8whIKb6HTZhjXePYxpK7rfPD5eMMINs+nNIPeWNch0fP7IkqEJ+oZwBKt2bAkmCWdgM1o2xDQTm4YcdrPNNQvNfMmipA8hYO9jlnPauxjbjIlwfhCbQsDgVaHv8braNRx3aclQyo0JqqdlhRSb+aNAPhgi3DDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr5Td5lo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25A61F000E9;
	Fri, 19 Jun 2026 03:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781841112;
	bh=Vr6O0YhdsMKbUUJ+z6qz01cFpIBANkl3LCq4CEbhXto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nr5Td5lo1ksYk1HwsaTahHC1EUNp0yEiaF6bvAQ+jdnxjzS5ZGnd4C/ZsKJGC0bJk
	 QdNFuf2RDrZ2x2GqZNnPf+elQUrYO5oAq4sG4gqSL6mBWuthQvj+4d+adTgVY4iV/L
	 le8pTw+WyucHt5Qso8eMNLB6PJg3pIR0jpEcqLdSavbLtuabY6FiSN96AjB/FK5+yj
	 vvYq17tNN0+JUjmzdh9LTo3u5VSxcCbE1wGI/TSU8SsOkhut3PlAqyK/7xjVzEkqx5
	 CD6JNRuygpETBB94GUTEsUZGg55qWKendZawJhuqy9pRtCHysB7OYIMgUZdlBIimFY
	 7qCwH/f/lAZDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: bsg: do not use GFP_NOWAIT for uring_cmd user
 buffer mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yang Xiuwei" <yangxiuwei@kylinos.cn>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260619013833.2312908-1-yangxiuwei@kylinos.cn>
References: <20260619013833.2312908-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 03:51:51 +0000
Message-Id: <20260619035151.E25A61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25087-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yangxiuwei@kylinos.cn,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12D1C6A3B3D

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditional use of GFP_KERNEL in a non-blocking io_uring context=
 violates non-blocking semantics and causes task_work deadlocks.

Pre-existing issues:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability due to mul=
tiple direct reads of SQE fields (`cmd->request_len`, `cmd->dout_xfer_len`,=
 etc.) from userspace memory, leading to a heap buffer overflow.
- [High] Allocating memory with GFP_KERNEL while holding a block request ta=
g can cause a deadlock under memory pressure.
--

commit f109aac7c9c45c1c7f2d18b3b1be8bc0e39e4c6e
Author: Yang Xiuwei <yangxiuwei@kylinos.cn>

scsi: bsg: do not use GFP_NOWAIT for uring_cmd user buffer mapping

This commit changes the bio allocation in the io_uring passthrough handler
to unconditionally use GFP_KERNEL instead of honoring the NOWAIT flag,
limiting NOWAIT to the block request allocation only.

> --- a/drivers/scsi/scsi_bsg.c
> +++ b/drivers/scsi/scsi_bsg.c
> @@ -91,10 +91,10 @@ static int scsi_bsg_map_user_buffer(struct request *r=
eq,
>  						&iter, ioucmd, issue_flags);
>  		if (ret < 0)
>  			return ret;
> -		ret =3D blk_rq_map_user_iov(req->q, req, NULL, &iter, gfp_mask);
> +		ret =3D blk_rq_map_user_iov(req->q, req, NULL, &iter, GFP_KERNEL);
>  	} else {
>  		ret =3D blk_rq_map_user(req->q, req, NULL, uptr64(buf_addr),
> -				      buf_len, gfp_mask);
> +				      buf_len, GFP_KERNEL);
>  	}

[Severity: High]
When mapping user buffers unconditionally with GFP_KERNEL here, does this
violate non-blocking semantics for io_uring?

If the mempool is depleted, mempool_alloc can sleep the submitter thread
indefinitely waiting for a bio. Because bios are freed via task_work by the
submitter task, blocking the submitter here prevents task_work from
executing, creating a circular deadlock.

Should this attempt allocation with GFP_NOWAIT first, and return -EAGAIN on
failure to trigger an io-wq punt?

[ ... ]

> @@ -126,10 +125,8 @@ static int scsi_bsg_uring_cmd(struct request_queue *=
q, struct io_uring_cmd *iouc
>  	if (cmd->dout_iovec_count > 0 || cmd->din_iovec_count > 0)
>  		return -EOPNOTSUPP;
> =20
> -	if (issue_flags & IO_URING_F_NONBLOCK) {
> +	if (issue_flags & IO_URING_F_NONBLOCK)
>  		blk_flags =3D BLK_MQ_REQ_NOWAIT;
> -		gfp_mask =3D GFP_NOWAIT;
> -	}
> =20
>  	req =3D scsi_alloc_request(q, cmd->dout_xfer_len ?
>  				 REQ_OP_DRV_OUT : REQ_OP_DRV_IN, blk_flags);

[Severity: High]
This is a pre-existing issue, but does performing memory allocation with
GFP_KERNEL while holding a block request tag risk deadlock under memory
pressure?

In scsi_bsg_uring_cmd(), scsi_alloc_request() consumes a hardware tag
from the shared tag set. Subsequently calling scsi_bsg_map_user_buffer()
with GFP_KERNEL can enter direct reclaim.

If memory reclaim needs to write dirty pages back to a block device on the
same host, it requires a request tag. If all tags are held by tasks
suspended in GFP_KERNEL, memory reclaim cannot make progress.

[Severity: Critical]
This is a pre-existing issue, but is there a Time-of-Check to
Time-of-Use (TOCTOU) vulnerability here?

The cmd->request_len field is read directly from the userspace-mapped
submission queue entry (ioucmd->sqe). A malicious userspace program
could mutate the SQE after the bounds check:

scsi_bsg_uring_cmd() {
    ...
    if (cmd->request_len > sizeof(scmd->cmnd)) {
        ret =3D -EINVAL;
        goto out_free_req;
    }

but before the copy executes:

    if (copy_from_user(scmd->cmnd, uptr64(cmd->request), cmd->request_len))=
 {
        ret =3D -EFAULT;
    ...
}

Could this allow copy_from_user to overflow the fixed 32-byte scmd->cmnd
buffer in the request PDU? The io_uring subsystem guidelines mandate
caching SQE fields locally via READ_ONCE() before validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619013833.2312=
908-1-yangxiuwei@kylinos.cn?part=3D1

