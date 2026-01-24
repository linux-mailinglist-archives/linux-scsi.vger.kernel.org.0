Return-Path: <linux-scsi+bounces-20504-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFcRI960dGkM9AAAu9opvQ
	(envelope-from <linux-scsi+bounces-20504-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Jan 2026 13:02:38 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BA07D716
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Jan 2026 13:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 463183008C1D
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Jan 2026 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805882DD5EF;
	Sat, 24 Jan 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hfl8zwFa"
X-Original-To: linux-scsi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864B2DBF4B;
	Sat, 24 Jan 2026 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769256131; cv=pass; b=gnCPlHGdCngg5qbnBkyigHlS2Skt479IK4y3kcRGc6SRwFrFpVgO2T/iisSUl/VCwHQef/+CaloynttXyIhcfTP1BwmXf21YZ7/jT6BV6/xNFCCTvh0hrH5EVcu6VFTOzng1HZaAE4h3qzVBGIe9I6uFUEv0I52Ju6kRhZTonY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769256131; c=relaxed/simple;
	bh=aKBv9dRlPqJEyB5f1AzJP5S1FvnsXLvudKhWsJblC2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MiOL17b5TWacLN/LWHmOeHIWsn4vzU4Tr5+9EONbf+oUK9AyW9hRe3GS5jfjsrXN1ymSnEq6fkGs1w+iGM0M6nq1rNwM7l/F8Yfj1/0CSm/8Ym7224Pe1eU1Cgj55l1tPKdyB/4HXRtMa5+V/ooyvufenoNsyt4RihLnxaWDN2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=hfl8zwFa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769256102; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NEP7rzGr9m6NvVSlNiNCzliDpUdCyxrwwO+wloILzHJbH+w9jACFimoGHuJFa6yA4ZoAq7RPh2QHWiOH8tLRnsECiHlIQUp39vfp5N2e0ElOIcAYBvo0KozDFdN3M4qtHK/LcF0bpSidOIL11xGk5mSWWPSjCuOwMSRdJdYzEVY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769256102; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k6vK7KNn0dooA0o4T40v3iTaTQUjchuIY4rvSJnYECk=; 
	b=H5tjR7ptwsFDe6nKVuqm0AMfoyBffmlQ32BuHQVGRftQ8jLpvgLHS8EyCmsKmxykHZ55QajNfb+bfi5tPoknk6bHAG3+pjyjzWG4E9IyhYXNngiXj8+gITuQBP5D90nRNvRsrm4JSvHc9F+QVqFCs4xPddkGqmYGFhWCzYnsuIE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769256102;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=k6vK7KNn0dooA0o4T40v3iTaTQUjchuIY4rvSJnYECk=;
	b=hfl8zwFayPE8rZ6IPezQ8cRmM0psH0jdAKJixnK+evu48Eh3muIsr2vOK97xWSVK
	HpFS6meANEgacu8labyOYPEktmSJP6Qt2MW7ci20UGAX0RPPKVPVx3muguJPLd1yvl/
	AGDNhkzxJFK5NIIEoaSlGLbdkGvdC51g/LRquBIo=
Received: by mx.zohomail.com with SMTPS id 1769256101593739.5738922352265;
	Sat, 24 Jan 2026 04:01:41 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 24 Jan 2026 13:00:51 +0100
Subject: [PATCH v6 05/24] phy: mediatek: ufs: Add support for resets
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260124-mt8196-ufs-v6-5-e7c005b60028@collabora.com>
References: <20260124-mt8196-ufs-v6-0-e7c005b60028@collabora.com>
In-Reply-To: <20260124-mt8196-ufs-v6-0-e7c005b60028@collabora.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Peter Wang <peter.wang@mediatek.com>, Stanley Jhu <chu.stanley@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Chaotian Jing <Chaotian.Jing@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 kernel@collabora.com, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20504-lists,linux-scsi=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,wdc.com,acm.org,kernel.org,gmail.com,collabora.com,mediatek.com,HansenPartnership.com,oracle.com,pengutronix.de,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,collabora.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23BA07D716
X-Rspamd-Action: no action

The MediaTek UFS PHY supports PHY resets. Until now, they've been
implemented in the UFS host driver. Since they were never documented in
the UFS HCI node's DT bindings, and no mainline DT uses it, it's fine if
it's moved to the correct location, which is the PHY driver.

Implement the MPHY reset logic in this driver and expose it through the
phy subsystem's reset op. The reset itself is optional, as judging by
other mainline devices that use this hardware, it's not required for the
device to function.

If no reset is present, the reset op returns -EOPNOTSUPP, which means
that the ufshci driver can detect it's present and not double sleep in
its own reset function, where it will call the phy reset.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-ufs.c | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
index 0cb5a25b1b7a..48f8e4dbf928 100644
--- a/drivers/phy/mediatek/phy-mtk-ufs.c
+++ b/drivers/phy/mediatek/phy-mtk-ufs.c
@@ -4,6 +4,7 @@
  * Author: Stanley Chu <stanley.chu@mediatek.com>
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -11,6 +12,8 @@
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
 
 #include "phy-mtk-io.h"
 
@@ -36,9 +39,17 @@
 
 #define UFSPHY_CLKS_CNT    2
 
+#define UFS_MTK_SIP_MPHY_CTRL       BIT(8)
+
+enum ufs_mtk_mphy_op {
+	UFS_MPHY_BACKUP = 0,
+	UFS_MPHY_RESTORE
+};
+
 struct ufs_mtk_phy {
 	struct device *dev;
 	void __iomem *mmio;
+	struct reset_control *reset;
 	struct clk_bulk_data clks[UFSPHY_CLKS_CNT];
 };
 
@@ -141,9 +152,59 @@ static int ufs_mtk_phy_power_off(struct phy *generic_phy)
 	return 0;
 }
 
+static int ufs_mtk_phy_ctrl(struct ufs_mtk_phy *phy, enum ufs_mtk_mphy_op op)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(MTK_SIP_UFS_CONTROL, UFS_MTK_SIP_MPHY_CTRL, op,
+		      0, 0, 0, 0, 0, &res);
+
+	switch (res.a0) {
+	case SMCCC_RET_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	case SMCCC_RET_INVALID_PARAMETER:
+		return -EINVAL;
+	default:
+		return 0;
+	}
+}
+
+static int ufs_mtk_phy_reset(struct phy *generic_phy)
+{
+	struct ufs_mtk_phy *phy = get_ufs_mtk_phy(generic_phy);
+	int ret;
+
+	if (!phy->reset)
+		return -EOPNOTSUPP;
+
+	ret = reset_control_assert(phy->reset);
+	if (ret)
+		return ret;
+
+	usleep_range(100, 110);
+
+	ret = reset_control_deassert(phy->reset);
+	if (ret)
+		return ret;
+
+	/*
+	 * To avoid double-sleep and other unintended side-effects in the ufshci
+	 * driver, don't return the phy_ctrl retval here, but just return -EPROTO.
+	 */
+	ret = ufs_mtk_phy_ctrl(phy, UFS_MPHY_RESTORE);
+	if (ret) {
+		dev_err(phy->dev, "UFS_MPHY_RESTORE SMC command failed: %pe\n",
+			ERR_PTR(ret));
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
 static const struct phy_ops ufs_mtk_phy_ops = {
 	.power_on       = ufs_mtk_phy_power_on,
 	.power_off      = ufs_mtk_phy_power_off,
+	.reset          = ufs_mtk_phy_reset,
 	.owner          = THIS_MODULE,
 };
 
@@ -163,8 +224,18 @@ static int ufs_mtk_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(phy->mmio))
 		return PTR_ERR(phy->mmio);
 
+	phy->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(phy->reset))
+		return dev_err_probe(dev, PTR_ERR(phy->reset), "Failed to get reset\n");
+
 	phy->dev = dev;
 
+	if (phy->reset) {
+		ret = ufs_mtk_phy_ctrl(phy, UFS_MPHY_BACKUP);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to back up MPHY\n");
+	}
+
 	ret = ufs_mtk_phy_clk_init(phy);
 	if (ret)
 		return ret;

-- 
2.52.0


