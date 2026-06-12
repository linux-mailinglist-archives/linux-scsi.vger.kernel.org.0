Return-Path: <linux-scsi+bounces-24857-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /v/sB9HvK2pUIAQAu9opvQ
	(envelope-from <linux-scsi+bounces-24857-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:38:57 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAE6679038
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WBIlvelP;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24857-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24857-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04C031BDFEB
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 11:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A705359A90;
	Fri, 12 Jun 2026 11:38:24 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2639337BBD
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 11:38:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264304; cv=none; b=tnJulLoN+2X/z1ej9zW/CxH0biNTzwh7N4ITMN6kA/Go8iweYFPc3UNiflR3Thw0Wvel8qMldPm5KRe819s/0rBmAlwjAU199t1nve+EHoUbXbYkqMZV8BYG0vIK80afM7w5d7F//1rC7hprzfSbaGK/cMOPivyMoa5uDPDFeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264304; c=relaxed/simple;
	bh=PH24FsN7BBA1uX5Za7MgC2pnJPgwt71j22Mz3abYEuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XjlyHXuOI1dnkNNMj7IoG8RK43y2qBjVFbo+8O7sczR7aipOW3tWUPeNAs43fmx79FkgKCcw9EnsmIlSt5zK+1pt11EZCNtB/NSm2i83yh3ERoG1JVy2lm1dbtNWm2BZ0R6DpZNs1irvgL8xRbRFJNu95wBhXs+J38k86bogFTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBIlvelP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC281F00A3A;
	Fri, 12 Jun 2026 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781264302;
	bh=JNETbx2z6zKNVxmLWeXIKtrF0gledZPLHUnmHVhjSZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBIlvelPOgh+Fes1w6b4u7MaiSi3Dt3McQduvk4Yw/yySjdn53O+zwP+AbjoP3Gps
	 /lXXG0PQiPEabeU+QJEEbuhc3sX9a8KJa1grlAQ6uys2Fh9pGGoFwHz/hTvT263AMX
	 TEzu0LtPxmnR+a+hjUZi7wRk3chVIup6LomIjN7s2ro1L+RBlOOWfvXnXP7Ejc0okY
	 kMMPZRBhjF+U0uKuE+UwmB4B3oIn/q5iObLYgKHsyBh8Fs+j6gB8HZ0ZLmexLsM6jz
	 20+TgxGggM6wdxsFadYVy1/5KvvQ0FiwBkQLg7whEKaZSAB+haz/7O7zOL+MCg1dOb
	 +hHYPKEhQb4BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 59/60] scsi: qla2xxx: Fix BSG job leak on validate
 flash image error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260612095333.1666592-60-njavali@marvell.com>
References: <20260612095333.1666592-60-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:38:21 +0000
Message-Id: <20260612113822.3EC281F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-24857-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EAE6679038

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on `job->request_len` leads to out-of-bounds =
heap reads of the BSG request payload.
--

commit 39e37aaaa21d29987eb2a2358ad4f2e41418684a
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Fix BSG job leak on validate flash image error path

This commit fixes a BSG job leak in the validate flash image error path.
By calling bsg_job_done() unconditionally, it ensures the transport
completes the job and frees resources even if the validation fails.

> diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bs=
g.c
> --- a/drivers/scsi/qla2xxx/qla_bsg.c
> +++ b/drivers/scsi/qla2xxx/qla_bsg.c
> @@ -3734,9 +3734,8 @@ static int qla28xx_validate_flash_image(struct bsg_=
job *bsg_job)

[Severity: High]
This is a pre-existing issue, but does this BSG job handling path lack
sufficient bounds checking on job->request_len?

The BSG infrastructure allocates job->request using memdup_user() with the
exact user-supplied length. In fc_bsg_host_dispatch(), the transport only
verifies that request_len >=3D sizeof(uint32_t) before inspecting the msgco=
de.

When dispatching a vendor command, it appears to read out of bounds if the
request is too small:

drivers/scsi/scsi_transport_fc.c:fc_bsg_host_dispatch() {
    ...
    if ((shost->hostt->vendor_id =3D=3D 0L) ||
        (bsg_request->rqst_data.h_vendor.vendor_id !=3D
            shost->hostt->vendor_id)) {
    ...
}

If the access accidentally matches the host's vendor_id, the driver then
reads further without validating the length:

drivers/scsi/qla2xxx/qla_bsg.c:qla2x00_process_vendor_specific() {
    ...
    switch (bsg_request->rqst_data.h_vendor.vendor_cmd[0]) {
    ...
}

This validation path then continues to read the command index directly
from the request without length validation:

drivers/scsi/qla2xxx/qla_bsg.c:qla28xx_do_validate_flash_image() {
    ...
    img_idx =3D bsg_request->rqst_data.h_vendor.vendor_cmd[1];
    ...
}

Can an attacker with the sys_rawio capability submit a malformed request
that triggers out-of-bounds heap reads across these functions, potentially
causing a panic or leaking uninitialized data?

>  	bsg_reply->result =3D DID_OK << 16;
>  	bsg_reply->reply_payload_rcv_len =3D 0;
>  	bsg_job->reply_len =3D sizeof(struct fc_bsg_reply);
> -	if (!rval)
> -		bsg_job_done(bsg_job, bsg_reply->result,
> -			     bsg_reply->reply_payload_rcv_len);
> +	bsg_job_done(bsg_job, bsg_reply->result,
> +		     bsg_reply->reply_payload_rcv_len);
> =20
>  	return QLA_SUCCESS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612095333.1666=
592-1-njavali@marvell.com?part=3D59

