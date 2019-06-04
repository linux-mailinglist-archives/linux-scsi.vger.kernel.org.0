Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E303471D
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfFDMmL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 08:42:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727394AbfFDMmL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 08:42:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0AE9E2FBFC136E0DAC60;
        Tue,  4 Jun 2019 20:42:08 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 20:41:57 +0800
Subject: Re: [PATCH] scsi: kill useless scsi_use_blk_mq
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190604114416.26924-1-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e2045ba0-2825-3563-c982-6a3acc93e63a@huawei.com>
Date:   Tue, 4 Jun 2019 13:41:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190604114416.26924-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 04/06/2019 12:44, Jason Yan wrote:
> The legacy path is gone and we do not have to choose mq or not. The
> module parameter scsi_use_blk_mq is useless now.
>

Can you look to also remove scsi_host_template.force_blk_mq? It only 
looks to be set (in virtio_scsi.c) and not read.

cheers

> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/scsi/scsi.c       | 4 ----
>  drivers/scsi/scsi_priv.h  | 1 -
>  drivers/scsi/scsi_sysfs.c | 8 --------
>  3 files changed, 13 deletions(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 653d5ea6c5d9..7049aabb86e0 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -765,10 +765,6 @@ MODULE_LICENSE("GPL");
>  module_param(scsi_logging_level, int, S_IRUGO|S_IWUSR);
>  MODULE_PARM_DESC(scsi_logging_level, "a bit mask of logging levels");
>
> -/* This should go away in the future, it doesn't do anything anymore */
> -bool scsi_use_blk_mq = true;
> -module_param_named(use_blk_mq, scsi_use_blk_mq, bool, S_IWUSR | S_IRUGO);
> -
>  static int __init init_scsi(void)
>  {
>  	int error;
> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index 5f21547b2ad2..a4f0741524d8 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -29,7 +29,6 @@ extern int scsi_init_hosts(void);
>  extern void scsi_exit_hosts(void);
>
>  /* scsi.c */
> -extern bool scsi_use_blk_mq;
>  int scsi_init_sense_cache(struct Scsi_Host *shost);
>  void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd);
>  #ifdef CONFIG_SCSI_LOGGING
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index dbb206c90ecf..403832ee17e0 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -386,15 +386,7 @@ show_host_busy(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR(host_busy, S_IRUGO, show_host_busy, NULL);
>
> -static ssize_t
> -show_use_blk_mq(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "1\n");
> -}
> -static DEVICE_ATTR(use_blk_mq, S_IRUGO, show_use_blk_mq, NULL);
> -
>  static struct attribute *scsi_sysfs_shost_attrs[] = {
> -	&dev_attr_use_blk_mq.attr,
>  	&dev_attr_unique_id.attr,
>  	&dev_attr_host_busy.attr,
>  	&dev_attr_cmd_per_lun.attr,
>


