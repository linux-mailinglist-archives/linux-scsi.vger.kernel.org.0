Return-Path: <linux-scsi+bounces-8839-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44F999ABE3
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Oct 2024 20:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F228657A
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Oct 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B9B1D173D;
	Fri, 11 Oct 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="umaHx467"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A681D0B96
	for <linux-scsi@vger.kernel.org>; Fri, 11 Oct 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672887; cv=none; b=MrQVgpx3fVCROCVIlq1SK87qPQQoRoOEbtTkzSXM+WQrDcRCOqAgpu1+oeO4/W6LYrCV0Jy8SO3sqIc5NOUBkbJEaH6bIw/RfA2XkW3D8GCHb6qmq5Q7PfDM9/NGC+FSOTppgxhXcGB5HLMmjYSNLyfeV2HAY4p/pxeolz0OSx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672887; c=relaxed/simple;
	bh=4tSMqXGX/3ETUOMKuUjYph4+Zl/mK4LSfM1HiT+8vN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUvrywU9vjPqvzhZAMgfaY28+kt3+4dt5YKr/vvtDziG6qG8x103R4KTiSvkTXu3ag/Kxme0wmiLXQbpPcxVyJRzvhLUs43wMepeZNOR2auKODQi3w80g7gb2sZHf3gnADW9uMy5q10kon7mOXwQ6DTNW3yR9AkiQJumltwW7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=umaHx467; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d447de11dso1531860f8f.1
        for <linux-scsi@vger.kernel.org>; Fri, 11 Oct 2024 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672878; x=1729277678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fBQGAiKArd769nsi4mYfjlrkxDV83MQGk5ueRBcZsk=;
        b=umaHx467lXWMi46aZlOfBezqLWZ1q5xyEAA+tq3PLahUt90KQ9iQzPmkAm8BMu10DY
         GC0KP3yKtXSoW7AOMeq7QIK0ply7chYBktWJpcl71myXx+y/QiT+2tadri2/lmZMj4Iv
         JT8KeMb1ACojKswVSj9Ln61J/sMZjSqdqIoHLJeXxCkNiZtn188oT8QLg2t1KaKIxjnl
         kykTnDCy1n0NP92pMsxTK8asnOKP8UoZOlTBNNLox4o4jO8jbfX9sjchXO2NamBdlR+v
         TyLlkaLs/LTi1voUids4DSe89P+xu9XR1fg467JLaYjsnTljO3yzAh5MdS4uhDaPKV2k
         s38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672878; x=1729277678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fBQGAiKArd769nsi4mYfjlrkxDV83MQGk5ueRBcZsk=;
        b=dcODju/So9Bme3/FgWJ0X1eFKzeJ1McR6qrGJe3NKQNb85SPU/BG3w1DWmVrDrGJWE
         jYuo1k8t/VIeVrZ9sKGH51/fx0XdZUJiKFUxroMA0WiTYrDKT1AY7XOLxxwJ2v74otte
         I4oiVQ0xwW77/WGcoVxHiFZ/80rS55tMG/0t+IZeAnu9SKdZGqNSftJVQTE/IvkBwLTv
         E6P+5sB0k2G7VM/5yRZMwWuP2LAc/HZewX/+HLHBUH7x63TghCsd5Z5bMKhIRgvuzXdI
         KkEocAQzxMH8JgB/TVucKi3XMywPfeYNmojLPt87uSN9EKFnaamFRW9AAsKtmrYWLaEW
         vNeg==
X-Forwarded-Encrypted: i=1; AJvYcCURQ2qUm154Pz5f4Ll5h9Zo/9vVgndmUKe3Uk0bBVxOn5+lLcMR76DwNVW9c5cof1oHYSsiT2kUrQUk@vger.kernel.org
X-Gm-Message-State: AOJu0YzX2lBncMMHsOhMi78n05GBHiB7BIOfviSfkr+hQOjNma7uPxjT
	IAss7F4teLHV0mkB9Ij/yaYnlFemT/BO7p4sJG9gUt+/bhLPTMXWl9CAPi7mTCQ=
X-Google-Smtp-Source: AGHT+IGGQ6RiFp9mxtQK4IZAf9S/fcCDsP1OdM98Kb3iWa5znBD4baXzZoXLBsdvuBRnC9GKLmTIGA==
X-Received: by 2002:a05:6000:18c:b0:37d:5173:7a54 with SMTP id ffacd0b85a97d-37d552d8858mr2567965f8f.52.1728672878481;
        Fri, 11 Oct 2024 11:54:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:06 +0200
Subject: [PATCH v7 07/17] firmware: qcom: scm: add calls for creating,
 preparing and importing keys
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-7-e3f7a752059b@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8044;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=n2w7tDh91QSO/VCvctNHCH3FCBZSppE4FqQ9BuGYdig=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRedmNOyQclM3efsfE1xIzmfzcXdAdvsiCds
 Cw67I+4UIiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XgAKCRARpy6gFHHX
 cjVMEAC8WumT6S/Z4BadeUEP7I8IKC7ktgYxERz/FB8eBThq9vc1sNwu+iR5IW/En7JNlHMCbj5
 870up/MuITOauIGZE/0pmFqXz7NXBdNiUVjtorypetGopjwyHcu73WVV8LVKnAG/dGrM/cryiEJ
 b1/FPitB6ChC5fPBAL+xClNbrAIIDSUtEufarldvQqg87+Lj6haKsFewFASHBvK2B0zGynXMm6j
 Qi+VpJglGqh0LhNGzCjfx4fysYcVa00IxDlha2JzITaVW7nlDFSJr47JmL/EkKJ87+MtqkU+9Ln
 wBre94tWjPhDKZWMUUayv4bCWFoSsYLdCFLz50+fAdPbWtQnMXMAjZ/6ZF1/P0reT6w3r9oBzZ0
 F1gw72q2uyGKaXOQQpEetJzMAQs8S5j8qFtB/qD8kGOLdOulIPhhWk5CGMydQjRv9uZuWC4ESgY
 PYbKiemrdDHj6rtuGagZOveE0T5rSPHUofNLc6gj6CcvtXfCgU5CUBo643htwa0An6rSGKpez5i
 Akh+O8ypOmGlkp/YNSu8QbMFAcweqtiGWxT7cUcs9gvIJ9Ybnb079sWTB8rcZozIWk9YVVEDoh1
 RA5g0Yh4Eta7Q0KPovdRj+qAL4DqI0TnlC/EI4C/U0ztvzJQWk+E30xH/vHXLdApGMbXw9hF3Vr
 mt4tQmrehnlyCbA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Storage encryption has two IOCTLs for creating, importing and preparing
keys for encryption. For wrapped keys, these IOCTLs need to interface
with Qualcomm's Trustzone. Add the following keys:

generate_key:
  This is used to generate and return a longterm wrapped key. Trustzone
  achieves this by generating a key and then wrapping it using the
  Hawrdware Key Manager (HWKM), returning a wrapped keyblob.

import_key:
  The functionality is similar to generate, but here: a raw key is
  imported into the HWKM and a longterm wrapped keyblob is returned.

prepare_key:
  The longterm wrapped key from the import or generate calls is made
  further secure by rewrapping it with a per-boot, ephemeral wrapped key
  before installing it in the kernel for programming into ICE.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
[Bartosz:
  improve kerneldocs,
  fix hex values coding style,
  rewrite commit message]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 161 +++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |   3 +
 include/linux/firmware/qcom/qcom_scm.h |   5 +
 3 files changed, 169 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index de90d21c2dfa..3a59fd2a45b5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1317,6 +1317,167 @@ int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
 
+/**
+ * qcom_scm_generate_ice_key() - Generate a wrapped key for encryption.
+ * @lt_key: the wrapped key returned after key generation
+ * @lt_key_size: size of the wrapped key to be returned.
+ *
+ * Generate a key using the built-in HW module in the SoC. Wrap the key using
+ * the platform-specific Key Encryption Key and return to the caller.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_GENERATE_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
+		.args[1] = lt_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *lt_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       lt_key_size,
+							       GFP_KERNEL);
+	if (!lt_key_buf)
+		return -ENOMEM;
+
+	desc.args[0] = qcom_tzmem_to_phys(lt_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(lt_key, lt_key_buf, lt_key_size);
+
+	memzero_explicit(lt_key_buf, lt_key_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_generate_ice_key);
+
+/**
+ * qcom_scm_prepare_ice_key() - Get the per-boot ephemeral wrapped key
+ * @lt_key: the longterm wrapped key
+ * @lt_key_size: size of the wrapped key
+ * @eph_key: ephemeral wrapped key to be returned
+ * @eph_key_size: size of the ephemeral wrapped key
+ *
+ * Qualcomm wrapped keys (longterm keys) are rewrapped with a per-boot
+ * ephemeral key for added protection. These are ephemeral in nature as
+ * they are valid only for that boot.
+ *
+ * Retrieve the key wrapped with the per-boot ephemeral key and return it to
+ * the caller.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
+			     u8 *eph_key, size_t eph_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_PREPARE_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = lt_key_size,
+		.args[3] = eph_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *lt_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       lt_key_size,
+							       GFP_KERNEL);
+	if (!lt_key_buf)
+		return -ENOMEM;
+
+	void *eph_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+								eph_key_size,
+								GFP_KERNEL);
+	if (!eph_key_buf) {
+		ret = -ENOMEM;
+		goto out_free_longterm;
+	}
+
+	memcpy(lt_key_buf, lt_key, lt_key_size);
+	desc.args[0] = qcom_tzmem_to_phys(lt_key_buf);
+	desc.args[2] = qcom_tzmem_to_phys(eph_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(eph_key, eph_key_buf, eph_key_size);
+
+	memzero_explicit(eph_key_buf, eph_key_size);
+
+out_free_longterm:
+	memzero_explicit(lt_key_buf, lt_key_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_prepare_ice_key);
+
+/**
+ * qcom_scm_import_ice_key() - Import a wrapped key for encryption
+ * @imp_key: the raw key that is imported
+ * @imp_key_size: size of the key to be imported
+ * @lt_key: the wrapped key to be returned
+ * @lt_key_size: size of the wrapped key
+ *
+ * Import a raw key and return a long-term wrapped key to the caller.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_key_size,
+			    u8 *lt_key, size_t lt_key_size)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_ES,
+		.cmd =  QCOM_SCM_ES_IMPORT_ICE_KEY,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_RO,
+					 QCOM_SCM_VAL, QCOM_SCM_RW,
+					 QCOM_SCM_VAL),
+		.args[1] = imp_key_size,
+		.args[3] = lt_key_size,
+		.owner = ARM_SMCCC_OWNER_SIP,
+	};
+
+	int ret;
+
+	void *imp_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+								imp_key_size,
+								GFP_KERNEL);
+	if (!imp_key_buf)
+		return -ENOMEM;
+
+	void *lt_key_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       lt_key_size,
+							       GFP_KERNEL);
+	if (!lt_key_buf) {
+		ret = -ENOMEM;
+		goto out_free_longterm;
+	}
+
+	memcpy(imp_key_buf, imp_key, imp_key_size);
+	desc.args[0] = qcom_tzmem_to_phys(imp_key_buf);
+	desc.args[2] = qcom_tzmem_to_phys(lt_key_buf);
+
+	ret = qcom_scm_call(__scm->dev, &desc, NULL);
+	if (!ret)
+		memcpy(lt_key, lt_key_buf, lt_key_size);
+
+	memzero_explicit(lt_key_buf, lt_key_size);
+
+out_free_longterm:
+	memzero_explicit(imp_key_buf, imp_key_size);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_import_ice_key);
+
 /**
  * qcom_scm_hdcp_available() - Check if secure environment supports HDCP.
  *
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 5a98b90ece32..85f46ae7bd37 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -128,6 +128,9 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_ES_INVALIDATE_ICE_KEY	0x03
 #define QCOM_SCM_ES_CONFIG_SET_ICE_KEY	0x04
 #define QCOM_SCM_ES_DERIVE_SW_SECRET	0x07
+#define QCOM_SCM_ES_GENERATE_ICE_KEY	0x08
+#define QCOM_SCM_ES_PREPARE_ICE_KEY	0x09
+#define QCOM_SCM_ES_IMPORT_ICE_KEY	0x0a
 
 #define QCOM_SCM_SVC_HDCP		0x11
 #define QCOM_SCM_HDCP_INVOKE		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 0ef4415e2023..b5ab39b35490 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -105,6 +105,11 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 			 enum qcom_scm_ice_cipher cipher, u32 data_unit_size);
 int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
 			      u8 *sw_secret, size_t sw_secret_size);
+int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size);
+int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
+			     u8 *eph_key, size_t eph_size);
+int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_size,
+			    u8 *lt_key, size_t lt_key_size);
 
 bool qcom_scm_hdcp_available(void);
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);

-- 
2.43.0


