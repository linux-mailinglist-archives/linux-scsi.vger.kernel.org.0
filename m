Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D979EB57
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Aug 2019 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfH0Omk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Aug 2019 10:42:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfH0Omk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Aug 2019 10:42:40 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2cfc-0000BW-0E; Tue, 27 Aug 2019 16:42:04 +0200
Date:   Tue, 27 Aug 2019 16:42:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
In-Reply-To: <20190827085344.30799-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1908271633450.1939@nanos.tec.linutronix.de>
References: <20190827085344.30799-1-ming.lei@redhat.com> <20190827085344.30799-2-ming.lei@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 27 Aug 2019, Ming Lei wrote:
> +/*
> + * Update average irq interval with the Exponential Weighted Moving
> + * Average(EWMA)
> + */
> +static void irq_update_interval(void)
> +{
> +#define IRQ_INTERVAL_EWMA_WEIGHT	128
> +#define IRQ_INTERVAL_EWMA_PREV_FACTOR	127
> +#define IRQ_INTERVAL_EWMA_CURR_FACTOR	(IRQ_INTERVAL_EWMA_WEIGHT - \
> +		IRQ_INTERVAL_EWMA_PREV_FACTOR)

Please do not stick defines into a function body. That's horrible.

> +
> +	int cpu = raw_smp_processor_id();
> +	struct irq_interval *inter = per_cpu_ptr(&avg_irq_interval, cpu);
> +	u64 delta = sched_clock_cpu(cpu) - inter->last_irq_end;

Why are you doing that raw_smp_processor_id() dance? The call site has
interrupts and preemption disabled.

Also how is that supposed to work when sched_clock is jiffies based?

> +	inter->avg = (inter->avg * IRQ_INTERVAL_EWMA_PREV_FACTOR +
> +		delta * IRQ_INTERVAL_EWMA_CURR_FACTOR) /
> +		IRQ_INTERVAL_EWMA_WEIGHT;

We definitely are not going to have a 64bit multiplication and division on
every interrupt. Asided of that this breaks 32bit builds all over the place.

Thanks,

	tglx




