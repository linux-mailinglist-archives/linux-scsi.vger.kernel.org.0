Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F1320CC
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Jun 2019 23:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFAVlc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 1 Jun 2019 17:41:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40769 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFAVlc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 1 Jun 2019 17:41:32 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so11209800ioc.7
        for <linux-scsi@vger.kernel.org>; Sat, 01 Jun 2019 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=HZBvO/kZJP15DaO1Ujux6HxYrDlwIdjR9fKR2tzQ9WU=;
        b=Ocm0fCOSISGoyALRlP3dt3Yawjgpjl9Jw8qVK6amZDykeGJ5BZKU93jQjkRLL+EovT
         8sJ9GNlEw5bCwxyZFJpLZIpkclEPeMSVdnl8frIbzDi+Ci2HdTHGFfEjIuu23Tj+kaPB
         I13MO4A+izsnn2AZCp+da+OxZDNgz6ldq6XlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=HZBvO/kZJP15DaO1Ujux6HxYrDlwIdjR9fKR2tzQ9WU=;
        b=nZcgmBowyX5L8tilVRfErkXZQCscCS/8LKwe8Q60Ds2D58bY+R2NaOQnph3E9E4jNk
         h5RGXFrnBt0akRODznr6ykvf04PJ1x3wIl5tzHQt4r+5/3fHlgVvoCjnn6fFCsDctC2c
         ReWqxf3KC9fNfGk0V4y+hU3wlKYaEG3qjNrD0h+8/25rcJBG2LSp0F6FryCIQb5IlIPG
         lwsU5C5Y07zSzFzQx7/FlwmL6/x0iB5Bvqv3KVS/IxBQFHMrpa0t7HIt0KMBRV+6DwjQ
         8KE+lTrRjS+FA2n8D+1obkaZbymtwtLGpUjcfuX//QWykSra/JvNCdQ+bSD4xl5vaYYq
         cpaA==
X-Gm-Message-State: APjAAAXXzNIuVXTGguzP6yVAnUvmGHfYZ6cY7atvZEGCASt5fLjEJ2X8
        MPjZOzaKo0MjPm+Ig+kFCYVjQi19T+vXbfUOSfZ1xQ==
X-Google-Smtp-Source: APXvYqz5qsyXFIwPtaNK5xibAdfuZNcebRG37ZoowTm/Cn3DElfYJq8NOmbGIkEfkXRynjdshMgTatUYFkl1yuVVaVc=
X-Received: by 2002:a6b:691d:: with SMTP id e29mr10217457ioc.96.1559425291225;
 Sat, 01 Jun 2019 14:41:31 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190531022801.10003-1-ming.lei@redhat.com> <20190531022801.10003-9-ming.lei@redhat.com>
In-Reply-To: <20190531022801.10003-9-ming.lei@redhat.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQISV99IJucrELCJ7/TtkhttwnBgjgOGFSeupfChmtA=
Date:   Sun, 2 Jun 2019 03:11:26 +0530
Message-ID: <7819e1a523b9e8227e3a9d188ee1e083@mail.gmail.com>
Subject: RE: [PATCH 8/9] scsi: megaraid: convert private reply queue to blk-mq
 hw queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> SCSI's reply qeueue is very similar with blk-mq's hw queue, both
assigned by
> IRQ vector, so map te private reply queue into blk-mq's hw queue via
> .host_tagset.
>
> Then the private reply mapping can be removed.
>
> Another benefit is that the request/irq lost issue may be solved in
generic
> approach because managed IRQ may be shutdown during CPU hotplug.

Ming,

I quickly tested this patch series on MegaRaid Aero controller. Without
this patch I can get 3.0M IOPS, but once I apply this patch I see only
1.2M IOPS (40% Performance drop)
HBA supports 5089 can_queue.

<perf top> output without  patch -

    3.39%  [megaraid_sas]  [k] complete_cmd_fusion
     3.36%  [kernel]        [k] scsi_queue_rq
     3.26%  [kernel]        [k] entry_SYSCALL_64
     2.57%  [kernel]        [k] syscall_return_via_sysret
     1.95%  [megaraid_sas]  [k] megasas_build_and_issue_cmd_fusion
     1.88%  [kernel]        [k] _raw_spin_lock_irqsave
     1.79%  [kernel]        [k] gup_pmd_range
     1.73%  [kernel]        [k] _raw_spin_lock
     1.68%  [kernel]        [k] __sched_text_start
     1.19%  [kernel]        [k] irq_entries_start
     1.13%  [kernel]        [k] scsi_dec_host_busy
     1.08%  [kernel]        [k] aio_complete
     1.07%  [kernel]        [k] read_tsc
     1.01%  [kernel]        [k] blk_mq_get_request
     0.93%  [kernel]        [k] __update_load_avg_cfs_rq
     0.92%  [kernel]        [k] aio_read_events
     0.91%  [kernel]        [k] lookup_ioctx
     0.91%  fio             [.] fio_gettime
     0.87%  [kernel]        [k] set_next_entity
     0.87%  [megaraid_sas]  [k] megasas_build_ldio_fusion

<perf top> output with  patch -

    11.30%  [kernel]       [k] native_queued_spin_lock_slowpath
     3.37%  [kernel]       [k] sbitmap_any_bit_set
     2.91%  [kernel]       [k] blk_mq_run_hw_queue
     2.32%  [kernel]       [k] _raw_spin_lock_irqsave
     2.29%  [kernel]       [k] menu_select
     2.04%  [kernel]       [k] entry_SYSCALL_64
     2.03%  [kernel]       [k] __sched_text_start
     1.70%  [kernel]       [k] scsi_queue_rq
     1.66%  [kernel]       [k] _raw_spin_lock
     1.58%  [kernel]       [k] syscall_return_via_sysret
     1.33%  [kernel]       [k] native_write_msr
     1.20%  [kernel]       [k] read_tsc
     1.13%  [kernel]       [k] blk_mq_run_hw_queues
     1.13%  [kernel]       [k] __sbq_wake_up
     1.01%  [kernel]       [k] irq_entries_start
     1.00%  [kernel]       [k] switch_mm_irqs_off
     0.99%  [kernel]       [k] gup_pmd_range
     0.98%  [kernel]       [k] __update_load_avg_cfs_rq
     0.98%  [kernel]       [k] set_next_entity
     0.92%  [kernel]       [k] do_idle

Kashyap
