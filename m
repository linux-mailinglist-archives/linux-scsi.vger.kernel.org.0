Return-Path: <linux-scsi+bounces-733-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40F809E43
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 09:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176421C209E7
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75861111AA
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3E7tP5s"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9AA1728
	for <linux-scsi@vger.kernel.org>; Thu,  7 Dec 2023 22:59:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d048d38881so13397485ad.2
        for <linux-scsi@vger.kernel.org>; Thu, 07 Dec 2023 22:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018755; x=1702623555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ/+btG3R4BylCT3sRnAP96/2um/WTuuUn1kNLXJGP8=;
        b=u3E7tP5sJooWyyGLKqgrfdmhGSU1qzqu17kBjFp70pFSXTTE/ZVJLGjaynCx0i0piU
         0ywuDpc86uuPFsxfeE98f2s9UGLHQkghauq/rUzn5UTTpNZi2D13w/wBIxU8b+EW0sQB
         bR6LWm02o9Jz55dKBegLjhttLtMU6kajytterlPVAtaj6br/SekiCE55oXwEBO3GEkUs
         vSzaOlF1IIM8m0HeT3y5bHdf5t1h+LnTz8SP1qi/EFmW4LTGwd1/X7wekLomJN39mfGX
         kzATlYfMJ5gUyp8skuLqxBg4IrUv/FYsreE6EfPQH1Kp0lpB2USKrRvj5scWqmrt4v4z
         veyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018755; x=1702623555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQ/+btG3R4BylCT3sRnAP96/2um/WTuuUn1kNLXJGP8=;
        b=p/KvmBL2J2IDio0vQsLKmCCGPHaoHgkcN0av54lo09JY+Oi49hVGI4PgbLoil3bxGV
         o41W9GrPUqCrro0RotbISlB1e/E7nbHd2wSQc2mFtGVEwvWB4p7P+bbvjpgiWVBx/wtt
         ebuubbeYVAWSHITi/B9zatIkyzKTuSZPCaQXKgMUZixsviG5P7ZcgX5z2HEj8ebZ6Qj8
         Pj/RiIlTdnz9lQziF5uBsZqP2px88ZBI3h28vxJJcmWtTGuQplom6dU793KtlUScbb19
         BhvL2m2FwC6V1vag27bCru9TfCzgz18O3TRxjFh+pn0wzSFsZVDyTX2kwR8DnmtZX6xF
         Yegw==
X-Gm-Message-State: AOJu0YzaOtYDFJzfYYSBSMHqHooDXHwy+H9+d2EsZTAW7iVvc/jl99TG
	zTxiWY3sDWW9hvohkFHXZdeH
X-Google-Smtp-Source: AGHT+IEWVNS4FBRgNsLlZoUKRQekH/RYMZkGGwR1xlrSIV8+OcGCofWlOOzi7raJq0QNnZm1H9O5xw==
X-Received: by 2002:a17:902:ecca:b0:1d0:7b65:9f8a with SMTP id a10-20020a170902ecca00b001d07b659f8amr3282715plh.51.1702018754908;
        Thu, 07 Dec 2023 22:59:14 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:14 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: martin.petersen@oracle.com,
	jejb@linux.ibm.com
Cc: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com,
	ahalaney@redhat.com,
	quic_nitirawa@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/17] scsi: ufs: qcom: Code cleanups
Date: Fri,  8 Dec 2023 12:28:45 +0530
Message-Id: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series has code some cleanups to the Qcom UFS driver. No functional
change. In this version, I've removed code supporting legacy controllers
ver < 2.0, as the respective platforms were never supported in upstream.

Tested on: RB5 development board based on Qcom SM8250 SoC.

- Mani

Changes in v2:

* Collected review tags
* Fixed the comments from Andrew
* Added a few more patches, most notably one removing the code for old
  controllers (ver < v2.0)

Manivannan Sadhasivam (17):
  scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks
  scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
  scsi: ufs: qcom: Fix the return value when
    platform_get_resource_byname() fails
  scsi: ufs: qcom: Remove superfluous variable assignments
  scsi: ufs: qcom: Remove the warning message when core_reset is not
    available
  scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq helpers and make
    use of them
  scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset
    fails
  scsi: ufs: qcom: Check the return value of
    ufs_qcom_power_up_sequence()
  scsi: ufs: qcom: Remove redundant error print for devm_kzalloc()
    failure
  scsi: ufs: qcom: Use dev_err_probe() to simplify error handling of
    devm_gpiod_get_optional()
  scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
  scsi: ufs: qcom: Sort includes alphabetically
  scsi: ufs: qcom: Initialize cycles_in_1us variable in
    ufs_qcom_set_core_clk_ctrl()
  scsi: ufs: qcom: Simplify ufs_qcom_{assert/deassert}_reset
  scsi: ufs: qcom: Remove support for host controllers older than v2.0
  scsi: ufs: qcom: Use ufshcd_rmwl() where applicable
  scsi: ufs: qcom: Remove unused definitions

 drivers/ufs/core/ufshcd.c   |   6 +-
 drivers/ufs/host/ufs-qcom.c | 377 +++++-------------------------------
 drivers/ufs/host/ufs-qcom.h |  52 +----
 include/ufs/ufshcd.h        |   2 +
 4 files changed, 66 insertions(+), 371 deletions(-)

-- 
2.25.1


