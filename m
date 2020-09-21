Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E327261C
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgIUNqn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 09:46:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbgIUNqm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 09:46:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79D1372461913A9B08DF;
        Mon, 21 Sep 2020 21:46:38 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:46:32 +0800
Subject: Re: [PATCH -next] scsi: libsas: simplify the return expression of
 sas_discover_* functions
To:     Liu Shixin <liushixin2@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <d44beaa3-6338-9188-7cf3-338cc0120305@huawei.com>
 <20200921134558.3478922-1-liushixin2@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <95502ce3-27aa-0298-21c6-b5ea9d05b478@huawei.com>
Date:   Mon, 21 Sep 2020 21:46:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200921134558.3478922-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.92]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


ÔÚ 2020/9/21 21:45, Liu Shixin Ð´µÀ:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   drivers/scsi/libsas/sas_ata.c      | 8 +-------
>   drivers/scsi/libsas/sas_discover.c | 8 +-------
>   2 files changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index a4887985aad6..024e5a550759 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -726,19 +726,13 @@ void sas_resume_sata(struct asd_sas_port *port)
>    */
>   int sas_discover_sata(struct domain_device *dev)
>   {
> -	int res;
> -
>   	if (dev->dev_type == SAS_SATA_PM)
>   		return -ENODEV;
>   
>   	dev->sata_dev.class = sas_get_ata_command_set(dev);
>   	sas_fill_in_rphy(dev, dev->rphy);
>   
> -	res = sas_notify_lldd_dev_found(dev);
> -	if (res)
> -		return res;
> -
> -	return 0;
> +	return sas_notify_lldd_dev_found(dev);
>   }
>   
>   static void async_sas_ata_eh(void *data, async_cookie_t cookie)
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index d0f9e90e3279..161c9b387da7 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -278,13 +278,7 @@ static void sas_resume_devices(struct work_struct *work)
>    */
>   int sas_discover_end_dev(struct domain_device *dev)
>   {
> -	int res;
> -
> -	res = sas_notify_lldd_dev_found(dev);
> -	if (res)
> -		return res;
> -
> -	return 0;
> +	return sas_notify_lldd_dev_found(dev);
>   }
>   
>   /* ---------- Device registration and unregistration ---------- */
> 

Please add a version descriptor and describe the change against the
first version next time . Otherwise this looks good to me.

Reviewed-by: Jason Yan <yanaijie@huawei.com>

Thanks,
Jason
