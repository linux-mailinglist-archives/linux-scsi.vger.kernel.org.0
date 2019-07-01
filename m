Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20B882BEB6
	for <lists+linux-scsi@lfdr.de>; Tue, 28 May 2019 07:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfE1Fna (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 May 2019 01:43:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfE1Fna (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 28 May 2019 01:43:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3676EAD26;
        Tue, 28 May 2019 05:43:28 +0000 (UTC)
Subject: Re: [PATCH V2 1/5] scsi: select reply queue from request's CPU
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190527150207.11372-1-ming.lei@redhat.com>
 <20190527150207.11372-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <59171e2e-bbf0-de91-efed-2c974b6df6e4@suse.com>
Date:   Tue, 28 May 2019 07:43:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527150207.11372-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/27/19 5:02 PM, Ming Lei wrote:
> Hisi_sas_v3_hw, hpsa, megaraid and mpt3sas use single blk-mq hw queue
> to submit request, meantime apply multiple private reply queues served as
> completion queue. The mapping between CPU and reply queue is setup via
> pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY) just like the usual
> blk-mq queue mapping.
> 
> These drivers always use current CPU(raw_smp_processor_id) to figure out
> the reply queue. Switch to use request's CPU to get the reply queue,
> so we can drain in-flight request via blk-mq's API before the last CPU of
> the reply queue becomes offline.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_main.c       |  5 +++--
>   drivers/scsi/hpsa.c                         |  2 +-
>   drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 ++--
>   drivers/scsi/mpt3sas/mpt3sas_base.c         | 16 ++++++++--------
>   include/scsi/scsi_cmnd.h                    | 11 +++++++++++
>   5 files changed, 25 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes


