Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A1324143
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Feb 2021 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhBXPpV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Feb 2021 10:45:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:20792 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237556AbhBXOit (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Feb 2021 09:38:49 -0500
IronPort-SDR: Llh4X7CtphyG40q4NWVw8YCiThpbVde//A9l0lW2KGVtG8mT1RbH10i/5gisjM+kcEhNeqmZ+9
 s6JhqMkuTZdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="172839140"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="172839140"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 06:34:14 -0800
IronPort-SDR: isPU/gOKOh+seRsTvvPYXskcQz0zrp3vVMFafIKuG/fwzig+KPiVJ2qR7KvGT/sVdnmEBeSxrS
 VANYZE7zE3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="403729160"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2021 06:34:08 -0800
Subject: Re: [PATCH v5 1/2] scsi: ufs: Enable power management for wlun
To:     Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1614142928.git.asutoshd@codeaurora.org>
 <e5940485edfb57906d4b343bf9fd1de408b7103b.1614142928.git.asutoshd@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <91ce18fa-cd86-ea7e-2eb4-51c86fc8a901@intel.com>
Date:   Wed, 24 Feb 2021 16:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e5940485edfb57906d4b343bf9fd1de408b7103b.1614142928.git.asutoshd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 24/02/21 7:13 am, Asutosh Das wrote:
> During runtime-suspend of ufs host, the scsi devices are
> already suspended and so are the queues associated with them.
> But the ufs host sends SSU to wlun during its runtime-suspend.
> During the process blk_queue_enter checks if the queue is not in
> suspended state. If so, it waits for the queue to resume, and never
> comes out of it.
> The commit
> (d55d15a33: scsi: block: Do not accept any requests while suspended)
> adds the check if the queue is in suspended state in blk_queue_enter().
> 
> Call trace:
>  __switch_to+0x174/0x2c4
>  __schedule+0x478/0x764
>  schedule+0x9c/0xe0
>  blk_queue_enter+0x158/0x228
>  blk_mq_alloc_request+0x40/0xa4
>  blk_get_request+0x2c/0x70
>  __scsi_execute+0x60/0x1c4
>  ufshcd_set_dev_pwr_mode+0x124/0x1e4
>  ufshcd_suspend+0x208/0x83c
>  ufshcd_runtime_suspend+0x40/0x154
>  ufshcd_pltfrm_runtime_suspend+0x14/0x20
>  pm_generic_runtime_suspend+0x28/0x3c
>  __rpm_callback+0x80/0x2a4
>  rpm_suspend+0x308/0x614
>  rpm_idle+0x158/0x228
>  pm_runtime_work+0x84/0xac
>  process_one_work+0x1f0/0x470
>  worker_thread+0x26c/0x4c8
>  kthread+0x13c/0x320
>  ret_from_fork+0x10/0x18
> 
> Fix this by registering ufs device wlun as a scsi driver and
> registering it for block runtime-pm. Also make this as a
> supplier for all other luns. That way, this device wlun
> suspends after all the consumers and resumes after
> hba resumes.
> 
> Co-developed-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs-qcom.c      |   2 +
>  drivers/scsi/ufs/ufshcd-pci.c    |  24 --
>  drivers/scsi/ufs/ufshcd-pltfrm.c |  29 +++
>  drivers/scsi/ufs/ufshcd-pltfrm.h |   4 +
>  drivers/scsi/ufs/ufshcd.c        | 491 +++++++++++++++++++++++++++++++--------
>  drivers/scsi/ufs/ufshcd.h        |   5 +
>  include/trace/events/ufs.h       |  20 ++
>  7 files changed, 454 insertions(+), 121 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index f97d7b0..8cd8cfd 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -1546,6 +1546,8 @@ static const struct dev_pm_ops ufs_qcom_pm_ops = {
>  	.runtime_suspend = ufshcd_pltfrm_runtime_suspend,
>  	.runtime_resume  = ufshcd_pltfrm_runtime_resume,
>  	.runtime_idle    = ufshcd_pltfrm_runtime_idle,
> +	.prepare	= ufshcd_pltfrm_prepare,
> +	.resume_early	= ufshcd_pltfrm_resume_early,

The pair for the "prepare" callback is the "complete" callback rather than
"resume_early"

Presumably all drivers will need this kind of change.

>  };
>  
>  static struct platform_driver ufs_qcom_pltform = {
> diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
> index fadd566..ab84d56 100644
> --- a/drivers/scsi/ufs/ufshcd-pci.c
> +++ b/drivers/scsi/ufs/ufshcd-pci.c
> @@ -247,29 +247,6 @@ static int ufshcd_pci_resume(struct device *dev)
>  	return ufshcd_system_resume(dev_get_drvdata(dev));
>  }
>  
> -/**
> - * ufshcd_pci_poweroff - suspend-to-disk poweroff function
> - * @dev: pointer to PCI device handle
> - *
> - * Returns 0 if successful
> - * Returns non-zero otherwise
> - */
> -static int ufshcd_pci_poweroff(struct device *dev)
> -{
> -	struct ufs_hba *hba = dev_get_drvdata(dev);
> -	int spm_lvl = hba->spm_lvl;
> -	int ret;
> -
> -	/*
> -	 * For poweroff we need to set the UFS device to PowerDown mode.
> -	 * Force spm_lvl to ensure that.
> -	 */
> -	hba->spm_lvl = 5;
> -	ret = ufshcd_system_suspend(hba);
> -	hba->spm_lvl = spm_lvl;
> -	return ret;
> -}
> -
>  #endif /* !CONFIG_PM_SLEEP */
>  
>  #ifdef CONFIG_PM
> @@ -370,7 +347,6 @@ static const struct dev_pm_ops ufshcd_pci_pm_ops = {
>  	.resume		= ufshcd_pci_resume,
>  	.freeze		= ufshcd_pci_suspend,
>  	.thaw		= ufshcd_pci_resume,
> -	.poweroff	= ufshcd_pci_poweroff,
>  	.restore	= ufshcd_pci_resume,
>  #endif
>  	SET_RUNTIME_PM_OPS(ufshcd_pci_runtime_suspend,
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index 1a69949..84550dc 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -217,6 +217,35 @@ int ufshcd_pltfrm_runtime_idle(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(ufshcd_pltfrm_runtime_idle);
>  
> +int ufshcd_pltfrm_prepare(struct device *dev)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	/*
> +	 * SCSI assumes that runtime-pm and system-pm for scsi drivers
> +	 * are same. And it doesn't wake up the device for system-suspend
> +	 * if it's runtime suspended. But ufs doesn't follow that.
> +	 * The rpm-lvl and spm-lvl can be different in ufs.
> +	 * Force it to honor system-suspend.

Presumably we could check whether the current power mode is different from
the spm_lvl target power mode, and only do this in that case?

> +	 */
> +	scsi_autopm_get_device(hba->sdev_ufs_device);
> +	/* Refer ufshcd_pltfrm_resume_early() */
> +	pm_runtime_get_noresume(&hba->sdev_ufs_device->sdev_gendev);
> +	scsi_autopm_put_device(hba->sdev_ufs_device);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_pltfrm_prepare);

The PCI driver will need this also, so we need a bus-agnostic version
exported from ufshcd.c that all drivers can use, like ufshcd_suspend() etc.

> +
> +int ufshcd_pltfrm_resume_early(struct device *dev)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	pm_runtime_put_noidle(&hba->sdev_ufs_device->sdev_gendev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_pltfrm_resume_early);

Ditto

>  #endif /* CONFIG_PM */
>  
>  void ufshcd_pltfrm_shutdown(struct platform_device *pdev)
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.h b/drivers/scsi/ufs/ufshcd-pltfrm.h
> index 772a8e8..caf2709 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.h
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.h
> @@ -40,6 +40,8 @@ int ufshcd_pltfrm_resume(struct device *dev);
>  int ufshcd_pltfrm_runtime_suspend(struct device *dev);
>  int ufshcd_pltfrm_runtime_resume(struct device *dev);
>  int ufshcd_pltfrm_runtime_idle(struct device *dev);
> +int ufshcd_pltfrm_prepare(struct device *dev);
> +int ufshcd_pltfrm_resume_early(struct device *dev);
>  
>  #else /* !CONFIG_PM */
>  
> @@ -48,6 +50,8 @@ int ufshcd_pltfrm_runtime_idle(struct device *dev);
>  #define ufshcd_pltfrm_runtime_suspend	NULL
>  #define ufshcd_pltfrm_runtime_resume	NULL
>  #define ufshcd_pltfrm_runtime_idle	NULL
> +#define ufshcd_pltfrm_prepare	NULL
> +#define ufshcd_pltfrm_resume_early	NULL
>  
>  #endif /* CONFIG_PM */
>  
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 45624c7..bc96544 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/blk-pm.h>
>  #include <linux/blkdev.h>
> +#include <scsi/scsi_driver.h>
>  #include "ufshcd.h"
>  #include "ufs_quirks.h"
>  #include "unipro.h"
> @@ -78,6 +79,8 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>  
> +#define wlun_dev_to_hba(dv) shost_priv(to_scsi_device(dv)->host)
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -251,6 +254,12 @@ static int ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
>  static inline int ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
>  static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
>  static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
> +static int ufshcd_wl_runtime_suspend(struct device *dev);
> +static int ufshcd_wl_runtime_resume(struct device *dev);
> +static int ufshcd_wl_suspend(struct device *dev);
> +static int ufshcd_wl_resume(struct device *dev);
> +static void ufshcd_wl_shutdown(struct device *dev);
> +static int ufshcd_clear_ua_wlun(struct ufs_hba *hba, u8 wlun);
>  
>  static inline bool ufshcd_valid_tag(struct ufs_hba *hba, int tag)
>  {
> @@ -1556,7 +1565,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>  	if (value == hba->clk_scaling.is_enabled)
>  		goto out;
>  
> -	pm_runtime_get_sync(hba->dev);
> +	scsi_autopm_get_device(hba->sdev_ufs_device);
>  	ufshcd_hold(hba, false);
>  
>  	hba->clk_scaling.is_enabled = value;
> @@ -1572,7 +1581,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>  	}
>  
>  	ufshcd_release(hba);
> -	pm_runtime_put_sync(hba->dev);
> +	scsi_autopm_put_device(hba->sdev_ufs_device);
>  out:
>  	up(&hba->host_sem);
>  	return err ? err : count;
> @@ -2572,6 +2581,17 @@ static inline u16 ufshcd_upiu_wlun_to_scsi_wlun(u8 upiu_wlun_id)
>  	return (upiu_wlun_id & ~UFS_UPIU_WLUN_ID) | SCSI_W_LUN_BASE;
>  }
>  
> +static inline bool is_rpmb_wlun(struct scsi_device *sdev)
> +{
> +	return (sdev->lun == ufshcd_upiu_wlun_to_scsi_wlun(UFS_UPIU_RPMB_WLUN));
> +}
> +
> +static inline bool is_device_wlun(struct scsi_device *sdev)
> +{
> +	return (sdev->lun ==
> +		ufshcd_upiu_wlun_to_scsi_wlun(UFS_UPIU_UFS_DEVICE_WLUN));
> +}
> +
>  static void ufshcd_init_lrb(struct ufs_hba *hba, struct ufshcd_lrb *lrb, int i)
>  {
>  	struct utp_transfer_cmd_desc *cmd_descp = hba->ucdl_base_addr;
> @@ -4808,6 +4828,41 @@ static inline void ufshcd_get_lu_power_on_wp_status(struct ufs_hba *hba,
>  }
>  
>  /**
> + * ufshcd_setup_links - associate link b/w device wlun and other luns
> + * @sdev: pointer to SCSI device
> + * @hba: pointer to ufs hba
> + */
> +static void ufshcd_setup_links(struct ufs_hba *hba, struct scsi_device *sdev)
> +{
> +	struct device_link *link;
> +
> +	/*
> +	 * device wlun is the supplier & rest of the luns are consumers
> +	 * This ensures that device wlun suspends after all other luns.
> +	 */
> +	if (hba->sdev_ufs_device) {
> +		link = device_link_add(&sdev->sdev_gendev,
> +				       &hba->sdev_ufs_device->sdev_gendev,
> +				       DL_FLAG_PM_RUNTIME);
> +		if (!link) {
> +			dev_err(&sdev->sdev_gendev, "Failed establishing link - %s\n",
> +				dev_name(&hba->sdev_ufs_device->sdev_gendev));
> +			return;
> +		}
> +		hba->luns_avail--;
> +		/* Ignore REPORT_LUN wlun probing */
> +		if (hba->luns_avail != 1)
> +			return;
> +
> +		pm_runtime_put_noidle(&hba->sdev_ufs_device->sdev_gendev);
> +		pm_runtime_mark_last_busy(&hba->sdev_ufs_device->sdev_gendev);
> +	} else {
> +		/* device wlun is probed */
> +		hba->luns_avail--;
> +	}
> +}
> +
> +/**
>   * ufshcd_slave_alloc - handle initial SCSI device configurations
>   * @sdev: pointer to SCSI device
>   *
> @@ -4838,6 +4893,8 @@ static int ufshcd_slave_alloc(struct scsi_device *sdev)
>  
>  	ufshcd_get_lu_power_on_wp_status(hba, sdev);
>  
> +	ufshcd_setup_links(hba, sdev);
> +
>  	return 0;
>  }
>  
> @@ -4984,16 +5041,9 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
>  			 * solution could be to abort the system suspend if
>  			 * UFS device needs urgent BKOPs.
>  			 */
> -			if (!hba->pm_op_in_progress &&
> -			    ufshcd_is_exception_event(lrbp->ucd_rsp_ptr) &&
> -			    schedule_work(&hba->eeh_work)) {
> -				/*
> -				 * Prevent suspend once eeh_work is scheduled
> -				 * to avoid deadlock between ufshcd_suspend
> -				 * and exception event handler.
> -				 */
> -				pm_runtime_get_noresume(hba->dev);
> -			}
> +			if (ufshcd_is_exception_event(lrbp->ucd_rsp_ptr))
> +				/* Flushed in suspend */
> +				schedule_work(&hba->eeh_work);
>  			break;
>  		case UPIU_TRANSACTION_REJECT_UPIU:
>  			/* TODO: handle Reject UPIU Response */
> @@ -5589,8 +5639,8 @@ static void ufshcd_rpm_dev_flush_recheck_work(struct work_struct *work)
>  	 * after a certain delay to recheck the threshold by next runtime
>  	 * suspend.
>  	 */
> -	pm_runtime_get_sync(hba->dev);
> -	pm_runtime_put_sync(hba->dev);
> +	scsi_autopm_get_device(hba->sdev_ufs_device);
> +	scsi_autopm_put_device(hba->sdev_ufs_device);
>  }
>  
>  /**
> @@ -5607,7 +5657,6 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
>  	u32 status = 0;
>  	hba = container_of(work, struct ufs_hba, eeh_work);
>  
> -	pm_runtime_get_sync(hba->dev);
>  	ufshcd_scsi_block_requests(hba);
>  	err = ufshcd_get_ee_status(hba, &status);
>  	if (err) {
> @@ -5623,14 +5672,6 @@ static void ufshcd_exception_event_handler(struct work_struct *work)
>  
>  out:
>  	ufshcd_scsi_unblock_requests(hba);
> -	/*
> -	 * pm_runtime_get_noresume is called while scheduling
> -	 * eeh_work to avoid suspend racing with exception work.
> -	 * Hence decrement usage counter using pm_runtime_put_noidle
> -	 * to allow suspend on completion of exception event handler.
> -	 */
> -	pm_runtime_put_noidle(hba->dev);
> -	pm_runtime_put(hba->dev);
>  	return;
>  }
>  
> @@ -7254,6 +7295,15 @@ static int ufshcd_scsi_add_wlus(struct ufs_hba *hba)
>  		goto out;
>  	}
>  	ufshcd_blk_pm_runtime_init(hba->sdev_ufs_device);
> +	/*
> +	 * A pm_runtime_put_sync is invoked when this device enables blk_pm_runtime
> +	 * & would suspend the device-wlun upon timer expiry.
> +	 * But suspending device wlun _may_ put the ufs device in the pre-defined
> +	 * low power mode (SSU <rpm_lvl>). Probing of other luns may fail then.
> +	 * Don't allow this suspend until all the luns have been probed.
> +	 * See pm_runtime_mark_last_busy in ufshcd_setup_links.
> +	 */
> +	pm_runtime_get_noresume(&hba->sdev_ufs_device->sdev_gendev);
>  	scsi_device_put(hba->sdev_ufs_device);
>  
>  	hba->sdev_rpmb = __scsi_add_device(hba->host, 0, 0,
> @@ -7417,6 +7467,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>  		goto out;
>  	}
>  
> +	hba->luns_avail = desc_buf[DEVICE_DESC_PARAM_NUM_LU] +
> +		desc_buf[DEVICE_DESC_PARAM_NUM_WLU];
> +
>  	ufs_fixup_device_setup(hba);
>  
>  	ufshcd_wb_probe(hba, desc_buf);
> @@ -7747,6 +7800,95 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
>  	return ret;
>  }
>  
> +static int ufshcd_wl_probe(struct device *dev)
> +{
> +	return is_device_wlun(to_scsi_device(dev)) ? 0 : -ENODEV;
> +}
> +
> +static int ufshcd_wl_remove(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ufshcd_wl_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ufshcd_wl_runtime_suspend, ufshcd_wl_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(ufshcd_wl_suspend, ufshcd_wl_resume)

Here SET_SYSTEM_SLEEP_PM_OPS sets .poweroff to ufshcd_wl_suspend() which is
only correct if spm_lvl is 5.  We need it to do what ufshcd_wl_shutdown()
does, although the PM functions return 'int' whereas ->shutdown() returns
'void', so it cannot use the same prototype i.e.

static int ufshcd_wl_poweroff(struct device *dev)
{
	ufshcd_wl_shutdown(dev);
	return 0;
}

Then,
	.suspend = ufshcd_wl_suspend,
	.resume = ufshcd_wl_resume,
	.freeze = ufshcd_wl_suspend,
	.thaw = ufshcd_wl_resume,
	.poweroff = ufshcd_wl_poweroff,
	.restore = ufshcd_wl_resume,


> +};
> +
> +/**
> + * ufs_dev_wlun_template - describes ufs device wlun
> + * ufs-device wlun - used to send pm commands
> + * All luns are consumers of ufs-device wlun.
> + *
> + * Currently, no sd driver is present for wluns.
> + * Hence the no specific pm operations are performed.
> + * With ufs design, SSU should be sent to ufs-device wlun.
> + * Hence register a scsi driver for ufs wluns only.
> + */
> +static struct scsi_driver ufs_dev_wlun_template = {
> +	.gendrv = {
> +		.name = "ufs_device_wlun",
> +		.owner = THIS_MODULE,
> +		.probe = ufshcd_wl_probe,
> +		.remove = ufshcd_wl_remove,
> +		.pm = &ufshcd_wl_pm_ops,
> +		.shutdown = ufshcd_wl_shutdown,
> +	},
> +};
> +
> +static int ufshcd_rpmb_probe(struct device *dev)
> +{
> +	return is_rpmb_wlun(to_scsi_device(dev)) ? 0 : -ENODEV;
> +}
> +
> +static inline int ufshcd_clear_rpmb_uac(struct ufs_hba *hba)
> +{
> +	int ret = 0;
> +
> +	if (!hba->wlun_rpmb_clr_ua)
> +		return 0;
> +	ret = ufshcd_clear_ua_wlun(hba, UFS_UPIU_RPMB_WLUN);
> +	if (!ret)
> +		hba->wlun_rpmb_clr_ua = 0;
> +	return ret;
> +}
> +
> +static int ufshcd_rpmb_runtime_resume(struct device *dev)
> +{
> +	struct ufs_hba *hba = wlun_dev_to_hba(dev);
> +
> +	if (hba->sdev_rpmb)
> +		return ufshcd_clear_rpmb_uac(hba);
> +	return 0;
> +}
> +
> +static int ufshcd_rpmb_resume(struct device *dev)
> +{
> +	struct ufs_hba *hba = wlun_dev_to_hba(dev);
> +
> +	if (hba->sdev_rpmb && !pm_runtime_suspended(dev))
> +		return ufshcd_clear_rpmb_uac(hba);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ufs_rpmb_pm_ops = {
> +	SET_RUNTIME_PM_OPS(NULL, ufshcd_rpmb_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, ufshcd_rpmb_resume)
> +};
> +
> +/**
> + * Describes the ufs rpmb wlun.
> + * Used only to send uac.
> + */
> +static struct scsi_driver ufs_rpmb_wlun_template = {
> +	.gendrv = {
> +		.name = "ufs_rpmb_wlun",
> +		.owner = THIS_MODULE,
> +		.probe = ufshcd_rpmb_probe,
> +		.pm = &ufs_rpmb_pm_ops,
> +	},
> +};
> +
>  /**
>   * ufshcd_add_lus - probe and add UFS logical units
>   * @hba: per-adapter instance
> @@ -7755,6 +7897,19 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  {
>  	int ret;
>  
> +	ret = scsi_register_driver(&ufs_dev_wlun_template.gendrv);
> +	if (ret) {
> +		dev_err(hba->dev, "Register device wlun driver failed: %d\n",
> +			ret);
> +		return ret;
> +	}

This is assuming there is only one UFS host controller, which is probably
true but not something that we should assume.  Moving this to
ufshcd_core_init() might also avoid some more of the forward declarations.

> +
> +	ret = scsi_register_driver(&ufs_rpmb_wlun_template.gendrv);
> +	if (ret) {
> +		dev_err(hba->dev, "Register device wlun driver failed: %d\n",
> +			ret);
> +		return ret;
> +	}
>  	/* Add required well known logical units to scsi mid layer */
>  	ret = ufshcd_scsi_add_wlus(hba);
>  	if (ret)
> @@ -7892,6 +8047,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool async)
>  	ufshcd_set_ufs_dev_active(hba);
>  	ufshcd_force_reset_auto_bkops(hba);
>  	hba->wlun_dev_clr_ua = true;
> +	hba->wlun_rpmb_clr_ua = true;
>  
>  	/* Gear up to HS gear if supported */
>  	if (hba->max_pwr_info.is_valid) {
> @@ -7964,6 +8120,7 @@ static void ufshcd_async_scan(void *data, async_cookie_t cookie)
>  		pm_runtime_put_sync(hba->dev);
>  		ufshcd_hba_exit(hba);
>  	}
> +	hba->init_done = true;
>  }
>  
>  static const struct attribute_group *ufshcd_driver_groups[] = {
> @@ -8475,7 +8632,8 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
>  	 * handling context.
>  	 */
>  	hba->host->eh_noresume = 1;
> -	ufshcd_clear_ua_wluns(hba);
> +	if (hba->wlun_dev_clr_ua)
> +		ufshcd_clear_ua_wlun(hba, UFS_UPIU_UFS_DEVICE_WLUN);
>  
>  	cmd[4] = pwr_mode << 4;
>  
> @@ -8650,31 +8808,19 @@ static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba)
>  		ufshcd_setup_hba_vreg(hba, true);
>  }
>  
> -/**
> - * ufshcd_suspend - helper function for suspend operations
> - * @hba: per adapter instance
> - * @pm_op: desired low power operation type
> - *
> - * This function will try to put the UFS device and link into low power
> - * mode based on the "rpm_lvl" (Runtime PM level) or "spm_lvl"
> - * (System PM level).
> - *
> - * If this function is called during shutdown, it will make sure that
> - * both UFS device and UFS link is powered off.
> - *
> - * NOTE: UFS device & link must be active before we enter in this function.
> - *
> - * Returns 0 for success and non-zero for failure
> - */
> -static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> +static int __ufshcd_wl_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  {
>  	int ret = 0;
> -	int check_for_bkops;
>  	enum ufs_pm_level pm_lvl;
>  	enum ufs_dev_pwr_mode req_dev_pwr_mode;
>  	enum uic_link_state req_link_state;
>  
> -	hba->pm_op_in_progress = 1;
> +	/*
> +	 * Is invoked when the device wlun is added to sysfs
> +	 * But by then hba->sdev_ufs_device may not be initialized.
> +	 */
> +	if (!hba->init_done)
> +		return 0;
>  	if (!ufshcd_is_shutdown_pm(pm_op)) {
>  		pm_lvl = ufshcd_is_runtime_pm(pm_op) ?
>  			 hba->rpm_lvl : hba->spm_lvl;
> @@ -8690,24 +8836,23 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  	 * just gate the clocks.
>  	 */
>  	ufshcd_hold(hba, false);
> -	hba->clk_gating.is_suspended = true;
>  
>  	if (ufshcd_is_clkscaling_supported(hba))
>  		ufshcd_clk_scaling_suspend(hba, true);
>  
>  	if (req_dev_pwr_mode == UFS_ACTIVE_PWR_MODE &&
>  			req_link_state == UIC_LINK_ACTIVE_STATE) {
> -		goto disable_clks;
> +		goto enable_scaling;
>  	}
>  
>  	if ((req_dev_pwr_mode == hba->curr_dev_pwr_mode) &&
>  	    (req_link_state == hba->uic_link_state))
> -		goto enable_gating;
> +		goto enable_scaling;
>  
>  	/* UFS device & link must be active before we enter in this function */
>  	if (!ufshcd_is_ufs_dev_active(hba) || !ufshcd_is_link_active(hba)) {
>  		ret = -EINVAL;
> -		goto enable_gating;
> +		goto enable_scaling;
>  	}
>  
>  	if (ufshcd_is_runtime_pm(pm_op)) {
> @@ -8719,7 +8864,7 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  			 */
>  			ret = ufshcd_urgent_bkops(hba);
>  			if (ret)
> -				goto enable_gating;
> +				goto enable_scaling;
>  		} else {
>  			/* make sure that auto bkops is disabled */
>  			ufshcd_disable_auto_bkops(hba);
> @@ -8746,10 +8891,206 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  
>  		if (!hba->dev_info.b_rpm_dev_flush_capable) {
>  			ret = ufshcd_set_dev_pwr_mode(hba, req_dev_pwr_mode);
> -			if (ret)
> -				goto enable_gating;
> +			if (!ret)
> +				goto out;
>  		}
>  	}
> +enable_scaling:
> +	if (ufshcd_is_clkscaling_supported(hba))
> +		ufshcd_clk_scaling_suspend(hba, false);
> +
> +	hba->dev_info.b_rpm_dev_flush_capable = false;
> +out:
> +	if (hba->dev_info.b_rpm_dev_flush_capable) {
> +		schedule_delayed_work(&hba->rpm_dev_flush_recheck_work,
> +			msecs_to_jiffies(RPM_DEV_FLUSH_RECHECK_WORK_DELAY_MS));
> +	}
> +	if (ret)
> +		ufshcd_update_evt_hist(hba, UFS_EVT_WL_SUSP_ERR, (u32)ret);
> +	ufshcd_release(hba);
> +	return ret;
> +}
> +
> +static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> +{
> +	int ret = 0;
> +
> +	if (!hba->init_done)
> +		return 0;
> +
> +	ufshcd_hold(hba, false);
> +	if (ufshcd_is_ufs_dev_deepsleep(hba)) {
> +		/* The device is in DeepSleep but hba was not suspended */
> +		ret = ufshcd_reset_and_restore(hba);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (!ufshcd_is_ufs_dev_active(hba)) {
> +		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> +		ufshcd_enable_auto_bkops(hba);
> +	else
> +		/*
> +		 * If BKOPs operations are urgently needed at this moment then
> +		 * keep auto-bkops enabled or else disable it.
> +		 */
> +		ufshcd_urgent_bkops(hba);
> +
> +	if (hba->clk_scaling.is_allowed)
> +		ufshcd_resume_clkscaling(hba);
> +
> +	if (hba->dev_info.b_rpm_dev_flush_capable) {
> +		hba->dev_info.b_rpm_dev_flush_capable = false;
> +		cancel_delayed_work(&hba->rpm_dev_flush_recheck_work);
> +	}
> +
> +out:
> +	if (ret)
> +		ufshcd_update_evt_hist(hba, UFS_EVT_WL_RES_ERR, (u32)ret);
> +	ufshcd_release(hba);
> +	return ret;
> +}
> +
> +static int ufshcd_wl_runtime_suspend(struct device *dev)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct ufs_hba *hba;
> +	int ret;
> +	ktime_t start = ktime_get();
> +
> +	hba = shost_priv(sdev->host);
> +
> +	ret = __ufshcd_wl_suspend(hba, UFS_RUNTIME_PM);
> +	if (ret)
> +		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__, ret);
> +
> +	trace_ufshcd_wl_runtime_suspend(dev_name(dev), ret,
> +		ktime_to_us(ktime_sub(ktime_get(), start)),
> +		hba->curr_dev_pwr_mode, hba->uic_link_state);
> +
> +	return ret;
> +}
> +
> +static int ufshcd_wl_runtime_resume(struct device *dev)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct ufs_hba *hba;
> +	int ret = 0;
> +	ktime_t start = ktime_get();
> +
> +	hba = shost_priv(sdev->host);
> +
> +	ret = __ufshcd_wl_resume(hba, UFS_RUNTIME_PM);
> +	if (ret)
> +		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__, ret);
> +
> +	trace_ufshcd_wl_runtime_resume(dev_name(dev), ret,
> +		ktime_to_us(ktime_sub(ktime_get(), start)),
> +		hba->curr_dev_pwr_mode, hba->uic_link_state);
> +
> +	return ret;
> +}
> +
> +static int ufshcd_wl_suspend(struct device *dev)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct ufs_hba *hba;
> +	int ret;
> +	ktime_t start = ktime_get();
> +
> +	hba = shost_priv(sdev->host);
> +	ret = __ufshcd_wl_suspend(hba, UFS_SYSTEM_PM);
> +	if (ret)
> +		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__,  ret);
> +
> +	trace_ufshcd_wl_suspend(dev_name(dev), ret,
> +		ktime_to_us(ktime_sub(ktime_get(), start)),
> +		hba->curr_dev_pwr_mode, hba->uic_link_state);
> +
> +	return ret;
> +}
> +
> +static int ufshcd_wl_resume(struct device *dev)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct ufs_hba *hba;
> +	int ret = 0;
> +	ktime_t start = ktime_get();
> +
> +	if (pm_runtime_suspended(dev))
> +		return 0;
> +	hba = shost_priv(sdev->host);
> +
> +	ret = __ufshcd_wl_resume(hba, UFS_SYSTEM_PM);
> +	if (ret)
> +		dev_err(&sdev->sdev_gendev, "%s failed: %d\n", __func__, ret);
> +
> +	trace_ufshcd_wl_resume(dev_name(dev), ret,
> +		ktime_to_us(ktime_sub(ktime_get(), start)),
> +		hba->curr_dev_pwr_mode, hba->uic_link_state);
> +
> +	return ret;
> +}
> +
> +static void ufshcd_wl_shutdown(struct device *dev)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +	struct ufs_hba *hba;
> +
> +	hba = shost_priv(sdev->host);
> +	scsi_device_quiesce(sdev);
> +	shost_for_each_device(sdev, hba->host) {
> +		if (sdev == hba->sdev_ufs_device)
> +			continue;
> +		scsi_device_quiesce(sdev);
> +	}
> +	__ufshcd_wl_suspend(hba, UFS_SHUTDOWN_PM);
> +}
> +
> +/**
> + * ufshcd_suspend - helper function for suspend operations
> + * @hba: per adapter instance
> + * @pm_op: desired low power operation type
> + *
> + * This function will try to put the UFS link into low power
> + * mode based on the "rpm_lvl" (Runtime PM level) or "spm_lvl"
> + * (System PM level).
> + *
> + * If this function is called during shutdown, it will make sure that
> + * link is powered off.
> + *
> + * Returns 0 for success and non-zero for failure
> + */
> +static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
> +{
> +	int ret = 0;
> +	int check_for_bkops;
> +	enum ufs_pm_level pm_lvl;
> +	enum ufs_dev_pwr_mode req_dev_pwr_mode;
> +	enum uic_link_state req_link_state;
> +
> +	hba->pm_op_in_progress = 1;
> +	if (!ufshcd_is_shutdown_pm(pm_op)) {
> +		pm_lvl = ufshcd_is_runtime_pm(pm_op) ?
> +			 hba->rpm_lvl : hba->spm_lvl;
> +		req_dev_pwr_mode = ufs_get_pm_lvl_to_dev_pwr_mode(pm_lvl);
> +		req_link_state = ufs_get_pm_lvl_to_link_pwr_state(pm_lvl);
> +	} else {
> +		req_dev_pwr_mode = UFS_POWERDOWN_PWR_MODE;
> +		req_link_state = UIC_LINK_OFF_STATE;
> +	}
> +
> +	/*
> +	 * If we can't transition into any of the low power modes
> +	 * just gate the clocks.
> +	 */
> +	ufshcd_hold(hba, false);
> +	hba->clk_gating.is_suspended = true;
>  
>  	/*
>  	 * In the case of DeepSleep, the device is expected to remain powered
> @@ -8758,9 +9099,8 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  	check_for_bkops = !ufshcd_is_ufs_dev_deepsleep(hba);
>  	ret = ufshcd_link_state_transition(hba, req_link_state, check_for_bkops);
>  	if (ret)
> -		goto set_dev_active;
> +		goto enable_gating;
>  
> -disable_clks:
>  	/*
>  	 * Call vendor specific suspend callback. As these callbacks may access
>  	 * vendor specific host controller register space call them before the
> @@ -8790,7 +9130,6 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  	goto out;
>  
>  set_link_active:
> -	ufshcd_vreg_set_hpm(hba);
>  	/*
>  	 * Device hardware reset is required to exit DeepSleep. Also, for
>  	 * DeepSleep, the link is off so host reset and restore will be done
> @@ -8804,28 +9143,15 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  		ufshcd_set_link_active(hba);
>  	else if (ufshcd_is_link_off(hba))
>  		ufshcd_host_reset_and_restore(hba);
> -set_dev_active:
>  	/* Can also get here needing to exit DeepSleep */
>  	if (ufshcd_is_ufs_dev_deepsleep(hba)) {
>  		ufshcd_device_reset(hba);
>  		ufshcd_host_reset_and_restore(hba);
>  	}
> -	if (!ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE))
> -		ufshcd_disable_auto_bkops(hba);
>  enable_gating:
> -	if (ufshcd_is_clkscaling_supported(hba))
> -		ufshcd_clk_scaling_suspend(hba, false);
> -
>  	hba->clk_gating.is_suspended = false;
> -	hba->dev_info.b_rpm_dev_flush_capable = false;
> -	ufshcd_clear_ua_wluns(hba);
>  	ufshcd_release(hba);
>  out:
> -	if (hba->dev_info.b_rpm_dev_flush_capable) {
> -		schedule_delayed_work(&hba->rpm_dev_flush_recheck_work,
> -			msecs_to_jiffies(RPM_DEV_FLUSH_RECHECK_WORK_DELAY_MS));
> -	}
> -
>  	hba->pm_op_in_progress = 0;
>  
>  	if (ret)
> @@ -8846,10 +9172,8 @@ static int ufshcd_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  {
>  	int ret;
> -	enum uic_link_state old_link_state;
>  
>  	hba->pm_op_in_progress = 1;
> -	old_link_state = hba->uic_link_state;
>  
>  	ufshcd_hba_vreg_set_hpm(hba);
>  	ret = ufshcd_vreg_set_hpm(hba);
> @@ -8901,43 +9225,14 @@ static int ufshcd_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  			goto vendor_suspend;
>  	}
>  
> -	if (!ufshcd_is_ufs_dev_active(hba)) {
> -		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
> -		if (ret)
> -			goto set_old_link_state;
> -	}
> -
> -	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
> -		ufshcd_enable_auto_bkops(hba);
> -	else
> -		/*
> -		 * If BKOPs operations are urgently needed at this moment then
> -		 * keep auto-bkops enabled or else disable it.
> -		 */
> -		ufshcd_urgent_bkops(hba);
> -
> -	hba->clk_gating.is_suspended = false;
> -
> -	if (ufshcd_is_clkscaling_supported(hba))
> -		ufshcd_clk_scaling_suspend(hba, false);
> -
>  	/* Enable Auto-Hibernate if configured */
>  	ufshcd_auto_hibern8_enable(hba);
>  
> -	if (hba->dev_info.b_rpm_dev_flush_capable) {
> -		hba->dev_info.b_rpm_dev_flush_capable = false;
> -		cancel_delayed_work(&hba->rpm_dev_flush_recheck_work);
> -	}
> -
> -	ufshcd_clear_ua_wluns(hba);
> -
>  	/* Schedule clock gating in case of no access to UFS device yet */
>  	ufshcd_release(hba);
>  
>  	goto out;
>  
> -set_old_link_state:
> -	ufshcd_link_state_transition(hba, old_link_state, 0);
>  vendor_suspend:
>  	ufshcd_vops_suspend(hba, pm_op);
>  disable_irq_and_vops_clks:
> @@ -9170,6 +9465,8 @@ EXPORT_SYMBOL(ufshcd_shutdown);
>  void ufshcd_remove(struct ufs_hba *hba)
>  {
>  	ufs_bsg_remove(hba);
> +	scsi_unregister_driver(&ufs_dev_wlun_template.gendrv);
> +	scsi_unregister_driver(&ufs_rpmb_wlun_template.gendrv);
>  	ufs_sysfs_remove_nodes(hba->dev);
>  	blk_cleanup_queue(hba->tmf_queue);
>  	blk_mq_free_tag_set(&hba->tmf_tag_set);
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index ee61f82..9087593 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -72,6 +72,8 @@ enum ufs_event_type {
>  	UFS_EVT_LINK_STARTUP_FAIL,
>  	UFS_EVT_RESUME_ERR,
>  	UFS_EVT_SUSPEND_ERR,
> +	UFS_EVT_WL_SUSP_ERR,
> +	UFS_EVT_WL_RES_ERR,
>  
>  	/* abnormal events */
>  	UFS_EVT_DEV_RESET,
> @@ -804,6 +806,7 @@ struct ufs_hba {
>  	struct list_head clk_list_head;
>  
>  	bool wlun_dev_clr_ua;
> +	bool wlun_rpmb_clr_ua;
>  
>  	/* Number of requests aborts */
>  	int req_abort_count;
> @@ -841,6 +844,8 @@ struct ufs_hba {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs_root;
>  #endif
> +	bool init_done;
> +	u32 luns_avail;
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index e151477..d9d233b 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -246,6 +246,26 @@ DEFINE_EVENT(ufshcd_template, ufshcd_init,
>  		      int dev_state, int link_state),
>  	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
>  
> +DEFINE_EVENT(ufshcd_template, ufshcd_wl_suspend,
> +	     TP_PROTO(const char *dev_name, int err, s64 usecs,
> +		      int dev_state, int link_state),
> +	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
> +
> +DEFINE_EVENT(ufshcd_template, ufshcd_wl_resume,
> +	     TP_PROTO(const char *dev_name, int err, s64 usecs,
> +		      int dev_state, int link_state),
> +	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
> +
> +DEFINE_EVENT(ufshcd_template, ufshcd_wl_runtime_suspend,
> +	     TP_PROTO(const char *dev_name, int err, s64 usecs,
> +		      int dev_state, int link_state),
> +	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
> +
> +DEFINE_EVENT(ufshcd_template, ufshcd_wl_runtime_resume,
> +	     TP_PROTO(const char *dev_name, int err, s64 usecs,
> +		      int dev_state, int link_state),
> +	     TP_ARGS(dev_name, err, usecs, dev_state, link_state));
> +
>  TRACE_EVENT(ufshcd_command,
>  	TP_PROTO(const char *dev_name, enum ufs_trace_str_t str_t,
>  		 unsigned int tag, u32 doorbell, int transfer_len, u32 intr,
> 

