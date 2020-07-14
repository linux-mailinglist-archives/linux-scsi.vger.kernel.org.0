Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9721E49E
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2020 02:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGNAh2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Jul 2020 20:37:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgGNAh1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 Jul 2020 20:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594687046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nvAaUN3/DSc+c3utpslSKECgwxMKIgbkAfFaINr4qsY=;
        b=XTXATC1fJC4yc3esPIuP4B0MpxLZCxcBIOE9xHSkcfCwD53loLzPX2SCCzZ14/ePF9Xq2Q
        3JbeKxxXLLkeAdcaHsU4dX5h334um0Lmg7wXHc26krNyDFNVvXVjzhbxJYvChfBJBLfn3a
        dz+7lFJnTpb76XagdhvwsOUAGW3Nw6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-jCExFSo7PKu8bwq-BQ5M5Q-1; Mon, 13 Jul 2020 20:37:22 -0400
X-MC-Unique: jCExFSo7PKu8bwq-BQ5M5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B081081;
        Tue, 14 Jul 2020 00:37:21 +0000 (UTC)
Received: from T590 (ovpn-12-153.pek2.redhat.com [10.72.12.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D9E5757DF;
        Tue, 14 Jul 2020 00:37:14 +0000 (UTC)
Date:   Tue, 14 Jul 2020 08:37:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: core: run queue in case of IO queueing failure
Message-ID: <20200714003710.GB308476@T590>
References: <20200708131405.3346107-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708131405.3346107-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jul 08, 2020 at 09:14:05PM +0800, Ming Lei wrote:
> IO requests may be held in scheduler queue because of resource contention.
> However, not like normal completion, when queueing request failed, we don't
> ask block layer to queue these requests, so IO hang[1] is caused.
> 
> Fix this issue by run queue when IO request failure happens.
> 
> [1] IO hang log by running heavy IO with removing scsi device
> 
> [   39.054963] scsi 13:0:0:0: rejecting I/O to dead device
> [   39.058700] scsi 13:0:0:0: rejecting I/O to dead device
> [   39.087855] sd 13:0:0:1: [sdd] Synchronizing SCSI cache
> [   39.088909] scsi 13:0:0:1: rejecting I/O to dead device
> [   39.095351] scsi 13:0:0:1: rejecting I/O to dead device
> [   39.096962] scsi 13:0:0:1: rejecting I/O to dead device
> [  247.021859] INFO: task scsi-stress-rem:813 blocked for more than 122 seconds.
> [  247.023258]       Not tainted 5.8.0-rc2 #8
> [  247.024069] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  247.025331] scsi-stress-rem D    0   813    802 0x00004000
> [  247.025334] Call Trace:
> [  247.025354]  __schedule+0x504/0x55f
> [  247.027987]  schedule+0x72/0xa8
> [  247.027991]  blk_mq_freeze_queue_wait+0x63/0x8c
> [  247.027994]  ? do_wait_intr_irq+0x7a/0x7a
> [  247.027996]  blk_cleanup_queue+0x4b/0xc9
> [  247.028000]  __scsi_remove_device+0xf6/0x14e
> [  247.028002]  scsi_remove_device+0x21/0x2b
> [  247.029037]  sdev_store_delete+0x58/0x7c
> [  247.029041]  kernfs_fop_write+0x10d/0x14f
> [  247.031281]  vfs_write+0xa2/0xdf
> [  247.032670]  ksys_write+0x6b/0xb3
> [  247.032673]  do_syscall_64+0x56/0x82
> [  247.034053]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  247.034059] RIP: 0033:0x7f69f39e9008
> [  247.036330] Code: Bad RIP value.
> [  247.036331] RSP: 002b:00007ffdd8116498 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  247.037613] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f69f39e9008
> [  247.039714] RDX: 0000000000000002 RSI: 000055cde92a0ab0 RDI: 0000000000000001
> [  247.039715] RBP: 000055cde92a0ab0 R08: 000000000000000a R09: 00007f69f3a79e80
> [  247.039716] R10: 000000000000000a R11: 0000000000000246 R12: 00007f69f3abb780
> [  247.039717] R13: 0000000000000002 R14: 00007f69f3ab6740 R15: 0000000000000002
> 
> Cc: linux-block@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/scsi_lib.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 534b85e87c80..4d7fab9e8af9 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1694,6 +1694,16 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		 */
>  		if (req->rq_flags & RQF_DONTPREP)
>  			scsi_mq_uninit_cmd(cmd);
> +
> +		/*
> +		 * Requests may be held in block layer queue because of
> +		 * resource contention. We usually run queue in normal
> +		 * completion for queuing these requests again. Block layer
> +		 * will finish this failed request simply, run queue in case
> +		 * of IO queueing failure so that requests can get chance to
> +		 * be finished.
> +		 */
> +		scsi_run_queue(q);
>  		break;
>  	}
>  	return ret;

Hello Guys,

Ping...


Thanks,
Ming

