Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4117F49928
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 08:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfFRGpt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 02:45:49 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:60297 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfFRGpt (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Tue, 18 Jun 2019 02:45:49 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 18 Jun 2019 08:25:47 +0200
Subject: Re: [PATCH v4 2/3] scsi: Avoid that .queuecommand() gets called for a
 blocked SCSI device
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
References: <20190617151820.241583-1-bvanassche@acm.org>
 <20190617151820.241583-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <5b534026-6581-d2fe-ac8f-3cf20d64b3e6@suse.com>
Date:   Tue, 18 Jun 2019 08:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617151820.241583-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/17/19 5:18 PM, Bart Van Assche wrote:
> Several SCSI transport and LLD drivers surround code that does not
> tolerate concurrent calls of .queuecommand() with scsi_target_block() /
> scsi_target_unblock(). These last two functions use
> blk_mq_quiesce_queue() / blk_mq_unquiesce_queue() for scsi-mq request
> queues to prevent concurrent .queuecommand() calls. However, that is
> not sufficient to prevent .queuecommand() calls from scsi_send_eh_cmnd().
> Hence surround the .queuecommand() call from the SCSI error handler with
> code that avoids that .queuecommand() gets called in the blocked state.
> 
> Note: converting the .queuecommand() call in scsi_send_eh_cmnd() into
> code that calls blk_get_request() + blk_execute_rq() is not an option
> since scsi_send_eh_cmnd() must be able to make forward progress even
> if all requests have been allocated.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_error.c | 26 ++++++++++++++++++++++++--
>  drivers/scsi/scsi_lib.c   |  4 ----
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 8e9680572b9f..d516dd1b824d 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -1054,7 +1054,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
>  	struct scsi_device *sdev = scmd->device;
>  	struct Scsi_Host *shost = sdev->host;
>  	DECLARE_COMPLETION_ONSTACK(done);
> -	unsigned long timeleft = timeout;
> +	unsigned long timeleft = timeout, delay;
>  	struct scsi_eh_save ses;
>  	const unsigned long stall_for = msecs_to_jiffies(100);
>  	int rtn;
> @@ -1065,7 +1065,29 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
>  
>  	scsi_log_send(scmd);
>  	scmd->scsi_done = scsi_eh_done;
> -	rtn = shost->hostt->queuecommand(shost, scmd);
> +
> +	/*
> +	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
> +	 * change the SCSI device state after we have examined it and before
> +	 * .queuecommand() is called.
> +	 */
> +	mutex_lock(&sdev->state_mutex);
> +	while (sdev->sdev_state == SDEV_BLOCK && timeleft > 0) {
> +		mutex_unlock(&sdev->state_mutex);
> +		SCSI_LOG_ERROR_RECOVERY(5, sdev_printk(KERN_DEBUG, sdev,
> +			"%s: state %d <> %d\n", __func__, sdev->sdev_state,
> +			SDEV_BLOCK));
> +		delay = min(timeleft, stall_for);
> +		timeleft -= delay;
> +		msleep(jiffies_to_msecs(delay));
> +		mutex_lock(&sdev->state_mutex);
> +	}
> +	if (sdev->sdev_state != SDEV_BLOCK)
> +		rtn = shost->hostt->queuecommand(shost, scmd);
> +	else
> +		rtn = SCSI_MLQUEUE_DEVICE_BUSY;
> +	mutex_unlock(&sdev->state_mutex);
> +
>  	if (rtn) {
>  		if (timeleft > stall_for) {
>  			scsi_eh_restore_cmnd(scmd, &ses);
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index b4a63e4fcf73..ec5b4b5bc011 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2632,10 +2632,6 @@ EXPORT_SYMBOL_GPL(scsi_internal_device_block_nowait);
>   * a legal transition). When the device is in this state, command processing
>   * is paused until the device leaves the SDEV_BLOCK state. See also
>   * scsi_internal_device_unblock().
> - *
> - * To do: avoid that scsi_send_eh_cmnd() calls queuecommand() after
> - * scsi_internal_device_block() has blocked a SCSI device and also
> - * remove the rport mutex lock and unlock calls from srp_queuecommand().
>   */
>  static int scsi_internal_device_block(struct scsi_device *sdev)
>  {
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
