Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD730A27
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfEaIVc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 04:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbfEaIVc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 04:21:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71E2B309B6D9;
        Fri, 31 May 2019 08:21:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2A707E5C2;
        Fri, 31 May 2019 08:21:22 +0000 (UTC)
Date:   Fri, 31 May 2019 16:21:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
Message-ID: <20190531082116.GA12106@ming.t460p>
References: <20190531074158.76923-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531074158.76923-1-hare@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 31 May 2019 08:21:31 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 31, 2019 at 09:41:58AM +0200, Hannes Reinecke wrote:
> (Resending due to missing mailing list submission)
> 
> Update v3 to support SCSI multiqueue.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 45 +++++++++++++++++-----------------
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 44 +++++++++++----------------------
>  3 files changed, 36 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
> index fc87994b5d73..4b6f32f60689 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas.h
> +++ b/drivers/scsi/hisi_sas/hisi_sas.h
> @@ -378,7 +378,6 @@ struct hisi_hba {
>  	u32 intr_coal_count;	/* Interrupt count to coalesce */
>  
>  	int cq_nvecs;
> -	unsigned int *reply_map;
>  
>  	/* debugfs memories */
>  	u32 *debugfs_global_reg;
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 8a7feb8ed8d6..f4237c4754a4 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -200,16 +200,12 @@ static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
>  	set_bit(slot_idx, bitmap);
>  }
>  
> -static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
> -				     struct scsi_cmnd *scsi_cmnd)
> +static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
>  {
>  	int index;
>  	void *bitmap = hisi_hba->slot_index_tags;
>  	unsigned long flags;
>  
> -	if (scsi_cmnd)
> -		return scsi_cmnd->request->tag;
> -
>  	spin_lock_irqsave(&hisi_hba->lock, flags);
>  	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
>  				   hisi_hba->last_slot_index + 1);

Then you switch to hisi_sas_slot_index_alloc() for allocating the unique
tag via spin_lock & find_next_zero_bit(). Do you think this way is more
efficient than blk-mq's sbitmap?

The worsen thing is that V3's actual max queue depth is (4096 - 96), but
this patch claims that the device can support (4096 - 96) * 32 command
slots, finally hisi_sas_slot_index_alloc() is used to respect the actual
max queue depth(4000).

Big contention is caused on hisi_sas_slot_index_alloc(), meantime huge
memory is wasted for request pool.



Thanks,
Ming
