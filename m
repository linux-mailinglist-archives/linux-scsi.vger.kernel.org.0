Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901D76806C3
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Jan 2023 08:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbjA3Hzj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Jan 2023 02:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjA3Hzi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 Jan 2023 02:55:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23928279A6;
        Sun, 29 Jan 2023 23:55:37 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U7V7dd005588;
        Mon, 30 Jan 2023 07:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SkcVV7m99sV/TfFNALzQEwK0EFLxQpDYW3ihupHkyS4=;
 b=llMXO92kn0kOzZ4krqI5YDyZQwPb/j80CyZVNvPPNA6FY0JDlL9QC8399p/5krzl33ee
 yEEyJNCtCy0N+vR8/EFIynwuMT21tHp7mwaLkB+okNT23Uj1sU1g/GQFUeT8mjvKx8TD
 I65QHiA44plALtres+boKH/gFhdiHZeyVqdgKh6+c2sA/AP/AO6gqCyuJvVQjqco+J+u
 HW/UZ5gVfKZcfL39WFdeBwUSC9c4fD2bPdhbKsAX4WMWyU5fRe60DpIs92miHdnCv22B
 xmROwmTRFEUlHhe9ZL+VLyZOYqU1qe5Moip7qr3zYgKUt8ZMo2ZHYl7If3Dk4rODM9MG fg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nctnyk2sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:55:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7tNjQ031136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:55:23 GMT
Received: from [10.253.12.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 23:55:19 -0800
Message-ID: <87c13393-5eda-5742-14e3-87dafc7d89d6@quicinc.com>
Date:   Mon, 30 Jan 2023 15:55:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] scsi: ufs: qcom: fix platform_msi_domain_free_irqs()
 reference
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Arnd Bergmann <arnd@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230126211831.2274211-1-arnd@kernel.org>
 <20230127060221.GB7809@thinkpad>
 <9ff005f0-0cef-65d6-6f69-8394f1ba3e3c@quicinc.com>
 <20230130074500.GA12687@thinkpad>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20230130074500.GA12687@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g9UUx4CaifRM47TU4H2e4hYIrD_QYD7K
X-Proofpoint-ORIG-GUID: g9UUx4CaifRM47TU4H2e4hYIrD_QYD7K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300074
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Mani,

On 1/30/2023 3:45 PM, Manivannan Sadhasivam wrote:
> On Mon, Jan 30, 2023 at 12:03:45PM +0800, Can Guo wrote:
>> Hi Mani and Arnd,
>>
>> On 1/27/2023 2:02 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Jan 26, 2023 at 10:17:31PM +0100, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> The newly added MSI support is mostly hidden inside of an #ifdef,
>>>> except for one line that now causes a build failure when MSI
>>>> is disabled:
>>>>
>>>> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_remove':
>>>> drivers/ufs/host/ufs-qcom.c:1698:9: error: implicit declaration of function 'platform_msi_domain_free_irqs' [-Werror=i]
>>>>    1698 |         platform_msi_domain_free_irqs(hba->dev);
>>>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Above that, the symbol that guards the other call was recently
>>>> removed, so that is all dead code at the moment.
>>>>
>>>> Remove the incorrect #ifdef and instead of a Kconfig dependency
>>>> to only allow building the driver when CONFIG_GENERIC_MSI_IRQ
>>>> is enabled. This symbol is always present when PCI_MSI
>>>> or ARM_GIC_V3_ITS are enabled, both of which should be present
>>>> on kernels that can run on Qualcomm SoCs.
>>>>
>>>> The 'select RESET_CONTROLLER' in combination with this dependency
>>>> unfortunately causes a dependency loop and this is a user-visible
>>>> symbol, so it's better to change both to 'depends on'.
>>>>
>>>> Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
>>>> Fixes: 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>
>>>> ---
>>>> Not sure if this is the best solution, both the GENERIC_MSI_IRQ
>>>> dependencies and the RESET_CONTROLLER dependencies are a bit
>>>> inconsistent already. Feel free to pick another approach that
>>>> addresses both of the bugs I found.
>>> I think your proposed solution works best at the moment.
>>>
>>> Thanks,
>>> Mani
>>>
>>>> ---
>>>>    drivers/ufs/host/Kconfig    | 3 ++-
>>>>    drivers/ufs/host/ufs-qcom.c | 8 --------
>>>>    2 files changed, 2 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
>>>> index 139064e70a34..663881437921 100644
>>>> --- a/drivers/ufs/host/Kconfig
>>>> +++ b/drivers/ufs/host/Kconfig
>>>> @@ -57,8 +57,9 @@ config SCSI_UFS_DWC_TC_PLATFORM
>>>>    config SCSI_UFS_QCOM
>>>>    	tristate "QCOM specific hooks to UFS controller platform driver"
>>>>    	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
>>>> +	depends on GENERIC_MSI_IRQ
>>>> +	depends on RESET_CONTROLLER
>>>>    	select QCOM_SCM if SCSI_UFS_CRYPTO
>>>> -	select RESET_CONTROLLER
>>>>    	help
>>>>    	  This selects the QCOM specific additions to UFSHCD platform driver.
>>>>    	  UFS host on QCOM needs some vendor specific configuration before
>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>> index 681da3ea7154..eb66b5f6cf19 100644
>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>> @@ -1538,7 +1538,6 @@ static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
>>>>    	return 0;
>>>>    }
>>>> -#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>>>>    static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>>>>    {
>>>>    	struct device *dev = msi_desc_to_dev(desc);
>>>> @@ -1626,13 +1625,6 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
>>>>    	return ret;
>>>>    }
>>>> -#else
>>>> -static int ufs_qcom_config_esi(struct ufs_hba *hba)
>>>> -{
>>>> -	return -EOPNOTSUPP;
>>>> -}
>>>> -#endif
>>>> -
>>>>    /*
>>>>     * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
>>>>     *
>>>> -- 
>>>> 2.39.0
>>>>
>> Thank you for pointing to 13e7accb81d6 ("genirq: Get rid of
>> GENERIC_MSI_IRQ_DOMAIN"),
>>
>> which I was not aware of. I am thinking about fixing it just like how
>>
>> 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") is fixing
>> drivers/dma/qcom/hidma.c -
>>
>> In ufs-qcom.c, use CONFIG_GENERIC_MSI_IRQ instead of
>> CONFIG_GENERIC_MSI_IRQ_DOMAIN,
>>
>> and meanwhile add #ifdef check before calling
>> platform_msi_domain_free_irqs().
>>
>> Please let me know your idea.
>>
> No. Let's get rid of the ifdef's please... I like Arnd's patch as it models the
> dependency nicely in Kconfig. And most (all?) of the qcom platforms require
> GENERIC_MSI_IRQ and RESET_CONTROLLER one way or the other anyway.
>
> Thanks,
> Mani


Make sense, I agree.


Thanks,

Can Guo.

>
>> Thanks.
>> Regards,
>> Can Guo
>>
>>
