Return-Path: <linux-scsi+bounces-4565-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62C8A497E
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Apr 2024 09:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3741C23328
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Apr 2024 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F423FB1C;
	Mon, 15 Apr 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZKPPlpTz"
X-Original-To: linux-scsi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FE3987B;
	Mon, 15 Apr 2024 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167665; cv=none; b=TP2XN3Oc8b6gePBRw1125JJ9Jq0fGm0jc3rp0/FlZ4MEREO8zpvpu/JjfiuSkVD+28RmjdRJu1g9W3eLaV/IEr5kRYwVfILECQTiM2jrHlZLw2HyeH8VRO9LOxQtxJRx/lERUbhC4O+usPX2gTOkpqL5CyMkHGHoVlLOthi+3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167665; c=relaxed/simple;
	bh=oAmHrFWJ0AgBwXeTr9PuBA8AXz2vtp9jcoIAQcxeovA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlVUsYbW7I+gsPiYJQ0g/caxn9MWxrDq8BiffL5H17MuEagb828gbdhbMup+ue1Z00BgLDyVtx7cTNWUgcAnCUb2PZuN7irZufuxbvJ6Tgykginb+48Vm/G/KILyKx6cILCef8IsNEU9y85xmJnEw9eDWJ9q4uzIKa/S8kwxKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZKPPlpTz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713167656;
	bh=oAmHrFWJ0AgBwXeTr9PuBA8AXz2vtp9jcoIAQcxeovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKPPlpTz8SDFqpqWbYvPH5KR4ujFHnwh1dhPCRq26AkMayZRWSWfrPDQPbVJrFPHu
	 QbfmHN9sGDXMAg5pzHTt+8RP1wxtyYO47G8XlMQZfdMczZB8rq+2jkFznM+VnGMp3r
	 ovxzcASnJqVFggahRJkGXCinBkbxNq5zEPspyQkNZYepk4Ygy0I2T7z0aRcjbL15da
	 HAc3rQNqm7XAGupQXlsPdQf8M3Gu/o0pXQcF95PwDUi6nGaUo3NCdcfK7mlJJ3SeCW
	 iom0ePaCcrsP/eiK6ulfDirRpL9SbW6mZ2BEq0q/ERR1JDUIJQmzdSQtILd45B23jG
	 ZLDEBxp72ARAw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6674937820A4;
	Mon, 15 Apr 2024 07:54:15 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	chu.stanley@gmail.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/8] scsi: ufs: ufs-mediatek: Remove useless mediatek,ufs-boost-crypt property
Date: Mon, 15 Apr 2024 09:54:01 +0200
Message-ID: <20240415075406.47543-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415075406.47543-1-angelogioacchino.delregno@collabora.com>
References: <20240415075406.47543-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to have a property that activates the inline crypto
boost feature, as this needs many things: a regulator, three clocks,
and the mediatek,boost-crypt-microvolt property to be set.

If any one of these is missing, the feature won't be activated,
hence, it is useless to have yet one more property to enable that.

While at it, also address another two issues:
1. Give back the return value to the caller and make sure to fail
   probing if we get an -EPROBE_DEFER or -ENOMEM; and
2. Free the ufs_mtk_crypt_cfg structure allocated in the crypto
   boost function if said functionality could not be enabled because
   it's not supported, as that'd be only wasted memory.

Last but not least, move the devm_kzalloc() call for ufs_mtk_crypt_cfg
to after getting the dvfsrc-vcore regulator and the boost microvolt
property, as if those fail there's no reason to even allocate that.

Fixes: ac8c2459091c ("scsi: ufs-mediatek: Decouple features from platform bindings")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/ufs/host/ufs-mediatek.c | 55 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 688d85909ad6..47f16e6720f4 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -575,51 +575,55 @@ static int ufs_mtk_init_host_clk(struct ufs_hba *hba, const char *name,
 	return ret;
 }
 
-static void ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
+static int ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
 	struct ufs_mtk_crypt_cfg *cfg;
 	struct device *dev = hba->dev;
 	struct regulator *reg;
 	u32 volt;
-
-	host->crypt = devm_kzalloc(dev, sizeof(*(host->crypt)),
-				   GFP_KERNEL);
-	if (!host->crypt)
-		goto disable_caps;
+	int ret;
 
 	reg = devm_regulator_get_optional(dev, "dvfsrc-vcore");
 	if (IS_ERR(reg)) {
-		dev_info(dev, "failed to get dvfsrc-vcore: %ld",
-			 PTR_ERR(reg));
-		goto disable_caps;
+		ret = PTR_ERR(reg);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		return 0;
 	}
 
-	if (of_property_read_u32(dev->of_node, "mediatek,boost-crypt-microvolt",
-				 &volt)) {
+	ret = of_property_read_u32(dev->of_node, "mediatek,boost-crypt-microvolt", &volt);
+	if (ret) {
 		dev_info(dev, "failed to get mediatek,boost-crypt-microvolt");
-		goto disable_caps;
+		return 0;
 	}
 
+	host->crypt = devm_kzalloc(dev, sizeof(*host->crypt), GFP_KERNEL);
+	if (!host->crypt)
+		return -ENOMEM;
+
 	cfg = host->crypt;
-	if (ufs_mtk_init_host_clk(hba, "crypt_mux",
-				  &cfg->clk_crypt_mux))
-		goto disable_caps;
+	ret = ufs_mtk_init_host_clk(hba, "crypt_mux", &cfg->clk_crypt_mux);
+	if (ret)
+		goto out;
 
-	if (ufs_mtk_init_host_clk(hba, "crypt_lp",
-				  &cfg->clk_crypt_lp))
-		goto disable_caps;
+	ret = ufs_mtk_init_host_clk(hba, "crypt_lp", &cfg->clk_crypt_lp);
+	if (ret)
+		goto out;
 
-	if (ufs_mtk_init_host_clk(hba, "crypt_perf",
-				  &cfg->clk_crypt_perf))
-		goto disable_caps;
+	ret = ufs_mtk_init_host_clk(hba, "crypt_perf", &cfg->clk_crypt_perf);
+	if (ret)
+		goto out;
 
 	cfg->reg_vcore = reg;
 	cfg->vcore_volt = volt;
 	host->caps |= UFS_MTK_CAP_BOOST_CRYPT_ENGINE;
 
-disable_caps:
-	return;
+out:
+	if (ret)
+		devm_kfree(dev, host->crypt);
+	return 0;
 }
 
 static int ufs_mtk_init_va09_pwr_ctrl(struct ufs_hba *hba)
@@ -648,8 +652,9 @@ static int ufs_mtk_init_host_caps(struct ufs_hba *hba)
 	struct device_node *np = hba->dev->of_node;
 	int ret;
 
-	if (of_property_read_bool(np, "mediatek,ufs-boost-crypt"))
-		ufs_mtk_init_boost_crypt(hba);
+	ret = ufs_mtk_init_boost_crypt(hba);
+	if (ret)
+		return ret;
 
 	ret = ufs_mtk_init_va09_pwr_ctrl(hba);
 	if (ret)
-- 
2.44.0


