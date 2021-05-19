Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464BD388ED4
	for <lists+linux-scsi@lfdr.de>; Wed, 19 May 2021 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbhESNTl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 May 2021 09:19:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3032 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbhESNTl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 May 2021 09:19:41 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlYHs37PNzQjF5;
        Wed, 19 May 2021 21:14:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 21:18:19 +0800
Received: from [10.47.87.246] (10.47.87.246) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 14:18:16 +0100
Subject: Re: [PATCH -next resend] scsi: hisi_sas: drop free_irq of
 devm_request_irq allocated irq
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>
References: <20210519130519.2661938-1-yangyingliang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <351f5f06-e992-d22a-5ad5-d3d749155ae0@huawei.com>
Date:   Wed, 19 May 2021 14:17:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210519130519.2661938-1-yangyingliang@huawei.com>
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

On 19/05/2021 14:05, Yang Yingliang wrote:
> irq allocated with devm_request_irq should not be freed using
> free_irq, because doing so causes a dangling pointer, and a
> subsequent double free.
> 
> Reported-by: Hulk Robot<hulkci@huawei.com>
> Signed-off-by: Yang Yingliang<yangyingliang@huawei.com>
> ---

Acked-by: John Garry <john.garry@huawei.com>
