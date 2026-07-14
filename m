Return-Path: <linux-scsi+bounces-26191-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9J7BJCY4Vmqj1gAAu9opvQ
	(envelope-from <linux-scsi+bounces-26191-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:22:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3F75508D
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mFO+9sdp;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26191-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26191-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1047130EBBD2
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 13:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC64657CF;
	Tue, 14 Jul 2026 13:10:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591A466B52
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 13:10:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034643; cv=none; b=LcAAUpP4IcKWPVzXrCiZw/TLxVsxmUdPqG0LxJGEtwXQLuD99v20/32QeHg/EtFDGSV6aJSG0SbxWKNcmH5+KLGatbiNc8mfFa7IM9xOORXUlkKkF/QI4q9eY0dcXTWjuu5lqo0SdW9/tZ9/QyZHLpj0NdHvMhNIihC/yOW4+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034643; c=relaxed/simple;
	bh=BFyif+cRQH9MdpsZdpQcGiKFZv7WXJqPWHgAdopKltA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=elUlzItYH40oO9b9wWzzMktl1lQteo7VeeHKN74Sn2mPeO+8SzceuyG40MskIB+d92926DvyggBOgjxkVsY+9HOLHTmegSBP/9WXXVkU7Zvj9pca33D1s58LzACn+pF6/T89TET26jIElknl7kF6x8iD5kQjfJ4ipiJGz3ziZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFO+9sdp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79EE1F000E9;
	Tue, 14 Jul 2026 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784034641;
	bh=4DA4mHdOh+1ZLXnYwX2T9aV91Mai/yaOmpv1jpVNiGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFO+9sdpdalSkRrfYYGseN03g3VBCAZwOwFt4BdFM8JZN45KbC6M19QCT9PE2Q39C
	 IEKk4oq3YGcHGuZYZcTH8LNl4pM+IhxgZA1o+n0rnVk6PiS3tiNNaCe0lX3VTws6kb
	 /qOcTaT/NxGXr+GlAEACVWfSzL+t6mDa4TJ2pDgJ43GLXsDXyUziNsD4noTzPLp10s
	 MnWWeattnbgJxIwaH7W55E0bqEeimT5pDbXXNHyyq1QZ3f+DOCU11lgZ5r6PQ/Keqc
	 JHQO5LAWa8twUZQkEPMwJ0ppGZhHzOk+vdyCutDUc9e13nQmNANKLyAIMWKHJCjPaL
	 SaIEEjDKvYO1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/56] scsi: qla2xxx: Enable serdes, resource count
 and FCE trace for 29xx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260714095353.289460-20-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
 <20260714095353.289460-20-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:10:40 +0000
Message-Id: <20260714131041.B79EE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-26191-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12C3F75508D

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect usage of `kstrtoul` in `qla2x00_dfs_fce_write` passes a =
NULL pointer for the result argument, causing an unconditional kernel oops =
upon successful parsing.
- [High] A TOCTOU race condition in `qla2x00_dfs_fce_release` can lead to a=
 NULL pointer dereference when accessing `ha->fce`.
- [High] Concurrent non-atomic modification of the `ha->flags` bitfield lea=
ds to data corruption, potentially dropping critical interrupts or mailbox =
states.
- [High] A concurrent firmware dump can trigger a Use-After-Free on `ha->fc=
e` while the FCE trace is being disabled via DebugFS.
--

--- Patch [19]: [PATCH v4 19/56] scsi: qla2xxx: Enable serdes, resource cou=
nt and FCE trace for 29xx ---
commit c0d2af5f457ed884072ede4fabe84388c9abed9e
Author: Nilesh Javali <njavali@marvell.com>

scsi: qla2xxx: Enable serdes, resource count and FCE trace for 29xx
   =20
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
This isn't a bug introduced by this patch, but looking at the parsing logic
further down in qla2x00_dfs_fce_write():

qla2x00_dfs_fce_write() {
    ...
    enable =3D kstrtoul(buf, 0, 0);
    ...
}

Does this cause an unconditional kernel oops? kstrtoul() writes the parsed
result to the pointer provided in the third argument, which is 0 (NULL)
here. Additionally, the return value (0 on success, negative on error) is
assigned to enable, which appears to invert the intended logic.


[Severity: High]
This is a pre-existing issue, but does modifying the bitfields in
qla2x00_dfs_fce_write() risk dropping mailbox interrupts?

qla2x00_dfs_fce_write() {
    ...
    ha->flags.user_enabled_fce =3D 1;
    ...
}

Since user_enabled_fce shares the same 32-bit volatile struct word as
mbox_int and mbox_busy, and compilers use non-atomic read-modify-write
operations for bitfields, can a concurrent interrupt handler modifying those
mailbox flags overwrite this update or vice versa?


[Severity: High]
This is also a pre-existing issue, but is there a use-after-free risk when
disabling the FCE trace?

In qla2x00_dfs_fce_write(), the trace buffer is freed:

    qla2x00_free_fce_trace(ha);

This is called under ha->fce_mutex. However, a concurrent firmware dump in
qla25xx_fw_dump() calls qla25xx_copy_fce() which copies data from ha->fce
while only holding ha->hardware_lock:

qla25xx_copy_fce() {
    ...
    memcpy(iter_reg, ha->fce, ntohl(fcec->size));
    ...
}

If these paths do not share a lock, could a concurrent firmware dump read
from the freed FCE buffer?


[Severity: High]
This is another pre-existing issue, but could a race condition cause a NULL
pointer dereference in qla2x00_dfs_fce_release()?

The release function checks ha->fce outside of the mutex:

qla2x00_dfs_fce_release() {
    if (ha->flags.fce_enabled || !ha->fce)
        goto out;

    mutex_lock(&ha->fce_mutex);
    ha->flags.fce_enabled =3D 1;
    memset(ha->fce, 0, fce_calc_size(ha->fce_bufs));
    ...
}

If a concurrent write to qla2x00_dfs_fce_write() acquires the mutex, frees
ha->fce, sets it to NULL, and releases the mutex, will the release thread
then acquire the mutex and execute memset() on the NULL pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714095353.2894=
60-1-njavali@marvell.com?part=3D19

