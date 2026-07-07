Return-Path: <linux-scsi+bounces-25805-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EDSMDqfTGrGnAEAu9opvQ
	(envelope-from <linux-scsi+bounces-25805-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:39:54 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 138497180A8
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:39:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TWpdDphd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25805-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25805-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4521B305A5CA
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736C3A7F4C;
	Tue,  7 Jul 2026 06:36:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF11221546
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 06:36:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406170; cv=none; b=Ikwv9Fnf4CDkeNlVfSAQZYf1otdvK4RAp6127EtwnVMRc/G+dFZmSWOSMSZSbJSsvIfukZ+Bdv/dAyO/xnIxxlfCvQxeYutHtaxp0X6/9GdVyL3ArOxhzBlCVjw1ryXaPQ42pl6k+RnIeN5c6nc3obBOo+xIAdW9aEKm+69J1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406170; c=relaxed/simple;
	bh=1MnLt96ChTLj6lnhexLIhjpc9/azX+AXy+sKmT4A2Zo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0NWTGGCmJRgfLbpaPRLBAFPCPIWYqlVt17iYGDiyppazy9EazYL+rKmDt+KQEFKqt15yi0FuyK1rnDQ7+I+i9kxbYK7Zy9paDv+W0Gk9o5T/ESHONh2CtxmX9HTzU7MeWzFAvE2GdiHcIRqaRoaruAgecG+3V2XLy96sk4cRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWpdDphd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6421F00A3F;
	Tue,  7 Jul 2026 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783406169;
	bh=2656gtF1GNtQTP3yqj6brjiO3gvX9XBcW8DryMdIiVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TWpdDphd36hYp2MLixmzC4sRw9DsCC8eNDZrMMa7wAlLtHTcVFSm66s37ZGaGP6KI
	 4CGKEwmfYsVOgF+8N+HvAvqHHLprDIzRVaGNPFWYaJMhzIDdglxA0EXqg7A6mHMJdR
	 acl8IpcuxwTmI+0brNiO39ZDnzK0FoN/skKnFpNICDxWqJ27cYNqYmHOqhQfsSmOH7
	 bB4lFlpHSlw4xjhgO25JslWTPLtqF1BbWKIPmhqgo0BTp/ozXn1TNRjjbSamE85Hfu
	 iw3Wm4JMpWsveKX77RUcFqyFq6P9iHAKzE5ylCzovFYQVLzYCJueWVGftXRDMkhli/
	 trojl6hHIYG4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/88] scsi: qla2xxx: Enable serdes, resource count
 and FCE trace for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-20-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-20-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 06:36:08 +0000
Message-Id: <20260707063608.EA6421F00A3F@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25805-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,marvell.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 138497180A8

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Multi-queue qpairs on 29xx miss the inline IOCB submission optimiz=
ation, leading to request ring corruption.

Pre-existing issues:
- [High] Enabling FCE trace via debugfs when `fw_dump` is already allocated=
 causes a vmalloc out-of-bounds write during firmware dump.
- [High] Race condition between disabling FCE trace via debugfs and capturi=
ng a firmware dump leads to a Use-After-Free of `ha->fce`.
- [High] TOCTOU race condition in `qla2x00_dfs_fce_release()` causing a NUL=
L pointer dereference.
- [High] Data race on bitfields in `ha->flags` between process context and =
hardware interrupt context.
--

--- Patch [19]: [PATCH v3 19/88] scsi: qla2xxx: Enable serdes, resource cou=
nt and FCE trace for 29xx ---
commit edd8bd44658eaa99ef8b8fe98bcd34952eb875a0
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Enable serdes, resource count and FCE trace for 29xx

The 29xx adapters share the diagnostic and management interfaces
already supported on ISP27xx/28xx, but several family capability
gates still omitted IS_QLA29XX(), leaving these paths unreachable
on 29xx.

> diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_df=
s.c
> index 43970caca7b39..177d47e92e494 100644
> --- a/drivers/scsi/qla2xxx/qla_dfs.c
> +++ b/drivers/scsi/qla2xxx/qla_dfs.c
> @@ -497,7 +497,7 @@ qla2x00_dfs_fce_write(struct file *file, const char _=
_user *buffer,
>  	unsigned long enable;
> =20
>  	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
> -	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha)) {
> +	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha) && !IS_QLA29XX(ha)) {
>  		ql_dbg(ql_dbg_user, vha, 0xd034,
>  		       "this adapter does not support FCE.");
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but enabling FCE trace via debug=
fs
when fw_dump is already allocated seems to cause a vmalloc out-of-bounds wr=
ite
during a firmware dump.

If ql2xallocfwdump is true, qla2x00_alloc_fw_dump() is called at probe while
ha->fce is still NULL, omitting FCE_SIZE.  If we then enable FCE via debugf=
s:

drivers/scsi/qla2xxx/qla_dfs.c:qla2x00_dfs_fce_write() {
    ...
    if (!ha->flags.fce_dump_buf_alloced)
        qla2x00_alloc_fw_dump(vha);
    ...
}

qla2x00_alloc_fw_dump() returns early if ha->fw_dump is non-NULL, skipping
the resize.  When the dump is later captured:

drivers/scsi/qla2xxx/qla_dbg.c:qla25xx_copy_fce() {
    ...
    memcpy(iter_reg, ha->fce, ntohl(fcec->size));
    ...
}

Does this blindly copy FCE_SIZE into the undersized dump buffer, triggering=
 an
out-of-bounds write?

[Severity: High]
This is a pre-existing issue, but there appears to be a race condition betw=
een
disabling FCE trace and capturing a firmware dump that leads to a
use-after-free.

Disabling FCE frees the DMA memory and NULLs ha->fce holding only
ha->fce_mutex:

drivers/scsi/qla2xxx/qla_dfs.c:qla2x00_dfs_fce_write() {
    ...
    qla2x00_free_fce_trace(ha);
    ...
}

However, a concurrent firmware dump executes under ha->hardware_lock but not
ha->fce_mutex.  If the debugfs thread frees the trace buffer between the
firmware dump's NULL check and the subsequent memcpy():

drivers/scsi/qla2xxx/qla_dbg.c:qla25xx_copy_fce() {
    ...
    memcpy(iter_reg, ha->fce, ntohl(fcec->size));
    ...
}

Could this result in a use-after-free read and data leak?

[Severity: High]
This is a pre-existing issue, but does qla2x00_dfs_fce_release() have a TOC=
TOU
race causing a NULL pointer dereference?

The guard condition is checked outside the critical section:

drivers/scsi/qla2xxx/qla_dfs.c:qla2x00_dfs_fce_release() {
    ...
    if (ha->flags.fce_enabled || !ha->fce)
        goto out;

    mutex_lock(&ha->fce_mutex);
    ...
}

If a concurrent thread writes 0 to the FCE node, it acquires the mutex,
frees ha->fce, and sets it to NULL.  When the first thread resumes, it
acquires the mutex and executes:

drivers/scsi/qla2xxx/qla_dfs.c:qla2x00_dfs_fce_release() {
    ...
    memset(ha->fce, 0, fce_calc_size(ha->fce_bufs));
    ...
}

Will this panic the kernel by dereferencing the newly NULL'd pointer?

[Severity: High]
This isn't a bug introduced by this patch, but does modifying user_enabled_=
fce
cause a data race with hardware interrupt context?

In qla2x00_dfs_fce_write():

drivers/scsi/qla2xxx/qla_dfs.c:qla2x00_dfs_fce_write() {
    ...
    ha->flags.user_enabled_fce =3D 1;
    ...
}

This executes in process context holding only fce_mutex.  However, it shares
the same 32-bit word as mbox_int:

drivers/scsi/qla2xxx/qla_def.h:
    volatile struct {
        uint32_t    mbox_int            :1;
        ...
        uint32_t    user_enabled_fce    :1;
        ...

The compiler updates these via non-atomic read-modify-write instructions.
If the ISR sets ha->flags.mbox_int =3D 1 under hardware_lock while the proc=
ess
context is in the middle of its RMW cycle, won't the process context overwr=
ite
the ISR's update, clearing mbox_int and causing dropped mailbox interrupts?

[ ... ]

> diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_i=
nit.c
> index bd0684d97fef1..ae9bf68710793 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -3733,7 +3733,7 @@ int qla2x00_alloc_fce_trace(scsi_qla_host_t *vha)
>  		return -EINVAL;
> =20
>  	if (!IS_QLA25XX(ha) && !IS_QLA81XX(ha) && !IS_QLA83XX(ha) &&
> -	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha))
> +	    !IS_QLA27XX(ha) && !IS_QLA28XX(ha) && !IS_QLA29XX(ha))
>  		return -EINVAL;
> =20
>  	if (ha->fce) {

[Severity: High]
When dynamically creating multi-queue qpairs for a 29xx adapter, target pat=
hs
can fall back to calling qla2x00_start_iocbs() if the inline IOCB submission
optimization is missed:

drivers/scsi/qla2xxx/qla_init.c:qla2xxx_create_qpair() {
    ...
    if (IS_QLA27XX(ha) || IS_QLA83XX(ha) || IS_QLA28XX(ha))
        qpair->reqq_start_iocbs =3D qla_83xx_start_iocbs;
    ...
}

Because 29xx adapters use 128-byte IOCBs and track the ring slot using
req->ring_ext_ptr, qla2x00_start_iocbs() fails to advance ring_ext_ptr.

Does the lack of IS_QLA29XX(ha) here cause the next request to blindly over=
write
the same ring slot, corrupting the hardware request queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D19

