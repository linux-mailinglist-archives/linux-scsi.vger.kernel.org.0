Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3576D1BDAA5
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Apr 2020 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2Lai (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Apr 2020 07:30:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD2Lah (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Apr 2020 07:30:37 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id AF67A8465A106A154182;
        Wed, 29 Apr 2020 12:30:35 +0100 (IST)
Received: from [127.0.0.1] (10.47.5.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 29 Apr
 2020 12:30:33 +0100
Subject: Re: [PATCH RFC v6 08/10] megaraid_sas: switch fusion adapters to MQ
From:   John Garry <john.garry@huawei.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "hare@suse.de" <hare@suse.de>,
        "don.brace@microsemi.com" <don.brace@microsemi.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "esc.storagedev@microsemi.com" <esc.storagedev@microsemi.com>,
        Hannes Reinecke <hare@suse.com>
References: <1583409280-158604-1-git-send-email-john.garry@huawei.com>
 <1583409280-158604-9-git-send-email-john.garry@huawei.com>
 <a1f0399e2e85b2244a9ae40e4a2f1089@mail.gmail.com>
 <f839f040-8bf4-cf83-7670-dfc208b77326@huawei.com>
 <7cac3eb9fd79b5b988e25da542305b35@mail.gmail.com>
 <40faaef8-8bfc-639f-747f-cacd4e61464f@huawei.com>
 <7b8c79b0453722023c6c7d53cd24441d@mail.gmail.com>
 <b759a8ed-09ba-bfe8-8916-c05ab9671cbf@huawei.com>
 <260c5decdb38db9f74994988ce7fcaf1@mail.gmail.com>
 <380d3bf2-67ee-a09a-3098-51b24b98f912@huawei.com>
 <e0c5a076-9fe5-4401-fd41-97f457888ad3@huawei.com>
 <d2ae343770a83466b870a33ffae5fa23@mail.gmail.com>
 <8e16d68b-4d71-58f1-ede9-92ffe5d65ba9@huawei.com>
 <f712fd935562dcff73f0f6cf15f9cce7@mail.gmail.com>
 <538dd70d-7edb-c66c-4205-d91f24a907ea@huawei.com>
Message-ID: <ca799ed3-0b18-2aa5-7d75-6eac5b0e6e7b@huawei.com>
Date:   Wed, 29 Apr 2020 12:29:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <538dd70d-7edb-c66c-4205-d91f24a907ea@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.5.201]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 28/04/2020 16:55, John Garry wrote:
> Hi Kashyap,
> 
>> I am using <mq-deadline> which is MQ version of SQ deadline.
>> For now we can just consider case without scheduler.
>>
>> I have some more findings. May be someone from upstream community can
>> connect the dots.
>>
>> #1. hctx_may_queue() throttle the IO at hctx level. This is eventually 
>> per
>> sdev throttling for megaraid_sas driver because It creates only one
>> context - hctx0 for each scsi device.
>>
>> If driver is using only one h/w queue,  active_queues will be always 
>> steady.
>> In my test it was 64 thread, so active_queues=64.
> 
> So I figure that 64 threads comes from 64 having disks.
> 
>> Even though <fio> thread is shared among allowed cpumask
>> (cpus_allowed_policy=shared option in fio),  active_queues will be 
>> always 64
>> because we have only one h/w queue.
>> All the logical cpus are mapped to one h/w queue. It means, thread moving
>> from one cpu to another cpu will not change active_queues per hctx.
>>
>> In case of this RFC, active_queues are now per hctx and there are 
>> multiple
>> hctx, but tags are shared. 
> 
> Right, so we need a policy to divide up the shared tags across request 
> queues, based on principle of fairness.
> 

Hi Kashyap,

How about this, which counts requests per request_queue for shared 
sbitmap instead of per hctx (and, as such, does not need to aggreate 
them in hctx_may_queue()):

---->8

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index ba68d934e3ca..0c8adecba219 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -60,9 +60,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
   * For shared tag users, we track the number of currently active users
   * and attempt to provide a fair share of the tag depth for each of them.
   */
-static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
+static inline bool hctx_may_queue(struct blk_mq_alloc_data *data,
  				  struct sbitmap_queue *bt)
  {
+	struct blk_mq_hw_ctx *hctx = data->hctx;
+	struct request_queue *q = data->q;
  	unsigned int depth, users;

  	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
@@ -84,14 +86,14 @@ static inline bool hctx_may_queue(struct 
blk_mq_hw_ctx *hctx,
  	 * Allow at least some tags
  	 */
  	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return atomic_read(&hctx->nr_active) < depth;
+	return __blk_mq_active_requests(hctx, q) < depth;
  }

  static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
  			    struct sbitmap_queue *bt)
  {
  	if (!(data->flags & BLK_MQ_REQ_INTERNAL) &&
-	    !hctx_may_queue(data->hctx, bt))
+	    !hctx_may_queue(data, bt))
  		return -1;
  	if (data->shallow_depth)
  		return __sbitmap_queue_get_shallow(bt, data->shallow_depth);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7e446f946e73..5bbd95e01f08 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -282,7 +282,7 @@ static struct request *blk_mq_rq_ctx_init(struct 
blk_mq_alloc_data *data,
  	} else {
  		if (data->hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED) {
  			rq_flags = RQF_MQ_INFLIGHT;
-			atomic_inc(&data->hctx->nr_active);
+			__blk_mq_inc_active_requests(data->hctx, data->q);
  		}
  		rq->tag = tag;
  		rq->internal_tag = -1;
@@ -502,7 +502,7 @@ void blk_mq_free_request(struct request *rq)

  	ctx->rq_completed[rq_is_sync(rq)]++;
  	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		atomic_dec(&hctx->nr_active);
+		__blk_mq_dec_active_requests(hctx, q);

  	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
  		laptop_io_completion(q->backing_dev_info);
@@ -1048,7 +1048,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
  	if (rq->tag >= 0) {
  		if (shared) {
  			rq->rq_flags |= RQF_MQ_INFLIGHT;
-			atomic_inc(&data.hctx->nr_active);
+			__blk_mq_inc_active_requests(rq->mq_hctx, rq->q);
  		}
  		data.hctx->tags->rqs[rq->tag] = rq;
  	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index dde2d29f0ce5..5ab1566c4b7d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -202,6 +202,29 @@ static inline bool 
blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
  	return true;
  }

+static inline  void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx 
*hctx, struct request_queue *q)
+{
+	if (blk_mq_is_sbitmap_shared(q->tag_set))
+		atomic_inc(&q->nr_active_requests);
+	else
+		atomic_inc(&hctx->nr_active);
+}
+
+static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx 
*hctx, struct request_queue *q)
+{
+	if (blk_mq_is_sbitmap_shared(q->tag_set))
+		atomic_dec(&q->nr_active_requests);
+	else
+		atomic_dec(&hctx->nr_active);
+}
+
+static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx, 
struct request_queue *q)
+{
+	if (blk_mq_is_sbitmap_shared(q->tag_set))
+		return atomic_read(&q->nr_active_requests);
+	return atomic_read(&hctx->nr_active);
+}
+
  static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
  					   struct request *rq)
  {
@@ -210,7 +233,7 @@ static inline void __blk_mq_put_driver_tag(struct 
blk_mq_hw_ctx *hctx,

  	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
  		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
+		__blk_mq_dec_active_requests(hctx, rq->q);
  	}
  }

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..5f2955872234 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,8 @@ struct request_queue {

  	size_t			cmd_size;

+	atomic_t nr_active_requests;
+
  	struct work_struct	release_work;

  #define BLK_MAX_WRITE_HINTS	5

> This can create unwanted throttling and
>> eventually more lock contention in sbitmap.
>> I added below patch and things improved a bit, but not a full proof.
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 586c9d6..c708fbc 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -60,10 +60,12 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>>    * For shared tag users, we track the number of currently active users
>>    * and attempt to provide a fair share of the tag depth for each of 
>> them.
>>    */
>> -static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>> +static inline bool hctx_may_queue(struct request_queue *q,
>> +                                 struct blk_mq_hw_ctx *hctx,
>>                                    struct sbitmap_queue *bt)
>>   {
>> -       unsigned int depth, users;
>> +       unsigned int depth, users, i, outstanding = 0;
>> +       struct blk_mq_hw_ctx *hctx_iter;
>>
>>          if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_SHARED))
>>                  return true;
>> @@ -84,14 +86,18 @@ static inline bool hctx_may_queue(struct 
>> blk_mq_hw_ctx
>> *hctx,
>>           * Allow at least some tags
>>           */
>>          depth = max((bt->sb.depth + users - 1) / users, 4U);
>> -       return atomic_read(&hctx->nr_active) < depth;
>> +
>> +       queue_for_each_hw_ctx(q, hctx_iter, i)
>> +               outstanding += atomic_read(&hctx_iter->nr_active);
>> +
> 
> OK,  I think that we need to find a cleaner way to do this.
> 
>> +       return outstanding < depth;
>>   }
>>
>>   static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
>>                              struct sbitmap_queue *bt)
>>   {
>>          if (!(data->flags & BLK_MQ_REQ_INTERNAL) &&
>> -           !hctx_may_queue(data->hctx, bt))
>>
>>
>> #2 - In completion path, scsi module call blk_mq_run_hw_queues() upon IO
>> completion.  I am not sure if it is good to run all the h/w queue or just
>> h/w queue of current reference is good enough.
>> Below patch helped to reduce contention in hcxt_lock().
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 610ee41..f72de2a 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -572,6 +572,7 @@ static bool scsi_end_request(struct request *req,
>> blk_status_t error,
>>          struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
>>          struct scsi_device *sdev = cmd->device;
>>          struct request_queue *q = sdev->request_queue;
>> +       struct blk_mq_hw_ctx *mq_hctx = req->mq_hctx;
>>
>>          if (blk_update_request(req, error, bytes))
>>                  return true;
>> @@ -613,7 +614,7 @@ static bool scsi_end_request(struct request *req,
>> blk_status_t error,
>>              !list_empty(&sdev->host->starved_list))
>>                  kblockd_schedule_work(&sdev->requeue_work);
>>          else
>> -               blk_mq_run_hw_queues(q, true);
>> +               blk_mq_run_hw_queue(mq_hctx, true);
> 
> Not sure on this. But, indeed, I found running all queues did add lots 
> of extra load for when enabling the deadline scheduler.
> 
>>
>>          percpu_ref_put(&q->q_usage_counter);
>>          return false;
>>
>> #3 -  __blk_mq_tag_idle() calls blk_mq_tag_wakeup_all which may not be
>> optimal for shared queue.
>> There is a penalty if we are calling __sbq_wake_up() frequently. In 
>> case of
>> nr_hw_queue = 1, things are better because one hctx and hctx->state will
>> avoid multiple calls.
>> If blk_mq_tag_wakeup_all is called from hctx0 context, there is no 
>> need to
>> call from hctx1, hctx2 etc.
>>
>> I have added below patch in my testing.
>>
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 586c9d6..5b331e5 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -53,7 +53,9 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>>
>>          atomic_dec(&tags->active_queues);
>>
>> -       blk_mq_tag_wakeup_all(tags, false);
>> +       /* TBD - Do this only for hctx->flags & 
>> BLK_MQ_F_TAG_HCTX_SHARED */
>> +       if (hctx->queue_num == 0)
>> +               blk_mq_tag_wakeup_all(tags, false);
> 
> ok, I see. But, again, I think we need to find a cleaner way to do this.
> 
>>   }
>>
>>   /*
>>
>>
>> With all above mentioned changes, I see performance improved from 2.2M 
>> IOPS
>> to 2.7M on same workload and profile.
> 
> But still short of nr_hw_queue = 1, which got 3.1M IOPS, as below, right?
> 
> Thanks,
> John
> 
>>
>>>
>>>>
>>>> Old Driver which has nr_hw_queue = 1 and I issue IOs from <fio>  queue
>>>> depth = 128. We get 3.1M IOPS in this config. This eventually exhaust
>>>> host can_queue.
>>>
>>> So I think I need to find a point where we start to get throttled.
>>>
>>>> Note - Very low contention in sbitmap_get()
>>>>
>>>> -   23.58%     0.25%  fio              [kernel.vmlinux]            [k]
>>>> blk_mq_make_request
>>>>      - 23.33% blk_mq_make_request
>>>>         - 21.68% blk_mq_get_request
>>>>            - 20.19% blk_mq_get_tag
>>>>               + 10.08% prepare_to_wait_exclusive
>>>>               + 4.51% io_schedule
>>>>               - 3.59% __sbitmap_queue_get
>>>>                  - 2.82% sbitmap_get
>>>>                       0.86% __sbitmap_get_word
>>>>                       0.75% _raw_spin_lock_irqsave
>>>>                       0.55% _raw_spin_unlock_irqrestore
>>>>
>>>> Driver with RFC which has nr_hw_queue = N and I issue IOs from <fio>
>>>> queue depth = 128. We get 2.3 M IOPS in this config. This eventually
>>>> exhaust host can_queue.
>>>> Note - Very high contention in sbitmap_get()
>>>>
>>>> -   42.39%     0.12%  fio              [kernel.vmlinux]            [k]
>>>> generic_make_request
>>>>      - 42.27% generic_make_request
>>>>         - 41.00% blk_mq_make_request
>>>>            - 38.28% blk_mq_get_request
>>>>               - 33.76% blk_mq_get_tag
>>>>                  - 30.25% __sbitmap_queue_get
>>>>                     - 29.90% sbitmap_get
>>>>                        + 9.06% _raw_spin_lock_irqsave
>>>>                        + 7.94% _raw_spin_unlock_irqrestore
>>>>                        + 3.86% __sbitmap_get_word
>>>>                        + 1.78% call_function_single_interrupt
>>>>                        + 0.67% ret_from_intr
>>>>                  + 1.69% io_schedule
>>>>                    0.59% prepare_to_wait_exclusive
>>>>                    0.55% __blk_mq_get_tag
>>>>
>>>> In this particular case, I observed alloc_hint = zeros which means,
>>>> sbitmap_get is not able to find free tags from hint. That may lead to
>>>> contention.
>>>> This condition is not happening with nr_hw_queue=1 (without RFC) 
>>>> driver.
>>>>
>>>> alloc_hint=
>>>> {663, 2425, 3060, 54, 3149, 4319, 4175, 4867, 543, 2481, 0, 4779, 377,
>>>> ***0***, 2010, 0, 909, 3350, 1546, 2179, 2875, 659, 3902, 2224, 3212,
>>>> 836, 1892, 1669, 2420, 3415, 1904, 512, 3027, 4810, 2845, 4690, 712,
>>>> 3105, 0, 0, 0, 3268, 4915, 3897, 1349, 547, 4, 733, 1765, 2068, 979,
>>>> 51, 880, 0, 370, 3520, 2877, 4097, 418, 4501, 3717, 2893, 604, 508,
>>>> 759, 3329, 4038, 4829, 715, 842, 1443, 556}
>>>>
>>>> Driver with RFC which has nr_hw_queue = N and I issue IOs from <fio>
>>>> queue depth = 32. We get 3.1M IOPS in this config. This workload does
>>>> *not* exhaust host can_queue.
>>>
>>> Please ensure .host_tagset is set for whenever nr_hw_queue = N. This 
>>> is as
>>> per
>>> RFC, and I don't think you modified from the RFC for your test.
>>> But I just wanted to mention that to be crystal clear.
>>
>> Yes I have two separate driver copy. One with RFC change and another 
>> without
>> RFC.
>>>
>>>>
>>>> -    5.07%     0.14%  fio              [kernel.vmlinux]  [k]
>>>> generic_make_request
>>>>      - 4.93% generic_make_request
>>>>         - 3.61% blk_mq_make_request
>>>>            - 2.04% blk_mq_get_request
>>>>               - 1.08% blk_mq_get_tag
>>>>                  - 0.70% __sbitmap_queue_get
>>>>                       0.67% sbitmap_get
>>>>
>>>> In summary, RFC has some performance bottleneck in sbitmap_get () if
>>>> outstanding per shost is about to exhaust.  Without this RFC also
>>>> driver works in nr_hw_queue = 1, but that case is managed very well.
>>>> I am not sure why it happens only with shared host tag ? Theoretically
>>>> all the hctx is sharing the same bitmaptag which is same as
>>>> nr_hw_queue=1, so why contention is only visible in shared host tag
>>>> case.
>>>
>>> Let me check this.
>>>
>>>>
>>>> If you want to reproduce this issue, may be you have to reduce the
>>>> can_queue in hisi_sas driver.
>>>>
>>>
>>> Thanks,
>>> John
> 

