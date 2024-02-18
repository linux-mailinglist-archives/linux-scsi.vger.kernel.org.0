Return-Path: <linux-scsi+bounces-2531-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E5859747
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Feb 2024 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B8B20E1F
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Feb 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22B06D1AE;
	Sun, 18 Feb 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4Ho5yFn"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB26BFA5
	for <linux-scsi@vger.kernel.org>; Sun, 18 Feb 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708264602; cv=none; b=MyVZ6/sfVaLWFZRoHR/uwBaRDCMFsLW/nIEv+VMtq3adwMeIp+jf/RsXhK679No1rktFFK43SDx8f1sOXlQ8KcEV7/ddj4GiLWz0dr1L8dapH7SJpVPkXlWI5GZ6amL6d9j03Ho8D2BetVR7lbP1Zl0KIt9ERYo0Ct2EynDFASk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708264602; c=relaxed/simple;
	bh=JUhIMc4iUWCBq7eLRAz88cgUjHbGVlb137bI76g/gfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XglxVuLbdiqUOdBCBbhO0dbxeeqm6Js/LIVitpbcbEnidmEKC0uND+R2KxIo9YsER/byMJRk1fKCPVTal22s2V+gDKN+T3hbw+42U3zSvRpGZt453VAzpXwSYGreHwZooHcgq1KE+VgzsbBe3zHO+rNgBL7oV6kPSSjq1r9yC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4Ho5yFn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512b36bb97eso53358e87.1
        for <linux-scsi@vger.kernel.org>; Sun, 18 Feb 2024 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708264599; x=1708869399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQM6AXrvF9wLpeD8ke2H3OmUga9j9iyxSldR7lmW6eU=;
        b=S4Ho5yFnYu59FVtIKm66CTOsrrN3Gf0wJwxATJCHPtL1rLCluk6UlNN5t3zz93rxNK
         ULBIDohQ97LU5ESlzt06L3PK2/11UfOf31oOJrawofF5WiVBjSaSwJPXepwRUm84EZfT
         s5NjpJhr6aom25QF5yPeQBZuI3txgEaiPbfjN6luECyeJ12d3eY2fmzyArK/sNnw7hZY
         G0Mj9DSAMoTUxgmOSYG+RMd5kaKYJROHrFUG0i1tKpvfm7GRQ1yMmG9IpH2h8iN97V8N
         rHnXriCuqLEU+zBKWzNrbhzvKXariPUSWX9SA0FgdewhygIVXP2F9X8i399WiC2CRava
         zEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708264599; x=1708869399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQM6AXrvF9wLpeD8ke2H3OmUga9j9iyxSldR7lmW6eU=;
        b=SASWpChOigdGUjLPQ3I+mgX4leLHSsjPlai2oZrlR0RfMHldck0ULlD67bHDr/SlV0
         NsQKDi+wUjEw4qVkTP4AnYqkt5hs0tvuqb3NyhhN4GfbfabHXwliS6EBoZhYoe9hgYuN
         xe5BHipkDBAHXt3yJi8L+N34hgeM1DQ7Nlbjn3GEGfX1XuOFeyNsEOop+LDX9sYLEgSu
         //uZdFzGXFK8wWGIejjghAXwX7/agrnub3KkKoGwBhd18oAkmuPtXIjywbxQT7f6PuD4
         eSAwlxlgpbsbvyr6uUOSFjqHrOubchBkp0LI76uBCNoS7avyj4ZPNUi6bQvvhFnrQzsR
         zbkg==
X-Forwarded-Encrypted: i=1; AJvYcCVyZUyCMicM4SuFWqVP9KdnYR0MAz2NsHEQhUAmZWe65k2eJDK3JC7WTquLKO9HlicOV07VInVGacyXWJr/QCBHN9VQD+wbqKhVKQ==
X-Gm-Message-State: AOJu0YwYNRp4MFGRH5zb60i45Mewyx+tO+Q+1gBh9TAO7VRfJ7CKvjWV
	3xTGyLehfAhpjohqkXQNR0f2oaeyPy1Vq4IRM32/d4Cy8/+2N555Ky9/YiD4xQo=
X-Google-Smtp-Source: AGHT+IEUZxDPf+24gy+QliHdxVhWdtAonWuTcXc4/EdW6yU8DebUvnBO9gH4P2wEp23duPuKOHEepw==
X-Received: by 2002:a05:6512:11c5:b0:511:9008:7266 with SMTP id h5-20020a05651211c500b0051190087266mr6220198lfr.6.1708264599082;
        Sun, 18 Feb 2024 05:56:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b005119fdbac87sm548698lfq.289.2024.02.18.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 05:56:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 18 Feb 2024 15:56:37 +0200
Subject: [PATCH v3 4/5] dt-bindings: ufs: qcom,ufs: drop source clock
 entries
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-msm8996-fix-ufs-v3-4-40aab49899a3@linaro.org>
References: <20240218-msm8996-fix-ufs-v3-0-40aab49899a3@linaro.org>
In-Reply-To: <20240218-msm8996-fix-ufs-v3-0-40aab49899a3@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nitin Rawat <quic_nitirawa@quicinc.com>, Can Guo <quic_cang@quicinc.com>, 
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JUhIMc4iUWCBq7eLRAz88cgUjHbGVlb137bI76g/gfY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl0gyT2lAaUPeO/yx9AQILQ3YhbffBLLjp6lDEJ
 lSsHvt+kxyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZdIMkwAKCRCLPIo+Aiko
 1Vr7CACVyOcblvX7/JOS1/9ki3KiVYu+sutex45YESPJcD2apP8o1PDAWDGn/+4jWq8c7Nr2qvi
 qItPlrqUeHEkG71ehu9hDBNsTFyHPge6fi86RhLIIhXh1KUCy08tT+L5fZGUhiTqnJI6akGyLX1
 VAC3gfiJPNDFRyu/e3z1cl4gh/1eoogreJqZTCD2P0it6120kEIUum5+dWyqdDeTpLE35GoRVMK
 DSqK74MD9N8DZDyKyVIZPSMORO+35+FiK0OBjOctZ4LVZki1caYc/gT3TVl3KcQnPdSvwd9jq45
 X9hLGeEEzn7ktT7zooJ7oZRo4YBMHZuEWvJDMNXgl8ht9qX8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to mention and/or to touch in any way the intermediate
(source) clocks. Drop them from MSM8996 UFSHCD schema, making it follow
the example lead by all other platforms.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..a6b11fdb39ab 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -43,11 +43,11 @@ properties:
 
   clocks:
     minItems: 8
-    maxItems: 11
+    maxItems: 9
 
   clock-names:
     minItems: 8
-    maxItems: 11
+    maxItems: 9
 
   dma-coherent: true
 
@@ -188,16 +188,14 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 11
-          maxItems: 11
+          minItems: 9
+          maxItems: 9
         clock-names:
           items:
-            - const: core_clk_src
             - const: core_clk
             - const: bus_clk
             - const: bus_aggr_clk
             - const: iface_clk
-            - const: core_clk_unipro_src
             - const: core_clk_unipro
             - const: core_clk_ice
             - const: ref_clk
@@ -257,7 +255,7 @@ allOf:
           maxItems: 2
         clocks:
           minItems: 8
-          maxItems: 11
+          maxItems: 9
 
 unevaluatedProperties: false
 

-- 
2.39.2


