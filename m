Return-Path: <linux-scsi+bounces-11115-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F15FA0057F
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jan 2025 09:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A046E18839E4
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jan 2025 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6A1B412C;
	Fri,  3 Jan 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tzp7Hufp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB2A93D;
	Fri,  3 Jan 2025 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735891475; cv=none; b=LrujRmYFPB1aQI9Epppq7C600PitWhScuLaWrGaRPC4jbFa7LOvtPZSvyLRO7mkiUrJ9UHFgs4rc1YdhcS/g2/lrXgywTyqCFW0naSeWioqoOaWYpfyBTaKGtH5NX2Q1HsKm0W/1x6Ej5eeGXvyyiq/QGXCXiE41Rq9T6zSnjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735891475; c=relaxed/simple;
	bh=re4Y2/L7Pfzxv9WK/iNtRZyDSWorwXdKvCC1NuitT+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nenP4Fq7qVzy48dr27VWsBP15RjSXUMGqp1R4TINSKvX1iZ88BZMc/K5/+/L04ojUWj2WDno/hF5c6iOZvLVPCVM8TfopcIIKRRBbr+BpyrieBm6rMkngXVUJFj9LnQk4/LSZi7mzpI0JjlnHqhECjVqZN7O335K4p8phAWDMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Tzp7Hufp; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1735891473; x=1767427473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=re4Y2/L7Pfzxv9WK/iNtRZyDSWorwXdKvCC1NuitT+s=;
  b=Tzp7HufpMNlY8n7lh2KZAfIA27U17jKszQWrxfs67whSxedrr8d3W0vS
   RCl6PuEx+bzYrcBhz+9Nb+K/ad3EGARpJFkaiY+y/+KuSH+YGY0J/zPi9
   qIlFqc7nXeyIkyJhu2R9Ci4DTR5qObl1Imy9TkeRBkjH5j+0TAgeKEvAp
   xqFqANmvb0ioWVGBxE0x9oQbDW45GuVsYK3qU5ZIZlhKEwIX96/lS+jkM
   /WY6p6rTflty1z8vPlL54TmiTu95H9XyqWs/YbZ7xRwxpc9qgtralIj8f
   Mla/cbhj6c6ACY0a/38YGfoaUF4HmArzrTuIzhtONrDfG3McIm/xeCLmq
   g==;
X-CSE-ConnectionGUID: ANbnF8HbRRCy7U/xGbgQmA==
X-CSE-MsgGUID: 8Cx+TeVRTqWiTwD7ybWKdw==
X-IronPort-AV: E=Sophos;i="6.12,286,1728921600"; 
   d="scan'208";a="36294080"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2025 16:04:33 +0800
IronPort-SDR: 67778b47_jF/AVm+/MQDfDF2LUS7dsjgLUZC5oPQOfUTD+TkAlePPYGO
 iXM58sYKUdf4BpVHr+liQwHGXSsxJHKzRhp60UA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2025 23:01:28 -0800
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2025 00:04:31 -0800
From: Avri Altman <avri.altman@wdc.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>,
	Can Guo <quic_cang@quicinc.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>
Subject: [PATCH v3] Revert "scsi: ufs: core: Probe for EXT_IID support"
Date: Fri,  3 Jan 2025 10:02:04 +0200
Message-Id: <20250103080204.63951-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6e1d850acff9477ae4c18a73c19ef52841ac2010.

Although added a while ago, to date no one make use of ext_iid,
specifically incorporates it in the upiu header.  Therefore, remove it
as it is currently unused and not serving any purpose.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: Can Guo <quic_cang@quicinc.com>
Cc: Asutosh Das <quic_asutoshd@quicinc.com>

---
Changes compared to v2:
 - Refrain from using the term 'dead code' (Bart)
 - Remove redundant space (Bart)

Changes compared to v1:
 - Fix typo
---
 drivers/ufs/core/ufshcd.c | 33 ---------------------------------
 include/ufs/ufs.h         |  5 -----
 include/ufs/ufshcd.h      |  2 --
 include/ufs/ufshci.h      |  5 -----
 4 files changed, 45 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3dfaeba5b691..7d672bd52b84 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2411,12 +2411,7 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	else
 		hba->lsdb_sup = true;
 
-	if (!hba->mcq_sup)
-		return 0;
-
 	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
-	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
-				     hba->mcq_capabilities);
 
 	return 0;
 }
@@ -8082,31 +8077,6 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	}
 }
 
-static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
-{
-	struct ufs_dev_info *dev_info = &hba->dev_info;
-	u32 ext_ufs_feature;
-	u32 ext_iid_en = 0;
-	int err;
-
-	/* Only UFS-4.0 and above may support EXT_IID */
-	if (dev_info->wspecversion < 0x400)
-		goto out;
-
-	ext_ufs_feature = get_unaligned_be32(desc_buf +
-				     DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
-	if (!(ext_ufs_feature & UFS_DEV_EXT_IID_SUP))
-		goto out;
-
-	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
-				      QUERY_ATTR_IDN_EXT_IID_EN, 0, 0, &ext_iid_en);
-	if (err)
-		dev_err(hba->dev, "failed reading bEXTIIDEn. err = %d\n", err);
-
-out:
-	dev_info->b_ext_iid_en = ext_iid_en;
-}
-
 static void ufshcd_set_rtt(struct ufs_hba *hba)
 {
 	struct ufs_dev_info *dev_info = &hba->dev_info;
@@ -8302,9 +8272,6 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufs_init_rtc(hba, desc_buf);
 
-	if (hba->ext_iid_sup)
-		ufshcd_ext_iid_probe(hba, desc_buf);
-
 	/*
 	 * ufshcd_read_string_desc returns size of the string
 	 * reset the error value
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index e594abe5d05f..89672ad8c3bb 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -180,7 +180,6 @@ enum attr_idn {
 	QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       = 0x1D,
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
-	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
 	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
 };
 
@@ -391,7 +390,6 @@ enum {
 	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
-	UFS_DEV_EXT_IID_SUP		= BIT(16),
 };
 #define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
@@ -585,9 +583,6 @@ struct ufs_dev_info {
 
 	bool    b_advanced_rpmb_en;
 
-	/* UFS EXT_IID Enable */
-	bool	b_ext_iid_en;
-
 	/* UFS RTC */
 	enum ufs_rtc_time rtc_type;
 	time64_t rtc_time_baseline;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index ce7667b020e2..a2f7d565a79b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -955,7 +955,6 @@ enum ufshcd_mcq_opr {
  * @nr_queues: number of Queues of different queue types
  * @complete_put: whether or not to call ufshcd_rpm_put() from inside
  *	ufshcd_resume_complete()
- * @ext_iid_sup: is EXT_IID is supported by UFSHC
  * @mcq_sup: is mcq supported by UFSHC
  * @mcq_enabled: is mcq ready to accept requests
  * @res: array of resource info of MCQ registers
@@ -1121,7 +1120,6 @@ struct ufs_hba {
 	unsigned int nr_hw_queues;
 	unsigned int nr_queues[HCTX_MAX_TYPES];
 	bool complete_put;
-	bool ext_iid_sup;
 	bool scsi_host_added;
 	bool mcq_sup;
 	bool lsdb_sup;
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 27364c4a6ef9..612500a7088f 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -82,11 +82,6 @@ enum {
 	MASK_MCQ_SUPPORT			= 0x40000000,
 };
 
-/* MCQ capability mask */
-enum {
-	MASK_EXT_IID_SUPPORT = 0x00000400,
-};
-
 enum {
 	REG_SQATTR		= 0x0,
 	REG_SQLBA		= 0x4,
-- 
2.25.1


