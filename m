Return-Path: <linux-scsi+bounces-4562-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2368A4977
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Apr 2024 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A46BB23093
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Apr 2024 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1CC381C4;
	Mon, 15 Apr 2024 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="06YlTsWS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5602E851;
	Mon, 15 Apr 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167663; cv=none; b=AciU1TuGNKEMMtUDc4z0iD5soNksM3faD3hIvnwHi3fXlBGCyCXkNnz/zZp1Mt6LjFqcOW7Y7mjGmP+rXwonPeRll76kyor4meg8gRvG9HPXsBhR03LptbtLuEHT/Jz7a6A8qf2gRzML8P5RKQkEdwq2nD9eQ11Dew+rET7Z2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167663; c=relaxed/simple;
	bh=WY8EthFDmZfJZmt27wVTY3epf3S/NvCwlH2R04NWsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKUsy53HHRSglMpRo6nBhOfKGA01lWDPuFM+gS56suBZuk8+N0B4OCwC77qZUJQhxvLJwHhBs17DZeonfCIdkE+yuxKBuZ9fixoOceGEv4PyjYFIvvzCQSuJlG53yhY4IWTRZwAks+GqFkaZ0DlyGMg7yw+yFQkqB5vZQeWfWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=06YlTsWS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713167655;
	bh=WY8EthFDmZfJZmt27wVTY3epf3S/NvCwlH2R04NWsW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=06YlTsWSw3P6sipl21AV67ZJAklMLTB1VvDKsbs4zFwaFu9kNK/aopglKAGrhMTlQ
	 6pPzsjN2z7W8PGAwfP/0BNYqYx7AfxMJAYIWlbWxnhbFxmI7slGXJzKh5pq+EtFtD4
	 ybNyWDa/8+iUwWz4kKwvXpRLQDINSuBsV8y3/rHlCu3e52BFqp2f3A1KT3PADf6YW9
	 Dc+RlzmFpEIEEPKJuyWkyDLRQI6szHjKkZPKPpN1+6iupPQ9lQLom16OTXTXSn4F+w
	 mYl/qiwedGS1CdXv/k6ekANa3L4Cu7ZXor01RrCFyxR/0dhPU/36i+9pJ/RzwEJPUT
	 haRALaePvEhEQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CEA123782043;
	Mon, 15 Apr 2024 07:54:13 +0000 (UTC)
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
Subject: [PATCH v3 2/8] scsi: ufs: ufs-mediatek: Fix property name for crypt boost voltage
Date: Mon, 15 Apr 2024 09:54:00 +0200
Message-ID: <20240415075406.47543-3-angelogioacchino.delregno@collabora.com>
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

Rename "boost-crypt-vcore-min" to "mediatek,boost-crypt-microvolt":
this is a vendor specific property and needs the "mediatek," prefix,
moreover, this is not defining a minimum voltage per-se;

Even if technically a call to regulator_set_voltage() does indeed
internally set a VMIN for a regulator, the API also supports other
calls to set VMIN-VMAX constraints, so this "vcore-min"->"microvolt"
rename is performed in order to avoid confusion, other than adding
the "microvolt" suffix to it (as this does take microvolts!).

Fixes: 590b0d2372fe ("scsi: ufs-mediatek: Support performance mode for inline encryption engine")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/ufs/host/ufs-mediatek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index e4643ac49033..688d85909ad6 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -595,9 +595,9 @@ static void ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
 		goto disable_caps;
 	}
 
-	if (of_property_read_u32(dev->of_node, "boost-crypt-vcore-min",
+	if (of_property_read_u32(dev->of_node, "mediatek,boost-crypt-microvolt",
 				 &volt)) {
-		dev_info(dev, "failed to get boost-crypt-vcore-min");
+		dev_info(dev, "failed to get mediatek,boost-crypt-microvolt");
 		goto disable_caps;
 	}
 
-- 
2.44.0


