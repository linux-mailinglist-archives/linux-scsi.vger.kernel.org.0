Return-Path: <linux-scsi+bounces-12248-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B37A3397D
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 09:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A227188864D
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2025 08:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00EA20B20B;
	Thu, 13 Feb 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="opb37hiw"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4D20B1F3;
	Thu, 13 Feb 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433676; cv=none; b=b0vH6q8jUl08NNnilaCebKX5Zj+rHQ6rUl02l4T0RlIExtRhoHjhdOMxXXQM+CCkJwceTGrojj52ASqz3wA4M7mgD6P84RYjhdbX8+f1r+GH4EeckwXQ90yInktpxcWlvd/t9yd9s93S6GYLu9mn+7XhtQJMPz+YR7TEX2/5o1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433676; c=relaxed/simple;
	bh=JCVox0UKZc5pfm1CmdQ+6isejy81ta6kj4TXqpNoUY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YZqUS+a3FM0L6waX2UzyFmiIC0ZYNkNuy8bb7hdi17HCBV39NKTtMSVRB/bXx9gjmnZoM3BSzROhIWc4TAj5+k/f0lTfZNYU8TcMv/RoO9ECQz8kdhOnek5c7IkiGuAnj21i+l8Fn1OQxF6h7tu2B50LC4xUrM+q+pq7PApVWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=opb37hiw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CJ13kj001378;
	Thu, 13 Feb 2025 08:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kCzSGhUBq6+
	RlrxSa3R+8rGSLAt/FXV4/9Aw3ccTTwk=; b=opb37hiwGnlaFPcLaiSCcjAPz+X
	8npYV0Sy7cK+kGQmrOzAuqu+Gr4N8oT2hKP6SjbnVGFJI40f/DqV0IXGx5LgyWTM
	ZTT3v2VPPVlDya0xZlF5k3inCw2J4mRBieIW9f97cMvLCW0Zh36J7gjjRVgGGMqt
	TanRP14zKaFNihjJHkXajG1fGyyVzysJIAbrR+S2Cv2attvELMIALkZu1dIgqfZu
	GOk7IE+B0hKnUTJkHH1Qf1clebbAfBW9cHVb08z4V4tXTxHflNNavm7eKyo5m5Da
	PJtJpd3bHYGEMYPzzJNfAMdHT+GdJCOe7joTsbnk72F0MetT/vx24hrLexA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rrnfu481-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 08:00:46 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 51D80hAp031688;
	Thu, 13 Feb 2025 08:00:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 44p0bkyaj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 08:00:43 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51D80gul031667;
	Thu, 13 Feb 2025 08:00:42 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 51D80gHD031660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 08:00:42 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 393357)
	id 638E040C04; Thu, 13 Feb 2025 16:00:41 +0800 (CST)
From: Ziqi Chen <quic_ziqichen@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        peter.wang@mediatek.com, quic_rampraka@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Eric Biggers <ebiggers@google.com>, Minwoo Im <minwoo.im@samsung.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 3/8] scsi: ufs: core: Add a vop to map clock frequency to gear speed
Date: Thu, 13 Feb 2025 16:00:03 +0800
Message-Id: <20250213080008.2984807-4-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213080008.2984807-1-quic_ziqichen@quicinc.com>
References: <20250213080008.2984807-1-quic_ziqichen@quicinc.com>
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
X-Proofpoint-GUID: HRKyK8HIMR_RUdd_RcTB9Ie54v5Uu74m
X-Proofpoint-ORIG-GUID: HRKyK8HIMR_RUdd_RcTB9Ie54v5Uu74m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130060

From: Can Guo <quic_cang@quicinc.com>

Add a vop to map UFS host controller clock frequencies to the corresponding
maximum supported UFS high speed gear speeds. During clock scaling, we can
map the target clock frequency, demanded by devfreq, to the maximum
supported gear speed, so that devfreq can scale the gear to the highest
gear speed supported at the target clock frequency, instead of just scaling
up/down the gear between the min and max gear speeds.

Co-developed-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
---
v2 -> v3:
1. Remove the parameter 'gear' and use it as function return result.
2. Change "vops" into "vop" in commit message.

v4 -> v5:
1. keep the indentation consistent for vop freq_to_gear_speed.
2. Change the return value type of vop freq_to_gear_speed from 'int' to 'u32'.
---
 drivers/ufs/core/ufshcd-priv.h | 8 ++++++++
 include/ufs/ufshcd.h           | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 0549b65f71ed..983b0a8dafb5 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -277,6 +277,14 @@ static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline u32 ufshcd_vops_freq_to_gear_speed(struct ufs_hba *hba, unsigned long freq)
+{
+	if (hba->vops && hba->vops->freq_to_gear_speed)
+		return hba->vops->freq_to_gear_speed(hba, freq);
+
+	return 0;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 02802981f07f..b34301de3cf8 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -336,6 +336,7 @@ struct ufs_pwr_mode_info {
  * @get_outstanding_cqs: called to get outstanding completion queues
  * @config_esi: called to config Event Specific Interrupt
  * @config_scsi_dev: called to configure SCSI device parameters
+ * @freq_to_gear_speed: called to map clock frequency to the max supported gear speed
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -387,6 +388,7 @@ struct ufs_hba_variant_ops {
 				       unsigned long *ocqs);
 	int	(*config_esi)(struct ufs_hba *hba);
 	void	(*config_scsi_dev)(struct scsi_device *sdev);
+	u32	(*freq_to_gear_speed)(struct ufs_hba *hba, unsigned long freq);
 };
 
 /* clock gating state  */
-- 
2.34.1


