Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1675454D36
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfFYLGl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:06:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35139 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbfFYLGh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:06:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so15837892ljh.2
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hJ1vw1zo6Yo+NVBoQruROWjbHicMMrc+0Uq5a9tZI0E=;
        b=AtCxVJwKFF83GEQSiD5/UyKHSg1ExoYmFtw2Symdhw/wCQw8WfSqYsOwSLVDvVProW
         IA1d83IEb81JbfBdDvNgolRz4O+LVN1Tuw0/bfiu2tjVyk/Fm+r3ncH6VULwCoU/Cu+9
         VO/DYwctluU9QQP/bca/HYt093rIWYRomNl/lekwrJE9unOWVRpkuIcDBKLn0kr6Vnc8
         0S9nojlcDE+l3Q+K0UIe3UMEKlf8m1ndFqQq4BJEk18lmC2MRZgnZ/dpdL4pV4jMQHoY
         o258LxH0BHcR0hIAXDSxzwXYNXnCI3utaNv81DARxQqBKX1FmTWQZhDoWkJ3RZjIy+eB
         jMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hJ1vw1zo6Yo+NVBoQruROWjbHicMMrc+0Uq5a9tZI0E=;
        b=rBZ8Ye36cRqFqvq4DeU/weqZ3RE2xhKd7loKQo67H5P/t6tAsfD1dmsT/TCwPqGBNu
         ReurTlTH+qo/50mKZgMqOyUhZV5/YNzCztzCaCiljegpCsUKi4mdZhZkZ4j58smgzxEM
         kztJ0CXkOD6KUB9wCV2v/Qdin+UIj2gyEMkLRH60+FB2Uf4JiPdTiSfdGbweV9cOw3j3
         MFDR7Nl2Z0lbdK2PVYY8CkBM477B8AulcGzPJbpENAu9j+zSJQEswPmtJTH06MlwjRK4
         ZF43w8XYEwDWEW/DxC+l89ZypWJA4AVQ4I8PqrvK1QV3DLQYyhdsPAwiqNXyNWh2coQ+
         XY8g==
X-Gm-Message-State: APjAAAXDfGpP3eOeBOzTqnPnwzqcPyKfP/33pPpR9Twc/M+zmDOWo7nL
        Y7mUV9GzE2iQSB+EbqUZADJkBxq8GVk=
X-Google-Smtp-Source: APXvYqyfuet2MP/Dnr9EfVjUh2ZWzHR3Uce4MeCK6uqHcizBWIFHMTfXvHhv+iCudLtIj5SIITGOjA==
X-Received: by 2002:a2e:8345:: with SMTP id l5mr15081292ljh.18.1561460795234;
        Tue, 25 Jun 2019 04:06:35 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id h3sm2221123lja.93.2019.06.25.04.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 04:06:34 -0700 (PDT)
Subject: Re: [PATCH 2/4] null_blk: add zone open, close, and finish support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-3-mb@lightnvm.io>
 <BYAPR04MB5816D471063D970DDCF9AEC7E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <1aa6552c-ecf9-a168-df75-ec8c52ddbea6@lightnvm.io>
Date:   Tue, 25 Jun 2019 13:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816D471063D970DDCF9AEC7E7E60@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/22/19 3:02 AM, Damien Le Moal wrote:
> On 2019/06/21 22:07, Matias Bjørling wrote:
>> From: Ajay Joshi <ajay.joshi@wdc.com>
>>
>> Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH
>> support to allow explicit control of zone states.
>>
>> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
>> Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
>> ---
>>   drivers/block/null_blk.h       |  4 ++--
>>   drivers/block/null_blk_main.c  | 13 ++++++++++---
>>   drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++++++++++++++---
>>   3 files changed, 42 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
>> index 34b22d6523ba..62ef65cb0f3e 100644
>> --- a/drivers/block/null_blk.h
>> +++ b/drivers/block/null_blk.h
>> @@ -93,7 +93,7 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
>>   		     gfp_t gfp_mask);
>>   void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>>   			unsigned int nr_sectors);
>> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
>> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector);
>>   #else
>>   static inline int null_zone_init(struct nullb_device *dev)
>>   {
>> @@ -111,6 +111,6 @@ static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>>   				   unsigned int nr_sectors)
>>   {
>>   }
>> -static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
>> +static inline void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector) {}
>>   #endif /* CONFIG_BLK_DEV_ZONED */
>>   #endif /* __NULL_BLK_H */
>> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
>> index 447d635c79a2..5058fb980c9c 100644
>> --- a/drivers/block/null_blk_main.c
>> +++ b/drivers/block/null_blk_main.c
>> @@ -1209,10 +1209,17 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
>>   			nr_sectors = blk_rq_sectors(cmd->rq);
>>   		}
>>   
>> -		if (op == REQ_OP_WRITE)
>> +		switch (op) {
>> +		case REQ_OP_WRITE:
>>   			null_zone_write(cmd, sector, nr_sectors);
>> -		else if (op == REQ_OP_ZONE_RESET)
>> -			null_zone_reset(cmd, sector);
>> +			break;
>> +		case REQ_OP_ZONE_RESET:
>> +		case REQ_OP_ZONE_OPEN:
>> +		case REQ_OP_ZONE_CLOSE:
>> +		case REQ_OP_ZONE_FINISH:
>> +			null_zone_mgmt_op(cmd, sector);
>> +			break;
>> +		}
>>   	}
>>   out:
>>   	/* Complete IO by inline, softirq or timer */
>> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
>> index fca0c97ff1aa..47d956b2e148 100644
>> --- a/drivers/block/null_blk_zoned.c
>> +++ b/drivers/block/null_blk_zoned.c
>> @@ -121,17 +121,44 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>>   	}
>>   }
>>   
>> -void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
>> +void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector)
>>   {
>>   	struct nullb_device *dev = cmd->nq->dev;
>>   	unsigned int zno = null_zone_no(dev, sector);
>>   	struct blk_zone *zone = &dev->zones[zno];
>> +	enum req_opf op = req_op(cmd->rq);
>>   
>>   	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
>>   		cmd->error = BLK_STS_IOERR;
>>   		return;
>>   	}
>>   
>> -	zone->cond = BLK_ZONE_COND_EMPTY;
>> -	zone->wp = zone->start;
>> +	switch (op) {
>> +	case REQ_OP_ZONE_RESET:
>> +		zone->cond = BLK_ZONE_COND_EMPTY;
>> +		zone->wp = zone->start;
>> +		return;
>> +	case REQ_OP_ZONE_OPEN:
>> +		if (zone->cond == BLK_ZONE_COND_FULL) {
>> +			cmd->error = BLK_STS_IOERR;
>> +			return;
>> +		}
>> +		zone->cond = BLK_ZONE_COND_EXP_OPEN;
> 
> 
> With ZBC, open of a full zone is a "nop". No error. So I would rather have this as:
> 
> 		if (zone->cond != BLK_ZONE_COND_FULL)
> 			zone->cond = BLK_ZONE_COND_EXP_OPEN;
> 		
Is this only ZBC? I can't find a reference to it in ZAC. I think it 
should fail. One is trying to open a zone that is full, one can't open 
it again. It's done for this round.
> 
>> +		return;
>> +	case REQ_OP_ZONE_CLOSE:
>> +		if (zone->cond == BLK_ZONE_COND_FULL) {
>> +			cmd->error = BLK_STS_IOERR;
>> +			return;
>> +		}
>> +		zone->cond = BLK_ZONE_COND_CLOSED;
> 
> Sam as for open. Closing a full zone on ZBC is a nop. 

I think this should cause error.

And the code above would
> also set an empty zone to closed. Finally, if the zone is open but nothing was
> written to it, it must be returned to empty condition, not closed. 

Only on a reset event right? In general, if I do a expl. open, close it, 
it should not go to empty.

So something
> like this is needed.
> 
> 		switch (zone->cond) {
> 		case BLK_ZONE_COND_FULL:
> 		case BLK_ZONE_COND_EMPTY:
> 			break;
> 		case BLK_ZONE_COND_EXP_OPEN:
> 			if (zone->wp == zone->start) {
> 				zone->cond = BLK_ZONE_COND_EMPTY;
> 				break;
> 			}
> 		/* fallthrough */
> 		default:
> 			zone->cond = BLK_ZONE_COND_CLOSED;
> 		}
> 
>> +		return;
>> +	case REQ_OP_ZONE_FINISH:
>> +		zone->cond = BLK_ZONE_COND_FULL;
>> +		zone->wp = zone->start + zone->len;
>> +		return;
>> +	default:
>> +		/* Invalid zone condition */
>> +		cmd->error = BLK_STS_IOERR;
>> +		return;
>> +	}
>>   }
>>
> 
> 

