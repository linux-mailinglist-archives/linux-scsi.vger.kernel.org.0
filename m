Return-Path: <linux-scsi+bounces-168-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72167F9860
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Nov 2023 05:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1877280CA8
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Nov 2023 04:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B956139
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Nov 2023 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EzbQH/0V"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0476C5;
	Sun, 26 Nov 2023 18:37:54 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR25aZZ001610;
	Mon, 27 Nov 2023 02:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EUx2kznvF55x6TcJFKC10LOA6TIMz5Dd7BoGMsvEIWA=;
 b=EzbQH/0VQZl5LF3KJrNYtLz4ZO1B5g/kySLWjRzWZYwCnS5v2TPNGbU09LYT/KEML+IE
 Jx1XKXxOCyIiq3CGzxcl5pNKMhA0CRtrTZnVJavsF3Bgj9xvjO2/v6ASSA2H27yyEuQi
 35DnD5t9VkqTrJFoE3SW9hw0M2c1x81f3kFiew7L65WnnXLgaw3NxagUMJfXIEkDDjQh
 oyen/oqfMuAfx476oakBeRCAr3KNaqIjqFxa79rIGQPLp9j6fREmwO29QJ0R7Gy+GnpO
 NUl3kYhOiAV4EchTt9ogPUoCLdHqU6qX6nf14u6gxngxMgOfkYEJL3/zvK8VJxqoOd8q lA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk912k24c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 02:37:11 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR2bA05007540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 02:37:10 GMT
Received: from [10.239.155.136] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 26 Nov
 2023 18:37:06 -0800
Message-ID: <62770dc8-097e-9583-39fd-1a18ba2a8d13@quicinc.com>
Date: Mon, 27 Nov 2023 10:36:52 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] dt-bindings: ufs: Add msi-parent for UFS MCQ
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <mani@kernel.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>
CC: <linux-scsi@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
        "Rob
 Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown
	<broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <1700629624-23571-1-git-send-email-quic_ziqichen@quicinc.com>
 <f9640827-4100-4ebf-8281-46f2d656540a@acm.org>
From: Ziqi Chen <quic_ziqichen@quicinc.com>
In-Reply-To: <f9640827-4100-4ebf-8281-46f2d656540a@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tD-mE2HJJtcgPXMzDPYrw-1jwI2kxQFg
X-Proofpoint-ORIG-GUID: tD-mE2HJJtcgPXMzDPYrw-1jwI2kxQFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270018



On 11/23/2023 1:53 AM, Bart Van Assche wrote:
> On 11/21/23 21:06, Ziqi Chen wrote:
>> diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml 
>> b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
>> index 985ea8f..31fe7f3 100644
>> --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
>> @@ -87,6 +87,8 @@ properties:
>>       description:
>>         Specifies max. load that can be drawn from VCCQ2 supply.
>> +  msi-parent: true
>> +
>>   dependencies:
>>     freq-table-hz: [ clocks ]
>>     operating-points-v2: [ clocks, clock-names ]
> 
> Does this patch break support for UFSHCI 4.0 controllers that do not 
> support MSI?

No, the controllers that do not support MSI would NOT be impacted by 
this patch.

-Ziqi

> 
> Thanks,
> 
> Bart.

