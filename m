Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544945853B8
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Jul 2022 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiG2QnZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 29 Jul 2022 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiG2QnY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 29 Jul 2022 12:43:24 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEE721251;
        Fri, 29 Jul 2022 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659113003; x=1690649003;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rtqlWzoBg32+YUKG0SS5QWN9yxKR8MwGAO832LwRtmg=;
  b=R6sZN6wZUpLNbyaurM/YQOmVc7E9htuKOOghqdRgzQL4ZgSMKoRzUpfw
   p2ySSiQxBoiSdYecFQOx6LwnBBO/nnPeNlQp0uamb3+CQAI/TG27BcLmJ
   OBN8Pj47UD81mgcsaKBPQvGF8xf0rmTIw1maAY18cM/+7BVk4li+00zZI
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Jul 2022 09:43:23 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 09:43:22 -0700
Received: from [10.110.38.152] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Jul
 2022 09:43:22 -0700
Message-ID: <59e835e6-b694-07c5-16a1-5f7774fc4177@quicinc.com>
Date:   Fri, 29 Jul 2022 09:43:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
From:   "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Can Guo <quic_cang@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <quic_nguyenb@quicinc.com>, <quic_ziqichen@quicinc.com>,
        <linux-scsi@vger.kernel.org>, <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <f93045ec-569c-bd09-3617-d7d7aca4e5cd@huawei.com>
 <ea33dee8-673c-0716-1640-28df7c983ca7@quicinc.com>
 <10288041-8c3d-7e3a-9049-10b9fcd8baed@acm.org>
 <6da1447d-01d6-222e-fc98-7e96b154d2d0@quicinc.com>
In-Reply-To: <6da1447d-01d6-222e-fc98-7e96b154d2d0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On 7/28/2022 2:07 PM, Asutosh Das (asd) wrote:
> On 7/28/2022 1:29 PM, Bart Van Assche wrote:
>> On 7/28/22 12:15, Asutosh Das (asd) wrote:
>>> Hello John,
>>>
>>> On 7/28/2022 12:10 PM, John Garry wrote:
>>>> On 19/07/2022 08:01, Can Guo wrote:
>>>>> +
>>>>> +    hba->nr_queues[HCTX_TYPE_DEFAULT] = num_possible_cpus();
>>>>> +    hba->nr_queues[HCTX_TYPE_READ] = 0;
>>>>> +    hba->nr_queues[HCTX_TYPE_POLL] = 1;
>>>>> +
>>>>> +    for (i = 0; i < HCTX_MAX_TYPES; i++)
>>>>> +        host->nr_hw_queues += hba->nr_queues[i];
>>>>> +
>>>>> +    host->can_queue = hba->nutrs;
>>>>> +    host->cmd_per_lun = hba->nutrs;
>>>>> +
>>>>> +    /* One more reserved for dev_cmd_queue */
>>>>> +    hba->nr_hw_queues = host->nr_hw_queues + 1;
>>>>> +
>>>>
>>>> So this would mean that the host can accept .can_queue * 
>>>> .nr_hw_queues numbers of requests simultaneously - is that true?
>>>
>>> That would mean that .can_queue * .nr_hw_queues numbers of request 
>>> may be queued to the host.
>>> Please can you elaborate if you see an issue.
>>
>> Hi Asutosh,
>>
>> The `host_tagset` flag has been introduced by John and Hannes some 
>> time ago. See also commit bdb01301f3ea ("scsi: Add host and host 
>> template flag 'host_tagset'"). This flag supports sharing tags across 
>> hardware queues and could be used to support UFSHCI 4.0 controllers 
>> that do not support the EXT_IID feature.
>>
>> In order not to complicate the implementation further, I propose to 
>> fall back to the UFSHCI 3.0 compatibility mode for UFSHCI 4.0 
>> controllers that do not support the EXT_IID feature.
>>
>> To answer John's question: the maximum number of outstanding commands 
>> is 16 * hba->nutrs if EXT_IID is supported (EXT_IID is a four bits 
>> field). If the hardware queue index is encoded in the EXT_IID field, 
>> hba->nutrs is the number of commands per hardware queue.
>>
>> Thanks,
>>
>> Bart.
> 
> Thanks Bart, I wasn't aware of the background of John's Q. I will 
> consider your proposal and get back.
> 

I went through the change and fwiu of your proposal is to use 
host_tagset = 1 if HC doesn't support EXT_IID capability.
That way tags would be shared across 16 HWQs (4-bit IID encoding the 
queue-ids).
That would also mean that the hba->nutrs would have to be adjusted such 
that the tags(8-bit) don't exceed 255.

Summarily,
if EXT_IID is not supported:
host_tagset = 1, maximum configurable hba->nutrs = 16, maximum 
configurable nr_hw_queues = 16.
maximum number of outstanding commands to host = 16 x 16 = 256.

if EXT_IID is supported:
host_tagset = 0, maximum confiugrable hba-nutrs = 255, maximum 
configurable nr_hw_queues = 255.

Please let me know if I'm missing something.

Thank you,
-asd




