Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EEE646E27
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Dec 2022 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLHLMK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Dec 2022 06:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLHLLg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Dec 2022 06:11:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F562DF0
        for <linux-scsi@vger.kernel.org>; Thu,  8 Dec 2022 03:11:19 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NSWfC6byrzJqLV;
        Thu,  8 Dec 2022 19:10:27 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 19:11:16 +0800
Subject: Re: [PATCH 4/6] scsi: libsas: remove useless dev_list delete in
 sas_ex_discover_end_dev()
To:     John Garry <john.g.garry@oracle.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <jinpu.wang@cloud.ionos.com>,
        <damien.lemoal@opensource.wdc.com>
References: <20221204081643.3835966-1-yanaijie@huawei.com>
 <20221204081643.3835966-5-yanaijie@huawei.com>
 <aaeef818-97d6-6f38-4a10-36a5d5473b50@oracle.com>
 <1a1f0169-bb89-c9fb-b26a-f8c03c669bd3@huawei.com>
 <8e077620-e0e8-71f0-0a77-66fd91320a78@oracle.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1136cceb-01d9-e01f-0047-eed40ef9f91c@huawei.com>
Date:   Thu, 8 Dec 2022 19:11:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8e077620-e0e8-71f0-0a77-66fd91320a78@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022/12/8 18:40, John Garry wrote:
> On 08/12/2022 07:21, Jason Yan wrote:
>>>> t_list_del:
>>>>       sas_rphy_free(child->rphy);
>>>>       list_del(&child->disco_list_node);
>>>> -    spin_lock_irq(&parent->port->dev_list_lock);
>>>> -    list_del(&child->dev_list_node);
>>>> -    spin_unlock_irq(&parent->port->dev_list_lock);
>>>
>>> Since we have the spin lock'ing, this seems to be have been 
>>> intentionally added (and not some simple typo or similar) - any idea 
>>> of the origin?
>>
>> The new device used to be added to the dev_list in this function. But 
>> after 92625f9bff38 ("[SCSI] libsas: restore scan order") and 
>> 87c8331fcf72 ("[SCSI] libsas: prevent domain rediscovery competing 
>> with ata error handling") it is added to the disco_list instead. But 
>> the list_del() and locking is forgot to be removed.
> 
> OK, so can we have a fixes tag then? That even helps review, as I can 
> then quickly see where we went wrong.
> 

Sure.

Thanks,
Jason
