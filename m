Return-Path: <linux-scsi+bounces-17947-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64CBC7A46
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Oct 2025 09:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FE23E8011
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Oct 2025 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1002D248D;
	Thu,  9 Oct 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n7w7u+Am"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DB2D061A;
	Thu,  9 Oct 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993929; cv=none; b=apmtBYPKrgnLNPHPtx9jPqwFbEAYvm5pGkOVBeP1T/xfcOGJ8nH0Z1U72EOjBMNA9rYRGjUAVTe00Ix7LK6K84IjJsSbvQfmvoelCDWvjC9D0CdLY+P6UvlcSDN8fVT6z8ssm5Ndk6qKqdY3gRiKmxM2mOUS5FWxooz7mt8wq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993929; c=relaxed/simple;
	bh=/q4mIKv3/3dPsSa9scY7FORoQPyA++qDFoLKcBCT3hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LWPyBwVB6KXayp8OfR9HEAtODMDdg0s1SRSwLmo9viNAOcRmJomTExF/AHfxaMmjCy2IkzW2Iw9huy0+6sNF6zOAUmejQKqIVb4ytYus3xNLC8D1I1/qOk8soG528VZGOlnnh8Fil0WWtf+T5KQZe+V1QFc9qs4Md2NJXdDZ9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n7w7u+Am; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EIqw022311;
	Thu, 9 Oct 2025 07:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=FFTkhT2aJu5gM8wwWjcIDP2i1mvv13ALQaJcBz6WE4E=; b=n7
	w7u+Amr3F3L60t65eUhTow4LYQn5ylFpzd+BS04xwIq8kV39pTDVCobos5ITqkxt
	4+x8tI4HqZexjDO9NP2kCnW9vtjqIX6piaAy86jor0+UndM1lkhd/f7IeIEbWvmr
	3MlB1ecPq1+4fwELlzyj//P4/kRSecbSAmoxWRAtteZhkB6FtYw4GauAaGp+N9m0
	1blASBiOnmS1hZsq8itkEhQ/7DXtf1qh1rBrxkT+56NZD5OAk4UPmNyUCin4I6YP
	6hBk7MaqfqUZlIYdFSZo2QXfAZUCAWAkJrizAp2wRwrm5iVaaVVKRlcx4WrszOnP
	KxQkDfld6ZqXVMzB7/bQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4shtwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 07:11:46 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5997Bhfx002157;
	Thu, 9 Oct 2025 07:11:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 49jvnmbgxw-1;
	Thu, 09 Oct 2025 07:11:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5997BgO3002131;
	Thu, 9 Oct 2025 07:11:42 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 5997BgbJ002126;
	Thu, 09 Oct 2025 07:11:42 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id A18105015BB; Thu,  9 Oct 2025 12:41:41 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mahap@quicinc.com, andersson@kernel.org,
        konradybcio@kernel.org, mani@kernel.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        vkoul@kernel.org, kishon@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        quic_vproddut@quicinc.com
Subject: [PATCH 3/5] phy: qcom: edp: Add support for edp reference clock vote
Date: Thu,  9 Oct 2025 12:41:25 +0530
Message-Id: <20251009071127.26026-4-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251009071127.26026-1-quic_riteshk@quicinc.com>
References: <20251009071127.26026-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WwdkvQ1_4klMgVvRXnFHdOC1W75myznO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX16I8Qd3vMz7I
 zMaaG1z0PWWQiiavv9Iz39CXFqXPuKAOv7XEZXknbmdzbIKI9XiOxfQR3l398r6PxYFqO0OOUFd
 1mFteF7O2RjrP8Avo3v/ahg6RVSXp3ZoPMjuRi8/f6nZWj3TxZRjANn88+6kUixaBwzd4nEfEg2
 5trWEi7sS79nj+XZNfETd+2sO9u4ctv+zQ61oYt32U1XMfm4XlzL6dRRYkBl/ztPb7fS5SZtexh
 1Yng0jIyNsMzh1lXdT9Fjb2wfh6v/VqxCKZgnn6U3QNeyZDFAQXGi35R8Lb+OhKCZoptmHHsESG
 tvozvoPaphr/igddCyJ1fqxmjanj1nZZS2D5DS8dGlGAgyxjIpi70ZtrGRHMzZEuYcLOSLoQ1zi
 JHZlik04ur9eQ+z8IP2ECV8HD+52fg==
X-Authority-Analysis: v=2.4 cv=SfL6t/Ru c=1 sm=1 tr=0 ts=68e76033 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=fXK_GqBklnNid1Tqd_YA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: WwdkvQ1_4klMgVvRXnFHdOC1W75myznO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

Commit 77d2fa54a9457 ("scsi: ufs: qcom : Refactor phy_power_on/off
calls") lead to edp reference clock to be turned off, leading to
below phy poweron failure on lemans edp phy.

phy phy-aec2a00.phy.10: phy poweron failed --> -110

edp reference clock is required to be enabled before edp PHY
initialization. This change adds support for voting the clock
from edp phy driver.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index f1b51018683d..b544b5988fa6 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -103,7 +103,7 @@ struct qcom_edp {
 
 	struct phy_configure_opts_dp dp_opts;
 
-	struct clk_bulk_data clks[2];
+	struct clk_bulk_data clks[3];
 	struct regulator_bulk_data supplies[2];
 
 	bool is_edp;
@@ -1094,6 +1094,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
 
 	edp->clks[0].id = "aux";
 	edp->clks[1].id = "cfg_ahb";
+	edp->clks[2].id = "edp_ref";
 	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(edp->clks), edp->clks);
 	if (ret)
 		return ret;
-- 
2.17.1


