Return-Path: <linux-scsi+bounces-25838-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EdhEAatTGrpnwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25838-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:38:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8791C7188DF
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:38:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d2Y71+Kz;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25838-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25838-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E71C031C3D1A
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA53F4852;
	Tue,  7 Jul 2026 07:26:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B833E025F
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:26:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409167; cv=none; b=q01oNwP4kwVdnKkpA7Ui36l3yf9n+7RCQtNX5yDPD4EHvbV0Vun8awr3vZxN8FDjol0o5vG1F+Zx0u639a4sPI4z5OAumRgkLtIhICbE5ClzRM36Ayw9w5PVjjkHPsa+x9plYWv9J182wFiDQjxhBIpvhVbiF+n8mnmd7vLdTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409167; c=relaxed/simple;
	bh=Orb2jSxEwUYKemMio0WxkI4AiEGCNY52lKqJR8NTLbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rJjtNh/c10/gv8ow6Xow1RpC2nGZfzN5hmhvLnMKoAX29SBYmKG/sFK+eA67L8Ok246BkLUHf0TPPRVc6pzldzO3j6G+5iYie/B9KM26sAMEgB54IKvKOMyoH1ilf89xD8a2Dd3PISAAcn1N3w1HReBwDZUpfyGRrYa99qiX+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2Y71+Kz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EFA1F000E9;
	Tue,  7 Jul 2026 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409157;
	bh=XrRz+LABxf/FBD7CpImRU5bledHSRA+tLayv82D2fYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2Y71+KzIQTiZz1k3IUS7aG8hvGQFWCdyxLsh8WivO++xmVtRkLBtgbGHKNqmLCjx
	 4VY6uHiMqboD1v8rWTd6fuQFy5l20AyEciF+4GpPO7TyZKvHng2KiFi/k9b3tle0gm
	 loLWRZI7k2rwD4huZzKgmruKchhNUp5fvZv6k7YrraI1fqsKk/X5m6BofLJCwrXyAR
	 NVaZoFBfyLi/QpSyBlZLphy+XjECfRmj3cOQHmEY1B8Ucfm/NQPZzgQ2GNJ4H5DQWy
	 0IRSKpffeot5WHlXCUELow3a0DkFOXBwS8bDit+MjuryYy876QSMUJzI5tdluF7bjj
	 UE4qro7Fn114A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 67/88] scsi: qla2xxx: Null out freed pointers in
 qla2x00_mem_alloc() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-68-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-68-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:25:57 +0000
Message-Id: <20260707072557.C4EFA1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25838-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,marvell.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8791C7188DF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double free of ha->sns_cmd in error path of qla2x00_mem_alloc.
--

--- Patch [67]: [PATCH v3 67/88] scsi: qla2xxx: Null out freed pointers in =
qla2x00_mem_alloc() error path ---
commit 67cec0babb19e6c4e62f136f94d2843f83907bad
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Null out freed pointers in qla2x00_mem_alloc() error path

This commit updates the error handling path in qla2x00_mem_alloc() to null
out several pointers after freeing them. This prevents a subsequent call
to qla2x00_mem_free() from double-freeing these resources when the hardware
probe fails.

> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -4619,28 +4619,43 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_=
t req_len, uint16_t rsp_len,
[ ... ]
>  fail_ex_init_cb:
>  	kfree(ha->npiv_info);
> +	ha->npiv_info =3D NULL;
>  fail_npiv_info:
>  	dma_free_coherent(&ha->pdev->dev,
>  		((*rsp)->length + 1) * rsp_entry_size,

[Severity: High]
This is a pre-existing issue, but since this patch is cleaning up dangling
pointers in the qla2x00_mem_alloc() error path, should ha->sns_cmd also
be cleared?

Further down in the error cleanup for qla2x00_mem_alloc(), ha->sns_cmd is=20
freed without setting the pointer to NULL:

fail_free_ms_iocb:
        dma_pool_free(ha->s_dma_pool, ha->ms_iocb, ha->ms_iocb_dma);
        ha->ms_iocb =3D NULL;
        ha->ms_iocb_dma =3D 0;

        if (ha->sns_cmd)
                dma_free_coherent(&ha->pdev->dev, sizeof(struct sns_cmd_pkt=
),
                    ha->sns_cmd, ha->sns_cmd_dma);
fail_dma_pool:

If an earlier allocation fails on legacy hardware, the cleanup code frees=20
ha->sns_cmd and leaves it dangling. When the error propagates up, the probe=
=20
error handler probe_hw_failed calls qla2x00_mem_free(). Since ha->sns_cmd=20
is still non-NULL, qla2x00_mem_free() will free it a second time.

Could this lead to memory corruption during probe failure on older systems?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D67

