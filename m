Return-Path: <linux-scsi+bounces-25107-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E0ctJi/wOGo+kQcAu9opvQ
	(envelope-from <linux-scsi+bounces-25107-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 10:19:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70B6AD9F5
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 10:19:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h65fzU3j;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25107-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25107-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C463300E3E1
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jun 2026 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4039022B;
	Mon, 22 Jun 2026 08:12:24 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310E38E5DE
	for <linux-scsi@vger.kernel.org>; Mon, 22 Jun 2026 08:12:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115943; cv=none; b=Z2OwDw8hUsN3s8VzUFOtqBlfHBqE43exh8GL3tOHT7JISeIoKYP34D/RFE1PBB96KwnRpvVvIx2eXmIuZl83+YGXfi4eQG05lSKTfzUw7OeGKG2fJ1LKYrdYOT9wWuDbUUBfJhlYkROpqhJozhAMjQFP6zS1u9eZRL4atqzcgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115943; c=relaxed/simple;
	bh=NTgeJblxCArSsEiPfNo5x0EelLm+kwn1rsw64LkRnBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UjBenxReh7athO1Lupy1Zw+YscrZzpZ52fAeWzt2s/C4KlSA3Ti8oc2siZqb2YzkxHh09jRYs17+oXqTvK1Mv3Eub1ndji5WiSOhS9PxZaJWLvJuuNs/g7MiNmpi3hJ3he8G5gQ6G1d2nDheuXi8eQpQpNTuioZBf4nDIq4VJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h65fzU3j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0B71F000E9;
	Mon, 22 Jun 2026 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782115940;
	bh=ekR2/GQU8MPm22P+5pkvg5pw0k75LY7uvezMZ/mz5LU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h65fzU3jDxqGfZEox+gU4VW4rQZXVnpeKBhv7BONJCMqBqAna2PppK4Oes5EM+TBJ
	 8DdWiSPqUMEppMtAOWE1yq1ZWUsXQ/ZHCYP0TRFLwSr9KeQFQ8ULNB25OHi1cNVKc0
	 nHMgFgbFU80zqTlVxCL86Hn3Qc/8OrREbQFYKai2ekSgPfqP8ywVcwjGV8r2XVIaND
	 MluXmrIHPNsxtEpjXEPFXvz+PcDFWvV3mBcsbCULsyZas5MXGU0/LbQ5/nut9SHGo8
	 YvMLmsYPxH9PkjDqsZOfvZxPpdRMD41cZO1lCLXuCBM+/+H0qnNQFwHonFdNN24li7
	 NNc2DdsCzIDnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] scsi: elx: efct: Fix IO leak on unsupported additional
 CDB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260622075844.832871-1-haoxiang_li2024@163.com>
References: <20260622075844.832871-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:12:20 +0000
Message-Id: <20260622081220.9D0B71F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25107-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A70B6AD9F5

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free and use-after-free of the hardware receive sequenc=
e when `efct_scsi_io_alloc()` fails.
- [High] IO resource leak in efct_scsi_recv_tmf() when the target node has =
no active session.
- [High] IO resource leak in efct_dispatch_unsol_tmf() when efct_scsi_send_=
tmf_resp() fails.
--

commit ba46f0e94cacea756eebf1dbcb852be56ee58afb
Author: Haoxiang Li <haoxiang_li2024@163.com>

scsi: elx: efct: Fix IO leak on unsupported additional CDB
   =20
efct_dispatch_fcp_cmd() allocates an efct_io before dispatching an
unsolicited FCP command. If the command has an unsupported additional
CDB, the function returns -EIO before handing the IO to the SCSI layer.
   =20
Free the allocated IO before returning from this error path.

> diff --git a/drivers/scsi/elx/efct/efct_unsol.c b/drivers/scsi/elx/efct/e=
fct_unsol.c
> index e6addab66a603..6a871a59c9096 100644
> --- a/drivers/scsi/elx/efct/efct_unsol.c
> +++ b/drivers/scsi/elx/efct/efct_unsol.c
> @@ -385,6 +385,7 @@ efct_dispatch_fcp_cmd(struct efct_node *node, struct =
efc_hw_sequence *seq)
> =20
>  		if (cmnd->fc_flags & FCP_CFL_LEN_MASK) {
>  			efc_log_err(efct, "Additional CDB not supported\n");
> +			efct_scsi_io_free(io);

[Severity: Critical]
This is a pre-existing issue, but does efct_scsi_io_alloc() failure cause a
double-free of the receive sequence?

When efct_scsi_io_alloc() fails earlier in this function, it repurposes the
incoming receive sequence for an asynchronous transmission:

drivers/scsi/elx/efct/efct_unsol.c:efct_dispatch_fcp_cmd() {
    ...
    io =3D efct_scsi_io_alloc(node);
    if (!io) {
        ...
        rc =3D efct_sframe_send_task_set_full_or_busy(node, seq);
        return rc;
    }
    ...
}

This constructs a transmit context directly inside the sequence's payload
buffer and submits it to the hardware for DMA. However, the caller
efct_dispatch_frame() ignores the return value of efct_dispatch_fcp_cmd()
and unconditionally frees seq immediately:

drivers/scsi/elx/efct/efct_unsol.c:efct_dispatch_frame() {
    ...
    efct_hw_sequence_free(&efct->hw, seq);
    ...
}

This causes the DMA buffer to be pushed back into the RX ring while the
hardware is actively transmitting it.

Furthermore, the async transmission completion callback then frees the
sequence again:

drivers/scsi/elx/efct/efct_unsol.c:efct_sframe_common_send_cb() {
    ...
    efct_hw_sequence_free(hw, ctx->seq);
    ...
}

Can this lead to DMA corruption and a double free into the hardware RX ring?

[Severity: High]
This is a pre-existing issue, but does this code leak the efct_io object if
the target node has no active session?

If cmnd->fc_tm_flags is set, efct_dispatch_unsol_tmf() is called, which cal=
ls
efct_scsi_recv_tmf():

drivers/scsi/elx/efct/efct_lio.c:efct_scsi_recv_tmf() {
    ...
    se_sess =3D tgt_node->session;
    if (!se_sess)
        return 0;
    ...
}

If tgt_node->session is NULL, the function returns 0. The caller
efct_dispatch_unsol_tmf() does not check the return value, and the dynamica=
lly
allocated io parameter is never freed or passed to a cleanup callback.

[Severity: High]
This is a pre-existing issue, but does efct_dispatch_unsol_tmf() leak the io
object if sending the TMF response fails synchronously?

When handling an unsupported TMF flag, efct_dispatch_unsol_tmf() attempts to
send a rejection response:

drivers/scsi/elx/efct/efct_unsol.c:efct_dispatch_unsol_tmf() {
    ...
    efct_scsi_send_tmf_resp(io, EFCT_SCSI_TMF_FUNCTION_REJECTED,
                            NULL, efct_fc_tmf_rejected_cb, NULL);
    ...
}

If efct_scsi_send_tmf_resp() fails synchronously (e.g., due to an error in
efct_hw_io_send()), it returns a non-zero error code and the callback
efct_fc_tmf_rejected_cb is never invoked.

Since the caller ignores the return value of efct_scsi_send_tmf_resp(), does
this permanently leak the allocated io object?

>  			return -EIO;
>  		}
>  		/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622075844.8328=
71-1-haoxiang_li2024@163.com?part=3D1

