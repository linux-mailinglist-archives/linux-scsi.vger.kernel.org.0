Return-Path: <linux-scsi+bounces-13358-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD0A84DDF
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Apr 2025 22:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63B19C0C83
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Apr 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B74928F959;
	Thu, 10 Apr 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJCxT2AG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D852900B3
	for <linux-scsi@vger.kernel.org>; Thu, 10 Apr 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315512; cv=none; b=O1KsVfGJYIYWkNZEBSJXJ/P2txZRDkvH2NgjRj9lx9QrqNG4d1OCw8j2ONbNMOO+V9KE7xWDGKQG/xi+NuDUXsrP8ZOryoNdaRp75GXTGbdPTToGio8R8RE1zJIpQe9S1GSwQaqMDoKl2s8PtZQ05ZGIlEHmf9Rw3Z7ratg9yFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315512; c=relaxed/simple;
	bh=UF6uFxhhpLDKtUrY3ht+7nQtiQu0sMUFMtx5ki3iz44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NANabzEFHvcD+TA/WLzhYBOB5nDr3ilLyg1JaIPbMmlReRrimLeNLrTblBCmdC8UXdXnVJYhKV88c4bzZn0wuLfRzRESHaZ/HaSuy4A0QfG+dO3aVr7kotu7x6r2DsT7XLkC/ALTCym7LBRI1fa+XAJmyXR0ZV6ecmGYiCKnQBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJCxT2AG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG2Gjq030686
	for <linux-scsi@vger.kernel.org>; Thu, 10 Apr 2025 20:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NDLAEun4AR3emOcXFOyfcWJY
	bo2wswXjIw76iL0ScI0=; b=PJCxT2AGW/leA1rf3fgN95tuljrzlv2PD/2LAeZ3
	4lcRsVwWwVQgkGLNC8UqAkaq95QQWzXmdbdkwxpYrD+28gVEzKRy7kJwc2PgcV5R
	ymss5be5CJAWt3rstQo5SyLz1B49HUn+suXw3jcGAZJA9AMXttMEVrGVGG6f3EFx
	hjg+SjdSvX+0+cgFFbCZxvo6aUBUxQ9MujAbvxjLwV3E1C9BNhnYSt+XWc4bO7v2
	GXwcVmaW6gW896+h5zJPupIyiCoNK0TDkfBMTA1RhOVRyBxJLW7hPoq3hRRU0dyz
	7yUXlEVRLOImJuBuN7N1RmE4BBgzehzi1wgk8RQiBha2lw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftr06w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-scsi@vger.kernel.org>; Thu, 10 Apr 2025 20:05:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5c77aff55so297828785a.3
        for <linux-scsi@vger.kernel.org>; Thu, 10 Apr 2025 13:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744315509; x=1744920309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDLAEun4AR3emOcXFOyfcWJYbo2wswXjIw76iL0ScI0=;
        b=k8TJlGbjACdpA8OdPj14sWJ8zriu1+ft5mcB2t73GPRi6wurau0vQJRNcopJMc+vM2
         hFya7FsJ37d0DCyAlQ309wJON21pVWDD3uRpFzkAloHhd1VKPkPxLV3D2mI3FiH0P5/y
         C/HdVhzmgpZyo/Eu3aucQRs+QPFVfcHiuWhB5V/waQXWaJ45YXgac5anSOSSM2nCeFzo
         C6fk7mrVst+R8ocXiv5DV71+vul3Q4pNWvLN71i7rCcVTmOFTef7wcS6Dq0el0PfHSmW
         CqF7ybMjd8Bn3zAtD39KRXSTDb+D1EoFmsxRr2+6zqB1HFCnlV7DooxoXKwxkbUwg9XX
         CaSA==
X-Forwarded-Encrypted: i=1; AJvYcCUabyWdoLPJIhQ74uhvX1iQJ739Xt3k1pzNz5Arn1oJFSKLZK1tB3sKQmEqMPOTyzrSfpkBizhkQ0Om@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2Hn4UjcPT/NCDCwmN1Ko4rgyc1ACOfjrv1kKTIYTmcSttgQQ
	8U8MsMxneyFAZ4Gymh2hN9p2BuT/r3Lg+u/NLR/f8Oep2XWPGI3MSaYUcrRzRttq7IzrkIhpYzV
	gKHU2gZ7ICGiKTPPnUu04Vl9IxymIG0eP0AbS2Lthd8oIzg4ZVRYPhsZjWcIU
X-Gm-Gg: ASbGncvapOCsp9NaGrfZCKJBHvKDbVKtouxuw3D0RiQE/uUas9O4pPzeDmD0xKkGlbe
	gIgs8Oj9AkmX1pSiaKbeEx2acH1bvo5HxEvK/uQIjDYiJ47DyWtjabeCrI5VULkbnjCw1r2H2yT
	LZrFn1u0lX0449Ugmn5iYv6m3CiBlG6D+0du8ynpz7A/aSFJthYMqDW/YDoHZ9rBQrw9y+RyEg7
	X95Oa7Vha/mv5rNe6JEK95jNt3sQxUeRrzT5fWmxcBo1WhoL1pkKOrGGNnKq2HLAqgV8pNg1j2U
	lwsoczNWJrvAwDRL4Z9wPeyRY2BF+Ddkp6XwHw9PXIPpByMeNTvGGkccFYm2MI0jp8vYpOx1c/U
	=
X-Received: by 2002:a05:620a:4001:b0:7c7:a5f5:5616 with SMTP id af79cd13be357-7c7af1d8653mr37248485a.42.1744315508743;
        Thu, 10 Apr 2025 13:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf+JpGVMSFzujCZW07L8EOj0/xyefs1ZkEaUKfid0MPMMwiHP/7FdGXBKdlU2vY59OqEnIcg==
X-Received: by 2002:a05:620a:4001:b0:7c7:a5f5:5616 with SMTP id af79cd13be357-7c7af1d8653mr37244685a.42.1744315508317;
        Thu, 10 Apr 2025 13:05:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d12311asm239157e87.2.2025.04.10.13.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 13:05:07 -0700 (PDT)
Date: Thu, 10 Apr 2025 23:05:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, manivannan.sadhasivam@linaro.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        bvanassche@acm.org, bjorande@quicinc.com, neil.armstrong@linaro.org,
        konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH V3 0/9] Refactor phy powerup sequence
Message-ID: <zzfffzclcftivaaffri6ucupyh3u5dfy7uctgw6xgid2vucusx@x542fel3qkeg>
References: <20250410090102.20781-1-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410090102.20781-1-quic_nitirawa@quicinc.com>
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f82476 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=BPZSipMUsAf8-dKi_Y8A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: l_dBZFUS2IgwswEtS0twlE8rRzssg4_-
X-Proofpoint-ORIG-GUID: l_dBZFUS2IgwswEtS0twlE8rRzssg4_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=442
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100145

On Thu, Apr 10, 2025 at 02:30:53PM +0530, Nitin Rawat wrote:
> In Current code regulators enable, clks enable, calibrating UFS PHY,
> start_serdes and polling PCS_ready_status are part of phy_power_on.
> 
> UFS PHY registers are retained after power collapse, meaning calibrating
> UFS PHY, start_serdes and polling PCS_ready_status can be done only when
> hba is powered_on, and not needed every time when phy_power_on is called
> during resume. Hence keep the code which enables PHY's regulators & clks
> in phy_power_on and move the rest steps into phy_calibrate function.
> 
> Since phy_power_on is separated out from phy calibrate, make separate calls
> to phy_power_on and phy_calibrate calls from ufs qcom driver.
> 
> Also for better power saving, remove the phy_power_on/off calls from
> resume/suspend path and put them to ufs_qcom_setup_clocks, so that
> PHY's regulators & clks can be turned on/off along with UFS's clocks.

Please add an explicit note that patch1 is a requirement for the rest of
the PHY patches. It might make sense to merge it through the PHY tree
too (or to use an immutable branch).

> 
> This patch series is tested on SM8550 QRD, SM8650 MTP , SM8750 MTP.
> 

-- 
With best wishes
Dmitry

