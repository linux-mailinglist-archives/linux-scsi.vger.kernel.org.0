Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377832DDE9A
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Dec 2020 07:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgLRG1F (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Dec 2020 01:27:05 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:39342 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732770AbgLRG1F (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Dec 2020 01:27:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608272800; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ci1RMDYuVkrZKakFCS9kv682lkAbxTxsLfD4j3hMbEc=;
 b=BzPqT1RcVvrVJx5rQlPPrIIOESUar1YPWfJMbuQNuX17b9/kjM5z7Nxa5+9fw9HAUOwO5IL3
 CTT2v5BUHSxQnHe3vifOrK9bfKsGMz/pxiSz15kPodbkbikb/OCQ2kF0D2iE/zk7qkg4MNqU
 JGv9F5YPZRE+CQRgrucrVAaH71A=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fdc4b82bfd08afb0d40b75b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 06:26:10
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5AF2CC43465; Fri, 18 Dec 2020 06:26:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1134C433ED;
        Fri, 18 Dec 2020 06:26:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Dec 2020 14:26:06 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] scsi: ufs: Protect some contexts from unexpected
 clock scaling
In-Reply-To: <1608011011.10163.9.camel@mtkswgap22>
References: <1607877104-8916-1-git-send-email-cang@codeaurora.org>
 <1607877104-8916-2-git-send-email-cang@codeaurora.org>
 <1608011011.10163.9.camel@mtkswgap22>
Message-ID: <0d80c723a707e1cf719c714cb7141dde@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-15 13:43, Stanley Chu wrote:
> Hi Can,
> 
> On Sun, 2020-12-13 at 08:31 -0800, Can Guo wrote:
>> In contexts like suspend, shutdown and error handling, we need to 
>> suspend
>> devfreq to make sure these contexts won't be disturbed by clock 
>> scaling.
>> However, suspending devfreq is not enough since users can still 
>> trigger a
>> clock scaling by manipulating the sysfs node clkscale_enable and 
>> devfreq
>> sysfs nodes like min/max_freq and governor. Add one more flag in 
>> struct
>> clk_scaling such that these contexts can prevent clock scaling from 
>> being
>> invoked through above sysfs nodes.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/ufshcd.c | 83 
>> +++++++++++++++++++++++++++++++----------------
>>  drivers/scsi/ufs/ufshcd.h |  2 ++
>>  2 files changed, 57 insertions(+), 28 deletions(-)
>> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 0c148fc..4ccdd2b 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -1147,12 +1147,22 @@ static int ufshcd_clock_scaling_prepare(struct 
>> ufs_hba *hba)
>>  	 */
>>  	ufshcd_scsi_block_requests(hba);
>>  	down_write(&hba->clk_scaling_lock);
>> -	if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
>> +
>> +	if (!hba->clk_scaling.is_allowed)
>> +		ret = -EAGAIN;
>> +	else if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US))
>>  		ret = -EBUSY;
>> +
>> +	if (ret) {
>>  		up_write(&hba->clk_scaling_lock);
>>  		ufshcd_scsi_unblock_requests(hba);
>> +		goto out;
>>  	}
>> 
>> +	/* let's not get into low power until clock scaling is completed */
>> +	ufshcd_hold(hba, false);
>> +
>> +out:
>>  	return ret;
>>  }
>> 
>> @@ -1160,6 +1170,7 @@ static void 
>> ufshcd_clock_scaling_unprepare(struct ufs_hba *hba)
>>  {
>>  	up_write(&hba->clk_scaling_lock);
>>  	ufshcd_scsi_unblock_requests(hba);
>> +	ufshcd_release(hba);
>>  }
>> 
>>  /**
>> @@ -1175,12 +1186,9 @@ static int ufshcd_devfreq_scale(struct ufs_hba 
>> *hba, bool scale_up)
>>  {
>>  	int ret = 0;
>> 
>> -	/* let's not get into low power until clock scaling is completed */
>> -	ufshcd_hold(hba, false);
>> -
>>  	ret = ufshcd_clock_scaling_prepare(hba);
>>  	if (ret)
>> -		goto out;
>> +		return ret;
>> 
>>  	/* scale down the gear before scaling down clocks */
>>  	if (!scale_up) {
>> @@ -1212,8 +1220,6 @@ static int ufshcd_devfreq_scale(struct ufs_hba 
>> *hba, bool scale_up)
>> 
>>  out_unprepare:
>>  	ufshcd_clock_scaling_unprepare(hba);
>> -out:
>> -	ufshcd_release(hba);
>>  	return ret;
>>  }
>> 
>> @@ -1487,7 +1493,7 @@ static ssize_t 
>> ufshcd_clkscale_enable_show(struct device *dev,
>>  {
>>  	struct ufs_hba *hba = dev_get_drvdata(dev);
>> 
>> -	return snprintf(buf, PAGE_SIZE, "%d\n", 
>> hba->clk_scaling.is_allowed);
>> +	return snprintf(buf, PAGE_SIZE, "%d\n", 
>> hba->clk_scaling.is_enabled);
>>  }
>> 
>>  static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>> @@ -1496,12 +1502,20 @@ static ssize_t 
>> ufshcd_clkscale_enable_store(struct device *dev,
>>  	struct ufs_hba *hba = dev_get_drvdata(dev);
>>  	u32 value;
>>  	int err;
>> +	unsigned long flags;
>> +	bool update = true;
>> 
>>  	if (kstrtou32(buf, 0, &value))
>>  		return -EINVAL;
>> 
>>  	value = !!value;
>> -	if (value == hba->clk_scaling.is_allowed)
>> +	spin_lock_irqsave(hba->host->host_lock, flags);
>> +	if (value == hba->clk_scaling.is_enabled)
>> +		update = false;
>> +	else
>> +		hba->clk_scaling.is_enabled = value;
>> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
>> +	if (!update)
>>  		goto out;
>> 
>>  	pm_runtime_get_sync(hba->dev);
>> @@ -1510,8 +1524,6 @@ static ssize_t 
>> ufshcd_clkscale_enable_store(struct device *dev,
>>  	cancel_work_sync(&hba->clk_scaling.suspend_work);
>>  	cancel_work_sync(&hba->clk_scaling.resume_work);
>> 
>> -	hba->clk_scaling.is_allowed = value;
>> -
>>  	if (value) {
>>  		ufshcd_resume_clkscaling(hba);
>>  	} else {
>> @@ -1845,8 +1857,6 @@ static void ufshcd_init_clk_scaling(struct 
>> ufs_hba *hba)
>>  	snprintf(wq_name, sizeof(wq_name), "ufs_clkscaling_%d",
>>  		 hba->host->host_no);
>>  	hba->clk_scaling.workq = create_singlethread_workqueue(wq_name);
>> -
>> -	ufshcd_clkscaling_init_sysfs(hba);
>>  }
>> 
>>  static void ufshcd_exit_clk_scaling(struct ufs_hba *hba)
>> @@ -1854,6 +1864,8 @@ static void ufshcd_exit_clk_scaling(struct 
>> ufs_hba *hba)
>>  	if (!ufshcd_is_clkscaling_supported(hba))
>>  		return;
>> 
>> +	if (hba->devfreq)
>> +		device_remove_file(hba->dev, &hba->clk_scaling.enable_attr);
>>  	destroy_workqueue(hba->clk_scaling.workq);
>>  	ufshcd_devfreq_remove(hba);
>>  }
>> @@ -1918,7 +1930,7 @@ static void ufshcd_clk_scaling_start_busy(struct 
>> ufs_hba *hba)
>>  	if (!hba->clk_scaling.active_reqs++)
>>  		queue_resume_work = true;
>> 
>> -	if (!hba->clk_scaling.is_allowed || hba->pm_op_in_progress)
>> +	if (!hba->clk_scaling.is_enabled || hba->pm_op_in_progress)
>>  		return;
>> 
>>  	if (queue_resume_work)
>> @@ -4987,7 +4999,8 @@ static void __ufshcd_transfer_req_compl(struct 
>> ufs_hba *hba,
>>  				complete(hba->dev_cmd.complete);
>>  			}
>>  		}
>> -		if (ufshcd_is_clkscaling_supported(hba))
>> +		if (ufshcd_is_clkscaling_supported(hba) &&
>> +		    hba->clk_scaling.active_reqs > 0)
>>  			hba->clk_scaling.active_reqs--;
>>  	}
>> 
>> @@ -5650,18 +5663,25 @@ static void ufshcd_err_handling_prepare(struct 
>> ufs_hba *hba)
>>  		ufshcd_vops_resume(hba, UFS_RUNTIME_PM);
>>  	} else {
>>  		ufshcd_hold(hba, false);
>> -		if (hba->clk_scaling.is_allowed) {
>> +		if (hba->clk_scaling.is_enabled) {
>>  			cancel_work_sync(&hba->clk_scaling.suspend_work);
>>  			cancel_work_sync(&hba->clk_scaling.resume_work);
>>  			ufshcd_suspend_clkscaling(hba);
>>  		}
>>  	}
>> +	down_write(&hba->clk_scaling_lock);
>> +	hba->clk_scaling.is_allowed = false;
>> +	up_write(&hba->clk_scaling_lock);
>>  }
>> 
>>  static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
>>  {
>>  	ufshcd_release(hba);
>> -	if (hba->clk_scaling.is_allowed)
>> +
>> +	down_write(&hba->clk_scaling_lock);
>> +	hba->clk_scaling.is_allowed = true;
>> +	up_write(&hba->clk_scaling_lock);
>> +	if (hba->clk_scaling.is_enabled)
>>  		ufshcd_resume_clkscaling(hba);
>>  	pm_runtime_put(hba->dev);
>>  }
>> @@ -7620,12 +7640,14 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>>  			sizeof(struct ufs_pa_layer_attr));
>>  		hba->clk_scaling.saved_pwr_info.is_valid = true;
>>  		if (!hba->devfreq) {
>> +			hba->clk_scaling.is_allowed = true;
> 
> Perhaps moving this line after ufshcd_devfreq_init() is successful?

devfreq starts to work even before ufshcd_devfreq_init() returns,
I don't want to block it, hence put it before ufshcd_devfreq_init().
If devfreq fails to initialize, clk_scaling and its related sysfs
nodes anyways won't work and clk_scaling->is_enabled is false, so
we are safe.

> 
>>  			ret = ufshcd_devfreq_init(hba);
>>  			if (ret)
>>  				goto out;
>> -		}
>> 
>> -		hba->clk_scaling.is_allowed = true;
>> +			hba->clk_scaling.is_enabled = true;
>> +			ufshcd_clkscaling_init_sysfs(hba);
>> +		}
>>  	}
>> 
>>  	ufs_bsg_probe(hba);
>> @@ -8491,11 +8513,14 @@ static int ufshcd_suspend(struct ufs_hba *hba, 
>> enum ufs_pm_op pm_op)
>>  	ufshcd_hold(hba, false);
>>  	hba->clk_gating.is_suspended = true;
>> 
>> -	if (hba->clk_scaling.is_allowed) {
>> +	if (hba->clk_scaling.is_enabled) {
>>  		cancel_work_sync(&hba->clk_scaling.suspend_work);
>>  		cancel_work_sync(&hba->clk_scaling.resume_work);
>>  		ufshcd_suspend_clkscaling(hba);
>>  	}
>> +	down_write(&hba->clk_scaling_lock);
>> +	hba->clk_scaling.is_allowed = false;
>> +	up_write(&hba->clk_scaling_lock);
>> 
>>  	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
>>  			req_link_state == UIC_LINK_ACTIVE_STATE) {
>> @@ -8592,8 +8617,6 @@ static int ufshcd_suspend(struct ufs_hba *hba, 
>> enum ufs_pm_op pm_op)
>>  	goto out;
>> 
>>  set_link_active:
>> -	if (hba->clk_scaling.is_allowed)
>> -		ufshcd_resume_clkscaling(hba);
>>  	ufshcd_vreg_set_hpm(hba);
>>  	if (ufshcd_is_link_hibern8(hba) && !ufshcd_uic_hibern8_exit(hba))
>>  		ufshcd_set_link_active(hba);
>> @@ -8603,7 +8626,10 @@ static int ufshcd_suspend(struct ufs_hba *hba, 
>> enum ufs_pm_op pm_op)
>>  	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
>>  		ufshcd_disable_auto_bkops(hba);
>>  enable_gating:
>> -	if (hba->clk_scaling.is_allowed)
>> +	down_write(&hba->clk_scaling_lock);
>> +	hba->clk_scaling.is_allowed = true;
>> +	up_write(&hba->clk_scaling_lock);
>> +	if (hba->clk_scaling.is_enabled)
>>  		ufshcd_resume_clkscaling(hba);
>>  	hba->clk_gating.is_suspended = false;
>>  	hba->dev_info.b_rpm_dev_flush_capable = false;
>> @@ -8701,7 +8727,10 @@ static int ufshcd_resume(struct ufs_hba *hba, 
>> enum ufs_pm_op pm_op)
>> 
>>  	hba->clk_gating.is_suspended = false;
>> 
>> -	if (hba->clk_scaling.is_allowed)
>> +	down_write(&hba->clk_scaling_lock);
>> +	hba->clk_scaling.is_allowed = true;
>> +	up_write(&hba->clk_scaling_lock);
>> +	if (hba->clk_scaling.is_enabled)
>>  		ufshcd_resume_clkscaling(hba);
>> 
>>  	/* Enable Auto-Hibernate if configured */
>> @@ -8725,8 +8754,6 @@ static int ufshcd_resume(struct ufs_hba *hba, 
>> enum ufs_pm_op pm_op)
>>  	ufshcd_vreg_set_lpm(hba);
>>  disable_irq_and_vops_clks:
>>  	ufshcd_disable_irq(hba);
>> -	if (hba->clk_scaling.is_allowed)
>> -		ufshcd_suspend_clkscaling(hba);
>>  	ufshcd_setup_clocks(hba, false);
>>  	if (ufshcd_is_clkgating_allowed(hba)) {
>>  		hba->clk_gating.state = CLKS_OFF;
>> @@ -8915,6 +8942,8 @@ int ufshcd_shutdown(struct ufs_hba *hba)
>> 
>>  	pm_runtime_get_sync(hba->dev);
>> 
>> +	ufshcd_exit_clk_scaling(hba);
>> +
>>  	ret = ufshcd_suspend(hba, UFS_SHUTDOWN_PM);
>>  out:
>>  	if (ret)
>> @@ -8944,8 +8973,6 @@ void ufshcd_remove(struct ufs_hba *hba)
>> 
>>  	ufshcd_exit_clk_scaling(hba);
>>  	ufshcd_exit_clk_gating(hba);
>> -	if (ufshcd_is_clkscaling_supported(hba))
>> -		device_remove_file(hba->dev, &hba->clk_scaling.enable_attr);
>>  	ufshcd_hba_exit(hba);
>>  }
>>  EXPORT_SYMBOL_GPL(ufshcd_remove);
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index e0f00a4..9fcecba 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -382,6 +382,7 @@ struct ufs_saved_pwr_info {
>>   * @workq: workqueue to schedule devfreq suspend/resume work
>>   * @suspend_work: worker to suspend devfreq
>>   * @resume_work: worker to resume devfreq
>> + * @is_enabled: tracks if scaling is currently enabled or not
>>   * @is_allowed: tracks if scaling is currently allowed or not
>>   * @is_busy_started: tracks if busy period has started or not
>>   * @is_suspended: tracks if devfreq is suspended or not
>> @@ -396,6 +397,7 @@ struct ufs_clk_scaling {
>>  	struct workqueue_struct *workq;
>>  	struct work_struct suspend_work;
>>  	struct work_struct resume_work;
>> +	bool is_enabled;
>>  	bool is_allowed;
>>  	bool is_busy_started;
>>  	bool is_suspended;
> 
> Now there are more and more "similar boolean attributes" regarding
> clk-scaling control, maybe add more comprehensive comments to describe
> them?
> 
> Otherwise this patch looks good to me.

Sure, I will give more words to the new flag.

Thanks,

Can Guo.

> 
> Feel free to add
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
