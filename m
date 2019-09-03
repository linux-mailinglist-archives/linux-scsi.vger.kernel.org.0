Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF0FA6390
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2019 10:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfICIKg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 3 Sep 2019 04:10:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIKg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 3 Sep 2019 04:10:36 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i53t4-0002J5-HG; Tue, 03 Sep 2019 10:10:02 +0200
Date:   Tue, 3 Sep 2019 10:09:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
In-Reply-To: <20190903072848.GA22170@ming.t460p>
Message-ID: <alpine.DEB.2.21.1909031000460.1880@nanos.tec.linutronix.de>
References: <20190827225827.GA5263@ming.t460p> <alpine.DEB.2.21.1908280104330.1939@nanos.tec.linutronix.de> <20190828110633.GC15524@ming.t460p> <alpine.DEB.2.21.1908281316230.1869@nanos.tec.linutronix.de> <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de> <20190903033001.GB23861@ming.t460p> <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org> <20190903063125.GA21022@ming.t460p> <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 3 Sep 2019, Ming Lei wrote:
> Scheduler can do nothing if the CPU is taken completely by handling
> interrupt & softirq, so seems not a scheduler problem, IMO.

Well, but thinking more about it, the solution you are proposing is more a
bandaid than anything else.

If you look at the networking NAPI mechanism. It handles that situation
gracefully by:

  - Disabling the interrupt at the device level

  - Polling the device in softirq context until empty and then reenabling
    interrupts

  - In case the softirq handles more packets than a defined budget it
    forces the softirq into the softirqd thread context which also
    allows rescheduling once the budget is completed.

With your adhoc workaround you handle one specific case. But it does not
work at all when an overload situation occurs in a case where the queues
are truly per cpu simply. Because then the interrupt and the thread
affinity are the same and single CPU targets and you replace the interrupt
with a threaded handler which runs by default with RT priority.

So instead of hacking something half baken into the hard/softirq code, why
can't block do a budget limitation and once that is reached switch to
something NAPI like as a general solution?

Thanks,

	tglx
