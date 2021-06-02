Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3530F3986A1
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Jun 2021 12:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhFBKh5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Jun 2021 06:37:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3131 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhFBKh4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Jun 2021 06:37:56 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fw4yr50Z2z6S1W3;
        Wed,  2 Jun 2021 18:29:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 12:36:11 +0200
Received: from [10.47.91.52] (10.47.91.52) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 2 Jun 2021
 11:36:10 +0100
Subject: Re: [PATCH] scsi: libsas: check lun number valid for ata device in
 sas_queuecommand()
To:     Yufen Yu <yuyufen@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <wubo40@huawei.com>, Linuxarm <linuxarm@huawei.com>
References: <20210601070439.1236679-1-yuyufen@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ff6ec6a7-fcff-99a8-8e9e-ffdc43b4af35@huawei.com>
Date:   Wed, 2 Jun 2021 11:36:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210601070439.1236679-1-yuyufen@huawei.com>
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

On 01/06/2021 08:04, Yufen Yu wrote:
> We found that offline a ata device on hisi sas control and then
> scanning the host can probe 255 not exist devices into system.
> It can be reproduced easily as following:
> 
> Some ata devices on hisi sas v3 control:
>    [root@localhost ~]# lsscsi
>    [2:0:0:0]    disk    ATA      Samsung SSD 860  2B6Q  /dev/sda
>    [2:0:1:0]    disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdb
>    [2:0:2:0]    disk    SEAGATE  ST600MM0006      B001  /dev/sdc
> 
>   1) echo "offline" > /sys/block/sdb/device/state
>   2) echo "- - -" > /sys/class/scsi_host/host2/scan
> 
> Then, we can see another 255 not exist device in system:
>    [root@localhost ~]# lsscsi
>    [2:0:0:0]    disk    ATA      Samsung SSD 860  2B6Q  /dev/sda
>    [2:0:1:0]    disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdb
>    [2:0:1:1]    disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdh
>    ...
>    [2:0:1:254]  disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdja
>    [2:0:1:255]  disk    ATA      WDC WD2003FYYS-3 1D01  /dev/sdjb
> 
> When we try to scan the host, REPORT LUN command issued to the
> offline device (sdb) will return fail. Then it tries to do a
> sequential scan. Since only one ata device, any INQUIRY command
> will be issued to the only device (i.e. lun 0) and return success,
> no matter the lun number. So, the device whose lun number is not
> zero will also be probed into system.
> 
> We fix the probe by checking lun number valid in sas_queuecommand.
> Any lun number is not equal '0' will return fail.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

As mentioned privately, we could alternatively add a check in a slave 
alloc callback, like:

int sas_slave_alloc(struct scsi_device *sdev)
{
	if (dev_is_sata(sdev_to_domain_dev(sdev)) && sdev->lun)
		return -ENXIO;

	return 0;
}

This avoids touching the queuecommand fastpath. But not sure it is worth it.

BTW, please mention that we are doing similar to commit 2fc62e2ac, to 
cut down the commit log a bit.

> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 1bf939818c98..62a01d11df96 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -174,6 +174,12 @@ int sas_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>   	}
>   
>   	if (dev_is_sata(dev)) {
> +		/* sas ata just have one lun */
> +		if (cmd->device->lun != 0) {
> +			cmd->result = (DID_BAD_TARGET << 16);
> +			cmd->scsi_done(cmd);
> +			return res;

goto out_done is better

> +		}
>   		spin_lock_irq(dev->sata_dev.ap->lock);
>   		res = ata_sas_queuecmd(cmd, dev->sata_dev.ap);
>   		spin_unlock_irq(dev->sata_dev.ap->lock);
> 

