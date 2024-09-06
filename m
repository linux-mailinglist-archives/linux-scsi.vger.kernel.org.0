Return-Path: <linux-scsi+bounces-8016-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4496FAE1
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F911F2698C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1561EB239;
	Fri,  6 Sep 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T8TWrpCI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0901E8B8C
	for <linux-scsi@vger.kernel.org>; Fri,  6 Sep 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646072; cv=none; b=kFH02lMyADs640HypeXwePDlTHHrlpKX7Mn/f2jUprYb4qOWX8suykXQ19BvMzL2VAo/jzndWxqrER4VIKKsArXpVQIZoYh4qSmilJW40j5XqjY6gky+PDc1wMRJKTpmReICx+VvAndPAqclOCJ0G519xSKuJ4hay2YEXOUwno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646072; c=relaxed/simple;
	bh=v2tO0O94AerGz2LUuB8pKOb7WappRT0VgI/JVLJXFhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cajwPBwSj4GEFeGl+H1J3yG6T3STNWZYd+cMts3zibmBAgjB7kmifYdAwUUGRRq96ke7B8uHmXx/hnHVqZVVA21TrFVnOpQ9O1SEvzwLTULiq0tyyuaZu1nQ0unRQnz4ZvWbs/GvvsGTl0ywfcZyxnrBQWhBuyGk5YVUDz9Q5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T8TWrpCI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso24561475e9.1
        for <linux-scsi@vger.kernel.org>; Fri, 06 Sep 2024 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646065; x=1726250865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKYSUreMTU+cYcBanJBY4jsV8klLofDdBOXT6M/7hYU=;
        b=T8TWrpCIuctV5DAz/u2x7zHqwAe2V86C3MLTQNL2T7i/L8pMPxxXjVKeplWl6CoQk4
         Oqcnum43iYrA1GiDGAt3l63ww6vITxjwEf0Z3To93iJ4SvAcjgMQQl9b4CdIINFUtiVO
         ZJVb7n2L23LtZwL8dfO5+linQtC9ob9GTFejz7C0XHhjoKK48S5fZTpSOVxJuUiF7KEb
         M43HuXeH2yH33ppIoC/W7ZxCaU7MD2Qejr+bQR4S52smT8MVgS6b3+QjRBCG4xWAoH6m
         AFD361RVnhWNIMYO1BhyFtOa957PDq6b2mbkcJzH/NWUWbU3BculTndyJwPan74DZuDF
         MGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646065; x=1726250865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKYSUreMTU+cYcBanJBY4jsV8klLofDdBOXT6M/7hYU=;
        b=lqOe6k5M0vVHrkxeax5pDzr5XX4ZVR3eAEClyU8A7x1Hsf3ZaScIdGhRsnj8SJi8/j
         fJx9BkS3uumpvGykt9oaPTkB3tXmA57fHgLuVCxU0vqLxpdcS7R1HudaQ9/8l1xdgiw3
         kMxx7dqnxOgfEllb70xdjqxtnGpHGiMoMOMuzJMDGAMTGzr5nYcKGaPXm5W5jj/C2M/w
         XwKNRkrD92wxRUhh0o+lPJXXsKd2y1pRvOumsUmiLL7qNbFcdfRgHeHLdsW7aXumNNVf
         TAf13MBTL0v/8+rQTxGeYConltIuHoz3YFAh7nsiczorl30rGPpGDO2d0ah6cFg9cq2T
         VSzw==
X-Forwarded-Encrypted: i=1; AJvYcCXqQ5URaNLoJJ7LGe5bdNyeWJqhKqtrT5jGrBtcbt70xSUH7WHUDTdRUj92ZhfzEH0M4tqev2BixjFH@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqCMcCz+dt56kFMLDWdT5K82/ZYBYUcs2jlHlfRafWfJ929lS
	HrpUsFhV6fSQM7jQXoklpXXGY4stFWOsq8SUEW6KnRd6Em/QgRMfeneQF0bU86Q=
X-Google-Smtp-Source: AGHT+IG/bcl0ijWM56B1Ut7S3j3JidAh27X2k+mXcwIK1jSGhrPibR4sJ0Dd8bUW1u6ev0lEeRdFBw==
X-Received: by 2002:a05:600c:3b1f:b0:426:5c81:2538 with SMTP id 5b1f17b1804b1-42c9f985531mr31972915e9.14.1725646064963;
        Fri, 06 Sep 2024 11:07:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:15 +0200
Subject: [PATCH v6 12/17] ufs: core: add support for wrapped keys to UFS
 core
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-12-d59e61bc0cb4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=/sqAFi9u5Ck7AfDW2yMPqBtleNfVOqWAItv0MOZDM6E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TZcF163x8w9RwtukS3YkahtqYJEij0WTH07
 QGxLWLaay2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2QAKCRARpy6gFHHX
 chB0D/49pBObw6UmMZQwxlreD6oUfx245xn9ZAV/4wuZKzrbcdba6wNH+4Haevvfe0eCH0UEque
 DxZTyF5XHJYv9JiGmmOW+F5leQNJbff//erU/tEhHUISAIsQVoeTusYmPIuSXK7iDvzPgPyTsZS
 QFgTO5EJbQyyurs9VliXV1jbtAN22oIKkzy2xIngynFjIsiD6tZr8Vh7VfV6puHKrLSLN1pf6X9
 g9EEzzueajKOmLeD10Ed8ezbNbDK7HMA2yLaC0rPSrk7cfYxRfXapoK3t20Gl3SwyZsgjWky8+N
 vBTQNoZSco2DVsWlXhErHtiKjq1nS9VL46M0B8Do9A7jPhMI6DgoAru45nEpRblT1N5YlVR1IUt
 t5RKZ5mRbpRr6/UFmHywlN5+9hi/cSYtFZubT6iLUxmlc1NRrCyGSNvLiCVmuzGTUZu5SjWXAU+
 jihvFiKxMrSN7qtzxK8uAaEHpLxl7Wz5wltnOFjybMbqX7FZioF4Rig/tPYCIZeBQQU2ehNYQgQ
 XL5ylTzTDN2RHXLmxYBrxVJP9bpmTHGz7y51nOICI2/RiVTFOSvySkn0WwFE4iJdy7HXxSG48pI
 HxBYg78BqFjno72LXuDN6iBipofxwj3f19DB3teJyzWLMcaIY3VPORWoaVbzZyNut6KT6abrF2x
 BtulfeX0OySJCPQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Add a new UFS capability flag indicating that the controller supports HW
wrapped keys and use it to determine which mechanism to use in UFS core.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 24 ++++++++++++++++--------
 include/ufs/ufshcd.h             |  5 +++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 33083e0cad6e..64389e876910 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -81,13 +81,15 @@ static int ufshcd_crypto_keyslot_program(struct blk_crypto_profile *profile,
 	cfg.crypto_cap_idx = cap_idx;
 	cfg.config_enable = UFS_CRYPTO_CONFIGURATION_ENABLE;
 
-	if (ccap_array[cap_idx].algorithm_id == UFS_CRYPTO_ALG_AES_XTS) {
-		/* In XTS mode, the blk_crypto_key's size is already doubled */
-		memcpy(cfg.crypto_key, key->raw, key->size/2);
-		memcpy(cfg.crypto_key + UFS_CRYPTO_KEY_MAX_SIZE/2,
-		       key->raw + key->size/2, key->size/2);
-	} else {
-		memcpy(cfg.crypto_key, key->raw, key->size);
+	if (key->crypto_cfg.key_type != BLK_CRYPTO_KEY_TYPE_HW_WRAPPED) {
+		if (ccap_array[cap_idx].algorithm_id == UFS_CRYPTO_ALG_AES_XTS) {
+			/* In XTS mode, the blk_crypto_key's size is already doubled */
+			memcpy(cfg.crypto_key, key->raw, key->size / 2);
+			memcpy(cfg.crypto_key + UFS_CRYPTO_KEY_MAX_SIZE / 2,
+			       key->raw + key->size / 2, key->size / 2);
+		} else {
+			memcpy(cfg.crypto_key, key->raw, key->size);
+		}
 	}
 
 	err = ufshcd_program_key(hba, key, &cfg, slot);
@@ -196,7 +198,13 @@ int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba)
 	hba->crypto_profile.ll_ops = ufshcd_crypto_ops;
 	/* UFS only supports 8 bytes for any DUN */
 	hba->crypto_profile.max_dun_bytes_supported = 8;
-	hba->crypto_profile.key_types_supported = BLK_CRYPTO_KEY_TYPE_STANDARD;
+	if (hba->caps & UFSHCD_CAP_WRAPPED_CRYPTO_KEYS)
+		hba->crypto_profile.key_types_supported =
+				BLK_CRYPTO_KEY_TYPE_HW_WRAPPED;
+	else
+		hba->crypto_profile.key_types_supported =
+				BLK_CRYPTO_KEY_TYPE_STANDARD;
+
 	hba->crypto_profile.dev = hba->dev;
 
 	/*
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 0beb010bb8da..a2dad4f982c2 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -763,6 +763,11 @@ enum ufshcd_caps {
 	 * WriteBooster when scaling the clock down.
 	 */
 	UFSHCD_CAP_WB_WITH_CLK_SCALING			= 1 << 12,
+
+	/*
+	 * UFS controller supports HW wrapped keys when using inline encryption.
+	 */
+	UFSHCD_CAP_WRAPPED_CRYPTO_KEYS			= 1 << 13,
 };
 
 struct ufs_hba_variant_params {

-- 
2.43.0


