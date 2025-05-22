Return-Path: <linux-scsi+bounces-14274-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C9AC0261
	for <lists+linux-scsi@lfdr.de>; Thu, 22 May 2025 04:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3028F9E3B9B
	for <lists+linux-scsi@lfdr.de>; Thu, 22 May 2025 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF08146D65;
	Thu, 22 May 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFZPw4yl"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3313AD1C;
	Thu, 22 May 2025 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747880180; cv=none; b=ILQolfeDAFv31unReDcDdyZZlAcOn6qjlqVoC7m3qZUIX8mAMYp+FdRX4a7nCi+hmhx17uZo4L2pSPTrB3Zr1k+ng2AwZrA2hbUNaENcuT60ozs8zN0HydpjIDEqgo4NCzpDxsHylYyJPdAaHOyKHNQxz4xxfZ0C0EovNOKyIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747880180; c=relaxed/simple;
	bh=RQ+UkO+g7U1XSuHGlOhjtXx/j/mXj+6fDWvDWu2SeVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnxrXn4gAwEPScRRdGGrNb6O/nP5GYcWsT4555a5h/IkDU7+wfMNSL7Gkeay6pUVZ3dIzDrFq9CqExpdtasqaBSHTvNnfn/ZSOnccNOrw4SFgtFGUNSSdjoXw/KtB1XijxP7tJCluLz9IQjyiK1Wy/Lbfs480rdPr4kt/KLQfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TFZPw4yl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHViC9024757;
	Thu, 22 May 2025 02:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l2X4KTcmSkXpi978dpv8lap9xD8yM5cZKzozqCn/xTA=; b=TFZPw4ylO9r/OfIS
	mzpXISNM3B6QHOH5HX6cBP4jVHS4cCXBnMkgCXA2rYUNeVkObmcnXkT71kHjQQbw
	dk36oMPK1QZuDUAPGQbol5vYm9QuPkaGkK9BEnlO+QTznvzlK/g025PTnkA2lEph
	ZL1EsTK7/DYh1y+fw3DI9DyffN4rXNZQuCzIamv6kJU+oSiDB/u+xYuUJotbn/FF
	dP/GJ672mkKzF7LzImRzZ0cKHuyzzHJ3ZRnnxWAxMbW2moT7mclp/uQONvzPC6Ts
	+hi+578EtZxmdLrom0CH318xFdiIY6gbT/rxfsvHTc3j8SyLPLINl4gzpON1h1gR
	/gLN/w==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4vptk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 02:15:47 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 54M2FjWP011772;
	Thu, 22 May 2025 02:15:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 46pkhn5p54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 02:15:45 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54M2FiHL011764;
	Thu, 22 May 2025 02:15:44 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 54M2FiRE011755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 02:15:44 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 393357)
	id 8C2A740C05; Thu, 22 May 2025 10:15:43 +0800 (CST)
From: Ziqi Chen <quic_ziqichen@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, neil.armstrong@linaro.org,
        luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
        peter.wang@mediatek.com
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/3] scsi: ufs: qcom: Map devfreq OPP freq to UniPro Core Clock freq
Date: Thu, 22 May 2025 10:15:36 +0800
Message-Id: <20250522021537.999107-3-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522021537.999107-1-quic_ziqichen@quicinc.com>
References: <20250522021537.999107-1-quic_ziqichen@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NEguqf7Qb_xqT9fZnSh0WKeXn454ncDg
X-Proofpoint-ORIG-GUID: NEguqf7Qb_xqT9fZnSh0WKeXn454ncDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDAyMCBTYWx0ZWRfXz5xnwWcAEHoU
 hZybGLV3ETRM9+1yLvuAs6vJc0INaHP71WdFk/hUy3TXXbEzpYSk9bratMpnAvq53jEgU1J7eEu
 Np53A96I1hfcPeF7YgDd/CepeE2r7LEtsy7U4YnBf4y5++XvmpWj9dZbuE0ouYB4eM3Wkh3Y41l
 q2XZLu00Z+HGeloA/ju4R5Z79QPN/KsVnR0zroIL/avnRGy7XumsdLtjwhihsvFuCWPxZUu1Asm
 0uiOseQDr8lLq72IjofRdXbu2sbL+Plk+XoSc1qvW2dkie3BVPXuN9Z5XdzJKlOgdjX0zfjET0c
 Hnchn3OZor3V4yXKwzFOnLm61GM1TUv1KIbHWBbMok4YmM8H0Ee38KbfWVx0t2bfug7fT0C16LD
 SjXQfFkMipd6GTCKj59HTd3ihAMSJCJ1oHhyBWt3yfXmH/pponMrX19wwJmjwkUIPXsJVaGO
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682e88d3 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8
 a=COk6AnOGAAAA:8 a=PY6Zn8H8AAAA:8 a=EUspDBNiAAAA:8 a=fTclbksgIu1b3d37_U8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Soq9LBFxuPC4vsCAQt-j:22
 a=TjNXssC_j7lpFel5tvFf:22 a=ySS05r0LPNlNiX1MMvNp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220020

From: Can Guo <quic_cang@quicinc.com>

On some platforms, the devfreq OPP freq may be different than the unipro
core clock freq. Implement ufs_qcom_opp_freq_to_clk_freq() and use it to
find the unipro core clk freq.

Fixes: c02fe9e222d1 ("scsi: ufs: qcom: Implement the freq_to_gear_speed() vop")
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Co-developed-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Closes: https://lore.kernel.org/linux-arm-msm/D9FZ9U3AEXW4.1I12FX3YQ3JPW@fairphone.com/
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Tested-by: Loïc Minier <loic.minier@oss.qualcomm.com>

---
V2 -> V3:
1. Skip calling ufs_qcom_opp_freq_to_clk_freq() if freq is ULONG_MAX to avoid
usless error prints.
2. Correct indentation size to follow Linux kernel coding style.

v3 -> v4:
Rebased to 6.15/scsi-queue which the relevant patch applied to.
---
 drivers/ufs/host/ufs-qcom.c | 81 ++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index a97fe8eee27a..0f30f057b870 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -99,7 +99,9 @@ static const struct __ufs_qcom_bw_table {
 };
 
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
-static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, unsigned long freq);
+static unsigned long ufs_qcom_opp_freq_to_clk_freq(struct ufs_hba *hba,
+						   unsigned long freq, char *name);
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up, unsigned long freq);
 
 static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 {
@@ -597,7 +599,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
 			return -EINVAL;
 		}
 
-		err = ufs_qcom_set_core_clk_ctrl(hba, ULONG_MAX);
+		err = ufs_qcom_set_core_clk_ctrl(hba, true, ULONG_MAX);
 		if (err)
 			dev_err(hba->dev, "cfg core clk ctrl failed\n");
 		/*
@@ -1316,29 +1318,46 @@ static int ufs_qcom_set_clk_40ns_cycles(struct ufs_hba *hba,
 	return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES), reg);
 }
 
-static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, unsigned long freq)
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up, unsigned long freq)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct list_head *head = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
 	u32 cycles_in_1us = 0;
 	u32 core_clk_ctrl_reg;
+	unsigned long clk_freq;
 	int err;
 
+	if (hba->use_pm_opp && freq != ULONG_MAX) {
+		clk_freq = ufs_qcom_opp_freq_to_clk_freq(hba, freq, "core_clk_unipro");
+		if (clk_freq) {
+			cycles_in_1us = ceil(clk_freq, HZ_PER_MHZ);
+			goto set_core_clk_ctrl;
+		}
+	}
+
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk) &&
 		    !strcmp(clki->name, "core_clk_unipro")) {
-			if (!clki->max_freq)
+			if (!clki->max_freq) {
 				cycles_in_1us = 150; /* default for backwards compatibility */
-			else if (freq == ULONG_MAX)
+				break;
+			}
+
+			if (freq == ULONG_MAX) {
 				cycles_in_1us = ceil(clki->max_freq, HZ_PER_MHZ);
-			else
-				cycles_in_1us = ceil(freq, HZ_PER_MHZ);
+				break;
+			}
 
+			if (is_scale_up)
+				cycles_in_1us = ceil(clki->max_freq, HZ_PER_MHZ);
+			else
+				cycles_in_1us = ceil(clk_get_rate(clki->clk), HZ_PER_MHZ);
 			break;
 		}
 	}
 
+set_core_clk_ctrl:
 	err = ufshcd_dme_get(hba,
 			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
 			    &core_clk_ctrl_reg);
@@ -1381,7 +1400,7 @@ static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba, unsigned long f
 		return ret;
 	}
 	/* set unipro core clock attributes and clear clock divider */
-	return ufs_qcom_set_core_clk_ctrl(hba, freq);
+	return ufs_qcom_set_core_clk_ctrl(hba, true, freq);
 }
 
 static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
@@ -1413,7 +1432,7 @@ static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
 static int ufs_qcom_clk_scale_down_post_change(struct ufs_hba *hba, unsigned long freq)
 {
 	/* set unipro core clock attributes and clear clock divider */
-	return ufs_qcom_set_core_clk_ctrl(hba, freq);
+	return ufs_qcom_set_core_clk_ctrl(hba, false, freq);
 }
 
 static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
@@ -1878,11 +1897,53 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	return ret;
 }
 
+static unsigned long ufs_qcom_opp_freq_to_clk_freq(struct ufs_hba *hba,
+						   unsigned long freq, char *name)
+{
+	struct ufs_clk_info *clki;
+	struct dev_pm_opp *opp;
+	unsigned long clk_freq;
+	int idx = 0;
+	bool found = false;
+
+	opp = dev_pm_opp_find_freq_exact_indexed(hba->dev, freq, 0, true);
+	if (IS_ERR(opp)) {
+		dev_err(hba->dev, "Failed to find OPP for exact frequency %lu\n", freq);
+		return 0;
+	}
+
+	list_for_each_entry(clki, &hba->clk_list_head, list) {
+		if (!strcmp(clki->name, name)) {
+			found = true;
+			break;
+		}
+
+		idx++;
+	}
+
+	if (!found) {
+		dev_err(hba->dev, "Failed to find clock '%s' in clk list\n", name);
+		dev_pm_opp_put(opp);
+		return 0;
+	}
+
+	clk_freq = dev_pm_opp_get_freq_indexed(opp, idx);
+
+	dev_pm_opp_put(opp);
+
+	return clk_freq;
+}
+
 static u32 ufs_qcom_freq_to_gear_speed(struct ufs_hba *hba, unsigned long freq)
 {
 	u32 gear = UFS_HS_DONT_CHANGE;
+	unsigned long unipro_freq;
+
+	if (!hba->use_pm_opp)
+		return gear;
 
-	switch (freq) {
+	unipro_freq = ufs_qcom_opp_freq_to_clk_freq(hba, freq, "core_clk_unipro");
+	switch (unipro_freq) {
 	case 403000000:
 		gear = UFS_HS_G5;
 		break;
-- 
2.34.1


