Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFB3D905C
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Jul 2021 16:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhG1OYN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Jul 2021 10:24:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7761 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbhG1OYN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Jul 2021 10:24:13 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZbNg5t9gzYfnm;
        Wed, 28 Jul 2021 22:18:11 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Jul 2021 22:24:07 +0800
Subject: Re: [PATH v2] scsi: scsi_dh_rdac: Avoid crash during rdac_bus_attach
To:     Bart Van Assche <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210113063103.2698953-1-yebin10@huawei.com>
 <a1113b04-e320-a12b-5a59-ec7479d5eec1@acm.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <61016887.9000200@huawei.com>
Date:   Wed, 28 Jul 2021 22:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <a1113b04-e320-a12b-5a59-ec7479d5eec1@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2021/7/23 12:04, Bart Van Assche wrote:
> On 1/12/21 10:31 PM, Ye Bin wrote:
>>   	sdev->handler_data = NULL;
>> +	synchronize_rcu();
>>   	kfree(h);
> What is the purpose of the new synchronize_rcu() call?
Thanks for your reply.
Yes, I add new synchronize_rcu() call is to wait until *h is no longer 
in use. If free
"h" right now , mybe lead to UAF.
> If its purpose is
> to wait until *h is no longer in use, please use kfree_rcu() instead.
struct rdac_dh_data {
         struct list_head        node;
         .....
}
As rdac_dh_data.node type is "struct list_head", but  kfree_rcu the 
first parameter type is
"struct rcu_head". So we can only use synchronize_rcu() at here.
>
> Thanks,
>
> Bart.
> .
>

