Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38C3422C
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFDIvI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 04:51:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfFDIvI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 04:51:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5FA1FB9A7CF393333ABD;
        Tue,  4 Jun 2019 16:50:19 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 16:50:12 +0800
Subject: Re: [PATCH 0/9] blk-mq/scsi: convert private reply queue into blk_mq
 hw queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190531022801.10003-1-ming.lei@redhat.com>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Sathya Prakash" <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d1c786d8-d3a9-551b-52fb-fe6f7805e50e@huawei.com>
Date:   Tue, 4 Jun 2019 09:49:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190531022801.10003-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 31/05/2019 03:27, Ming Lei wrote:
> Hi,
>
> The 1st patch introduces support hostwide tags for multiple hw queues
> via the simplest approach to share single 'struct blk_mq_tags' instance
> among all hw queues. In theory, this way won't cause any performance drop.
> Even small IOPS improvement can be observed on random IO on
> null_blk/scsi_debug.
>
> By applying the hostwide tags for MQ, we can convert some SCSI driver's
> private reply queue into generic blk-mq hw queue, then at least two
> improvement can be obtained:
>
> 1) the private reply queue maping can be removed from drivers, since the
> mapping has been implemented as generic API in blk-mq core
>
> 2) it helps to solve the generic managed IRQ race[1] during CPU hotplug
> in generic way, otherwise we have to re-invent new way to address the
> same issue for these drivers using private reply queue.
>
>
> [1] https://lore.kernel.org/linux-block/20190527150207.11372-1-ming.lei@redhat.com/T/#m6d95e2218bdd712ffda8f6451a0bb73eb2a651af
>
> Any comment and test feedback are appreciated.
>
> Thanks,
> Ming
>

Hi Ming,

I think that we'll wait for a v2 to test this, since you gave some 
updated patch for the megaraid performance testing.

Thanks,
John

> Hannes Reinecke (1):
>   scsi: Add template flag 'host_tagset'
>
> Ming Lei (8):
>   blk-mq: allow hw queues to share hostwide tags
>   block: null_blk: introduce module parameter of 'g_host_tags'
>   scsi_debug: support host tagset
>   scsi: introduce scsi_cmnd_hctx_index()
>   scsi: hpsa: convert private reply queue to blk-mq hw queue
>   scsi: hisi_sas_v3: convert private reply queue to blk-mq hw queue
>   scsi: megaraid: convert private reply queue to blk-mq hw queue
>   scsi: mp3sas: convert private reply queue to blk-mq hw queue
>
>  block/blk-mq-debugfs.c                      |  1 +
>  block/blk-mq-sched.c                        |  8 +++
>  block/blk-mq-tag.c                          |  6 ++
>  block/blk-mq.c                              | 14 ++++
>  block/elevator.c                            |  5 +-
>  drivers/block/null_blk_main.c               |  6 ++
>  drivers/scsi/hisi_sas/hisi_sas.h            |  2 +-
>  drivers/scsi/hisi_sas/hisi_sas_main.c       | 36 +++++-----
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c      | 46 +++++--------
>  drivers/scsi/hpsa.c                         | 49 ++++++--------
>  drivers/scsi/megaraid/megaraid_sas_base.c   | 50 +++++---------
>  drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 +-
>  drivers/scsi/mpt3sas/mpt3sas_base.c         | 74 ++++-----------------
>  drivers/scsi/mpt3sas/mpt3sas_base.h         |  3 +-
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 17 +++++
>  drivers/scsi/scsi_debug.c                   |  3 +
>  drivers/scsi/scsi_lib.c                     |  2 +
>  include/linux/blk-mq.h                      |  1 +
>  include/scsi/scsi_cmnd.h                    | 15 +++++
>  include/scsi/scsi_host.h                    |  3 +
>  20 files changed, 168 insertions(+), 177 deletions(-)
>


