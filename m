Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469B837711
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfFFOqM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 10:46:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46865 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfFFOqM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 10:46:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so1669976qtn.13
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 07:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nXvnI3/fiUyY/K7aQymnRrDfNYYM8tBF1mYSPjSQ9M=;
        b=VnQkljykvzRdM5YhWu1EiDYBm5JzDAYvV1TF0as0NdstxhX8nMFw/GVikK390K7CkA
         vpJIwsaJLTmFppQFIi7k9AQzA0kQHpa+IdSCKPHsk8BggDgCwFExFOVCR70q5dycQVUc
         Qgm7cN350nNgoSQgf0SFEP4idVflLsfwOHbZ5a1Kk+ja6s96/B1oUBDeM2aBIaIpW6tb
         JSpaD8kzMSVi0x6SNFsI5kJPfsRUpI4hjOp6UlSIJYqAP0x56VxUNXsLzgLJLDRCfJ85
         UDni0bfIJ5MVKcgCndnjpBKqh2FPIuEy/TzqA+DeYQBg1DpUMW5kiu+/EffJS/tua3Fr
         qdRg==
X-Gm-Message-State: APjAAAW/IbAY+bOxqMrsfwDt3Xr00S6akgCQ+cp8ncJA78q9JzjWmtPV
        ch6V1oKx2ufX9PWsDZ9rI3i1Pg==
X-Google-Smtp-Source: APXvYqzzIGoecbgT0QXrhU7vGOyZcreRMENpTcoZs8YjPp+ULA5oeLlvg4S5OlOiBrsPIuJdf7KJLw==
X-Received: by 2002:ac8:1e15:: with SMTP id n21mr15347313qtl.20.1559832371175;
        Thu, 06 Jun 2019 07:46:11 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-aa45-cafe-5682-368f.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-aa45-cafe-5682-368f.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:aa45:cafe:5682:368f])
        by smtp.gmail.com with ESMTPSA id u26sm436630qtc.33.2019.06.06.07.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:46:10 -0700 (PDT)
Message-ID: <77fd56a6e5173dffc6d8ca5bd570aa39e14fdc2e.camel@redhat.com>
Subject: Re: [PATCH 3/3] RDMA/srp: Fix a sleep-in-invalid-context bug
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Date:   Thu, 06 Jun 2019 10:46:04 -0400
In-Reply-To: <20190605201435.233701-4-bvanassche@acm.org>
References: <20190605201435.233701-1-bvanassche@acm.org>
         <20190605201435.233701-4-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2019-06-05 at 13:14 -0700, Bart Van Assche wrote:
> The previous patch guarantees that srp_queuecommand() does not get
> invoked while reconnecting occurs. Hence remove the code from
> srp_queuecommand() that prevents command queueing while reconnecting.
> This patch avoids that the following can appear in the kernel log:
> 
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:747
> in_atomic(): 1, irqs_disabled(): 0, pid: 5600, name: scsi_eh_9
> 1 lock held by scsi_eh_9/5600:
>  #0:  (rcu_read_lock){....}, at: [<00000000cbb798c7>]
> __blk_mq_run_hw_queue+0xf1/0x1e0
> Preemption disabled at:
> [<00000000139badf2>] __blk_mq_delay_run_hw_queue+0x78/0xf0
> CPU: 9 PID: 5600 Comm: scsi_eh_9 Tainted: G        W        4.15.0-
> rc4-dbg+ #1
> Hardware name: Dell Inc. PowerEdge R720/0VWT90, BIOS 2.5.4 01/22/2016
> Call Trace:
>  dump_stack+0x67/0x99
>  ___might_sleep+0x16a/0x250 [ib_srp]
>  __mutex_lock+0x46/0x9d0
>  srp_queuecommand+0x356/0x420 [ib_srp]
>  scsi_dispatch_cmd+0xf6/0x3f0
>  scsi_queue_rq+0x4a8/0x5f0
>  blk_mq_dispatch_rq_list+0x73/0x440
>  blk_mq_sched_dispatch_requests+0x109/0x1a0
>  __blk_mq_run_hw_queue+0x131/0x1e0
>  __blk_mq_delay_run_hw_queue+0x9a/0xf0
>  blk_mq_run_hw_queue+0xc0/0x1e0
>  blk_mq_start_hw_queues+0x2c/0x40
>  scsi_run_queue+0x18e/0x2d0
>  scsi_run_host_queues+0x22/0x40
>  scsi_error_handler+0x18d/0x5f0
>  kthread+0x11c/0x140
>  ret_from_fork+0x24/0x30
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c
> b/drivers/infiniband/ulp/srp/ib_srp.c
> index be9ddcad8f28..b7c5a35f7daa 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -2338,7 +2338,6 @@ static void srp_handle_qp_err(struct ib_cq *cq,
> struct ib_wc *wc,
>  static int srp_queuecommand(struct Scsi_Host *shost, struct
> scsi_cmnd *scmnd)
>  {
>  	struct srp_target_port *target = host_to_target(shost);
> -	struct srp_rport *rport = target->rport;
>  	struct srp_rdma_ch *ch;
>  	struct srp_request *req;
>  	struct srp_iu *iu;
> @@ -2348,16 +2347,6 @@ static int srp_queuecommand(struct Scsi_Host
> *shost, struct scsi_cmnd *scmnd)
>  	u32 tag;
>  	u16 idx;
>  	int len, ret;
> -	const bool in_scsi_eh = !in_interrupt() && current == shost-
> >ehandler;
> -
> -	/*
> -	 * The SCSI EH thread is the only context from which
> srp_queuecommand()
> -	 * can get invoked for blocked devices (SDEV_BLOCK /
> -	 * SDEV_CREATED_BLOCK). Avoid racing with srp_reconnect_rport()
> by
> -	 * locking the rport mutex if invoked from inside the SCSI EH.
> -	 */
> -	if (in_scsi_eh)
> -		mutex_lock(&rport->mutex);
>  
>  	scmnd->result = srp_chkready(target->rport);
>  	if (unlikely(scmnd->result))
> @@ -2426,13 +2415,7 @@ static int srp_queuecommand(struct Scsi_Host
> *shost, struct scsi_cmnd *scmnd)
>  		goto err_unmap;
>  	}
>  
> -	ret = 0;
> -
> -unlock_rport:
> -	if (in_scsi_eh)
> -		mutex_unlock(&rport->mutex);
> -
> -	return ret;
> +	return 0;
>  
>  err_unmap:
>  	srp_unmap_data(scmnd, ch, req);
> @@ -2454,7 +2437,7 @@ static int srp_queuecommand(struct Scsi_Host
> *shost, struct scsi_cmnd *scmnd)
>  		ret = SCSI_MLQUEUE_HOST_BUSY;
>  	}
>  
> -	goto unlock_rport;
> +	return ret;
>  }
>  
>  /*

Based on prior patch this looks good to me.
I will also test it
Reviewed-by: Laurence Oberman <loberman@redjat.com>

