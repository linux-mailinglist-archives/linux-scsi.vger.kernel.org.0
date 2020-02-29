Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8D17441C
	for <lists+linux-scsi@lfdr.de>; Sat, 29 Feb 2020 02:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgB2BTF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Feb 2020 20:19:05 -0500
Received: from smtp.infotech.no ([82.134.31.41]:52553 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB2BTF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 28 Feb 2020 20:19:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 765B820418D;
        Sat, 29 Feb 2020 02:19:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xm+YxwMiHhmL; Sat, 29 Feb 2020 02:18:55 +0100 (CET)
Received: from [192.168.0.18] (unknown [198.52.162.92])
        by smtp.infotech.no (Postfix) with ESMTPA id 3E5C620417C;
        Sat, 29 Feb 2020 02:18:53 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v7 24/38] sg: xarray for reqs in fd
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20200227165902.11861-1-dgilbert@interlog.com>
 <20200227165902.11861-25-dgilbert@interlog.com>
 <ad33e788-2a13-d0f5-7b0c-4ac2863ee01c@suse.de>
 <57373dbf-6edf-f24b-b528-f5d3507b032f@interlog.com>
Message-ID: <c2d51bb6-b52f-864d-cd6b-ff67f690313c@interlog.com>
Date:   Fri, 28 Feb 2020 20:18:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <57373dbf-6edf-f24b-b528-f5d3507b032f@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

See below.

On 2020-02-28 1:55 p.m., Douglas Gilbert wrote:
> On 2020-02-28 4:00 a.m., Hannes Reinecke wrote:
>> On 2/27/20 5:58 PM, Douglas Gilbert wrote:
>>> Replace the linked list and the fix arrays of requests (max 16)
>>> with an xarray. The xarray (srp_arr) has two marks: one for
>>> INACTIVE state (i.e. available for re-use) requests; the other
>>> is AWAIT state which is after the internal completion point of
>>> a request and before the user space has fetched the response.
>>>
>>> Of the five states in sg_request::rq_st, two are marked. They are
>>> SG_RS_INACTIVE and SG_RS_AWAIT_RCV. This allows the request xarray
>>> (sg_fd::srp_arr) to be searched (with xa_for_each_mark) on two
>>> embedded sub-lists. The SG_RS_INACTIVE sub-list replaces the free
>>> list. The SG_RS_AWAIT_RCV sub-list contains requests that have
>>> reached their internal completion point but have not been read/
>>> received by the user space. Add support functions for this and
>>> partially wire them up.
>>>
>>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>>> ---
>>>   drivers/scsi/sg.c | 325 +++++++++++++++++++++++++++++++++-------------
>>>   1 file changed, 238 insertions(+), 87 deletions(-)
>>>
>>> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
>>> index de4b35aabe40..ef3674b9a5dc 100644
>>> --- a/drivers/scsi/sg.c
>>> +++ b/drivers/scsi/sg.c
>>> @@ -73,7 +73,7 @@ static char *sg_version_date = "20190606";
>>>   #define SG_MAX_CDB_SIZE 252
>>>   /* Following enum contains the states of sg_request::rq_st */
>>> -enum sg_rq_state {
>>> +enum sg_rq_state {    /* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
>>>       SG_RS_INACTIVE = 0,    /* request not in use (e.g. on fl) */
>>>       SG_RS_INFLIGHT,        /* active: cmd/req issued, no response yet */
>>>       SG_RS_AWAIT_RCV,    /* have response from LLD, awaiting receive */
>>> @@ -115,6 +115,11 @@ enum sg_rq_state {
>>>   #define SG_FDEV_DETACHING    1    /* may be unexpected device removal */
>>>   #define SG_FDEV_LOG_SENSE    2    /* set by ioctl(SG_SET_DEBUG) */
>>> +/* xarray 'mark's allow sub-lists within main array/list. */
>>> +#define SG_XA_RQ_FREE XA_MARK_0    /* xarray sets+clears */
>>> +#define SG_XA_RQ_INACTIVE XA_MARK_1
>>> +#define SG_XA_RQ_AWAIT XA_MARK_2
>>> +
>>>   int sg_big_buff = SG_DEF_RESERVED_SIZE;
>>>   /*
>>>    * This variable is accessible via /proc/scsi/sg/def_reserved_size . Each
>>> @@ -154,11 +159,11 @@ struct sg_device;        /* forward declarations */
>>>   struct sg_fd;
>>>   struct sg_request {    /* SG_MAX_QUEUE requests outstanding per file */
>>> -    struct list_head entry;    /* list entry */
>>>       struct sg_scatter_hold data;    /* hold buffer, perhaps scatter list */
>>>       struct sg_io_hdr header;  /* scsi command+info, see <scsi/sg.h> */
>>>       u8 sense_b[SCSI_SENSE_BUFFERSIZE];
>>>       u32 duration;        /* cmd duration in milliseconds */
>>> +    u32 rq_idx;        /* my index within parent's srp_arr */
>>>       char res_used;        /* 1 -> using reserve buffer, 0 -> not ... */
>>>       char orphan;        /* 1 -> drop on sight, 0 -> normal */
>>>       u32 rq_result;        /* packed scsi request result from LLD */
>>> @@ -177,24 +182,23 @@ struct sg_request {    /* SG_MAX_QUEUE requests 
>>> outstanding per file */
>>>   struct sg_fd {        /* holds the state of a file descriptor */
>>>       struct sg_device *parentdp;    /* owning device */
>>>       wait_queue_head_t read_wait;    /* queue read until command done */
>>> -    spinlock_t rq_list_lock;    /* protect access to list in req_arr */
>>>       struct mutex f_mutex;    /* protect against changes in this fd */
>>>       int timeout;        /* defaults to SG_DEFAULT_TIMEOUT      */
>>>       int timeout_user;    /* defaults to SG_DEFAULT_TIMEOUT_USER */
>>>       u32 idx;        /* my index within parent's sfp_arr */
>>> -    atomic_t submitted;    /* number inflight or awaiting read */
>>> -    atomic_t waiting;    /* number of requests awaiting read */
>>> +    atomic_t submitted;    /* number inflight or awaiting receive */
>>> +    atomic_t waiting;    /* number of requests awaiting receive */
>>> +    atomic_t req_cnt;    /* number of requests */
>>>       int sgat_elem_sz;    /* initialized to scatter_elem_sz */
>>>       struct sg_scatter_hold reserve;    /* buffer for this file descriptor */
>>> -    struct list_head rq_list; /* head of request list */
>>> -    struct fasync_struct *async_qp;    /* used by asynchronous notification */
>>> -    struct sg_request req_arr[SG_MAX_QUEUE];/* use as singly-linked list */
>>>       char force_packid;    /* 1 -> pack_id input to read(), 0 -> ignored */
>>>       char cmd_q;        /* 1 -> allow command queuing, 0 -> don't */
>>>       u8 next_cmd_len;    /* 0: automatic, >0: use on next write() */
>>>       char keep_orphan;    /* 0 -> drop orphan (def), 1 -> keep for read() */
>>>       char mmap_called;    /* 0 -> mmap() never called on this fd */
>>>       char res_in_use;    /* 1 -> 'reserve' array in use */
>>> +    struct fasync_struct *async_qp;    /* used by asynchronous notification */
>>> +    struct xarray srp_arr;
>>>       struct kref f_ref;
>>>       struct execute_work ew_fd;  /* harvest all fd resources and lists */
>>>   };
>>> @@ -273,6 +277,7 @@ static const char *sg_rq_st_str(enum sg_rq_state rq_st, 
>>> bool long_str);
>>>   #if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
>>>   #define SG_LOG_BUFF_SZ 48
>>> +#define SG_LOG_ACTIVE 1
>>>   #define SG_LOG(depth, sfp, fmt, a...)                    \
>>>       do {                                \
>>> @@ -724,6 +729,119 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const 
>>> char __user *buf,
>>>       return count;
>>>   }
>>> +#if IS_ENABLED(SG_LOG_ACTIVE)
>>> +static void
>>> +sg_rq_state_fail(struct sg_fd *sfp, enum sg_rq_state exp_old_st,
>>> +         enum sg_rq_state want_st, enum sg_rq_state act_old_st,
>>> +         const char *fromp)
>>> +{
>>> +    const char *eaw_rs = "expected_old,actual_old,wanted rq_st";
>>> +
>>> +    if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
>>> +        SG_LOG(1, sfp, "%s: %s: %s: %s,%s,%s\n",
>>> +               __func__, fromp, eaw_rs,
>>> +               sg_rq_st_str(exp_old_st, false),
>>> +               sg_rq_st_str(act_old_st, false),
>>> +               sg_rq_st_str(want_st, false));
>>> +    else
>>> +        pr_info("sg: %s: %s: %s: %d,%d,%d\n", __func__, fromp, eaw_rs,
>>> +            (int)exp_old_st, (int)act_old_st, (int)want_st);
>>> +}
>>> +#endif
>>> +
>>> +static void
>>> +sg_rq_state_force(struct sg_request *srp, enum sg_rq_state new_st)
>>> +{
>>> +    bool prev, want;
>>> +    struct xarray *xafp = &srp->parentfp->srp_arr;
>>> +
>>> +    atomic_set(&srp->rq_st, new_st);
>>> +    want = (new_st == SG_RS_AWAIT_RCV);
>>> +    prev = xa_get_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
>>> +    if (prev != want) {
>>> +        if (want)
>>> +            __xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
>>> +        else
>>> +            __xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
>>> +    }
>>> +    want = (new_st == SG_RS_INACTIVE);
>>> +    prev = xa_get_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
>>> +    if (prev != want) {
>>> +        if (want)
>>> +            __xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
>>> +        else
>>> +            __xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
>>> +    }
>>> +}
>>> +
>>> +/* Following array indexed by enum sg_rq_state, 0 means no xa mark change */
>>> +static int sg_rq_state_arr[] = {1, 0, 4, 0, 0};
>>> +
>>> +static void
>>> +sg_rq_state_helper(struct sg_request *srp, enum sg_rq_state old_st,
>>> +           enum sg_rq_state new_st)
>>> +{
>>> +    int indic = sg_rq_state_arr[(int)old_st] +
>>> +            (sg_rq_state_arr[(int)new_st] << 1);
>>> +    struct xarray *xafp = &srp->parentfp->srp_arr;
>>> +
>>> +    if (indic == 0)
>>> +        return;
>>> +    if (indic & 1)        /* from inactive state */
>>> +        __xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
>>> +    else if (indic & 2)    /* to inactive state */
>>> +        __xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_INACTIVE);
>>> +    if ((indic & (4 | 8)) == 0)
>>> +        return;
>>> +    if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
>>> +        return;        /* skip AWAIT mark for sync invocations */
>>> +    if (indic & 4)        /* from await state */
>>> +        __xa_clear_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
>>> +    else if (indic & 8)    /* to await state */
>>> +        __xa_set_mark(xafp, srp->rq_idx, SG_XA_RQ_AWAIT);
>>> +}
>>> +
>>> +/*
>>> + * This function keeps the srp->rq_st state and associated marks on the
>>> + * owning xarray's element in sync. If force is true then new_st is stored
>>> + * in srp->rq_st and xarray marks are set accordingly (and old_st is
>>> + * ignored); and 0 is returned.
>>> + * If force is false, then atomic_cmpxchg() is called. If the actual
>>> + * srp->rq_st is not old_st, then -EPROTOTYPE is returned. If the actual
>>> + * srp->rq_st is old_st then it is replaced by new_st and the xarray marks
>>> + * are setup accordingly and 0 is returned. This assumes srp_arr xarray
>>> + * spinlock is held.
>>> + */
>>> +static int
>>> +sg_rq_state_chg(struct sg_request *srp, enum sg_rq_state old_st,
>>> +        enum sg_rq_state new_st, bool force, const char *fromp)
>>> +{
>>> +    unsigned long iflags;
>>> +    enum sg_rq_state act_old_st;
>>> +    struct xarray *xafp = &srp->parentfp->srp_arr;
>>> +
>>> +    if (force) {
>>> +        xa_lock_irqsave(xafp, iflags);
>>> +        sg_rq_state_force(srp, new_st);
>>> +        xa_unlock_irqrestore(xafp, iflags);
>>> +        return 0;
>>> +    }
>>> +    act_old_st = (enum sg_rq_state)atomic_cmpxchg(&srp->rq_st, old_st,
>>> +                              new_st);
>>> +    if (act_old_st != old_st) {
>>> +#if IS_ENABLED(SG_LOG_ACTIVE)
>>> +        if (fromp)
>>> +            sg_rq_state_fail(srp->parentfp, old_st, new_st,
>>> +                     act_old_st, fromp);
>>> +#endif
>>> +        return -EPROTOTYPE;    /* only used for this error type */
>>> +    }
>>> +    xa_lock_irqsave(xafp, iflags);
>>> +    sg_rq_state_helper(srp, old_st, new_st);
>>> +    xa_unlock_irqrestore(xafp, iflags);
>>> +    return 0;
>>> +}
>>
>>>   /*
>>>    * All writes and submits converge on this function to launch the SCSI
>>>    * command/request (via blk_execute_rq_nowait). Returns a pointer to a
>> The locking here is ... peculiar.
>> You first do an cmpxchg() (presumably to avoid locking), but then continue to 
>> lock the 'xsfp' structure.
>> Why not simply move the functionality of the cmpexchg() into the lock and make 
>> it a simple 'if' clause?
> 
> The atomic_cmpxchg() is about breaking a race when two threads on the same
> fd try and re-use the same inactive request on the xarray. One will succeed
> on that cmpxchg and the other with fail. Then for some (but not all) state
> transitions, the code needs to change the corresponding mark on the xarray.
> 
> Yes, I think that xa_lock_irqsave block is overkill, I'll remove it and
> take the "__" off the clear and set mark calls in the helper. And I'll test
> it for regressions as it is central to the functioning of this driver.

Nope, it ain't overkill, it is needed! One weakness of xarray locking (or
perhaps my lack of understanding *** ), is that if you let it take locks, you
are no longer interrupt safe. And in the irq routine [sg_rq_end_io()] there
is indeed a state change hence this code is invoked.

> One advantage of using xarray is that it is very good about screaming if
> it doesn't like the way its locks are being used. And the the sg driver
> uses those xarray locks almost exclusively now.

And indeed, xarray did scream!

<snip>

Doug Gilbert


*** xarray will call the _irq() spinlock variants if asked. But it will
     not call the irqsave() variants, probably because of that pesky
     iflags argument. And as LT says, the irqsave() variants are better ...
