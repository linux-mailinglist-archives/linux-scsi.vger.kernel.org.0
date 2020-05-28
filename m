Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205211E68D7
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2020 19:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405652AbgE1RuQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 May 2020 13:50:16 -0400
Received: from smtp.infotech.no ([82.134.31.41]:57691 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405580AbgE1RuO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 28 May 2020 13:50:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 4420820423B;
        Thu, 28 May 2020 19:50:11 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yGUgEze9YaoH; Thu, 28 May 2020 19:50:04 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 81A6D204179;
        Thu, 28 May 2020 19:50:03 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 3/4] scsi: move target device list to xarray
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20200528163625.110184-1-hare@suse.de>
 <20200528163625.110184-4-hare@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <a6b85428-f32c-e57b-fa3e-e376400819ac@interlog.com>
Date:   Thu, 28 May 2020 13:50:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528163625.110184-4-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-05-28 12:36 p.m., Hannes Reinecke wrote:
> Use xarray for device lookup by target. LUNs below 256 are linear,
> and can be used directly as the index into the xarray.
> LUNs above 256 have a distinct LUN format, and are not necessarily
> linear. They'll be stored in indices above 256 in the xarray, with
> the next free index in the xarray.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   drivers/scsi/scsi.c        | 32 +++++++++++++++++++-------------
>   drivers/scsi/scsi_lib.c    |  9 ++++-----
>   drivers/scsi/scsi_scan.c   |  3 +--
>   drivers/scsi/scsi_sysfs.c  | 17 +++++++++++++++--
>   include/scsi/scsi_device.h |  4 ++--
>   5 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index d601424e32b2..9dbbc51a1eb5 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -601,13 +601,14 @@ static struct scsi_target *__scsi_target_lookup(struct Scsi_Host *shost,
>   void starget_for_each_device(struct scsi_target *starget, void *data,
>   		     void (*fn)(struct scsi_device *, void *))
>   {
> -	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
>   	struct scsi_device *sdev;
> +	unsigned long lun_id = 0;
>   
> -	shost_for_each_device(sdev, shost) {
> -		if ((sdev->channel == starget->channel) &&
> -		    (sdev->id == starget->id))
> -			fn(sdev, data);
> +	xa_for_each(&starget->devices, lun_id, sdev) {
> +		if (scsi_device_get(sdev))
> +			continue;
> +		fn(sdev, data);
> +		scsi_device_put(sdev);
>   	}
>   }
>   EXPORT_SYMBOL(starget_for_each_device);
> @@ -629,14 +630,11 @@ EXPORT_SYMBOL(starget_for_each_device);
>   void __starget_for_each_device(struct scsi_target *starget, void *data,
>   			       void (*fn)(struct scsi_device *, void *))
>   {
> -	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
>   	struct scsi_device *sdev;
> +	unsigned long lun_id = 0;
>   
> -	__shost_for_each_device(sdev, shost) {
> -		if ((sdev->channel == starget->channel) &&
> -		    (sdev->id == starget->id))
> -			fn(sdev, data);
> -	}
> +	xa_for_each(&starget->devices, lun_id, sdev)
> +		fn(sdev, data);
>   }
>   EXPORT_SYMBOL(__starget_for_each_device);
>   
> @@ -659,11 +657,19 @@ struct scsi_device *__scsi_device_lookup_by_target(struct scsi_target *starget,
>   						   u64 lun)
>   {
>   	struct scsi_device *sdev;
> +	unsigned long lun_idx = 256;
> +
> +	if (lun < lun_idx) {
> +		sdev = xa_load(&starget->devices, lun);
> +		if (sdev && sdev->sdev_state == SDEV_DEL)
> +			sdev = NULL;
> +		return sdev;
> +	}
>   
> -	list_for_each_entry(sdev, &starget->devices, same_target_siblings) {
> +	xa_for_each(&starget->devices, lun_idx, sdev) {
>   		if (sdev->sdev_state == SDEV_DEL)
>   			continue;
> -		if (sdev->lun ==lun)
> +		if (sdev->lun == lun)
>   			return sdev;
>   	}
>   
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index c163fa22267c..f9829fc0d84e 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -361,9 +361,9 @@ static void scsi_kick_queue(struct request_queue *q)
>   static void scsi_single_lun_run(struct scsi_device *current_sdev)
>   {
>   	struct Scsi_Host *shost = current_sdev->host;
> -	struct scsi_device *sdev, *tmp;
> +	struct scsi_device *sdev;
>   	struct scsi_target *starget = scsi_target(current_sdev);
> -	unsigned long flags;
> +	unsigned long flags, lun_id = 0;
>   
>   	spin_lock_irqsave(shost->host_lock, flags);
>   	starget->starget_sdev_user = NULL;
> @@ -380,8 +380,7 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
>   	spin_lock_irqsave(shost->host_lock, flags);
>   	if (starget->starget_sdev_user)
>   		goto out;
> -	list_for_each_entry_safe(sdev, tmp, &starget->devices,
> -			same_target_siblings) {
> +	xa_for_each(&starget->devices, lun_id, sdev) {
>   		if (sdev == current_sdev)
>   			continue;
>   		if (scsi_device_get(sdev))
> @@ -390,7 +389,7 @@ static void scsi_single_lun_run(struct scsi_device *current_sdev)
>   		spin_unlock_irqrestore(shost->host_lock, flags);
>   		scsi_kick_queue(sdev->request_queue);
>   		spin_lock_irqsave(shost->host_lock, flags);
> -	
> +
>   		scsi_device_put(sdev);
>   	}
>    out:
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index dc2656df495b..c7aba9ba5c0c 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -235,7 +235,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
>   	mutex_init(&sdev->state_mutex);
>   	sdev->sdev_state = SDEV_CREATED;
>   	INIT_LIST_HEAD(&sdev->siblings);
> -	INIT_LIST_HEAD(&sdev->same_target_siblings);
>   	INIT_LIST_HEAD(&sdev->starved_entry);
>   	INIT_LIST_HEAD(&sdev->event_list);
>   	spin_lock_init(&sdev->list_lock);
> @@ -417,7 +416,7 @@ static struct scsi_target *scsi_alloc_target(struct device *parent,
>   	starget->id = id;
>   	starget->channel = channel;
>   	starget->can_queue = 0;
> -	INIT_LIST_HEAD(&starget->devices);
> +	xa_init(&starget->devices);
>   	starget->state = STARGET_CREATED;
>   	starget->scsi_level = SCSI_2;
>   	starget->max_target_blocked = SCSI_DEFAULT_TARGET_BLOCKED;
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 95aaa96ce03b..27c19232f175 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -434,6 +434,7 @@ static void scsi_device_cls_release(struct device *class_dev)
>   static void scsi_device_dev_release_usercontext(struct work_struct *work)
>   {
>   	struct scsi_device *sdev;
> +	struct scsi_target *starget;
>   	struct device *parent;
>   	struct list_head *this, *tmp;
>   	struct scsi_vpd *vpd_pg80 = NULL, *vpd_pg83 = NULL;
> @@ -441,6 +442,7 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
>   	unsigned long flags;
>   
>   	sdev = container_of(work, struct scsi_device, ew.work);
> +	starget = sdev->sdev_target;
>   
>   	scsi_dh_release_device(sdev);
>   
> @@ -448,7 +450,7 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
>   
>   	spin_lock_irqsave(sdev->host->host_lock, flags);
>   	list_del(&sdev->siblings);
> -	list_del(&sdev->same_target_siblings);
> +	xa_erase(&starget->devices, sdev->lun_idx);
>   	list_del(&sdev->starved_entry);
>   	spin_unlock_irqrestore(sdev->host->host_lock, flags);
>   
> @@ -1621,7 +1623,18 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
>   
>   	transport_setup_device(&sdev->sdev_gendev);
>   	spin_lock_irqsave(shost->host_lock, flags);
> -	list_add_tail(&sdev->same_target_siblings, &starget->devices);
> +	if (sdev->lun < 256) {
> +		sdev->lun_idx = sdev->lun;
> +		WARN_ON(xa_insert(&starget->devices, sdev->lun_idx,
> +				   sdev, GFP_KERNEL) < 0);

You have interrupts masked again, so GFP_KERNEL is a non-no.

Also, like most modern kernel libraries, xarray returns 0 for good
and a negated errno for an error. If you are going to WARN, I would
like to know what that negated errno is.

> +	} else {
> +		struct xa_limit scsi_lun_limit = {
> +			.min = 256,
> +			.max = UINT_MAX,
> +		};
> +		WARN_ON(xa_alloc(&starget->devices, &sdev->lun_idx,
> +				  sdev, scsi_lun_limit, GFP_KERNEL) < 0);

dito

> +	}
>   	list_add_tail(&sdev->siblings, &shost->__devices);
>   	spin_unlock_irqrestore(shost->host_lock, flags);
>   	/*
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index 28034cc0fce5..2c6b9d8bc40e 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -104,7 +104,6 @@ struct scsi_device {
>   
>   	/* the next two are protected by the host->host_lock */
>   	struct list_head    siblings;   /* list of all devices on this host */
> -	struct list_head    same_target_siblings; /* just the devices sharing same target id */
>   
>   	atomic_t device_busy;		/* commands actually active on LLDD */
>   	atomic_t device_blocked;	/* Device returned QUEUE_FULL. */
> @@ -123,6 +122,7 @@ struct scsi_device {
>   
>   	unsigned int id, channel;
>   	u64 lun;

Is 'lun' a T10 LUN as in a big-endian array of bytes, converted to a 64 bit
native unsigned integer, or is that the Linux 8 no, 16 no, 32 no, 64 bit
hack? /* A comment might help there. */

> +	unsigned int lun_idx;		/* Index into target device xarray */

Xarray gives you _two_ choices for the type of an index :-)
It is either u32 (as used in xa_alloc() and its variants) _or_
unsigned long (as used everywhere else in xarray where an index
is needed). So it's definitely 32 bits for xa_alloc() and either
32 or 64 bits for the rest of xarray depending on the machine
architecture.
Matthew Wilcox may care to explain why this is ...

By using 'unsigned int lun_idx;' you make a confusing picture even
more so. A comment wouldn't hurt there either since the splat the
compiler spits out it if you use 'unsigned int' for the second argument
to the xa_for_each() macro [which is called 'index'] is not very
instructive. [That macro takes the address of the given index and
feeds it to xa_find_after() which expects 'unsigned long *' .]

>   	unsigned int manufacturer;	/* Manufacturer of device, for using
>   					 * vendor-specific cmd's */
>   	unsigned sector_size;	/* size in bytes */
> @@ -285,7 +285,7 @@ enum scsi_target_state {
>   struct scsi_target {
>   	struct scsi_device	*starget_sdev_user;
>   	struct list_head	siblings;
> -	struct list_head	devices;
> +	struct xarray		devices;
>   	struct device		dev;
>   	struct kref		reap_ref; /* last put renders target invisible */
>   	unsigned int		channel;
> 

