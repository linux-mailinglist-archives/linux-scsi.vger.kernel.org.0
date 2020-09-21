Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D95272493
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUNG2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 09:06:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgIUNG1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Sep 2020 09:06:27 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 14C2077031D4F8552A14;
        Mon, 21 Sep 2020 14:06:25 +0100 (IST)
Received: from [127.0.0.1] (10.210.166.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 14:06:24 +0100
Subject: Re: [PATCH -next] scsi: libsas: simplify the return expression of
 sas_discover_end_dev
To:     Liu Shixin <liushixin2@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200921082453.2592137-1-liushixin2@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d44beaa3-6338-9188-7cf3-338cc0120305@huawei.com>
Date:   Mon, 21 Sep 2020 14:03:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200921082453.2592137-1-liushixin2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.25]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 21/09/2020 09:24, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>   drivers/scsi/libsas/sas_discover.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
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

You can make a similar change at the end of sas_discover_data() [and 
include in the same patch]
