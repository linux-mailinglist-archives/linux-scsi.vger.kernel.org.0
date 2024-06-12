Return-Path: <linux-scsi+bounces-5630-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09377904709
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2024 00:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50C1284C65
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Jun 2024 22:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CE155A53;
	Tue, 11 Jun 2024 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgMRtB6S"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB863155A46;
	Tue, 11 Jun 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145342; cv=none; b=f7+u0NsOMvpU90JfVNxxZQ7vx5lLyqYvtSpX3Xv/LKkMdHnVBs+Icti93haR9fVIvDQvxsmlPDovqHGzKBeuDE4PKc1Onic5rcpMicS2dEKw1bjzGxWkWgo95dvvfJrKq/gdBWSjnMSVrdn0VHuWYnIM0AP/H0uBVRHKdnbbqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145342; c=relaxed/simple;
	bh=u0jYwdKW3UnVrdgG/w93hhY2HIs0pseo3u1lMTfTwls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5iXUzfVv7HqLpowWIVJ928tMEjhvaq5VgkhtzehSOYGW8+YDzyI28YBBc1ED3oKY/HioC1Aw+nDkU9QpQlIwI0jvNrpkJ1MKlEwhfSo67rA3KZEW5txvydkkUJJXt1hzh9Mpl5u7Wi9im0F2oSy4FLc4WRkGXd0AzrLsoVDOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgMRtB6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C887C2BD10;
	Tue, 11 Jun 2024 22:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718145341;
	bh=u0jYwdKW3UnVrdgG/w93hhY2HIs0pseo3u1lMTfTwls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgMRtB6SsZOOAlt2/G4BArfiJF+0XyYqrSc4S6J3U1mQpfdPdldpsaKL75l4mj8IA
	 b+G1SQwFb9LiTJzeheS2c0BJT0BEE5i49hQxAhtt414QOT40NgRTGOHBu5jePPadmW
	 ggREBbtTLGFKBKjG8RQYkfpwSmaePJQ5N4VXMW96fKDFqNpccIKNDz/fbMvl7bUy8I
	 gnWrcUxxM3sVdhLgK6jh4mjS+VJTEFiQNq5PE/SlTWh9voj4PqFq7XsRceLLB59xv+
	 jSs/3hTfifB3CDvOPGK8TWvM/e5W4leCFvqykT6+D83SXWlQfGpCMYWoGCNKk5gkI+
	 wGQNsQem4MpWA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-scsi@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	William McVicker <willmcvicker@google.com>
Subject: [PATCH 4/6] scsi: ufs: core: Add fill_crypto_prdt variant op
Date: Tue, 11 Jun 2024 15:34:17 -0700
Message-ID: <20240611223419.239466-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611223419.239466-1-ebiggers@kernel.org>
References: <20240611223419.239466-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Add a variant op to allow host drivers to initialize nonstandard
crypto-related fields in the PRDT.  This is needed to support inline
encryption on the "Exynos" UFS controller.

Note that this will be used together with the support for overriding the
PRDT entry size that was already added by commit ada1e653a5ea ("scsi:
ufs: core: Allow UFS host drivers to override the sg entry size").

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/ufs/core/ufshcd-crypto.h | 19 +++++++++++++++++++
 drivers/ufs/core/ufshcd.c        |  2 +-
 include/ufs/ufshcd.h             |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd-crypto.h b/drivers/ufs/core/ufshcd-crypto.h
index be8596f20ba2..3eb8df42e194 100644
--- a/drivers/ufs/core/ufshcd-crypto.h
+++ b/drivers/ufs/core/ufshcd-crypto.h
@@ -35,10 +35,23 @@ ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb *lrbp,
 	h->cci = lrbp->crypto_key_slot;
 	h->dunl = cpu_to_le32(lower_32_bits(lrbp->data_unit_num));
 	h->dunu = cpu_to_le32(upper_32_bits(lrbp->data_unit_num));
 }
 
+static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
+					  struct ufshcd_lrb *lrbp)
+{
+	struct scsi_cmnd *cmd = lrbp->cmd;
+	const struct bio_crypt_ctx *crypt_ctx = scsi_cmd_to_rq(cmd)->crypt_ctx;
+
+	if (crypt_ctx && hba->vops && hba->vops->fill_crypto_prdt)
+		return hba->vops->fill_crypto_prdt(hba, crypt_ctx,
+						   lrbp->ucd_prdt_ptr,
+						   scsi_sg_count(cmd));
+	return 0;
+}
+
 bool ufshcd_crypto_enable(struct ufs_hba *hba);
 
 int ufshcd_hba_init_crypto_capabilities(struct ufs_hba *hba);
 
 void ufshcd_init_crypto(struct ufs_hba *hba);
@@ -52,10 +65,16 @@ static inline void ufshcd_prepare_lrbp_crypto(struct request *rq,
 
 static inline void
 ufshcd_prepare_req_desc_hdr_crypto(struct ufshcd_lrb *lrbp,
 				   struct request_desc_header *h) { }
 
+static inline int ufshcd_crypto_fill_prdt(struct ufs_hba *hba,
+					  struct ufshcd_lrb *lrbp)
+{
+	return 0;
+}
+
 static inline bool ufshcd_crypto_enable(struct ufs_hba *hba)
 {
 	return false;
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 0cf07194bbe8..e8a044149562 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2634,11 +2634,11 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	if (sg_segments < 0)
 		return sg_segments;
 
 	ufshcd_sgl_to_prdt(hba, lrbp, sg_segments, scsi_sglist(cmd));
 
-	return 0;
+	return ufshcd_crypto_fill_prdt(hba, lrbp);
 }
 
 /**
  * ufshcd_enable_intr - enable interrupts
  * @hba: per adapter instance
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 4b7ad23a4420..59aa6c831a41 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -319,10 +319,11 @@ struct ufs_pwr_mode_info {
  * @dbg_register_dump: used to dump controller debug information
  * @phy_initialization: used to initialize phys
  * @device_reset: called to issue a reset pulse on the UFS device
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
+ * @fill_crypto_prdt: initialize crypto-related fields in the PRDT
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
  * @mcq_config_resource: called to configure MCQ platform resources
  * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
  * @op_runtime_config: called to config Operation and runtime regs Pointers
@@ -363,10 +364,13 @@ struct ufs_hba_variant_ops {
 	void	(*config_scaling_param)(struct ufs_hba *hba,
 				struct devfreq_dev_profile *profile,
 				struct devfreq_simple_ondemand_data *data);
 	int	(*program_key)(struct ufs_hba *hba,
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
+	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
+				    const struct bio_crypt_ctx *crypt_ctx,
+				    void *prdt, unsigned int num_segments);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
 	void	(*reinit_notify)(struct ufs_hba *);
 	int	(*mcq_config_resource)(struct ufs_hba *hba);
 	int	(*get_hba_mac)(struct ufs_hba *hba);
-- 
2.45.2


