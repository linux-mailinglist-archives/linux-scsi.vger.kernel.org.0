Return-Path: <linux-scsi+bounces-548-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29A805794
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBE91C21049
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7A59E32
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="n/cLmLnB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED81A1
	for <linux-scsi@vger.kernel.org>; Tue,  5 Dec 2023 06:39:06 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1c890f9b55so83564366b.1
        for <linux-scsi@vger.kernel.org>; Tue, 05 Dec 2023 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1701787145; x=1702391945; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTsU0tLdMfpk3k+17/uFzQeio4Ea0FMF0dlG83ANcS0=;
        b=n/cLmLnBvPll7b6FvlUsMrCkFyCN3gHnhH7hpLmlc3K+f8rXYlezeiZL/k5SADMznt
         vrSRCqgiZT51vg/HqxxLRiJLlG3oBQwppislsi5k040HmUXwl8VV5RMK9v8LlQKeiuzY
         M+yg1Ma4NDg2LSE/YA2NXM21VBVHUvKfBCm7w90Y0PmmzFnQKZo8Ns44gFw6Lbg9FmDV
         8wBQDVGdIKBeVXCsVDlC/iKAwHo/qeFOtDjrnep7ciJxtMBLFn+vRBnqJ+sxq51o2ko6
         RA0Wyv3RKgr0XTlYb7lq5q6KxcFyIiSHGiCrcs84+hIGa00R8AM/uZxonH/p2Gne0gzX
         ovAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787145; x=1702391945;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTsU0tLdMfpk3k+17/uFzQeio4Ea0FMF0dlG83ANcS0=;
        b=vcekxoig3wVig0btdbmgs1c4xiks+ZixFC7+I6dUx8C/6Xa7qxCviWB1kNdMlHfIKx
         EnrSBDW4nGAB08q5HfcnILt5wC8nJOkGCmh6cFgx0xZGddpOBjbHzN9oC8mi9FwZWqxL
         bmzl6G8AHn6U+a9HzjX0UJgiKI04PZapFB14oVj50xml65lJPzH0Z5h5T3sd8tC5EvzV
         fTuZ/kbEk5A6Qh1w7J+0xclprl8pjBYib86itwvWJKL/o6MLbaHeE1m5X9AfaNvSzwms
         l7UjHZk7oFQBcIYRZZCFyU9yQ4cUR5KK36o7DVM97lRaIAeZ7qV5gQFDE7d2gY9LiH2R
         DAEA==
X-Gm-Message-State: AOJu0YzNCDg7/HaN8SlQ5SNVdqzWUwxais2fiZTvAq0+RXdovlhn+RjS
	zEsMLpz8fMNOwfpSmPo29Db0CA==
X-Google-Smtp-Source: AGHT+IFQuWQQqywH3CVl2hKn71xrka+HXiv9ID0fLEcgLwb4Eomjby4eFCI/jt81Jh5Pl1fWcnCPSA==
X-Received: by 2002:a17:906:1011:b0:a19:f69e:1d3f with SMTP id 17-20020a170906101100b00a19f69e1d3fmr3812202ejm.71.1701787144906;
        Tue, 05 Dec 2023 06:39:04 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id gq18-20020a170906e25200b00a0a8b2b74ddsm6795404ejb.154.2023.12.05.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:39:04 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v6 0/3] Add UFS host controller and Phy nodes for sc7280
Date: Tue, 05 Dec 2023 15:38:53 +0100
Message-Id: <20231205-sc7280-ufs-v6-0-ad6ca7796de7@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP01b2UC/23OsQ6CMBSF4Vchnb2kLVCsE+9hiKnlInegxRZQQ
 3h3gcHJ8R/Ol7OwiIEwskuysIAzRfJuC3VKmO2MeyBQszWTXGZC8hyiLeWZw9RGuAssc4VGcWz
 YNhgCtvQ+sGu9dRt8D2MX0PwIrqUWmdCZSqXOpQABz4nszdFIwbxMtRc5m1rf72RHcfThc9ybi
 x3++2QugIOWyiI2RcEbU7WGwtB5h4dUr+v6BSbnrvrrAAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nitin Rawat <quic_nitirawa@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.4

This patch adds UFS host controller and Phy nodes for Qualcomm sc7280
SoC and enable it on some sc7280-based boards.

Pick up the patchset from Nitin since the last revision (v4) has been
sent end of September and is blocking qcm6490-fairphone-fp5 UFS.

---
Changes in v6:
- Use MX power domain for phy, UFS_PHY_GDSC is only used for the
  controller (Mani)
- Link to v5: https://lore.kernel.org/r/20231204-sc7280-ufs-v5-0-926ceed550da@fairphone.com

Changes in v5:
- Try to get patch tags in order
- Drop patch reordering clocks/clock-names in dt-bindings example (Rob)
- Use QCOM_ICC_TAG_ALWAYS for interconnect (Konrad)
- Add missing interconnect-names (Luca)
- Fix sorting of ufs nodes, place at correct location (Luca)
- Provide ufs_mem_phy clock to gcc node (Luca)
- Add missing power-domain to ufs_mem_phy (Luca)
- Link to v4: https://lore.kernel.org/linux-arm-msm/20230929131936.29421-1-quic_nitirawa@quicinc.com/

---
Nitin Rawat (3):
      scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
      arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
      arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board

 .../devicetree/bindings/ufs/qcom,ufs.yaml          |  2 +
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 19 ++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 74 +++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)
---
base-commit: ce733604ab13d907655fd76ef5be55d16bbd0f8c
change-id: 20231204-sc7280-ufs-b1e746ea60ed

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


