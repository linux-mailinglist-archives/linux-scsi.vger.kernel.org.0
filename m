Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA25769CAA
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Jul 2023 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjGaQep (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Jul 2023 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjGaQeo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Jul 2023 12:34:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB811981
        for <linux-scsi@vger.kernel.org>; Mon, 31 Jul 2023 09:34:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b2886364so28570725ad.0
        for <linux-scsi@vger.kernel.org>; Mon, 31 Jul 2023 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690821281; x=1691426081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NF3cdDHtgDTlBXnay3QPfk41bl0qVAIfQAF8Qog11Xc=;
        b=tQycVGjXj7OfmBsv0gQU0GvZzIeMw3uB8HpYG5JRHHnqS35VmZkW6x9j+vHLcdpoBy
         ehQnhVe657UqqOsiMqUYI04wNLdK8ArvLslngurhhWL/BZyQh95eG68FWWaxeWjl8Gt8
         Vbve44+kYnYdyB7wpzbPY5ff33gTZLoBClgaAE9Y8XmwK0Ua/SFqCpsKGe2wupu3R4wF
         sl1ofmKRxTVKn1SHcSoXKvmNlHwYuHQgUTZIvHa/IWes9oW4SCRjJbuaI1bt3eqG+iau
         SxaaV5N3Jwzw3G30+udC5blncNh7Q0fObZzb0PpvcIOzf7J2eNO7ZZllAzgfMRsxW7iT
         9UPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821281; x=1691426081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NF3cdDHtgDTlBXnay3QPfk41bl0qVAIfQAF8Qog11Xc=;
        b=Pm2iBLqUN/nkBYxxJeqlhRwB8EPxo0mAp+KPpWzr2Kf1f9QR3NJ3LRb4iZtW5tAZDo
         hBuKWt4IjOeLsTOFqRvKgFtoJLXBWKl4fM9TKbw0HT46KzoomHjfXobiuhhwwlnw7Qom
         9gQ7b64E360Y6MX5h4AJsNlSFQqqIBRZzd+SC6HSY1COpAmA86pmB55Qk0LFslXb4l8R
         OQ0la1hzE92Vyg9HuGzycjUBzmwKw2McsENEvwijbbhLydT2dj4WhhpyXq9GtP3ywtM5
         4dQd/jCGrkBEFdrqDOppY7ZsWRGO6lkJRMc+maLh9I365MTBChB+WUjqg6FfA6mpO+aT
         5fYQ==
X-Gm-Message-State: ABy/qLZGJckzhPtIB1EXAT3ZWUiR3PuQ4KZu83xsZvUp9A7qmkiOqFov
        GEzgj5G4vsTjaARs6lC672qb
X-Google-Smtp-Source: APBJJlGo9I3jYAVeZYXO30xOv/8AyqAUnxLLFlrO69X8v20rYrYqjKlnjOXvYZNJwOWNg4MQ1X3TMg==
X-Received: by 2002:a17:902:d303:b0:1bb:de7f:a4d4 with SMTP id b3-20020a170902d30300b001bbde7fa4d4mr10001547plc.61.1690821281374;
        Mon, 31 Jul 2023 09:34:41 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b001bb1f09189bsm8779541plg.221.2023.07.31.09.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:34:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/6] UFS: Add OPP support
Date:   Mon, 31 Jul 2023 22:03:51 +0530
Message-Id: <20230731163357.49045-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

This series adds OPP (Operating Points) support to UFSHCD driver.

Motivation behind adding OPP support is to scale both clocks as well as
regulators/performance state dynamically. Currently, UFSHCD just scales
clock frequency during runtime with the help of "freq-table-hz" property
defined in devicetree. With the addition of OPP tables in devicetree (as
done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
both clocks and performance state of power domain which helps in power
saving.

For the addition of OPP support to UFSHCD, there are changes required to
the OPP framework and devfreq drivers. The OPP framework changes are already
merged and available in linux-next, the devfreq change is added in this series.

Credits
=======

This series is a continuation of previous work by Krzysztof Kozlowski [1].

Testing
=======

This series is tested on 96Boards RB3 (SDM845 SoC) and RB5 (SM8250 SoC)
development boards.

Merging Strategy
================

An immutable branch might be required between OPP and SCSI trees because of
the API dependency (devfreq too). And I leave it up to the maintainers to
decide.

Dependency
==========

This series depends on the OPP framework changes that got merged into PM tree
and available in linux-next.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220513061347.46480-1-krzysztof.kozlowski@linaro.org/

Changes in v3:

* Rebased on top of linux-next/master tag: next-20230731
* Dropped the already applied patches (dts, opp binding and framework)
* Moved the interconnect patches to a separate series:
  https://lore.kernel.org/linux-scsi/20230731145020.41262-1-manivannan.sadhasivam@linaro.org/
* Moved ufshcd_opp_config_clks() API to ufshcd.c to fix the build failure
  reported by Kbuild bot: https://lore.kernel.org/all/202307210542.KoLHRbU6-lkp@intel.com/
* Collected Acks
* v2: https://lore.kernel.org/all/20230720054100.9940-1-manivannan.sadhasivam@linaro.org/

Changes in v2:

* Added more description to the bindings patch 2/15
* Fixed dev_pm_opp_put() usage in patch 10/15
* Added a new patch for adding enums for UFS lanes 14/15
* Changed the icc variables to mem_bw and cfg_bw and used
  the enums for gears and lanes in bw_table
* Collected review tags
* Added SCSI list and folks
* Removed duplicate patches

Krzysztof Kozlowski (2):
  dt-bindings: ufs: common: add OPP table
  arm64: dts: qcom: sdm845: Add OPP table support to UFSHC

Manivannan Sadhasivam (4):
  PM / devfreq: Switch to dev_pm_opp_find_freq_{ceil/floor}_indexed()
    APIs
  scsi: ufs: core: Add OPP support for scaling clocks and regulators
  scsi: ufs: host: Add support for parsing OPP
  arm64: dts: qcom: sm8250: Add OPP table support to UFSHC

 .../devicetree/bindings/ufs/ufs-common.yaml   |  34 +++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  42 +++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  39 +++-
 drivers/devfreq/devfreq.c                     |  14 +-
 drivers/ufs/core/ufshcd.c                     | 179 ++++++++++++++----
 drivers/ufs/host/ufshcd-pltfrm.c              |  78 ++++++++
 include/ufs/ufshcd.h                          |   7 +
 7 files changed, 331 insertions(+), 62 deletions(-)


base-commit: ec89391563792edd11d138a853901bce76d11f44
prerequisite-patch-id: 9e7233b8c34b4eeef63a90e851bc9429619627bc
prerequisite-patch-id: a18af123ce0e9537a96676ae0b2d8c1f0fd19c4b
-- 
2.25.1

