Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639678FC6D
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Sep 2023 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349216AbjIALnM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Sep 2023 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjIALnE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Sep 2023 07:43:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5375B5;
        Fri,  1 Sep 2023 04:43:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381A0Csi019941;
        Fri, 1 Sep 2023 11:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/LDI4xbTTZJEZhw8SQsuXul4NtFZ4wMk1vLaQ+gPH08=;
 b=Q2EQKFUrJfL0Kkqmn2h/dwBMaA+D+Ez13uHUiiwVILs+eKiE16nHl10ne6xulNEgKJwj
 XGJIS7usEcZjbdL1M/WZYVREnqXPMwdxid0o1J9m6NvcjokDl4XHMyV4yPF7mg960Q/3
 1cSDkivjBiH/+oIQ/fu4LysJCOcTEbIHexM8mhuiZlHZITpnjqMLjwjtDfvYIBK4jR7d
 c/cqlz6yc7c9jZNsY1vczJgHPrB1SroU4tNt2ozbcXXBy3s9yD57WSiFo0103ykdbMY7
 pyB5+H0XohdCJWbh8urvVwWH2s+aJJNID5YuYSAyvFAHE4sMB4qBGb0V7tp/DAtSOKbI bQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stv5nawxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 11:42:53 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 381BgnHv013946;
        Fri, 1 Sep 2023 11:42:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sqafmj043-1;
        Fri, 01 Sep 2023 11:42:49 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 381BgnNi013941;
        Fri, 1 Sep 2023 11:42:49 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 381BgnHO013940;
        Fri, 01 Sep 2023 11:42:49 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id E44985006A6; Fri,  1 Sep 2023 17:12:48 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: [PATCH V6 2/6] scsi: ufs: qcom: Configure PA_VS_CORE_CLK_40NS_CYCLES
Date:   Fri,  1 Sep 2023 17:12:38 +0530
Message-Id: <20230901114242.31219-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
References: <20230901114242.31219-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8sHP9734E5S5QmK6GgQWATXr9xMC_F9x
X-Proofpoint-ORIG-GUID: 8sHP9734E5S5QmK6GgQWATXr9xMC_F9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010109
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Configure PA_VS_CORE_CLK_40NS_CYCLES with frequency of unipro core clk
for Qualcomm UFS controller V4.0 and onwards to align with the hardware
specification.

Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 47 ++++++++++++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index fe36003faaa8..018e391c276e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -93,8 +93,9 @@ static const struct __ufs_qcom_bw_table {
 static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];

 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
-static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 clk_cycles);
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
+						       u32 clk_cycles,
+						       u32 clk_40ns_cycles);

 static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 {
@@ -690,8 +691,8 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 			 * set unipro core clock cycles to 150 & clear clock
 			 * divider
 			 */
-			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
-									  150);
+			err = ufs_qcom_set_core_clk_ctrl(hba,
+									  150, 6);

 		/*
 		 * Some UFS devices (and may be host) have issues if LCC is
@@ -1295,12 +1296,12 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 	phy_power_off(host->generic_phy);
 	phy_exit(host->generic_phy);
 }
-
-static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
-						       u32 cycles_in_1us)
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
+					u32 cycles_in_1us,
+					u32 cycles_in_40ns)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	u32 core_clk_ctrl_reg;
+	u32 core_clk_ctrl_reg, reg;
 	int ret;

 	ret = ufshcd_dme_get(hba,
@@ -1325,9 +1326,33 @@ static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
 	/* Clear CORE_CLK_DIV_EN */
 	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;

-	return ufshcd_dme_set(hba,
+	err = ufshcd_dme_set(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    core_clk_ctrl_reg);
+	/*
+	 * UFS host controller V4.0.0 onwards needs to program
+	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
+	 * frequency of unipro core clk of UFS host controller.
+	 */
+	if (!err && (host->hw_ver.major >= 4)) {
+		if (cycles_in_40ns > PA_VS_CORE_CLK_40NS_CYCLES_MASK)
+			return -EINVAL;
+
+		err = ufshcd_dme_get(hba,
+				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
+				     &reg);
+		if (err)
+			return err;
+
+		reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
+		reg |= cycles_in_40ns;
+
+		err = ufshcd_dme_set(hba,
+				     UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES),
+				     reg);
+	}
+
+	return err;
 }

 static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
@@ -1344,7 +1369,7 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
 		return 0;

 	/* set unipro core clock cycles to 150 and clear clock divider */
-	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 150);
+	return ufs_qcom_set_core_clk_ctrl(hba, 150, 6);
 }

 static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
@@ -1380,7 +1405,7 @@ static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba)
 		return 0;

 	/* set unipro core clock cycles to 75 and clear clock divider */
-	return ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba, 75);
+	return ufs_qcom_set_core_clk_ctrl(hba, 75, 3);
 }

 static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 8a9d3dbec297..d81bf1a1b77a 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -132,6 +132,8 @@ enum {
 #define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
 #define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
 #define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)
+#define PA_VS_CORE_CLK_40NS_CYCLES			0x9007
+#define PA_VS_CORE_CLK_40NS_CYCLES_MASK			GENMASK(6, 0)

 static inline void
 ufs_qcom_get_controller_revision(struct ufs_hba *hba,
--
2.17.1

