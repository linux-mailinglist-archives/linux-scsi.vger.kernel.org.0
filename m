Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990BA38A00D
	for <lists+linux-scsi@lfdr.de>; Thu, 20 May 2021 10:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhETIrU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 May 2021 04:47:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4697 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhETIrU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 May 2021 04:47:20 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm3Cz0hzPz16Q1R;
        Thu, 20 May 2021 16:43:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 16:45:57 +0800
Received: from [10.47.87.246] (10.47.87.246) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 09:45:55 +0100
Subject: Re: [PATCH] scsi: hisi_sas: propagate errors in
 interrupt_init_v1_hw()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
References: <49ba93a3-d427-7542-d85a-b74fe1a33a73@omp.ru>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3cbaf195-6f08-24e0-0eaa-f50616573c04@huawei.com>
Date:   Thu, 20 May 2021 09:44:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <49ba93a3-d427-7542-d85a-b74fe1a33a73@omp.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.246]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 19/05/2021 20:20, Sergey Shtylyov wrote:
> After the commit 6c11dc060427 ("scsi: hisi_sas: Fix IRQ checks") we have
> the error codes returned by platform_get_irq() ready for the propagation
> upsream in interrupt_init_v1_hw() -- that will fix still broken deferred
> probing. Let's propagate the error codes from devm_request_irq() as well
> since I don't see the reason to override them with -ENOENT...
> 
> Fixes: df2d8213d9e3 ("hisi_sas: use platform_get_irq()")

Personally I would drop the fixes tag. I am almost sure that this HW is 
not used any longer. And I don't see a point in this change being picked 
up by stable.

> Signed-off-by: Sergey Shtylyov<s.shtylyov@omp.ru>

Acked-by: John Garry <john.garry@huawei.com>
