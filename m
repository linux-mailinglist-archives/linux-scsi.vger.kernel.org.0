Return-Path: <linux-scsi+bounces-399-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12FD800406
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 07:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4FF281608
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D411CB6
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BNTwbhdT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE8D1981;
	Thu, 30 Nov 2023 21:04:47 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B14aULo007790;
	Fri, 1 Dec 2023 05:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=8lNJtIxq4QyUwpN4j9OKeu7nOMsXjWl2NhGsEwxko3w=;
 b=BNTwbhdTNq/t8pIX8CREfsrAFMWg6ciDcNzNsW8KYh+mJ/YzaG8mek3ofHNqifKVknjY
 WNiU301kymXZA/uLQHMO8qpS5awDa/mU7r+ICNDb76EqeV3SkXjShw6XlkpZNyp1n6jV
 YUEW4evN8c9yaFAZ0t/kJBMIj3jdbnGm/GGDsIqOEmboekTSRh/q8bAvd7kzZNnRQNt6
 Qgw2TBBwEV4TUBWPMC4KuQRXIeww6s4/tVPfRBeXFxtLLTTNv/2pB2bRyPhbsIybxCuV
 CnYiarfxN8GyeKPzk6z5O1ySE+dSP39LeYHfxtYpWgJ7LFqDHUmI8nK+SLuS6x2gfcqA sw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upv481we9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 05:04:05 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B14k6oh028224;
	Fri, 1 Dec 2023 05:04:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3unmevu33h-1;
	Fri, 01 Dec 2023 05:04:04 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1515R4015861;
	Fri, 1 Dec 2023 05:04:04 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
	by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 3B1544lI019708;
	Fri, 01 Dec 2023 05:04:04 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
	id C4E1B20A77; Thu, 30 Nov 2023 21:04:03 -0800 (PST)
From: Can Guo <quic_cang@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, vkoul@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 06/10] scsi: ufs: ufs-qcom: Set initial PHY gear to max HS gear for HW ver 4 and newer
Date: Thu, 30 Nov 2023 21:03:16 -0800
Message-Id: <1701407001-471-7-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V-oNqm89EKq5t-WCWKa3Fn1PM4pvzgPa
X-Proofpoint-ORIG-GUID: V-oNqm89EKq5t-WCWKa3Fn1PM4pvzgPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_02,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010028
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

Since HW ver 4, max HS gear can be get from UFS host controller's register,
use the max HS gear as the initial PHY gear instead of UFS_HS_G2, so that
we don't need to update the hard code for newer targets in future.

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index aca6199..543939c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1060,6 +1060,22 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
+static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
+{
+	struct ufs_host_params *host_params = &host->host_params;
+
+	host->phy_gear = host_params->hs_tx_gear;
+
+	/*
+	 * For controllers whose major HW version is < 4, power up the PHY using
+	 * minimum supported gear (UFS_HS_G2). Switching to max gear will be
+	 * performed during reinit if supported. For newer controllers, whose
+	 * major HW version is >= 4, power up the PHY using max supported gear.
+	 */
+	if (host->hw_ver.major < 0x4)
+		host->phy_gear = UFS_HS_G2;
+}
+
 static void ufs_qcom_set_host_params(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -1296,6 +1312,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	ufs_qcom_set_caps(hba);
 	ufs_qcom_advertise_quirks(hba);
 	ufs_qcom_set_host_params(hba);
+	ufs_qcom_set_phy_gear(host);
 
 	err = ufs_qcom_ice_init(host);
 	if (err)
@@ -1313,12 +1330,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		dev_warn(dev, "%s: failed to configure the testbus %d\n",
 				__func__, err);
 
-	/*
-	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
-	 * Switching to max gear will be performed during reinit if supported.
-	 */
-	host->phy_gear = UFS_HS_G2;
-
 	return 0;
 
 out_variant_clear:
-- 
2.7.4


