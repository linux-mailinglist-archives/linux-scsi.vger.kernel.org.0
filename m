Return-Path: <linux-scsi+bounces-8021-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A349396FB16
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13771C25550
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2024 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7283DAC08;
	Fri,  6 Sep 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iKGxZmgn"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367971EB256
	for <linux-scsi@vger.kernel.org>; Fri,  6 Sep 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646080; cv=none; b=gFiVvr1IZfknitUJo/+NlqpGYma63j1WMAx4lr4/iuVPvPFwyEcinCoLdmbfelo6ten0Z8VlcfUo5ysc33KC+RuCHlea0LzQMsSxP2WOyFcJjEBaaoblx5NNwh5ErFHpcuCes5tJRBacGUOlIkP/QIzsgZ3eNldMTl9CE6fiTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646080; c=relaxed/simple;
	bh=yN3UyiSFYgnUZ7NwiyFNFYXW8dahCqci8HzGdQLvfDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkIguPqjiwOmIYf6xQaxTignglO5G9hQe+YTQ6IgUS39AEptyx45wO4/E8O7DFRPBRvReAACE/Blejz/QxYlvWtg2bT+z6vQ8Sv9CqKYojDWNiNTKjcSxF42w+RqLrnS49C/Kd0jzHPD90Lud0rGEJ7PNvsT2ppW2SEZztYO23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iKGxZmgn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so1742406f8f.0
        for <linux-scsi@vger.kernel.org>; Fri, 06 Sep 2024 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646073; x=1726250873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0F4M8TV9wbFiPgmY2At1z2Y50uIr5nXzL3lGpc2+c2g=;
        b=iKGxZmgnr+Y4UG5MbVP0wL9J4HlbC6XQz1N0T2yut3bRpi5hFv219/BTISvk2AYXQx
         vxoNxxjUcVcTWD+wQAPVgOQlirriUcIkbIf/lWQj/aPV85L/Oix58ZwbGL7Euk3x3IRY
         bMszi5obo0REIqJli38Tu92a7EJlVfO7Y5QTsvmy8p4s0re1WFM0aKk4QhBmeVQ1DMxX
         mZ29HqFuuoEpqe7aTwRT02zUW6PA2KnoXzWq+p5OvkFTLfTSoNvvigcsziX6nbyJYyZj
         ATKGMLWjpQXYVe7OhG9c+WuBscbF4AjezNgCPHtxirDc50AGHBOIDhnI6RxK4Z41tenh
         Kmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646073; x=1726250873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0F4M8TV9wbFiPgmY2At1z2Y50uIr5nXzL3lGpc2+c2g=;
        b=iX37aG8lyyNyy2CyxNjGgXVmVIe64tcOd6Gx4DZTUAHsMZ1DSwQ2erNT/iBRjBpCNu
         RB7dF0hfeXd2TC8AE4xqmwNQyFnK7t8YYbnZLCpjaqZ86x1WNni3Le7rTWQtFrzZkoUV
         MdRUQKWwiZlNdWI+GAd9sNy9/eBA6D26fUd0V+3NhJlvSbB7vHNxFlHUsjWIcQPdZjOK
         M0QjXHCOLpCjgHNVHsdbLnqgM8pREDjs2QW73KRbc1i1oJ9W4ZuqstRMheV++y/kqd6/
         KHXec+LX0yuy4jYQl+EXCdLYWPwAt/ofLr8x8nKCtUpwOGD5/zp/8qUfUf25m7ykepAX
         bbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4QJxSJuhjjdowqnfF0bz+D0LuWloOMcsT22mUJocUyaKLG/WnHdENC7jB63Cp2MIWUJfQrgDnc4o1@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzWtEKxmo+pppBH7sRmCrMEd+emj+Nq3BmmgLlVxSS4xub4mw
	R5BQ7b3mdM3Ph50fsb6wA9Ft6H4z6vjIXiBsqfOt4yIgytfqNkuV7KZuI9LtT2I=
X-Google-Smtp-Source: AGHT+IFzLgUC8XDV/1hmeSArnp6cG4xAw+z/Gpqq5CLLSznnGIQotYfc6wYotVA2fo3sOEb29ZstZQ==
X-Received: by 2002:a5d:5cc5:0:b0:374:bcdc:6257 with SMTP id ffacd0b85a97d-37892466eecmr69710f8f.54.1725646073049;
        Fri, 06 Sep 2024 11:07:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:20 +0200
Subject: [PATCH v6 17/17] ufs: host: add support for generating, importing
 and preparing wrapped keys
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-17-d59e61bc0cb4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4227;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=lAz64p9mYL3e8mxedYIAwwas8wL0VPUBWm79cF7quNM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TbMJe/MV01X+lyorGFEGKGia63YS2Jy7eb9
 ezOsWi8dIqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2wAKCRARpy6gFHHX
 cniYD/9kh0S4qtv/43wWiE+pb51WOIqUAF2VV1lMlkcDal89KQicHRAFEysMOaGZV3IB9LJovkl
 zun/fHymbSr6EW7nt/jveOpN9bUjsDt+Nf/CTzIn9ETQnIl+LuY02w8BPJVT9GS4A+qNKLM7U8e
 IQOKp8W8CN+q0MaibQB62vkLR69gkgft5gS84yPkhtl/0BIB8te0E67jWGOZbn/lTHGTClWb49W
 ZLswNjG7DMpuMvK642zxWIfo4PCj1Vmqyfl/1/Fi5hIIRXtyTuCAwhW8gbagPDkdY1tWZlpEN7M
 iEqOYZfZjZ7tNCNIG961mMTlUtfeG2arec4VjAZvSAh5FqFrYfQu6tV998bSnlCenTwefnhNu0R
 g/qk/vll1+34iVAKSHy4woo/18eiQAu1/9XkS1pm/wlVUCq5Yx3jIFXaMoRDYRGDR1z0PqoWSOj
 kI+exVmGTR/dFwuDqs0fuofn3Sy3RsV4Ls1kYWpOFPltnH4nfDQvRi13r6GaxWEAXfY9n+MG3wN
 IHoBp/LJmtrgm/cr6+Qyy7JRd6QmDM3b6GGfzUfakN5WLoY+xpGRXINAUuteZH7uknccu7EDPEb
 Z4x8mNDldMcoZ9ldM3R+omc4LduppLdJ5ppa9mD4k13l3mh4sWVpV1Iq9lncHmvIjGSj0Fu5BRU
 9wAF+McJ/TiP3xw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Extend the UFS core ops to include callbacks for generating, importing
and prepating HW wrapped keys using the lower-level block crypto
operations and implement them for QCom UFS.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 34 ++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h        | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 77fb5e66e4be..fd8952473f4b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -195,10 +195,41 @@ static int ufs_qcom_ice_derive_sw_secret(struct ufs_hba *hba, const u8 wkey[],
 	return qcom_ice_derive_sw_secret(host->ice, wkey, wkey_size, sw_secret);
 }
 
+static int ufs_qcom_ice_generate_key(struct ufs_hba *hba,
+				     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_generate_key(host->ice, lt_key);
+}
+
+static int ufs_qcom_ice_prepare_key(struct ufs_hba *hba,
+				    const u8 *lt_key, size_t lt_key_size,
+				    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size,
+				    eph_key);
+}
+
+static int ufs_qcom_ice_import_key(struct ufs_hba *hba,
+				   const u8 *imp_key, size_t imp_key_size,
+				   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_import_key(host->ice, imp_key, imp_key_size,
+				   lt_key);
+}
+
 #else
 
 #define ufs_qcom_ice_program_key NULL
 #define ufs_qcom_ice_derive_sw_secret NULL
+#define ufs_qcom_ice_generate_key NULL
+#define ufs_qcom_ice_prepare_key NULL
+#define ufs_qcom_ice_import_key NULL
 
 static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
@@ -1830,6 +1861,9 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
 	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
+	.generate_key		= ufs_qcom_ice_generate_key,
+	.prepare_key		= ufs_qcom_ice_prepare_key,
+	.import_key		= ufs_qcom_ice_import_key,
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index b8b1763df022..a94b3d872bcc 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -324,6 +324,9 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @derive_sw_secret: derive sw secret from a wrapped key
+ * @generate_key: generate a storage key and return longterm wrapped key
+ * @prepare_key: unwrap longterm key and return ephemeral wrapped key
+ * @import_key: import sw storage key and return longterm wrapped key
  * @fill_crypto_prdt: initialize crypto-related fields in the PRDT
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
@@ -376,6 +379,14 @@ struct ufs_hba_variant_ops {
 	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
 				    unsigned int wkey_size,
 				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+	int	(*generate_key)(struct ufs_hba *hba,
+				u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+	int	(*prepare_key)(struct ufs_hba *hba,
+			       const u8 *lt_key, size_t lt_key_size,
+			       u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+	int	(*import_key)(struct ufs_hba *hba,
+			      const u8 *imp_key, size_t imp_key_size,
+			      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,
 				    void *prdt, unsigned int num_segments);

-- 
2.43.0


