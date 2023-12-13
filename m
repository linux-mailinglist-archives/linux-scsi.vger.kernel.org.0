Return-Path: <linux-scsi+bounces-730-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67D809C84
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 07:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1631C209D0
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 06:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D63101E8
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NiMYXNKS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E511723;
	Thu,  7 Dec 2023 22:28:30 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B86FNoP030077;
	Fri, 8 Dec 2023 06:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=n7Z1RwTN7c73R+xQHbb19t2J4VcVHCQLVaJscLNNmyg=;
 b=NiMYXNKSwylg6f6keLVMdUlsTYBFMByqlUr2pMhvOh7D8sQBp70NvnJN5BEXWfp/I7R7
 UP73tK0OOWxf5q9POWin8eR7XPH5ilYFAIgU9QJLxl49O8GWCp5IjhE+MvwHRNvOoprc
 6X0/vthcqSj2mdpDyrBRMsIhnwgGB1pVHsCQBhoSX8wGVk8X8XfnXI1DR2E9RAQCo2gT
 xhpsdjWXfWo6o1VJo5bvY3pADr/IsDH1BANc5PFXxhVONByuNbdfEav33g2mwSqyqERf
 itZ4FZ3HzSFRNHB33boUAGIiznf+QbFSEPr7UQyZXntlKpFCoTT2uLhGjemmDAAKXSbY fA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uubd82qxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Dec 2023 06:28:27 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B86SRYu013172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Dec 2023 06:28:27 GMT
Received: from [10.216.14.21] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 22:22:50 -0800
Message-ID: <cf86e733-9e5a-4bdb-9460-698d3eb7f945@quicinc.com>
Date: Fri, 8 Dec 2023 11:52:47 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] ice, ufs, mmc: use blk_crypto_key for
 program_key
Content-Language: en-US
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <ebiggers@google.com>,
        <neil.armstrong@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <omprsing@qti.qualcomm.com>,
        <quic_psodagud@quicinc.com>, <abel.vesa@linaro.org>,
        <quic_spuppala@quicinc.com>, <kernel@quicinc.com>
References: <20231122053817.3401748-1-quic_gaurkash@quicinc.com>
 <20231122053817.3401748-2-quic_gaurkash@quicinc.com>
From: Om Prakash Singh <quic_omprsing@quicinc.com>
In-Reply-To: <20231122053817.3401748-2-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c67tyH0MJkqXZmKnA-fX1WsvAXsyYYuw
X-Proofpoint-ORIG-GUID: c67tyH0MJkqXZmKnA-fX1WsvAXsyYYuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=862 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080050



On 11/22/2023 11:08 AM, Gaurav Kashyap wrote:
> The program key ops in the storage controller does not pass on the blk 
> crypto key structure to ice, this is okay when wrapped keys are not 
> supported and keys are standard AES XTS sizes. However, wrapped keyblobs 
> can be of any size and in preparation for that, modify the ICE and 
> storage controller APIs to accept blk_crypto_key. Signed-off-by: Gaurav 
> Kashyap <quic_gaurkash@quicinc.com> ---
Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>

