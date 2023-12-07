Return-Path: <linux-scsi+bounces-684-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE5808372
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 09:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2621C20E6A
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91231739
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TgWQ86Sk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E65BC6;
	Thu,  7 Dec 2023 00:42:08 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B76ZReY028237;
	Thu, 7 Dec 2023 08:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rSh9gO+7aiqSoK8Q0lTevNd0WDRcePzWVmY+H4lC+2s=;
 b=TgWQ86Skox2ngP92/AHRjO6uGQri+nVsQT60Co7ZCF9RcnBWT6G5CPjfhh4wtwzflKiw
 5ourggAIvgApMYg1d1qBiyFrUkv8l3ZnQ5liV8oXKZWwHUTE8TG6ROb5+KAk0nk6e+UH
 IAvxgwlurW7t+IZit5W9DtfXGa6ZdZED2X/IPCOJnZ3cVrrEqguQjY0DerdX/WP4c4Dh
 2Pqn88qktg/VbBMqwcX+q3G0N/6TsJxkfBTsZRIEHqFgD97I7FIVRplTJ9ojbB729sHu
 NTuGTu9csAhDNgz2poFwcajygeksG2h7kyUnW1o3eSCFXZoeOXkSCpraJsI8iRzoBqnV cQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu0w514dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 08:41:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B78frKl003843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 08:41:53 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 00:41:47 -0800
Message-ID: <4819834c-b861-a507-8d6c-94a05760a03d@quicinc.com>
Date: Thu, 7 Dec 2023 14:11:43 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v8 08/10] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Content-Language: en-US
To: Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>, <mani@kernel.org>,
        <adrian.hunter@intel.com>, <vkoul@kernel.org>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Bao D.
 Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list
	<linux-kernel@vger.kernel.org>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
 <1701520577-31163-9-git-send-email-quic_cang@quicinc.com>
From: Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1701520577-31163-9-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7hIEbJMi7CCPYkmSsF6w3a_9GmidTbVt
X-Proofpoint-ORIG-GUID: 7hIEbJMi7CCPYkmSsF6w3a_9GmidTbVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070069



On 12/2/2023 6:06 PM, Can Guo wrote:
> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> 
> Start from HW ver 5, a spare register in UFS host controller is added and
> used to indicate the UFS device version. The spare register is populated by
> bootloader for now, but in future it will be populated by HW automatically
> during link startup with its best efforts in any boot stage prior to Linux.
> 
> During host driver init, read the spare register, if it is not populated
> with a UFS device version, go ahead with the dual init mechanism. If a UFS
> device version is in there, use the UFS device version together with host
> controller's HW version to decide the proper PHY gear which should be used
> to configure the UFS PHY without going through the second init.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
> 
> v7 -> v8:
> Fixed a BUG introduced from v6 -> v7. The spare register is added since HW ver 5, hence exclude HW ver == 4.
> 
> ---
>   drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++-------
>   drivers/ufs/host/ufs-qcom.h |  4 ++++
>   2 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ee3f07a..968a4c0 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1065,17 +1065,38 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>   static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
>   {
>   	struct ufs_host_params *host_params = &host->host_params;
> +	u32 val, dev_major;
>   
>   	host->phy_gear = host_params->hs_tx_gear;
>   
> -	/*
> -	 * For controllers whose major HW version is < 4, power up the PHY using
> -	 * minimum supported gear (UFS_HS_G2). Switching to max gear will be
> -	 * performed during reinit if supported. For newer controllers, whose
> -	 * major HW version is >= 4, power up the PHY using max supported gear.
> -	 */
> -	if (host->hw_ver.major < 0x4)
> +	if (host->hw_ver.major < 0x4) {
> +		/*
> +		 * For controllers whose major HW version is < 4, power up the
> +		 * PHY using minimum supported gear (UFS_HS_G2). Switching to
> +		 * max gear will be performed during reinit if supported.
> +		 * For newer controllers, whose major HW version is >= 4, power
> +		 * up the PHY using max supported gear.
> +		 */
>   		host->phy_gear = UFS_HS_G2;
> +	} else if (host->hw_ver.major >= 0x5) {
> +		val = ufshcd_readl(host->hba, REG_UFS_DEBUG_SPARE_CFG);
> +		dev_major = FIELD_GET(UFS_DEV_VER_MAJOR_MASK, val);
> +
> +		/*
> +		 * Since the UFS device version is populated, let's remove the
> +		 * REINIT quirk as the negotiated gear won't change during boot.
> +		 * So there is no need to do reinit.
> +		 */
> +		if (dev_major != 0x0)
> +			host->hba->quirks &= ~UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
> +
> +		/*
> +		 * For UFS 3.1 device and older, power up the PHY using HS-G4
> +		 * PHY gear to save power.
> +		 */
> +		if (dev_major > 0x0 && dev_major < 0x4)
> +			host->phy_gear = UFS_HS_G4;
> +	}
>   }
>   
>   static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 11419eb..32e51d9 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -23,6 +23,8 @@
>   #define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
>   #define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
>   
> +#define UFS_DEV_VER_MAJOR_MASK	GENMASK(7, 4)
> +
>   /* vendor specific pre-defined parameters */
>   #define SLOW 1
>   #define FAST 2
> @@ -54,6 +56,8 @@ enum {
>   	UFS_AH8_CFG				= 0xFC,
>   
>   	REG_UFS_CFG3				= 0x271C,
> +
> +	REG_UFS_DEBUG_SPARE_CFG			= 0x284C,
>   };
>   
>   /* QCOM UFS host controller vendor specific debug registers */

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>

