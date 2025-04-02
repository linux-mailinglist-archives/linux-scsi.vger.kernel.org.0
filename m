Return-Path: <linux-scsi+bounces-13144-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFCA78DAD
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Apr 2025 14:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A934617105E
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Apr 2025 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC8C23959B;
	Wed,  2 Apr 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PQcJGqfC"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707C23958C;
	Wed,  2 Apr 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595199; cv=none; b=eDMK1mkGAUs3c20ECGQBLLKepRuxoz2q0yWObyO7mwpaqiy7hL8i5gdVx/e/QEa4a3aC8GMdGgc8EWKa1ZHv4zSeTwALngGRGLD9olIcpF8LC8y0T76sK8ganULCk5JRFPQXCfSvcrumDCuekPEafmg//AJfc2zB0WeGwtAXCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595199; c=relaxed/simple;
	bh=4JiVsbykmZPlGme2dQA+hsM0yItlxp9C9iBD8FGv4+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnR6NMDEzsmy86JyF+bmdhkoQcMV/DZ0IdownrOeZWQ59cjc9YUfBdmzyu6sfoEB8Hb+Ow8/0IzDe+7LurB3xjX7/NrJHbvrvgFSRIse9WEjOndr+ZlRRS25sgzJ+k0a6cVm1xq3cnyULKmbrTHT/xjNWG49OtyehQxBial7crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PQcJGqfC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532Bpskc007206;
	Wed, 2 Apr 2025 11:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vn5JtBe5I0QtdmY4FOx/K+4l
	LPY7E+fWNpdJ1ZtHUdc=; b=PQcJGqfCbJ8ytXEsq/ZcHhw67GdTvGjIQObh7WT4
	mS0xvCByIJq9c8+OtNynUU80hsvmAc5r908bfhGMrSmay0cd/acZZsY0C+ZxCEwC
	SWqky3sH0+7ZXAGvyhNYwYIxMbAVzcIH0fmNTYWcS4sL80/vzaag5v+orUziatzu
	csSSfQuoAeM96ZKVWWIJO+eXzQIXcq0ouFbt8+d07+uEQXRsPJBQwoEqmjq+EAAo
	wUoaT/zKMKXYGQ4vkGGAEjpbSGYGa9VGR2UJV7unM13BWz5qrZdGnSfj2whh5GNs
	PiVwPvlByzhDdDyK1yVHXJFB36Y5hbZ8HjtOnBGTZxoOqw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rh7yk6kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 11:59:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532Bxqkl020104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Apr 2025 11:59:52 GMT
Received: from hu-mapa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Apr 2025 04:59:49 -0700
From: Manish Pandey <quic_mapa@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nitirawa@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>
Subject: [PATCH V5 3/3] scsi: ufs-qcom: Add support to dump testbus registers
Date: Wed, 2 Apr 2025 17:29:22 +0530
Message-ID: <20250402115922.27874-4-quic_mapa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250402115922.27874-1-quic_mapa@quicinc.com>
References: <20250402115922.27874-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=IYWHWXqa c=1 sm=1 tr=0 ts=67ed26ba cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=oU32yFmJg_HV1qE5Ry8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: s4IC_8jZsZWjPK7sPAN8rAi_iU7-_d7M
X-Proofpoint-ORIG-GUID: s4IC_8jZsZWjPK7sPAN8rAi_iU7-_d7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_04,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=736
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020075

Add support to dump testbus registers to enhance debugging capabilities
for the Qualcomm UFS Host Controller.

Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 22720ea761d9..d8606776c95f 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -5,6 +5,7 @@
 
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/devfreq.h>
 #include <linux/gpio/consumer.h>
@@ -96,6 +97,24 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_MAX][0][0]		    = { 7643136,	819200 },
 };
 
+static const struct {
+	int nminor;
+	char *prefix;
+} testbus_info[TSTBUS_MAX] = {
+	[TSTBUS_UAWM]     = {32, "TSTBUS_UAWM"},
+	[TSTBUS_UARM]     = {32, "TSTBUS_UARM"},
+	[TSTBUS_TXUC]     = {32, "TSTBUS_TXUC"},
+	[TSTBUS_RXUC]     = {32, "TSTBUS_RXUC"},
+	[TSTBUS_DFC]      = {32, "TSTBUS_DFC"},
+	[TSTBUS_TRLUT]    = {32, "TSTBUS_TRLUT"},
+	[TSTBUS_TMRLUT]   = {32, "TSTBUS_TMRLUT"},
+	[TSTBUS_OCSC]     = {32, "TSTBUS_OCSC"},
+	[TSTBUS_UTP_HCI]  = {32, "TSTBUS_UTP_HCI"},
+	[TSTBUS_COMBINED] = {32, "TSTBUS_COMBINED"},
+	[TSTBUS_WRAPPER]  = {32, "TSTBUS_WRAPPER"},
+	[TSTBUS_UNIPRO]   = {256, "TSTBUS_UNIPRO"},
+};
+
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
 
@@ -1542,6 +1561,32 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
 	return 0;
 }
 
+static void ufs_qcom_dump_testbus(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	int i, j, nminor = 0, testbus_len = 0;
+	u32 *testbus __free(kfree) = NULL;
+	char *prefix;
+
+	testbus = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
+	if (!testbus)
+		return;
+
+	for (j = 0; j < TSTBUS_MAX; j++) {
+		nminor = testbus_info[j].nminor;
+		prefix = testbus_info[j].prefix;
+		host->testbus.select_major = j;
+		testbus_len = nminor * sizeof(u32);
+		for (i = 0; i < nminor; i++) {
+			host->testbus.select_minor = i;
+			ufs_qcom_testbus_config(host);
+			testbus[i] = ufshcd_readl(hba, UFS_TEST_BUS);
+		}
+		print_hex_dump(KERN_ERR, prefix, DUMP_PREFIX_OFFSET,
+				16, 4, testbus, testbus_len, false);
+	}
+}
+
 static void ufs_qcom_dump_mcq_hci_regs(struct ufs_hba *hba)
 {
 	/* voluntarily yield the CPU to prevent CPU hog during data dumps */
@@ -1659,6 +1704,11 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 		/* Dump MCQ Host Vendor Specific Registers */
 		if (hba->mcq_enabled)
 			ufs_qcom_dump_mcq_hci_regs(hba);
+
+		/* voluntarily yield the CPU as we are dumping too much data */
+		ufshcd_dump_regs(hba, UFS_TEST_BUS, 4, "UFS_TEST_BUS ");
+		cond_resched();
+		ufs_qcom_dump_testbus(hba);
 	}
 }
 
-- 
2.17.1


