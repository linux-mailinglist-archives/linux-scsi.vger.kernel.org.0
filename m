Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34178BE1
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbfG2MiH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 08:38:07 -0400
Received: from smtp.infotech.no ([82.134.31.41]:35793 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387903AbfG2MiH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jul 2019 08:38:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B9570204247;
        Mon, 29 Jul 2019 14:38:04 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WiPz5yHo4Frb; Mon, 29 Jul 2019 14:38:04 +0200 (CEST)
Received: from [82.134.31.183] (unknown [82.134.31.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 7FCE020414E;
        Mon, 29 Jul 2019 14:38:04 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v2 05/18] sg: bitops in sg_device
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bart.vanassche@wdc.com
References: <20190727033728.21134-1-dgilbert@interlog.com>
 <20190727033728.21134-6-dgilbert@interlog.com>
 <09886ead-133b-ae41-cea3-00641b66e521@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <089c55b2-6023-bbf0-f436-d9d2f598e51e@interlog.com>
Date:   Mon, 29 Jul 2019 14:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <09886ead-133b-ae41-cea3-00641b66e521@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019-07-29 1:16 p.m., Hannes Reinecke wrote:
> On 7/27/19 5:37 AM, Douglas Gilbert wrote:
>> Introduce bitops in sg_device to replace an atomic, a bool and a
>> char. That char (sgdebug) had been reduced to only two states.
>> Add some associated macros to make the code a little clearer.
>>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>> ---
>>   drivers/scsi/sg.c | 104 +++++++++++++++++++++++-----------------------
>>   1 file changed, 53 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>> index 9aa1b1030033..97ce84f0c51b 100644
>> --- a/drivers/scsi/sg.c
>> +++ b/drivers/scsi/sg.c
>> @@ -74,6 +74,11 @@ static char *sg_version_date = "20190606";
>>   
>>   #define SG_DEFAULT_TIMEOUT mult_frac(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
>>   
>> +/* Bit positions (flags) for sg_device::fdev_bm bitmask follow */
>> +#define SG_FDEV_EXCLUDE		0	/* have fd open with O_EXCL */
>> +#define SG_FDEV_DETACHING	1	/* may be unexpected device removal */
>> +#define SG_FDEV_LOG_SENSE	2	/* set by ioctl(SG_SET_DEBUG) */
>> +
>>   int sg_big_buff = SG_DEF_RESERVED_SIZE;
>>   /* N.B. This variable is readable and writeable via
>>      /proc/scsi/sg/def_reserved_size . Each time sg_open() is called a buffer
>> @@ -155,14 +160,12 @@ struct sg_device { /* holds the state of each scsi generic device */
>>   	struct scsi_device *device;
>>   	wait_queue_head_t open_wait;    /* queue open() when O_EXCL present */
>>   	struct mutex open_rel_lock;     /* held when in open() or release() */
>> -	int sg_tablesize;	/* adapter's max scatter-gather table size */
>> -	u32 index;		/* device index number */
>>   	struct list_head sfds;
>>   	rwlock_t sfd_lock;      /* protect access to sfd list */
>> -	atomic_t detaching;     /* 0->device usable, 1->device detaching */
>> -	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
>> +	int sg_tablesize;	/* adapter's max scatter-gather table size */
>> +	u32 index;		/* device index number */
>>   	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
>> -	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
>> +	unsigned long fdev_bm[1];	/* see SG_FDEV_* defines above */
> 
> Just use 'unsigned long fdev_bm' (or maybe 'unsigned long fdev_flags').
> No point in declaring a one-entry array.

The point is to make the invocations cleaner by removing the need for
"&" on the second argument of bitops.

I find it easier on the eye and less error prone to read:
     set_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm);

than:
     set_bit(SG_FDEV_EXCLUDE, &sdp->fdev_bm);

include/linux/fdtable.h uses the same technique with
full_fds_bits_init and full_fds_bits.

It also makes the code more robust if the number of flags became larger
than sizeof(unsigned long)*8 . That is unlikely to be the case here.

>>   	struct gendisk *disk;
>>   	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
>>   	struct kref d_ref;
>> @@ -200,6 +203,9 @@ static void sg_device_destroy(struct kref *kref);
>>   #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
>>   #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
>>   
>> +#define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
>> +#define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)
>> +
>>   /*
>>    * Kernel needs to be built with CONFIG_SCSI_LOGGING to see log messages.
>>    * 'depth' is a number between 1 (most severe) and 7 (most noisy, most
>> @@ -273,26 +279,26 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
>>   		while (sdp->open_cnt > 0) {
>>   			mutex_unlock(&sdp->open_rel_lock);
>>   			retval = wait_event_interruptible(sdp->open_wait,
>> -					(atomic_read(&sdp->detaching) ||
>> +					(SG_IS_DETACHING(sdp) ||
>>   					 !sdp->open_cnt));
>>   			mutex_lock(&sdp->open_rel_lock);
>>   
>>   			if (retval) /* -ERESTARTSYS */
>>   				return retval;
>> -			if (atomic_read(&sdp->detaching))
>> +			if (SG_IS_DETACHING(sdp))
>>   				return -ENODEV;
>>   		}
>>   	} else {
>> -		while (sdp->exclude) {
>> +		while (SG_HAVE_EXCLUDE(sdp)) {
>>   			mutex_unlock(&sdp->open_rel_lock);
>>   			retval = wait_event_interruptible(sdp->open_wait,
>> -					(atomic_read(&sdp->detaching) ||
>> -					 !sdp->exclude));
>> +					(SG_IS_DETACHING(sdp) ||
>> +					 !SG_HAVE_EXCLUDE(sdp)));
>>   			mutex_lock(&sdp->open_rel_lock);
>>   
>>   			if (retval) /* -ERESTARTSYS */
>>   				return retval;
>> -			if (atomic_read(&sdp->detaching))
>> +			if (SG_IS_DETACHING(sdp))
>>   				return -ENODEV;
>>   		}
>>   	}
>> @@ -354,7 +360,7 @@ sg_open(struct inode *inode, struct file *filp)
>>   				goto error_mutex_locked;
>>   			}
>>   		} else {
>> -			if (sdp->exclude) {
>> +			if (SG_HAVE_EXCLUDE(sdp)) {
>>   				retval = -EBUSY;
>>   				goto error_mutex_locked;
>>   			}
>> @@ -367,10 +373,10 @@ sg_open(struct inode *inode, struct file *filp)
>>   
>>   	/* N.B. at this point we are holding the open_rel_lock */
>>   	if (o_excl)
>> -		sdp->exclude = true;
>> +		set_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm);
>>   
>>   	if (sdp->open_cnt < 1) {  /* no existing opens */
>> -		sdp->sgdebug = 0;
>> +		clear_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm);
>>   		q = sdp->device->request_queue;
>>   		sdp->sg_tablesize = queue_max_segments(q);
>>   	}
> Do not use 'set_bit' and 'clear_bit' on their own; the do not imply any
> memory barriers, so concurrent  open() calls will not necessarily see
> the real value.

That code is inside a critical section protected by a mutex that
establishes a seq_cst ordering. So maybe it should be __clear_bit()
instead.

However there may be other unprotected instances that need that
change. I will check that.

> So either use some XX_bit() variant which returns a value (like
> test_and_set_bit()), or add an explicit memory barrier.
> 
> Cheers,
> 
> Hannes
> 

