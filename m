Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078C23F031F
	for <lists+linux-scsi@lfdr.de>; Wed, 18 Aug 2021 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhHRMAw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Aug 2021 08:00:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3661 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhHRMAv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Aug 2021 08:00:51 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GqRJp6N8vz6BHR9;
        Wed, 18 Aug 2021 19:59:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 14:00:15 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 13:00:14 +0100
Subject: Re: [PATCH v2 06/11] blk-mq: Pass driver tags to
 blk_mq_clear_rq_mapping()
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <kashyap.desai@broadcom.com>, <hare@suse.de>
References: <1628519378-211232-1-git-send-email-john.garry@huawei.com>
 <1628519378-211232-7-git-send-email-john.garry@huawei.com>
 <YRyGb/Ay3lvUZs/V@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <23448833-593c-139f-6051-9b8e7d3deade@huawei.com>
Date:   Wed, 18 Aug 2021 13:00:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YRyGb/Ay3lvUZs/V@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>   
>> @@ -2346,8 +2345,11 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tag_set *set,
>>   void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>   		     unsigned int hctx_idx)
>>   {
>> +	struct blk_mq_tags *drv_tags;
>>   	struct page *page;
>>   
>> +		drv_tags = set->tags[hctx_idx];
> 

Hi Ming,

> Indent.

That's intentional, as we have from later patch:

void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags 
*tags, unsigned int hctx_idx)
{
	struct blk_mq_tags *drv_tags;
	struct page *page;

+	if (blk_mq_is_sbitmap_shared(set->flags))
+		drv_tags = set->shared_sbitmap_tags;
+	else
		drv_tags = set->tags[hctx_idx];

	...

	blk_mq_clear_rq_mapping(drv_tags, tags);

}

And it's just nice to not re-indent later.

> 
>> +
>>   	if (tags->static_rqs && set->ops->exit_request) {
>>   		int i;
>>   
>> @@ -2361,7 +2363,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>   		}
>>   	}
>>   
>> -	blk_mq_clear_rq_mapping(set, tags, hctx_idx);
>> +	blk_mq_clear_rq_mapping(drv_tags, tags);
> 
> Maybe you can pass set->tags[hctx_idx] directly since there is only one
> reference on it.
> 

Again, intentional for similar reason, as above.

Thanks,
John

