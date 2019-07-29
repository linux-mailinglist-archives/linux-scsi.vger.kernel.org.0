Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6723B78A4A
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfG2LQ5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 07:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:38078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387475AbfG2LQ5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jul 2019 07:16:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC42DABD0;
        Mon, 29 Jul 2019 11:16:55 +0000 (UTC)
Subject: Re: [PATCH v2 05/18] sg: bitops in sg_device
To:     Douglas Gilbert <dgilbert@interlog.com>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bart.vanassche@wdc.com
References: <20190727033728.21134-1-dgilbert@interlog.com>
 <20190727033728.21134-6-dgilbert@interlog.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <09886ead-133b-ae41-cea3-00641b66e521@suse.de>
Date:   Mon, 29 Jul 2019 13:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190727033728.21134-6-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/27/19 5:37 AM, Douglas Gilbert wrote:
> Introduce bitops in sg_device to replace an atomic, a bool and a
> char. That char (sgdebug) had been reduced to only two states.
> Add some associated macros to make the code a little clearer.
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>  drivers/scsi/sg.c | 104 +++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index 9aa1b1030033..97ce84f0c51b 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -74,6 +74,11 @@ static char *sg_version_date = "20190606";
>  
>  #define SG_DEFAULT_TIMEOUT mult_frac(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
>  
> +/* Bit positions (flags) for sg_device::fdev_bm bitmask follow */
> +#define SG_FDEV_EXCLUDE		0	/* have fd open with O_EXCL */
> +#define SG_FDEV_DETACHING	1	/* may be unexpected device removal */
> +#define SG_FDEV_LOG_SENSE	2	/* set by ioctl(SG_SET_DEBUG) */
> +
>  int sg_big_buff = SG_DEF_RESERVED_SIZE;
>  /* N.B. This variable is readable and writeable via
>     /proc/scsi/sg/def_reserved_size . Each time sg_open() is called a buffer
> @@ -155,14 +160,12 @@ struct sg_device { /* holds the state of each scsi generic device */
>  	struct scsi_device *device;
>  	wait_queue_head_t open_wait;    /* queue open() when O_EXCL present */
>  	struct mutex open_rel_lock;     /* held when in open() or release() */
> -	int sg_tablesize;	/* adapter's max scatter-gather table size */
> -	u32 index;		/* device index number */
>  	struct list_head sfds;
>  	rwlock_t sfd_lock;      /* protect access to sfd list */
> -	atomic_t detaching;     /* 0->device usable, 1->device detaching */
> -	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
> +	int sg_tablesize;	/* adapter's max scatter-gather table size */
> +	u32 index;		/* device index number */
>  	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
> -	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
> +	unsigned long fdev_bm[1];	/* see SG_FDEV_* defines above */

Just use 'unsigned long fdev_bm' (or maybe 'unsigned long fdev_flags').
No point in declaring a one-entry array.

>  	struct gendisk *disk;
>  	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
>  	struct kref d_ref;
> @@ -200,6 +203,9 @@ static void sg_device_destroy(struct kref *kref);
>  #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
>  #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
>  
> +#define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
> +#define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)
> +
>  /*
>   * Kernel needs to be built with CONFIG_SCSI_LOGGING to see log messages.
>   * 'depth' is a number between 1 (most severe) and 7 (most noisy, most
> @@ -273,26 +279,26 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
>  		while (sdp->open_cnt > 0) {
>  			mutex_unlock(&sdp->open_rel_lock);
>  			retval = wait_event_interruptible(sdp->open_wait,
> -					(atomic_read(&sdp->detaching) ||
> +					(SG_IS_DETACHING(sdp) ||
>  					 !sdp->open_cnt));
>  			mutex_lock(&sdp->open_rel_lock);
>  
>  			if (retval) /* -ERESTARTSYS */
>  				return retval;
> -			if (atomic_read(&sdp->detaching))
> +			if (SG_IS_DETACHING(sdp))
>  				return -ENODEV;
>  		}
>  	} else {
> -		while (sdp->exclude) {
> +		while (SG_HAVE_EXCLUDE(sdp)) {
>  			mutex_unlock(&sdp->open_rel_lock);
>  			retval = wait_event_interruptible(sdp->open_wait,
> -					(atomic_read(&sdp->detaching) ||
> -					 !sdp->exclude));
> +					(SG_IS_DETACHING(sdp) ||
> +					 !SG_HAVE_EXCLUDE(sdp)));
>  			mutex_lock(&sdp->open_rel_lock);
>  
>  			if (retval) /* -ERESTARTSYS */
>  				return retval;
> -			if (atomic_read(&sdp->detaching))
> +			if (SG_IS_DETACHING(sdp))
>  				return -ENODEV;
>  		}
>  	}
> @@ -354,7 +360,7 @@ sg_open(struct inode *inode, struct file *filp)
>  				goto error_mutex_locked;
>  			}
>  		} else {
> -			if (sdp->exclude) {
> +			if (SG_HAVE_EXCLUDE(sdp)) {
>  				retval = -EBUSY;
>  				goto error_mutex_locked;
>  			}
> @@ -367,10 +373,10 @@ sg_open(struct inode *inode, struct file *filp)
>  
>  	/* N.B. at this point we are holding the open_rel_lock */
>  	if (o_excl)
> -		sdp->exclude = true;
> +		set_bit(SG_FDEV_EXCLUDE, sdp->fdev_bm);
>  
>  	if (sdp->open_cnt < 1) {  /* no existing opens */
> -		sdp->sgdebug = 0;
> +		clear_bit(SG_FDEV_LOG_SENSE, sdp->fdev_bm);
>  		q = sdp->device->request_queue;
>  		sdp->sg_tablesize = queue_max_segments(q);
>  	}
Do not use 'set_bit' and 'clear_bit' on their own; the do not imply any
memory barriers, so concurrent  open() calls will not necessarily see
the real value.
So either use some XX_bit() variant which returns a value (like
test_and_set_bit()), or add an explicit memory barrier.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
