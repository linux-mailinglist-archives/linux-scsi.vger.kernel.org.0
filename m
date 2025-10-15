Return-Path: <linux-scsi+bounces-18116-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C261ABDDBE1
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Oct 2025 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 854DD501D86
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Oct 2025 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AB3195EC;
	Wed, 15 Oct 2025 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QOJw+CNv"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FA302CA2;
	Wed, 15 Oct 2025 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519990; cv=none; b=FLlpJUuJEpMw8MpMe7mVlvrFeeuQe/l/lPShj7EWqOEze+HS12nMe9EQeBshKHJcMRf/N/M0rb0wGVde1wlefFq5HDTNyxfKXa3ey175Fz3T5LEQ9vbnRUJ6YgmwiAa7XnIpONaCWrWY1Qk5G32tHaCfO4RbWAH3Hqkojxpf8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519990; c=relaxed/simple;
	bh=zd0Js33uT4qAQsGbVa94/D6bzrHjWGPrzmHI09kg7LA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QkHKhVD/NBhoyKa0gSgLKRbz82Vki7RutSMU2Ryk8cRARfxDLxlafo080fGBCsnZ/sBrM6ENRD1Qu4EGlnmZVNxPvWDafPiUaGv5XAzO3txnjsz7Fs4Hic511nz/NDwYX//vHmTYr39Op12uRQTDxdAPPXFSH+wif2jbzfJTSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QOJw+CNv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sEmR014780;
	Wed, 15 Oct 2025 09:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zd0Js33uT4qAQsGbVa94/D6bzrHjWGPrzmHI09kg7LA=; b=QOJw+CNvy50zjqMC
	IgFfRdlXC5TLoszBj/q8hnGFMTt2O1tI9nzCMXlOETZkn/pjAtrOnhPwnGAnps+i
	3NUAT6LvtWvn4navdjmybHU9U5Zq6DG+ax0rEkH0NbyKBSgG71fk3RrU+U6xqRXI
	+Q94On32Rk8DC7hzpwHQU1HOXUR3d8Uha0nkEKRykCCI5/b77mE486Iu7g7St+C4
	UcsIwB0222EXyTOhg94f7pZ4DtsbmXpAgdi+aO6n3wI/25rlS0glIgSQSUBeWEDn
	ShvkPx/51yU8IgaMJJCCAjeBtC5bbIeX9ZgvoQlS4pcZO6P6IA8oe5iOnabxDQYO
	Tqmm3w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbj3v4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 09:19:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59F9JNTp016333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 09:19:23 GMT
Received: from [10.216.55.200] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Wed, 15 Oct
 2025 02:19:12 -0700
Message-ID: <4bd619e7-e9ca-44a8-9d36-10c18d7a8157@quicinc.com>
Date: Wed, 15 Oct 2025 14:49:08 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add edp reference clock for lemans
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <robin.clark@oss.qualcomm.com>, <lumag@kernel.org>,
        <abhinav.kumar@linux.dev>, <jessica.zhang@oss.qualcomm.com>,
        <sean@poorly.run>, <marijn.suijten@somainline.org>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <quic_mahap@quicinc.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <mani@kernel.org>,
        <James.Bottomley@hansenpartnership.com>, <martin.petersen@oracle.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <quic_vproddut@quicinc.com>
References: <20251013104806.6599-1-quic_riteshk@quicinc.com>
 <7jmk3txdrnit6zn7ufra7davmomggd3graizdu6wqonp3lljza@mfnxt2owpknq>
From: Ritesh Kumar <quic_riteshk@quicinc.com>
In-Reply-To: <7jmk3txdrnit6zn7ufra7davmomggd3graizdu6wqonp3lljza@mfnxt2owpknq>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8VUjADvpBF8S
 kMdccCGoi2LX0d3PplLf45/vynuXKc10l8JtzCzzKGlNx2Y+Bep9yX37ktbVWBMCPvpgIdQB3d1
 vmAwlofGUcdN5HgfYyVU7CrXH+tkp19VEVKEeTWRuZGNLFOGDwJ1Jt24x0R/RE+0ZbeRX8Cn/ka
 RERxGOc3IJJ8arYtXyWRh00F2MFDt3oK1hIB6An6JCXtUXwfPyr+JUwCaMO8MyNOetpUgVJ464u
 Z2dHKe6fdTc2FvWHJ7vvz5QvliqUqITKrq5AoIB1+ksXq1upQ7M3FiNiu20uYWT9G3+3pX9S62h
 uJCK5NRAUki0R4EdGnivAYTi6BAzCleg7H4WJjLif+j2tnw9aNGy2JKs6T88P2J2swL5qUHLEb9
 pyQ9s1ZymTkjl61WWUURf8SKx6r5Lg==
X-Proofpoint-ORIG-GUID: WkUePfu7CdqX9UE-bIRZOgucfbNQ8Sp4
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ef671c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=nQ7leC29giJESoIIZeQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: WkUePfu7CdqX9UE-bIRZOgucfbNQ8Sp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018


On 10/13/2025 6:04 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 13, 2025 at 04:18:03PM +0530, Ritesh Kumar wrote:
> > On lemans chipset, edp reference clock is being voted by ufs mem phy
> > (ufs_mem_phy: phy@1d87000). But after commit 77d2fa54a9457
> > ("scsi: ufs: qcom : Refactor phy_power_on/off calls") edp reference
> > clock is getting turned off, leading to below phy poweron failure on
> > lemans edp phy.
>
> How does UFS turn on eDP reference clock?

In lemans, GCC_EDP_REF_CLKREF_EN is voted as qref clock in ufs_mem_phy.


ufs_mem_phy: phy@1d87000 {
     compatible = "qcom,sa8775p-qmp-ufs-phy";
     reg = <0x0 0x01d87000 0x0 0xe10>;
     /*
      * Yes, GCC_EDP_REF_CLKREF_EN is correct in qref. It
      * enables the CXO clock to eDP *and* UFS PHY.
      */
     clocks = <&rpmhcc RPMH_CXO_CLK>,
              <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
              <&gcc GCC_EDP_REF_CLKREF_EN>;
     clock-names = "ref", "ref_aux", "qref";

>
>

