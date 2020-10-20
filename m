Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242D284645
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Oct 2020 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgJFGrG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 02:47:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:37961 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgJFGrG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 6 Oct 2020 02:47:06 -0400
IronPort-SDR: kgfNs3dCMPpynVD7ocOdws+iDD+2j2tPAcEO9PRUmYK65Rb9fERR1LFU9tRvbAcdpCUHJRP0xh
 rS6hd4CSuhgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="161767798"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="161767798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 23:47:05 -0700
IronPort-SDR: n60UX+bp7g9HQ0stn4j8gwMJbIr3UUxpfWx/W7IQh+0umQgIg+RcRMtJFRQ54kLqbXeyb/Jy0i
 SAdvrAbkcPsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="315490143"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2020 23:47:00 -0700
Subject: Re: [PATCH V2] scsi: ufs: Add DeepSleep feature
To:     Bean Huo <huobean@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
References: <20201005130451.20595-1-adrian.hunter@intel.com>
 <dff3236892909139403f70aad4ccc7c004e9f53f.camel@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fc96fc7b-b0cd-aa89-7286-19491761bd2e@intel.com>
Date:   Tue, 6 Oct 2020 09:46:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dff3236892909139403f70aad4ccc7c004e9f53f.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/10/20 6:46 pm, Bean Huo wrote:
> Hi Adrian
> 
> thanks for submitting your patch. this patch looks fine to me.
> 
> 
> do you think the new deepsleep PM level aslo should be added in
> "rpm_lvl" description in Documentation/ABI/testing/sysfs-driver-ufs?

Thanks for looking at this.  Yes, I missed that.  Fixed in V3.

> 
> Thanks,
> Bean
> 
> 
> On Mon, 2020-10-05 at 16:04 +0300, Adrian Hunter wrote:
>> DeepSleep is a UFS v3.1 feature that achieves the lowest power
>> consumption
>> of the device, apart from power off.
>>
>> In DeepSleep mode, no commands are accepted, and the only way to exit
>> is
>> using a hardware reset or power cycle.
>>
>> This patch assumes that if a power cycle was an option, then power
>> off
>> would be preferable, so only exit via a hardware reset is supported.
>>
>> Drivers that wish to support DeepSleep need to set a new capability
>> flag
>> UFSHCD_CAP_DEEPSLEEP and provide a hardware reset via the existing
>>  ->device_reset() callback.
>>
>> It is assumed that UFS devices with wspecversion >= 0x310 support
>> DeepSleep.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>>
>> Changes in V2:
>>
>>
>> 	Fix SSU command IMMED setting and consequently drop patch 2.
>>
>>
>>  drivers/scsi/ufs/ufs-sysfs.c |  7 +++++++
>>  drivers/scsi/ufs/ufs.h       |  1 +
>>  drivers/scsi/ufs/ufshcd.c    | 39
>> ++++++++++++++++++++++++++++++++++--
>>  drivers/scsi/ufs/ufshcd.h    | 17 +++++++++++++++-
>>  include/trace/events/ufs.h   |  3 ++-
>>  5 files changed, 63 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-
>> sysfs.c
>> index bdcd27faa054..08e72b7eef6a 100644
>> --- a/drivers/scsi/ufs/ufs-sysfs.c
>> +++ b/drivers/scsi/ufs/ufs-sysfs.c
>> @@ -28,6 +28,7 @@ static const char
>> *ufschd_ufs_dev_pwr_mode_to_string(
>>  	case UFS_ACTIVE_PWR_MODE:	return "ACTIVE";
>>  	case UFS_SLEEP_PWR_MODE:	return "SLEEP";
>>  	case UFS_POWERDOWN_PWR_MODE:	return "POWERDOWN";
>> +	case UFS_DEEPSLEEP_PWR_MODE:	return "DEEPSLEEP";
>>  	default:			return "UNKNOWN";
>>  	}
>>  }
>> @@ -38,6 +39,7 @@ static inline ssize_t ufs_sysfs_pm_lvl_store(struct
>> device *dev,
>>  					     bool rpm)
>>  {
>>  	struct ufs_hba *hba = dev_get_drvdata(dev);
>> +	struct ufs_dev_info *dev_info = &hba->dev_info;
>>  	unsigned long flags, value;
>>  
>>  	if (kstrtoul(buf, 0, &value))
>> @@ -46,6 +48,11 @@ static inline ssize_t
>> ufs_sysfs_pm_lvl_store(struct device *dev,
>>  	if (value >= UFS_PM_LVL_MAX)
>>  		return -EINVAL;
>>  
>> +	if (ufs_pm_lvl_states[value].dev_state ==
>> UFS_DEEPSLEEP_PWR_MODE &&
>> +	    (!(hba->caps & UFSHCD_CAP_DEEPSLEEP) ||
>> +	     !(dev_info->wspecversion >= 0x310)))
>> +		return -EINVAL;
>> +
>>  	spin_lock_irqsave(hba->host->host_lock, flags);
>>  	if (rpm)
>>  		hba->rpm_lvl = value;
>> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>> index f8ab16f30fdc..d593edb48767 100644
>> --- a/drivers/scsi/ufs/ufs.h
>> +++ b/drivers/scsi/ufs/ufs.h
>> @@ -442,6 +442,7 @@ enum ufs_dev_pwr_mode {
>>  	UFS_ACTIVE_PWR_MODE	= 1,
>>  	UFS_SLEEP_PWR_MODE	= 2,
>>  	UFS_POWERDOWN_PWR_MODE	= 3,
>> +	UFS_DEEPSLEEP_PWR_MODE	= 4,
>>  };
>>  
>>  #define UFS_WB_BUF_REMAIN_PERCENT(val) ((val) / 10)
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index b8f573a02713..ccacf54ed7ef 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -163,6 +163,11 @@ struct ufs_pm_lvl_states ufs_pm_lvl_states[] = {
>>  	{UFS_SLEEP_PWR_MODE, UIC_LINK_HIBERN8_STATE},
>>  	{UFS_POWERDOWN_PWR_MODE, UIC_LINK_HIBERN8_STATE},
>>  	{UFS_POWERDOWN_PWR_MODE, UIC_LINK_OFF_STATE},
>> +	/*
>> +	 * For DeepSleep, the link is first put in hibern8 and then
>> off.
>> +	 * Leaving the link in hibern8 is not supported.
>> +	 */
>> +	{UFS_DEEPSLEEP_PWR_MODE, UIC_LINK_OFF_STATE},
>>  };
>>  
>>  static inline enum ufs_dev_pwr_mode
>> @@ -8292,7 +8297,8 @@ static int ufshcd_link_state_transition(struct
>> ufs_hba *hba,
>>  	}
>>  	/*
>>  	 * If autobkops is enabled, link can't be turned off because
>> -	 * turning off the link would also turn off the device.
>> +	 * turning off the link would also turn off the device, except
>> in the
>> +	 * case of DeepSleep where the device is expected to remain
>> powered.
>>  	 */
>>  	else if ((req_link_state == UIC_LINK_OFF_STATE) &&
>>  		 (!check_for_bkops || !hba->auto_bkops_enabled)) {
>> @@ -8302,6 +8308,9 @@ static int ufshcd_link_state_transition(struct
>> ufs_hba *hba,
>>  		 * put the link in low power mode is to send the DME
>> end point
>>  		 * to device and then send the DME reset command to
>> local
>>  		 * unipro. But putting the link in hibern8 is much
>> faster.
>> +		 *
>> +		 * Note also that putting the link in Hibern8 is a
>> requirement
>> +		 * for entering DeepSleep.
>>  		 */
>>  		ret = ufshcd_uic_hibern8_enter(hba);
>>  		if (ret) {
>> @@ -8434,6 +8443,7 @@ static void ufshcd_hba_vreg_set_hpm(struct
>> ufs_hba *hba)
>>  static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>>  {
>>  	int ret = 0;
>> +	int check_for_bkops;
>>  	enum ufs_pm_level pm_lvl;
>>  	enum ufs_dev_pwr_mode req_dev_pwr_mode;
>>  	enum uic_link_state req_link_state;
>> @@ -8519,7 +8529,13 @@ static int ufshcd_suspend(struct ufs_hba *hba,
>> enum ufs_pm_op pm_op)
>>  	}
>>  
>>  	flush_work(&hba->eeh_work);
>> -	ret = ufshcd_link_state_transition(hba, req_link_state, 1);
>> +
>> +	/*
>> +	 * In the case of DeepSleep, the device is expected to remain
>> powered
>> +	 * with the link off, so do not check for bkops.
>> +	 */
>> +	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
>> +	ret = ufshcd_link_state_transition(hba, req_link_state,
>> check_for_bkops);
>>  	if (ret)
>>  		goto set_dev_active;
>>  
>> @@ -8560,11 +8576,25 @@ static int ufshcd_suspend(struct ufs_hba
>> *hba, enum ufs_pm_op pm_op)
>>  	if (hba->clk_scaling.is_allowed)
>>  		ufshcd_resume_clkscaling(hba);
>>  	ufshcd_vreg_set_hpm(hba);
>> +	/*
>> +	 * Device hardware reset is required to exit DeepSleep. Also,
>> for
>> +	 * DeepSleep, the link is off so host reset and restore will be
>> done
>> +	 * further below.
>> +	 */
>> +	if (ufshcd_is_ufs_dev_deepsleep(hba)) {
>> +		ufshcd_vops_device_reset(hba);
>> +		WARN_ON(!ufshcd_is_link_off(hba));
>> +	}
>>  	if (ufshcd_is_link_hibern8(hba) &&
>> !ufshcd_uic_hibern8_exit(hba))
>>  		ufshcd_set_link_active(hba);
>>  	else if (ufshcd_is_link_off(hba))
>>  		ufshcd_host_reset_and_restore(hba);
>>  set_dev_active:
>> +	/* Can also get here needing to exit DeepSleep */
>> +	if (ufshcd_is_ufs_dev_deepsleep(hba)) {
>> +		ufshcd_vops_device_reset(hba);
>> +		ufshcd_host_reset_and_restore(hba);
>> +	}
>>  	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
>>  		ufshcd_disable_auto_bkops(hba);
>>  enable_gating:
>> @@ -8626,6 +8656,9 @@ static int ufshcd_resume(struct ufs_hba *hba,
>> enum ufs_pm_op pm_op)
>>  	if (ret)
>>  		goto disable_vreg;
>>  
>> +	/* For DeepSleep, the only supported option is to have the link
>> off */
>> +	WARN_ON(ufshcd_is_ufs_dev_deepsleep(hba) &&
>> !ufshcd_is_link_off(hba));
>> +
>>  	if (ufshcd_is_link_hibern8(hba)) {
>>  		ret = ufshcd_uic_hibern8_exit(hba);
>>  		if (!ret) {
>> @@ -8639,6 +8672,8 @@ static int ufshcd_resume(struct ufs_hba *hba,
>> enum ufs_pm_op pm_op)
>>  		/*
>>  		 * A full initialization of the host and the device is
>>  		 * required since the link was put to off during
>> suspend.
>> +		 * Note, in the case of DeepSleep, the device will exit
>> +		 * DeepSleep due to device reset.
>>  		 */
>>  		ret = ufshcd_reset_and_restore(hba);
>>  		/*
>> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
>> index 6663325ed8a0..8c6094fb35f4 100644
>> --- a/drivers/scsi/ufs/ufshcd.h
>> +++ b/drivers/scsi/ufs/ufshcd.h
>> @@ -114,16 +114,22 @@ enum uic_link_state {
>>  	((h)->curr_dev_pwr_mode = UFS_SLEEP_PWR_MODE)
>>  #define ufshcd_set_ufs_dev_poweroff(h) \
>>  	((h)->curr_dev_pwr_mode = UFS_POWERDOWN_PWR_MODE)
>> +#define ufshcd_set_ufs_dev_deepsleep(h) \
>> +	((h)->curr_dev_pwr_mode = UFS_DEEPSLEEP_PWR_MODE)
>>  #define ufshcd_is_ufs_dev_active(h) \
>>  	((h)->curr_dev_pwr_mode == UFS_ACTIVE_PWR_MODE)
>>  #define ufshcd_is_ufs_dev_sleep(h) \
>>  	((h)->curr_dev_pwr_mode == UFS_SLEEP_PWR_MODE)
>>  #define ufshcd_is_ufs_dev_poweroff(h) \
>>  	((h)->curr_dev_pwr_mode == UFS_POWERDOWN_PWR_MODE)
>> +#define ufshcd_is_ufs_dev_deepsleep(h) \
>> +	((h)->curr_dev_pwr_mode == UFS_DEEPSLEEP_PWR_MODE)
>>  
>>  /*
>>   * UFS Power management levels.
>> - * Each level is in increasing order of power savings.
>> + * Each level is in increasing order of power savings, except
>> DeepSleep
>> + * which is lower than PowerDown with power on but not PowerDown
>> with
>> + * power off.
>>   */
>>  enum ufs_pm_level {
>>  	UFS_PM_LVL_0, /* UFS_ACTIVE_PWR_MODE, UIC_LINK_ACTIVE_STATE */
>> @@ -132,6 +138,7 @@ enum ufs_pm_level {
>>  	UFS_PM_LVL_3, /* UFS_SLEEP_PWR_MODE, UIC_LINK_HIBERN8_STATE */
>>  	UFS_PM_LVL_4, /* UFS_POWERDOWN_PWR_MODE, UIC_LINK_HIBERN8_STATE
>> */
>>  	UFS_PM_LVL_5, /* UFS_POWERDOWN_PWR_MODE, UIC_LINK_OFF_STATE */
>> +	UFS_PM_LVL_6, /* UFS_DEEPSLEEP_PWR_MODE, UIC_LINK_OFF_STATE */
>>  	UFS_PM_LVL_MAX
>>  };
>>  
>> @@ -591,6 +598,14 @@ enum ufshcd_caps {
>>  	 * inline crypto engine, if it is present
>>  	 */
>>  	UFSHCD_CAP_CRYPTO				= 1 << 8,
>> +
>> +	/*
>> +	 * This capability allows the host controller driver to use
>> DeepSleep,
>> +	 * if it is supported by the UFS device. The host controller
>> driver must
>> +	 * support device hardware reset via the hba->device_reset()
>> callback,
>> +	 * in order to exit DeepSleep state.
>> +	 */
>> +	UFSHCD_CAP_DEEPSLEEP				= 1 << 9,
>>  };
>>  
>>  struct ufs_hba_variant_params {
>> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
>> index 84841b3a7ffd..2362244c2a9e 100644
>> --- a/include/trace/events/ufs.h
>> +++ b/include/trace/events/ufs.h
>> @@ -19,7 +19,8 @@
>>  #define UFS_PWR_MODES			\
>>  	EM(UFS_ACTIVE_PWR_MODE)		\
>>  	EM(UFS_SLEEP_PWR_MODE)		\
>> -	EMe(UFS_POWERDOWN_PWR_MODE)
>> +	EM(UFS_POWERDOWN_PWR_MODE)	\
>> +	EMe(UFS_DEEPSLEEP_PWR_MODE)
>>  
>>  #define UFSCHD_CLK_GATING_STATES	\
>>  	EM(CLKS_OFF)			\
> 

