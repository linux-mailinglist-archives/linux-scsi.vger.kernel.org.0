Return-Path: <linux-scsi+bounces-18342-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A8C033CF
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Oct 2025 21:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3271A68186
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Oct 2025 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D41534FF7F;
	Thu, 23 Oct 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EpIn/fNa"
X-Original-To: linux-scsi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC6A34DB76;
	Thu, 23 Oct 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249185; cv=pass; b=GNyb0tWVq4rui+idwpYXhCzs21UlrA9dPFtDRMoxPa50wE7AMHhdRddbobTpbVDsWt5jAkMuYAgSxXO23Bpp9dREWGIAX6YrjunT6JmjvyQ8LXllFK7L2F+xsil3MwjH+J5r8srV7G8DK+mUbJlb4eC0MUJytsvAMFKNmp26vk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249185; c=relaxed/simple;
	bh=z0slMJauXlWVuNpNVYHccub5EmAQQddYApgNfgaGiiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qE5aeczZJtzj5KxR/dXHjN6ec5IpSCoKICdTdQ3G9ZfaAq2/Qe3kYBqstZtpQebZDeXTvzPf1Hk1W3aG7Z4rarH8DYKcCcnBRAKc2tiKXPnXEB/Zsumv+vlULPVaPOSqLbax9XvEcQoyhDiylfbV8eacgWEajJMAooQgrBtq2ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=EpIn/fNa; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761249028; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UR6Ute5TkYShFb0TCKnimsM0O4MKoQYlt2p1KXab5JN2/SxrhdztWYArEARU+aLkZGFCJtivVw4EzTAIhnsODX2cMsSY+sBNIx6DssqyRRLPGccVTNqwu3FdbySDncX7c70mzZNQzSIUhc1F5VFUkZxjkECyxWpwQhqKZt2IkIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761249028; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Q08dBFOvRvWjsO6y9Vc8FPaqsMyP49sm/FVPkULVzI=; 
	b=Lv7Q8Ngha/SCOcVhcxwU3LaUnqincKTZ+tfAPEh9/lSy5jXwpQCneHZKiE1T34QKMfx2x0WVcjVgVCmlwCXQNiEMUqTR3KooZ1jhLIFWYv5MeEncL/1ax/SaHLwJ28KvMG1W3VK+aq6vZ2ChYTuulNPAN8vS6Iy0yhtyOs1/i74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761249028;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=4Q08dBFOvRvWjsO6y9Vc8FPaqsMyP49sm/FVPkULVzI=;
	b=EpIn/fNauatK9AeVJLlk2SsJv5pE4WmxKjQY+0SbA7UYfYfU09pDwFheHGHZWoW5
	x2e318M9s+g3b2KP9pwUXFxGMcVwWuQCd9eJlRu1JXyUlPuueJdJyX25Uo5klDhru7m
	IuE+RJiKdo3V0jOr16IIJimDauqlMLNNDzXg3tO0=
Received: by mx.zohomail.com with SMTPS id 1761249025896474.2707197528921;
	Thu, 23 Oct 2025 12:50:25 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 23 Oct 2025 21:49:20 +0200
Subject: [PATCH v3 02/24] dt-bindings: ufs: mediatek,ufs: Complete the
 binding
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-mt8196-ufs-v3-2-0f04b4a795ff@collabora.com>
References: <20251023-mt8196-ufs-v3-0-0f04b4a795ff@collabora.com>
In-Reply-To: <20251023-mt8196-ufs-v3-0-0f04b4a795ff@collabora.com>
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
 Mark Brown <broonie@kernel.org>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 kernel@collabora.com, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

As it stands, the mediatek,ufs.yaml binding is startlingly incomplete.
Its one example, which is the only real "user" of this binding in
mainline, uses the deprecated freq-table-hz property.

The resets, of which there are three optional ones, are completely
absent.

The clock description for MT8195 is incomplete, as is the one for
MT8192. It's not known if the one clock binding for MT8183 is even
correct, but I do not have access to the necessary code and
documentation to find this out myself.

The power supply situation is not much better; the binding describes one
required power supply, but uses a supply property from ufs-common.yaml
that can be either 1.8V or 3.3V.

No second example is present in the binding, making verification
difficult.

Disallow freq-table-hz and move to operating-points-v2. It's fine to
break compatibility here, as the binding is currently unused and would
be impossible to correctly use in its current state.

Add the three resets and the corresponding reset-names property. These
resets appear to be optional, i.e. not required for the functioning of
the device.

Move the list of clock names out of the if condition, and expand it for
the confirmed clocks I could find by cross-referencing several clock
drivers. For MT8195, increase the minimum number of clocks to include
the crypt and rx_symbol ones, as they're internal to the SoC and should
always be present, and should therefore not be omitted.

MT8192 gets to have at least 3 clocks, as these were the ones I could
quickly confirm from a glance at various trees. I can't say this was an
exhaustive search though, but it's better than the current situation.

Properly document all supplies, with which pin name on the SoCs they
supply, and what voltage we understand them as. Mandate vcc-supply-1p8,
as vcc-supply appears to always be describing a 1.8V supply. The
ufs-common.yaml vccq/vccq2 supplies are used for this purpose, so that
common UFS implementations which do power management for these don't
have to treat MediaTek's 1.2V supplies in a special way.

Add the missing avdd09-supply, which so far only mt8183 uses.

Also add a MT8195 example to the binding, using supply labels that I am
pretty sure would be the right ones for e.g. the Radxa NIO 12L.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../devicetree/bindings/ufs/mediatek,ufs.yaml      | 115 +++++++++++++++++----
 1 file changed, 97 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 1dec54fb00f3..364672bc65b1 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -18,11 +18,28 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 8
+    maxItems: 13
 
   clock-names:
     minItems: 1
-    maxItems: 8
+    items:
+      - const: ufs
+      - const: ufs_aes
+      - const: ufs_tick
+      - const: unipro_sysclk
+      - const: unipro_tick
+      - const: unipro_mp_bclk
+      - const: ufs_tx_symbol
+      - const: ufs_mem_sub
+      - const: crypt_mux
+      - const: crypt_lp
+      - const: crypt_perf
+      - const: ufs_rx_symbol0
+      - const: ufs_rx_symbol1
+
+  operating-points-v2: true
+
+  freq-table-hz: false
 
   phys:
     maxItems: 1
@@ -30,7 +47,31 @@ properties:
   reg:
     maxItems: 1
 
-  vcc-supply: true
+  resets:
+    items:
+      - description: reset for the UniPro layer
+      - description: reset for the cryptography engine
+      - description: reset for the host controller
+
+  reset-names:
+    items:
+      - const: unipro
+      - const: crypto
+      - const: hci
+
+  avdd09-supply:
+    description: Phandle to the 0.9V supply powering the AVDD09_UFS pin
+
+  vcc-supply:
+    description: Phandle to the 1.8V supply powering the AVDD18_UFS pin
+
+  vcc-supply-1p8: true
+
+  vccq-supply:
+    description: Phandle to the 1.2V supply powering the AVDD12_UFS pin
+
+  vccq2-supply:
+    description: Phandle to the 1.2V supply powering the AVDD12_CKBUF_UFS pin
 
   mediatek,ufs-disable-mcq:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -43,6 +84,7 @@ required:
   - phys
   - reg
   - vcc-supply
+  - vcc-supply-1p8
 
 unevaluatedProperties: false
 
@@ -53,29 +95,41 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - mediatek,mt8195-ufshci
+            const: mediatek,mt8183-ufshci
     then:
       properties:
         clocks:
-          minItems: 8
+          maxItems: 1
         clock-names:
           items:
             - const: ufs
-            - const: ufs_aes
-            - const: ufs_tick
-            - const: unipro_sysclk
-            - const: unipro_tick
-            - const: unipro_mp_bclk
-            - const: ufs_tx_symbol
-            - const: ufs_mem_sub
-    else:
+        vccq2-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8192-ufshci
+    then:
       properties:
         clocks:
-          maxItems: 1
+          minItems: 3
+          maxItems: 3
+        clocks-names:
+          minItems: 3
+          maxItems: 3
+        avdd09-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-ufshci
+    then:
+      properties:
+        clocks:
+          minItems: 13
         clock-names:
-          items:
-            - const: ufs
+          minItems: 13
+        avdd09-supply: false
 
 examples:
   - |
@@ -94,8 +148,33 @@ examples:
 
             clocks = <&infracfg_ao CLK_INFRA_UFS>;
             clock-names = "ufs";
-            freq-table-hz = <0 0>;
 
             vcc-supply = <&mt_pmic_vemc_ldo_reg>;
+            vcc-supply-1p8;
         };
     };
+  - |
+    ufshci@11270000 {
+        compatible = "mediatek,mt8195-ufshci";
+        reg = <0x11270000 0x2300>;
+        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+        phys = <&ufsphy>;
+        clocks = <&infracfg_ao 63>, <&infracfg_ao 64>, <&infracfg_ao 65>,
+                 <&infracfg_ao 54>, <&infracfg_ao 55>,
+                 <&infracfg_ao 56>, <&infracfg_ao 90>,
+                 <&infracfg_ao 93>, <&topckgen 60>, <&topckgen 152>,
+                 <&topckgen 125>, <&topckgen 212>, <&topckgen 215>;
+        clock-names = "ufs", "ufs_aes", "ufs_tick",
+                      "unipro_sysclk", "unipro_tick",
+                      "unipro_mp_bclk", "ufs_tx_symbol",
+                      "ufs_mem_sub", "crypt_mux", "crypt_lp",
+                      "crypt_perf", "ufs_rx_symbol0", "ufs_rx_symbol1";
+
+        operating-points-v2 = <&ufs_opp_table>;
+
+        vcc-supply = <&mt6359_vufs_ldo_reg>;
+        vcc-supply-1p8;
+        vccq-supply = <&mt6359_vrf12_ldo_reg>;
+        vccq2-supply = <&mt6359_vbbck_ldo_reg>;
+        mediatek,ufs-disable-mcq;
+    };

-- 
2.51.1.dirty


