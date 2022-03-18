Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A914DE12C
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Mar 2022 19:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiCRSkK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Mar 2022 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiCRSkJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Mar 2022 14:40:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208DC1C6ECD
        for <linux-scsi@vger.kernel.org>; Fri, 18 Mar 2022 11:38:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w12so15411964lfr.9
        for <linux-scsi@vger.kernel.org>; Fri, 18 Mar 2022 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHqKUGIuEtftMeafh3bJR5uOnAVeeytzXHaCASE6Gn4=;
        b=ZoEWjWqwUVUE8RL638A1vp3y96A6v3Db295HCFYjubg8CsKNVOIs/CYwXnnGofh4Kz
         TaGzYzmVWLyAdEjGzYHLSd7ZlKQOngV2b12idRYKK/t/ACCLVGTJSB4ni+8H89KGA52V
         GVN+W26u8vg9htT9NJRsd3U2+4UfkiaYHp499jhPbQqa++f69xIskRzjnjpuTVc245G+
         yND2HwBlRNQuUMqJqGGmUPIjyFcBINeYyqPccrYHCFr3bAqEQDxY9ebkV1HO02BDMQJF
         DBDExuExpgcvCwgWVa17UrfqMw4a1evPMjujShh3mN8q/zBwzSP95mu6EvzaEGhW8jb2
         2aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHqKUGIuEtftMeafh3bJR5uOnAVeeytzXHaCASE6Gn4=;
        b=0zapvioNgAwD/1TZNZWiZsWGS3amaT5cnAFeju6lpzSnnl34aak0s2o53FdbbDzjjm
         uvoofQLBD8flSWF+k0/VwDvA5RBb6og7xgt+HLgFQsoJXcaqjPO/jyitXm+3PYkU4nd1
         rvS2LpYqIS2rJ8+CmX4g+gsvhupVF7NsE/vYHOWAtofwklqNYmda+3mjYjeVZVelT0J7
         uW5l5P+pUWnikAQ3PpjyklVhhJfhhHwug12qWZHyp6oVRKOma4+LgiID32rA/VXN6K8K
         4GUZrcI1QfyhhoW32Wk5LTMznn6axkv+HxwINFIjx9bIOvSmKGcsw9ZW86Q3W01uKpiK
         e+WQ==
X-Gm-Message-State: AOAM530w3xaP4FAqXKw6pz+RYVH9yPtG0rB2lu+yHz8TPuFKvlOK21Lc
        sKONMktfXyogDqw9EUwK86WBzq+TaB5ouQ==
X-Google-Smtp-Source: ABdhPJxrGyAm3rDmPJ5rZTz7TuI7XPNT/CCRKjeORWRNh9AvTOx1SAT/KaWg8k2+FR6cyt5034mAzg==
X-Received: by 2002:a05:6402:d09:b0:418:7a4a:c3f2 with SMTP id eb9-20020a0564020d0900b004187a4ac3f2mr10797459edb.366.1647628226711;
        Fri, 18 Mar 2022 11:30:26 -0700 (PDT)
Received: from otso.arnhem.chello.nl (a246182.upc-a.chello.nl. [62.163.246.182])
        by smtp.gmail.com with ESMTPSA id y8-20020a50eb08000000b00418b114469csm4567551edp.52.2022.03.18.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:30:26 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] scsi: ufs: dt-bindings: Add SM6350 compatible string
Date:   Fri, 18 Mar 2022 19:29:59 +0100
Message-Id: <20220318183004.858707-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318183004.858707-1-luca.weiss@fairphone.com>
References: <20220318183004.858707-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Document the compatible for the UFS found on SM6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 5b3a2157f7e5..d17db2cdf3c2 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
           - qcom,sdm845-ufshc
+          - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
           - qcom,sm8350-ufshc
-- 
2.35.1

