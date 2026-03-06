Return-Path: <linux-scsi+bounces-21550-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EWFDQzWqmn3XQEAu9opvQ
	(envelope-from <linux-scsi+bounces-21550-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 14:26:36 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F52218CD
	for <lists+linux-scsi@lfdr.de>; Fri, 06 Mar 2026 14:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E8230F6661
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2026 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F083976BB;
	Fri,  6 Mar 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RZQP4j2J"
X-Original-To: linux-scsi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748C39903D;
	Fri,  6 Mar 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803544; cv=pass; b=g91474KWfNG++buMKHtP7e67/uuMOR2cddXWhNBJ+aPM05qG4VChHSp6wdM57egKQ4IfX0pyynf3q8VmVm5vtkWiTpG8aaqULaovtoKdsuG118WV6jXhFWohyX5ZGsd6/Y2atwLMecEU4iaGQoCsLQ05PfzXAFJ5ojf4UJjrB8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803544; c=relaxed/simple;
	bh=EypgtlfYshILgwlUk3/w02vtCCXWaUCb7oIkiSqhtWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8KZ7uzWjcSdVDMu7R//x4sY4AKMhIyzHwwAiF8EKfdr4g2KwEtaOJAwtsa0MMCYhw/00B/zlqKkXaCJTiYHOkvjIXvG8XmqNDKKb4c0LPfBIqVCmBodIUuLTxar6pucMEEvcFBo8GkM+ufaAURQMUAGdp7OXomNDTAQvssxXtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=RZQP4j2J; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772803509; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MRgrvv3zLP7EH3uZhGsFFFqYTStidSTuXHi+wiCJ+X1FvErgC6Ynfh/u/I8csJXWXE+KZbEiqhOpyvTWsRLSocSrN7mHORops/lt/+56+kIoTvEhyLdqxb76wRAMkQUsW1TgOqERrT9BGp6ua1C1meLbLcXOPeJFsS8XtNfhLKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772803509; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wIUS+P9KTYwp9LndB8yjQ3RjTNoJrePfDlm02gE6g6U=; 
	b=oBdFsAQQar+5ZxmwKYpb0x7Q6Nb/9L3c/c53yLi7kzvObjzaZBtM6n0Nr9w1YisR1DTBqPJBYfPkbgTQkoqtSS4UgqMadGwx8p6wPKJ48lbvEfvFg12WZBsizBROm7Epv7MQ3e9M7AwctBzkabV/YW6yZ366nU6gOlqu9nMJhZQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772803509;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=wIUS+P9KTYwp9LndB8yjQ3RjTNoJrePfDlm02gE6g6U=;
	b=RZQP4j2JEexlZXHGUFmyijv9A82g4TyduO6X9DqYNrdQYU8I5/ehg5R0mtVXu7w2
	ySkmnRhHWahUElbTyIx5yszoSrsbq5sGrxhok42utZ9n1zsQKkYqdOV9bYMpLBhKutf
	QZ1qNKUQhaV8dom0oaAJmyj+It9MCkiOKyYCE+xk=
Received: by mx.zohomail.com with SMTPS id 1772803507807240.81662629010486;
	Fri, 6 Mar 2026 05:25:07 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 06 Mar 2026 14:24:42 +0100
Subject: [PATCH v9 01/23] dt-bindings: phy: Add mediatek,mt8196-ufsphy
 variant
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-mt8196-ufs-v9-1-55b073f7a830@collabora.com>
References: <20260306-mt8196-ufs-v9-0-55b073f7a830@collabora.com>
In-Reply-To: <20260306-mt8196-ufs-v9-0-55b073f7a830@collabora.com>
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B06F52218CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21550-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[samsung.com,wdc.com,acm.org,kernel.org,gmail.com,collabora.com,mediatek.com,HansenPartnership.com,oracle.com,pengutronix.de,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[1.0.89.0:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email,collabora.com:dkim,collabora.com:email,collabora.com:mid]
X-Rspamd-Action: no action

The MediaTek MT8196 SoC includes an M-PHY compatible with the already
existing mt8183 binding.

However, one omission from the original binding was that all of these
variants may have an optional reset.

Add the new compatible, and also the resets property, with an example.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml
index 6e2edd43fc2a..ee71dfa4e0c0 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,ufs-phy.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8195-ufsphy
+              - mediatek,mt8196-ufsphy
           - const: mediatek,mt8183-ufsphy
       - const: mediatek,mt8183-ufsphy
 
@@ -43,6 +44,10 @@ properties:
       - const: unipro
       - const: mp
 
+  resets:
+    items:
+      - description: Optional UFS M-PHY reset.
+
   "#phy-cells":
     const: 0
 
@@ -66,5 +71,16 @@ examples:
         clock-names = "unipro", "mp";
         #phy-cells = <0>;
     };
+  - |
+    #include <dt-bindings/reset/mediatek,mt8196-resets.h>
+    ufs-phy@16800000 {
+        compatible = "mediatek,mt8196-ufsphy", "mediatek,mt8183-ufsphy";
+        reg = <0x16800000 0x10000>;
+        clocks = <&ufs_ao_clk 3>,
+                 <&ufs_ao_clk 5>;
+        clock-names = "unipro", "mp";
+        resets = <&ufs_ao_clk MT8196_UFSAO_RST0_UFS_MPHY>;
+        #phy-cells = <0>;
+    };
 
 ...

-- 
2.53.0


