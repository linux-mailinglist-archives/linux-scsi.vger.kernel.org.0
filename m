Return-Path: <linux-scsi+bounces-14354-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D4ACBF37
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Jun 2025 06:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0771881091
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Jun 2025 04:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A518952C;
	Tue,  3 Jun 2025 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfOUnTwh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A32F2D;
	Tue,  3 Jun 2025 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748925517; cv=none; b=X9zfeTIYF0Zu4mnefHb+A0Ft+qDQ9Ur8W9ywcsD6O6KVu5rpFCtxkzu3hxh0qSxlkQTrEMFquUtBrUo+5oerx2Aqp1stOPQSROB9tj/fRi3+WCxE9g+uFNETslkCSi8wm90lPBP/p5qRvumhcTdKkHUQXyjNR2n2qfsMeK5NnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748925517; c=relaxed/simple;
	bh=nf6rippSCtPnu9Qu7l3fVOckpNN52C+dzO+b0/V03kU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hVkThCwF+50ms1Jjwj86cxEWsvnBKRCwy8U/XcnOs32SttnqAUFPZNbNsnmBaeseyZ4awyR6jV6fylMhcPx7uARHjOEsNA9mlnnrV7liE88sdlfVxNvWa1Rlr4hUGd2IUl0ubJ4MAyLPXh1Fn0oE62iwAQgQhyqIsyz+TWj8LUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfOUnTwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25190C4CEED;
	Tue,  3 Jun 2025 04:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748925517;
	bh=nf6rippSCtPnu9Qu7l3fVOckpNN52C+dzO+b0/V03kU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IfOUnTwh4gJ65Y2qDp+ZEJhiPmtToC2Mf1cIbZn+Z1oWZIwEAZGiJsKR5G9jM/AZ9
	 6jvaY/lsf9l9DT8UKfm6D8sC9uHqYwY829WNVoWgFmvJD6EqXm11acCVoKxJGiJVmZ
	 5D5/2PQAlKIle6kjaijkrIfhC4V95Tol6mD52ennz8U8h1XI41ooREaM/r49jx7t8+
	 bPctl1qLbaJJPKJt5TjoZJs5IUHlXSsGvjVwStY7ppwDuDC9Om10gSVxqeR3t445/x
	 2wxy+BYmGGBNH3hjiWxg8FBG7rRabqvxIsXMs2TErNOYhT1R0Hxf38H8/1mNWbkfxK
	 FU9q5nGtD0z3A==
Date: Tue, 3 Jun 2025 13:38:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sd: Add timeout_sec and max_retries module parameter
 for sd
Message-Id: <20250603133834.130f5c92183a486fccafed3c@kernel.org>
In-Reply-To: <174891816691.3598746.4969251260451409086.stgit@mhiramat.tok.corp.google.com>
References: <174891816691.3598746.4969251260451409086.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Jun 2025 11:36:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Sometimes a USB storage connection is unstable and the probing
> takes longer time than the hung check timeout. Since the probing
> runs under device_lock(dev), if there is another task tries to
> acquire the same device_lock() (e.g. udevd, in this case), that
> task hits the hung_task error and will lead a kernel panic.
> 
> For example, enabling CONFIG_DETECT_HUNG_TASK_BLOCKER, I got an
> error message something like below (Note that this is 6.1 kernel
> example, so the function names are a bit different.);
> 
>  INFO: task udevd:5301 blocked for more than 122 seconds.
> ...
>  INFO: task udevd:5301 is blocked on a mutex likely owned by task kworker/u4:1:11.
>  task:kworker/u4:1state:D stack:0 pid:11ppid:2  flags:0x00004000
>  Workqueue: events_unbound async_run_entry_fn
>  Call Trace:
>   <TASK>
>   schedule+0x438/0x1490
>   ? blk_mq_do_dispatch_ctx+0x70/0x1c0
>   schedule_timeout+0x253/0x790
>   ? try_to_del_timer_sync+0xb0/0xb0
>   io_schedule_timeout+0x3f/0x80
>   wait_for_common_io+0xb4/0x160
>   blk_execute_rq+0x1bd/0x210
>   __scsi_execute+0x156/0x240
>   sd_revalidate_disk+0xa2a/0x2360
>   ? kobject_uevent_env+0x158/0x430
>   sd_probe+0x364/0x47
>   really_probe+0x15a/0x3b0
>   __driver_probe_device+0x78/0xc0
>   driver_probe_device+0x24/0x1a0
>   __device_attach_driver+0x131/0x160
>   ? coredump_store+0x50/0x50
>   bus_for_each_drv+0x9d/0xf0
>   __device_attach_async_helper+0x7e/0xd0  <=== device_lock()
> ...
> 
> In this case, device_lock() was locked in
> __device_attach_async_helper(), and it ran driver_probe_device()
> for each driver, and eventually send a scsi command which took
> very long time.
> 
> This is because we use a long timeout and retries for sd_probe().
> To avoid it, makes the default timeout and max retries tunable.
> Since the sd.ko can be loaded right before the broken device is
> probed, pass the default value as module parameters, so that
> user can set it via modules.conf.
> 
> If we set these values 10 times smaller (e.g. timeout_sec=3),
> sd_probe can detect wrong devices/connection before causing
> hung_task error.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  drivers/scsi/sd.c |   50 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 950d8c9fb884..5021bad3bd40 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -100,6 +100,14 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_MOD);
>  MODULE_ALIAS_SCSI_DEVICE(TYPE_RBC);
>  MODULE_ALIAS_SCSI_DEVICE(TYPE_ZBC);
>  
> +/* timeout_sec defines the default value of the SCSI command timeout in second. */
> +static int sd_timeout_sec = SD_TIMEOUT / HZ;
> +module_param_named(timeout_sec, sd_timeout_sec, int, 0644);
> +
> +/* max_retries defines the default value of the max of SCSI command retries.*/
> +static int sd_max_retries = SD_MAX_RETRIES;
> +module_param_named(max_retries, sd_max_retries, int, 0644);
> +
>  #define SD_MINORS	16
>  
>  static void sd_config_discard(struct scsi_disk *sdkp, struct queue_limits *lim,
> @@ -184,7 +192,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
>  		return count;
>  	}
>  
> -	if (scsi_mode_sense(sdp, 0x08, 8, 0, buffer, sizeof(buffer), SD_TIMEOUT,
> +	if (scsi_mode_sense(sdp, 0x08, 8, 0, buffer, sizeof(buffer), sd_timeout_sec * HZ,
>  			    sdkp->max_retries, &data, NULL))
>  		return -EINVAL;
>  	len = min_t(size_t, sizeof(buffer), data.length - data.header_length -
> @@ -202,7 +210,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
>  	 */
>  	data.device_specific = 0;
>  
> -	ret = scsi_mode_select(sdp, 1, sp, buffer_data, len, SD_TIMEOUT,
> +	ret = scsi_mode_select(sdp, 1, sp, buffer_data, len, sd_timeout_sec * HZ,
>  			       sdkp->max_retries, &data, &sshdr);
>  	if (ret) {
>  		if (ret > 0 && scsi_sense_valid(&sshdr))
> @@ -729,7 +737,7 @@ static int sd_sec_submit(void *data, u16 spsp, u8 secp, void *buffer,
>  	put_unaligned_be32(len, &cdb[6]);
>  
>  	ret = scsi_execute_cmd(sdev, cdb, send ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
> -			       buffer, len, SD_TIMEOUT, sdkp->max_retries,
> +			       buffer, len, sd_timeout_sec * HZ, sdkp->max_retries,
>  			       &exec_args);
>  	return ret <= 0 ? ret : -EIO;
>  }
> @@ -930,7 +938,7 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
>  
>  	cmd->allowed = sdkp->max_retries;
>  	cmd->transfersize = data_len;
> -	rq->timeout = SD_TIMEOUT;
> +	rq->timeout = sd_timeout_sec * HZ;
>  
>  	return scsi_alloc_sgtables(cmd);
>  }
> @@ -1016,7 +1024,7 @@ static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
>  
>  	cmd->allowed = sdkp->max_retries;
>  	cmd->transfersize = data_len;
> -	rq->timeout = unmap ? SD_TIMEOUT : SD_WRITE_SAME_TIMEOUT;
> +	rq->timeout = unmap ? sd_timeout_sec * HZ : SD_WRITE_SAME_TIMEOUT;

Ah, there is a fixed timeout (SD_WRITE_SAME_TIMEOUT) yet.
Let me make it another knob too.

Thanks!

>  
>  	return scsi_alloc_sgtables(cmd);
>  }
> @@ -1043,7 +1051,7 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
>  
>  	cmd->allowed = sdkp->max_retries;
>  	cmd->transfersize = data_len;
> -	rq->timeout = unmap ? SD_TIMEOUT : SD_WRITE_SAME_TIMEOUT;
> +	rq->timeout = unmap ? sd_timeout_sec * HZ : SD_WRITE_SAME_TIMEOUT;
>  
>  	return scsi_alloc_sgtables(cmd);
>  }
> @@ -1739,7 +1747,7 @@ static unsigned int sd_check_events(struct gendisk *disk, unsigned int clearing)
>  	if (scsi_block_when_processing_errors(sdp)) {
>  		struct scsi_sense_hdr sshdr = { 0, };
>  
> -		retval = scsi_test_unit_ready(sdp, SD_TIMEOUT, sdkp->max_retries,
> +		retval = scsi_test_unit_ready(sdp, sd_timeout_sec * HZ, sdkp->max_retries,
>  					      &sshdr);
>  
>  		/* failed to execute TUR, assume media not present */
> @@ -1952,7 +1960,7 @@ static int sd_pr_in_command(struct block_device *bdev, u8 sa,
>  	put_unaligned_be16(data_len, &cmd[7]);
>  
>  	result = scsi_execute_cmd(sdev, cmd, REQ_OP_DRV_IN, data, data_len,
> -				  SD_TIMEOUT, sdkp->max_retries, &exec_args);
> +				  sd_timeout_sec * HZ, sdkp->max_retries, &exec_args);
>  	if (scsi_status_is_check_condition(result) &&
>  	    scsi_sense_valid(&sshdr)) {
>  		sdev_printk(KERN_INFO, sdev, "PR command failed: %d\n", result);
> @@ -2063,7 +2071,7 @@ static int sd_pr_out_command(struct block_device *bdev, u8 sa, u64 key,
>  	data[20] = flags;
>  
>  	result = scsi_execute_cmd(sdev, cmd, REQ_OP_DRV_OUT, &data,
> -				  sizeof(data), SD_TIMEOUT, sdkp->max_retries,
> +				  sizeof(data), sd_timeout_sec * HZ, sdkp->max_retries,
>  				  &exec_args);
>  
>  	if (scsi_status_is_check_condition(result) &&
> @@ -2435,7 +2443,7 @@ sd_spinup_disk(struct scsi_disk *sdkp)
>  		scsi_failures_reset_retries(&failures);
>  
>  		the_result = scsi_execute_cmd(sdkp->device, cmd, REQ_OP_DRV_IN,
> -					      NULL, 0, SD_TIMEOUT,
> +					      NULL, 0, sd_timeout_sec * HZ,
>  					      sdkp->max_retries, &exec_args);
>  
>  
> @@ -2498,7 +2506,7 @@ sd_spinup_disk(struct scsi_disk *sdkp)
>  				sd_printk(KERN_NOTICE, sdkp, "Spinning up disk...");
>  				scsi_execute_cmd(sdkp->device, start_cmd,
>  						 REQ_OP_DRV_IN, NULL, 0,
> -						 SD_TIMEOUT, sdkp->max_retries,
> +						 sd_timeout_sec * HZ, sdkp->max_retries,
>  						 &exec_args);
>  				spintime_expire = jiffies + 100 * HZ;
>  				spintime = 1;
> @@ -2649,7 +2657,7 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
>  		memset(buffer, 0, RC16_LEN);
>  
>  		the_result = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN,
> -					      buffer, RC16_LEN, SD_TIMEOUT,
> +					      buffer, RC16_LEN, sd_timeout_sec * HZ,
>  					      sdkp->max_retries, &exec_args);
>  		if (the_result > 0) {
>  			if (media_not_present(sdkp, &sshdr))
> @@ -2760,7 +2768,7 @@ static int read_capacity_10(struct scsi_disk *sdkp, struct scsi_device *sdp,
>  	memset(buffer, 0, 8);
>  
>  	the_result = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN, buffer,
> -				      8, SD_TIMEOUT, sdkp->max_retries,
> +				      8, sd_timeout_sec * HZ, sdkp->max_retries,
>  				      &exec_args);
>  
>  	if (the_result > 0) {
> @@ -2948,7 +2956,7 @@ sd_do_mode_sense(struct scsi_disk *sdkp, int dbd, int modepage,
>  		len = 8;
>  
>  	return scsi_mode_sense(sdkp->device, dbd, modepage, 0, buffer, len,
> -			       SD_TIMEOUT, sdkp->max_retries, data, sshdr);
> +			       sd_timeout_sec * HZ, sdkp->max_retries, data, sshdr);
>  }
>  
>  /*
> @@ -3206,7 +3214,7 @@ static bool sd_is_perm_stream(struct scsi_disk *sdkp, unsigned int stream_id)
>  	put_unaligned_be32(sizeof(buf), &cdb[10]);
>  
>  	res = scsi_execute_cmd(sdev, cdb, REQ_OP_DRV_IN, &buf, sizeof(buf),
> -			       SD_TIMEOUT, sdkp->max_retries, &exec_args);
> +			       sd_timeout_sec * HZ, sdkp->max_retries, &exec_args);
>  	if (res < 0)
>  		return false;
>  	if (scsi_status_is_check_condition(res) && scsi_sense_valid(&sshdr))
> @@ -3231,7 +3239,7 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
>  		return;
>  
>  	res = scsi_mode_sense(sdp, /*dbd=*/0x8, /*modepage=*/0x0a,
> -			      /*subpage=*/0x05, buffer, SD_BUF_SIZE, SD_TIMEOUT,
> +			      /*subpage=*/0x05, buffer, SD_BUF_SIZE, sd_timeout_sec * HZ,
>  			      sdkp->max_retries, &data, &sshdr);
>  	if (res < 0)
>  		return;
> @@ -3274,7 +3282,7 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
>  	if (sdkp->protection_type == 0)
>  		return;
>  
> -	res = scsi_mode_sense(sdp, 1, 0x0a, 0, buffer, 36, SD_TIMEOUT,
> +	res = scsi_mode_sense(sdp, 1, 0x0a, 0, buffer, 36, sd_timeout_sec * HZ,
>  			      sdkp->max_retries, &data, &sshdr);
>  
>  	if (res < 0 || !data.header_length ||
> @@ -3682,7 +3690,7 @@ static void sd_read_block_zero(struct scsi_disk *sdkp)
>  	}
>  
>  	scsi_execute_cmd(sdkp->device, cmd, REQ_OP_DRV_IN, buffer, buf_len,
> -			 SD_TIMEOUT, sdkp->max_retries, NULL);
> +			 sd_timeout_sec * HZ, sdkp->max_retries, NULL);
>  	kfree(buffer);
>  }
>  
> @@ -3957,13 +3965,13 @@ static int sd_probe(struct device *dev)
>  	sdkp->device = sdp;
>  	sdkp->disk = gd;
>  	sdkp->index = index;
> -	sdkp->max_retries = SD_MAX_RETRIES;
> +	sdkp->max_retries = sd_max_retries;
>  	atomic_set(&sdkp->openers, 0);
>  	atomic_set(&sdkp->device->ioerr_cnt, 0);
>  
>  	if (!sdp->request_queue->rq_timeout) {
>  		if (sdp->type != TYPE_MOD)
> -			blk_queue_rq_timeout(sdp->request_queue, SD_TIMEOUT);
> +			blk_queue_rq_timeout(sdp->request_queue, sd_timeout_sec * HZ);
>  		else
>  			blk_queue_rq_timeout(sdp->request_queue,
>  					     SD_MOD_TIMEOUT);
> @@ -4131,7 +4139,7 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
>  	if (!scsi_device_online(sdp))
>  		return -ENODEV;
>  
> -	res = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN, NULL, 0, SD_TIMEOUT,
> +	res = scsi_execute_cmd(sdp, cmd, REQ_OP_DRV_IN, NULL, 0, sd_timeout_sec * HZ,
>  			       sdkp->max_retries, &exec_args);
>  	if (res) {
>  		sd_print_result(sdkp, "Start/Stop Unit failed", res);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

