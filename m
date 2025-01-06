Return-Path: <linux-scsi+bounces-11173-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608AA0244E
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jan 2025 12:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEAC7A2A44
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jan 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F51D5CFA;
	Mon,  6 Jan 2025 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vis9yqCG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E53184F;
	Mon,  6 Jan 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163150; cv=none; b=oue0IzF3qMZIqYb9lWfiJ0Tq06mQUtZyMHg672TwWgeFJHvDGj7EjSCJ21uOM9+awhw5gxLr9PF8/R4KIW88A6NLZpTEmiNYGOt4QLRjq71UEuvBl2JNONRUpNPI4DCddhSs0dZJlPknl5sONk4+n4a5tlZu3cjPFBXbTRmWktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163150; c=relaxed/simple;
	bh=H2JOktb0rjRrq21t28HRGQdGAYY6mRv6/Dfem8dx/Co=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=HJ6qMQuhDMCIW4WvnsKxlbmIgHTsD2mK8aJCUgXkiIb2SVol2Q4wEANmZhTwX4UA615EhPuLSNRlLj54V7q0fz8xrYdN/4IMdWeQeuUv7qCBs+6MfX6RozJ9vealCAmrI4+L/RlJeMCEPH0+WoJboe1Wm7NuUB9bUaDmo8Qmfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vis9yqCG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5068IkgC031247;
	Mon, 6 Jan 2025 11:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xgwfpEzzvoVDicanRV0QFUqMeKg97WGqgkGpaQdR9ro=; b=Vis9yqCGsDrLksgO
	iIocUDpxPQsDu9yw685dngUma9WXW8Ut62HsHC4rkAsrvpUw7BCkdX5EDXZi5aA4
	+bzLG75pOgHpMvYCmyP4vplunvcmGMsrqLaAOu93jB22ltDQHriybAknPxwdcILR
	uLTivt3JGj50mBOL/8cMIzN4DN8XgX6wC+f/7HEqAKV173xSA4iTD3QGtP7V6seT
	qAym7rLszCw5S/ii2bECO8/8/Hm0gnVTUe+61kowWSxKy5V+a10dcdeJD5AOHtNk
	tCw7sV0Rm23bLoY29Bko2IxQbvmHszTXgzOkAZF/6FSLalNTbC+UvWUwOxEVg0tH
	xzm72A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440bj4gdc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 11:32:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 506BW87T022845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 11:32:08 GMT
Received: from [10.218.43.20] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 Jan 2025
 03:32:04 -0800
Message-ID: <959c67c9-fb19-4601-84b7-87503779789d@quicinc.com>
Date: Mon, 6 Jan 2025 17:02:01 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8] scsi: ufs: qcom: Enable UFS Shared ICE Feature
From: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>,
        <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
        <andersson@kernel.org>, <bvanassche@acm.org>, <ebiggers@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naveen Kumar Goud Arepalli
	<quic_narepall@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>
References: <20241224154725.8127-1-quic_rdwivedi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241224154725.8127-1-quic_rdwivedi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q_j_DFP_W9J2qGKs2ccKzJGmNgiuHcVF
X-Proofpoint-ORIG-GUID: q_j_DFP_W9J2qGKs2ccKzJGmNgiuHcVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060101

A Gentle reminder, it’s been almost two weeks!!.


On 24-Dec-24 9:17 PM, Ram Kumar Dwivedi wrote:
> By default, the UFS controller allocates a fixed number of RX
> and TX engines statically. Consequently, when UFS reads are in
> progress, the TX ICE engines remain idle, and vice versa.
> This leads to inefficient utilization of RX and TX engines.
> 
> To address this limitation, enable the UFS shared ICE feature for
> Qualcomm UFS V5.0 and above. This feature utilizes a pool of crypto
> cores for both TX streams (UFS Write – Encryption) and RX streams
> (UFS Read – Decryption). With this approach, crypto cores are
> dynamically allocated to either the RX or TX stream as needed.
> 
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> ---
> Changes from v7:
> 1. Addressed Eric's comment to perform ice configuration only if
>    UFSHCD_CAP_CRYPTO is enabled.
>  
> Changes from v6: 
> 1. Addressed Eric's comment to replace is_ice_config_supported() helper
>    function with a conditional check for UFS_QCOM_CAP_ICE_CONFIG.
> 
> Changes from v5: 
> 1. Addressed Bart's comment to declare the "val" variable with
>    the "static" keyword.
> 
> Changes from v4:
> 1. Addressed Bart's comment to use get_unaligned_le32() instead of
>    bit shifting and to declare val with the const keyword.
> 
> Changes from v3:
> 1. Addressed Bart's comment to change the data type of "config" to u32
>    and "val" to uint8_t.
> 
> Changes from v2:
> 1. Refactored the code to have a single algorithm in the code and
> enabled by default.
> 2. Revised the commit message to incorporate the refactored change.
> 3. Qcom host capabilities are now enabled in a separate function.
> 
> Changes from v1:
> 1. Addressed Rob's and Krzysztof's comment to fix dt binding compilation
>    issue.
> 2. Addressed Rob's comment to enable the nodes in example.
> 3. Addressed Eric's comment to rephrase patch commit description.
>    Used terminology as ICE allocator instead of ICE algorithm.
> 4. Addressed Christophe's comment to align the comment as per kernel doc.
> ---
>  drivers/ufs/host/ufs-qcom.c | 38 ++++++++++++++++++++++++++++++++++
>  drivers/ufs/host/ufs-qcom.h | 41 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 68040b2ab5f8..ffc67b5d5c3e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/time.h>
> +#include <linux/unaligned.h>
>  
>  #include <soc/qcom/ice.h>
>  
> @@ -105,6 +106,26 @@ static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>  }
>  
>  #ifdef CONFIG_SCSI_UFS_CRYPTO
> +/**
> + * ufs_qcom_config_ice_allocator() - ICE core allocator configuration
> + *
> + * @host: pointer to qcom specific variant structure.
> + */
> +static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
> +{
> +	struct ufs_hba *hba = host->hba;
> +	static const uint8_t val[4] = { NUM_RX_R1W0, NUM_TX_R0W1, NUM_RX_R1W1, NUM_TX_R1W1 };
> +	u32 config;
> +
> +	if (!(host->caps & UFS_QCOM_CAP_ICE_CONFIG) ||
> +			!(host->hba->caps & UFSHCD_CAP_CRYPTO))
> +		return;
> +
> +	config = get_unaligned_le32(val);
> +
> +	ufshcd_writel(hba, ICE_ALLOCATOR_TYPE, REG_UFS_MEM_ICE_CONFIG);
> +	ufshcd_writel(hba, config, REG_UFS_MEM_ICE_NUM_CORE);
> +}
>  
>  static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
>  {
> @@ -196,6 +217,11 @@ static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
>  {
>  	return 0;
>  }
> +
> +static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
> +{
> +}
> +
>  #endif
>  
>  static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
> @@ -435,6 +461,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>  		err = ufs_qcom_enable_lane_clks(host);
>  		break;
>  	case POST_CHANGE:
> +		ufs_qcom_config_ice_allocator(host);
> +
>  		/* check if UFS PHY moved from DISABLED to HIBERN8 */
>  		err = ufs_qcom_check_hibern8(hba);
>  		ufs_qcom_enable_hw_clk_gating(hba);
> @@ -932,6 +960,14 @@ static void ufs_qcom_set_host_params(struct ufs_hba *hba)
>  	host_params->hs_tx_gear = host_params->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
>  }
>  
> +static void ufs_qcom_set_host_caps(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	if (host->hw_ver.major >= 0x5)
> +		host->caps |= UFS_QCOM_CAP_ICE_CONFIG;
> +}
> +
>  static void ufs_qcom_set_caps(struct ufs_hba *hba)
>  {
>  	hba->caps |= UFSHCD_CAP_CLK_GATING | UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
> @@ -940,6 +976,8 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
>  	hba->caps |= UFSHCD_CAP_WB_EN;
>  	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
>  	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
> +
> +	ufs_qcom_set_host_caps(hba);
>  }
>  
>  /**
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index b9de170983c9..92e2278b6a54 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -196,7 +196,8 @@ struct ufs_qcom_host {
>  #ifdef CONFIG_SCSI_UFS_CRYPTO
>  	struct qcom_ice *ice;
>  #endif
> -
> +	#define UFS_QCOM_CAP_ICE_CONFIG BIT(0)
> +	u32 caps;
>  	void __iomem *dev_ref_clk_ctrl_mmio;
>  	bool is_dev_ref_clk_enabled;
>  	struct ufs_hw_version hw_ver;
> @@ -226,6 +227,44 @@ ufs_qcom_get_debug_reg_offset(struct ufs_qcom_host *host, u32 reg)
>  	return UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(reg);
>  };
>  
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +
> +/* ICE configuration to share AES engines among TX stream and RX stream */
> +#define ICE_ALLOCATOR_TYPE 2
> +#define REG_UFS_MEM_ICE_CONFIG 0x260C
> +#define REG_UFS_MEM_ICE_NUM_CORE  0x2664
> +
> +
> +/*
> + * Number of cores allocated for RX stream when Read data block received and
> + * Write data block is not in progress
> + */
> +#define NUM_RX_R1W0 28
> +
> +/*
> + * Number of cores allocated for TX stream when Device asked to send write
> + * data block and Read data block is not in progress
> + */
> +#define NUM_TX_R0W1 28
> +
> +/*
> + * Number of cores allocated for RX stream when Read data block received and
> + * Write data block is in progress
> + * OR
> + * Device asked to send write data block and Read data block is in progress
> + */
> +#define NUM_RX_R1W1 15
> +
> +/*
> + * Number of cores allocated for TX stream (UFS write) when Read data block
> + * received and Write data block is in progress
> + * OR
> + * Device asked to send write data block and Read data block is in progress
> + */
> +#define NUM_TX_R1W1 13
> +
> +#endif /* UFS_CRYPTO */
> +
>  #define ufs_qcom_is_link_off(hba) ufshcd_is_link_off(hba)
>  #define ufs_qcom_is_link_active(hba) ufshcd_is_link_active(hba)
>  #define ufs_qcom_is_link_hibern8(hba) ufshcd_is_link_hibern8(hba)


