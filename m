Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB4414EF9
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Sep 2021 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhIVRZN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Sep 2021 13:25:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3850 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhIVRZN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Sep 2021 13:25:13 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HF4p36N62z67Ljg;
        Thu, 23 Sep 2021 01:21:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 19:23:41 +0200
Received: from [10.47.82.229] (10.47.82.229) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 18:23:40 +0100
Subject: Re: [PATCH 45/84] libsas: Call scsi_done() directly
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jason Yan <yanaijie@huawei.com>, Yufen Yu <yuyufen@huawei.com>
References: <20210918000607.450448-1-bvanassche@acm.org>
 <20210918000607.450448-46-bvanassche@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fc3473cc-e859-da6b-2b17-1ff47ac000a3@huawei.com>
Date:   Wed, 22 Sep 2021 18:26:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210918000607.450448-46-bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.229]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 18/09/2021 01:05, Bart Van Assche wrote:
> Conditional statements are faster than indirect calls.

Some might say safer as well

> Hence call
> scsi_done() directly.
> 
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>

Reviewed-by: John Garry <john.garry@huawei.com>

