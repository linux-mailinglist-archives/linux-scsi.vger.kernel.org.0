Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17E7283B90
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Oct 2020 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgJEPq2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Oct 2020 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgJEPq2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Oct 2020 11:46:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D6C0613CE;
        Mon,  5 Oct 2020 08:46:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so10143544wrp.8;
        Mon, 05 Oct 2020 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvZjJ33Bk1CDFZkZmRquuRUUZq7ffudAiMbV3hy2hWc=;
        b=gOa1XRpJ4CMLX5d/xeuw/NCkF/XLV1BVg/ZYfXkMiVYD638l5ALMFmdgUEPlzRe5E9
         xb/lkw/rSa0BePGVXQ1/ljcmSRlD/15v7ZE3AxET6oIDvdlBl7dp4legzXA6xgwA4FVB
         X6rMe1MK8HEIKlytOalBAat+58I+PsVjYfd0mmJY37rCp61XnHiSajblBtsHqdGKf+p7
         Ys62SEBGp4ubqrX9+7TeZtdoOkoxs3nlZ5Zi6sdayQDZemI5p+wyNB+CSDtSmAgx7uFF
         rSUFwOZFtStSz/NEiAXuuyguCZPGRXseOmGXLQ7+fXptBnGkW65dqvKW8Z4KOhvbGCup
         5Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvZjJ33Bk1CDFZkZmRquuRUUZq7ffudAiMbV3hy2hWc=;
        b=FVBLP3OthDgcV1EomI/T5wKRXJNZoJd/2UOVpeLrGG6Af4VtdloJUDGTVTP04THoJQ
         Z7tXOktXPU5Bm1M0aC0Xj2G2CmVdnY831/dYws963/2Fsv5aSSUiNF88Ai9Ky7ovNfX1
         oS4YBdxcxVKQkrIg85cuOdNuJIZiuHa12oLYR2x5zt5HhaEqO3vNyyIgMWyGAYu2Qe7L
         uZGmSufL5lDCsH2M6IGUG/6AlA3iZmUt13lqdBYgYmCfEru6FjGOZrxU5tJC/hht3f9F
         60E13NxJebvP8wYTAjqI1RE4H+0XanuimcMy9QWlhzOzHnchKmfVlL7ixXHBh2VnDdSU
         pZEg==
X-Gm-Message-State: AOAM532ki4FmYiwsR9E2cM1Lr0NXXje1Jpv3F0AySgDjQ9AZ+gOk8aB1
        xjX5YysLquLjNwmkUno5E1ydIM/JG/2aJjTE
X-Google-Smtp-Source: ABdhPJwQ4jStPoOYY32ZIsZaCnFsmK2XKgvMjIO7OdZPjzwiAr2wWYalfy6gM09vSF3DnZB+aGvjGw==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr18407025wrs.405.1601912786305;
        Mon, 05 Oct 2020 08:46:26 -0700 (PDT)
Received: from ubuntu-laptop ([165.225.203.62])
        by smtp.googlemail.com with ESMTPSA id x64sm144951wmg.33.2020.10.05.08.46.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Oct 2020 08:46:25 -0700 (PDT)
Message-ID: <dff3236892909139403f70aad4ccc7c004e9f53f.camel@gmail.com>
Subject: Re: [PATCH V2] scsi: ufs: Add DeepSleep feature
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Date:   Mon, 05 Oct 2020 17:46:23 +0200
In-Reply-To: <20201005130451.20595-1-adrian.hunter@intel.com>
References: <20201005130451.20595-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Adrian

thanks for submitting your patch. this patch looks fine to me.


do you think the new deepsleep PM level aslo should be added in
"rpm_lvl" description in Documentation/ABI/testing/sysfs-driver-ufs?

Thanks,
Bean


On Mon, 2020-10-05 at 16:04 +0300, Adrian Hunter wrote:
> DeepSleep is a UFS v3.1 feature that achieves the lowest power
> consumption
> of the device, apart from power off.
> 
> In DeepSleep mode, no commands are accepted, and the only way to exit
> is
> using a hardware reset or power cycle.
> 
> This patch assumes that if a power cycle was an option, then power
> off
> would be preferable, so only exit via a hardware reset is supported.
> 
> Drivers that wish to support DeepSleep need to set a new capability
> flag
> UFSHCD_CAP_DEEPSLEEP and provide a hardware reset via the existing
>  ->device_reset() callback.
> 
> It is assumed that UFS devices with wspecversion >= 0x310 support
> DeepSleep.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V2:
> 
> 
> 	Fix SSU command IMMED setting and consequently drop patch 2.
> 
> 
>  drivers/scsi/ufs/ufs-sysfs.c |  7 +++++++
>  drivers/scsi/ufs/ufs.h       |  1 +
>  drivers/scsi/ufs/ufshcd.c    | 39
> ++++++++++++++++++++++++++++++++++--
>  drivers/scsi/ufs/ufshcd.h    | 17 +++++++++++++++-
>  include/trace/events/ufs.h   |  3 ++-
>  5 files changed, 63 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-
> sysfs.c
> index bdcd27faa054..08e72b7eef6a 100644
> --- a/drivers/scsi/ufs/ufs-sysfs.c
> +++ b/drivers/scsi/ufs/ufs-sysfs.c
> @@ -28,6 +28,7 @@ static const char
> *ufschd_ufs_dev_pwr_mode_to_string(
>  	case UFS_ACTIVE_PWR_MODE:	return "ACTIVE";
>  	case UFS_SLEEP_PWR_MODE:	return "SLEEP";
>  	case UFS_POWERDOWN_PWR_MODE:	return "POWERDOWN";
> +	case UFS_DEEPSLEEP_PWR_MODE:	return "DEEPSLEEP";
>  	default:			return "UNKNOWN";
>  	}
>  }
> @@ -38,6 +39,7 @@ static inline ssize_t ufs_sysfs_pm_lvl_store(struct
> device *dev,
>  					     bool rpm)
>  {
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	struct ufs_dev_info *dev_info = &hba->dev_info;
>  	unsigned long flags, value;
>  
>  	if (kstrtoul(buf, 0, &value))
> @@ -46,6 +48,11 @@ static inline ssize_t
> ufs_sysfs_pm_lvl_store(struct device *dev,
>  	if (value >= UFS_PM_LVL_MAX)
>  		return -EINVAL;
>  
> +	if (ufs_pm_lvl_states[value].dev_state ==
> UFS_DEEPSLEEP_PWR_MODE &&
> +	    (!(hba->caps & UFSHCD_CAP_DEEPSLEEP) ||
> +	     !(dev_info->wspecversion >= 0x310)))
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(hba->host->host_lock, flags);
>  	if (rpm)
>  		hba->rpm_lvl = value;
> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
> index f8ab16f30fdc..d593edb48767 100644
> --- a/drivers/scsi/ufs/ufs.h
> +++ b/drivers/scsi/ufs/ufs.h
> @@ -442,6 +442,7 @@ enum ufs_dev_pwr_mode {
>  	UFS_ACTIVE_PWR_MODE	= 1,
>  	UFS_SLEEP_PWR_MODE	= 2,
>  	UFS_POWERDOWN_PWR_MODE	= 3,
> +	UFS_DEEPSLEEP_PWR_MODE	= 4,
>  };
>  
>  #define UFS_WB_BUF_REMAIN_PERCENT(val) ((val) / 10)
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index b8f573a02713..ccacf54ed7ef 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -163,6 +163,11 @@ struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
>  	{UFS_SLEEP_PWR_MODE, UIC_LINK_HIBERN8_STATE},
>  	{UFS_POWERDOWN_PWR_MODE, UIC_LINK_HIBERN8_STATE},
>  	{UFS_POWERDOWN_PWR_MODE, UIC_LINK_OFF_STATE},
> +	/*
> +	 * For DeepSleep, the link is first put in hibern8 and then
> off.
> +	 * Leaving the link in hibern8 is not supported.
> +	 */
> +	{UFS_DEEPSLEEP_PWR_MODE, UIC_LINK_OFF_STATE},
>  };
>  
>  static inline enum ufs_dev_pwr_mode
> @@ -8292,7 +8297,8 @@ static int ufshcd_link_state_transition(struct
> ufs_hba *hba,
>  	}
>  	/*
>  	 * If autobkops is enabled, link can't be turned off because
> -	 * turning off the link would also turn off the device.
> +	 * turning off the link would also turn off the device, except
> in the
> +	 * case of DeepSleep where the device is expected to remain
> powered.
>  	 */
>  	else if ((req_link_state == UIC_LINK_OFF_STATE) &&
>  		 (!check_for_bkops || !hba->auto_bkops_enabled)) {
> @@ -8302,6 +8308,9 @@ static int ufshcd_link_state_transition(struct
> ufs_hba *hba,
>  		 * put the link in low power mode is to send the DME
> end point
>  		 * to device and then send the DME reset command to
> local
>  		 * unipro. But putting the link in hibern8 is much
> faster.
> +		 *
> +		 * Note also that putting the link in Hibern8 is a
> requirement
> +		 * for entering DeepSleep.
>  		 */
>  		ret = ufshcd_uic_hibern8_enter(hba);
>  		if (ret) {
> @@ -8434,6 +8443,7 @@ static void ufshcd_hba_vreg_set_hpm(struct
> ufs_hba *hba)
>  static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  {
>  	int ret = 0;
> +	int check_for_bkops;
>  	enum ufs_pm_level pm_lvl;
>  	enum ufs_dev_pwr_mode req_dev_pwr_mode;
>  	enum uic_link_state req_link_state;
> @@ -8519,7 +8529,13 @@ static int ufshcd_suspend(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  	}
>  
>  	flush_work(&hba->eeh_work);
> -	ret = ufshcd_link_state_transition(hba, req_link_state, 1);
> +
> +	/*
> +	 * In the case of DeepSleep, the device is expected to remain
> powered
> +	 * with the link off, so do not check for bkops.
> +	 */
> +	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
> +	ret = ufshcd_link_state_transition(hba, req_link_state,
> check_for_bkops);
>  	if (ret)
>  		goto set_dev_active;
>  
> @@ -8560,11 +8576,25 @@ static int ufshcd_suspend(struct ufs_hba
> *hba, enum ufs_pm_op pm_op)
>  	if (hba->clk_scaling.is_allowed)
>  		ufshcd_resume_clkscaling(hba);
>  	ufshcd_vreg_set_hpm(hba);
> +	/*
> +	 * Device hardware reset is required to exit DeepSleep. Also,
> for
> +	 * DeepSleep, the link is off so host reset and restore will be
> done
> +	 * further below.
> +	 */
> +	if (ufshcd_is_ufs_dev_deepsleep(hba)) {
> +		ufshcd_vops_device_reset(hba);
> +		WARN_ON(!ufshcd_is_link_off(hba));
> +	}
>  	if (ufshcd_is_link_hibern8(hba) &&
> !ufshcd_uic_hibern8_exit(hba))
>  		ufshcd_set_link_active(hba);
>  	else if (ufshcd_is_link_off(hba))
>  		ufshcd_host_reset_and_restore(hba);
>  set_dev_active:
> +	/* Can also get here needing to exit DeepSleep */
> +	if (ufshcd_is_ufs_dev_deepsleep(hba)) {
> +		ufshcd_vops_device_reset(hba);
> +		ufshcd_host_reset_and_restore(hba);
> +	}
>  	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
>  		ufshcd_disable_auto_bkops(hba);
>  enable_gating:
> @@ -8626,6 +8656,9 @@ static int ufshcd_resume(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  	if (ret)
>  		goto disable_vreg;
>  
> +	/* For DeepSleep, the only supported option is to have the link
> off */
> +	WARN_ON(ufshcd_is_ufs_dev_deepsleep(hba) &&
> !ufshcd_is_link_off(hba));
> +
>  	if (ufshcd_is_link_hibern8(hba)) {
>  		ret = ufshcd_uic_hibern8_exit(hba);
>  		if (!ret) {
> @@ -8639,6 +8672,8 @@ static int ufshcd_resume(struct ufs_hba *hba,
> enum ufs_pm_op pm_op)
>  		/*
>  		 * A full initialization of the host and the device is
>  		 * required since the link was put to off during
> suspend.
> +		 * Note, in the case of DeepSleep, the device will exit
> +		 * DeepSleep due to device reset.
>  		 */
>  		ret = ufshcd_reset_and_restore(hba);
>  		/*
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 6663325ed8a0..8c6094fb35f4 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -114,16 +114,22 @@ enum uic_link_state {
>  	((h)->curr_dev_pwr_mode = UFS_SLEEP_PWR_MODE)
>  #define ufshcd_set_ufs_dev_poweroff(h) \
>  	((h)->curr_dev_pwr_mode = UFS_POWERDOWN_PWR_MODE)
> +#define ufshcd_set_ufs_dev_deepsleep(h) \
> +	((h)->curr_dev_pwr_mode = UFS_DEEPSLEEP_PWR_MODE)
>  #define ufshcd_is_ufs_dev_active(h) \
>  	((h)->curr_dev_pwr_mode == UFS_ACTIVE_PWR_MODE)
>  #define ufshcd_is_ufs_dev_sleep(h) \
>  	((h)->curr_dev_pwr_mode == UFS_SLEEP_PWR_MODE)
>  #define ufshcd_is_ufs_dev_poweroff(h) \
>  	((h)->curr_dev_pwr_mode == UFS_POWERDOWN_PWR_MODE)
> +#define ufshcd_is_ufs_dev_deepsleep(h) \
> +	((h)->curr_dev_pwr_mode == UFS_DEEPSLEEP_PWR_MODE)
>  
>  /*
>   * UFS Power management levels.
> - * Each level is in increasing order of power savings.
> + * Each level is in increasing order of power savings, except
> DeepSleep
> + * which is lower than PowerDown with power on but not PowerDown
> with
> + * power off.
>   */
>  enum ufs_pm_level {
>  	UFS_PM_LVL_0, /* UFS_ACTIVE_PWR_MODE, UIC_LINK_ACTIVE_STATE */
> @@ -132,6 +138,7 @@ enum ufs_pm_level {
>  	UFS_PM_LVL_3, /* UFS_SLEEP_PWR_MODE, UIC_LINK_HIBERN8_STATE */
>  	UFS_PM_LVL_4, /* UFS_POWERDOWN_PWR_MODE, UIC_LINK_HIBERN8_STATE
> */
>  	UFS_PM_LVL_5, /* UFS_POWERDOWN_PWR_MODE, UIC_LINK_OFF_STATE */
> +	UFS_PM_LVL_6, /* UFS_DEEPSLEEP_PWR_MODE, UIC_LINK_OFF_STATE */
>  	UFS_PM_LVL_MAX
>  };
>  
> @@ -591,6 +598,14 @@ enum ufshcd_caps {
>  	 * inline crypto engine, if it is present
>  	 */
>  	UFSHCD_CAP_CRYPTO				= 1 << 8,
> +
> +	/*
> +	 * This capability allows the host controller driver to use
> DeepSleep,
> +	 * if it is supported by the UFS device. The host controller
> driver must
> +	 * support device hardware reset via the hba->device_reset()
> callback,
> +	 * in order to exit DeepSleep state.
> +	 */
> +	UFSHCD_CAP_DEEPSLEEP				= 1 << 9,
>  };
>  
>  struct ufs_hba_variant_params {
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index 84841b3a7ffd..2362244c2a9e 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -19,7 +19,8 @@
>  #define UFS_PWR_MODES			\
>  	EM(UFS_ACTIVE_PWR_MODE)		\
>  	EM(UFS_SLEEP_PWR_MODE)		\
> -	EMe(UFS_POWERDOWN_PWR_MODE)
> +	EM(UFS_POWERDOWN_PWR_MODE)	\
> +	EMe(UFS_DEEPSLEEP_PWR_MODE)
>  
>  #define UFSCHD_CLK_GATING_STATES	\
>  	EM(CLKS_OFF)			\

