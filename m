Return-Path: <linux-scsi+bounces-8013-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4596FAD4
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 20:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7C01C2497C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6401E977F;
	Fri,  6 Sep 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PzwqnbJg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1D1E1333
	for <linux-scsi@vger.kernel.org>; Fri,  6 Sep 2024 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646067; cv=none; b=T3FJklRk2wrN8AHeH4x2f5TXcFGAIRYhR+8CfjgMq7waJCvoqlytpo612d5Ij7BuFq9bysD0wCYpBJfb9dZNE58Q3nFQJOEeYTdgU1fcfYZvxcwTUin/M75Gq3sSnkabdYMDq9EYdGI82J+c1kI19GglUW6iZipRkzw0BdGOsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646067; c=relaxed/simple;
	bh=NTpnGYJWRKUfD2+EdtJmRcavDBWB/vbpL4lKlrJIiuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDBrkS6Ymo0QtPwPaHFdf+peZEOddyAb6uzbL2R17FM6Egtv2qi8etGzKq0TmrWqXsUO6kr1Rfmj2HeyLbSI5Jjglis1aE7+ANKdpGaqId5TUWOmyzmkqvj16QH9mCId0cz+O0Dw4N7xZHUx4MGQVtno9YpksfVsJt2M5rVYpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PzwqnbJg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso18337985e9.1
        for <linux-scsi@vger.kernel.org>; Fri, 06 Sep 2024 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646060; x=1726250860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvGNvxvKM8eiH1ZuQL0JBic8eLP1K1xp7NCDrQaUBYs=;
        b=PzwqnbJg+jswTirG+BrA6ebH25ptG6tkqbFZLGpj7946yqDUatOx4wpcW/JKfrIQZf
         y2vCQ3NCWyjKqOBZd8DU4RjfApxpdnfN4VWQ1qLzoMXsOTMrvhDKNPfG18+mCblYb/ee
         XHU8wQ+0gqRwozgCRz+WzvlM4hRkPWImiRTitiulKob8PFAZyCwtWtbK638hRSuZpPmk
         HQYFmMufPqx3EytGwGg4Qvpimmv9UrVoM2uxiZI2v3s37DbI0n2Wk4q9p2ULPjV4pOWv
         tWQFzHbZ5XbKJaaZu8Ce/xOSDBDZQZ+ndBaUkgJLTCMb5WoXWospnxMG9nRqdSZmTjRH
         G3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646060; x=1726250860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvGNvxvKM8eiH1ZuQL0JBic8eLP1K1xp7NCDrQaUBYs=;
        b=UZ2Yio8pCs9G/VkS/enhV5JKFkHtXzAwrFtleBw5NWjz+tAYkG1L7wuDBJN//le0L7
         L908IWiM2Td8fcu7hnAcUwB7DS3xCWX5ERUaCc5Fapgsd6RHX5Xmt3WANmCmMOTByolm
         kJh9yzTbvBUaF2pEY2UKSmgbnNtitvUM8cTXbgFtOVVC7AdLlcAxwp48N68IrEEQuYGp
         n1wz+UF+d0n7oZa3RSIVa0Ava0sp2UofMOzUfJ1G1VPpvccjVtPL6s2wTm1JJN/J/lpU
         JCpVtF2iMcirTwnLw34slbJhTiw67sR303BxIrp1IcSLeiJtwVL0oSGWWsPwYkeX/SrT
         mVSw==
X-Forwarded-Encrypted: i=1; AJvYcCV7uWy7d8y9vtzhZU0f/sUKdunNuAGhoheYod2AgYNzxteBrPo1fm77hVEGDVKyHkttYgmgb6jzu3GL@vger.kernel.org
X-Gm-Message-State: AOJu0YxYh06Fl5HLSXTN1QBMdMbpAVLOlXikM0FUESfruhqT91kG3MPw
	42eJa/k/F7/lisV42VVzODmwPukEtKUFFXz0YV4ZX+uIeSN3HKC7gnKwZsfIhlY=
X-Google-Smtp-Source: AGHT+IHl+1djh8D5/zTaI8EOd+eUJSMxa7gQJYRF4dAvxMJXV54Ke44oN1iyzFOK5+nQIqB9eAnylw==
X-Received: by 2002:a05:600c:1d02:b0:428:640:c1b1 with SMTP id 5b1f17b1804b1-42c9f985328mr28913525e9.17.1725646060229;
        Fri, 06 Sep 2024 11:07:40 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:12 +0200
Subject: [PATCH v6 09/17] soc: qcom: ice: add HWKM support to the ICE
 driver
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-9-d59e61bc0cb4@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
In-Reply-To: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9572;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=JLFG06y2/CVmmFjvX7qoJO0lgzWocHfOpOak0flGkYo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TYD/AB5xsUCklcRcmLkufb7UBJEZB+YXLti
 +Ul6uT3U1qJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2AAKCRARpy6gFHHX
 cpB0EAC1OFHrBJr93mf0hpGGKUUxHP2gvRHom0quaNwqBzHRlbNlD1wY6s4dW3po7Qhi5fkPTEx
 fiSPLg2sQTUZjYWnUzzKBGP/ORA7TZt47pxt/LJ2Xkp9wVNkeSpeF4Ef/q1dToBLvKPjfTJ0zgt
 Q8H3Tq1IuPPG+Y2H5AcLP1ro3KTW7vEUnMnwC+VAzGXqIa6zYXBtsQxfadO26IigwsqWdIPghDH
 aQkipCZj4+g2NsJb+9gaUxDXH0tbAf1wgFq2B4HWk5eKDGXgrZ5GWXR9xQYjbAlJyaYF+aoo4oj
 3wOrFjwvQGHqhGUfcgUw97tfJPNgmYuAmA87mlbATsgdYT1Zbl89Uzh0kn7MRidsdDriHPf68sN
 3KwCEmq2Z2WP+FgQXAWWTH0CSKo//8L8S/EeesVRgkvko+oQCAMJvCfcdXhXW4QzYJzz86P5YmU
 N63z8i3ITo+U5E0vWQLzXB55nnE1eO5dUE7cRqxYriwxf8SgAF7F8wfVKC6MsMw0bHvnn1VL6LG
 sF5i7Kv3w3aoA64GM9j4f8ft7N7npwENm7kVSS4V9mgwl96hBy577yMI4y9XMssArx+qZPhqAxP
 gCAWpD6fN2sBjwSsGOJkWWy9lb81TEL8S1ranoONdnU8U8kK46cPpnTb+qW6Jq7V9jBxG+I1RIB
 KF2u8TEEVtgtWOA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Qualcomm's ICE (Inline Crypto Engine) contains a proprietary key
management hardware called Hardware Key Manager (HWKM). Add HWKM support
to the ICE driver if it is available on the platform. HWKM primarily
provides hardware wrapped key support where the ICE (storage) keys are
not available in software and instead protected in hardware.

When HWKM software support is not fully available (from Trustzone), there
can be a scenario where the ICE hardware supports HWKM, but it cannot be
used for wrapped keys. In this case, raw keys have to be used without
using the HWKM. We query the TZ at run-time to find out whether wrapped
keys support is available.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/ice.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/soc/qcom/ice.h |   1 +
 2 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 4393262a1bf2..667d993694ac 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -27,6 +27,40 @@
 #define QCOM_ICE_REG_FUSE_SETTING		0x0010
 #define QCOM_ICE_REG_BIST_STATUS		0x0070
 #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
+#define QCOM_ICE_REG_CONTROL			0x0
+/* QCOM ICE HWKM registers */
+#define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
+#define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
+#define QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS	0x2008
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_0			0x5000
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_1			0x5004
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_2			0x5008
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_3			0x500C
+#define QCOM_ICE_REG_HWKM_BANK0_BBAC_4			0x5010
+
+/* QCOM ICE HWKM reg vals */
+#define QCOM_ICE_HWKM_BIST_DONE_V1		BIT(16)
+#define QCOM_ICE_HWKM_BIST_DONE_V2		BIT(9)
+#define QCOM_ICE_HWKM_BIST_DONE(ver)		QCOM_ICE_HWKM_BIST_DONE_V##ver
+
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V1		BIT(14)
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V2		BIT(7)
+#define QCOM_ICE_HWKM_CRYPTO_BIST_DONE(v)		QCOM_ICE_HWKM_CRYPTO_BIST_DONE_V##v
+
+#define QCOM_ICE_HWKM_BOOT_CMD_LIST1_DONE		BIT(2)
+#define QCOM_ICE_HWKM_BOOT_CMD_LIST0_DONE		BIT(1)
+#define QCOM_ICE_HWKM_KT_CLEAR_DONE			BIT(0)
+
+#define QCOM_ICE_HWKM_BIST_VAL(v)	(QCOM_ICE_HWKM_BIST_DONE(v) |		\
+					QCOM_ICE_HWKM_CRYPTO_BIST_DONE(v) |	\
+					QCOM_ICE_HWKM_BOOT_CMD_LIST1_DONE |	\
+					QCOM_ICE_HWKM_BOOT_CMD_LIST0_DONE |	\
+					QCOM_ICE_HWKM_KT_CLEAR_DONE)
+
+#define QCOM_ICE_HWKM_V1_STANDARD_MODE_VAL	(BIT(0) | BIT(1) | BIT(2))
+#define QCOM_ICE_HWKM_V2_STANDARD_MODE_MASK	GENMASK(31, 1)
+#define QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL	(BIT(1) | BIT(2))
+#define QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL	BIT(3)
 
 /* BIST ("built-in self-test") status flags */
 #define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
@@ -35,6 +69,9 @@
 #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
 #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
 
+#define QCOM_ICE_HWKM_REG_OFFSET	0x8000
+#define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
+
 #define qcom_ice_writel(engine, val, reg)	\
 	writel((val), (engine)->base + (reg))
 
@@ -47,6 +84,9 @@ struct qcom_ice {
 	struct device_link *link;
 
 	struct clk *core_clk;
+	u8 hwkm_version;
+	bool use_hwkm;
+	bool hwkm_init_complete;
 };
 
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
@@ -64,8 +104,21 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
 		return false;
 	}
 
-	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
-		 major, minor, step);
+	if (major >= 4 || (major == 3 && minor == 2 && step >= 1))
+		ice->hwkm_version = 2;
+	else if (major == 3 && minor == 2)
+		ice->hwkm_version = 1;
+	else
+		ice->hwkm_version = 0;
+
+	if (ice->hwkm_version == 0)
+		ice->use_hwkm = false;
+
+	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d, HWKM v%d\n",
+		 major, minor, step, ice->hwkm_version);
+
+	if (!ice->use_hwkm)
+		dev_info(dev, "QC ICE HWKM (Hardware Key Manager) not used/supported");
 
 	/* If fuses are blown, ICE might not work in the standard way. */
 	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
@@ -114,27 +167,106 @@ static void qcom_ice_optimization_enable(struct qcom_ice *ice)
  * fails, so we needn't do it in software too, and (c) properly testing
  * storage encryption requires testing the full storage stack anyway,
  * and not relying on hardware-level self-tests.
+ *
+ * However, we still care about if HWKM BIST failed (when supported) as
+ * important functionality would fail later, so disable hwkm on failure.
  */
 static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
 {
 	u32 regval;
+	u32 bist_done_val;
 	int err;
 
 	err = readl_poll_timeout(ice->base + QCOM_ICE_REG_BIST_STATUS,
 				 regval, !(regval & QCOM_ICE_BIST_STATUS_MASK),
 				 50, 5000);
-	if (err)
+	if (err) {
 		dev_err(ice->dev, "Timed out waiting for ICE self-test to complete\n");
+		return err;
+	}
 
+	if (ice->use_hwkm) {
+		bist_done_val = ice->hwkm_version == 1 ?
+				QCOM_ICE_HWKM_BIST_VAL(1) :
+				QCOM_ICE_HWKM_BIST_VAL(2);
+		if (qcom_ice_readl(ice,
+				   HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_STATUS)) !=
+				   bist_done_val) {
+			dev_err(ice->dev, "HWKM BIST error\n");
+			ice->use_hwkm = false;
+			err = -ENODEV;
+		}
+	}
 	return err;
 }
 
+static void qcom_ice_enable_standard_mode(struct qcom_ice *ice)
+{
+	u32 val = 0;
+
+	/*
+	 * When ICE is in standard (hwkm) mode, it supports HW wrapped
+	 * keys, and when it is in legacy mode, it only supports standard
+	 * (non HW wrapped) keys.
+	 *
+	 * Put ICE in standard mode, ICE defaults to legacy mode.
+	 * Legacy mode - ICE HWKM slave not supported.
+	 * Standard mode - ICE HWKM slave supported.
+	 *
+	 * Depending on the version of HWKM, it is controlled by different
+	 * registers in ICE.
+	 */
+	if (ice->hwkm_version >= 2) {
+		val = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
+		val = val & QCOM_ICE_HWKM_V2_STANDARD_MODE_MASK;
+		qcom_ice_writel(ice, val, QCOM_ICE_REG_CONTROL);
+	} else {
+		qcom_ice_writel(ice, QCOM_ICE_HWKM_V1_STANDARD_MODE_VAL,
+				HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
+	}
+}
+
+static void qcom_ice_hwkm_init(struct qcom_ice *ice)
+{
+	/* Disable CRC checks. This HWKM feature is not used. */
+	qcom_ice_writel(ice, QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL,
+			HWKM_OFFSET(QCOM_ICE_REG_HWKM_TZ_KM_CTL));
+
+	/*
+	 * Give register bank of the HWKM slave access to read and modify
+	 * the keyslots in ICE HWKM slave. Without this, trustzone will not
+	 * be able to program keys into ICE.
+	 */
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_0));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_1));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_2));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_3));
+	qcom_ice_writel(ice, GENMASK(31, 0), HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BBAC_4));
+
+	/* Clear HWKM response FIFO before doing anything */
+	qcom_ice_writel(ice, QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL,
+			HWKM_OFFSET(QCOM_ICE_REG_HWKM_BANK0_BANKN_IRQ_STATUS));
+	ice->hwkm_init_complete = true;
+}
+
 int qcom_ice_enable(struct qcom_ice *ice)
 {
+	int err;
+
 	qcom_ice_low_power_mode_enable(ice);
 	qcom_ice_optimization_enable(ice);
 
-	return qcom_ice_wait_bist_status(ice);
+	if (ice->use_hwkm)
+		qcom_ice_enable_standard_mode(ice);
+
+	err = qcom_ice_wait_bist_status(ice);
+	if (err)
+		return err;
+
+	if (ice->use_hwkm)
+		qcom_ice_hwkm_init(ice);
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(qcom_ice_enable);
 
@@ -150,6 +282,10 @@ int qcom_ice_resume(struct qcom_ice *ice)
 		return err;
 	}
 
+	if (ice->use_hwkm) {
+		qcom_ice_enable_standard_mode(ice);
+		qcom_ice_hwkm_init(ice);
+	}
 	return qcom_ice_wait_bist_status(ice);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_resume);
@@ -157,6 +293,7 @@ EXPORT_SYMBOL_GPL(qcom_ice_resume);
 int qcom_ice_suspend(struct qcom_ice *ice)
 {
 	clk_disable_unprepare(ice->core_clk);
+	ice->hwkm_init_complete = false;
 
 	return 0;
 }
@@ -206,6 +343,12 @@ int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
 }
 EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
 
+bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
+{
+	return ice->use_hwkm;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
@@ -240,6 +383,7 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
 		engine->core_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(engine->core_clk))
 		return ERR_CAST(engine->core_clk);
+	engine->use_hwkm = qcom_scm_has_wrapped_key_support();
 
 	if (!qcom_ice_check_supported(engine))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 9dd835dba2a7..1f52e82e3e1c 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -34,5 +34,6 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 const struct blk_crypto_key *bkey,
 			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
+bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */

-- 
2.43.0


