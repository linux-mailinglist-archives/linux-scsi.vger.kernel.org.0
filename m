Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFF14BCA03
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Feb 2022 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiBSSm7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Feb 2022 13:42:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242854AbiBSSm6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Feb 2022 13:42:58 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AB27174
        for <linux-scsi@vger.kernel.org>; Sat, 19 Feb 2022 10:42:36 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E67F0402E6
        for <linux-scsi@vger.kernel.org>; Sat, 19 Feb 2022 18:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645296149;
        bh=IpayMm2NDayFRCQpyYNgxkcMgu4j6Y5WdNwFaqdKRKg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZLXcSJpd0nqLvRXFrh/KnKLS3v5sd4NFUGrZuL5jBpXbQzWGGwx2V1JsM2yZDVofT
         FlSbmi1vGsyBIPJfCKik0x8hk63XjV9zm8nxIPVF/vkm7rocT0am260YuWy7/hCrIt
         bowm3YZRqt/p9I9WMN5j7TNOuNO86LqUSTHk3I5m+i+H6dnHPstk6MAqj8ITAJGtRn
         mF/0+DdyCLvYg0D21hY3EsOghdLt9ZIFMumS5QCNnmmEVjhO5aAxvhTRtpzK4BftQR
         3PXgH2r+rnBmcdoSSHOeYFFpzl12jDLMv70+IAttXkYvk9KOo3swAL4Fzh4y3sWv+T
         k39mM6ULn+UIQ==
Received: by mail-ed1-f71.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so7419866edo.22
        for <linux-scsi@vger.kernel.org>; Sat, 19 Feb 2022 10:42:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpayMm2NDayFRCQpyYNgxkcMgu4j6Y5WdNwFaqdKRKg=;
        b=xoSR4cSjseLdzHcloQ/IpD0/zvip6ds1gwLefWSF2STGluJnFf/vng4EKfbqibxYIc
         dVDM1/hLzGItM3Xm2bb+sXldIe63tXT53Kn7+ZhORDYWyDU4OKJEFlLN5Bz60X3O37ef
         bsD3qqKHAMj4eJWVJ/ysVMYYNNJ1O57fBM+ki92fVc5sGxJiW/V+fkzgTE7w3O9UkzVg
         +n/Fc1p/DDWEsx/xsbxeLHVvgKkLTH+UpJ7/BdodGD1WHMRFc5WBtviptrgEisb6q4Jk
         Ag07bkByOUjBS0EUOIAS+cQ1hvej1zbbLX2fPRGm0RqppPwOWta3HaLJKGdDJeOoGoG5
         8OGw==
X-Gm-Message-State: AOAM5324bgoxogUur5FuhaMX3ZhTm1e7Uj5b6N83oVPxB0Qle+mpfHxp
        KL4ccszWW5/Za0JEHOiBO6b7RRFqifLGyIy28mmXIGzp94zPL8QdMZbeBSC18SxLUFnQe/HvCym
        /TJ9fOzsBs/Ilt8ynjEv+G+2RoS7xgr3L82Zu1uM=
X-Received: by 2002:a17:906:63d2:b0:6cf:e170:16a with SMTP id u18-20020a17090663d200b006cfe170016amr10538670ejk.119.1645296149574;
        Sat, 19 Feb 2022 10:42:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiqM564la9f2+z2rcYkrfPS7xmkgG7xKR2Hwt606HpXjoo9oUDMPgqlHColfMRdxWcckR6vg==
X-Received: by 2002:a17:906:63d2:b0:6cf:e170:16a with SMTP id u18-20020a17090663d200b006cfe170016amr10538653ejk.119.1645296149312;
        Sat, 19 Feb 2022 10:42:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j8sm6680745edw.40.2022.02.19.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:42:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 1/8] dt-bindings: ufs: add common platform bindings
Date:   Sat, 19 Feb 2022 19:42:17 +0100
Message-Id: <20220219184224.44339-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add bindings for common parts (platform) of Universal Flash Storage
(UFS) Host Controllers in dtschema format.

The 'freq-table-hz' is not correct in dtschema, because '-hz' suffix
defines uint32 type, not an array.  Therefore deprecate 'freq-table-hz'
and use 'freq-table' instead.

Include also the bindings directory in UFS maintainers entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |  2 +-
 .../devicetree/bindings/ufs/ufs-common.yaml   | 86 +++++++++++++++++++
 .../devicetree/bindings/ufs/ufs-hisi.txt      |  4 +-
 MAINTAINERS                                   |  1 +
 4 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml

diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
index 4d13e6bc1c50..dc93fe2d3458 100644
--- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
@@ -80,7 +80,7 @@ examples:
                 compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
                 reg = <0x0 0x4000 0x0 0x10000>;
                 interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-                freq-table-hz = <19200000 19200000>;
+                freq-table = <19200000 19200000>;
                 power-domains = <&k3_pds 277>;
                 clocks = <&k3_clks 277 1>;
                 assigned-clocks = <&k3_clks 277 1>;
diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
new file mode 100644
index 000000000000..66d0612b9991
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/ufs-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for Universal Flash Storage (UFS) Host Controllers
+
+maintainers:
+  - Alim Akhtar <alim.akhtar@samsung.com>
+  - Avri Altman <avri.altman@wdc.com>
+
+properties:
+  clocks: true
+
+  clock-names: true
+
+  freq-table-hz:
+    deprecated: true
+    description:
+      Use freq-table.
+
+  freq-table:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 64
+    description: |
+      Array of <min max> operating frequencies in Hz stored in the same order
+      as the clocks property. If this property is not defined or a value in the
+      array is "0" then it is assumed that the frequency is set by the parent
+      clock or a fixed rate clock source.
+
+  interrupts:
+    maxItems: 1
+
+  lanes-per-direction:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    default: 2
+    description:
+      Number of lanes available per direction.  Note that it is assume same
+      number of lanes is used both directions at once.
+
+  vdd-hba-supply:
+    description:
+      Phandle to UFS host controller supply regulator node.
+
+  vcc-supply:
+    description:
+      Phandle to VCC supply regulator node.
+
+  vccq-supply:
+    description:
+      Phandle to VCCQ supply regulator node.
+
+  vccq2-supply:
+    description:
+      Phandle to VCCQ2 supply regulator node.
+
+  vcc-supply-1p8:
+    type: boolean
+    description:
+      For embedded UFS devices, valid VCC range is 1.7-1.95V or 2.7-3.6V. This
+      boolean property when set, specifies to use low voltage range of
+      1.7-1.95V. Note for external UFS cards this property is invalid and valid
+      VCC range is always 2.7-3.6V.
+
+  vcc-max-microamp:
+    description:
+      Specifies max. load that can be drawn from VCC supply.
+
+  vccq-max-microamp:
+    description:
+      Specifies max. load that can be drawn from VCCQ supply.
+
+  vccq2-max-microamp:
+    description:
+      Specifies max. load that can be drawn from VCCQ2 supply.
+
+dependencies:
+  freq-table: [ 'clocks' ]
+
+required:
+  - interrupts
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
index 0b83df1a5418..7e9cf4cff3d3 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
@@ -14,7 +14,7 @@ Required properties:
 - clocks	        : List of phandle and clock specifier pairs
 - clock-names       : List of clock input name strings sorted in the same
 					order as the clocks property. "ref_clk", "phy_clk" is optional
-- freq-table-hz     : Array of <min max> operating frequencies stored in the same
+- freq-table        : Array of <min max> operating frequencies stored in the same
                       order as the clocks property. If this property is not
                       defined or a value in the array is "0" then it is assumed
                       that the frequency is set by the parent clock or a
@@ -35,7 +35,7 @@ Example:
 		clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
 			<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
 		clock-names = "ref_clk", "phy_clk";
-		freq-table-hz = <0 0>, <0 0>;
+		freq-table = <0 0 0 0>;
 		/* offset: 0x84; bit: 12  */
 		resets = <&crg_rst 0x84 12>;
 		reset-names = "rst";
diff --git a/MAINTAINERS b/MAINTAINERS
index cae5b0c8400d..542174f434ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20015,6 +20015,7 @@ R:	Alim Akhtar <alim.akhtar@samsung.com>
 R:	Avri Altman <avri.altman@wdc.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/ufs/
 F:	Documentation/scsi/ufs.rst
 F:	drivers/scsi/ufs/
 
-- 
2.32.0

