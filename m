Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5283261612
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgIHRCD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 13:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbgIHRBx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 13:01:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E1C061573;
        Tue,  8 Sep 2020 10:01:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so4410381pfn.9;
        Tue, 08 Sep 2020 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vzAjbkXx9hrfKPFCUT3q6o3FbYgiDnBxRlYM5oOC7UM=;
        b=lPE/zjb/wZpMT9ZM/91DXgkkwUjSR1p5O/C6Wh3hWxgKaxXMtyHHlmQu+sEPmSYu+K
         4lS6PAOSy8MQP5BCThO9ts92ESFHzgOFfCbKttsKHsrQaJglGBOdp+28eFRi9pdLDP6+
         GrEJitfWcDgwQ5d5GvDDPQz9Np712hXZvCWO6PpgqEYtQFGcmIlJbWuyB9TUp57c6ngN
         3kqzIeJgQevapLW2+gWFUh9z8e1Q/WvTlG14MN2bTEOsvsrWuWcrmzdImWP1kDiS7K5W
         PGRUkP/2jdkuewe153SElWVkqkB1RXMwcnaP1YGHd4KJNMwYOsEwDuSBDfn3/SMQYEzX
         yp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzAjbkXx9hrfKPFCUT3q6o3FbYgiDnBxRlYM5oOC7UM=;
        b=R5SexEUaxd/SIhGgnh8LiRCAQNPbQe9DN6SbWOy6xpCVkfYNQpl6uf4l3+f9CfkIIw
         q5qnUOw3IIReFecWGr0k/7Myvao4x1NTvRKVUmwykpEGF4L2q3MNzaBmGUzTnkvdEWZX
         LrbLz+mGNBlPOqzLM7jpcxWkkUIxk7rK0P2kUdpPdlEbfaVAOSCGTVM81RpkggzXey/c
         KVuXINa1Qe1VLnVEIB68naZxYV9mvoTXKPu4oTUFt5wW7ZGDryQT2lpWjgX84NUg3Otu
         OlSYsJ1Qc7GHY4kt5IDblVGdxHoSUOW40wzsTtu7KF/IzHKoC3Z3BT4HuolBotNq+PRr
         P6KQ==
X-Gm-Message-State: AOAM533JvbTHFswwtUxyU/2oKLtXdxnFogy+Cy1UoPYSPp8BipsLVZbf
        WAE34dAtWhVLijQu/GuMlXg=
X-Google-Smtp-Source: ABdhPJyFGTMRyuLCFx1jU570pVgnMhQDPgZIIhFIS8orI9niXe0EGK1uaRhOnqmQXLdaqfgr5ODw9w==
X-Received: by 2002:a17:902:fe15:: with SMTP id g21mr24955756plj.22.1599584512862;
        Tue, 08 Sep 2020 10:01:52 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id n2sm18860051pfa.182.2020.09.08.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:01:52 -0700 (PDT)
Date:   Tue, 8 Sep 2020 22:29:58 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Hannes Reinecke <hare@suse.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v2 04/15] scsi: aic79xx: use generic power management
Message-ID: <20200908165958.GE9948@gmail.com>
References: <20200720133427.454400-1-vaibhavgupta40@gmail.com>
 <20200720133427.454400-5-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720133427.454400-5-vaibhavgupta40@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 20, 2020 at 07:04:17PM +0530, Vaibhav Gupta wrote:
> With legacy PM hooks, it was the responsibility of a driver to manage PCI
> states and also the device's power state. The generic approach is to let
> the PCI core handle the work.
> 
> PCI core passes "struct device*" as an argument to the .suspend() and
> .resume() callbacks.
> 
> Driver was using PCI helper functions like pci_save/restore_state(),
> pci_disable/enable_device(), pci_set_power_state() and pci_enable_wake().
> They should not be invoked by the driver.
> 
> Also, .suspend() and .resume() were invoking other functions for PM, which
> were againg bounded by "#ifdef CONFIG_PM" directive. Remove them and mark
> them as "__maybe_unused".
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/scsi/aic7xxx/aic79xx.h         | 12 +++----
>  drivers/scsi/aic7xxx/aic79xx_core.c    |  8 ++---
>  drivers/scsi/aic7xxx/aic79xx_osm_pci.c | 43 +++++++-------------------
>  drivers/scsi/aic7xxx/aic79xx_pci.c     |  6 ++--
>  4 files changed, 20 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic79xx.h b/drivers/scsi/aic7xxx/aic79xx.h
> index 9a515551641c..dd5dfd4f30a5 100644
> --- a/drivers/scsi/aic7xxx/aic79xx.h
> +++ b/drivers/scsi/aic7xxx/aic79xx.h
> @@ -1330,10 +1330,8 @@ const struct	ahd_pci_identity *ahd_find_pci_device(ahd_dev_softc_t);
>  int			  ahd_pci_config(struct ahd_softc *,
>  					 const struct ahd_pci_identity *);
>  int	ahd_pci_test_register_access(struct ahd_softc *);
> -#ifdef CONFIG_PM
> -void	ahd_pci_suspend(struct ahd_softc *);
> -void	ahd_pci_resume(struct ahd_softc *);
> -#endif
> +void __maybe_unused	ahd_pci_suspend(struct ahd_softc *);
> +void __maybe_unused	ahd_pci_resume(struct ahd_softc *);
>  
>  /************************** SCB and SCB queue management **********************/
>  void		ahd_qinfifo_requeue_tail(struct ahd_softc *ahd,
> @@ -1344,10 +1342,8 @@ struct ahd_softc	*ahd_alloc(void *platform_arg, char *name);
>  int			 ahd_softc_init(struct ahd_softc *);
>  void			 ahd_controller_info(struct ahd_softc *ahd, char *buf);
>  int			 ahd_init(struct ahd_softc *ahd);
> -#ifdef CONFIG_PM
> -int			 ahd_suspend(struct ahd_softc *ahd);
> -void			 ahd_resume(struct ahd_softc *ahd);
> -#endif
> +int __maybe_unused	 ahd_suspend(struct ahd_softc *ahd);
> +void __maybe_unused	 ahd_resume(struct ahd_softc *ahd);
>  int			 ahd_default_config(struct ahd_softc *ahd);
>  int			 ahd_parse_vpddata(struct ahd_softc *ahd,
>  					   struct vpd_config *vpd);
> diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
> index e4a09b93d00c..06ee7abd0f8f 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_core.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_core.c
> @@ -7880,11 +7880,9 @@ ahd_pause_and_flushwork(struct ahd_softc *ahd)
>  	ahd->flags &= ~AHD_ALL_INTERRUPTS;
>  }
>  
> -#ifdef CONFIG_PM
> -int
> +int __maybe_unused
>  ahd_suspend(struct ahd_softc *ahd)
>  {
> -
>  	ahd_pause_and_flushwork(ahd);
>  
>  	if (LIST_FIRST(&ahd->pending_scbs) != NULL) {
> @@ -7895,15 +7893,13 @@ ahd_suspend(struct ahd_softc *ahd)
>  	return (0);
>  }
>  
> -void
> +void __maybe_unused
>  ahd_resume(struct ahd_softc *ahd)
>  {
> -
>  	ahd_reset(ahd, /*reinit*/TRUE);
>  	ahd_intr_enable(ahd, TRUE); 
>  	ahd_restart(ahd);
>  }
> -#endif
>  
>  /************************** Busy Target Table *********************************/
>  /*
> diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> index 8b891a05d9e7..07b670b80f1b 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> @@ -74,11 +74,10 @@ static const struct pci_device_id ahd_linux_pci_id_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, ahd_linux_pci_id_table);
>  
> -#ifdef CONFIG_PM
> -static int
> -ahd_linux_pci_dev_suspend(struct pci_dev *pdev, pm_message_t mesg)
> +static int __maybe_unused
> +ahd_linux_pci_dev_suspend(struct device *dev)
>  {
> -	struct ahd_softc *ahd = pci_get_drvdata(pdev);
> +	struct ahd_softc *ahd = dev_get_drvdata(dev);
>  	int rc;
>  
>  	if ((rc = ahd_suspend(ahd)))
> @@ -86,39 +85,20 @@ ahd_linux_pci_dev_suspend(struct pci_dev *pdev, pm_message_t mesg)
>  
>  	ahd_pci_suspend(ahd);
>  
> -	pci_save_state(pdev);
> -	pci_disable_device(pdev);
> -
> -	if (mesg.event & PM_EVENT_SLEEP)
> -		pci_set_power_state(pdev, PCI_D3hot);
> -
>  	return rc;
>  }
>  
> -static int
> -ahd_linux_pci_dev_resume(struct pci_dev *pdev)
> +static int __maybe_unused
> +ahd_linux_pci_dev_resume(struct device *dev)
>  {
> -	struct ahd_softc *ahd = pci_get_drvdata(pdev);
> -	int rc;
> -
> -	pci_set_power_state(pdev, PCI_D0);
> -	pci_restore_state(pdev);
> -
> -	if ((rc = pci_enable_device(pdev))) {
> -		dev_printk(KERN_ERR, &pdev->dev,
> -			   "failed to enable device after resume (%d)\n", rc);
> -		return rc;
> -	}
> -
> -	pci_set_master(pdev);
> +	struct ahd_softc *ahd = dev_get_drvdata(dev);
>  
>  	ahd_pci_resume(ahd);
>  
>  	ahd_resume(ahd);
>  
> -	return rc;
> +	return 0;
>  }
> -#endif
>  
>  static void
>  ahd_linux_pci_dev_remove(struct pci_dev *pdev)
> @@ -224,13 +204,14 @@ ahd_linux_pci_dev_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	return (0);
>  }
>  
> +static SIMPLE_DEV_PM_OPS(ahd_linux_pci_dev_pm_ops,
> +			 ahd_linux_pci_dev_suspend,
> +			 ahd_linux_pci_dev_resume);
> +
>  static struct pci_driver aic79xx_pci_driver = {
>  	.name		= "aic79xx",
>  	.probe		= ahd_linux_pci_dev_probe,
> -#ifdef CONFIG_PM
> -	.suspend	= ahd_linux_pci_dev_suspend,
> -	.resume		= ahd_linux_pci_dev_resume,
> -#endif
> +	.driver.pm	= &ahd_linux_pci_dev_pm_ops,
>  	.remove		= ahd_linux_pci_dev_remove,
>  	.id_table	= ahd_linux_pci_id_table
>  };
> diff --git a/drivers/scsi/aic7xxx/aic79xx_pci.c b/drivers/scsi/aic7xxx/aic79xx_pci.c
> index 8397ae93f7dd..2f0bdb9225a4 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_pci.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_pci.c
> @@ -377,8 +377,7 @@ ahd_pci_config(struct ahd_softc *ahd, const struct ahd_pci_identity *entry)
>  	return ahd_pci_map_int(ahd);
>  }
>  
> -#ifdef CONFIG_PM
> -void
> +void __maybe_unused
>  ahd_pci_suspend(struct ahd_softc *ahd)
>  {
>  	/*
> @@ -394,7 +393,7 @@ ahd_pci_suspend(struct ahd_softc *ahd)
>  
>  }
>  
> -void
> +void __maybe_unused
>  ahd_pci_resume(struct ahd_softc *ahd)
>  {
>  	ahd_pci_write_config(ahd->dev_softc, DEVCONFIG,
> @@ -404,7 +403,6 @@ ahd_pci_resume(struct ahd_softc *ahd)
>  	ahd_pci_write_config(ahd->dev_softc, CSIZE_LATTIME,
>  			     ahd->suspend_state.pci_state.csize_lattime, /*bytes*/1);
>  }
> -#endif
>  
>  /*
>   * Perform some simple tests that should catch situations where
> -- 
> 2.27.0
> 
.
