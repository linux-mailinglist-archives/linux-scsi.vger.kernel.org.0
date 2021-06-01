Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA65397617
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Jun 2021 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhFAPJk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Jun 2021 11:09:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3119 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhFAPJj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Jun 2021 11:09:39 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZzx5fxJz6T1ZW;
        Tue,  1 Jun 2021 22:58:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 17:07:56 +0200
Received: from [10.47.91.52] (10.47.91.52) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 16:07:55 +0100
Subject: Re: [PATCH V3 0/3] scsi: two fixes in scsi_add_host_with_dma
To:     Ming Lei <ming.lei@redhat.com>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.de>
References: <20210531050727.2353973-1-ming.lei@redhat.com>
 <d37d30cf-8293-e34e-0b4f-eebfcfa56bc9@huawei.com> <YLYx//I7J2kcnrtN@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <17786916-5e1f-8387-344c-55bb1020b09e@huawei.com>
Date:   Tue, 1 Jun 2021 16:07:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YLYx//I7J2kcnrtN@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.52]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 01/06/2021 14:11, Ming Lei wrote:
>> We don't call scsi_host_cls_release() either, so I guess a ref count is
>> leaked for shost_dev - I see its refcount is 1 at exit in
>> scsi_add_host_with_dma(). We have the device_initialize(), device_add(),
>> device_del() in the alloc and add host functions, but I don't know who is
>> responsible for the final "device put".
> Hammm, we still need to put ->shost_dev before returning the error, and the
> following delta patch can fix the issue, and it should have been wrapped
> into the 1st one.
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 22a58e453a0c..532165462a42 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -306,6 +306,8 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>   	pm_runtime_set_suspended(&shost->shost_gendev);
>   	pm_runtime_put_noidle(&shost->shost_gendev);
>    fail:
> +	/* drop ref of ->shost_dev so that caller can release this host */
> +	put_device(&shost->shost_dev);
>   	return error;
>   }
>   EXPORT_SYMBOL(scsi_add_host_with_dma);

That looks better now.

And we can see the equivalent on the normal removal path in 
scsi_remove_host() -> device_unregister(&shost->shost_dev), which does a 
device_del()+put_device().

So could we actually just have:
out_del_dev:
	unregister_dev(&shost->shost_dev)

I am not sure if we are required to keep that shost_dev reference all 
the way until the exit, as you do.

Thanks,
John
