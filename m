Return-Path: <linux-scsi+bounces-8017-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0230C96FAEC
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 20:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF89028AC5A
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6681EB25D;
	Fri,  6 Sep 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XHCgNQQI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875211D7E4F
	for <linux-scsi@vger.kernel.org>; Fri,  6 Sep 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646073; cv=none; b=KrtNKRWr1D5XzXY+FQfH7zaZhBmiYf5QPMLXSDJOyditV1umDgHFrcbPWfCikUVf40dccjdmHjP/oC+PRcsy9zS7srhAMFVJq+ljCYCtK54ZV6DzheEnr3EAFJMIWk58GwvihqgyqA5Ny9OjIEjIHq0h7g4FdJqH4WYQ+mdVPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646073; c=relaxed/simple;
	bh=OiTQs/o4iIOclq2/II8GFOi7yVE7fd4Ofbj0SHeNToU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3T7tVunflD+b1zHAAoj6/qbjZwS+FZlUAidW8TNiNOGulsj8MdgD5jrMF+H+fWS0LciN/QwbCPA9PD7H45Xg5cD+XjHDeSGlel1G2Z5XvPWv+n+ONcvVCdK2M46uAUy+ieaYeNfIcPbNjxAIXTkLzXWWqDFrXGPyeiebtRkYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XHCgNQQI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3770320574aso1286606f8f.2
        for <linux-scsi@vger.kernel.org>; Fri, 06 Sep 2024 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646067; x=1726250867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUF38RhJP/xWJ3nsoL8I4l8UYROpqB3e6odW9g8ieUo=;
        b=XHCgNQQIi64gnVEjNfcp+yl37cw0xskjhCczQGr1QdeWkYfJnMotAtezV5WS3qSpuH
         kAGPATgtBR+EIBrsYQppLi0v7dYwuJCUNo1g+tDC5D9lkKFTcG+o1B1WCwB/U0O7oPrS
         G2sJsGDMv57QrzI00uVlD/F/hTzvJo6fxd7qt5850/d41MLlDckihOxb6rAj8xmJcVAR
         o8tytnk9hj9BxzCOYXvHsOKZFuzWpNx2S/BleQ48DIWa91vXKbULqjhdzytFedGgJGyk
         bbpm7BkMGXLVWMop0zjC3lDaH2vPm83p6i+ZXUNeC3V/VjCQn080hvjaMk6zba3rhWb/
         7P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646067; x=1726250867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUF38RhJP/xWJ3nsoL8I4l8UYROpqB3e6odW9g8ieUo=;
        b=ud6OROMIcj8Qv1CT2m4KmLU9iw8t3ogrh7VWKu2LrUA2cZb/Grnh0bg3q6ek+2rwiM
         nZ9djo68btle25edw9WIBMR8p7FbJMzdMx2Kam+fJ4Dy9VHxtQcERxAJMnQGEfThxsn1
         qzyuHPaV9kBvBhTCSn4AKywGOflpQLglYGOOREfjljthyl1n0J1SwPEeD37D1jMnndVm
         LI8FN9GWT3jCYJejAAzrfrESCXcK/iodA4hN70eRcnQ9J2wGQ3rYZE/REu1ri/tsOgof
         Mn4ooQu2m/xxlbF8zX53DVzSSgVWo9qhgIyuCizblmLI1CuvtSKG3ZW07hdtUaeQTgb3
         RqUA==
X-Forwarded-Encrypted: i=1; AJvYcCWa/Z9i7ZT3iXL+yN4N68zB+WP0fHVev9N7SK7vnz/Pko4Wx+jECKQ11H1XOHqeHaOaGrBLqpGdxfNg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79FCKdbugLyddoL0l2dyPVe7rG4A52oxAxjKkSUanNpskRSxF
	Sd0AfkYuV78dLdmPE35e02ZyHNWAzVq7Ezdf7HZQElyiD9NcIJFMgthCiKiYEog=
X-Google-Smtp-Source: AGHT+IG36Xih85G9y6Nb2G00mKL7EauJKzGTn4BsvgwP+Z5ieQBsVHrZEkvhof1vQ3Rntfk5UrZTKw==
X-Received: by 2002:a05:6000:25c:b0:374:c10c:83b3 with SMTP id ffacd0b85a97d-3788969fcd7mr1651689f8f.54.1725646066564;
        Fri, 06 Sep 2024 11:07:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:16 +0200
Subject: [PATCH v6 13/17] ufs: core: add support for deriving the software
 secret
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-13-d59e61bc0cb4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+O4fdu9GZr4J7nzYrJhbrNMvxA5VEGSdndPo0S5CrQM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TZrb3SHTwnz2R7Nx9OI32Q36SvL7ZwpgbGD
 YFfJMdVbNqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2QAKCRARpy6gFHHX
 ci/dD/9vIw3Bysghw6DNsGzax+I8Q+JSgmwIExWkyla62bo+JWEAe99yQmscgZS5oWTQCA3IWtE
 VxO7rS3jTU1RCL42YIwVNviK8ZWYAR5IYhenr3R6V4cEjM93xBl1utGkIfWPNRFKKm9d6SR3nQT
 u+HC7Yzm3euXtBQiDvbxo6eH6J9ItprVKFJzp4nnfSmO1n+EWJ57THoTdhDLxjhRzoNIAasEfUS
 HDLfgOJTMU6je+t03Mc02YUkkWq7fzXpRy4oXUrYvMfro6gAxB/G38cN3ZlFH/pKuxfgKsgshM8
 nfEty/c98oY/K8IFcgK1XHEq3hCT6El93sN6v+xb0LcW4DbGPTIZQT1vnCtZGDXB9RsgLboRfoJ
 yBYdUB3vsXv/ZaJYWR6qoomYLfx2ERvH5zmeOqBrr1UKKL2ex3rYKHShos53Y8UaezCUcdSTcAy
 g/WT8uxgDTzwol0cDSNw/diMeL1OHmdVWvk3le6njkLekem243syTH0gDd/Sb7tzCWBD0NPjEfI
 OhW3QdsgPJqXjBAQTl2zgxRJB2Bv099uzeNKiEt0Tz2WBJeVcoC18r3EMx069dbFJaUb54rc+tE
 2nvXxTTTe/BNrdWmlTx9ai1N/TrQHl/eA3ryyCZDCrePus1cG7foS0lOMUdZ6q2x7tx7Bkf/uND
 8JGKyOl6Zaif/NA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Extend the UFS core to allow calling the block layer's callback for
deriving the software secret from a wrapped key. This is needed as in
most cases the wrapped key support will be vendor-specific and the
implementation will live in the specific UFS driver.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/core/ufshcd-crypto.c | 15 +++++++++++++++
 include/ufs/ufshcd.h             |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
index 64389e876910..2530239d42af 100644
--- a/drivers/ufs/core/ufshcd-crypto.c
+++ b/drivers/ufs/core/ufshcd-crypto.c
@@ -113,6 +113,20 @@ static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
 	return ufshcd_program_key(hba, NULL, &cfg, slot);
 }
 
+static int ufshcd_crypto_derive_sw_secret(struct blk_crypto_profile *profile,
+					  const u8 wkey[], size_t wkey_size,
+					  u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
+{
+	struct ufs_hba *hba =
+		container_of(profile, struct ufs_hba, crypto_profile);
+
+	if (hba->vops && hba->vops->derive_sw_secret)
+		return hba->vops->derive_sw_secret(hba, wkey, wkey_size,
+						   sw_secret);
+
+	return -EOPNOTSUPP;
+}
+
 /*
  * Reprogram the keyslots if needed, and return true if CRYPTO_GENERAL_ENABLE
  * should be used in the host controller initialization sequence.
@@ -134,6 +148,7 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
 static const struct blk_crypto_ll_ops ufshcd_crypto_ops = {
 	.keyslot_program	= ufshcd_crypto_keyslot_program,
 	.keyslot_evict		= ufshcd_crypto_keyslot_evict,
+	.derive_sw_secret	= ufshcd_crypto_derive_sw_secret,
 };
 
 static enum blk_crypto_mode_num
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index a2dad4f982c2..c11dd3baf53c 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -372,6 +372,9 @@ struct ufs_hba_variant_ops {
 	int	(*program_key)(struct ufs_hba *hba,
 			       const struct blk_crypto_key *bkey,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
+	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
+				    unsigned int wkey_size,
+				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,
 				    void *prdt, unsigned int num_segments);

-- 
2.43.0


