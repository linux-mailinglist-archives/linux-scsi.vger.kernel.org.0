Return-Path: <linux-scsi+bounces-396-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310C8003FE
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 07:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE65F281548
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883EE11710
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EmTDw1yg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAB1726;
	Thu, 30 Nov 2023 21:04:46 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B14xB1o000982;
	Fri, 1 Dec 2023 05:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ZC/earWkqWNkcUV0oq+iV9LAfKxTP8mapb8MzlHxtCk=;
 b=EmTDw1ygQIk422hZtfbXhiRelECZr5rg6eLv0WVy/cJ2TKBeNLv8FqA4NTNnocHw/SCd
 6o3cNGJF+nCpHa2kyZw0JHGEIDxcWRrBOr0FuYF56tnb2PS5GB4WpaiXeICCIYN7yTR+
 m/dd46LI55oGrwLWuocXZYIvJuvs2pl98RMi6GR3/mfQomRAU3GNGZQ6HJrJIpKBSX9f
 X+NBYVi9m22lBqUjmSqS114QW0QK7B+onWUXWZtLbFORwNA+ejb5wsMwRfhcOfWmzqOt
 Zpdpo+hkkLepKyeCdEJq600SjaeEzfSYMdqHGiWuPcrF9AVD5/KWiuXu2HYuIxFFK6pG cg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3upvm1su3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 05:04:06 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B14icuq010891;
	Fri, 1 Dec 2023 05:04:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3unmewu5hx-1;
	Fri, 01 Dec 2023 05:04:05 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1545Ze004609;
	Fri, 1 Dec 2023 05:04:05 GMT
Received: from stor-dylan.qualcomm.com (stor-dylan.qualcomm.com [192.168.140.207])
	by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3B1545VI004597;
	Fri, 01 Dec 2023 05:04:05 +0000
Received: by stor-dylan.qualcomm.com (Postfix, from userid 359480)
	id A6C7B20A73; Thu, 30 Nov 2023 21:04:04 -0800 (PST)
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
Subject: [PATCH v7 07/10] scsi: ufs: ufs-qcom: Check return value of phy_set_mode_ext()
Date: Thu, 30 Nov 2023 21:03:17 -0800
Message-Id: <1701407001-471-8-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4N4QdOsZjC-UO2zg5nPsQFPK7VfPq8fs
X-Proofpoint-GUID: 4N4QdOsZjC-UO2zg5nPsQFPK7VfPq8fs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_02,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010028
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

In ufs_qcom_power_up_sequence(), check return value of phy_set_mode_ext()
and stop proceeding if phy_set_mode_ext() fails.

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 543939c..ee3f07a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -475,7 +475,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		return ret;
 	}
 
-	phy_set_mode_ext(phy, mode, host->phy_gear);
+	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
+	if (ret)
+		goto out_disable_phy;
 
 	/* power on phy - start serdes and phy's power and clocks */
 	ret = phy_power_on(phy);
-- 
2.7.4


