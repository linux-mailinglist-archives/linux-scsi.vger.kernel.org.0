Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC655F5E41
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Oct 2022 03:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJFBHc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Oct 2022 21:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiJFBHM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Oct 2022 21:07:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D924733E1;
        Wed,  5 Oct 2022 18:07:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2960t8a3029469;
        Thu, 6 Oct 2022 01:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3sbckE6A5VhBPnv5y9H+XY3VNUl30WTK1gLe3niRbXc=;
 b=YQusL3SLuaYNApMLJrFKlRUR4u6R3UcmFjCVHJUfJtaXA+1PDvRG+KJQe3VeUDEvBT0E
 YUxU9DSLWMYLVXyrqkGh+Gt0mQcSuI2K7wC3MOl5yzQeZKLtx/I91fShbOcr2/aeQUUr
 eJn7Yee6dEAyAhl/O3V63IyJ2JY89328xw/C0OPfujsH5vHLvYroWHwrsc+u0n3IFJ9a
 gxJ+B8Ab+zMCFXUbR2wQVOzIVS2p1irIoj7/u5xPU+Yo2uqCA7X6dbN6uaFD2UefZZyF
 u0+UeevelQpot7eKF1pqJkMGsTk2Od8TP6O3WxFZlxoaTexdf+JPmS8H4eYg7970l/kO nQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1kva04jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 01:06:50 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29616neF026665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 01:06:49 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 18:06:49 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_bhaskarv@quicinc.com>,
        <quic_richardp@quicinc.com>, <linux-scsi@vger.kernel.org>
CC:     Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>
Subject: [PATCH v2 01/17] ufs: core: Probe for ext_iid support
Date:   Wed, 5 Oct 2022 18:06:00 -0700
Message-ID: <1d21e634e86f26e3a22be3c380a85bd4dd17f1ae.1665017636.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1665017636.git.quic_asutoshd@quicinc.com>
References: <cover.1665017636.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M2Nn-54LSADPPnNNjb7_0IgQ2Yqv6G7Y
X-Proofpoint-ORIG-GUID: M2Nn-54LSADPPnNNjb7_0IgQ2Yqv6G7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Task Tag is limited to 8 bits and this restricts the number
of active IOs to 255.
In Multi-circular queue mode, this may not be enough.
The specification provides EXT_IID which can be used to increase
the number of IOs if the UFS device and UFSHC support it.
This patch adds support to probe for ext_iid support in
ufs device and UFSHC.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/ufs/ufs.h         |  4 ++++
 include/ufs/ufshcd.h      |  4 ++++
 include/ufs/ufshci.h      |  7 +++++++
 4 files changed, 57 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f4f8ded..80f01d0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -214,6 +214,17 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static unsigned int ufs_get_ext_ufs_feature(struct ufs_hba *hba,
+					    const u8 *desc_buf)
+{
+	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
+	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
+		return 0;
+
+	return get_unaligned_be32(desc_buf +
+				  DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+}
+
 static const struct ufs_dev_quirk ufs_fixups[] = {
 	/* UFS cards deviations table */
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
@@ -2239,6 +2250,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	if (err)
 		dev_err(hba->dev, "crypto setup failed\n");
 
+	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
+	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
+				     hba->mcq_capabilities);
+
 	return err;
 }
 
@@ -7664,6 +7679,30 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	}
 }
 
+static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
+{
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	u32 ext_ufs_feature;
+	u32 ext_iid_en = 0;
+	int err;
+
+	/* Only UFS-4.0 and above may support EXT_IID */
+	if (dev_info->wspecversion < 0x400)
+		goto out;
+
+	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
+	if (!(ext_ufs_feature & UFS_DEV_EXT_IID_SUP))
+		goto out;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				      QUERY_ATTR_IDN_EXT_IID_EN, 0, 0, &ext_iid_en);
+	if (err)
+		dev_err(hba->dev, "failed reading bEXTIIDEn. err = %d\n", err);
+
+out:
+	dev_info->b_ext_iid_en = ext_iid_en;
+}
+
 void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
 			     const struct ufs_dev_quirk *fixups)
 {
@@ -7762,6 +7801,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 
 	ufshcd_temp_notif_probe(hba, desc_buf);
 
+	if (hba->ext_iid_sup)
+		ufshcd_ext_iid_probe(hba, desc_buf);
+
 	/*
 	 * ufshcd_read_string_desc returns size of the string
 	 * reset the error value
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fe..ba2a1d8 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -165,6 +165,7 @@ enum attr_idn {
 	QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       = 0x1D,
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
+	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
 };
 
 /* Descriptor idn for Query requests */
@@ -352,6 +353,7 @@ enum {
 	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
 	UFS_DEV_HPB_SUPPORT		= BIT(7),
 	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
+	UFS_DEV_EXT_IID_SUP		= BIT(16),
 };
 #define UFS_DEV_HPB_SUPPORT_VERSION		0x310
 
@@ -601,6 +603,8 @@ struct ufs_dev_info {
 
 	bool	b_rpm_dev_flush_capable;
 	u8	b_presrv_uspc_en;
+	/* UFS EXT_IID Enable */
+	bool	b_ext_iid_en;
 };
 
 /*
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a92..da1eb8a 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -737,6 +737,7 @@ struct ufs_hba_monitor {
  * @outstanding_lock: Protects @outstanding_reqs.
  * @outstanding_reqs: Bits representing outstanding transfer requests
  * @capabilities: UFS Controller Capabilities
+ * @mcq_capabilities: UFS Multi Command Queue capabilities
  * @nutrs: Transfer Request Queue depth supported by controller
  * @nutmrs: Task Management Queue depth supported by controller
  * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
@@ -818,6 +819,7 @@ struct ufs_hba_monitor {
  *	device
  * @complete_put: whether or not to call ufshcd_rpm_put() from inside
  *	ufshcd_resume_complete()
+ * @ext_iid_sup: is EXT_IID is supported by UFSHC
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -859,6 +861,7 @@ struct ufs_hba {
 
 	u32 capabilities;
 	int nutrs;
+	u32 mcq_capabilities;
 	int nutmrs;
 	u32 reserved_slot;
 	u32 ufs_version;
@@ -965,6 +968,7 @@ struct ufs_hba {
 #endif
 	u32 luns_avail;
 	bool complete_put;
+	bool ext_iid_sup;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index f81aa95..ef5c3a8 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -22,6 +22,7 @@ enum {
 /* UFSHCI Registers */
 enum {
 	REG_CONTROLLER_CAPABILITIES		= 0x00,
+	REG_MCQCAP				= 0x04,
 	REG_UFS_VERSION				= 0x08,
 	REG_CONTROLLER_DEV_ID			= 0x10,
 	REG_CONTROLLER_PROD_ID			= 0x14,
@@ -68,6 +69,12 @@ enum {
 	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
 	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
 	MASK_CRYPTO_SUPPORT			= 0x10000000,
+	MASK_MCQ_SUPPORT			= 0x40000000,
+};
+
+/* MCQ capability mask */
+enum {
+	MASK_EXT_IID_SUPPORT = 0x00000400,
 };
 
 #define UFS_MASK(mask, offset)		((mask) << (offset))
-- 
2.7.4

