Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8612215386
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jul 2020 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgGFHxk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Jul 2020 03:53:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2425 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728248AbgGFHxj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Jul 2020 03:53:39 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 234D032C2C788AD03BDD;
        Mon,  6 Jul 2020 08:53:38 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 6 Jul 2020
 08:53:37 +0100
Subject: Re: [PATCH 03/22] scsi: add scsi_{get,put}_internal_cmd() helper
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        Don Brace <don.brace@microchip.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20200629072021.9864-1-hare@suse.de>
 <20200629072021.9864-4-hare@suse.de>
 <e211779a-d95c-de3a-5beb-6bf0311733fe@huawei.com>
 <a0ae1522-856d-f47a-c8c1-f67e38ad4f3c@suse.de>
 <SN4PR0401MB359872DFD1AFEC0797D34D479B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f060204d-1ad4-a3b4-56f1-b0163247a928@huawei.com>
Date:   Mon, 6 Jul 2020 08:51:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359872DFD1AFEC0797D34D479B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.142]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 02/07/2020 09:21, Johannes Thumshirn wrote:
> On 02/07/2020 09:59, Hannes Reinecke wrote:
>> That's one of the best-kept secrets in the block layer:
>>
>> op_is_write()
>>
>> The assumption is that every request with a REQ_OP which has the lowest
>> bit set is a write.
>> And quite a lot of accounting the the block layer revolves around that.
>> So we'll need to keep it.
>>
>> ... and we probably should document it somewhere.
> 

Now that I check further, it is documented in blk_types.h:

  * The least significant bit of the operation number indicates the data
  * transfer direction:
  *
  *   - if the least significant bit is set transfers are TO the device
  *   - if the least significant bit is not set transfers are FROM the 
device
  *

> I personally find this very obvious:
> 
> static inline bool op_is_write(unsigned int op) > {
> 	return (op & 1);
> }
> 
> .
> 

