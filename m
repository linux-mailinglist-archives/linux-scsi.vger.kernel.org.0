Return-Path: <linux-scsi+bounces-12129-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B711FA2E885
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 11:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52B0188686F
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2025 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43341DE8A6;
	Mon, 10 Feb 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D0iP4sCb"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6691D54FA;
	Mon, 10 Feb 2025 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181774; cv=none; b=KPLxTKW0oZDbHs6es749VZkDO1jxKZ0iEMJipPvrZ4gjNd6d1Xtq+wUpoFBT/8xUAOQhVvFd15uMvC0aoYpqi/bHwGfI0EyK9CsnBPdMgVZQMeZkocXptVDDT2LiUaBeOp+RRy7uQQmLgINh5mwBPNAsDN2LxErn0/huILW9hdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181774; c=relaxed/simple;
	bh=cTFaOIJniykaGDY/+UyOqHlkVuqEvcqJ/CZUMVFEYQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHtOVeiaEZCeRRLyzPnbQARtJnxuLokIlv4/WtVJgX2XEnxAenUDHyFS7nnjv+ZV6+aLzzUgkSXabuJiQFK2KcIzM8yKb1l95SI5r3PSpRF+gkArSFBqkNpPvM5AVfopSiio/LdRP/qQgwKTyymrgu/t4WWI5RssYzn4qpb5R5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D0iP4sCb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A8esDJ006121;
	Mon, 10 Feb 2025 10:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AzsTl9U1T91
	j6lhrlPqAzKkmFqMYsFGyOla9k9gsW5E=; b=D0iP4sCb+/zOJfaVJtKHWkxA62+
	ZksFhMEEZ3ub1h0iReASGlGYJp+I7bhpRkVuHM6SSrJKIx07MD7mm8RZzuh4rvSN
	Zhe4IkyDcMcGbbNcTzCiWnvAK0SPGMMho7i0f4jCFZws+tm50mbmB8jB7VD1+UU4
	cSg3or9YAk5uEL6y1hDONDIv1mlydMf/6jX5jQ2gZ4YJtw+5NRuYVt2+qtwzV0A/
	EN+v6dfwTwA/6qc4GtK+LaP0yfZ4qxe6aCV2jEo6aEvm63YV0aW5cy3NkOcycpnu
	KBejzmZb1mN/FUxOLZvZklZ0fTNKAm4XuZIxHHjjwk754gqax3IZRy8u8yw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe5mr8es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:02:34 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 51AA2VX4011397;
	Mon, 10 Feb 2025 10:02:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 44p0bkhyjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:02:31 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51AA2GhM011330;
	Mon, 10 Feb 2025 10:02:31 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 51AA2U5a011391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 10:02:31 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 393357)
	id E828240BF7; Mon, 10 Feb 2025 18:02:29 +0800 (CST)
From: Ziqi Chen <quic_ziqichen@quicinc.com>
To: quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Eric Biggers <ebiggers@google.com>, Minwoo Im <minwoo.im@samsung.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/8] scsi: ufs: core: Add a vop to map clock frequency to gear speed
Date: Mon, 10 Feb 2025 18:02:06 +0800
Message-Id: <20250210100212.855127-4-quic_ziqichen@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210100212.855127-1-quic_ziqichen@quicinc.com>
References: <20250210100212.855127-1-quic_ziqichen@quicinc.com>
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
X-Proofpoint-GUID: 4967QLHuataWq97NPQO_uzdjAxAsCPTg
X-Proofpoint-ORIG-GUID: 4967QLHuataWq97NPQO_uzdjAxAsCPTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_05,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100084

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
v2 ->v3:
1. Remove the parameter 'gear' and use it as function return result.
2. Change "vops" into "vop" in commit message.
---
 drivers/ufs/core/ufshcd-priv.h | 8 ++++++++
 include/ufs/ufshcd.h           | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 0549b65f71ed..4da3e65c6735 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -277,6 +277,14 @@ static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_vops_freq_to_gear_speed(struct ufs_hba *hba, unsigned long freq)
+{
+	if (hba->vops && hba->vops->freq_to_gear_speed)
+		return hba->vops->freq_to_gear_speed(hba, freq);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index f51d425696e7..cdb853f5b871 100644
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
+	int (*freq_to_gear_speed)(struct ufs_hba *hba, unsigned long freq);
 };
 
 /* clock gating state  */
-- 
2.34.1


