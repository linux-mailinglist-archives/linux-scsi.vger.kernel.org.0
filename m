Return-Path: <linux-scsi+bounces-25076-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ptBrJ97+M2opKgYAu9opvQ
	(envelope-from <linux-scsi+bounces-25076-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 16:21:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 388176A0E7B
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 16:21:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LX7wzu4T;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25076-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25076-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1E39301587C
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2026 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F8C2874FB;
	Thu, 18 Jun 2026 14:21:16 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435635AC0E
	for <linux-scsi@vger.kernel.org>; Thu, 18 Jun 2026 14:21:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792476; cv=none; b=B1xT6MiY4VZ7Ck6KNGo1LvU28Oq9nrP1gCk64Ll9l2+JLWsiwmwYjQ2YDBD7D5vIBoKa54e0ife+/Lk68qdaByNAIEKo8IiD+SKoRwte+hwrcpAsJZdcU4tmgvWLY7m1o6guCi6l/nkCntZT4epOAlMiEgzO7w360HMX59HJsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792476; c=relaxed/simple;
	bh=gSdgolfmFakrZjYbByuiyLgIjNVqafReeoPkHq5VYG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3NTZZxmIacrs0y2azUXqAOHprSpXlrIDSSY8pGhjt99kXFNGTz4kTjYSEcXKcHXxWAn8vwf0RomqMxK5FlGagrYrnSLCiH4SoPFTWIrUb/gYmkhM7EFISeXw44HWKOTt0eY015m38i/qEcEPDRr71fVGGLyWxtebb4yjkgJBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX7wzu4T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61281F000E9;
	Thu, 18 Jun 2026 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781792474;
	bh=fn0CLHCRzGUhqytmYVUZsgDQ//1CWISRPizndV5du9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LX7wzu4THdxiRZh2tkJ44eqoazSvAfA+nKJNw0jjxCk3M4MlpbnJrfsH0a/qyAQCd
	 3hfoeraX0YyZDs1UQxrrWa8GzO+AUkgL771/gr9z+oNcFdnQoX1DFZgUVi/lXnE/f6
	 3b24LbaQSfzvzd8CHW6tuYhmJTsHzLaQlZzpcOBhMAkPG3qlnUX0v7inFfX25/mxqz
	 KQQo/THtdGqWg5EF1HsZ99CMAIi9R8CWF5U/X4BCN43mQ4TNVx1l9z8R9dBZHAA6gi
	 6fHyaYHz14sfWBw4k7rdsIcuNWurHivf8e2b2ZFqBhw/hYDQnZH2O4OzJgzPmNIlpC
	 8AB3GWJ4SX2PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] scsi: ufs: core: Avoid possible memory reclaim
 deadlock in TX EQTR context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Can Guo" <can.guo@oss.qualcomm.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260618140941.902000-1-can.guo@oss.qualcomm.com>
References: <20260618140941.902000-1-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 14:21:14 +0000
Message-Id: <20260618142114.B61281F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25076-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:can.guo@oss.qualcomm.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 388176A0E7B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The POST_CHANGE notification is skipped on error paths in ufshcd_t=
x_eqtr(), leaving variant-specific hardware state unbalanced.
- [High] Missing cleanup of TX Equalization settings and Power Mode on erro=
r paths in ufs_qcom_get_rx_fom().
--

commit 8d8593416ad1701fbb78203bd1a0efec4ccc4895
Author: Can Guo <can.guo@oss.qualcomm.com>

scsi: ufs: core: Avoid possible memory reclaim deadlock in TX EQTR context
   =20
This patch uses memalloc_noio_save() and memalloc_noio_restore() in
ufshcd_tx_eqtr() to prevent potential memory reclaim deadlocks. TX EQTR
allocations in a quiesced UFS tagset context could trigger direct reclaim
depending on UFS I/O, leading to deadlocks.

Closes: https://sashiko.dev/#/patchset/20260615132834.2985346-1-can.guo@oss=
.qualcomm.com?part=3D2

>     Use memalloc_noio_save/restore() in ufshcd_tx_eqtr() to cover all
>     allocations in the TX EQTR call tree, including:
>     - params->eqtr_record in ufshcd_tx_eqtr()
>     - eqtr_data in __ufshcd_tx_eqtr()
>     - params in ufs_qcom_get_rx_fom()

[Severity: High]
This is a pre-existing issue, but does ufs_qcom_get_rx_fom() skip cleanup
on error paths?

The function overrides TX Equalization settings via
ufshcd_apply_tx_eq_settings() and then alters the power mode to test the FO=
M.

If ufshcd_change_power_mode() or ufs_qcom_host_sw_rx_fom() fails, it
returns the error directly:

drivers/ufs/host/ufs-qcom.c:ufs_qcom_get_rx_fom() {
    ...
    ret =3D ufs_qcom_host_sw_rx_fom(hba, pwr_mode->lane_rx, fom);
    if (ret) {
        dev_err(...);
        return ret;
    }
    ...
}

Does this direct return bypass the restoration of the original TX
Equalization settings, permanently leaking the test PHY equalization
settings into the hardware configuration?

> diff --git a/drivers/ufs/core/ufs-txeq.c b/drivers/ufs/core/ufs-txeq.c
> index aa64f2bf4f1ef..d20c478659157 100644
> --- a/drivers/ufs/core/ufs-txeq.c
> +++ b/drivers/ufs/core/ufs-txeq.c
[ ... ]
> @@ -1248,6 +1260,9 @@ static int ufshcd_tx_eqtr(struct ufs_hba *hba,
>  	if (ret)
>  		ufshcd_tx_eqtr_unprepare(hba, &old_pwr_info);
> =20
> +out_noio_restore:
> +	memalloc_noio_restore(noio_flag);
> +
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
ufshcd_tx_eqtr() skip restoring the hardware state?

When ufshcd_vops_tx_eqtr_notify() is called with PRE_CHANGE, it saves
critical PHY settings. If __ufshcd_tx_eqtr() fails, the code jumps to out
and skips the POST_CHANGE notification:

drivers/ufs/core/ufs-txeq.c:ufshcd_tx_eqtr() {
    ...
    ret =3D ufshcd_vops_tx_eqtr_notify(hba, PRE_CHANGE, pwr_mode);
    if (ret)
        goto out;

    ret =3D __ufshcd_tx_eqtr(hba, params, pwr_mode);
    if (ret)
        goto out;

    ret =3D ufshcd_vops_tx_eqtr_notify(hba, POST_CHANGE, pwr_mode);
    ...
}

Since POST_CHANGE is exclusively responsible for restoring the saved
hardware state, could skipping this permanently leave the PHY tuning
registers corrupted and prevent UFS link recovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618140941.9020=
00-1-can.guo@oss.qualcomm.com?part=3D1

