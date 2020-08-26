Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE12529C8
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Aug 2020 11:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgHZJNz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Aug 2020 05:13:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:47189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgHZJNx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Aug 2020 05:13:53 -0400
IronPort-SDR: k/5HGykLIF7IahC3PSJMNvWv6BLEi7LNF6+ldTtvKsT4MNct5IeWl8x0fchG0KedIazt/hI1WG
 uyPZ9GMdwB6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="153681728"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="153681728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 02:13:52 -0700
IronPort-SDR: xOK/xO1ZDxXjmVX7zGBxqT8wqCi4/Dt0ENeQazE6o9GPEemSv7obztP3UC7avomBMiLsjS3AzP
 e8dAVSdSJAzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="312828541"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2020 02:13:50 -0700
Subject: Re: [PATCH] scsi: ufs-pci: Add LTR support for Intel controllers
To:     Avri Altman <Avri.Altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <20200825081854.7222-1-adrian.hunter@intel.com>
 <BY5PR04MB67054EC026978782F129F88EFC540@BY5PR04MB6705.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <f831cd03-213f-0f0c-154e-04c591a4bf83@intel.com>
Date:   Wed, 26 Aug 2020 12:13:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB67054EC026978782F129F88EFC540@BY5PR04MB6705.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 26/08/20 9:13 am, Avri Altman wrote:
>  
>>
>> Intel host controllers support the setting of latency tolerance.
>> Accordingly, implement the PM QoS ->set_latency_tolerance() callback. The
>> raw register values are also exposed via debugfs.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks for the quick review!

I will send a V2, refer below

> 
> Some nits below.
> 
> Thanks,
> Avri
> 
>> ---
>>  drivers/scsi/ufs/ufshcd-pci.c | 122 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 120 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
>> index 5a95a7bfbab0..e10f05013ae6 100644
>> --- a/drivers/scsi/ufs/ufshcd-pci.c
>> +++ b/drivers/scsi/ufs/ufshcd-pci.c
>> @@ -13,6 +13,14 @@
>>  #include "ufshcd.h"
>>  #include <linux/pci.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/pm_qos.h>
>> +#include <linux/debugfs.h>
>> +
>> +struct intel_host {
>> +       u32             active_ltr;
>> +       u32             idle_ltr;
>> +       struct dentry   *debugfs_root;
>> +};
>>
>>  static int ufs_intel_disable_lcc(struct ufs_hba *hba)
>>  {
>> @@ -44,20 +52,129 @@ static int ufs_intel_link_startup_notify(struct ufs_hba
>> *hba,
>>         return err;
>>  }
>>
>> +#define INTEL_ACTIVELTR                0x804
>> +#define INTEL_IDLELTR          0x808
>> +
>> +#define INTEL_LTR_REQ          BIT(15)
>> +#define INTEL_LTR_SCALE_MASK   GENMASK(11, 10)
>> +#define INTEL_LTR_SCALE_1US    (2 << 10)
>> +#define INTEL_LTR_SCALE_32US   (3 << 10)
>> +#define INTEL_LTR_VALUE_MASK   GENMASK(9, 0)
>> +
>> +static void intel_cache_ltr(struct ufs_hba *hba)
>> +{
>> +       struct intel_host *host = ufshcd_get_variant(hba);
>> +
>> +       host->active_ltr = readl(hba->mmio_base + INTEL_ACTIVELTR);
>> +       host->idle_ltr = readl(hba->mmio_base + INTEL_IDLELTR);
> You might want to use the standard ufshcd_readl

LTR is more of a PCI concept, not directly related to UFS, so I am relucant
to use ufshcd_readl which implies a closer relationship to UFS.

> 
>> +}
>> +
>> +static void intel_ltr_set(struct device *dev, s32 val)
>> +{
>> +       struct ufs_hba *hba = dev_get_drvdata(dev);
>> +       struct intel_host *host = ufshcd_get_variant(hba);
>> +       u32 ltr;
>> +
>> +       pm_runtime_get_sync(dev);
>> +
>> +       /*
>> +        * Program latency tolerance (LTR) accordingly what has been asked
>> +        * by the PM QoS layer or disable it in case we were passed
>> +        * negative value or PM_QOS_LATENCY_ANY.
>> +        */
>> +       ltr = readl(hba->mmio_base + INTEL_ACTIVELTR);
>> +
>> +       if (val == PM_QOS_LATENCY_ANY || val < 0) {
>> +               ltr &= ~INTEL_LTR_REQ;
>> +       } else {
>> +               ltr |= INTEL_LTR_REQ;
>> +               ltr &= ~INTEL_LTR_SCALE_MASK;
>> +               ltr &= ~INTEL_LTR_VALUE_MASK;
>> +
>> +               if (val > INTEL_LTR_VALUE_MASK) {
>> +                       val >>= 5;
>> +                       if (val > INTEL_LTR_VALUE_MASK)
>> +                               val = INTEL_LTR_VALUE_MASK;
>> +                       ltr |= INTEL_LTR_SCALE_32US | val;
>> +               } else {
>> +                       ltr |= INTEL_LTR_SCALE_1US | val;
>> +               }
>> +       }
>> +
>> +       if (ltr == host->active_ltr)
>> +               goto out;
>> +
>> +       writel(ltr, hba->mmio_base + INTEL_ACTIVELTR);
>> +       writel(ltr, hba->mmio_base + INTEL_IDLELTR);
>> +
>> +       /* Cache the values into intel_host structure */
>> +       intel_cache_ltr(hba);
>> +out:
>> +       pm_runtime_put(dev);
>> +}
>> +
>> +static void ufs_intel_ltr_expose(struct ufs_hba *hba)
>> +{
>> +       struct intel_host *host = ufshcd_get_variant(hba);
>> +       struct dentry *dir = host->debugfs_root;
>> +       struct device *dev = hba->dev;
>> +
>> +       dev->power.set_latency_tolerance = intel_ltr_set;
>> +       dev_pm_qos_expose_latency_tolerance(dev);
>> +
>> +       intel_cache_ltr(hba);
>> +
>> +       debugfs_create_x32("active_ltr", 0444, dir, &host->active_ltr);
>> +       debugfs_create_x32("idle_ltr", 0444, dir, &host->idle_ltr);
> You might as well allow those values to be traced, e.g. use dev_pm_qos_update_user_latency_tolerance

The registers default to "no requirement" and there is no use-case for
reading the initial values, other than debugging for which there is debugfs.
 Add the fact that there are 2 registers, which should be the same, but what
if they are not, plus having to decode the register bits, doesn't seem worth it.

> 
>> +}
>> +
>> +static void ufs_intel_ltr_hide(struct ufs_hba *hba)
>> +{
>> +       struct device *dev = hba->dev;
>> +
>> +       dev_pm_qos_hide_latency_tolerance(dev);
>> +       dev->power.set_latency_tolerance = NULL;
>> +}
>> +
>> +static int ufs_intel_common_init(struct ufs_hba *hba)
>> +{
>> +       struct device *dev = hba->dev;
>> +       struct intel_host *host;
>> +
>> +       host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
>> +       if (!host)
>> +               return -ENOMEM;
>> +       ufshcd_set_variant(hba, host);
>> +       host->debugfs_root = debugfs_create_dir(dev_name(dev), NULL);
> Maybe pack the debugfs code together, i.e. move this just above debugfs_create_x32 ....

Yes, I can move all the debugfs code together.

> 
>> +       ufs_intel_ltr_expose(hba);
>> +       return 0;
>> +}
>> +
>> +static void ufs_intel_common_exit(struct ufs_hba *hba)
>> +{
>> +       struct intel_host *host = ufshcd_get_variant(hba);
>> +
>> +       debugfs_remove_recursive(host->debugfs_root);
>> +       ufs_intel_ltr_hide(hba);
>> +}
>> +
>>  static int ufs_intel_ehl_init(struct ufs_hba *hba)
>>  {
>>         hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
>> -       return 0;
>> +       return ufs_intel_common_init(hba);
>>  }
>>
>>  static struct ufs_hba_variant_ops ufs_intel_cnl_hba_vops = {
>>         .name                   = "intel-pci",
>> +       .init                   = ufs_intel_common_init,
>> +       .exit                   = ufs_intel_common_exit,
>>         .link_startup_notify    = ufs_intel_link_startup_notify,
>>  };
>>
>>  static struct ufs_hba_variant_ops ufs_intel_ehl_hba_vops = {
>>         .name                   = "intel-pci",
>>         .init                   = ufs_intel_ehl_init,
>> +       .exit                   = ufs_intel_common_exit,
>>         .link_startup_notify    = ufs_intel_link_startup_notify,
>>  };
>>
>> @@ -162,6 +279,8 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>>                 return err;
>>         }
>>
>> +       pci_set_drvdata(pdev, hba);
>> +
>>         hba->vops = (struct ufs_hba_variant_ops *)id->driver_data;
>>
>>         err = ufshcd_init(hba, mmio_base, pdev->irq);
>> @@ -171,7 +290,6 @@ ufshcd_pci_probe(struct pci_dev *pdev, const struct
>> pci_device_id *id)
>>                 return err;
>>         }
>>
>> -       pci_set_drvdata(pdev, hba);
>>         pm_runtime_put_noidle(&pdev->dev);
>>         pm_runtime_allow(&pdev->dev);
>>
>> --
>> 2.17.1
> 

