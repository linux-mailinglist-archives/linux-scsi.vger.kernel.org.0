Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6738521EAAA
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 09:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgGNHyZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 03:54:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgGNHyZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:54:25 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 06052CAAB23C2DAE9FC3;
        Tue, 14 Jul 2020 08:54:24 +0100 (IST)
Received: from [127.0.0.1] (10.47.10.169) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 14 Jul
 2020 08:54:22 +0100
Subject: Re: [PATCH RFC v7 12/12] hpsa: enable host_tagset and switch to MQ
To:     Hannes Reinecke <hare@suse.de>, <don.brace@microsemi.com>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <kashyap.desai@broadcom.com>,
        <sumit.saxena@broadcom.com>, <ming.lei@redhat.com>,
        <bvanassche@acm.org>, <hare@suse.com>, <hch@lst.de>,
        <shivasharan.srikanteshwara@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <chenxiang66@hisilicon.com>,
        <megaraidlinux.pdl@broadcom.com>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <1591810159-240929-13-git-send-email-john.garry@huawei.com>
 <939891db-a584-1ff7-d6a0-3857e4257d3e@huawei.com>
 <3b3ead84-5d2f-dcf2-33d5-6aa12d5d9f7e@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4319615a-220b-3629-3bf4-1e7fd2d27b92@huawei.com>
Date:   Tue, 14 Jul 2020 08:52:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3b3ead84-5d2f-dcf2-33d5-6aa12d5d9f7e@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.169]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 14/07/2020 08:41, Hannes Reinecke wrote:
> On 7/14/20 9:37 AM, John Garry wrote:
>> On 10/06/2020 18:29, John Garry wrote:
>>> From: Hannes Reinecke <hare@suse.de>
>>>
>>> The smart array HBAs can steer interrupt completion, so this
>>> patch switches the implementation to use multiqueue and enables
>>> 'host_tagset' as the HBA has a shared host-wide tagset.
>>>
>>
>> Hi Don,
>>
>> I am preparing the next iteration of this series, and we're getting
>> close to dropping the RFC tags. The series has grown a bit, and I am not
>> sure what to do with hpsa support.
>>
>> The latest versions of this series have not been tested for hpsa, AFAIK.
>> Can you let me know if you can test and review this patch? Or someone
>> else let me know it's tested (Hannes?)
>> I'll give it a go.
> 
> Which git repository should I base the tests on?

v7 is here:

https://github.com/hisilicon/kernel-dev/commits/private-topic-blk-mq-shared-tags-rfc-v7

So that should be good to test with for now.

And I was going to ask this same question about smartpqi, so can you 
please let me know about this one?

Thanks,
John
