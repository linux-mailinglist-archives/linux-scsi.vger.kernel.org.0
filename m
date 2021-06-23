Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6DB3B1987
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Jun 2021 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFWMFT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Jun 2021 08:05:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17141 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhFWMFS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 23 Jun 2021 08:05:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624449781; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TZy3QLobESFBPo4zqXB+Lm4NnttlJStnDUEdgvJ5AMs=;
 b=rjZdD61tea1se5uj+aTQTZ3itgDSBB2sRDtHbdXT9c+XvaLlzzt3G4Ykqko4fPML0hrb5byk
 /bvblS14cbyHrh1IzNs23+K/nBEJQRFW2ElLAK9+9mCNQmgdt+oHvHeyO1x7LAH2Z9T0xA7y
 +PAiv/V2DGccBxPQ1JXnx4RzOjs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d322f4dc4628fe7eb9e66f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 12:03:00
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8221FC4360C; Wed, 23 Jun 2021 12:02:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 364F4C433D3;
        Wed, 23 Jun 2021 12:02:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jun 2021 20:02:58 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH RFC 4/4] ufs: Make host controller state change handling
 more systematic
In-Reply-To: <20210619005228.28569-5-bvanassche@acm.org>
References: <20210619005228.28569-1-bvanassche@acm.org>
 <20210619005228.28569-5-bvanassche@acm.org>
Message-ID: <58b71eb33b331033d04e4830f5e02d5c@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

On 2021-06-19 08:52, Bart Van Assche wrote:
> Introduce a function that reports whether or not a controller state 
> change
> is allowed instead of duplicating these checks in every context that
> changes the host controller state. This patch includes a behavior 
> change:
> ufshcd_link_recovery() no longer can change the host controller state 
> from
> UFSHCD_STATE_ERROR into UFSHCD_STATE_RESET.
> 
> Cc: Can Guo <cang@codeaurora.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 59 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c213daec20f7..a10c8ec28468 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4070,16 +4070,32 @@ static int ufshcd_uic_change_pwr_mode(struct
> ufs_hba *hba, u8 mode)
>  	return ret;
>  }
> 
> +static bool ufshcd_set_state(struct ufs_hba *hba, enum ufshcd_state 
> new_state)
> +{
> +	lockdep_assert_held(hba->host->host_lock);
> +
> +	if (old_state != UFSHCD_STATE_ERROR || new_state == 
> UFSHCD_STATE_ERROR)
> +		hba->ufshcd_state = new_state;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  int ufshcd_link_recovery(struct ufs_hba *hba)
>  {
>  	int ret;
>  	unsigned long flags;
> +	bool proceed;
> 
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> -	hba->ufshcd_state = UFSHCD_STATE_RESET;
> -	ufshcd_set_eh_in_progress(hba);
> +	proceed = ufshcd_set_state(hba, UFSHCD_STATE_RESET);
> +	if (proceed)
> +		ufshcd_set_eh_in_progress(hba);
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> 
> +	if (!proceed)
> +		return -EPERM;
> +
>  	/* Reset the attached device */
>  	ufshcd_device_reset(hba);
> 
> @@ -4087,7 +4103,7 @@ int ufshcd_link_recovery(struct ufs_hba *hba)
> 
>  	spin_lock_irqsave(hba->host->host_lock, flags);
>  	if (ret)
> -		hba->ufshcd_state = UFSHCD_STATE_ERROR;
> +		ufshcd_set_state(hba, UFSHCD_STATE_ERROR);
>  	ufshcd_clear_eh_in_progress(hba);
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> 
> @@ -5856,15 +5872,17 @@ static inline bool
> ufshcd_is_saved_err_fatal(struct ufs_hba *hba)
>  /* host lock must be held before calling this func */
>  static inline void ufshcd_schedule_eh_work(struct ufs_hba *hba)
>  {
> -	/* handle fatal errors only when link is not in error state */
> -	if (hba->ufshcd_state != UFSHCD_STATE_ERROR) {
> -		if (hba->force_reset || ufshcd_is_link_broken(hba) ||
> -		    ufshcd_is_saved_err_fatal(hba))
> -			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_FATAL;
> -		else
> -			hba->ufshcd_state = UFSHCD_STATE_EH_SCHEDULED_NON_FATAL;
> +	bool proceed;
> +
> +	if (hba->force_reset || ufshcd_is_link_broken(hba) ||
> +	    ufshcd_is_saved_err_fatal(hba))
> +		proceed = ufshcd_set_state(hba,
> +					   UFSHCD_STATE_EH_SCHEDULED_FATAL);
> +	else
> +		proceed = ufshcd_set_state(hba,
> +					   UFSHCD_STATE_EH_SCHEDULED_NON_FATAL);
> +	if (proceed)
>  		queue_work(hba->eh_wq, &hba->eh_work);
> -	}
>  }
> 
>  static void ufshcd_clk_scaling_allow(struct ufs_hba *hba, bool allow)
> @@ -6017,8 +6035,7 @@ static void ufshcd_err_handler(struct work_struct 
> *work)
>  	down(&hba->host_sem);
>  	spin_lock_irqsave(hba->host->host_lock, flags);
>  	if (ufshcd_err_handling_should_stop(hba)) {
> -		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
> -			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
> +		ufshcd_set_state(hba, UFSHCD_STATE_OPERATIONAL);
>  		spin_unlock_irqrestore(hba->host->host_lock, flags);
>  		up(&hba->host_sem);
>  		return;
> @@ -6029,8 +6046,7 @@ static void ufshcd_err_handler(struct work_struct 
> *work)
>  	/* Complete requests that have door-bell cleared by h/w */
>  	ufshcd_complete_requests(hba);
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> -	if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
> -		hba->ufshcd_state = UFSHCD_STATE_RESET;
> +	ufshcd_set_state(hba, UFSHCD_STATE_RESET);
>  	/*
>  	 * A full reset and restore might have happened after preparation
>  	 * is finished, double check whether we should stop.
> @@ -6163,8 +6179,7 @@ static void ufshcd_err_handler(struct work_struct 
> *work)
> 
>  skip_err_handling:
>  	if (!needs_reset) {
> -		if (hba->ufshcd_state == UFSHCD_STATE_RESET)
> -			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;

State transition to OPERATIONAL should only be from RESET, this
is to make sure that we don't miss any new error (fatal or non-fatal)
occurs while error handling is running.

> +		ufshcd_set_state(hba, UFSHCD_STATE_OPERATIONAL);
>  		if (hba->saved_err || hba->saved_uic_err)
>  			dev_err_ratelimited(hba->dev, "%s: exit: saved_err 0x%x 
> saved_uic_err 0x%x",
>  			    __func__, hba->saved_err, hba->saved_uic_err);
> @@ -7135,7 +7150,7 @@ static int ufshcd_reset_and_restore(struct 
> ufs_hba *hba)
>  	 */
>  	scsi_report_bus_reset(hba->host, 0);
>  	if (err) {
> -		hba->ufshcd_state = UFSHCD_STATE_ERROR;
> +		ufshcd_set_state(hba, UFSHCD_STATE_ERROR);
>  		hba->saved_err |= saved_err;
>  		hba->saved_uic_err |= saved_uic_err;
>  	}
> @@ -7951,7 +7966,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba,
> bool init_dev_params)
>  	unsigned long flags;
>  	ktime_t start = ktime_get();
> 
> -	hba->ufshcd_state = UFSHCD_STATE_RESET;
> +	ufshcd_set_state(hba, UFSHCD_STATE_RESET);
> 
>  	ret = ufshcd_link_startup(hba);
>  	if (ret)
> @@ -8024,10 +8039,8 @@ static int ufshcd_probe_hba(struct ufs_hba
> *hba, bool init_dev_params)
> 
>  out:
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> -	if (ret)
> -		hba->ufshcd_state = UFSHCD_STATE_ERROR;
> -	else if (hba->ufshcd_state == UFSHCD_STATE_RESET)
> -		hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;

State transition to OPERATIONAL should only be from RESET, this
is to make sure that we don't miss any new error (fatal or non-fatal)
occurs during re-probe.

Thanks,

Can Guo.

> +	ufshcd_set_state(hba, ret ? UFSHCD_STATE_ERROR :
> +			 UFSHCD_STATE_OPERATIONAL);
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> 
>  	trace_ufshcd_init(dev_name(hba->dev), ret,
