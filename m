Return-Path: <linux-scsi+bounces-8841-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59699ABF7
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Oct 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB27286811
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Oct 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC21E5727;
	Fri, 11 Oct 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tzk9zX6N"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC001D04A4
	for <linux-scsi@vger.kernel.org>; Fri, 11 Oct 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672890; cv=none; b=Yt0QxBNKCKm3xjzjF+p/ACnZH+QPFYPW0VCEhkdU6gjQ+Ewyt37O/l18R5dyryyehu7F0plO27+lPqom15HxqkQ25ESISznqqM37A1e2wt4ThJvNbN7ov4ADwp0Z5P/tLSG7wn1gpCbpcYAicQHeoBz+h/JZh74Abo5wJ2obb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672890; c=relaxed/simple;
	bh=Fp9wq3ZtQFq/uTh7cxPI+ZLTbg5uSwhh859jzCiLJj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eeS72tFM1RkZ04B8fcc+lm7P8Z0O7g+WfrEg9UmP7ZWRZhS5fhUqC5wB2ALIuPuBykRbCiJq9W93M7QObOuznrFvqar0pkfCEnJWMVQ+xhfo+jHGyy7fHDKvHbh34IHh/Fcw2pS2aeXe6UrsWudrlUMRyp//77om1RYkU+hrAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tzk9zX6N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4311695c6c2so17116335e9.1
        for <linux-scsi@vger.kernel.org>; Fri, 11 Oct 2024 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672883; x=1729277683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZb5eGhW+yHrp6LLSYxnRM6nvxA+fWqJwJ3y6fvQXrQ=;
        b=tzk9zX6NSPVU6r7ATUucD3N3cgfnO1KnHDKyNP2Zz5EelUxHTKFBy7OFBoDAWlfOcB
         0CC8JTrItY9lXu3/9Ssbs2sQfccMluSK953wpPIr3RyIMo2DnhGGDEjGisNzwFSzgnW4
         FAOoS1khMDe+l7HSd6xUhw9YQCQq0VSzWWE+dFLUhol30XXS9BGUazU6NT5zbgB2RDTn
         JcV8ocE3nuk1x8FWKK2fHtJVO5Cks63NLFsGZ0cVVZg0I9ZuH02DN9W6qeQ4nbq1UgGJ
         6o6foMhmLkpRAK/z3T29ecEPHRL4XhH1/deQlKOueZNGNbqR82W7hNcViPAnkzv2mcS8
         VeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672883; x=1729277683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZb5eGhW+yHrp6LLSYxnRM6nvxA+fWqJwJ3y6fvQXrQ=;
        b=HzR+YpwT1ep72lNbD9XNF1g5gECcj+ZK8HH14NqtT2XiNfdbq0KpZRSy6AWaG9lPf/
         2YggnZWTGwM1VxxiDTEA9F4U0n4foO+dMtYwcWuzOlukkeXxNs6nUIrnWQcwWhxKD1kY
         f82f5RNTLsHfdbaNWN10z9ZRyW+2qcqHYa9y8qU42LUomQ7PNLn4547X6X/81SNUoWY5
         /RX0+JnMl52vXY0M1Iu6zsvVDm6ukyeT3fExmDAunOIpGFRGqgHzxn4h4R2B2eAyT6H9
         wh/QIn7c911PvtTGF30UpEqBLySQWgli5K4li2H+Ie6woTp6LA2yjlHuLBLaa7r6Vmmj
         Rdnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2tJhnnUe9xkyFe2ACaF+WSlHzlJuhQIRoCAU0k7vEX4w3aQYRVxnJD1oK8S9zT07XulolsiVW2/MR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JzcuZufz5VGGLAoBwruhnSXQOPwyqyXtl/sY8ZbExDUNsn4E
	lbC//2IE18IZJdSID0aFckdk5gggxfzij1BdmveUxxlFjm1OpOIvsHnXsTgi52E=
X-Google-Smtp-Source: AGHT+IG7xhf7VJhXkSusSN8cCIhf+djvKxcuAo7wK7GAstrIFO0o2ioqU4M4R6an0um1UPLgxIsvHg==
X-Received: by 2002:a05:600c:3496:b0:42c:b22e:fbfa with SMTP id 5b1f17b1804b1-431255e765amr3588755e9.21.1728672882885;
        Fri, 11 Oct 2024 11:54:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:09 +0200
Subject: [PATCH v7 10/17] soc: qcom: ice: add support for hardware wrapped
 keys
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-10-e3f7a752059b@linaro.org>
References: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
In-Reply-To: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8347;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=1qrZ+cI8tCGtiGLI4tYrHaGnHNxmtAVnemK62xuanzo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRfRzTuHD9UxyEoGwdhXyBCEF/vefyrxSG7V
 ntJsPD6Q2iJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XwAKCRARpy6gFHHX
 craxEACeRmozUjrwNqtCwCc2kUwXVXkMpUP3Uy+OjRbyrqlZXgHwc+jmmVkrS+zksyOJ1WeiGEw
 9xEUT9voluHz1PHlED1zfcuvZD6hrZEh56JaIt94DS2nKs1w2MzUI4n9zpxaOh3P2xIYDvLuKyi
 2DHdqEFS/IE0E8k7KHrtbl2UbCv2UOdL+BgG0JvT7TkS1ysJZAFwirLksjTW5Msv0InabRE/Gg1
 t8VgD4A0FICjtIExaJOPIwIEH/5mFU7dLKCaGB6eiyoFcuvk8Bfx1aUfev+Udj+yoOJh+TIOYhG
 pnvis4ijUXYSJF3dWt2NfBa7uT2/TsCBCNbLB25QbuDIFvrTSV0G3kq6TlAIkFAMr8P41xo94O4
 FnM95G/RXEopT+ZdvSOuXOo2iwRv0vQlzorwfrQNZ01XOzBQ5P9T7LZg+wNT562GYauaW43HIyf
 Px9qNpkDoirb7nlxQu04yQJJrgtkxg3fjAt7tD2STijsrd9aJTAnQBjTfnyRXdiWBtSrbpuSdGE
 QUxInv48Vp25ZXZTNe2fATYMxxHzC1+VL7jUDjYWMPRPlV/+zzq9E3XkvB+PYAd6Ngdt+WT9a6R
 PxiYYDhFS3XDtmLi2aL89BuDAaucQhkhqMa0hKXlu+pd2mQus+kMYJVpjTfLWDhBIQPezc7GZ+X
 KjwqhygmH1U4riQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Now that HWKM support has been added to ICE, extend the ICE driver to
support hardware wrapped keys programming coming in from the storage
controllers (UFS and eMMC). This is similar to raw keys where the call is
forwarded to Trustzone, however we also need to clear and re-enable
CFGE before and after programming the key.

Derive software secret support is also added by forwarding the call to
the corresponding SCM API.

Wrapped keys are only used if the new module parameter is set AND the
architecture supports HWKM.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/ice.c | 128 ++++++++++++++++++++++++++++++++++++++++++++-----
 include/soc/qcom/ice.h |   4 ++
 2 files changed, 121 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 667d993694ac..1f22453ab332 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -28,6 +28,8 @@
 #define QCOM_ICE_REG_BIST_STATUS		0x0070
 #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
 #define QCOM_ICE_REG_CONTROL			0x0
+#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16		0x4040
+
 /* QCOM ICE HWKM registers */
 #define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
 #define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
@@ -62,6 +64,8 @@
 #define QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL	(BIT(1) | BIT(2))
 #define QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL	BIT(3)
 
+#define QCOM_ICE_HWKM_CFG_ENABLE_VAL		BIT(7)
+
 /* BIST ("built-in self-test") status flags */
 #define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
 
@@ -69,6 +73,8 @@
 #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
 #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
 
+#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET	0x80
+
 #define QCOM_ICE_HWKM_REG_OFFSET	0x8000
 #define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
 
@@ -78,6 +84,15 @@
 #define qcom_ice_readl(engine, reg)	\
 	readl((engine)->base + (reg))
 
+#define QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot) \
+	(QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 + \
+	 QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot)
+
+static bool ufs_qcom_use_wrapped_keys;
+module_param_named(use_wrapped_keys, ufs_qcom_use_wrapped_keys, bool, 0660);
+MODULE_PARM_DESC(use_wrapped_keys,
+"Use HWKM for wrapped keys support if available on the platform");
+
 struct qcom_ice {
 	struct device *dev;
 	void __iomem *base;
@@ -89,6 +104,16 @@ struct qcom_ice {
 	bool hwkm_init_complete;
 };
 
+union crypto_cfg {
+	__le32 regval;
+	struct {
+		u8 dusize;
+		u8 capidx;
+		u8 reserved;
+		u8 cfge;
+	};
+};
+
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
 {
 	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
@@ -299,6 +324,46 @@ int qcom_ice_suspend(struct qcom_ice *ice)
 }
 EXPORT_SYMBOL_GPL(qcom_ice_suspend);
 
+/*
+ * For v1 the ICE slot will be calculated in the trustzone.
+ */
+static int translate_hwkm_slot(struct qcom_ice *ice, int slot)
+{
+	return (ice->hwkm_version == 1) ? slot : (slot * 2);
+}
+
+static int qcom_ice_program_wrapped_key(struct qcom_ice *ice,
+					const struct blk_crypto_key *key,
+					u8 data_unit_size, int slot)
+{
+	union crypto_cfg cfg = {
+		.dusize = data_unit_size,
+		.capidx = QCOM_SCM_ICE_CIPHER_AES_256_XTS,
+		.cfge = QCOM_ICE_HWKM_CFG_ENABLE_VAL,
+	};
+	int hwkm_slot;
+	int err;
+
+	hwkm_slot = translate_hwkm_slot(ice, slot);
+
+	/* Clear CFGE */
+	qcom_ice_writel(ice, 0x0, QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot));
+
+	/* Call trustzone to program the wrapped key using hwkm */
+	err = qcom_scm_ice_set_key(hwkm_slot, key->raw, key->size,
+				   QCOM_SCM_ICE_CIPHER_AES_256_XTS, data_unit_size);
+	if (err) {
+		pr_err("%s:SCM call Error: 0x%x slot %d\n", __func__, err,
+		       slot);
+		return err;
+	}
+
+	/* Enable CFGE after programming key */
+	qcom_ice_writel(ice, cfg.regval, QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot));
+
+	return err;
+}
+
 int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 algorithm_id, u8 key_size,
 			 const struct blk_crypto_key *bkey,
@@ -314,24 +379,40 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 
 	/* Only AES-256-XTS has been tested so far. */
 	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
-	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
+	    (key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256 &&
+	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED)) {
 		dev_err_ratelimited(dev,
 				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
 				    algorithm_id, key_size);
 		return -EINVAL;
 	}
 
-	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
+	if (ufs_qcom_use_wrapped_keys &&
+	    (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)) {
+		/* It is expected that HWKM init has completed before programming wrapped keys */
+		if (!ice->use_hwkm || !ice->hwkm_init_complete) {
+			dev_err_ratelimited(dev, "HWKM not currently used or initialized\n");
+			return -EINVAL;
+		}
+		err = qcom_ice_program_wrapped_key(ice, bkey, data_unit_size,
+						   slot);
+	} else {
+		if (bkey->size != QCOM_ICE_CRYPTO_KEY_SIZE_256)
+			dev_err_ratelimited(dev,
+					    "Incorrect key size; bkey->size=%d\n",
+					    algorithm_id);
+		return -EINVAL;
+		memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
 
-	/* The SCM call requires that the key words are encoded in big endian */
-	for (i = 0; i < ARRAY_SIZE(key.words); i++)
-		__cpu_to_be32s(&key.words[i]);
+		/* The SCM call requires that the key words are encoded in big endian */
+		for (i = 0; i < ARRAY_SIZE(key.words); i++)
+			__cpu_to_be32s(&key.words[i]);
 
-	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
-				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
-				   data_unit_size);
-
-	memzero_explicit(&key, sizeof(key));
+		err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
+					   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
+					   data_unit_size);
+		memzero_explicit(&key, sizeof(key));
+	}
 
 	return err;
 }
@@ -339,7 +420,23 @@ EXPORT_SYMBOL_GPL(qcom_ice_program_key);
 
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot)
 {
-	return qcom_scm_ice_invalidate_key(slot);
+	int hwkm_slot = slot;
+
+	if (ice->use_hwkm) {
+		hwkm_slot = translate_hwkm_slot(ice, slot);
+
+		/*
+		 * Ignore calls to evict key when HWKM is supported and hwkm
+		 * init is not yet done. This is to avoid the clearing all
+		 * slots call during a storage reset when ICE is still in
+		 * legacy mode. HWKM slave in ICE takes care of zeroing out
+		 * the keytable on reset.
+		 */
+		if (!ice->hwkm_init_complete)
+			return 0;
+	}
+
+	return qcom_scm_ice_invalidate_key(hwkm_slot);
 }
 EXPORT_SYMBOL_GPL(qcom_ice_evict_key);
 
@@ -349,6 +446,15 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice)
 }
 EXPORT_SYMBOL_GPL(qcom_ice_hwkm_supported);
 
+int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
+			      unsigned int wkey_size,
+			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	return qcom_scm_derive_sw_secret(wkey, wkey_size,
+					 sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
+}
+EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index 1f52e82e3e1c..dabe0d3a1fd0 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -17,6 +17,7 @@ enum qcom_ice_crypto_key_size {
 	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
 	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
 	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
+	QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED	= 0x5,
 };
 
 enum qcom_ice_crypto_alg {
@@ -35,5 +36,8 @@ int qcom_ice_program_key(struct qcom_ice *ice,
 			 u8 data_unit_size, int slot);
 int qcom_ice_evict_key(struct qcom_ice *ice, int slot);
 bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
+int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
+			      unsigned int wkey_size,
+			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */

-- 
2.43.0


