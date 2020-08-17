Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDC245EF5
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Aug 2020 10:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHQIMP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Aug 2020 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgHQIMO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Aug 2020 04:12:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C88C061388;
        Mon, 17 Aug 2020 01:12:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so7755098pgl.3;
        Mon, 17 Aug 2020 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Ghot5mUmzxhW3ypl42NBWLIYbTdm3HropjEkPH7sRo=;
        b=JKjiPQoA8xRWgSC4jFWJ/H+ejS9pqU3A5WcqYemhAfZhAWAJKDlAUHLesyWDdFj2GQ
         wBegAJ70p1u3qOmM3HV60revcvoeAIz57T5FpWzkNrUw0twmLYOtlGPGm1JqOife83zQ
         tTK5Yde7EA4tkpoXUIwJRSh4Cz3AtzIkZPucHyoAqkyTwdsqgtNAVKStIUFikLk1VPZU
         htsKXbMRjqDaqU45FNmA7XAeDCDuYonlPjAy5DHJSbMEw9KtYGUCAVtf3pq354B5ePt0
         f46cK1FCrsV3NwCQwLVEtLteV2saRhOJYp2pvh8BaiQu+aQ5TqCBq9UxRlpIE5k98xzz
         ucsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Ghot5mUmzxhW3ypl42NBWLIYbTdm3HropjEkPH7sRo=;
        b=unJ58r3IBdI09rqIkbbUmv6c6YMpedMuSTBYbh9Ben220t8ACXAv4lhaZpj/Bcd7d/
         h94j3BIsOxdqR7QpPvkskoR46KHooxXPRdWYdFsKLQRO4hjicPZB4E+xRD+K3Zv3p7zq
         +eln4etpfttgYJBxUY0IOgtVbUCuyoSATXvOuPFVWB95qtWEWVRGwKzk8NHemndKQDE2
         q5swZiYxDo+1VvzTxLeEFoWaLhY2w+i5l2bzW6/mqHLcMSyn6B/NazrovY3udnKv33mT
         dwTqAiMZa1mV0HCYoIroMJsQSRciPwJRFnyyFxa21ddgrSXUTQp7NPuLI/wcZmhgwLVv
         +i2g==
X-Gm-Message-State: AOAM5307XZmfuDf0CD9tIwsspmO4qQg6zFwnO6fb9JHfVMPV3DPU2Y8K
        h39EENG2XaqYaCVhyEx84uI=
X-Google-Smtp-Source: ABdhPJxtuLAvAlefhtLISvQFkrPKKRd160qLw2UoVo6UAkSiv8dcAKW3WNrZx1zMQPSgSgwD+ersPA==
X-Received: by 2002:a62:6d03:: with SMTP id i3mr10618083pfc.6.1597651933513;
        Mon, 17 Aug 2020 01:12:13 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id u62sm18541511pfb.4.2020.08.17.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:12:13 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:40:32 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] scsi: smartpqi: use generic power management
Message-ID: <20200817081032.GH5869@gmail.com>
References: <20200730070233.221488-1-vaibhavgupta40@gmail.com>
 <20200730110930.664486-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730110930.664486-1-vaibhavgupta40@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jul 30, 2020 at 04:39:30PM +0530, Vaibhav Gupta wrote:
> Drivers using legacy power management .suspen()/.resume() callbacks
> have to manage PCI states and device's PM states themselves. They also
> need to take care of standard configuration registers.
> 
> Switch to generic power management framework using a single
> "struct dev_pm_ops" variable to take the unnecessary load from the driver.
> This also avoids the need for the driver to directly call most of the PCI
> helper functions and device power state control functions, as through
> the generic framework PCI Core takes care of the necessary operations,
> and drivers are required to do only device-specific jobs.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/scsi/smartpqi/smartpqi_init.c | 44 +++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index cd157f11eb22..7061bd26897a 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -8059,11 +8059,11 @@ static void pqi_process_module_params(void)
>  	pqi_process_lockup_action_param();
>  }
>  
> -static __maybe_unused int pqi_suspend(struct pci_dev *pci_dev, pm_message_t state)
> +static int pqi_suspend_late(struct device *dev, pm_message_t state)
>  {
>  	struct pqi_ctrl_info *ctrl_info;
>  
> -	ctrl_info = pci_get_drvdata(pci_dev);
> +	ctrl_info = dev_get_drvdata(dev);
>  
>  	pqi_disable_events(ctrl_info);
>  	pqi_cancel_update_time_worker(ctrl_info);
> @@ -8081,20 +8081,33 @@ static __maybe_unused int pqi_suspend(struct pci_dev *pci_dev, pm_message_t stat
>  	if (state.event == PM_EVENT_FREEZE)
>  		return 0;
>  
> -	pci_save_state(pci_dev);
> -	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state));
> -
>  	ctrl_info->controller_online = false;
>  	ctrl_info->pqi_mode_enabled = false;
>  
>  	return 0;
>  }
>  
> -static __maybe_unused int pqi_resume(struct pci_dev *pci_dev)
> +static __maybe_unused int pqi_suspend(struct device *dev)
> +{
> +	return pqi_suspend_late(dev, PMSG_SUSPEND);
> +}
> +
> +static __maybe_unused int pqi_hibernate(struct device *dev)
> +{
> +	return pqi_suspend_late(dev, PMSG_HIBERNATE);
> +}
> +
> +static __maybe_unused int pqi_freeze(struct device *dev)
> +{
> +	return pqi_suspend_late(dev, PMSG_FREEZE);
> +}
> +
> +static __maybe_unused int pqi_resume(struct device *dev)
>  {
>  	int rc;
>  	struct pqi_ctrl_info *ctrl_info;
>  
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	ctrl_info = pci_get_drvdata(pci_dev);
>  
>  	if (pci_dev->current_state != PCI_D0) {
> @@ -8115,9 +8128,6 @@ static __maybe_unused int pqi_resume(struct pci_dev *pci_dev)
>  		return 0;
>  	}
>  
> -	pci_set_power_state(pci_dev, PCI_D0);
> -	pci_restore_state(pci_dev);
> -
>  	return pqi_ctrl_init_resume(ctrl_info);
>  }
>  
> @@ -8480,16 +8490,24 @@ static const struct pci_device_id pqi_pci_id_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, pqi_pci_id_table);
>  
> +static const struct dev_pm_ops pqi_pm_ops = {
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend = pqi_suspend,
> +	.resume = pqi_resume,
> +	.freeze = pqi_freeze,
> +	.thaw = pqi_resume,
> +	.poweroff = pqi_hibernate,
> +	.restore = pqi_resume,
> +#endif
> +};
> +
>  static struct pci_driver pqi_pci_driver = {
>  	.name = DRIVER_NAME_SHORT,
>  	.id_table = pqi_pci_id_table,
>  	.probe = pqi_pci_probe,
>  	.remove = pqi_pci_remove,
>  	.shutdown = pqi_shutdown,
> -#if defined(CONFIG_PM)
> -	.suspend = pqi_suspend,
> -	.resume = pqi_resume,
> -#endif
> +	.driver.pm = &pqi_pm_ops
>  };
>  
>  static int __init pqi_init(void)
> -- 
> 2.27.0
> 
