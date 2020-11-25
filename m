Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6303D2C36EC
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Nov 2020 03:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgKYCsQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 Nov 2020 21:48:16 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:39806 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgKYCsP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 24 Nov 2020 21:48:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606272494; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fu3QlETUYTW6skoAuNdQe8WjrkEdT4zbxcm0mfyjjQs=;
 b=ks+/6q9M2yykeySjgpVe1ZO+7h6C118Fb4PBnBZT2hhxX/rB8CzJ034ni0zavoTixLv8yCfu
 2fdd3SJbgUae4c3XD6E21YyJv+jDE/PwU+A/XzdWmSkf6jX+RP8Y35SYW2pQyUTdnGq3BsH5
 o7qqDnpPQpPVGoi7w/pnGBCWXIc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fbdc5e79e87e163520962bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 02:48:07
 GMT
Sender: hongwus=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D6A3C43466; Wed, 25 Nov 2020 02:48:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hongwus)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E1B2C433C6;
        Wed, 25 Nov 2020 02:48:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 10:48:04 +0800
From:   hongwus@codeaurora.org
To:     Can Guo <cang@codeaurora.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        ziqichen@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] scsi: ufs: Serialize eh_work with system PM events
 and async scan
In-Reply-To: <1605596660-2987-2-git-send-email-cang@codeaurora.org>
References: <1605596660-2987-1-git-send-email-cang@codeaurora.org>
 <1605596660-2987-2-git-send-email-cang@codeaurora.org>
Message-ID: <5f56daec9aee0a6222106b12f7d7b254@codeaurora.org>
X-Sender: hongwus@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-11-17 15:04, Can Guo wrote:
> Serialize eh_work with system PM events and async scan to make sure 
> eh_work
> does not run in parallel with them.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 64 
> +++++++++++++++++++++++++++++------------------
>  drivers/scsi/ufs/ufshcd.h |  1 +
>  2 files changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 1d8134e..7e764e8 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5597,7 +5597,9 @@ static inline void
> ufshcd_schedule_eh_work(struct ufs_hba *hba)
>  static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
>  {
>  	pm_runtime_get_sync(hba->dev);
> -	if (pm_runtime_suspended(hba->dev)) {
> +	if (pm_runtime_status_suspended(hba->dev) || hba->is_sys_suspended) {
> +		enum ufs_pm_op pm_op;
> +
>  		/*
>  		 * Don't assume anything of pm_runtime_get_sync(), if
>  		 * resume fails, irq and clocks can be OFF, and powers
> @@ -5612,7 +5614,8 @@ static void ufshcd_err_handling_prepare(struct
> ufs_hba *hba)
>  		if (!ufshcd_is_clkgating_allowed(hba))
>  			ufshcd_setup_clocks(hba, true);
>  		ufshcd_release(hba);
> -		ufshcd_vops_resume(hba, UFS_RUNTIME_PM);
> +		pm_op = hba->is_sys_suspended ? UFS_RUNTIME_PM : UFS_SYSTEM_PM;
> +		ufshcd_vops_resume(hba, pm_op);
>  	} else {
>  		ufshcd_hold(hba, false);
>  		if (hba->clk_scaling.is_allowed) {
> @@ -5633,7 +5636,7 @@ static void ufshcd_err_handling_unprepare(struct
> ufs_hba *hba)
> 
>  static inline bool ufshcd_err_handling_should_stop(struct ufs_hba 
> *hba)
>  {
> -	return (hba->ufshcd_state == UFSHCD_STATE_ERROR ||
> +	return (!hba->is_powered || hba->ufshcd_state == UFSHCD_STATE_ERROR 
> ||
>  		(!(hba->saved_err || hba->saved_uic_err || hba->force_reset ||
>  			ufshcd_is_link_broken(hba))));
>  }
> @@ -5646,6 +5649,7 @@ static void ufshcd_recover_pm_error(struct 
> ufs_hba *hba)
>  	struct request_queue *q;
>  	int ret;
> 
> +	hba->is_sys_suspended = false;
>  	/*
>  	 * Set RPM status of hba device to RPM_ACTIVE,
>  	 * this also clears its runtime error.
> @@ -5704,11 +5708,13 @@ static void ufshcd_err_handler(struct 
> work_struct *work)
> 
>  	hba = container_of(work, struct ufs_hba, eh_work);
> 
> +	down(&hba->eh_sem);
>  	spin_lock_irqsave(hba->host->host_lock, flags);
>  	if (ufshcd_err_handling_should_stop(hba)) {
>  		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
>  			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
>  		spin_unlock_irqrestore(hba->host->host_lock, flags);
> +		up(&hba->eh_sem);
>  		return;
>  	}
>  	ufshcd_set_eh_in_progress(hba);
> @@ -5716,20 +5722,18 @@ static void ufshcd_err_handler(struct 
> work_struct *work)
>  	ufshcd_err_handling_prepare(hba);
>  	spin_lock_irqsave(hba->host->host_lock, flags);
>  	ufshcd_scsi_block_requests(hba);
> -	/*
> -	 * A full reset and restore might have happened after preparation
> -	 * is finished, double check whether we should stop.
> -	 */
> -	if (ufshcd_err_handling_should_stop(hba)) {
> -		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
> -			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
> -		goto out;
> -	}
>  	hba->ufshcd_state = UFSHCD_STATE_RESET;
> 
>  	/* Complete requests that have door-bell cleared by h/w */
>  	ufshcd_complete_requests(hba);
> 
> +	/*
> +	 * A full reset and restore might have happened after preparation
> +	 * is finished, double check whether we should stop.
> +	 */
> +	if (ufshcd_err_handling_should_stop(hba))
> +		goto skip_err_handling;
> +
>  	if (hba->dev_quirks & UFS_DEVICE_QUIRK_RECOVERY_FROM_DL_NAC_ERRORS) {
>  		bool ret;
> 
> @@ -5737,17 +5741,10 @@ static void ufshcd_err_handler(struct 
> work_struct *work)
>  		/* release the lock as ufshcd_quirk_dl_nac_errors() may sleep */
>  		ret = ufshcd_quirk_dl_nac_errors(hba);
>  		spin_lock_irqsave(hba->host->host_lock, flags);
> -		if (!ret && !hba->force_reset && ufshcd_is_link_active(hba))
> +		if (!ret && ufshcd_err_handling_should_stop(hba))
>  			goto skip_err_handling;
>  	}
> 
> -	if (hba->force_reset || ufshcd_is_link_broken(hba) ||
> -	    ufshcd_is_saved_err_fatal(hba) ||
> -	    ((hba->saved_err & UIC_ERROR) &&
> -	     (hba->saved_uic_err & (UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
> -				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR))))
> -		needs_reset = true;
> -
>  	if ((hba->saved_err & (INT_FATAL_ERRORS | UFSHCD_UIC_HIBERN8_MASK)) 
> ||
>  	    (hba->saved_uic_err &&
>  	     (hba->saved_uic_err != UFSHCD_UIC_PA_GENERIC_ERROR))) {
> @@ -5767,8 +5764,14 @@ static void ufshcd_err_handler(struct 
> work_struct *work)
>  	 * transfers forcefully because they will get cleared during
>  	 * host reset and restore
>  	 */
> -	if (needs_reset)
> +	if (hba->force_reset || ufshcd_is_link_broken(hba) ||
> +	    ufshcd_is_saved_err_fatal(hba) ||
> +	    ((hba->saved_err & UIC_ERROR) &&
> +	     (hba->saved_uic_err & (UFSHCD_UIC_DL_NAC_RECEIVED_ERROR |
> +				    UFSHCD_UIC_DL_TCx_REPLAY_ERROR)))) {
> +		needs_reset = true;
>  		goto do_reset;
> +	}
> 
>  	/*
>  	 * If LINERESET was caught, UFS might have been put to PWM mode,
> @@ -5876,12 +5879,11 @@ static void ufshcd_err_handler(struct 
> work_struct *work)
>  			dev_err_ratelimited(hba->dev, "%s: exit: saved_err 0x%x 
> saved_uic_err 0x%x",
>  			    __func__, hba->saved_err, hba->saved_uic_err);
>  	}
> -
> -out:
>  	ufshcd_clear_eh_in_progress(hba);
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
>  	ufshcd_scsi_unblock_requests(hba);
>  	ufshcd_err_handling_unprepare(hba);
> +	up(&hba->eh_sem);
>  }
> 
>  /**
> @@ -6856,6 +6858,7 @@ static int ufshcd_reset_and_restore(struct 
> ufs_hba *hba)
>  	 */
>  	scsi_report_bus_reset(hba->host, 0);
>  	if (err) {
> +		hba->ufshcd_state = UFSHCD_STATE_ERROR;
>  		hba->saved_err |= saved_err;
>  		hba->saved_uic_err |= saved_uic_err;
>  	}
> @@ -7704,8 +7707,10 @@ static void ufshcd_async_scan(void *data,
> async_cookie_t cookie)
>  	struct ufs_hba *hba = (struct ufs_hba *)data;
>  	int ret;
> 
> +	down(&hba->eh_sem);
>  	/* Initialize hba, detect and initialize UFS device */
>  	ret = ufshcd_probe_hba(hba, true);
> +	up(&hba->eh_sem);
>  	if (ret)
>  		goto out;
> 
> @@ -8718,6 +8723,7 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
>  	int ret = 0;
>  	ktime_t start = ktime_get();
> 
> +	down(&hba->eh_sem);
>  	if (!hba || !hba->is_powered)
>  		return 0;
> 
> @@ -8748,6 +8754,8 @@ int ufshcd_system_suspend(struct ufs_hba *hba)
>  		hba->curr_dev_pwr_mode, hba->uic_link_state);
>  	if (!ret)
>  		hba->is_sys_suspended = true;
> +	else
> +		up(&hba->eh_sem);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ufshcd_system_suspend);
> @@ -8764,8 +8772,10 @@ int ufshcd_system_resume(struct ufs_hba *hba)
>  	int ret = 0;
>  	ktime_t start = ktime_get();
> 
> -	if (!hba)
> +	if (!hba) {
> +		up(&hba->eh_sem);
>  		return -EINVAL;
> +	}
> 
>  	if (!hba->is_powered || pm_runtime_suspended(hba->dev))
>  		/*
> @@ -8781,6 +8791,7 @@ int ufshcd_system_resume(struct ufs_hba *hba)
>  		hba->curr_dev_pwr_mode, hba->uic_link_state);
>  	if (!ret)
>  		hba->is_sys_suspended = false;
> +	up(&hba->eh_sem);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ufshcd_system_resume);
> @@ -8872,6 +8883,7 @@ int ufshcd_shutdown(struct ufs_hba *hba)
>  {
>  	int ret = 0;
> 
> +	down(&hba->eh_sem);
>  	if (!hba->is_powered)
>  		goto out;
> 
> @@ -8888,6 +8900,8 @@ int ufshcd_shutdown(struct ufs_hba *hba)
>  out:
>  	if (ret)
>  		dev_err(hba->dev, "%s failed, err %d\n", __func__, ret);
> +	hba->is_powered = false;
> +	up(&hba->eh_sem);
>  	/* allow force shutdown even in case of errors */
>  	return 0;
>  }
> @@ -9082,6 +9096,8 @@ int ufshcd_init(struct ufs_hba *hba, void
> __iomem *mmio_base, unsigned int irq)
>  	INIT_WORK(&hba->eh_work, ufshcd_err_handler);
>  	INIT_WORK(&hba->eeh_work, ufshcd_exception_event_handler);
> 
> +	sema_init(&hba->eh_sem, 1);
> +
>  	/* Initialize UIC command mutex */
>  	mutex_init(&hba->uic_cmd_mutex);
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 47eb143..1e680bf 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -728,6 +728,7 @@ struct ufs_hba {
>  	u32 intr_mask;
>  	u16 ee_ctrl_mask;
>  	bool is_powered;
> +	struct semaphore eh_sem;
> 
>  	/* Work Queues */
>  	struct workqueue_struct *eh_wq;

Reviewed-by: Hongwu Su<hongwus@codeaurora.org>
