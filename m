Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635F2BB0AC
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 17:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgKTQfZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Nov 2020 11:35:25 -0500
Received: from netrider.rowland.org ([192.131.102.5]:44433 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728220AbgKTQfZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Nov 2020 11:35:25 -0500
Received: (qmail 620760 invoked by uid 1000); 20 Nov 2020 11:35:24 -0500
Date:   Fri, 20 Nov 2020 11:35:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Can Guo <cang@codeaurora.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH RFC v2 1/1] scsi: pm: Leave runtime PM status alone
 during system resume/thaw/restore
Message-ID: <20201120163524.GB619708@rowland.harvard.edu>
References: <1605861443-11459-1-git-send-email-cang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605861443-11459-1-git-send-email-cang@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Nov 20, 2020 at 12:37:22AM -0800, Can Guo wrote:
> Runtime resume is handled by runtime PM framework, no need to forcibly
> set runtime PM status to RPM_ACTIVE during system resume/thaw/restore.

Sorry, I don't understand this explanation at all.

Sure, runtime resume is handled by the runtime PM framework.  But this 
patch changes the code for system resume, which is completely different.

Following a system resume, the hardware will be at full power.  We don't 
want the kernel to think that the device is still in runtime suspend; 
otherwise is would never put the device back into low-power mode.

Alan Stern

> Cc: Stanley Chu <stanley.chu@mediatek.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
> 
> Changes since v1:
> - Incorporated Bart's comments
> 
> ---
>  drivers/scsi/scsi_pm.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
> index 3717eea..908f27f 100644
> --- a/drivers/scsi/scsi_pm.c
> +++ b/drivers/scsi/scsi_pm.c
> @@ -79,25 +79,6 @@ static int scsi_dev_type_resume(struct device *dev,
>  	scsi_device_resume(to_scsi_device(dev));
>  	dev_dbg(dev, "scsi resume: %d\n", err);
>  
> -	if (err == 0) {
> -		pm_runtime_disable(dev);
> -		err = pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);
> -
> -		/*
> -		 * Forcibly set runtime PM status of request queue to "active"
> -		 * to make sure we can again get requests from the queue
> -		 * (see also blk_pm_peek_request()).
> -		 *
> -		 * The resume hook will correct runtime PM status of the disk.
> -		 */
> -		if (!err && scsi_is_sdev_device(dev)) {
> -			struct scsi_device *sdev = to_scsi_device(dev);
> -
> -			blk_set_runtime_active(sdev->request_queue);
> -		}
> -	}
> -
>  	return err;
>  }
>  
> @@ -165,11 +146,8 @@ static int scsi_bus_resume_common(struct device *dev,
>  		 */
>  		if (strncmp(scsi_scan_type, "async", 5) != 0)
>  			async_synchronize_full_domain(&scsi_sd_pm_domain);
> -	} else {
> -		pm_runtime_disable(dev);
> -		pm_runtime_set_active(dev);
> -		pm_runtime_enable(dev);
>  	}
> +
>  	return 0;
>  }
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
