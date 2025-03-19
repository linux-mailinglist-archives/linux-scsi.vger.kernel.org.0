Return-Path: <linux-scsi+bounces-12965-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709AAA6851C
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Mar 2025 07:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3AC3BD7C6
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Mar 2025 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82E2505B6;
	Wed, 19 Mar 2025 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XPbmWe0b"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8722500BC;
	Wed, 19 Mar 2025 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742365873; cv=none; b=LmpYC7kP1fuFU9Eu0+tNjyn/ctMNdjkcoQOVvXgJbuyHwTyoVBBf06ffpEWe9TKmKY90Xp5vecOLB1whNeqOxtyMFI3nGN8D9mWKL0APqzApnGKXCrApqKXC/cfLZ02O/A/Y00WVuBiSQEHtfWexCi28S4ml33jcGqF+1kFH5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742365873; c=relaxed/simple;
	bh=o9jaXD66cuF8hfdU1XeCS+n8m2ZVaPtU5+g7+bHXZ6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/p0Lw/HFyOOFBzQg8mgFiz20CXQwX1q9PM/8ekkgULONz3ybGtFpzIBgR8Vejdng2LEuCmH89iOXHspgugMf+YtNt/N+ZRRljnYG+875K6814i6nx+VlVDcTbTOxD1T9DIdE2bLZF71rHvCsz5zg18M0f51J0TguFII+T34rrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XPbmWe0b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4mDMe004934;
	Wed, 19 Mar 2025 06:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XweLUXcVnctQJF0uY6kt0k4+
	E4i3sk/knyFu4yCjhM8=; b=XPbmWe0bucSRKwrfAs8fhbuBFTrlE4qSrOmJGjwP
	TRZMvEpohezCIV2yUgDKxSphEH+GIcFNnYRHEU3EjmZp+Ng+2MT6+ZUDjCmQNy2j
	+9tlYMV4oOrYxktL2CBw9s1o6FcMbKAKYYVO3XrWyYHDl+drKo5AQcfCt4E11sq1
	c+OdnMVwiP9kcOQzQSN70vcvOGq8q5klrj+HDkYdhTpq3WBGAq0r+sVTYC0ZdVLk
	v+ZxgW4vwjuMvvYSCFYvK/ii12vf1j7vCJxzIqCUv1ndFnCzCa4D802XrNYijVvf
	WFv43x9n9pe/zhEPSWbI40dOCd0+7f/CGHEcqQmCHXeNTQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwx48jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 06:31:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52J6V6v0021716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 06:31:06 GMT
Received: from hu-mapa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Mar 2025 23:31:03 -0700
From: Manish Pandey <quic_mapa@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_nitirawa@quicinc.com>,
        <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>
Subject: [PATCH V4 3/3] scsi: ufs-qcom: Add support to dump testbus registers
Date: Wed, 19 Mar 2025 12:00:43 +0530
Message-ID: <20250319063043.15236-4-quic_mapa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319063043.15236-1-quic_mapa@quicinc.com>
References: <20250319063043.15236-1-quic_mapa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 92edRufQxlUU5nD_z0VlN1jqGsBFsVKJ
X-Authority-Analysis: v=2.4 cv=INICChvG c=1 sm=1 tr=0 ts=67da64aa cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=oU32yFmJg_HV1qE5Ry8A:9 a=4N01sYDrZpogBGng4wqm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 92edRufQxlUU5nD_z0VlN1jqGsBFsVKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=738 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190043

Add support to dump testbus registers to enhance debugging capabilities
for the Qualcomm UFS Host Controller.

Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index fc9e8d0ddc92..85043db89b8c 100644
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
 	/* sleep intermittently to prevent CPU hog during data dumps. */
@@ -1659,6 +1704,11 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 		/* Dump MCQ Host Vendor Specific Registers */
 		if (hba->mcq_enabled)
 			ufs_qcom_dump_mcq_hci_regs(hba);
+
+		/* sleep a bit intermittently as we are dumping too much data */
+		ufshcd_dump_regs(hba, UFS_TEST_BUS, 4, "UFS_TEST_BUS ");
+		usleep_range(1000, 1100);
+		ufs_qcom_dump_testbus(hba);
 	}
 }
 
-- 
2.17.1


