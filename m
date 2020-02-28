Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326BB1740DC
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Feb 2020 21:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgB1UUf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 15:20:35 -0500
Received: from smtp.infotech.no ([82.134.31.41]:51780 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgB1UUf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 15:20:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 0621820418D;
        Fri, 28 Feb 2020 21:20:33 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0SBI+IfpxvPR; Fri, 28 Feb 2020 21:20:26 +0100 (CET)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 215A420416A;
        Fri, 28 Feb 2020 21:20:24 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v7 27/38] sg: add sg v4 interface support
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20200227165902.11861-1-dgilbert@interlog.com>
 <20200227165902.11861-28-dgilbert@interlog.com>
 <ed210750-42dc-1bf5-c6d8-50ac623e3b46@suse.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <6e60c2a6-ba94-833b-f631-ce91c1104c34@interlog.com>
Date:   Fri, 28 Feb 2020 15:20:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ed210750-42dc-1bf5-c6d8-50ac623e3b46@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-02-28 4:08 a.m., Hannes Reinecke wrote:
> On 2/27/20 5:58 PM, Douglas Gilbert wrote:
>> Add support for the sg v4 interface based on struct sg_io_v4 found
>> in include/uapi/linux/bsg.h and only previously supported by the
>> bsg driver. Add ioctl(SG_IOSUBMIT) and ioctl(SG_IORECEIVE) for
>> async (non-blocking) usage of the sg v4 interface. Do not accept
>> the v3 interface with these ioctls. Do not accept the v4
>> interface with this driver's existing write() and read()
>> system calls.
>>
>> For sync (blocking) usage expand the existing ioctl(SG_IO)
>> to additionally accept the sg v4 interface object.
>>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>> ---
>>   drivers/scsi/sg.c      | 458 +++++++++++++++++++++++++++++++++--------
>>   include/uapi/scsi/sg.h |  37 +++-
>>   2 files changed, 405 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>> index c2838325ac57..58ba30409790 100644
>> --- a/drivers/scsi/sg.c
>> +++ b/drivers/scsi/sg.c
>> @@ -7,8 +7,9 @@
>>    *
>>    * Original driver (sg.c):
>>    *        Copyright (C) 1992 Lawrence Foard
>> - * Version 2 and 3 extensions to driver:
>> + * Version 2, 3 and 4 extensions to driver:
>>    *        Copyright (C) 1998 - 2019 Douglas Gilbert
>> + *
>>    */
>>   static int sg_version_num = 30901;  /* [x]xyyzz where [x] empty when x=0 */
> 
> As you modify the copyright you might want to update the year, too ...

I'll do all that housekeeping in the final patch of this
series [38].

>> @@ -40,11 +41,12 @@ static char *sg_version_date = "20190606";
>>   #include <linux/atomic.h>
>>   #include <linux/ratelimit.h>
>>   #include <linux/uio.h>
>> -#include <linux/cred.h> /* for sg_check_file_access() */
>> +#include <linux/cred.h>            /* for sg_check_file_access() */
>>   #include <linux/proc_fs.h>
>>   #include <linux/xarray.h>
>> -#include "scsi.h"
>> +#include <scsi/scsi.h>
>> +#include <scsi/scsi_eh.h>
>>   #include <scsi/scsi_dbg.h>
>>   #include <scsi/scsi_host.h>
>>   #include <scsi/scsi_driver.h>
>> @@ -76,6 +78,9 @@ static struct kmem_cache *sg_sense_cache;
>>   #define SG_MEMPOOL_MIN_NR 4
>>   static mempool_t *sg_sense_pool;
>> +#define uptr64(usp_val) ((void __user *)(uintptr_t)(usp_val))
>> +#define cuptr64(usp_val) ((const void __user *)(uintptr_t)(usp_val))
>> +
>>   /* Following enum contains the states of sg_request::rq_st */
>>   enum sg_rq_state {    /* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
>>       SG_RS_INACTIVE = 0,    /* request not in use (e.g. on fl) */
>> @@ -100,6 +105,7 @@ enum sg_rq_state {    /* N.B. sg_rq_state_arr assumes 
>> SG_RS_AWAIT_RCV==2 */
>>   #define SG_ADD_RQ_MAX_RETRIES 40    /* to stop infinite _trylock(s) */
>>   /* Bit positions (flags) for sg_request::frq_bm bitmask follow */
>> +#define SG_FRQ_IS_V4I        0    /* true (set) when is v4 interface */
>>   #define SG_FRQ_IS_ORPHAN    1    /* owner of request gone */
>>   #define SG_FRQ_SYNC_INVOC    2    /* synchronous (blocking) invocation */
>>   #define SG_FRQ_DIO_IN_USE    3    /* false->indirect_IO,mmap; 1->dio */
>> @@ -165,6 +171,15 @@ struct sg_slice_hdr3 {
>>       void __user *usr_ptr;
>>   };
>> +struct sg_slice_hdr4 {    /* parts of sg_io_v4 object needed in async usage */
>> +    void __user *sbp;    /* derived from sg_io_v4::response */
>> +    u64 usr_ptr;        /* hold sg_io_v4::usr_ptr as given (u64) */
>> +    int out_resid;
>> +    s16 dir;        /* data xfer direction; SG_DXFER_*  */
>> +    u16 cmd_len;        /* truncated of sg_io_v4::request_len */
>> +    u16 max_sb_len;        /* truncated of sg_io_v4::max_response_len */
>> +};
>> +
>>   struct sg_scatter_hold {     /* holding area for scsi scatter gather info */
>>       struct page **pages;    /* num_sgat element array of struct page* */
>>       int buflen;        /* capacity in bytes (dlen<=buflen) */
>> @@ -178,7 +193,10 @@ struct sg_fd;
>>   struct sg_request {    /* active SCSI command or inactive request */
>>       struct sg_scatter_hold sgat_h;    /* hold buffer, perhaps scatter list */
>> -    struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
>> +    union {
>> +        struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
>> +        struct sg_slice_hdr4 s_hdr4; /* reduced size struct sg_io_v4 */
>> +    };
>>       u32 duration;        /* cmd duration in milliseconds */
>>       u32 rq_flags;        /* hold user supplied flags */
>>       u32 rq_idx;        /* my index within parent's srp_arr */
>> @@ -238,7 +256,10 @@ struct sg_device { /* holds the state of each scsi 
>> generic device */
>>   struct sg_comm_wr_t {  /* arguments to sg_common_write() */
>>       int timeout;
>>       unsigned long frq_bm[1];    /* see SG_FRQ_* defines above */
>> -    struct sg_io_hdr *h3p;
>> +    union {        /* selector is frq_bm.SG_FRQ_IS_V4I */
>> +        struct sg_io_hdr *h3p;
>> +        struct sg_io_v4 *h4p;
>> +    };
>>       u8 *cmnd;
>>   };
>> @@ -247,12 +268,12 @@ static void sg_rq_end_io(struct request *rq, 
>> blk_status_t status);
>>   /* Declarations of other static functions used before they are defined */
>>   static int sg_proc_init(void);
>>   static int sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
>> -            int dxfer_dir);
>> +            struct sg_io_v4 *h4p, int dxfer_dir);
>>   static void sg_finish_scsi_blk_rq(struct sg_request *srp);
>>   static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
>> -static int sg_submit(struct file *filp, struct sg_fd *sfp,
>> -             struct sg_io_hdr *hp, bool sync,
>> -             struct sg_request **o_srp);
>> +static int sg_v3_submit(struct file *filp, struct sg_fd *sfp,
>> +            struct sg_io_hdr *hp, bool sync,
>> +            struct sg_request **o_srp);
>>   static struct sg_request *sg_common_write(struct sg_fd *sfp,
>>                         struct sg_comm_wr_t *cwrp);
>>   static int sg_read_append(struct sg_request *srp, void __user *outp,
>> @@ -260,11 +281,11 @@ static int sg_read_append(struct sg_request *srp, void 
>> __user *outp,
>>   static void sg_remove_sgat(struct sg_request *srp);
>>   static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
>>   static void sg_remove_sfp(struct kref *);
>> -static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int pack_id);
>> +static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id);
>>   static struct sg_request *sg_add_request(struct sg_fd *sfp, int dxfr_len,
>>                        struct sg_comm_wr_t *cwrp);
>>   static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
>> -static struct sg_device *sg_get_dev(int dev);
>> +static struct sg_device *sg_get_dev(int min_dev);
>>   static void sg_device_destroy(struct kref *kref);
>>   static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
>>                        int db_len);
>> @@ -274,8 +295,11 @@ static const char *sg_rq_st_str(enum sg_rq_state rq_st, 
>> bool long_str);
>>   #define SZ_SG_HEADER ((int)sizeof(struct sg_header))    /* v1 and v2 header */
>>   #define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))    /* v3 header */
>> +#define SZ_SG_IO_V4 ((int)sizeof(struct sg_io_v4))  /* v4 header (in bsg.h) */
>>   #define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
>> +/* There is a assert that SZ_SG_IO_V4 >= SZ_SG_IO_HDR in first function */
>> +
>>   #define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
>>   #define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)
>>   #define SG_RS_ACTIVE(srp) (atomic_read(&(srp)->rq_st) != SG_RS_INACTIVE)
>> @@ -332,6 +356,10 @@ static const char *sg_rq_st_str(enum sg_rq_state rq_st, 
>> bool long_str);
>>   static int
>>   sg_check_file_access(struct file *filp, const char *caller)
>>   {
>> +    /* can't put following in declarations where it belongs */
>> +    compiletime_assert(SZ_SG_IO_V4 >= SZ_SG_IO_HDR,
>> +               "struct sg_io_v4 should be larger than sg_io_hdr");
>> +
>>       if (filp->f_cred != current_real_cred()) {
>>           pr_err_once("%s: process %d (%s) changed security contexts after 
>> opening file descriptor, this is not allowed.\n",
>>               caller, task_tgid_vnr(current), current->comm);
>> @@ -350,7 +378,7 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
>>   {
>>       int res = 0;
>> -    if (o_excl) {
>> +    if (unlikely(o_excl)) {
>>           while (atomic_read(&sdp->open_cnt) > 0) {
>>               mutex_unlock(&sdp->open_rel_lock);
>>               res = wait_event_interruptible
>> @@ -359,13 +387,13 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
>>                         atomic_read(&sdp->open_cnt) == 0));
>>               mutex_lock(&sdp->open_rel_lock);
>> -            if (res) /* -ERESTARTSYS */
>> +            if (unlikely(res)) /* -ERESTARTSYS */
>>                   return res;
>> -            if (SG_IS_DETACHING(sdp))
>> +            if (unlikely(SG_IS_DETACHING(sdp)))
>>                   return -ENODEV;
>>           }
>>       } else {
>> -        while (SG_HAVE_EXCLUDE(sdp)) {
>> +        while (unlikely(SG_HAVE_EXCLUDE(sdp))) {
>>               mutex_unlock(&sdp->open_rel_lock);
>>               res = wait_event_interruptible
>>                       (sdp->open_wait,
>> @@ -373,13 +401,12 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
>>                         !SG_HAVE_EXCLUDE(sdp)));
>>               mutex_lock(&sdp->open_rel_lock);
>> -            if (res) /* -ERESTARTSYS */
>> +            if (unlikely(res)) /* -ERESTARTSYS */
>>                   return res;
>> -            if (SG_IS_DETACHING(sdp))
>> +            if (unlikely(SG_IS_DETACHING(sdp)))
>>                   return -ENODEV;
>>           }
>>       }
>> -
>>       return res;
>>   }
>> @@ -393,9 +420,9 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
>>   static inline int
>>   sg_allow_if_err_recovery(struct sg_device *sdp, bool non_block)
>>   {
>> -    if (!sdp)
>> +    if (unlikely(!sdp))
>>           return -EPROTO;
>> -    if (SG_IS_DETACHING(sdp))
>> +    if (unlikely(SG_IS_DETACHING(sdp)))
>>           return -ENODEV;
>>       if (non_block)
>>           return 0;
> 
> Please move the likely/unlikely statements into a different patch.
> They don't really relate to the subject of this patch.

There is a patch for precisely that but since it's at 47, it is in
the second patchset. There has been some leakage which I'll try
to get out.

There are still some there from new code, earlier patches in this
series and patches that other people have applied to this driver.
It seems a bit perverse to take them all out just so they can
all be "cleanly" added back in, within a single patch.

Doug Gilbert

