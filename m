Return-Path: <linux-scsi+bounces-12163-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8ADA2F9F4
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6984B3A4DBA
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0D2505DB;
	Mon, 10 Feb 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaR4AXlt"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638BC2505B6;
	Mon, 10 Feb 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219110; cv=none; b=W8vJyUwztj6kvqPMFRHtt4gXORFNU8nA6BsO+hyJTNBDKW+hahltCSlxmr/bSQnrNuOY3V5itojCvmykF8yrVman3RFknwBlCXgBQLg3WskMIV7j0WN9CKRhSWpHVBwPOmUowJHbaVrsq8jHISWgpk3dsSKf2Ql+JPqd1jZ7yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219110; c=relaxed/simple;
	bh=FGi1R8qyhVRxpLPKTI8ijkLnVxBeeJqv19GVfmaeLMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiDtDDYhiAktY6jc9rXjqnKMU7ccmo5KZ/GcyRbe2EnpSJBRCu8pon6eQhB2Cm0/LwBrdzYF8w+vVZczwK3yODCOc+KtCDqERY9v+bjQbS4rrP5vuNvX6jDdmziem0f4g+1aAqY2XSSIvL7av4WlcPWwQIhfPGcHa4VKvxxaH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaR4AXlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD495C4CEE9;
	Mon, 10 Feb 2025 20:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739219110;
	bh=FGi1R8qyhVRxpLPKTI8ijkLnVxBeeJqv19GVfmaeLMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaR4AXltkpKFyE8nQ9cUFOvL07P43GWIBTmuh6E6V6CuVOq9OCCnyAhdq6rB1HMEL
	 PdyXfy/MehX+x1xflLb8pQ/KKFc+GfkRMMBB1m7mngFL5E0usyY0QI9Eu0qmwpioEv
	 R53n3Ar4tYcrKkwGs9AgU5tu0XVqof3XZoT6Ihbh5qZdH89qjiVAE6ysfrLWeJy4k2
	 LigTAZJgRW+fh8OBfQE57NM+0R2y2H9BmXwOa4ii6w7gS404qNeaxgBcxUxGPhGmzZ
	 ttqgehDwB7ML7ga/1zo4dMvHkHbjt0GFWRyp0lovVgymTYf/uGRyXa7qh4CcHUlBIZ
	 PNLn9Pn0vHm6g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Gaurav Kashyap <quic_gaurkash@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v12 3/4] ufs: qcom: add support for wrapped keys
Date: Mon, 10 Feb 2025 12:23:35 -0800
Message-ID: <20250210202336.349924-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210202336.349924-1-ebiggers@kernel.org>
References: <20250210202336.349924-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Wire up the wrapped key support for ufs-qcom by implementing the needed
methods in struct blk_crypto_ll_ops and setting the appropriate flag in
blk_crypto_profile::key_types_supported.

For more information about this feature and how to use it, refer to
the sections about hardware-wrapped keys in
Documentation/block/inline-encryption.rst and
Documentation/filesystems/fscrypt.rst.

Based on patches by Gaurav Kashyap <quic_gaurkash@quicinc.com>.
Reworked to use the custom crypto profile support.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> # sm8650
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/ufs/host/ufs-qcom.c | 51 ++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f34527fb02fb..dc3eb6f29f5b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -132,15 +132,10 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	}
 
 	if (IS_ERR_OR_NULL(ice))
 		return PTR_ERR_OR_ZERO(ice);
 
-	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
-		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
-		return 0;
-	}
-
 	host->ice = ice;
 
 	/* Initialize the blk_crypto_profile */
 
 	caps.reg_val = cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
@@ -150,11 +145,11 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	if (err)
 		return err;
 
 	profile->ll_ops = ufs_qcom_crypto_ops;
 	profile->max_dun_bytes_supported = 8;
-	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
+	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
 	profile->dev = dev;
 
 	/*
 	 * Currently this driver only supports AES-256-XTS.  All known versions
 	 * of ICE support it, but to be safe make sure it is really declared in
@@ -218,13 +213,57 @@ static int ufs_qcom_ice_keyslot_evict(struct blk_crypto_profile *profile,
 	err = qcom_ice_evict_key(host->ice, slot);
 	ufshcd_release(hba);
 	return err;
 }
 
+static int ufs_qcom_ice_derive_sw_secret(struct blk_crypto_profile *profile,
+					 const u8 *eph_key, size_t eph_key_size,
+					 u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_derive_sw_secret(host->ice, eph_key, eph_key_size,
+					 sw_secret);
+}
+
+static int ufs_qcom_ice_import_key(struct blk_crypto_profile *profile,
+				   const u8 *raw_key, size_t raw_key_size,
+				   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_import_key(host->ice, raw_key, raw_key_size, lt_key);
+}
+
+static int ufs_qcom_ice_generate_key(struct blk_crypto_profile *profile,
+				     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_generate_key(host->ice, lt_key);
+}
+
+static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
+				    const u8 *lt_key, size_t lt_key_size,
+				    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
+}
+
 static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
 	.keyslot_program	= ufs_qcom_ice_keyslot_program,
 	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
+	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
+	.import_key		= ufs_qcom_ice_import_key,
+	.generate_key		= ufs_qcom_ice_generate_key,
+	.prepare_key		= ufs_qcom_ice_prepare_key,
 };
 
 #else
 
 static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
-- 
2.48.1


