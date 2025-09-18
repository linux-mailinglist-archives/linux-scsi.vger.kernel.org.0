Return-Path: <linux-scsi+bounces-15904-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81592B20C08
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Aug 2025 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3934916C8B9
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Aug 2025 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7ED2D2394;
	Mon, 11 Aug 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WMsHkOsr"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF9253954;
	Mon, 11 Aug 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922741; cv=none; b=t7NR+FvkIASoSEmc4wIdPtW0ijSD3MZEAYzSidn7r9ZABKJOT2odEAdztoU2B2iFnkFYRgGlaDXIzvRSTbJMTo0R22ptQYuk9rW6gLMSUFN2XusrlKBtTZIdjZNV0RXtc0eOOoDACsojOzdly6GRPFw5mjiTstTIIOa32PwksNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922741; c=relaxed/simple;
	bh=zMQSzU43geZRqQzfaOUxQiKDR4ywNE1VYOcEEc6W6nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqyaUHBCwCF4x+KMDRvXTFEtBgdmZzm/jEcb1HDuPh/qOAIfblrUv6ATZ6gjEhJ2dDMVyskqYtHdhnSXxWbaJGwfv1D+00nlmV5NBERchm6yG7AGU+RqzwDUeiEo4JbhZXT2QVwFFbGVf38zSKaJPD5CmF4ItNOFcvoYvZhx5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WMsHkOsr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCwq021654;
	Mon, 11 Aug 2025 14:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1FxsZVSU7lmnYgpxflseIwFu8Dhx01Pd+TSdBewQmlw=; b=WMsHkOsrsGzAviPU
	nw9U2Kxr/KEzhn/NfySJprM44DqFGiPiNeMee4s3Rh+XWNpe1S8pD6YC4n7QWf0j
	wHWSkaJ6579zZFov64tQrX6PPK3XxJpIbicBPyVIeCwcFDxg7R0TnBr41uKpbie1
	dj+gLUp4GQjOrAcFBcafRnMeH+RYv+2fplE4Yts+IBj/rA3HajsDFwWfv6purDQT
	+nY+dKPYkiVHFiEtu+edhmSeJ5C2pSXG9OIhu1tvxmHIWaIw+DFsjC6/1ehIowj/
	Jz3ELxLQrW16gCcW10kTMj4Hcx3d0gV12Kcs04MT2NsC2tDGYjrkjpKz4FqTVOn+
	C9CS1Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj44r6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:32:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57BEW36b031954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 14:32:03 GMT
Received: from hu-rdwivedi-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 07:31:58 -0700
From: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
To: <mani@kernel.org>, <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <bvanassche@acm.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <agross@kernel.org>,
        <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/4] dt-bindings: ufs: qcom: Document MCQ register space for UFS
Date: Mon, 11 Aug 2025 20:01:36 +0530
Message-ID: <20250811143139.16422-2-quic_rdwivedi@quicinc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811143139.16422-1-quic_rdwivedi@quicinc.com>
References: <20250811143139.16422-1-quic_rdwivedi@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX8oZCz+c2+0+P
 SJoIaI8JO/fI42bAd/9s8/BW8TNIlPAfDCCxJDmmSG+bZt8wFBAqGI4yqNZyqdr6YQiDMkLYSkl
 fmUsRRgj4SXSjINDS2NLBXpKvX1fMj5cvziehpD4CPWY2ExIlj4/tn7gA1vWrzHljCBLF56J13O
 sb+UWKBTvOmjAAIW112GSL1m3g/xbX4amJ27/XmvqIjuEfINRs+g5AoFVJk3jc8Uc8996um1bpD
 OjesibBeEdYz+GAvOjpQMSDwHOBgt2DxOlqetItuTPgkm7GqPhcGweFwF/w+HmK0VBjx9S/vROA
 /HsBL45S5EdNcZvlrhxCX0OdscZ0mp2DaCAethQ92Y8lP188ssOnhr38exmK8FsNg3Jr8WbqMNW
 TOqRDNAF
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6899fee3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=Y0JeA398hpKOggu2qcoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NCj4S3h1S3FPXxpaGjHtzcWHFSrncJCy
X-Proofpoint-GUID: NCj4S3h1S3FPXxpaGjHtzcWHFSrncJCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

Document Multi-Circular Queue (MCQ) register space for
Qualcomm UFS controllers.

Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml        | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 6c6043d9809e..daf681b0e23b 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -89,9 +89,13 @@ properties:
     maxItems: 2
 
   reg-names:
-    items:
-      - const: std
-      - const: ice
+    oneOf:
+      - items:
+          - const: std
+          - const: ice
+      - items:
+          - const: ufs_mem
+          - const: mcq
 
   required-opps:
     maxItems: 1
@@ -177,9 +181,9 @@ allOf:
             - const: rx_lane1_sync_clk
         reg:
           minItems: 1
-          maxItems: 1
+          maxItems: 2
         reg-names:
-          maxItems: 1
+          maxItems: 2
 
   - if:
       properties:
@@ -280,7 +284,7 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 1
+          maxItems: 2
         clocks:
           minItems: 7
           maxItems: 8
-- 
2.50.1


