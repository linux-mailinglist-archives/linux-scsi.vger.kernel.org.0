Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681601C33D9
	for <lists+linux-scsi@lfdr.de>; Mon,  4 May 2020 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEDHuL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 May 2020 03:50:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbgEDHuK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 May 2020 03:50:10 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id CDF8E50AA9ADA351D103;
        Mon,  4 May 2020 08:50:07 +0100 (IST)
Received: from [127.0.0.1] (10.210.171.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 08:50:06 +0100
Subject: Re: [PATCH RFC v3 37/41] libsas: add tag to struct sas_task
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20200430131904.5847-1-hare@suse.de>
 <20200430131904.5847-38-hare@suse.de>
 <61c1be62-c2f1-8d0d-9533-ba3cf671d666@huawei.com>
 <4361894d-c9b7-c601-56b4-35846f27c8e7@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <57c8f0c8-1314-d3ea-af89-2a730ddd2d6e@huawei.com>
Date:   Mon, 4 May 2020 08:49:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4361894d-c9b7-c601-56b4-35846f27c8e7@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.171.25]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>> -
>>> +    task->tag = cmd->request->tag;
>>>        task->scatter = scsi_sglist(cmd);
>>>        task->num_scatter = scsi_sg_count(cmd);
>>>        task->total_xfer_len = scsi_bufflen(cmd);
>>> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
>>> index c927228019c9..af864f68b5cc 100644
>>> --- a/include/scsi/libsas.h
>>> +++ b/include/scsi/libsas.h
>>> @@ -594,6 +594,8 @@ struct sas_task {
>>>        u32    total_xfer_len;
>>>        u8     data_dir:2;      /* Use PCI_DMA_... */
>>> +    u32    tag;
>>
>> unsigned, yet we assign it -1?
>>
> Yeah, that's how the block layer does internally, too.
> Maybe we should export SCSI_NO_TAG and use it here.
> 

I think it's better that the LLDD would not have to deal with "no tag" 
scenario (pm8001 driver has to handle it in this series). Rather libsas 
can handle that, and fail an allocation of a slow_task to the LLDD instead.

Thanks,
John
