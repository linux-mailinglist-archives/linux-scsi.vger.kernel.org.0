Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFE2615D5
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgIHQ5J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbgIHQ5B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 12:57:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0501C061573;
        Tue,  8 Sep 2020 09:57:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so11464622pfi.4;
        Tue, 08 Sep 2020 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBD1EJXPjVAPBpvdc8wf1ILIVz5P8vX0mxtXEPwALzw=;
        b=Ele0Rrax+SxCArR7vCT+Ep4XzRpupXA++JWD3kHsYCsN5NDhZAVsIEGGQQ88ehNC5R
         46X0/j2chtpx+hmu9XItNJmS3if7iMfnXSYDV1uEJMrQHQDW22kF9ka/I3di4/dJSFYF
         4mtMnPvRlqjWvbhmtg21sQpyMB8u4w4i21teNB+X3EFAJhMHaLCu5aKE2z+IrKZzcuRB
         8LmD1TVvq7PW+2h4Y8+DchxExEX+odbLBhJV+TqhWyBPLlyj/IFZkOOwXg5f6T1hM9cn
         I1yEt6NQJu3QdvQoIL6YzFaipMpF4S26ypm5drRygYvWFfuiOGAdfr8wrkQXzy2hLNNH
         xKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBD1EJXPjVAPBpvdc8wf1ILIVz5P8vX0mxtXEPwALzw=;
        b=ixkI/jGdZJVTUcZNk2LluRjrMzZAUr8tN10xq39LAgE2+PMkJBWfYgTUYSDHf4x5M7
         qfJv8mz5yVUeLJgxRnAdYy2Rg5dHyOA6NIiiKxVOS0zP1/hpUPTgBDJokrQMU+yIM/J0
         8TKnxXMRpuirmFfytgFIn/kn5pghLEr3LAxmM28QTG7ZwhhRc41sL1df8b/ydAvZzPpZ
         pEKE42QFA3McF7EjW1vTOMFc0QGOJqsf4dFUTH1JHo7FRbsLj7Aqw/B17vDtauae895c
         n4Ja4C8FCnWvgY5d4zI8bW7HBVR1XnZJZbC1SU8fVdZLjcGcrCqeX07gXU0tiFmMmc7H
         EL7g==
X-Gm-Message-State: AOAM532m5CC7SJB4bfTPY0ocr/WWt6HyYdUv/P9JRusBiWdw5Pxo/sFT
        +2VdxOsiBWDvBCJs/y7X5z4=
X-Google-Smtp-Source: ABdhPJwZxemNY6Dve6ZxiSwz4vCGjA5iIlNIPUHL3l9AnM4JkFzTMbYq7IAQKVpAR9CjNuYYwMBgSQ==
X-Received: by 2002:a05:6a00:8c5:b029:13e:ce2c:88bd with SMTP id s5-20020a056a0008c5b029013ece2c88bdmr96593pfu.0.1599584221085;
        Tue, 08 Sep 2020 09:57:01 -0700 (PDT)
Received: from gmail.com ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id h15sm4467pfo.23.2020.09.08.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:57:00 -0700 (PDT)
Date:   Tue, 8 Sep 2020 22:24:58 +0530
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
Subject: Re: [PATCH v2 00/15] scsi: use generic power management
Message-ID: <20200908165458.GA9948@gmail.com>
References: <20200720133427.454400-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720133427.454400-1-vaibhavgupta40@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 20, 2020 at 07:04:13PM +0530, Vaibhav Gupta wrote:
> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to upgrade power management in scsi
> drivers. This has been done by upgrading .suspend() and .resume() callbacks.
> 
> The upgrade makes sure that the involvement of PCI Core does not change the
> order of operations executed in a driver. Thus, does not change its behavior.
> 
> In general, drivers with legacy PM, .suspend() and .resume() make use of PCI
> helper functions like pci_request/release_regions(), pci_set_power_state(),
> pci_save/restore_state(), pci_enable/disable_device(), etc. to complete
> their job.
> 
> The conversion requires the removal of those function calls, change the
> callbacks' definition accordingly and make use of dev_pm_ops structure.
> 
> v2: kbuild error in v1.
> 
> All patches are compile-tested only.
> 
> Test tools:
>     - Compiler: gcc (GCC) 10.1.0
>     - allmodconfig build: make -j$(nproc) W=1 all
> 
> Vaibhav Gupta (15):
>   scsi: megaraid_sas: use generic power management
>   scsi: aacraid: use generic power management
>   scsi: aic7xxx: use generic power management
>   scsi: aic79xx: use generic power management
>   scsi: arcmsr: use generic power management
>   scsi: esas2r: use generic power management
>   scsi: hisi_sas_v3_hw: use generic power management
>   scsi: mpt3sas_scsih: use generic power management
>   scsi: lpfc: use generic power management
>   scsi: pm_8001: use generic power management
>   scsi: hpsa: use generic power management
>   scsi: 3w-9xxx: use generic power management
>   scsi: 3w-sas: use generic power management
>   scsi: mvumi: use generic power management
>   scsi: pmcraid: use generic power management
> 
>  drivers/scsi/3w-9xxx.c                    |  30 ++-----
>  drivers/scsi/3w-sas.c                     |  31 ++-----
>  drivers/scsi/aacraid/linit.c              |  34 ++------
>  drivers/scsi/aic7xxx/aic79xx.h            |  12 +--
>  drivers/scsi/aic7xxx/aic79xx_core.c       |   8 +-
>  drivers/scsi/aic7xxx/aic79xx_osm_pci.c    |  43 +++-------
>  drivers/scsi/aic7xxx/aic79xx_pci.c        |   6 +-
>  drivers/scsi/aic7xxx/aic7xxx.h            |  10 +--
>  drivers/scsi/aic7xxx/aic7xxx_core.c       |   6 +-
>  drivers/scsi/aic7xxx/aic7xxx_osm_pci.c    |  46 +++-------
>  drivers/scsi/aic7xxx/aic7xxx_pci.c        |   4 +-
>  drivers/scsi/arcmsr/arcmsr_hba.c          |  35 +++-----
>  drivers/scsi/esas2r/esas2r.h              |   5 +-
>  drivers/scsi/esas2r/esas2r_init.c         |  48 +++--------
>  drivers/scsi/esas2r/esas2r_main.c         |   3 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |  32 +++----
>  drivers/scsi/hpsa.c                       |  12 +--
>  drivers/scsi/lpfc/lpfc_init.c             | 100 +++++++---------------
>  drivers/scsi/megaraid/megaraid_sas_base.c |  61 ++++---------
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  36 +++-----
>  drivers/scsi/mvumi.c                      |  49 +++--------
>  drivers/scsi/pm8001/pm8001_init.c         |  46 ++++------
>  drivers/scsi/pmcraid.c                    |  44 +++-------
>  23 files changed, 212 insertions(+), 489 deletions(-)
> 
> -- 
> 2.27.0
> 
Please review the patch-series.

Thanks
Vaibhav Gupta
