Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9539A4F1
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Jun 2021 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFCPpA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Jun 2021 11:45:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3150 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCPo7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Jun 2021 11:44:59 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fwqbn6J8pz6J8kh;
        Thu,  3 Jun 2021 23:30:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:43:13 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 16:43:13 +0100
Subject: Re: [PATCH 0/4] scsi: fix failure handling of alloc/add host
To:     Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
References: <20210602133029.2864069-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6fb17d5f-d266-58b8-40be-eae970f84e47@huawei.com>
Date:   Thu, 3 Jun 2021 16:43:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210602133029.2864069-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 02/06/2021 14:30, Ming Lei wrote:
> Hello Martin,
> 
> Fix failure handling of alloc/add host code, and related device release
> handling.
> 
> 
> Ming Lei (4):
>    scsi: core: fix error handling of scsi_host_alloc
>    scsi: core: fix failure handling of scsi_add_host_with_dma
>    scsi: core: put .shost_dev in failure path if host state becomes
>      running
>    scsi: core: only put parent device if host state isn't in
>      SHOST_CREATED
> 
>   drivers/scsi/hosts.c | 47 ++++++++++++++++++++++++--------------------
>   1 file changed, 26 insertions(+), 21 deletions(-)
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Hannes Reinecke <hare@suse.de>
> 

I tested a single error path in each of scsi_host_alloc() and 
scsi_add_host_with_dma(), and it looked ok, so:

Tested-by: John Garry <john.garry@huawei.com>
