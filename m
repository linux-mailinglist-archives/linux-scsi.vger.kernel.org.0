Return-Path: <linux-scsi+bounces-12947-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85A7A676E3
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Mar 2025 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF6688280E
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Mar 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692121147F;
	Tue, 18 Mar 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DnmF+cOR"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B7621018A;
	Tue, 18 Mar 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309408; cv=none; b=hIFOgDBWqL3rAI7gNS5xeCgXJnqmaR0IR3P+85feLeeBinw6K1rEEVCMQuDVHS9f3e5tUne3oF4dxE7JJiFHCWGd+V1RG2EB88zZgxNq2i+UPLjp0+gLOM+NfbFJgqR0GN3he4jM/TFTkLcH9iD9+gREPd3D63iZG9e5swDmiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309408; c=relaxed/simple;
	bh=jhCaO9YMV23oEWsJK6n59kEeKrc9zPYEVuoTbh0oOLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8YfPjiKU+yi5hfXWPuoCLIT4npJetJgesNuyeCqKgziDERnCR34culicKWLIVCU95pNZX9Yk6kjfKxmGLVDnhBvt3SS2fjiginftq56wvPI/RJD5IPs1HhRFr8jKZY0FlRmJ+L79Coc59Nbj/xLJPDDB3Xv5geIo1kgqNRr36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DnmF+cOR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I9RDAa001749;
	Tue, 18 Mar 2025 14:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gOleFGyQgsf
	puCg30QL8T3cvvRGzQrC6LQuAy4DHe2Q=; b=DnmF+cORTcdV5duDqO2xHudGik1
	wtXGxQ/RAvrRkHr18eqItyxF7uU279y4uKTUVmXMmH3b7dM8jydD/BMKnODdG3B+
	unNTiPYojO64eHEsqwygEzwHqOGAW9gnJ7VTCJjSaJ5dZYrpJj14NZ1wUWAYH8B7
	fFgUbHchaLnBP1hVX6Rn+BY/b6q+S6n1M3aJWhTMQ45GK9TNPFhFu9CN7z+0L4ex
	+KAih1m2pSeo0L9B/5oYeoG7roeHZ0KWZVawJk+BWDOB9gFKEc0xOVXwFkklNdox
	TYCVAUPSESUlUKhqTTufoL8np9NwBgfv/Xunp3a2BkxcAsC+Vjb/7iRxJjg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1x80pbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 14:49:53 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEnmCV004303;
	Tue, 18 Mar 2025 14:49:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 45dkgmfv97-1;
	Tue, 18 Mar 2025 14:49:50 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52IEnmWU004296;
	Tue, 18 Mar 2025 14:49:50 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 52IEnmLa004293;
	Tue, 18 Mar 2025 14:49:50 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
	id 94536501583; Tue, 18 Mar 2025 20:19:49 +0530 (+0530)
From: Nitin Rawat <quic_nitirawa@quicinc.com>
To: vkoul@kernel.org, kishon@kernel.org, manivannan.sadhasivam@linaro.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        konrad.dybcio@oss.qualcomm.com
Cc: quic_rdwivedi@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>
Subject: [PATCH V2 5/6] scsi: ufs: qcom : Refactor phy_power_on/off calls
Date: Tue, 18 Mar 2025 20:19:43 +0530
Message-ID: <20250318144944.19749-6-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318144944.19749-1-quic_nitirawa@quicinc.com>
References: <20250318144944.19749-1-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 22gcK7MD6rPyO5oBHuloKAN1Ib_Rp7sz
X-Proofpoint-ORIG-GUID: 22gcK7MD6rPyO5oBHuloKAN1Ib_Rp7sz
X-Authority-Analysis: v=2.4 cv=Jem8rVKV c=1 sm=1 tr=0 ts=67d98812 cx=c_pps a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=ylzO3PbLlNu0Q4qtwUgA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180107

Commit 3f6d1767b1a0 ("phy: ufs-qcom: Refactor all init steps into
phy_poweron") removes the phy_power_on/off from ufs_qcom_setup_clocks
to suspend/resume func.

To have a better power saving, remove the phy_power_on/off calls from
resume/suspend path and put them back to ufs_qcom_setup_clocks, so that
PHY regulators & clks can be turned on/off along with UFS's clocks.

Since phy phy_power_on is separated out from phy calibrate, make
separate calls to phy_power_on and phy_calibrate calls from ufs qcom
driver.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Co-developed-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 58 +++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 1b37449fbffc..5c7b6c75d669 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -473,6 +473,11 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		goto out_disable_phy;
 	}

+	ret = phy_calibrate(phy);
+	if (ret) {
+		dev_err(hba->dev, "Failed to calibrate PHY %d\n", ret);
+		goto out_disable_phy;
+	}
 	ufs_qcom_select_unipro_mode(host);

 	return 0;
@@ -633,26 +638,17 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 	enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct phy *phy = host->generic_phy;

 	if (status == PRE_CHANGE)
 		return 0;

-	if (ufs_qcom_is_link_off(hba)) {
-		/*
-		 * Disable the tx/rx lane symbol clocks before PHY is
-		 * powered down as the PLL source should be disabled
-		 * after downstream clocks are disabled.
-		 */
+	if (!ufs_qcom_is_link_active(hba))
 		ufs_qcom_disable_lane_clks(host);
-		phy_power_off(phy);

-		/* reset the connected UFS device during power down */
-		ufs_qcom_device_reset_ctrl(hba, true);

-	} else if (!ufs_qcom_is_link_active(hba)) {
-		ufs_qcom_disable_lane_clks(host);
-	}
+	/* reset the connected UFS device during power down */
+	if (ufs_qcom_is_link_off(hba) && host->device_reset)
+		ufs_qcom_device_reset_ctrl(hba, true);

 	return ufs_qcom_ice_suspend(host);
 }
@@ -660,26 +656,11 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
 static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct phy *phy = host->generic_phy;
 	int err;

-	if (ufs_qcom_is_link_off(hba)) {
-		err = phy_power_on(phy);
-		if (err) {
-			dev_err(hba->dev, "%s: failed PHY power on: %d\n",
-				__func__, err);
-			return err;
-		}
-
-		err = ufs_qcom_enable_lane_clks(host);
-		if (err)
-			return err;
-
-	} else if (!ufs_qcom_is_link_active(hba)) {
-		err = ufs_qcom_enable_lane_clks(host);
-		if (err)
-			return err;
-	}
+	err = ufs_qcom_enable_lane_clks(host);
+	if (err)
+		return err;

 	return ufs_qcom_ice_resume(host);
 }
@@ -1036,6 +1017,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				 enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct phy *phy = host->generic_phy;
+	int err;

 	/*
 	 * In case ufs_qcom_init() is not yet done, simply ignore.
@@ -1054,10 +1037,20 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				/* disable device ref_clk */
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
 			}
+			err = phy_power_off(phy);
+			if (err) {
+				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
+					return err;
+			}
 		}
 		break;
 	case POST_CHANGE:
 		if (on) {
+			err = phy_power_on(phy);
+			if (err) {
+				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
+				return err;
+			}
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
 				ufs_qcom_dev_ref_clk_ctrl(host, true);
@@ -1240,9 +1233,10 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 static void ufs_qcom_exit(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct phy *phy = host->generic_phy;

 	ufs_qcom_disable_lane_clks(host);
-	phy_power_off(host->generic_phy);
+	phy_power_off(phy);
 	phy_exit(host->generic_phy);
 }

--
2.48.1


