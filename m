Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0526165E
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgIHRJi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731353AbgIHRJW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 13:09:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD13EC061573;
        Tue,  8 Sep 2020 10:09:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so11480769pfp.11;
        Tue, 08 Sep 2020 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VVR+JzkOTyWwsNAoJBX58DCmkSh7PCwgOHMkPoIcLb4=;
        b=kmIG7UoG4eyCrmI34A0VLVY6+Xmc5KvRcgvFlbDNDyDkvI8iPh8gPtMd+j9xoavOjm
         CCI4rWA0zwwjz0QPNHBbQuVuQPJWQkj3JAhdGF33eFAaUQZUPgNIv8BjFLY28wRatggf
         gCXtrS2Qmgzn2CxTEj4oFRjA3qKXNn9W7gVTCH7w3jyD0/RzW9NwnrVRqESUn3mj3z8d
         SOljJEg7PLlkmXQl2SSxuE6AkaIzQdw3z48/4dwwPd/tsiS8odl8RED5ktwcfVp+H7oD
         mSn1ufc20l0EG4cu3ymhqQqMO/OkoPE7UGa2hnShcLqMcDHqlRv6TJTpOTRV+4h8WDXI
         XIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VVR+JzkOTyWwsNAoJBX58DCmkSh7PCwgOHMkPoIcLb4=;
        b=uIxouq6u/EFKx1HezjpWiaM8Me1VNiora2etsl5tbfyhClkKzMJImgKCbq+74TMrig
         8EfIjWgM+H4FLB80OAuVELlJhkFuXFT3DtCMM/ssfdB2M+ijZdS0X4E3KAqtTbQ1IjbE
         S8Gi4GWjS6CiAKUDbmDQjn9mFoSEGXnBxCfI96eRnYlt1J8Moowyx9h+1DZULYiSdz47
         d4uW6RTA+mF+iqpA8xFEWolQWa6T9mNoCf0KSK1Cs/NcZgc7kJCASGcGPsYVyrmT53tD
         sDD/go/K3HrwApu2+scHsTFbG4wKzQy55Gr5EObeK3Src1sPp4QXm+ekAiFasL+HJV1I
         xevw==
X-Gm-Message-State: AOAM533zmg2gSQfRyy00MZKH+Uc9pTTQr9ahAhBLQiR0ql+jONUrx5rJ
        KjQij40GSPyAbqb41FL651o=
X-Google-Smtp-Source: ABdhPJwBFZKiTPtRmcJ/LEq2URqgcqPKdOAofksD1/UvcLL+ZRRxxc1PV9Xo/bzmlrg/UD4km8tRAg==
X-Received: by 2002:a63:6dc2:: with SMTP id i185mr12418823pgc.297.1599584960999;
        Tue, 08 Sep 2020 10:09:20 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id s16sm12584037pgl.78.2020.09.08.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:09:20 -0700 (PDT)
Date:   Tue, 8 Sep 2020 22:37:21 +0530
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
Subject: Re: [PATCH v2 14/15] scsi: mvumi: use generic power management
Message-ID: <20200908170721.GO9948@gmail.com>
References: <20200720133427.454400-1-vaibhavgupta40@gmail.com>
 <20200720133427.454400-15-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720133427.454400-15-vaibhavgupta40@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 20, 2020 at 07:04:27PM +0530, Vaibhav Gupta wrote:
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
> 
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
> 
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(),
> pci_set_power_state() and pci_set_master() to do required operations. In
> generic mode, they are no longer needed.
> 
> Change function parameter in both .suspend() and .resume() to
> "struct device*" type. Use dev_get_drvdata() to get drv data.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/scsi/mvumi.c | 49 ++++++++++----------------------------------
>  1 file changed, 11 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
> index 8906aceda4c4..7a6ef8264e47 100644
> --- a/drivers/scsi/mvumi.c
> +++ b/drivers/scsi/mvumi.c
> @@ -2558,7 +2558,7 @@ static void mvumi_detach_one(struct pci_dev *pdev)
>  
>  /**
>   * mvumi_shutdown -	Shutdown entry point
> - * @device:		Generic device structure
> + * @pdev:		PCI device structure
>   */
>  static void mvumi_shutdown(struct pci_dev *pdev)
>  {
> @@ -2567,47 +2567,28 @@ static void mvumi_shutdown(struct pci_dev *pdev)
>  	mvumi_flush_cache(mhba);
>  }
>  
> -static int __maybe_unused mvumi_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int __maybe_unused mvumi_suspend(struct device *dev)
>  {
> -	struct mvumi_hba *mhba = NULL;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	mhba = pci_get_drvdata(pdev);
> +	struct mvumi_hba *mhba = pci_get_drvdata(pdev);
>  	mvumi_flush_cache(mhba);
>  
> -	pci_set_drvdata(pdev, mhba);
>  	mhba->instancet->disable_intr(mhba);
> -	free_irq(mhba->pdev->irq, mhba);
>  	mvumi_unmap_pci_addr(pdev, mhba->base_addr);
> -	pci_release_regions(pdev);
> -	pci_save_state(pdev);
> -	pci_disable_device(pdev);
> -	pci_set_power_state(pdev, pci_choose_state(pdev, state));
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
> +static int __maybe_unused mvumi_resume(struct device *dev)
>  {
>  	int ret;
> -	struct mvumi_hba *mhba = NULL;
> -
> -	mhba = pci_get_drvdata(pdev);
> -
> -	pci_set_power_state(pdev, PCI_D0);
> -	pci_enable_wake(pdev, PCI_D0, 0);
> -	pci_restore_state(pdev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct mvumi_hba *mhba = pci_get_drvdata(pdev);
>  
> -	ret = pci_enable_device(pdev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "enable device failed\n");
> -		return ret;
> -	}
> +	device_wakeup_disable(dev);
>  
> -	ret = mvumi_pci_set_master(pdev);
>  	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		goto fail;
> -	ret = pci_request_regions(mhba->pdev, MV_DRIVER_NAME);
>  	if (ret)
>  		goto fail;
>  	ret = mvumi_map_pci_addr(mhba->pdev, mhba->base_addr);
> @@ -2627,12 +2608,6 @@ static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
>  		goto unmap_pci_addr;
>  	}
>  
> -	ret = request_irq(mhba->pdev->irq, mvumi_isr_handler, IRQF_SHARED,
> -				"mvumi", mhba);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register IRQ\n");
> -		goto unmap_pci_addr;
> -	}
>  	mhba->instancet->enable_intr(mhba);
>  
>  	return 0;
> @@ -2642,11 +2617,12 @@ static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
>  release_regions:
>  	pci_release_regions(pdev);
>  fail:
> -	pci_disable_device(pdev);
>  
>  	return ret;
>  }
>  
> +static SIMPLE_DEV_PM_OPS(mvumi_pm_ops, mvumi_suspend, mvumi_resume);
> +
>  static struct pci_driver mvumi_pci_driver = {
>  
>  	.name = MV_DRIVER_NAME,
> @@ -2654,10 +2630,7 @@ static struct pci_driver mvumi_pci_driver = {
>  	.probe = mvumi_probe_one,
>  	.remove = mvumi_detach_one,
>  	.shutdown = mvumi_shutdown,
> -#ifdef CONFIG_PM
> -	.suspend = mvumi_suspend,
> -	.resume = mvumi_resume,
> -#endif
> +	.driver.pm = &mvumi_pm_ops,
>  };
>  
>  module_pci_driver(mvumi_pci_driver);
> -- 
> 2.27.0
> 
.
