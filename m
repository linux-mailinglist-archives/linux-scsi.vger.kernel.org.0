Return-Path: <linux-scsi+bounces-283-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A177FD12E
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 09:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55E1B21640
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C7125B1
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Nov 2023 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="otA4sfo7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669851BC8;
	Wed, 29 Nov 2023 00:29:22 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT4M26b026089;
	Wed, 29 Nov 2023 08:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=n3EXxuuZpecr97yadUS8Jc3s3y2WaE0HXsYi/kt7/X8=;
 b=otA4sfo77RHVplw+uyiP3Rdz+FekR5aNqLGs6u4NKhfDG6t9BoVWU6sYYyUb1oaViydZ
 xHSDFqA7rk5byAFRvEoWcACPHraAuBdCKceSisIZVR+seQUI+S4os4OnWK2S4ONjsOhX
 +qFAt8nV/oc4ncHjvRLv4qgJnsFA1K8unHLThA3gV8sWGMEQ7lAZ8nN9uHmhrI1PZkou
 FdYWFhrMWg4b3HLq8o/U8FWM7AhoVxWyS3B6cwRhEm6sR1/eyxBWPl8aFFzBmd0lqTmi
 GbfJK7tL4okUd2kWctU0CFUFDzTWoeslD5Y3nkJV8nJwMxhaRZY3d5CfYqtpbi+TqHjl vQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unkent3e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 08:29:09 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AT8D5bG030537;
	Wed, 29 Nov 2023 08:29:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3unmew6x9s-1;
	Wed, 29 Nov 2023 08:29:08 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AT8T83w021502;
	Wed, 29 Nov 2023 08:29:08 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3AT8T8jC021500;
	Wed, 29 Nov 2023 08:29:08 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
	id 45CAA20A5D; Wed, 29 Nov 2023 00:29:08 -0800 (PST)
From: Can Guo <quic_cang@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        adrian.hunter@intel.com, cmd4@qualcomm.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 10/10] scsi: ufs: ufs-qcom: Add support for UFS device version detection
Date: Wed, 29 Nov 2023 00:28:35 -0800
Message-Id: <1701246516-11626-11-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SVGJBxBXVFheDgP5w9446gI_atSnZt-x
X-Proofpoint-ORIG-GUID: SVGJBxBXVFheDgP5w9446gI_atSnZt-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_06,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290062
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>

A spare register in UFS host controller is used to indicate the UFS device
version. The spare register is populated by bootloader for now, but in
future it will be populated by HW automatically during link startup with
its best efforts in any boot stages prior to Linux.

During host driver init, read the spare register, if it is not populated
with a UFS device version, go ahead with the dual init mechanism. If a UFS
device version is in there, use the UFS device version together with host
controller's HW version to decide the proper PHY gear which should be used
to configure the UFS PHY without going through the second init.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 23 ++++++++++++++++++-----
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 9c0ebbc..e94dea2 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1068,15 +1068,28 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
 {
 	struct ufs_host_params *host_params = &host->host_params;
+	u32 val, dev_major = 0;
 
 	host->phy_gear = host_params->hs_tx_gear;
 
-	/*
-	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
-	 * Switching to max gear will be performed during reinit if supported.
-	 */
-	if (host->hw_ver.major < 0x4)
+	if (host->hw_ver.major < 0x4) {
+		/*
+		 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
+		 * Switching to max gear will be performed during reinit if supported.
+		 */
 		host->phy_gear = UFS_HS_G2;
+	} else {
+		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
+		dev_major = FIELD_GET(GENMASK(7, 4), val);
+
+		/* UFS device version populated, no need to do init twice */
+		if (dev_major != 0)
+			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+
+		/* For UFS 3.1 and older, apply HS-G4 PHY gear to save power */
+		if (dev_major < 0x4 && dev_major > 0)
+			host->phy_gear = UFS_HS_G4;
+	}
 }
 
 static void ufs_qcom_set_host_params(struct ufs_hba *hba)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 11419eb..d12fc5a 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -54,6 +54,8 @@ enum {
 	UFS_AH8_CFG				= 0xFC,
 
 	REG_UFS_CFG3				= 0x271C,
+
+	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
-- 
2.7.4


