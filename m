Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC62B21960C
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2020 04:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGICLr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jul 2020 22:11:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgGICLr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 8 Jul 2020 22:11:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2EF1B20BDB74D96789CF;
        Thu,  9 Jul 2020 10:11:43 +0800 (CST)
Received: from [10.174.179.105] (10.174.179.105) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 9 Jul 2020
 10:11:39 +0800
Subject: Re: [PATCH] scsi: fcoe: add missed kfree() in an error path
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-scsi@vger.kernel.org>
References: <977e2781-99ed-54c0-27ad-82d768a1c1e6@web.de>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Hannes Reinecke" <hare@suse.de>,
        "James E. J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Neerav Parikh <Neerav.Parikh@intel.com>,
        Robert Love <robert.w.love@intel.com>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F067CDA.8010404@huawei.com>
Date:   Thu, 9 Jul 2020 10:11:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <977e2781-99ed-54c0-27ad-82d768a1c1e6@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.105]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 2020/7/7 19:38, Markus Elfring wrote:
>> fcoe_fdmi_info() misses to call kfree() in an error path.
>> Add the missed function call to fix it.
>
> I suggest to use an additional jump target for the completion
> of the desired exception handling.
>
>
> …
>> +++ b/drivers/scsi/fcoe/fcoe.c
>> @@ -830,6 +830,7 @@ static void fcoe_fdmi_info(struct fc_lport *lport, struct net_device *netdev)
>>   		if (rc) {
>>   			printk(KERN_INFO "fcoe: Failed to retrieve FDMI "
>>   					"information from netdev.\n");
>> +			kfree(fdmi);
>>   			return;
>>   		}
>
> -			return;
> +			goto free_fdmi;
>
>
> How do you think about to apply any further coding style adjustments?

The local variable "fdmi" is invisible to the function.
See fcoe_fdmi_info().

	Thanks
>
> Regards,
> Markus
> .
>
