Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828D22B9BC2
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKST4s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 14:56:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2132 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgKST4s (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Nov 2020 14:56:48 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CcVlK5YJlz67DHk;
        Fri, 20 Nov 2020 03:55:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 19 Nov 2020 20:56:46 +0100
Received: from [10.200.65.70] (10.200.65.70) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 19 Nov
 2020 19:56:44 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/3] genirq/affinity: Add irq_update_affinity_desc()
To:     Thomas Gleixner <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maz@kernel.org>
References: <87ft57r7v3.fsf@nanos.tec.linutronix.de>
 <78356caa-57a0-b807-fe52-8f12d36c1789@huawei.com>
 <874klmqu2r.fsf@nanos.tec.linutronix.de>
 <b86af904-2288-8b53-7e99-e763b73987d0@huawei.com>
 <87lfexp6am.fsf@nanos.tec.linutronix.de>
Message-ID: <3acb7fde-eae2-a223-9cfd-f409cc2abba6@huawei.com>
Date:   Thu, 19 Nov 2020 19:56:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87lfexp6am.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.200.65.70]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Thomas,

>>>    3) Interrupt has already been switched to managed. Double init is not
>>>       really a good sign either.
>> I just tested that and case 3) would be a problem. I don't see us
>> clearing the managed flag when free'ing the interrupt. So with
>> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y, we attempt this affinity update
>> twice, and error from the irqd_affinity_is_managed() check.
> That means the interrupt is not deallocated and reallocated, which does
> not make sense to me.
> 

Just mentioning a couple of things here, which could be a clue to what 
is going on:
- the device is behind mbigen secondary irq controller
- the flow in the LLDD is to allocate all 128 interrupts during probe, 
but we only register handlers for a subset with device managed API

Thanks,
John

