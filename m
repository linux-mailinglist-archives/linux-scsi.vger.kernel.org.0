Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9648AE1AD
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Sep 2019 02:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfIJAYv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Sep 2019 20:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbfIJAYv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 9 Sep 2019 20:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 326AF10576D5;
        Tue, 10 Sep 2019 00:24:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FDDE5C21F;
        Tue, 10 Sep 2019 00:24:39 +0000 (UTC)
Date:   Tue, 10 Sep 2019 08:24:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Long Li <longli@microsoft.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190910002433.GA20557@ming.t460p>
References: <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <20190906141858.GA3953@localhost.localdomain>
 <CY4PR21MB0741091795CEE3D4624977CFCEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190906221920.GA12290@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906221920.GA12290@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Tue, 10 Sep 2019 00:24:50 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, Sep 07, 2019 at 06:19:20AM +0800, Ming Lei wrote:
> On Fri, Sep 06, 2019 at 05:50:49PM +0000, Long Li wrote:
> > >Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
> > >
> > >On Fri, Sep 06, 2019 at 09:48:21AM +0800, Ming Lei wrote:
> > >> When one IRQ flood happens on one CPU:
> > >>
> > >> 1) softirq handling on this CPU can't make progress
> > >>
> > >> 2) kernel thread bound to this CPU can't make progress
> > >>
> > >> For example, network may require softirq to xmit packets, or another
> > >> irq thread for handling keyboards/mice or whatever, or rcu_sched may
> > >> depend on that CPU for making progress, then the irq flood stalls the
> > >> whole system.
> > >>
> > >> >
> > >> > AFAIU, there are fast medium where the responses to requests are
> > >> > faster than the time to process them, right?
> > >>
> > >> Usually medium may not be faster than CPU, now we are talking about
> > >> interrupts, which can be originated from lots of devices concurrently,
> > >> for example, in Long Li'test, there are 8 NVMe drives involved.
> > >
> > >Why are all 8 nvmes sharing the same CPU for interrupt handling?
> > >Shouldn't matrix_find_best_cpu_managed() handle selecting the least used
> > >CPU from the cpumask for the effective interrupt handling?
> > 
> > The tests run on 10 NVMe disks on a system of 80 CPUs. Each NVMe disk has 32 hardware queues.
> 
> Then there are total 320 NVMe MSI/X vectors, and 80 CPUs, so irq matrix
> can't avoid effective CPUs overlapping at all.
> 
> > It seems matrix_find_best_cpu_managed() has done its job, but we may still have CPUs that service several hardware queues mapped from other issuing CPUs.
> > Another thing to consider is that there may be other managed interrupts on the system, so NVMe interrupts may not end up evenly distributed on such a system.
> 
> Another improvement could be to try to not overlap effective CPUs among
> vectors of fast device first, meantime allow the overlap between slow
> vectors and fast vectors.
> 
> This way could improve in case that total fast vectors are <= nr_cpu_cores.

For this particular case, it can't be done, because:

1) this machine has 10 NUMA nodes, and each NVMe has 8 hw queues, so too
many CPUs are assigned to the 1st two hw queues, see the code branch of
'if (numvecs <= nodes)' in __irq_build_affinity_masks().

2) then less CPUs are assigned to the other 6 hw queues

3) finally same effective CPU is shared by two IRQ vector.

Also looks matrix_find_best_cpu_managed() has been doing well enough for
choosing best effective CPU.


Thanks,
Ming
