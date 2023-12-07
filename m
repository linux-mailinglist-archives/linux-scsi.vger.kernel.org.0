Return-Path: <linux-scsi+bounces-690-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D185A8087E0
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 13:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DA01C20318
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A60D3D0A2
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CBNA1wsf"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7A10C2;
	Thu,  7 Dec 2023 03:27:41 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B76pfEm032475;
	Thu, 7 Dec 2023 11:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n2YTQb/UjP+pwK7iKBnIiq6r4mjJpw9TcnxON9yKqZI=;
 b=CBNA1wsfQFXYzkKI5EzKfFqx/vU+HFKGOXAGhbWrl6GvoZHU+Ghl2nG4viv2LB+BUTm+
 amu2K5bIcsZeKLZdO/qdYIIwSNLfU4inc0UgRSVuVAus8UlI2beFy7epEe8xen0kCduL
 9L60wdGZ/8jENO7khGD+4PqQJANO6y1dRrNXUzcurzDrspBJV91sBnlaCCsmgr1wBDFv
 JCr1Qysc7N6hkzgg79Vv9OToS3pL/TfqDiAixsNra94v4znHoNpm6UD+YI1e1fZbtW4e
 otUIiJiaeZzrTvsGHtjTK6JlcyWPJsKcamqmDw0TFmOwaCX9HzdJlMYVxwDTt+G29o80 AQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utuhfaerd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 11:27:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7BRNoc002597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 11:27:23 GMT
Received: from [10.218.37.200] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 03:26:47 -0800
Message-ID: <090f3c8c-bbd8-4036-aaa1-d18c7a854ee9@quicinc.com>
Date: Thu, 7 Dec 2023 16:56:44 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Andy
 Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        <chu.stanley@gmail.com>, Alim
 Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van
 Assche <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, Nitin Rawat
	<quic_nitirawa@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
 <20231206152646.GH12802@thinkpad>
From: Naresh Maramaina <quic_mnaresh@quicinc.com>
In-Reply-To: <20231206152646.GH12802@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3wlcbkcRaHNdlTi71SETI-ottmSdZcja
X-Proofpoint-GUID: 3wlcbkcRaHNdlTi71SETI-ottmSdZcja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070093



On 12/6/2023 8:56 PM, Manivannan Sadhasivam wrote:
> On Mon, Dec 04, 2023 at 08:00:59PM +0530, Maramaina Naresh wrote:
>> Register ufs driver to CPU latency PM QoS framework can improves
>> ufs device random io performance.
>>
>> PM QoS initialization will insert new QoS request into the CPU
>> latency QoS list with the maximum latency PM_QOS_DEFAULT_VALUE
>> value.
>>
>> UFS driver will vote for performance mode on scale up and power
>> save mode for scale down.
>>
>> If clock scaling feature is not enabled then voting will be based
>> on clock on or off condition.
>>
>> tiotest benchmark tool io performance results on sm8550 platform:
>>
>> 1. Without PM QoS support
>> 	Type (Speed in)    | Average of 18 iterations
>> 	Random Write(IPOS) | 41065.13
>> 	Random Read(IPOS)  | 37101.3
>>
>> 2. With PM QoS support
>> 	Type (Speed in)    | Average of 18 iterations
>> 	Random Write(IPOS) | 46784.9
>> 	Random Read(IPOS)  | 42943.4
>> (Improvement % with PM QoS = ~15%).
>>
>> Co-developed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
>> ---
>>   drivers/ufs/core/ufshcd-priv.h |  8 +++++
>>   drivers/ufs/core/ufshcd.c      | 62 ++++++++++++++++++++++++++++++++++
>>   include/ufs/ufshcd.h           | 16 +++++++++
>>   3 files changed, 86 insertions(+)
>>
>> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
>> index f42d99ce5bf1..536805f6c4e1 100644
>> --- a/drivers/ufs/core/ufshcd-priv.h
>> +++ b/drivers/ufs/core/ufshcd-priv.h
>> @@ -241,6 +241,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>>   		hba->vops->config_scaling_param(hba, p, data);
>>   }
>>   
>> +static inline u32 ufshcd_vops_config_qos_vote(struct ufs_hba *hba)
>> +{
>> +	if (hba->vops && hba->vops->config_qos_vote)
>> +		return hba->vops->config_qos_vote(hba);
> 
> Please remove this callback as Bart noted.
> 

Sure Mani, will takecare of this comment.

>> +
>> +	return UFSHCD_QOS_DEFAULT_VOTE;
>> +}
>> +
>>   static inline void ufshcd_vops_reinit_notify(struct ufs_hba *hba)
>>   {
>>   	if (hba->vops && hba->vops->reinit_notify)
>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index ae9936fc6ffb..13370febd2b5 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -1001,6 +1001,20 @@ static bool ufshcd_is_unipro_pa_params_tuning_req(struct ufs_hba *hba)
>>   	return ufshcd_get_local_unipro_ver(hba) < UFS_UNIPRO_VER_1_6;
>>   }
>>   
>> +/**
>> + * ufshcd_pm_qos_perf - vote for PM QoS performance or power save mode
> 
> ufshcd_pm_qos_update() - Update PM QoS request
> 

Sure Mani, will takecare of this comment.

>> + * @hba: per adapter instance
>> + * @on: If True, vote for perf PM QoS mode otherwise power save mode
>> + */
>> +static void ufshcd_pm_qos_perf(struct ufs_hba *hba, bool on)
>> +{
>> +	if (!hba->pm_qos_init)
>> +		return;
>> +
>> +	cpu_latency_qos_update_request(&hba->pm_qos_req, on ? hba->qos_vote
>> +							: PM_QOS_DEFAULT_VALUE);
>> +}
>> +
>>   /**
>>    * ufshcd_set_clk_freq - set UFS controller clock frequencies
>>    * @hba: per adapter instance
>> @@ -1153,6 +1167,10 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
>>   	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
>>   			(scale_up ? "up" : "down"),
>>   			ktime_to_us(ktime_sub(ktime_get(), start)), ret);
>> +
>> +	if (!ret)
>> +		ufshcd_pm_qos_perf(hba, scale_up);
> 
> Can't you just move this before trace_ufshcd_profile_clk_scaling()? This also
> avoids checking for !ret.
> 

In this case, we need to use goto out; inside if(ret) of 
ufshcd_vops_clk_scale_notify.
will do the above change, to enable ufshcd_pm_qos_perf before the out flag.

>> +
>>   	return ret;
>>   }
>>   
>> @@ -9204,6 +9222,8 @@ static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on)
>>   	if (ret)
>>   		return ret;
>>   
>> +	if (!ufshcd_is_clkscaling_supported(hba))
>> +		ufshcd_pm_qos_perf(hba, on);
>>   out:
>>   	if (ret) {
>>   		list_for_each_entry(clki, head, list) {
>> @@ -9296,6 +9316,45 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
>>   	return ret;
>>   }
>>   
>> +/**
>> + * ufshcd_pm_qos_init - initialize PM QoS instance
> 
> "Initialize PM QoS request"
> 

Sure Mani, will takecare of this comment.

>> + * @hba: per adapter instance
>> + */
>> +static void ufshcd_pm_qos_init(struct ufs_hba *hba)
>> +{
>> +	if (!(hba->caps & UFSHCD_CAP_PM_QOS))
>> +		return;
>> +
>> +	/*
>> +	 * called to configure PM QoS vote value for UFS host,
>> +	 * expecting qos vote return value from caller else
>> +	 * default vote value will be return.
>> +	 */
>> +	hba->qos_vote = ufshcd_vops_config_qos_vote(hba);
> 
> No need of this variable too if you get rid of the callback.
> 
>> +	cpu_latency_qos_add_request(&hba->pm_qos_req,
>> +					PM_QOS_DEFAULT_VALUE);
>> +
>> +	if (cpu_latency_qos_request_active(&hba->pm_qos_req))
>> +		hba->pm_qos_init = true;
> 
> Why do you need this flag?

this flag ensure UFS qos request got added into the Global PM QoS list.

> 
>> +
>> +	dev_dbg(hba->dev, "%s: QoS %s, qos_vote: %u\n", __func__,
>> +		hba->pm_qos_init ? "initialized" : "uninitialized",
>> +		hba->qos_vote);
>> +}
>> +
>> +/**
>> + * ufshcd_pm_qos_exit - remove instance from PM QoS
>> + * @hba: per adapter instance
>> + */
>> +static void ufshcd_pm_qos_exit(struct ufs_hba *hba)
>> +{
>> +	if (!hba->pm_qos_init)
>> +		return;
>> +
>> +	cpu_latency_qos_remove_request(&hba->pm_qos_req);
>> +	hba->pm_qos_init = false;
>> +}
>> +
> 
> [...]
> 
>>   /**
>>    * struct ufs_hba - per adapter private structure
>>    * @mmio_base: UFSHCI base register address
>> @@ -912,6 +923,8 @@ enum ufshcd_mcq_opr {
>>    * @mcq_base: Multi circular queue registers base address
>>    * @uhq: array of supported hardware queues
>>    * @dev_cmd_queue: Queue for issuing device management commands
>> + * @pm_qos_req: PM QoS request handle
>> + * @pm_qos_init: flag to check if pm qos init completed
>>    */
>>   struct ufs_hba {
>>   	void __iomem *mmio_base;
>> @@ -1076,6 +1089,9 @@ struct ufs_hba {
>>   	struct ufs_hw_queue *uhq;
>>   	struct ufs_hw_queue *dev_cmd_queue;
>>   	struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
>> +	struct pm_qos_request pm_qos_req;
>> +	bool pm_qos_init;
>> +	u32 qos_vote;
> 
> Order doesn't match Kdoc.
>

we are removing qos_vote variable in next patch series.

> - Mani
> 

Thanks,
Naresh.

