Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E336C072
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhD0H4i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 03:56:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2918 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhD0H4h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Apr 2021 03:56:37 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FTv1s6JbXz73dRH;
        Tue, 27 Apr 2021 15:45:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Apr 2021 09:55:53 +0200
Received: from [10.47.94.234] (10.47.94.234) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 27 Apr
 2021 08:55:52 +0100
Subject: Re: [bug report] shared tags causes IO hang and performance drop
To:     Ming Lei <ming.lei@redhat.com>
CC:     Kashyap Desai <kashyap.desai@broadcom.com>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>
References: <cb326d404c6e0785d03a7dfadc42832c@mail.gmail.com>
 <YHbOOfGNHwO4SMS7@T590> <87ceccf2-287b-9bd1-899a-f15026c9e65b@huawei.com>
 <YHe3M62agQET6o6O@T590> <0c85fe52-ebc7-68b3-2dbe-dfad5d604346@huawei.com>
 <c1d5abaa-c460-55f8-5351-16f09d6aa81f@huawei.com> <YIbS1dgSYrsAeGvZ@T590>
 <55743a51-4d6f-f481-cebf-e2af9c657911@huawei.com> <YIbkX2G0+dp3PV+u@T590>
 <9ad15067-ba7b-a335-ae71-8c4328856b91@huawei.com> <YIdTyyVE5azlYwtO@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ab83eec4-20f1-ad74-7f43-52a4a87a8aa9@huawei.com>
Date:   Tue, 27 Apr 2021 08:52:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YIdTyyVE5azlYwtO@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.234]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 27/04/2021 00:59, Ming Lei wrote:
>> Anyway, I'll look at adding code for a per-request queue sched tags to see
>> if it helps. But I would plan to continue to use a per hctx sched request
>> pool.
> Why not switch to per hctx sched request pool?

I don't understand. The current code uses a per-hctx sched request pool, 
and I said that I don't plan to change that.

Thanks,
John
