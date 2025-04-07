Return-Path: <linux-scsi+bounces-13253-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD9A7E1D4
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Apr 2025 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38384208D0
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Apr 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EFE1DE4FC;
	Mon,  7 Apr 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SwWlcYL3"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8581DE4DA;
	Mon,  7 Apr 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035702; cv=none; b=NE3+8yXpALMH8a1kPFUMx58rTa9vlMI5jyUkvFj6nXs8mwn1Ihch+T6uEd2nQBdJayFaigVK77S/E52rPakqMgoQp6oojC2Q9nAhH6WvmMMn6tFSBl1Wnx+b+bOMaaZKxptqz8Su4UT76l196hTE9bzLTuEMKHZwfii9yhdVxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035702; c=relaxed/simple;
	bh=3yqdxfN8mBE/0Isqq5N0IafS5lYEEcmxfFTObL8gLB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVahf4kUJqUA8GyGFidZNpN9nMFp9eFqppzMAL0Eei0uQcLyKTQq9TtuVqj8ygpOBpuGeqf82WeStU+scEdW8V0uN/zjDP2JtycuSUDHYdfdLgTOigQxcdycnpq7rgnUgxHSvE9q3x/Mrm5lueIC2h/AfLygA3Qak8fAMji1LIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SwWlcYL3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dnOK009248;
	Mon, 7 Apr 2025 14:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zmFdUop9JRXRGeCW1vcmGM8I
	mpPSKGBJ0ajOqtj2q0U=; b=SwWlcYL3ZRKqtQcNBQ/RRo3QSKZT1/qwZdbSAcIs
	f5Lfa+D+eduSygwQqzmVY8OnBmYU6ZygJ347NWpTgnZn0rTNjixvw+udI5k0jjeG
	FQtynQHM222ZLQNR+73ILmfdk/RplybWJpn5cP4Y7DdVezxmYlym99GRDR53Qq7l
	d9b+ICNEX7ETO1sx0efdd89uHaJjde9lgPlUqPQF/7nTblww4LfVicCFrgAftHPW
	rptIiqVTfx29vmmL7NXa4mJ/lzuiPKruYuljn/pGW57wFTu9PoRdYuX8q+denImH
	U8VzhoFPbV8qQeN0Cz6qazOERX7DWY7qTldxaZ+hSnqDTQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbucg44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 14:21:35 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 537ELYcX026448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 7 Apr 2025 14:21:34 GMT
Received: from hu-mapa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Apr 2025 07:21:31 -0700
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
Subject: [PATCH V6 3/3] scsi: ufs-qcom: Add support to dump testbus registers
Date: Mon, 7 Apr 2025 19:51:10 +0530
Message-ID: <20250407142110.16925-4-quic_mapa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250407142110.16925-1-quic_mapa@quicinc.com>
References: <20250407142110.16925-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: waBTlqCZDqnT5GIec2I6RY_3XQjiCYpY
X-Proofpoint-ORIG-GUID: waBTlqCZDqnT5GIec2I6RY_3XQjiCYpY
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f3df6f cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=oU32yFmJg_HV1qE5Ry8A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=732 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070101

Add support to dump testbus registers to enhance debugging capabilities
for the Qualcomm UFS Host Controller.

Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3a8eac62967e..f9868a240430 100644
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
 
@@ -1565,6 +1584,32 @@ int ufs_qcom_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
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
@@ -1682,6 +1727,11 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
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


