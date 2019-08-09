Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76B87CFF
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 16:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406320AbfHIOny convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Fri, 9 Aug 2019 10:43:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34688 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHIOnx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Aug 2019 10:43:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so39753345pgc.1
        for <linux-scsi@vger.kernel.org>; Fri, 09 Aug 2019 07:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=54w5llfHVG7BpJ18bUZ+mQCZmt3GMuv42cbQDc8Jzw0=;
        b=MU3ZnaM6VLnPeqQg9R0v72Y+ntkN/VdCn9+GaepDLUZXEUTw6pm3wxuI3ltqV0NHMo
         tKCwJAK7MJ6z+hx+YoppRD9KvarW61zfzzjf5hBvgwl74aHZmOTNjPnFsBIF8YmZOd5K
         r9dUvM8lAUhScRxvyFeW7ulGEJK+URO9Qm/atrYEYQVnbfFQLLPswlrIN6YrHL0kq7hu
         b5wR4XRsTlmDTMCOKBQp22J6+A9qvbuFXd4ExehKn+iCjW4DYGqvHrxUcky1G1EpRmOb
         HsTLaa4Dmn8ebznQja8vrKaMqBn2VDixeDL8BJ5OppGulJUm4bVXrIPmEKNM6gI5W67w
         SXOw==
X-Gm-Message-State: APjAAAUHXqGEuoMDfKHYAiXbeoUOqlKps/GiuNmRGfDJb+iAcS6JPnmI
        1QiAEqUPAZsf97lr6CWTtUI=
X-Google-Smtp-Source: APXvYqxg7EFj+k0d/HGBk7M5ydjonBd+yUFjwbMuJqeCKF73oNIAMxbSZwLKbHcl6XAm4xepN2Kzng==
X-Received: by 2002:a62:e301:: with SMTP id g1mr20926131pfh.119.1565361832146;
        Fri, 09 Aug 2019 07:43:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4001:6530:4350:6e15:abcd:4554? ([2601:647:4001:6530:4350:6e15:abcd:4554])
        by smtp.gmail.com with ESMTPSA id r1sm90431864pgv.70.2019.08.09.07.43.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 07:43:51 -0700 (PDT)
Subject: Re: [PATCH] SCSI: fix queue cleanup race before
 scsi_requeue_run_queue is done
To:     zhengbin <zhengbin13@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, ming.lei@redhat.com,
        linux-scsi@vger.kernel.org
Cc:     houtao1@huawei.com, yanaijie@huawei.com
References: <1565341433-110262-1-git-send-email-zhengbin13@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <41353fa5-fbcf-7c4a-0186-4238cef877b0@acm.org>
Date:   Fri, 9 Aug 2019 07:43:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565341433-110262-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/9/19 2:03 AM, zhengbin wrote:
> KASAN reports a use-after-free in 4.19-stable,
> which won't happen after commit 47cdee29ef9d
> ("block: move blk_exit_queue into __blk_release_queue").
> However, backport this patch to 4.19-stable will be a lot of work and
> the risk is great. Moreover, we should make sure scsi_requeue_run_queue
> is done before blk_cleanup_queue in master too.
> 
> BUG: KASAN: use-after-free in dd_has_work+0x50/0xe8
> Read of size 8 at addr ffff808b57c6f168 by task kworker/53:1H/6910
> 
> CPU: 53 PID: 6910 Comm: kworker/53:1H Kdump: loaded Tainted: G
> Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.59 01/31/2019
> Workqueue: kblockd scsi_requeue_run_queue
> Call trace:
>  dump_backtrace+0x0/0x270
>  show_stack+0x24/0x30
>  dump_stack+0xb4/0xe4
>  print_address_description+0x68/0x278
>  kasan_report+0x204/0x330
>  __asan_load8+0x88/0xb0
>  dd_has_work+0x50/0xe8
>  blk_mq_run_hw_queue+0x19c/0x218
>  blk_mq_run_hw_queues+0x7c/0xb0
>  scsi_run_queue+0x3ec/0x520
>  scsi_requeue_run_queue+0x2c/0x38
>  process_one_work+0x2e4/0x6d8
>  worker_thread+0x6c/0x6a8
>  kthread+0x1b4/0x1c0
>  ret_from_fork+0x10/0x18
> 
> Allocated by task 46843:
>  kasan_kmalloc+0xe0/0x190
>  kmem_cache_alloc_node_trace+0x10c/0x258
>  dd_init_queue+0x68/0x190
>  blk_mq_init_sched+0x1cc/0x300
>  elevator_init_mq+0x90/0xe0
>  blk_mq_init_allocated_queue+0x700/0x728
>  blk_mq_init_queue+0x48/0x90
>  scsi_mq_alloc_queue+0x34/0xb0
>  scsi_alloc_sdev+0x340/0x530
>  scsi_probe_and_add_lun+0x46c/0x1260
>  __scsi_scan_target+0x1b8/0x7b0
>  scsi_scan_target+0x140/0x150
>  fc_scsi_scan_rport+0x164/0x178 [scsi_transport_fc]
>  process_one_work+0x2e4/0x6d8
>  worker_thread+0x6c/0x6a8
>  kthread+0x1b4/0x1c0
>  ret_from_fork+0x10/0x18
> 
> Freed by task 46843:
>  __kasan_slab_free+0x120/0x228
>  kasan_slab_free+0x10/0x18
>  kfree+0x88/0x218
>  dd_exit_queue+0x5c/0x78
>  blk_mq_exit_sched+0x104/0x130
>  elevator_exit+0xa8/0xc8
>  blk_exit_queue+0x48/0x78
>  blk_cleanup_queue+0x170/0x248
>  __scsi_remove_device+0x84/0x1b0
>  scsi_probe_and_add_lun+0xd00/0x1260
>  __scsi_scan_target+0x1b8/0x7b0
>  scsi_scan_target+0x140/0x150
>  fc_scsi_scan_rport+0x164/0x178 [scsi_transport_fc]
>  process_one_work+0x2e4/0x6d8
>  worker_thread+0x6c/0x6a8
>  kthread+0x1b4/0x1c0
>  ret_from_fork+0x10/0x18
> 
> Fixes: 8dc765d438f1 ("SCSI: fix queue cleanup race before queue initialization is done")
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 11e64b5..e5ef180 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -531,6 +531,11 @@ void scsi_requeue_run_queue(struct work_struct *work)
>  	sdev = container_of(work, struct scsi_device, requeue_work);
>  	q = sdev->request_queue;
>  	scsi_run_queue(q);
> +	/*
> +	 * need to put q_usage_counter which
> +	 * is got in scsi_end_request.
> +	 */
> +	percpu_ref_put(&q->q_usage_counter);
>  }
> 
>  void scsi_run_host_queues(struct Scsi_Host *shost)
> @@ -615,10 +620,11 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
>  	if (scsi_target(sdev)->single_lun ||
>  	    !list_empty(&sdev->host->starved_list))
>  		kblockd_schedule_work(&sdev->requeue_work);
> -	else
> +	else {
>  		blk_mq_run_hw_queues(q, true);
> +		percpu_ref_put(&q->q_usage_counter);
> +	}
> 
> -	percpu_ref_put(&q->q_usage_counter);
>  	return false;
>  }

Can kblockd_schedule_work() return 0? If so, should percpu_ref_put() be
called in that case?

Bart.

