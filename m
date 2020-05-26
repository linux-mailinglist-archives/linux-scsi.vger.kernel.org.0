Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EBF1DAC9A
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2020 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETHwl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 May 2020 03:52:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgETHwl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 20 May 2020 03:52:41 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 335CA3100B71746184BD;
        Wed, 20 May 2020 08:52:39 +0100 (IST)
Received: from [127.0.0.1] (10.210.167.247) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 20 May
 2020 08:52:38 +0100
Subject: Re: [PATCH] ata: libata: Remove unused parameter in function
 ata_sas_port_alloc()
To:     chenxiang <chenxiang66@hisilicon.com>, <tj@kernel.org>,
        <martin.petersen@oracle.com>, <brking@us.ibm.com>
CC:     <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, c00284940 <c00284940@huawei.com>
References: <1589958442-70575-1-git-send-email-chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8815c2e4-6e6e-8ce8-f7d8-b2c8eef788bf@huawei.com>
Date:   Wed, 20 May 2020 08:51:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1589958442-70575-1-git-send-email-chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.247]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 20/05/2020 08:07, chenxiang wrote:
> From: c00284940 <c00284940@huawei.com>

Hi Xiang Chen,

Please ensure author is same as signed-off person.

Thanks

> 
> Input Parameter shost in function ata_sas_port_alloc() is not used, so
> remove it.
> 
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>   drivers/ata/libata-sata.c     | 4 +---
>   drivers/scsi/ipr.c            | 2 +-
>   drivers/scsi/libsas/sas_ata.c | 2 +-
>   include/linux/libata.h        | 2 +-
>   4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index c16423e..a3c83fe 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1070,7 +1070,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
>    *	port_alloc - Allocate port for a SAS attached SATA device
>    *	@host: ATA host container for all SAS ports
>    *	@port_info: Information from low-level host driver
> - *	@shost: SCSI host that the scsi device is attached to
>    *
>    *	LOCKING:
>    *	PCI/etc. bus probe sem.
> @@ -1080,8 +1079,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_change_queue_depth);
>    */
>   
>   struct ata_port *ata_sas_port_alloc(struct ata_host *host,
> -				    struct ata_port_info *port_info,
> -				    struct Scsi_Host *shost)
> +				    struct ata_port_info *port_info)
>   {
>   	struct ata_port *ap;
>   
> diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
> index 7d77997..331c41c 100644
> --- a/drivers/scsi/ipr.c
> +++ b/drivers/scsi/ipr.c
> @@ -4816,7 +4816,7 @@ static int ipr_target_alloc(struct scsi_target *starget)
>   		if (!sata_port)
>   			return -ENOMEM;
>   
> -		ap = ata_sas_port_alloc(&ioa_cfg->ata_host, &sata_port_info, shost);
> +		ap = ata_sas_port_alloc(&ioa_cfg->ata_host, &sata_port_info);
>   		if (ap) {
>   			spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
>   			sata_port->ioa_cfg = ioa_cfg;
> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
> index 5d716d3..0cdfae9 100644
> --- a/drivers/scsi/libsas/sas_ata.c
> +++ b/drivers/scsi/libsas/sas_ata.c
> @@ -549,7 +549,7 @@ int sas_ata_init(struct domain_device *found_dev)
>   
>   	ata_host_init(ata_host, ha->dev, &sas_sata_ops);
>   
> -	ap = ata_sas_port_alloc(ata_host, &sata_port_info, shost);
> +	ap = ata_sas_port_alloc(ata_host, &sata_port_info);
>   	if (!ap) {
>   		pr_err("ata_sas_port_alloc failed.\n");
>   		rc = -ENODEV;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 8bf5e59..5a6fb80 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1228,7 +1228,7 @@ extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   extern int ata_slave_link_init(struct ata_port *ap);
>   extern void ata_sas_port_destroy(struct ata_port *);
>   extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
> -					   struct ata_port_info *, struct Scsi_Host *);
> +					   struct ata_port_info *);
>   extern void ata_sas_async_probe(struct ata_port *ap);
>   extern int ata_sas_sync_probe(struct ata_port *ap);
>   extern int ata_sas_port_init(struct ata_port *);
> 

