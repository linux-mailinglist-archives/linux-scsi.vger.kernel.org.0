Return-Path: <linux-scsi+bounces-508-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B074803721
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 15:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56958280E6F
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D95A28DC4
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BT4P047m"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED13ABB;
	Mon,  4 Dec 2023 06:31:54 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4E9SbJ013569;
	Mon, 4 Dec 2023 14:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=xooxlWLKIsvtkrOb642NLu1+Jfd8/ATrNFtubumv2mQ=;
 b=BT4P047mElrWe6Sb+J+COwQH1QLyA29oeuWhkUGHk0ToqdrLA27lUmmXImFaIz9gfYHv
 bEgnwkWgXIdnQZdURYR+DO6pmdVQV/xfT2LWb+xrztPBzKtVWUO0AgkE7rTDApghkwk0
 EmpRLRF8LZKasMLCuMI4K20qeQ+0vP/2w9jCRbZtgb87AmW5/YNVp+5HGvk4nvI+ROB4
 Mto5bupSHc8SUhu7hbe84Fi0TDWb425DOqfXpSLkraYYKzls3C6PyRx3BMep5TKBgZ8x
 18Q4kfE5O/DYQM48d5pIentc0kol1GLy93p9JjslYbvlg3GwmL8lqNmYdfTGp41sAWre Rw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3us8wph87u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 14:31:30 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4EVTNk019498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 14:31:29 GMT
Received: from hu-mnaresh-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 06:31:22 -0800
From: Maramaina Naresh <quic_mnaresh@quicinc.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        <chu.stanley@gmail.com>
CC: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
Subject: [PATCH V2 0/3] Add CPU latency QoS support for ufs driver
Date: Mon, 4 Dec 2023 20:00:58 +0530
Message-ID: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f7xWZ5ltK3HEdBw-zw5Ace9q9ybTauM4
X-Proofpoint-ORIG-GUID: f7xWZ5ltK3HEdBw-zw5Ace9q9ybTauM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_13,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=782 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040108

Add CPU latency QoS support for ufs driver. This improves random io
performance by 15% for ufs.

tiotest benchmark tool io performance results on sm8550 platform:

1. Without PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Read(IPOS)  | 37101.3
	Random Write(IPOS) | 41065.13

2. With PM QoS support
	Type (Speed in)    | Average of 18 iterations
	Random Read(IPOS)  | 42943.4
	Random Write(IPOS) | 46784.9
(Improvement % with PM QoS = ~15%).

This patch is based on below patch by Stanley Chu [1]. 
Moving the PM QoS code to ufshcd.c and making it generic.

[1] https://lore.kernel.org/r/20220623035052.18802-8-stanley.chu@mediatek.com

Changes from v1:
- Addressed bvanassche comments to have the code in core ufshcd
- Design is changed from per-device PM QoS to CPU latency QoS based support
- Reverted existing PM QoS feature from MEDIATEK UFS driver
- Added PM QoS capability for both QCOM and MEDIATEK SoCs

Maramaina Naresh (3):
  ufs: core: Add CPU latency QoS support for ufs driver
  ufs: ufs-mediatek: Enable CPU latency PM QoS support for MEDIATEK SoC
  ufs: ufs-qcom: Enable CPU latency QoS support for QCOM SoC

 drivers/ufs/core/ufshcd-priv.h  |  8 +++++
 drivers/ufs/core/ufshcd.c       | 62 +++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-mediatek.c | 20 ++---------
 drivers/ufs/host/ufs-mediatek.h |  3 --
 drivers/ufs/host/ufs-qcom.c     |  1 +
 include/ufs/ufshcd.h            | 16 +++++++++
 6 files changed, 90 insertions(+), 20 deletions(-)

-- 
2.34.1


