Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7D2EAE2
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 04:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfE3C5T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 22:57:19 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55081 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfE3C5S (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 22:57:18 -0400
Received: by mail-wm1-f50.google.com with SMTP id i3so2900912wml.4
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 19:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AA5L7tfhLlsKfjGe42dTc5zf0iEd+7+TtHmShr+XIPs=;
        b=NEcEeTpzLTtVHgI3RCF6pmQ5Gnd3bR5Mmkq+gpf/3jViIj1SWCRCslERop8XNNpb8S
         lF6a3CGUd5Xh3LzLS/LsIuS/Rw3IQHsptp+4w7DHYi+91th5SwpU9lVKV96o+L7sXRXA
         1HyIrmMK0qhzO64LavYemUgTTv5aVjYG0OnYCN7fwP4Y9LHTxoXyajfLz+ji3zoxPOU8
         BzYL/cnMceW3x3hbxdhblMTIF1bXdOAGGe0zfYO4q4ESil2AL73P3i+9hmHCXYx0+LbV
         Q5dJ98n1NbN/EgynYDILKpZ/aJKLNPoMqqJfvqqpAqRUTA1Yejx9QgKYsXbRmsu3Jg1A
         0JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA5L7tfhLlsKfjGe42dTc5zf0iEd+7+TtHmShr+XIPs=;
        b=eICxSiB93npKKVOoMZzJ1ho2gAPRy7ZZp3mq2z5nYXaW/B5SPTmZcLKCWdazOOzqAJ
         Omrq1R1Jhlvv4PKWDEjLZLfQRHZOr7ZSMsjMApZD6x98pV10oKjO+M1D2tGbg/o83YDM
         UQcaHfZuq2FofteP6ll4eO0kG1cddcximbobZhhS2ZDu6Iaai7xfvLdHDNcyafU/MGY7
         4V9uvJcG2jcWfsHJ88Me4i4bVp+8z6n8tvxvO1OwAjGYclqIYOkYQWv026u29WQM8iqR
         UW451SfYYmXYF43Cd7MH2khWYCN2Iv7JEXr588q9lvJiBG6Fg0DQZr8NS8ImV9VaZsfa
         RmeA==
X-Gm-Message-State: APjAAAXnImvgRbhhXhV6Ku0Io4MpUSxIRGmrPBKBIs3T+qglTUy0A42P
        9Inw+CbtK/AsA0vHTDft/uz1llr7ekZ4i55BRvg=
X-Google-Smtp-Source: APXvYqxnyQWQO0sotY7Bc4dPYoWpKpisVJQ8Zv5SbkDX6V/jBzwLXo5XtFGPaWag/lAgQUlNNkhqv50bXjjiwVNeR3Q=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr641945wme.146.1559185036654;
 Wed, 29 May 2019 19:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <KU1P153MB016617EB56A9B6ED55B8CFD0BF010@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KU1P153MB016617EB56A9B6ED55B8CFD0BF010@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 30 May 2019 10:57:02 +0800
Message-ID: <CACVXFVOmgZthx433vSAtpJKkbpmU-9EGTuJEcmcmQt2PCwTLhg@mail.gmail.com>
Subject: Re: SCSI adapter: how to freeze and thaw I/O on hibernation?
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>, Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 23, 2019 at 11:18 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> Hi,
> I'm adding code to enable the hv_storvsc driver (drivers/scsi/storvsc_drv.c)
> for hibernation (ACPI S5). I know how to save/restore the state of the virtual
> Hyper-V SCSI adapter, but I don't know how to prevent the higher layer SCSI
> driver(s) from submitting new I/O requests to the low level driver hv_storvsc,
> before I disable the Hyper-V SCSI adapter in hv_storvsc.
>
> Note: I can not call scsi_remove_host(), because the SCSI host should not
> disappear and re-appear on hibernation.
>
> scsi_target_block() calls scsi_internal_device_block() ->
> blk_mq_quiesce_queue(), but it is only used in a few drivers
> (scsi_transport_fc.c, scsi_transport_iscsi.c and scsi_transport_srp.c), so
> I doubt it is suitable to me?
>
> scsi_block_requests() is used in a lot of drivers and hence is more likely
> to be the API I'm looking for, but it only sets a flag
> shost->host_self_blocked -- how can this prevent another CPU from
> submitting I/O requests?
>
> I also checked scsi_bus_pm_ops, but it's only for "sdev": see
> scsi_bus_suspend_common() -> "if (scsi_is_sdev_device(dev))...".
>
> Even for "sdev", it looks the scsi_dev_type_suspend() can't work for me,
> because it looks the sdev's driver is sd, whose sd_pm_ops doesn't
> define the .freeze and .thaw ops, which are needed in hibernation.
>
> sd_pm_ops does define .suspend and .resume, but it looks they are only
> for suspend-to-memory (ACPI S3).
>
> Can you please recommend the standard way to prevent the higher layer
> SCSI driver(s) from submitting new I/O requests?
>
> How do the other low level SCSI adapter drivers support hibernation?
>
> I checked some PCI HBA drivers, and they use scsi_block_requests(), but
> as I described above, I don't know how setting a flag can prevent another
> CPU from submitting I/O requests.
>
> Looking forward to your insights!

scsi_device_quiesce() has been called by scsi_dev_type_suspend() to prevent
any non-pm request from entering queue.

Or do you still see IO requests coming during hibernation?

Thanks,
Ming Lei
