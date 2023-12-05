Return-Path: <linux-scsi+bounces-525-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086B804A4A
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 07:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2538D1F2144C
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 06:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBAE12E47
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Dec 2023 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o8m8mIqi"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA52134;
	Mon,  4 Dec 2023 21:59:46 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B530TCh010074;
	Tue, 5 Dec 2023 05:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3LK9jcnO2LKsXvZ4d4db8H6yT9gdmGLVtbrluxK8Gv0=;
 b=o8m8mIqi/aC0QrUWWiuWVZjs9GXCeX+xG8xlFpLj4irv22PQlGNrgUs/TZN7Hy7ycN0m
 RkkZxtrCGk4XibHSUdjiDc3ZwFLx7Zh+ghQXRkvB6iKND+aNNlT68UeAH7/FZvBMwM+S
 igz96hsNywiVf/AHgU3eEcPaEJn6JqsRuiIPtsavJxD139PVLgJN52EJnCS8NYPLH6IB
 gn0tBNKjJarZ8lNvL9JJCuwUFvnc0daqEVOGQHDsEmYUCfKizlU3KQ9I+SeBRzR82GG8
 BIdONGQ3MZsJCSenhCcJ0o13Mn4IjpFQOTStJXW9WFUCau87kpugwGVCYjEfJg6Dc8rA Ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usdf7jdek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Dec 2023 05:59:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B55x0Y2022211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Dec 2023 05:59:00 GMT
Received: from [10.217.219.220] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 21:58:54 -0800
Message-ID: <692cd503-5b14-4be6-831d-d8e9c282a95e@quicinc.com>
Date: Tue, 5 Dec 2023 11:28:51 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
To: Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley"
	<jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Matthias
 Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        <chu.stanley@gmail.com>
CC: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, Nitin Rawat <quic_nitirawa@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
 <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
Content-Language: en-US
From: Naresh Maramaina <quic_mnaresh@quicinc.com>
In-Reply-To: <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 94TVaSz2EVX3106dVDD8YYFE_UR_i5ND
X-Proofpoint-GUID: 94TVaSz2EVX3106dVDD8YYFE_UR_i5ND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050048

On 12/5/2023 12:30 AM, Bart Van Assche wrote:
> On 12/4/23 06:30, Maramaina Naresh wrote:
>> +    u32    (*config_qos_vote)(struct ufs_hba *hba);
> 
> Please remove the above callback since this patch series does not
> introduce any instances of this callback.
> 

Sure Bart, i will take care of this comment in next patch set.
If some SoC vendor have a different qos vote value then this callback 
can be added in future.

>> +
>> +    /* This capability allows the host controller driver to use the 
>> PM QoS
>> +     * feature.
>> +     */
>> +    UFSHCD_CAP_PM_QOS                = 1 << 13,
>>   };
> 
> Why does it depend on the host driver whether or not PM QoS is
> enabled? Why isn't it enabled unconditionally?

For some platform vendors power KPI might be more important than random 
io KPI. Hence this flag is disabled by default and can be enabled based 
on platform requirement.

> 
>> + * @pm_qos_req: PM QoS request handle
>> + * @pm_qos_init: flag to check if pm qos init completed
>>    */
> 
> Documentation for pm_qos_init is missing.
> 
Sorry, i didn't get your comment, i have already added documentation for 
@pm_qos_init, @pm_qos_req variable as above. Do you want me to add this 
information some where else as well?



>>   struct ufs_hba {
>>       void __iomem *mmio_base;
>> @@ -1076,6 +1089,9 @@ struct ufs_hba {
>>       struct ufs_hw_queue *uhq;
>>       struct ufs_hw_queue *dev_cmd_queue;
>>       struct ufshcd_mcq_opr_info_t mcq_opr[OPR_MAX];
>> +    struct pm_qos_request pm_qos_req;
>> +    bool pm_qos_init;
>> +    u32 qos_vote;
> 
> Please rename "pm_qos_init" into "pm_qos_initialized".
> 

Sure Bart, i will take care of this comment in next patch set.

> Thanks,
> 
> Bart.
> 

Thanks,
Naresh.

