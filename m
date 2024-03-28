Return-Path: <linux-scsi+bounces-3555-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB19B88CB38
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Mar 2024 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBAB1F67684
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Mar 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8042208BC;
	Tue, 26 Mar 2024 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3ImuXZA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE61D559
	for <linux-scsi@vger.kernel.org>; Tue, 26 Mar 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475199; cv=none; b=ENMKNwkY8q3b8ZHroG+a1K+hGiMZxL2T2/zXgoYD1PALwxh1U5s7QKRZ5+UBhumP4E+nV+ezTHb/galXeNdSmudMq4U2ZcZzOrIQWe41o8021CXEMzXY3wldEKk8Uji7CQaw4t1UfgWGkXjralSziiPzFHEY0Tbvi81tvSCh0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475199; c=relaxed/simple;
	bh=+Jb3+P97t3/SYjNzJeD0Doe3JTD7QKu5XiF0KJGtqvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqmj8hoqOTwoCGQbeTOsjS81M7BFxbC9tKp8fJsEcYSjTfCRILwILrByJwCe2h19S6tNbXmZAzwjaO3PorUrZGM8iZO3x6Rz9XzcIwV6IQv92dvDrxwIKpB2OhEq2BuQVvKnTpdsYAfjHvNsq4DvKTQ+bisKzOYE2jsIY2OH8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k3ImuXZA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c1364ff79so2987727a12.1
        for <linux-scsi@vger.kernel.org>; Tue, 26 Mar 2024 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711475196; x=1712079996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEazo7CkUjqyyWnsaq027rdmCtFwk9evR4G6KKq+jfU=;
        b=k3ImuXZABKLxMtlS5jhB/uwjnfN5VK7JEQJIHp8a+aGIZiqswNhk27zUh/JBoLl8r6
         t1CVwhLwCM2zkkwXnapZ8vUBwgpadJsQyIYDvqOn3UntxjuMclnRJqZAgGehgPE1LHjf
         kaqO7EOnymZ1D8ZXbvGQ+xiElSi9mMRofMyH94CgEGJ7KwIWZTtB5aiVawgh2BmJBgH0
         97j7OGhqFUH+JN1Jyj5eeEJy2ZvCoOe7pazOh2KKPNbaPPKuSk9/7DWzGLSIJmKOxLzg
         55bQ7kbtNuJJhXUNMiSXugDxEMidn2Je99iHq5pDjhrjr4ZzWgsksWWFqjumKreug/XF
         njdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475196; x=1712079996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEazo7CkUjqyyWnsaq027rdmCtFwk9evR4G6KKq+jfU=;
        b=dLnrRsVB/pe/5WGXR2GrMT1+PhNw8Ff2XB45hNX7fpistAS7VxjxxwKsgicPT/jKIg
         D57H8RJef1hjYNsJ0sW1PGGo7FSrYulzKtl8JybyNm/Uwv9f7kU2JhIjzHT9H00tLALt
         09lr6Hcm8cNZzAFbr9aQVMoYbb8wyQEVt2RpJJfQuIEWmc23tIO4qVjcNIXUqg3o2/Yg
         wBHm/g4Jpca+F42z2rFFS8Bxbw2eIshgjglAXEDcaKQmhAGz74yqvwjX07AKeAYXFoaF
         o2zm5EoL9d8gYxLijWM7wsNCzqgaETq2phz2KhmyC6r1jBXF2psKxw1QUTAZRcArIOOA
         wuxw==
X-Forwarded-Encrypted: i=1; AJvYcCVb46SceUqEvIg2HDHZolKuiT9SKsT8wrnPQuVkVHF943otYkSHdWdy1lfSR6h7Qrc2QH9rypiKvinUykvMgQ5fr2Se133Gam2cZw==
X-Gm-Message-State: AOJu0YyRDVj2HmjxmnD55yqa5kNl9KbgO7hwyf0A02fEb7FVa66q0ZGs
	bk+w4fqc1p1sRkbHlWLZkeRBpNrRnjx3WjqbXfAFzPj2FTkbxacWCjxoB6ndJc8=
X-Google-Smtp-Source: AGHT+IEDXr/rGD/GEqrQHL/G3YeNWczFxMCfJdYUN/McfMgn2peLnTcs3anULp1X3DvgNu3GWK0kxw==
X-Received: by 2002:a17:906:c9ce:b0:a46:be85:4410 with SMTP id hk14-20020a170906c9ce00b00a46be854410mr243447ejb.74.1711475196041;
        Tue, 26 Mar 2024 10:46:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090612d300b00a46cffe6d06sm4451438ejb.42.2024.03.26.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:46:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: ufs: qcom: document SC8180X UFS
Date: Tue, 26 Mar 2024 18:46:30 +0100
Message-Id: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document already upstreamed and used Qualcomm SC8180x UFS host
controller to fix dtbs_check warnings like:

  sc8180x-primus.dtb: ufshc@1d84000: compatible:0: 'qcom,sc8180x-ufshc' is not one of ['qcom,msm8994-ufshc', ... ]
  sc8180x-primus.dtb: ufshc@1d84000: Unevaluated properties are not allowed ('compatible' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rob, considering limbo status of this binding, maybe you can take it
directly? Would be the fastest.
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..1ab3d16917ac 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8998-ufshc
           - qcom,sa8775p-ufshc
           - qcom,sc7280-ufshc
+          - qcom,sc8180x-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
@@ -120,6 +121,7 @@ allOf:
               - qcom,msm8998-ufshc
               - qcom,sa8775p-ufshc
               - qcom,sc7280-ufshc
+              - qcom,sc8180x-ufshc
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-- 
2.34.1


