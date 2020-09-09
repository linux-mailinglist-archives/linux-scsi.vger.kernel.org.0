Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32273262F54
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgIINtH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Sep 2020 09:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgIINX6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Sep 2020 09:23:58 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B71B2087C;
        Wed,  9 Sep 2020 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599657813;
        bh=9SV+/keZQaLlsbt6dY6GLxcu53/x0HY3jCvWzsM40EU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NnNoII6trox+kORTlYP8POR6Q5+c/+Nm5eQVS706pe6Ta0P53Jc40DO1fkCBVvIpe
         VgISw0Dkv3b7E95vQdGdQW1IbvU6zuTGNpQIjncw0D5+v32sc6R2x1cdunqq3Hs7e6
         OWmhLCkOtCLDYGDqNAuGsFr4WIeLcJOspvrBSvFY=
Date:   Wed, 9 Sep 2020 08:23:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v2 01/15] scsi: megaraid_sas: use generic power management
Message-ID: <20200909132332.GA696701@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909100315.GA13015@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Sep 09, 2020 at 03:33:15PM +0530, Vaibhav Gupta wrote:
> On Tue, Sep 08, 2020 at 12:32:09PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 20, 2020 at 07:04:14PM +0530, Vaibhav Gupta wrote:
> > > With legacy PM hooks, it was the responsibility of a driver to manage PCI
> > > states and also the device's power state. The generic approach is to let
> > > the PCI core handle the work.
> > > 
> > > PCI core passes "struct device*" as an argument to the .suspend() and
> > > .resume() callbacks. As the .suspend() work with "struct instance*",
> > > extract it from "struct device*" using dev_get_drv_data().
> > > 
> > > Driver was also using PCI helper functions like pci_save/restore_state(),
> > > pci_disable/enable_device(), pci_set_power_state() and pci_enable_wake().
> > > They should not be invoked by the driver.
> > > 
> > > Compile-tested only.
> > > 
> > > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > > ---
> > >  drivers/scsi/megaraid/megaraid_sas_base.c | 61 ++++++-----------------
> > >  1 file changed, 16 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> > > index 00668335c2af..4a6ee7778977 100644
> > > --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> > > +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> > > @@ -7539,25 +7539,21 @@ static void megasas_shutdown_controller(struct megasas_instance *instance,
> > >  	megasas_return_cmd(instance, cmd);
> > >  }
> > >  
> > > -#ifdef CONFIG_PM
> > >  /**
> > >   * megasas_suspend -	driver suspend entry point
> > > - * @pdev:		PCI device structure
> > > - * @state:		PCI power state to suspend routine
> > > + * @dev:		Device structure
> > >   */
> > > -static int
> > > -megasas_suspend(struct pci_dev *pdev, pm_message_t state)
> > > +static int __maybe_unused
> > > +megasas_suspend(struct device *dev)
> > >  {
> > > -	struct megasas_instance *instance;
> > > -
> > > -	instance = pci_get_drvdata(pdev);
> > > +	struct megasas_instance *instance = dev_get_drvdata(dev);
> > >  
> > >  	if (!instance)
> > >  		return 0;
> > >  
> > >  	instance->unload = 1;
> > >  
> > > -	dev_info(&pdev->dev, "%s is called\n", __func__);
> > > +	dev_info(dev, "%s is called\n", __func__);
> > >  
> > >  	/* Shutdown SR-IOV heartbeat timer */
> > >  	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
> > > @@ -7579,7 +7575,7 @@ megasas_suspend(struct pci_dev *pdev, pm_message_t state)
> > >  
> > >  	tasklet_kill(&instance->isr_tasklet);
> > >  
> > > -	pci_set_drvdata(instance->pdev, instance);
> > > +	dev_set_drvdata(dev, instance);
> > 
> > It *might* be correct to replace "instance->pdev" with "dev", but it's
> > not obvious and deserves some explanation.  It's true that you can
> > replace &pdev->dev with dev, but I don't know anything about
> > instance->dev.

Sorry, I meant "instance->pdev" here.

> > I don't think this change is actually necessary, is it?
> > "instance->pdev" is still a pci_dev pointer, so pci_set_drvdata()
> > should work fine. ...
> > 
> There is no instance->dev . The 'dev' passed dev_set_drvdata() is
> same &pdev->dev. 

Yes, it's true that "dev" here is the same as the "&pdev->dev" we had
previously.  But we passed "instance->pdev" (not "pdev") to
pci_set_drvdata().  So the question is whether instance->pdev->dev ==
dev.

They *might* be the same, but I don't think it's obvious.

> The dev pointer used here, points to same value.
> 
> pci_get_drvdata() and pci_set_drvdata() invoke dev_get_drvdata() and
> dev_set_drvdata() respectively. And they do nothing else. Seems like
> additional unnecessary function calls and operations.
