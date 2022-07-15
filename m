Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207BC5768DE
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Jul 2022 23:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiGOV0i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Jul 2022 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiGOV0h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 15 Jul 2022 17:26:37 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783A73907
        for <linux-scsi@vger.kernel.org>; Fri, 15 Jul 2022 14:26:36 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id f11so4209004plr.4
        for <linux-scsi@vger.kernel.org>; Fri, 15 Jul 2022 14:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hnEAIOfNMe9QKXEO8DOyKlMaoYb/EBm2NNxA3j6CL1M=;
        b=BBb2zLR5SPbkw/e6GlMnZ9Ee6jUTEJA7skJfKddGP7PkY5Zyn0jXqre/EgCfLzyKST
         8fZUxSFa/4y/NbK2j8IuU+F6Ida/8g2O3oqPSzgzFXVqX3WAeEOhInRvQ6G/0RxbNnhz
         mA2CmRJe8qaKU3k0QVEi7RADv+bI3jZiAcJbhafZaJAG/GVkwciCnnWmiopmGWpBRjym
         ENZg1CSJGOKmnuBUT1Pkoy2WX201fhpS9wT/xrbyplJqWGJm99633Lnm2/NLkvniFHNU
         HfRr0YOLQrNTGBxk5GIE5x4IPhCJKMFghz8PJ6mC8KtHfkPmaulG0rNaWEzy5quBN4sr
         6g9w==
X-Gm-Message-State: AJIora/IFUU+4zF5fRl4D0lILuiOiNlFt+1LYV/N4rWm91XMpSUP4HW5
        ZhS9NoFOmTF9ne5+qYKgF6U=
X-Google-Smtp-Source: AGRyM1u7GcwmrcUdDLhsoorYU2O1nOrX1nh8yOcfXOXBUNW6bW5UgeoYJSyBjQMhP+Ctp2ATSWrZgQ==
X-Received: by 2002:a17:90b:88d:b0:1ef:9182:104a with SMTP id bj13-20020a17090b088d00b001ef9182104amr25154834pjb.74.1657920395745;
        Fri, 15 Jul 2022 14:26:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:276e:f777:f438:e01d])
        by smtp.gmail.com with ESMTPSA id e35-20020a630f23000000b0040c40b022fbsm3535944pgl.94.2022.07.15.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 14:26:35 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-scsi@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v2 5/5] scsi: ufs: Allow UFS host drivers to override the sg entry size
Date:   Fri, 15 Jul 2022 14:25:15 -0700
Message-Id: <20220715212515.347664-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220715212515.347664-1-bvanassche@acm.org>
References: <20220715212515.347664-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Modify the UFSHCD core to allow 'struct ufshcd_sg_entry' to be
variable-length. The default is the standard length, but variants can
override ufs_hba::sg_entry_size with a larger value if there are
vendor-specific fields following the standard ones.

This is needed to support inline encryption with ufs-exynos (FMP).

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
[ bvanassche: edited commit message and introduced CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 39 ++++++++++++++++++---------------------
 drivers/ufs/host/Kconfig  | 10 ++++++++++
 include/ufs/ufshcd.h      | 32 ++++++++++++++++++++++++++++++++
 include/ufs/ufshci.h      |  9 +++++++--
 4 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8363d2ff622c..8894d66413e1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -523,7 +523,7 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 		prdt_length = le16_to_cpu(
 			lrbp->utr_descriptor_ptr->prd_table_length);
 		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
-			prdt_length /= sizeof(struct ufshcd_sg_entry);
+			prdt_length /= ufshcd_sg_entry_size(hba);
 
 		dev_err(hba->dev,
 			"UPIU[%d] - PRDT - %d entries  phys@0x%llx\n",
@@ -532,7 +532,7 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 
 		if (pr_prdt)
 			ufshcd_hex_dump("UPIU PRDT: ", lrbp->ucd_prdt_ptr,
-				sizeof(struct ufshcd_sg_entry) * prdt_length);
+				ufshcd_sg_entry_size(hba) * prdt_length);
 	}
 }
 
@@ -2437,7 +2437,7 @@ int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
  */
 static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 {
-	struct ufshcd_sg_entry *prd_table;
+	struct ufshcd_sg_entry *prd;
 	struct scatterlist *sg;
 	struct scsi_cmnd *cmd;
 	int sg_segments;
@@ -2452,13 +2452,12 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 
 		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
 			lrbp->utr_descriptor_ptr->prd_table_length =
-				cpu_to_le16((sg_segments *
-					sizeof(struct ufshcd_sg_entry)));
+				cpu_to_le16(sg_segments * ufshcd_sg_entry_size(hba));
 		else
 			lrbp->utr_descriptor_ptr->prd_table_length =
 				cpu_to_le16(sg_segments);
 
-		prd_table = lrbp->ucd_prdt_ptr;
+		prd = lrbp->ucd_prdt_ptr;
 
 		scsi_for_each_sg(cmd, sg, sg_segments, i) {
 			const unsigned int len = sg_dma_len(sg);
@@ -2472,9 +2471,10 @@ static int ufshcd_map_sg(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 			 * indicates 4 bytes, '7' indicates 8 bytes, etc."
 			 */
 			WARN_ONCE(len > 256 * 1024, "len = %#x\n", len);
-			prd_table[i].size = cpu_to_le32(len - 1);
-			prd_table[i].addr = cpu_to_le64(sg->dma_address);
-			prd_table[i].reserved = 0;
+			prd->size = cpu_to_le32(len - 1);
+			prd->addr = cpu_to_le64(sg->dma_address);
+			prd->reserved = 0;
+			prd = (void *)prd + ufshcd_sg_entry_size(hba);
 		}
 	} else {
 		lrbp->utr_descriptor_ptr->prd_table_length = 0;
@@ -2767,10 +2767,11 @@ static int ufshcd_map_queues(struct Scsi_Host *shost)
 
 static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
 {
-	struct utp_transfer_cmd_desc *cmd_descp = hba->ucdl_base_addr;
+	struct utp_transfer_cmd_desc *cmd_descp = (void *)hba->ucdl_base_addr +
+		i * sizeof_utp_transfer_cmd_desc(hba);
 	struct utp_transfer_req_desc *utrdlp = hba->utrdl_base_addr;
 	dma_addr_t cmd_desc_element_addr = hba->ucdl_dma_addr +
-		i * sizeof(struct utp_transfer_cmd_desc);
+		i * sizeof_utp_transfer_cmd_desc(hba);
 	u16 response_offset = offsetof(struct utp_transfer_cmd_desc,
 				       response_upiu);
 	u16 prdt_offset = offsetof(struct utp_transfer_cmd_desc, prd_table);
@@ -2778,11 +2779,11 @@ static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
 	lrb->utr_descriptor_ptr = utrdlp + i;
 	lrb->utrd_dma_addr = hba->utrdl_dma_addr +
 		i * sizeof(struct utp_transfer_req_desc);
-	lrb->ucd_req_ptr = (struct utp_upiu_req *)(cmd_descp + i);
+	lrb->ucd_req_ptr = (struct utp_upiu_req *)cmd_descp;
 	lrb->ucd_req_dma_addr = cmd_desc_element_addr;
-	lrb->ucd_rsp_ptr = (struct utp_upiu_rsp *)cmd_descp[i].response_upiu;
+	lrb->ucd_rsp_ptr = (struct utp_upiu_rsp *)cmd_descp->response_upiu;
 	lrb->ucd_rsp_dma_addr = cmd_desc_element_addr + response_offset;
-	lrb->ucd_prdt_ptr = cmd_descp[i].prd_table;
+	lrb->ucd_prdt_ptr = (struct ufshcd_sg_entry *)cmd_descp->prd_table;
 	lrb->ucd_prdt_dma_addr = cmd_desc_element_addr + prdt_offset;
 }
 
@@ -3669,7 +3670,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	size_t utmrdl_size, utrdl_size, ucdl_size;
 
 	/* Allocate memory for UTP command descriptors */
-	ucdl_size = (sizeof(struct utp_transfer_cmd_desc) * hba->nutrs);
+	ucdl_size = sizeof_utp_transfer_cmd_desc(hba) * hba->nutrs;
 	hba->ucdl_base_addr = dmam_alloc_coherent(hba->dev,
 						  ucdl_size,
 						  &hba->ucdl_dma_addr,
@@ -3763,7 +3764,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
 	prdt_offset =
 		offsetof(struct utp_transfer_cmd_desc, prd_table);
 
-	cmd_desc_size = sizeof(struct utp_transfer_cmd_desc);
+	cmd_desc_size = sizeof_utp_transfer_cmd_desc(hba);
 	cmd_desc_dma_addr = hba->ucdl_dma_addr;
 
 	for (i = 0; i < hba->nutrs; i++) {
@@ -9601,6 +9602,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 	hba->dev = dev;
 	hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
 	hba->nop_out_timeout = NOP_OUT_TIMEOUT;
+	ufshcd_set_sg_entry_size(hba, sizeof(struct ufshcd_sg_entry));
 	INIT_LIST_HEAD(&hba->clk_list_head);
 	spin_lock_init(&hba->outstanding_lock);
 
@@ -9979,11 +9981,6 @@ static int __init ufshcd_core_init(void)
 {
 	int ret;
 
-	/* Verify that there are no gaps in struct utp_transfer_cmd_desc. */
-	static_assert(sizeof(struct utp_transfer_cmd_desc) ==
-		      2 * ALIGNED_UPIU_SIZE +
-			      SG_ALL * sizeof(struct ufshcd_sg_entry));
-
 	ufs_debugfs_init();
 
 	ret = scsi_register_driver(&ufs_dev_wlun_template.gendrv);
diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 4cc2dbd79ed0..49017abdac92 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -124,3 +124,13 @@ config SCSI_UFS_EXYNOS
 
 	  Select this if you have UFS host controller on Samsung Exynos SoC.
 	  If unsure, say N.
+
+config SCSI_UFS_VARIABLE_SG_ENTRY_SIZE
+	bool "Variable size UTP physical region descriptor"
+	help
+	  In the UFSHCI 3.0 standard the Physical Region Descriptor (PRD) is a
+	  data structure used for transferring data between host and UFS
+	  device. This data structure describes a single region in physical
+	  memory. Although the standard requires that this data structure has a
+	  size of 16 bytes, for some controllers this data structure has a
+	  different size. Enable this option for UFS controllers that need it.
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 6d78bcbedb9e..a1d0dab9a01e 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -744,6 +744,9 @@ struct ufs_hba_monitor {
  * @vops: pointer to variant specific operations
  * @vps: pointer to variant specific parameters
  * @priv: pointer to variant specific private data
+#ifdef CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE
+ * @sg_entry_size: size of struct ufshcd_sg_entry (may include variant fields)
+#endif
  * @irq: Irq number of the controller
  * @is_irq_enabled: whether or not the UFS controller interrupt is enabled.
  * @dev_ref_clk_freq: reference clock frequency
@@ -865,6 +868,9 @@ struct ufs_hba {
 	const struct ufs_hba_variant_ops *vops;
 	struct ufs_hba_variant_params *vps;
 	void *priv;
+#ifdef CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE
+	size_t sg_entry_size;
+#endif
 	unsigned int irq;
 	bool is_irq_enabled;
 	enum ufs_ref_clk_freq dev_ref_clk_freq;
@@ -967,6 +973,32 @@ struct ufs_hba {
 	bool complete_put;
 };
 
+#ifdef CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE
+static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
+{
+	return hba->sg_entry_size;
+}
+
+static inline void ufshcd_set_sg_entry_size(struct ufs_hba *hba, size_t sg_entry_size)
+{
+	WARN_ON_ONCE(sg_entry_size < sizeof(struct ufshcd_sg_entry));
+	hba->sg_entry_size = sg_entry_size;
+}
+#else
+static inline size_t ufshcd_sg_entry_size(const struct ufs_hba *hba)
+{
+	return sizeof(struct ufshcd_sg_entry);
+}
+
+#define ufshcd_set_sg_entry_size(hba, sg_entry_size)                   \
+	({ (void)(hba); BUILD_BUG_ON(sg_entry_size != sizeof(struct ufshcd_sg_entry)); })
+#endif
+
+static inline size_t sizeof_utp_transfer_cmd_desc(const struct ufs_hba *hba)
+{
+	return sizeof(struct utp_transfer_cmd_desc) + SG_ALL * ufshcd_sg_entry_size(hba);
+}
+
 /* Returns true if clocks can be gated. Otherwise false */
 static inline bool ufshcd_is_clkgating_allowed(struct ufs_hba *hba)
 {
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index f81aa95ffbc4..4e764016895d 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -426,18 +426,23 @@ struct ufshcd_sg_entry {
 	__le64    addr;
 	__le32    reserved;
 	__le32    size;
+	/*
+	 * followed by variant-specific fields if
+	 * CONFIG_SCSI_UFS_VARIABLE_SG_ENTRY_SIZE has been defined.
+	 */
 };
 
 /**
  * struct utp_transfer_cmd_desc - UTP Command Descriptor (UCD)
  * @command_upiu: Command UPIU Frame address
  * @response_upiu: Response UPIU Frame address
- * @prd_table: Physical Region Descriptor
+ * @prd_table: Physical Region Descriptor: an array of SG_ALL struct
+ *	ufshcd_sg_entry's.  Variant-specific fields may be present after each.
  */
 struct utp_transfer_cmd_desc {
 	u8 command_upiu[ALIGNED_UPIU_SIZE];
 	u8 response_upiu[ALIGNED_UPIU_SIZE];
-	struct ufshcd_sg_entry    prd_table[SG_ALL];
+	u8 prd_table[];
 };
 
 /**
