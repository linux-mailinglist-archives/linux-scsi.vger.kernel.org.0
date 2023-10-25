Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB247D62C4
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Oct 2023 09:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjJYHbE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Oct 2023 03:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjJYHaz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 25 Oct 2023 03:30:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5819AAF
        for <linux-scsi@vger.kernel.org>; Wed, 25 Oct 2023 00:30:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5056059e0so81141581fa.3
        for <linux-scsi@vger.kernel.org>; Wed, 25 Oct 2023 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219050; x=1698823850; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2HOUl2/zwYYWK4gK2TOvGSANbvNcIA9wpMKyZvXodu4=;
        b=YuQhomPspkNZJuYNpj9hilE3NSD4RGqf2/QFfi0IaJMDUruf6JFm1rtyyA0ZkMd6CS
         E9F/x7J1UV7d6bpoemOR/chmACCtUe2H2J4yiLqfK/HrA1/3c/YJNPDyaGmrXBJM++h5
         BUS2an7i7pGrk+MG9pyTt+0fDKWNK4hoggOl8Ck6YGuV0e15iv1Zf5JdYGVqpN2a0A2e
         JTCq7n5SPBf4isUY8obFofBHqkuGzNv+8ZKPmQaGjW+8yMMv+SI3NTJAQVKFIdmuFA/N
         8DdIkEI5wp4DwOvKuPGPfxzP1p3CucEvbUmgD+RYqvWgI/ijCMm/54ZyzmfA+LdAzGr4
         YBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219050; x=1698823850;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HOUl2/zwYYWK4gK2TOvGSANbvNcIA9wpMKyZvXodu4=;
        b=ndLOdeONH+FH1hny29O13ZAWOA1OL1YqElHquf9Eg4t35stAm79/ea59HQAVQgf0S0
         narxzrO//DKpJMkkg9HVkeid9L/u8cPKTrt/J57VlFXU65kaUwNNvJ2tN6eiFRHB/6vK
         KlQIFUvqULUDioYn3rB4eQkUSxHiRGKs7sZsjcQTw7CkqVnjerSGzXY1lz8LRNYN48bL
         OzaAR04BioTJmUXpEhkfikQUoA4JfWSfjBPzE4Wfd+IVh6O5Drjy9qzcXCLX96NqL7SL
         /n+TKXcPxg1QVraMk+ntsmCYPvM8XidtNt+hVLLph/vQcSrf2SKnnmE4NknQsVG/gqVL
         l1Mw==
X-Gm-Message-State: AOJu0Yzsn9HOOoUk+sCMh+s/D52B96fn+8LGVh5BcqQSFn+sB+wjrx70
        D2sNhzMyqTfyrboA8urAofv3rg==
X-Google-Smtp-Source: AGHT+IFNkBpMy/8xQv6c6aZWy3fOS2p9RZYaBauIqTXCUsqk4AHB6PXZzRYeJj7NCDk6zX6p6ZYgWQ==
X-Received: by 2002:a05:651c:1255:b0:2bc:d8cb:59fe with SMTP id h21-20020a05651c125500b002bcd8cb59femr9725408ljh.8.1698219050580;
        Wed, 25 Oct 2023 00:30:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm11490413wrq.20.2023.10.25.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:30:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:30:48 +0200
Subject: [PATCH] dt-bindings: ufs: qcom-ufs: document the SM8560 UFS
 Controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-bindings-ufs-v1-1-a355e3556531@linaro.org>
X-B4-Tracking: v=1; b=H4sIACfEOGUC/x3NQQqEMAxA0atI1gbaSlXmKoMLbVInC2tpdBgQ7
 26Z5dv8f4FyEVZ4NRcU/orKnips20D4zGllFKoGZ1xnje3x2LME1G3svcEz61F43nCRRJJWxTM
 qkulC9I78QB5qKBeO8vtP3tN9P6di2Zl0AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+ou1lwOLPIWCMRFAU+MMfL6oc+Ki8fn5yH6Tmb27AgU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMQp7qzh+bufmIGHRim51m6udr9NL7UiB3P4dkig
 CysrZlCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEKQAKCRB33NvayMhJ0ZJTD/
 9TRTUpDLSoewhZqE5WI8EX3oVvwZEfIwcfPuVTNbOnp3Ft8vjpkGeO4hP4afVhhF/ZIw4JFNDaXvDs
 kRsAG6FhlTZpsJcu/8FDfCedBK7JgVyiFIxaKGanPKyI7bVdfZn+s8zgYaSrnSz7sLt1ZzDZziY5KM
 X54ejGqMKPX2E7RyuRiPSXHSKe8T0yYNh73iS1GmTNAV0es49jcoW9D4A4AU+FHU4O4UtzQJwcLtF5
 TNPVeQrmbFoPYnghamaO6Ot3/DAEs+vTD/SGjJs87Wzc3CFQL4PhOm8NO03D9EB0abUG04U1/rRJXt
 fWGKJTUOTTkWamFunvCFeJ2jE2e7EIzYYAXLgRYLu56YaxEX488lA3Vh7qL8inzdVC9Kk7pJoHMjYm
 S7KHPP2BVHaqe414BzqgfI2+b8YnAabXhq1g3xKcYRClMQkc8RsfJsvb2bBB8ehlN+uVtyMxv1x6Zg
 hewYJRmBATBZyNw1Cuu/zDjqhJSfcmcS3FaytiqnuIvq8QAa+ObzKs/uf9XG7qYnucdB0YAhW1QgB+
 W3yhkt/qT3dy98JmGoLW7jyUIGcg5u3uUg383V2tRJrOIoUrj5J3ZD6UDxpy1+2k4Z+WUzIEZPeob2
 C2D3yAsJZuu+6jWmhibSSnbCSEAIjaQB8Jp4FmBvgvU+QajXnb/oVKv+A2Tg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Document the UFS Controller on the SM8650 Platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5a1cec..0d136c047b8b 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -36,6 +36,7 @@ properties:
           - qcom,sm8350-ufshc
           - qcom,sm8450-ufshc
           - qcom,sm8550-ufshc
+          - qcom,sm8650-ufshc
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-ufs-d03cf52d57d5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

