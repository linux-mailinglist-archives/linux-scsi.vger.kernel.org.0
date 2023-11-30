Return-Path: <linux-scsi+bounces-357-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054617FEAE4
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 09:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FD71C20BD6
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B5364B5
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Nov 2023 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FqzLhe0Y"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24296D5E;
	Wed, 29 Nov 2023 23:44:30 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU4Ui6a020058;
	Thu, 30 Nov 2023 07:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=j547jNixqenyDHQDJth/ORI7ELVgm2E/2slM2GPvjZs=;
 b=FqzLhe0YNj2kKrzplc1Aw0nSCWgJBAZk84KNyn6I06b4ujSt0PaHkoB/+N1qpgI6zjqO
 JpKvnNMSry+BYhDID3iMUPsq8Ua+kr6mlUtFmXCSjduL7AJNYJoUcp9rXqRUVtJzIQ+Q
 Hs4dCIlNIE4ni/J4YSocyq8FlNrdJf5ahEGqT/HGuMJd+UbIdCIcErFF/Zp0nuE+8JeN
 DzUqMbh5rmjuQ/YE9A7xD5LVZOaF0kJW3Q+lKsWPNKnQUDGDy/McLlDcjdOni6xcryCO
 /edsgDusPceU28BNVY7A2JAHOa7ZgxcURRxZUOrRFJL4uXHX+/+yKjfrk2XUkDLo+9iX TQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up4cfaq69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 07:44:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU7iFpK028306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Nov 2023 07:44:15 GMT
Received: from [10.253.11.15] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 23:44:12 -0800
Message-ID: <df573678-3ca0-4e7e-af73-efa674be7090@quicinc.com>
Date: Thu, 30 Nov 2023 15:44:09 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] scsi: ufs: ufs-qcom: Allow the first init start
 with the maximum supported gear
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <bvanassche@acm.org>, <adrian.hunter@intel.com>, <cmd4@qualcomm.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list
	<linux-kernel@vger.kernel.org>
References: <1701246516-11626-1-git-send-email-quic_cang@quicinc.com>
 <1701246516-11626-5-git-send-email-quic_cang@quicinc.com>
 <20231130064221.GE3043@thinkpad>
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231130064221.GE3043@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KuyYo3ATjvfc_tn1un0ik5PUtOwI93c-
X-Proofpoint-ORIG-GUID: KuyYo3ATjvfc_tn1un0ik5PUtOwI93c-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_05,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300056



On 11/30/2023 2:42 PM, Manivannan Sadhasivam wrote:
> On Wed, Nov 29, 2023 at 12:28:29AM -0800, Can Guo wrote:
>> During host driver init, the phy_gear is set to the minimum supported gear
>> (HS_G2). Then, during the first power mode change, the negotiated gear, say
>> HS-G4, is updated to the phy_gear variable so that in the second init the
>> updated phy_gear can be used to program the PHY.
>>
>> But the current code only allows update the phy_gear to a higher value. If
>> one wants to start the first init with the maximum support gear, say HS-G4,
>> the phy_gear is not updated to HS-G3 if the device only supports HS-G3.
>>
>> The original check added there is intend to make sure the phy_gear won't be
>> updated when gear is scaled down (during clock scaling). Update the check
>> so that one can start the first init with the maximum support gear without
>> breaking the original fix by checking the ufshcd_state, that is, allow
>> update to phy_gear only if power mode change is invoked from
>> ufshcd_probe_hba().
>>
>> This change is a preparation patch for the next patches in the same series.
> 
> If you happen to respin the series, please remove this line. When the patches
> get merged, there will be no concept of patches/series as all will be git
> commits.
> 
> You can have this information in the comment section (below --- line) though.
> 

Sure, will remove it in next version.

Thanks,
Can Guo.

>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 9a90019..81056b9 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -916,11 +916,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   		}
>>   
>>   		/*
>> -		 * Update phy_gear only when the gears are scaled to a higher value. This is
>> -		 * because, the PHY gear settings are backwards compatible and we only need to
>> -		 * change the PHY gear settings while scaling to higher gears.
>> +		 * During UFS driver probe, always update the PHY gear to match the negotiated
>> +		 * gear, so that, if quirk UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH is enabled,
>> +		 * the second init can program the optimal PHY settings. This allows one to start
>> +		 * the first init with either the minimum or the maximum support gear.
>>   		 */
>> -		if (dev_req_params->gear_tx > host->phy_gear)
>> +		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
>>   			host->phy_gear = dev_req_params->gear_tx;
>>   
>>   		/* enable the device ref clock before changing to HS mode */
>> -- 
>> 2.7.4
>>
>>
> 

