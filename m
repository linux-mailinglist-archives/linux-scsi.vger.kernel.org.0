Return-Path: <linux-scsi+bounces-25840-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cUChHoOrTGqHnwEAu9opvQ
	(envelope-from <linux-scsi+bounces-25840-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:32:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387D7187A7
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 09:32:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WI1MKwl2;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25840-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25840-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB2413007524
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653B3CF680;
	Tue,  7 Jul 2026 07:27:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388873AE19F
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 07:27:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409246; cv=none; b=O8JnWqmmbIQwiBMKjNKd1K2RuoirprBkHeEjR0UYKyaAD9hFTrGaMj9rtnXeI69OGHjK+GEvKTBZMmh9K2rVRephXHEb3hzh3OpaEPneQU3OvV214WoT4k0fD2nFDnRIacBFaoGQOwvK/CdMVYpeWfSrqpllFI6tv1+pue0n3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409246; c=relaxed/simple;
	bh=N75GEYFzQEJLWLkFJnhekbYi5lj8bKzR+wKSMoW8Uno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rB2csuvxizOzJby3S3ep0GFoV/T6C/0O+zE0f0nbBltuppDbHajdcVFBQPoiF5SNx+GPNwWGdD/FRNuKHzl/SdiXOGgWvTxc2RzPoW9fL3jNoc4lgkAAKgHH3RhEJu+4WGoXynX6MpNcgVULD0ZA9lo5c7gpi6+VqDfQW1cI+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WI1MKwl2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04531F000E9;
	Tue,  7 Jul 2026 07:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783409239;
	bh=NMXKbsxzeM7tl2SQFTVX5/6vCZi7naTFqoyQLwsZlAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WI1MKwl2T1BRNRQeCJkRoc4BObpApy5BW29lb0oIU/Y2oBXjJwgGMkAIyRxoyYmvI
	 Evz7mXHbyyfn60/B2jXNj+zOe0+zux6OU/aabnGivArc99/umAxkKF6IFo6DklP85i
	 fEdW70Rj/1yUry4lnTjHDcf2lP+xpf1v4AqeJN3pxa4kbBQpF70LJGGxJjDFtoCfnq
	 oHq5IvkebItkHOThmNdkLrd7E0EKAJzXXpfrBZnvkk8mDkwuKyc0mACOlVtg+H3CbK
	 fGm0vtJuhO0aS+FjVHruUM2mDAusRb+B3eJvrOu+BeOrwOK73UY8zI8jCrdcFzeV6y
	 xd+JGUjdcD9yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 76/88] scsi: qla2xxx: Skip vport under deletion in
 report ID acquisition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nilesh Javali" <njavali@marvell.com>
Cc: linux-scsi@vger.kernel.org
In-Reply-To: <20260707055435.2680300-77-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
 <20260707055435.2680300-77-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:27:19 +0000
Message-Id: <20260707072719.D04531F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-25840-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4387D7187A7

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to fix a Use-After-Free (UAF) by checking `=
VPORT_DELETE` before incrementing `vref_count`, but introduces a Time-of-Ch=
eck to Time-of-Use (TOCTOU) race condition that leaves the bug open.
- [Critical] Inconsistent locking across multiple threads protecting the `h=
ost_map` btree causes severe structural corruption.
- [High] Dropping a list lock inside `list_for_each_entry_safe` exposes the=
 cached next element to concurrent destruction, causing a Use-After-Free.
- [High] The Deferred Processing Context (DPC) thread processes a dying vir=
tual port, resulting in firmware state corruption and Use-After-Free.
--

--- Patch [76]: [PATCH v3 76/88] scsi: qla2xxx: Skip vport under deletion i=
n report ID acquisition ---
commit 6dadc96ded15841eb3868816e697201cbe752d9d
Author: Nilesh Javali <njavali@marvell.com>
Subject: scsi: qla2xxx: Skip vport under deletion in report ID acquisition

This commit addresses an issue in qla24xx_report_id_acquisition() by
skipping vports that have VPORT_DELETE set before taking a reference.
This prevents dying vports from being re-registered in the host_map.

Reported-by: Sashiko <sashiko-dev@google.com>
Cc: stable@vger.kernel.org

> diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mb=
x.c
> --- a/drivers/scsi/qla2xxx/qla_mbx.c
> +++ b/drivers/scsi/qla2xxx/qla_mbx.c
> @@ -4268,6 +4268,8 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,=
 void *pkt)
>  			spin_lock_irqsave(&ha->vport_slock, flags);
>  			list_for_each_entry(vp, &ha->vp_list, list) {

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to drop the
vport_slock while iterating the vport list in other areas of the driver?

In functions like qla2x00_quiesce_io() and qla2x00_do_dpc_all_vps(), the
code uses list_for_each_entry_safe() but temporarily drops the lock:

qla2xxx/qla_mid.c:qla2x00_do_dpc_all_vps() {
    list_for_each_entry_safe(vp, tvp, &ha->vp_list, list) {
        if (vp->vp_idx) {
            atomic_inc(&vp->vref_count);
            spin_unlock_irqrestore(&ha->vport_slock, flags);

            qla2x00_do_dpc_vp(vp);

            spin_lock_irqsave(&ha->vport_slock, flags);
            atomic_dec(&vp->vref_count);
        }
    }
}

Since list_for_each_entry_safe() caches the next element (tvp), could a
concurrent qla24xx_vport_delete() completely remove and free tvp while the
lock is dropped, leading to a use-after-free when the loop advances?

>  				if (vp_idx =3D=3D vp->vp_idx) {
> +					if (test_bit(VPORT_DELETE, &vp->dpc_flags))
> +						break;

[Severity: Critical]
This isn't a bug introduced by this patch, but does checking VPORT_DELETE
here fully resolve the race condition?

In qla24xx_report_id_acquisition(), the vport_slock is dropped shortly after
this check and the vref_count increment:

qla2xxx/qla_mbx.c:qla24xx_report_id_acquisition() {
    ...
    spin_unlock_irqrestore(&ha->vport_slock, flags);

    if (!found)
        return;

    spin_lock_irqsave(&ha->vport_slock, flags);
    qla_update_host_map(vp, id);
    spin_unlock_irqrestore(&ha->vport_slock, flags);
    ...
}

During the unlocked window, could a concurrent qla24xx_vport_delete()
disable the vport and remove it from host_map?

If so, when the lock is reacquired, qla_update_host_map() would re-insert
the now-dying vport into the btree.

[Severity: High]
This isn't a bug introduced by this patch, but should a similar VPORT_DELETE
check be added to the DPC thread iteration?

In qla2xxx/qla_mid.c:qla2x00_do_dpc_all_vps(), the DPC thread iterates
vp_list and invokes qla2x00_do_dpc_vp(vp) without checking if VPORT_DELETE
is set.

If qla24xx_vport_delete() marks a vport with VPORT_DELETE and disables it
in firmware, could the concurrent DPC thread issue mailbox commands that
inadvertently resurrect the dying vport in firmware?

>  					found =3D 1;
>  					atomic_inc(&vp->vref_count);
>  					break;

[Severity: Critical]
This isn't a bug introduced by this patch, but does the host_map btree have
consistent locking across the driver?

When qla24xx_report_id_acquisition() modifies the btree for physical ports,
it appears to do so without holding vport_slock.

Meanwhile, qla24xx_disable_vp() modifies the btree using hardware_lock
instead of vport_slock:

qla2xxx/qla_mid.c:qla24xx_disable_vp() {
    spin_lock_irqsave(&vha->hw->hardware_lock, flags);
    qla_update_vp_map(vha, RESET_AL_PA);
    spin_unlock_irqrestore(&vha->hw->hardware_lock, flags);
}

Could simultaneous operations from these different threads with
non-overlapping locks cause structural corruption of the btree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707055435.2680=
300-1-njavali@marvell.com?part=3D76

