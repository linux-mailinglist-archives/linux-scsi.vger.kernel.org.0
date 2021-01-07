Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E9D2ECA62
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 07:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbhAGGLT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 01:11:19 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:60112 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbhAGGLS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Jan 2021 01:11:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609999854; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dFQegvrRvGd0eGFxd2nAZpJcWozq9olKCdVXlGOTAMM=;
 b=bDAy8dwiOOb0DLKd7Qn3RLGipA+ppFw6UzTraXKljxQhBe9r6kEIHJI213SV+trdul9cstPt
 GB4B26DuoZkz6QTlmR+bDdofi1vtWSde92VGqjnV1z/BOYgQ36nPSp82sKdYY/HP7SXk6jVH
 PWDlwFkzHzzlhlirkoStkVUelps=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ff6a5cde2332e083a312e6e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Jan 2021 06:10:21
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6727C43465; Thu,  7 Jan 2021 06:10:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01A81C433CA;
        Thu,  7 Jan 2021 06:10:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jan 2021 14:10:19 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        martin.petersen@oracle.com, stanley.chu@mediatek.com
Subject: Re: [PATCH v3 1/2] scsi: ufs: fix livelock of ufshcd_clear_ua_wluns
In-Reply-To: <20210106214109.44041-2-jaegeuk@kernel.org>
References: <20210106214109.44041-1-jaegeuk@kernel.org>
 <20210106214109.44041-2-jaegeuk@kernel.org>
Message-ID: <fc4cb27df8bd6b2c1037d82e4b5d3860@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-01-07 05:41, Jaegeuk Kim wrote:
> When gate_work/ungate_work gets an error during hibern8_enter or exit,
>  ufshcd_err_handler()
>    ufshcd_scsi_block_requests()
>    ufshcd_reset_and_restore()
>      ufshcd_clear_ua_wluns() -> stuck
>    ufshcd_scsi_unblock_requests()
> 
> In order to avoid it, ufshcd_clear_ua_wluns() can be called per 
> recovery flows
> such as suspend/resume, link_recovery, and error_handler.
> 
> Fixes: 1918651f2d7e ("scsi: ufs: Clear UAC for RPMB after ufshcd 
> resets")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index bedb822a40a3..1678cec08b51 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -3996,6 +3996,8 @@ int ufshcd_link_recovery(struct ufs_hba *hba)
>  	if (ret)
>  		dev_err(hba->dev, "%s: link recovery failed, err %d",
>  			__func__, ret);
> +	else
> +		ufshcd_clear_ua_wluns(hba);

Can we put it right after ufshcd_scsi_add_wlus() in ufshcd_add_lus()?

Thanks,
Can Guo.

> 
>  	return ret;
>  }
> @@ -6003,6 +6005,9 @@ static void ufshcd_err_handler(struct work_struct 
> *work)
>  	ufshcd_scsi_unblock_requests(hba);
>  	ufshcd_err_handling_unprepare(hba);
>  	up(&hba->eh_sem);
> +
> +	if (!err && needs_reset)
> +		ufshcd_clear_ua_wluns(hba);
>  }
> 
>  /**
> @@ -6940,14 +6945,11 @@ static int
> ufshcd_host_reset_and_restore(struct ufs_hba *hba)
>  	ufshcd_set_clk_freq(hba, true);
> 
>  	err = ufshcd_hba_enable(hba);
> -	if (err)
> -		goto out;
> 
>  	/* Establish the link again and restore the device */
> -	err = ufshcd_probe_hba(hba, false);
>  	if (!err)
> -		ufshcd_clear_ua_wluns(hba);
> -out:
> +		err = ufshcd_probe_hba(hba, false);
> +
>  	if (err)
>  		dev_err(hba->dev, "%s: Host init failed %d\n", __func__, err);
>  	ufshcd_update_evt_hist(hba, UFS_EVT_HOST_RESET, (u32)err);
> @@ -8777,6 +8779,7 @@ static int ufshcd_suspend(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  		ufshcd_resume_clkscaling(hba);
>  	hba->clk_gating.is_suspended = false;
>  	hba->dev_info.b_rpm_dev_flush_capable = false;
> +	ufshcd_clear_ua_wluns(hba);
>  	ufshcd_release(hba);
>  out:
>  	if (hba->dev_info.b_rpm_dev_flush_capable) {
> @@ -8887,6 +8890,8 @@ static int ufshcd_resume(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  		cancel_delayed_work(&hba->rpm_dev_flush_recheck_work);
>  	}
> 
> +	ufshcd_clear_ua_wluns(hba);
> +
>  	/* Schedule clock gating in case of no access to UFS device yet */
>  	ufshcd_release(hba);
