Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA24A19AD27
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2020 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgDANvw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 Apr 2020 09:51:52 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732705AbgDANvv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 1 Apr 2020 09:51:51 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 56382A1EEE0BEBFC7BBB;
        Wed,  1 Apr 2020 14:51:50 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.170) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 14:51:48 +0100
Subject: Re: [PATCH] scsi: remove show_use_blk_mq()
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20200401134049.9352-1-yanaijie@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <57f6fde1-fe0c-68e7-f476-35d92902c6b1@huawei.com>
Date:   Wed, 1 Apr 2020 14:51:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200401134049.9352-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.170]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 01/04/2020 14:40, Jason Yan wrote:
> This code is useless now so remove it.
> 

note: I did not delete this in "scsi: core: Delete scsi_use_blk_mq", to 
avoid risk of breaking some user still using this

thanks,
John

> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/scsi/scsi_sysfs.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 163dbcb741c1..6480e27982ab 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -386,15 +386,7 @@ show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
>   }
>   static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
>   
> -static ssize_t
> -show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "1\n");
> -}
> -static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
> -
>   static struct attribute *scsi_sysfs_shost_attrs[] = {
> -	&dev_attr_use_blk_mq.attr,
>   	&dev_attr_unique_id.attr,
>   	&dev_attr_host_busy.attr,
>   	&dev_attr_cmd_per_lun.attr,
> 

