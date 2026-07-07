Return-Path: <linux-scsi+bounces-25817-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zIz8NbKkTGopngEAu9opvQ
	(envelope-from <linux-scsi+bounces-25817-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:03:14 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468587183EC
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:03:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jzv/e1OU";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25817-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25817-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5AF130AB331
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623263CE0B8;
	Tue,  7 Jul 2026 06:54:07 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D13CC332
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 06:54:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407246; cv=none; b=kQUUwTMEqZj4m5F5zlBzTMdESrDGPMZgg0yJpayDc2cHq6kDIsdFUVCyLyyJlGgDBbdBR8jgnsFf5LWmXY819RpzkuWQD+1trHeflb5I9nd8a5Qvh2YdZ13BWJYUsJCNO2Lanr14N1tuAvPEewTlaN09EKR3gUyLI5PGjL3Cf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407246; c=relaxed/simple;
	bh=a3HtFPGZ/tb+CaMHsPT68PyHSN4M9cAXpGPq6e/SODM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=auB5sCG739kRSHdfyT20gndQcHaqrxOZG6krQ1BN4RG+HDmd64PJqxj+3WuqsfH3BP9QIBGCTusi6INqM3U26Fpe5UwkYP/SREJCFw3JXa30PPd8Xlo+bzKksmA5kJYHj4iJDtss706ETftlPWlE71CjToZ3DW2kgKg1/B6oy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzv/e1OU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FAE1F000E9;
	Tue,  7 Jul 2026 06:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783407243;
	bh=PIgkkWKseHWg89LumrfJgoSUZd2fs6wxUu4AZw3uO+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzv/e1OUFtEyiYKMdemeaIR1VXz55nd4hPWFmNbeko2nbeciVUsROMRvD5e5Z8R39
	 2xwxosD3rs0mcubnvK0zOp/RRoUqUKpVUPwwyhI4bVVOgZxQfSO0AGA5BkE3Qf/N8B
	 V207QoRmVOk0m8eBmDsXlORMad4ceGE2SmfRSYBtTcC+NXHtwkWY6gVbYTMI31WDGq
	 kSOopMkDTfyNDcRVl5jlVvSPTkChP+zobnSZH1wPdahy8qF8Ek1AwgHqgGNWstVzGk
	 bxYjZo9Wtnfmq+JLsMaWYOWMdrDPvZpHvVnlNpex+9P2y1GcZsO5Wers3I1pUzFqQL
	 IWK9JtKTtCKmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 49/88] scsi: qla2xxx: Check entry_status in
 qla24xx_modify_vp_config()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-50-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-50-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 06:54:02 +0000
Message-Id: <20260707065403.09FAE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25817-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,marvell.com:email,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 468587183EC

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing early reject check in qla84xx_verify_chip() leads to false=
 success.
- [High] Ignored IOCB execution status in qla84xx_updatefw() and qla84xx_mg=
mt_cmd().
--

--- Patch [49]: [PATCH v3 49/88] scsi: qla2xxx: Check entry_status in qla24=
xx_modify_vp_config() ---
commit a6a888a28160758908720e759f4660c0e9650700
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Check entry_status in qla24xx_modify_vp_config()

The Modify VP Config completion handler labelled its first error branch
"error status" but tested vpmod->comp_status instead of
vpmod->entry_status. Because CS_COMPLETE is 0, the following
"comp_status !=3D CS_COMPLETE" branch duplicated that test and was dead
code, and entry_status was never examined at all.

Cc: stable@vger.kernel.org

> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mb=
x.c
> index b32ca8ed274d6..59023492c5a98 100644
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c
> @@ -4401,10 +4401,10 @@ qla24xx_modify_vp_config(scsi_qla_host_t *vha)
>  	if (rval !=3D QLA_SUCCESS) {
>  		ql_dbg(ql_dbg_mbx, vha, 0x10bd,
>  		    "Failed to issue VP config IOCB (%x).\n", rval);
> -	} else if (vpmod->comp_status !=3D 0) {
> +	} else if (vpmod->entry_status !=3D 0) {
>  		ql_dbg(ql_dbg_mbx, vha, 0x10be,
>  		    "Failed to complete IOCB -- error status (%x).\n",
> -		    vpmod->comp_status);
> +		    vpmod->entry_status);
>  		rval =3D QLA_FUNCTION_FAILED;
>  	} else if (vpmod->comp_status !=3D cpu_to_le16(CS_COMPLETE)) {
>  		ql_dbg(ql_dbg_mbx, vha, 0x10bf,

[Severity: High]
This isn't a bug introduced by this patch, but while you are fixing this
missing entry_status check here, does qla84xx_verify_chip() suffer from the
exact same flaw?

During driver initialization or error recovery, if the firmware rejects the
verify IOCB early, it sets entry_status but leaves comp_status as 0=20
(CS_COMPLETE) from the initial memset. The driver only evaluates
comp_status:

drivers/scsi/qla2xxx/qla_mbx.c:qla84xx_verify_chip() {
    ...
    status[0] =3D le16_to_cpu(mn->p.rsp.comp_status);
    status[1] =3D status[0] =3D=3D CS_VCS_CHIP_FAILURE ?
        le16_to_cpu(mn->p.rsp.failure_code) : 0;
    ...
}

Could this result in a malfunctioning 84xx adapter, or one with an invalid
firmware image, being falsely marked as initialized and ready?

[Severity: High]
This is also a pre-existing issue, but do qla84xx_updatefw() and
qla84xx_mgmt_cmd() similarly ignore the IOCB execution status?

In both of these functions, the driver calls qla2x00_issue_iocb_timeout()
which verifies that the mailbox command was accepted. However, the driver
then unconditionally sets the result to DID_OK without checking the
entry_status or comp_status of the returned IOCB:

drivers/scsi/qla2xxx/qla_bsg.c:qla84xx_updatefw() {
    ...
    bsg_reply->result =3D DID_OK;
    ...
}

drivers/scsi/qla2xxx/qla_bsg.c:qla84xx_mgmt_cmd() {
    ...
    bsg_reply->result =3D DID_OK;
    ...
}

Would this cause BSG operations like firmware updates to silently fail
but report success to userspace, or return zeroed memory for read commands
instead of an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D49

