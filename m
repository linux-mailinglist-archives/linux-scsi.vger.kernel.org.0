Return-Path: <linux-scsi+bounces-23045-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B/YKpgg4mlX1wAAu9opvQ
	(envelope-from <linux-scsi+bounces-23045-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 13:59:20 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE60541B022
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C02DB300D556
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF139478F;
	Fri, 17 Apr 2026 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pYNPcNvJ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107D2D5923
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427153; cv=none; b=XkoUtp2W5C4KcrK6csg1H8xqMieLV8GziljL3ZSVLyztLPh21oEFWVC4S24SmS4zCqxn19jhxhL99QT+QaBpd1PuQObpN5WrYNtdfWTJon6FXLbZVhzEAFzdAHyTNV4sYap2KbNwfBSfK8vuSlG82bA/ojuLXsnAM1PycnnJmzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427153; c=relaxed/simple;
	bh=K02Snn3IVf1p6+hyNMpPD51fWmtuska6FUViGDQ8eiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sidm88iq63lwBhNp7Zsgokk4uo0B3CbPFO+KPkwSGmkmfkAB+ODc2g9atHShYyfz0zVGmpLOYcduWXmC7MQTt80oKoADAeJtm/NnO0oqK2uiWFl9GHixp9nRnIPM/kEHzp7QgFpWbss7umvc9rH/so+UyaepTrGpJjbJxqzCjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pYNPcNvJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260417115910epoutp02c6e4dd47ce8a99a8dfbbaa4044807eb8~nIxTHYWUT1893018930epoutp02f
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 11:59:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260417115910epoutp02c6e4dd47ce8a99a8dfbbaa4044807eb8~nIxTHYWUT1893018930epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776427150;
	bh=ojLXeHbC5TlNvceo/oEDKPeYBz7Ith8Rtaarof/EAdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYNPcNvJLqlSsBte0b8lToSabkE7VGI1k5JSrnVkXcNWxg5Xa2XkfBlGRhdVZC4rQ
	 3hmfKy/6USLFarcGY0nPZfa4G+j0jNTJYUR50VGeeA50OyKUBOfXyP8A6DoPjTXC8H
	 WtkUMbEvALt13VpFVrA2yVDuIOLLaNY77KRKjkLw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260417115909epcas5p14de402e43845f76bdabf7f7cf66ca66f~nIxSpTAUE0070100701epcas5p1s;
	Fri, 17 Apr 2026 11:59:09 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fxthX4GWwz2SSKY; Fri, 17 Apr
	2026 11:59:08 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260417115908epcas5p1450496b1b2e333ec1d07c18afd32540c~nIxRMJUh82797527975epcas5p1S;
	Fri, 17 Apr 2026 11:59:08 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260417115901epsmtip2622e58a34699ed1d26ffef78ef3abfe4~nIxLLmJkE0979809798epsmtip2Y;
	Fri, 17 Apr 2026 11:59:01 +0000 (GMT)
From: Alim Akhtar <alim.akhtar@samsung.com>
To: avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	martin.petersen@oracle.com, krzk+dt@kernel.org
Cc: sowon.na@samsung.com, peter.griffin@linaro.org,
	linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Alim Akhtar
	<alim.akhtar@samsung.com>
Subject: [PATCH v2 4/4] arm64: dts: exynosautov920: enable support for ufs
 controller
Date: Fri, 17 Apr 2026 17:44:52 +0530
Message-Id: <20260417121452.827054-5-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417121452.827054-1-alim.akhtar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260417115908epcas5p1450496b1b2e333ec1d07c18afd32540c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260417115908epcas5p1450496b1b2e333ec1d07c18afd32540c
References: <20260417121452.827054-1-alim.akhtar@samsung.com>
	<CGME20260417115908epcas5p1450496b1b2e333ec1d07c18afd32540c@epcas5p1.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-23045-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,16e04000:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alim.akhtar@samsung.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BE60541B022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sowon Na <sowon.na@samsung.com>

Add ufs node for ExynosAutov920 SoC. Also enable ufs_phy and
ufs controller nodes.

Signed-off-by: Sowon Na <sowon.na@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../boot/dts/exynos/exynosautov920-sadk.dts   |  8 +++++++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi | 21 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
index a397f068ed53..5873720c213e 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
@@ -83,6 +83,14 @@ &usi_0 {
 	status = "okay";
 };
 
+&ufs_0 {
+	status = "okay";
+};
+
+&ufs_0_phy {
+	status = "okay";
+};
+
 &xtcxo {
 	clock-frequency = <38400000>;
 };
diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 0eb853770732..f1f5efcdb91e 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -1444,6 +1444,27 @@ pinctrl_hsi2ufs: pinctrl@16d20000 {
 			interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ufs_0: ufs@16e00000 {
+			compatible = "samsung,exynosautov920-ufs";
+			reg = <0x16e00000 0x100>,
+			      <0x16e01100 0x400>,
+			      <0x16e80000 0x8000>,
+			      <0x16d08000 0x800>;
+			reg-names = "hci", "vs_hci", "unipro", "ufsp";
+			interrupts = <GIC_SPI 613 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_hsi2 CLK_MOUT_HSI2_UFS_EMBD_USER>,
+				 <&cmu_hsi2 CLK_MOUT_HSI2_NOC_UFS_USER>;
+			clock-names = "core_clk", "sclk_unipro_main";
+			freq-table-hz = <0 0>, <0 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
+			phys = <&ufs_0_phy>;
+			phy-names = "ufs-phy";
+			samsung,sysreg = <&syscon_hsi2 0x710>;
+			dma-coherent;
+			status = "disabled";
+		};
+
 		ufs_0_phy: phy@16e04000 {
 			compatible = "samsung,exynosautov920-ufs-phy";
 			reg = <0x16e04000 0x4000>;
-- 
2.34.1


