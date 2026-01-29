Return-Path: <linux-scsi+bounces-20610-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iInrG8T8emlyAQIAu9opvQ
	(envelope-from <linux-scsi+bounces-20610-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jan 2026 07:23:00 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C43E5AC319
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jan 2026 07:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06DE3015709
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jan 2026 06:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A942D838B;
	Thu, 29 Jan 2026 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CHklQ68o"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C21E5B70
	for <linux-scsi@vger.kernel.org>; Thu, 29 Jan 2026 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667776; cv=none; b=DPbWmFg2ktTIIExKUi3bwPRoNtwugwPYqtGHavuX+HrfCuU+zqqP2tEvhjtNU/CEWcDALqZUjnYlavLwtLjkt5AR4+veQ5wHV44ibg0yVG8LmH3Nr5tdDo96M9y581JwNDuKHnnv1NKanNftO9D2CeTzQvmCGnSk3woqDI8CW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667776; c=relaxed/simple;
	bh=I6Fr/YujG5kY3udIbUtO/8Cp56SbxfDZQHhbtQwkX2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JiuTiopEDGzeQQAm+Cf+6L4B+9eYXFQt+hBH9uIGc7dGRg3Qtwt1OCOtxMIXz59Itc6p/CUhY17wz9HHyFKC9YrllXpC353G4lvtbkApZgyuySU/IfBmtuBMzss4D4Nx2M8ghGXFiuv0uYmrxezkzzZIo0XhoJSTG9GtJy8fKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CHklQ68o; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260129062252epoutp034b2a9b6b3c7f18e2d6c2a25cea3e8c5d~PH3aQzxoQ1058910589epoutp03g
	for <linux-scsi@vger.kernel.org>; Thu, 29 Jan 2026 06:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260129062252epoutp034b2a9b6b3c7f18e2d6c2a25cea3e8c5d~PH3aQzxoQ1058910589epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769667772;
	bh=jph+wUnLlCRFQcr4iB2hzFiOjy3APcOw4EwJOk+Udiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHklQ68o69JoOnK4vIe++2GJJpT2VMHME4EmGEWsG4/Di6CHb9Kj25f6Hol19lNKC
	 dkb2GYXla0JPjF0PkR1VElpJHMxUbl89HIuU9s2F7J1bPDRTxxzsVryvfLKgo0kSWm
	 j7EuMoE7SzdFsdY92Ad+E0EagKy9wIlyrGkriBKg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260129062252epcas5p4d48892413c8ae46091faab70f0dd5b20~PH3Z3DRO91933119331epcas5p46;
	Thu, 29 Jan 2026 06:22:52 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f1pwW174Jz6B9m6; Thu, 29 Jan
	2026 06:22:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260129061800epcas5p27ea107df6d3b296e4a63d948a8d6af17~PHzKkQigs2810128101epcas5p2m;
	Thu, 29 Jan 2026 06:18:00 +0000 (GMT)
Received: from testpc12933.samsungds.net (unknown [109.105.129.33]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260129061759epsmtip282fc76f950b7432ee8e62dfe060a6ccc~PHzJn5IiV2848628486epsmtip2K;
	Thu, 29 Jan 2026 06:17:59 +0000 (GMT)
From: "zheng.gong" <zheng.gong@samsung.com>
To: linux-scsi@vger.kernel.org
Cc: avri.altman@wdc.com, bvanassche@acm.org, quic_cang@quicinc.com,
	alim.akhtar@samsung.com, martin.petersen@oracle.com, ebiggers@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v4 0/3] scsi: ufs: Add crypto_keyslot_remap support
Date: Thu, 29 Jan 2026 14:17:58 +0800
Message-ID: <20260129061758.329806-1-zheng.gong@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112031035.GA2832160@google.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260129061800epcas5p27ea107df6d3b296e4a63d948a8d6af17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260129061800epcas5p27ea107df6d3b296e4a63d948a8d6af17
References: <20251112031035.GA2832160@google.com>
	<CGME20260129061800epcas5p27ea107df6d3b296e4a63d948a8d6af17@epcas5p2.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20610-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FROM_NEQ_ENVFROM(0.00)[zheng.gong@samsung.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C43E5AC319
X-Rspamd-Action: no action

Hi Eric,

Thank you for ur kind question. I understand your concern.
the confusion arises from the coexistence of two different UFS drivers on Exynos platforms.

There are two distinct UFS host controller implementations on Samsung Exynos:
- ufs-exynos.c
- ufs-exynosautovX.c

But ufs-exynosautovX is not mainlined, which:
- Uses a hardware crypto engine that does support keyslots
- Assigns keyslots to VMs (e.g., QNX, Linux, Android)
- Needs to remap logical keyslot + VM-specific offset at request time

We added a minimal, DT-based remap in ufs-exynos.c not because mobile uses it, but to:
- Prove that the hook has a real, upstream-mergeable use pattern
- Show that the mechanism can be used by actual platform

It is a generic, not tied to one usecase.

As for how we use it in our platform.

In our driver, we implement as like:

void exynos_ufs_fmp_crypto_keyslot_remap(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
{
    struct exynosauto_ufs *ufs = to_exynosauto_ufs(hba);
    u32 vm_id = ufs->iov->vm_id;
    u32 offset = vm_id * UFS_KEYSLOTS;

    if (lrbp->crypto_key_slot >= 0)
        lrbp->crypto_key_slot += offset;
}

We have tested this on ExynosAuto V920 platform with:
4 virtual machines: QNX, Linux, Linux, Android.
Each VM has its own UFS VH and keyslot range as per allocation.
Inline encryption is enabled for all VMs. offset is configured in dt for each VH node.

Despite driver resides in our out-of-tree exynosauto-modules and cannot be upstreamed easily,
but the use case is real and actively used in production platform.

To help move this forward, could you please let us know what additional 
information or changes would be needed to make this patch acceptable?

If it is not plausible for mainline, do u have any suggestion in terms of this kind of case?

Appreciate it.



