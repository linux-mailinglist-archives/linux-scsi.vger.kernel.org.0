Return-Path: <linux-scsi+bounces-8018-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283F96FAF8
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02D328B17C
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB521EB95D;
	Fri,  6 Sep 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1YndgZ7S"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB831EAB83
	for <linux-scsi@vger.kernel.org>; Fri,  6 Sep 2024 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646076; cv=none; b=dmrPlwzHKeU4G1ynW3OGE2UquD4bg5WZ2Pta1uFvBODl9Mnwm3l5k6F0qDQ6Y1Msy/tAX9DQB1jzrwiraY4HA+5lqfkaKPLQ2rMQZZxhADs9SpFo8P5vlqo/mstyCMjdP6oF/fNtH70ArJ7t+AykaKV8QuQ6vIn+cIY7phUCh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646076; c=relaxed/simple;
	bh=rCoqdQ9B7Hn8xdsgALiUMx6hOr/x0MpVdqxz3Ze2hQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1bn1tPRuloTKBdLlsVhEia4HbEA4hIC2yzb2Oq8uJKuXtUojyixFWaMEGJEqLoqwD24hIl46Sdt39n98nYn8gVJ4dcQIZd/Et7B7QMAMid8hMgKYXrQ20M47ZVN7+MdcwbeTa0nKo2jlJG5auy5TyAfO2Xg+anZ6NON5Rs0ilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1YndgZ7S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbc70caa4so18392265e9.0
        for <linux-scsi@vger.kernel.org>; Fri, 06 Sep 2024 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646068; x=1726250868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhatKWKJuxfltx1oNZ6oUaNqgboH9F2TpuTRwRw3JfI=;
        b=1YndgZ7S3cnVvgP/jgQePXDZGAVREbDi/c7FyUCYi+qU9TS0IUt80vR34PYvZ1AYJF
         Qjh15LcoBJbnfcs5S9PVyi3Kt1V2xO40B2whVyIUAacbhcjXRcMNN46bAvChYusiJUo5
         CSW2BE1ZVsQ/wXWxHS6tV3N1TNbMLq25/iAfd8kZPFBkz8QzsyuHcSNkAaxWdPCKgV++
         PX1BqAU8+RjDEuAXWzT96my6oPdme5K814SMLHcF4cuNsCK9aIht8vARbbAaXZ+QV4mp
         ihRfKtlcUHtBLbytW54UJdzaublUhiMhmwATXyqhqVQ8svfc7rwLJR/Qqng/8nsHUmkL
         G2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646068; x=1726250868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhatKWKJuxfltx1oNZ6oUaNqgboH9F2TpuTRwRw3JfI=;
        b=VYtJsO6bGc+tv7dex6roF3ud+XsOasH7YgEmvFBNlHw4kt05BWRyG1Vh/wcEJ+po4R
         mO9pp9iIiyvtHLJOTyvydyNDwaF5GXXVeYXXOb0ccc3QAHMJAp3TOt3g3ezUbm4lN8BI
         LHB1PjDktwTWjAiytkM+Gioru6jh2CH2FU9kVpUG+O9vSgH/PL2cZM86kZ5jkuqiBifa
         4LqYv5B6FkT3aZJsNLh9UgpuOM4QrGdk+5o5LOx/yaASDS6Rzp1VCLwKsIE5u7qC86uW
         +5C8a/I6k9K8dBlFirYeEDahQIaVJmIOeTAFfjG2AoKyxu7/r2Ppz47dJqGEjnFMYvEZ
         UrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFF+78SA1R2vKg8awfjY84ETuZJWwvyGAnhqUk+6htfQC07E8TdtB1GlGVyxIpO5rQ7ApFIibAuf+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Y4XmfhE1QiPyRADGbJ4jhEtPBVYV3HBiyPJS5Jmggav2KXze
	59+wJou9nnEBIsLqlqjdLSzWAF8h6tsN+FTVL0NKKMGziyuTRg31hFB2nU9glzM=
X-Google-Smtp-Source: AGHT+IFOg0pepQs+VdsYBIWsjbQQjXUJeI6KG/cFUzINm+1c+XVO6jt8d37cZGTYUA+GQauE9dhMBA==
X-Received: by 2002:a5d:4687:0:b0:374:c2e9:28bc with SMTP id ffacd0b85a97d-378895cb7admr2551376f8f.21.1725646068090;
        Fri, 06 Sep 2024 11:07:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:17 +0200
Subject: [PATCH v6 14/17] ufs: core: add support for generating, importing
 and preparing keys
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-14-d59e61bc0cb4@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+ALSGPhqSpFCx8VMqBEOHa6jvoZdtMRVH6U+tA0zR4E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TZHG7mGdP2yFeDCgoTznf05+6dq0aY36CmD
 ovuEoC17GGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2QAKCRARpy6gFHHX
 cvO+EACvuksLWfnKBrpniQe6Iv46e+yJoHo4yghwKDIwAlpdFhXkGYmt3z+Gp7mfW0cxBUxfka9
 rbbHdcBUVhp0aToj3CBkm2cy7u1llGhn81wyzAAnD15+roJfk7DF/aVr/g5cD/9/VYeFDIbfOv+
 DRx+YXZ35DpsSrmRTc78cbOrGqnmDrfhvuMS4K2fvH1UmSr64s7ZLu5mp6HEBi3L71dla+m43bV
 VuaJYK8DX7rpHG7oKOa/fjD/DLlP04HbHg/QvuVQohrSPRFYsX6mtar7jpPB37vWz7VW7BGCEab
 drRBSAcK/iGAXD5hCj02WE9aZmm8yUQSVGzAaY0TcvHkmv4J9xNCvgjy6XvFvZDAaJdnegxMQ+F
 VyIfdTDqkCWAusDHI8eEJ4HWTVlj4jYiItMj5bDIqYiTTJ5pqjK7JMAw2I7Y2Ej9GtvGOx9M5gn
 tLhLOxDydraJ86bvBW4Qq9rZuOQBdkZIFHUdi/EPIXZhYQuaWQBmwzBrfgCPEKe1WTAQbZDnI/L
 uyWHZaubRrkuTJ91tvyPm5nzOwjl63ZmqvKG68cdMAts44qlQCptRNkt+qqozMqPNUyl+7eqr3v
 4J3pEiueN/55h6WuFK53jEUlbIIMSVxr4/xNMIUKVsTB0n45VAb4nd+FGuIASPsWqBrtg2AVKs3
 nnleYxvy0CG/O4g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

The block layer now allows storage controllers to implement the
operations for handling wrapped keys. We can now extend the UFS core to
also support them by reaching into the block layer. Add hooks
corresponding with the existing crypto operations lower on the stack.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 2530239d42af..49c0784f2432 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -145,10 +145,51 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 	return true;
 }
 
+static int ufshcd_crypto_generate_key(struct blk_crypto_profile *profile,
+				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->generate_key)
+		return hba->vops->generate_key(hba, lt_key);
+
+	return -EOPNOTSUPP;
+}
+
+static int ufshcd_crypto_prepare_key(struct blk_crypto_profile *profile,
+				     const u8 *lt_key, size_t lt_key_size,
+				     u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->prepare_key)
+		return hba->vops->prepare_key(hba, lt_key, lt_key_size, eph_key);
+
+	return -EOPNOTSUPP;
+}
+
+static int ufshcd_crypto_import_key(struct blk_crypto_profile *profile,
+				    const u8 *imp_key, size_t imp_key_size,
+				    u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->import_key)
+		return hba->vops->import_key(hba, imp_key, imp_key_size, lt_key);
+
+	return -EOPNOTSUPP;
+}
+
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
 	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
+	.generate_key		= ufshcd_crypto_generate_key,
+	.prepare_key		= ufshcd_crypto_prepare_key,
+	.import_key		= ufshcd_crypto_import_key,
 };
 
 static enum blk_crypto_mode_num

-- 
2.43.0


