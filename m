Return-Path: <linux-scsi+bounces-20605-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPzHHwrSemlX+wEAu9opvQ
	(envelope-from <linux-scsi+bounces-20605-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jan 2026 04:20:42 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E1AB63C
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jan 2026 04:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC2BD3022F48
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Jan 2026 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49C270568;
	Thu, 29 Jan 2026 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y2Id7XJm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBB28C849
	for <linux-scsi@vger.kernel.org>; Thu, 29 Jan 2026 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656830; cv=none; b=nQCvCaDzc9KHZL8Yo+Q1SK8GVLxVYctZYoKYBrGXg7SL/HLj/faj/d3P8ma5DohS48AfXpsaCGY10PuckafVZ6+IsxAuY5TUjM8UNi80bMptvUZCbeW/iYaUezZ1RsG8yCXP+uzh43ACqTIx3CiAX2sTJzvHxEGhJ4GYfQ4I04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656830; c=relaxed/simple;
	bh=1Ii7V88DAH2WXmP8Gyx8c+QC52EAWiHFOqy2t8sbY8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YYRSw9HLaOQkBMOb6djWfpUjwRQz7vPVt8zzrpVgyYJDTWvCh0I/wbuzbnF44mSA7ZdCVrtJinZPsgaKEryg3Bt1TyqCcVNMbCqEl15jO8T26sEIKXCcCqMKmpYJG45VpoOQFaPWVAWzVVtul4POYaojEFfMxtetDZt+6G6TjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y2Id7XJm; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260129032026epoutp0422ff47a45edb8cc3133cafe1e0ff69ab~PFYIN4nN90460404604epoutp04u
	for <linux-scsi@vger.kernel.org>; Thu, 29 Jan 2026 03:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260129032026epoutp0422ff47a45edb8cc3133cafe1e0ff69ab~PFYIN4nN90460404604epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769656826;
	bh=+zoEUws75av8unKfrjyl9GLv3I0yHKz+75I7bVXnS9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2Id7XJmYlIgASjDRF7jF1ZHpSUcsMSv2KmLPdmFeUUnzuMkvQ3Rnjh9Osy4oxuZ1
	 KpxW3zGWU3oDXMH+IdavbaHWUQssB7g7Zy9bTPj8mN3S1RuvCD7kDEp6O4Mz5RE3qa
	 OYxHU60P+8eU2NQG5aCKj7qzFfFYRaHjBNecCPu8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260129032026epcas5p1f04820c0786365a8321feefcb12341cd~PFYH76uFg0140301403epcas5p1l;
	Thu, 29 Jan 2026 03:20:26 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4f1kt14CYBz3hhTF; Thu, 29 Jan
	2026 03:20:25 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260129031043epcas5p36dc864415f55b44ededa232c17d33f39~PFPpQmO-_1803918039epcas5p3X;
	Thu, 29 Jan 2026 03:10:43 +0000 (GMT)
Received: from testpc12933.samsungds.net (unknown [109.105.129.33]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260129031042epsmtip1e2d533838c079fa2d219495b248bf3c4~PFPoHds3H0411304113epsmtip1v;
	Thu, 29 Jan 2026 03:10:42 +0000 (GMT)
From: "zheng.gong" <zheng.gong@samsung.com>
To: linux-scsi@vger.kernel.org
Cc: avri.altman@wdc.com, bvanassche@acm.org, quic_cang@quicinc.com,
	alim.akhtar@samsung.com, martin.petersen@oracle.com, ebiggers@kernel.org,
	linux-kernel@vger.kernel.org, "zheng.gong" <zheng.gong@samsung.com>
Subject: [PATCH v4 2/3] scsi: ufs: exynos: Support crypto keyslot remapping
 via DT
Date: Thu, 29 Jan 2026 11:10:32 +0800
Message-ID: <20260129031033.3428295-3-zheng.gong@samsung.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129031033.3428295-1-zheng.gong@samsung.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260129031043epcas5p36dc864415f55b44ededa232c17d33f39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260129031043epcas5p36dc864415f55b44ededa232c17d33f39
References: <20251112031035.GA2832160@google.com>
	<20260129031033.3428295-1-zheng.gong@samsung.com>
	<CGME20260129031043epcas5p36dc864415f55b44ededa232c17d33f39@epcas5p3.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20605-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zheng.gong@samsung.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2C4E1AB63C
X-Rspamd-Action: no action

Add support for crypto keyslot remapping in the exynos UFS driver using
the device tree property 'ufs-keyslot-offset'.

This allows platforms to apply a fixed offset to the logical keyslot,
enabling secure inline encryption in virtualized or multi-domain
environments.

The implementation is generic and optional which only active if the DT
property is present.

Signed-off-by: zheng.gong <zheng.gong@samsung.com>
---
 drivers/ufs/host/ufs-exynos.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 70d195179eba..dc63900ebbee 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1437,6 +1437,19 @@ static int exynos_ufs_fmp_fill_prdt(struct ufs_hba *hba,
 	return 0;
 }
 
+static void exynos_ufs_fmp_crypto_keyslot_remap(struct ufs_hba *hba,
+				    struct ufshcd_lrb *lrbp)
+{
+	struct device_node *np = hba->dev->of_node;
+	u32 offset;
+
+	/* If dt property is not present, use identity mapping still.*/
+	if (of_property_read_u32(np, "ufs-keyslot-offset", &offset) == 0) {
+		if (lrbp->crypto_key_slot >= 0)
+			lrbp->crypto_key_slot += offset;
+	}
+}
+
 #else /* CONFIG_SCSI_UFS_CRYPTO */
 
 static void exynos_ufs_fmp_init(struct ufs_hba *hba, struct exynos_ufs *ufs)
@@ -1449,6 +1462,8 @@ static void exynos_ufs_fmp_resume(struct ufs_hba *hba)
 
 #define exynos_ufs_fmp_fill_prdt NULL
 
+#define exynos_ufs_fmp_crypto_keyslot_remap NULL
+
 #endif /* !CONFIG_SCSI_UFS_CRYPTO */
 
 static int exynos_ufs_init(struct ufs_hba *hba)
@@ -2013,6 +2028,7 @@ static const struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
 	.suspend			= exynos_ufs_suspend,
 	.resume				= exynos_ufs_resume,
 	.fill_crypto_prdt		= exynos_ufs_fmp_fill_prdt,
+	.crypto_keyslot_remap = exynos_ufs_fmp_crypto_keyslot_remap,
 };
 
 static struct ufs_hba_variant_ops ufs_hba_exynosauto_vh_ops = {
-- 
2.50.1


