Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18F38AA4
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfFGMtk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 08:49:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39723 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfFGMtk (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Fri, 7 Jun 2019 08:49:40 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 07 Jun 2019 14:49:38 +0200
Subject: Re: [PATCH 2/3] scsi: Avoid that .queuecommand() gets called for a
 quiesced SCSI device
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-3-bvanassche@acm.org>
 <c58b16b0-84ae-f82c-9beb-5afb8dbfb663@suse.de>
 <92eed484-bdd7-401a-5bf4-640984ae960a@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <e0d70594-270b-5fcf-759e-1c0a2a6b8a13@suse.com>
Date:   Fri, 7 Jun 2019 14:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <92eed484-bdd7-401a-5bf4-640984ae960a@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/6/19 10:40 PM, Bart Van Assche wrote:
> On 6/5/19 10:50 PM, Hannes Reinecke wrote:
>> On 6/5/19 10:14 PM, Bart Van Assche wrote:
>>> Several SCSI transport and LLD drivers surround code that does not
>>> tolerate concurrent calls of .queuecommand() with scsi_target_block() /
>>> scsi_target_unblock(). These last two functions use
>>> blk_mq_quiesce_queue() / blk_mq_unquiesce_queue() for scsi-mq request
>>> queues to prevent concurrent .queuecommand() calls. However, that is
>>> not sufficient to prevent .queuecommand() calls from
>>> scsi_send_eh_cmnd().
>>> Hence surround the .queuecommand() call from the SCSI error handler with
>>> code that avoids that .queuecommand() gets called in the quiesced state.
>>>
>>> Note: converting the .queuecommand() call in scsi_send_eh_cmnd() into
>>> code that calls blk_get_request() + blk_execute_rq() is not an option
>>> since scsi_send_eh_cmnd() must be able to make forward progress even
>>> if all requests have been allocated.
>>>
>> Hmm. Have you actually observed this?
>> Typically, scsi_target_block()/scsi_target_unblock() is called prior to
>> invoking EH, to allow the system to settle and to guarantee that it's
>> fully quiesced. Only then EH is started.
>> Consequently, scsi_target_block()/scsi_target_unblock() really shouldn't
>> be called during EH; we're essentially single-threaded at this point, so
>> nothing else will be submitting command.
>> Can you explain why you need this?
> 
> Hi Hannes,
> 
> As one can see in the commit message of patch 3/3, I have observed a
> .queuecommand() call by the SCSI EH causing a crash.
> 
> The SCSI EH and blocking of SCSI devices have different triggers:
> - As one can see in scsi_times_out(), if a SCSI command times out and an
> abort has already been scheduled for that command then that command is
> handed over to the SCSI error handler. After all commands that are in
> progress have failed the error handler thread is woken up.
> - The iSCSI and SRP transport drivers call scsi_target_block() if a
> transport layer error has been observed. This can happen from another
> thread than the SCSI error handler thread and these functions can be
> called either before or after the SCSI error handler thread has been
> woken up.
> 
But then I'd rather not quiesce the queue in these circumstances, like
in this (untested) patch:

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 34eaef631064..e0bdde025d1a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2641,8 +2641,17 @@ static int scsi_internal_device_block(struct
scsi_device *sdev)

        mutex_lock(&sdev->state_mutex);
        err = scsi_internal_device_block_nowait(sdev);
-       if (err == 0)
-               blk_mq_quiesce_queue(q);
+       if (err == 0) {
+               unsigned long flags;
+
+               spin_lock_irqsave(sdev->host->host_lock, flags);
+               if (sdev->host->shost_state != SHOST_RECOVERY &&
+                   sdev->host->shost_state != SHOST_CANCEL_RECOVERY) {
+                       spin_unlock_irqrestore(sdev->host->host_lock,
flags);
+                       blk_mq_quiesce_queue(q);
+               } else
+                       spin_unlock_irqrestore(sdev->host->host_lock,
flags);
+       }
        mutex_unlock(&sdev->state_mutex);

        return err;

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
