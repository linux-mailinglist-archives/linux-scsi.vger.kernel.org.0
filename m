Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F354A00A7
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Aug 2019 13:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH1LXx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Aug 2019 07:23:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1LXx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Aug 2019 07:23:53 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2w2d-0001b2-3b; Wed, 28 Aug 2019 13:23:07 +0200
Date:   Wed, 28 Aug 2019 13:23:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
In-Reply-To: <20190828110633.GC15524@ming.t460p>
Message-ID: <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de>
References: <20190827085344.30799-1-ming.lei@redhat.com> <20190827085344.30799-2-ming.lei@redhat.com> <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de> <20190827225827.GA5263@ming.t460p> <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de>
 <20190828110633.GC15524@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 28 Aug 2019, Ming Lei wrote:
> On Wed, Aug 28, 2019 at 01:09:44AM +0200, Thomas Gleixner wrote:
> > > > Also how is that supposed to work when sched_clock is jiffies based?
> > > 
> > > Good catch, looks ktime_get_ns() is needed.
> > 
> > And what is ktime_get_ns() returning when the only available clocksource is
> > jiffies?
> 
> IMO, it isn't one issue. If the only clocksource is jiffies, we needn't to
> expect high IO performance. Then it is fine to always handle the irq in
> interrupt context or thread context.
> 
> However, if it can be recognized runtime, irq_flood_detected() can
> always return true or false.

Right. The clocksource is determined at runtime. And if there is no high
resolution clocksource then that function will return crap.
 
> > No. Talk to Daniel. There is not going to be yet another ad hoc thingy just
> > to make block happy.
> 
> I just take a first glance at the code of 'interrupt timing', and its
> motivation is to predicate of the next occurrence of interested interrupt
> for use cases of PM, such as predicate wakeup time.
> 
> And predication could be one much more difficult thing, and its implementation
> requires to record more info: such as irq number, recent multiple irq timestamps,
> that means its overhead is a bit high. Meantime IRQS_TIMINGS should only be set
> on interested interrupt(s).

Well, yes. But it's trivial enough to utilize parts of it for your
purposes.

> Daniel, correct me if I am wrong.

Daniel could have replied, if you'd put him on Cc ....

> In theory, this patch provides one simple generic mechanism for avoiding
> IRQ flood/CPU lockup, which could be used for any devices, not only high
> performance storage.

Right, we can add a lot of things to the kernel which provide simple
generic mechanisms for special purposes and if all of them are enabled then
we are doing the same thing over and over.

Thanks,

	tglx
