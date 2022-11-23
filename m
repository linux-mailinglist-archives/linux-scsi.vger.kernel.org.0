Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F57635148
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Nov 2022 08:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiKWHsw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Nov 2022 02:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiKWHsh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Nov 2022 02:48:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6487A6D
        for <linux-scsi@vger.kernel.org>; Tue, 22 Nov 2022 23:48:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so3212411pjt.0
        for <linux-scsi@vger.kernel.org>; Tue, 22 Nov 2022 23:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1do4krfTNAeH24U0L6peava1Lck8JMrBtZKqw7SNLZU=;
        b=uNXzYR6zshjclrlR6Ysov6PSyX1SkIgPG0TiYS9vJikclr6RP9ZclC47TIM49cI6hk
         DUf2WV0r6CXbAmhH+6co5IM7Gt1SkvGO2/dE1RwDuUihG2RJoZEb0PRpA72dAe8KqqdS
         ZypeewA71U3vSHk4d7oXtq7SDpCHqxUyleGeiU0UQL4ALw8tnzyAWSqknSSonyCU/hQB
         Wp4OrEI6yP8e9JRfwvt8Ry6ctAmEH8w35J/Ha0FQncMbGT9YMyqFTNDsywrSYF4l9DY8
         p4zLkqZFGWv6KJ4G3ojH6U3C6mH0o5h7wX7Pej2Oim8I11QA/vBm6xNa0syECXWvxH9o
         PqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1do4krfTNAeH24U0L6peava1Lck8JMrBtZKqw7SNLZU=;
        b=K4K3NECwImnHhcKV4GbR/TXwFmvdJeRPFM1f8ZBx9kwk7bR7/kpoEkGozURhjodZPA
         56Jr1Lna7dNc3K2JtSIj02qeXb8jQJp+fBBcRp9oUYvO6W1heXO95X1/+4Eb2Tpf3X2s
         GlzyBFFPjevJEUBJ0nr1gCb3pnBaiktSzDqCStxzdfmPY20MP6AZxaBX00Qs2j53x274
         VMOCh90+eFZ6/pXIKg2lGAyOLiVIVVesryp6qMmvsl3DZqVGsnpK1Hna6k0T5ETgpZDU
         uqv6yRsjbo6lwVn15zCBtf7df3kOAUah8TlV8AUeVuRW6tafsp9dthaCD+5A/USBb74D
         oouw==
X-Gm-Message-State: ANoB5plGOhmBXlWJLXjBFFxD+U5ZnGZ+gMSD9WdY3fQPMxExriSqmdi0
        S69yIafzRLriHgNW3/wAOZBx
X-Google-Smtp-Source: AA0mqf6/pIJ68NWr5UXpoeJ1NuSE7EY0hVDfKb/7s3QLGum988+gRz1HT90O1LpDGdRyd2NdlzaG3A==
X-Received: by 2002:a17:90a:307:b0:213:ff80:b37f with SMTP id 7-20020a17090a030700b00213ff80b37fmr35769928pje.118.1669189715910;
        Tue, 22 Nov 2022 23:48:35 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:48:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/20] ufs: qcom: Add HS-G4 support
Date:   Wed, 23 Nov 2022 13:18:06 +0530
Message-Id: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello,

This series adds HS-G4 support to the Qcom UFS driver and PHY driver.
The newer Qcom platforms support configuring the UFS controller and PHY
in dual gears (i.e., controller/PHY can be configured to run in two gear
speeds). This is accomplished by adding two different PHY init sequences
to the PHY driver and the UFS driver requesting the one that's required
based on the platform configuration.

Initially the ufs-qcom driver will use the default gear G2 for enumerating
the UFS device. Afer enumeration, the max gear supported by both the
controller and device would be found out and that will be used thereafter.
But for using the max gear after enumeration, the ufs-qcom driver requires
the UFS device to be reinitialized. For this purpose, a separate quirk has
been introduced in the UFS core along with a callback and those will be used
by the ufs-qcom driver.

This series has been tested on following platforms:

* Qcom RB5 development platform powered by SM8250 SoC
* SM8450 based dev board

Merging Strategy:
-----------------

The PHY patches are expected to go through PHY tree and UFS, MAINTAINERS
patches are expected to go through SCSI tree.

NOTE: Since this series targets multiple SoCs (base like SM8350) and
(derivative like SC8280XP), testing on all of these platforms is really
appreciated. Although, if the series works for base SoC, then for derivatives
also it should work.

Thanks,
Mani

Changes in v3:

* Dropped the "device-max-gear" DT property and switched to reinitialization (Krzysztof)
* Added HS-G4 support to all compatible SoCs (SM8150, SM8250 and SM8450). This will also
  benefit the derivative SoCs of these platforms like SC8180x, SC8280x etc...
* Splitted the qmp_phy_init_tbl changes into separate patches (Vinod)
* Collected reviews from Andrew H

Changes in v2:

* Collected reviews from Dmitry
* Renamed "max-gear" property to "max-device-gear"
* Used min() for deciding which gear to use instead of open comparision
* Added comment about the old register name

Manivannan Sadhasivam (20):
  phy: qcom-qmp-ufs: Remove _tbl suffix from qmp_phy_init_tbl
    definitions
  phy: qcom-qmp-ufs: Rename MSM8996 PHY definitions
  phy: qcom-qmp-ufs: Move register settings to qmp_phy_cfg_tbls struct
  phy: qcom-qmp-ufs: Add support for configuring PHY in HS Series B mode
  phy: qcom-qmp-ufs: Add support for configuring PHY in HS G4 mode
  phy: qcom-qmp-ufs: Move HS Rate B register setting to tbls_hs_b
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8150 SoC
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8250 SoC
  phy: qcom-qmp-ufs: Add HS G4 mode support to SM8450 SoC
  scsi: ufs: ufs-qcom: Remove un-necessary goto statements
  scsi: ufs: ufs-qcom: Remove un-necessary WARN_ON()
  scsi: ufs: ufs-qcom: Use bitfields where appropriate
  scsi: ufs: ufs-qcom: Use dev_err_probe() for printing probe error
  scsi: ufs: ufs-qcom: Fix the Qcom register name for offset 0xD0
  scsi: ufs: core: Add reinit_notify() callback
  scsi: ufs: core: Add support for reinitializing the UFS device
  scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
  scsi: ufs: ufs-qcom: Add support for reinitializing the UFS device
  scsi: ufs: ufs-qcom: Add support for finding max gear on new platforms
  MAINTAINERS: Add myself as the maintainer for Qcom UFS driver

 MAINTAINERS                                   |   8 +
 .../phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h    |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 442 +++++++++++++-----
 drivers/ufs/core/ufshcd-priv.h                |   6 +
 drivers/ufs/core/ufshcd.c                     |  63 ++-
 drivers/ufs/host/ufs-qcom.c                   | 170 +++----
 drivers/ufs/host/ufs-qcom.h                   |  70 +--
 include/ufs/ufshcd.h                          |   8 +
 8 files changed, 530 insertions(+), 238 deletions(-)

-- 
2.25.1

