Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B97614B2
	for <lists+linux-scsi@lfdr.de>; Sun,  7 Jul 2019 13:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfGGLAH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 7 Jul 2019 07:00:07 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:50080
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGGLAH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 7 Jul 2019 07:00:07 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <lnx-linux-scsi@m.gmane.org>)
        id 1hk4tm-0001vK-IB
        for linux-scsi@vger.kernel.org; Sun, 07 Jul 2019 13:00:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-scsi@vger.kernel.org
From:   "Andrey Jr. Melnikov" <temnota.am@gmail.com>
Subject: Re: [PATCH 1/1] scsi: aacraid: resurrect correct arc ctrl checks for Series-6
Date:   Sun, 7 Jul 2019 13:09:39 +0300
Message-ID: <10t8vf-fq.ln1@banana.localnet>
References: <20190627161408.10295-1-khorenko@virtuozzo.com> <20190627161408.10295-2-khorenko@virtuozzo.com>
User-Agent: tin/2.2.1-20140504 ("Tober an Righ") (UNIX) (Linux/4.3.3-bananian (armv7l))
Cc:     linux-kernel@vger.kernel.org
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In gmane.linux.scsi Konstantin Khorenko <khorenko@virtuozzo.com> wrote:
> This partially reverts ms commit
> 395e5df79a95 ("scsi: aacraid: Remove reference to Series-9")

> The patch above not only drops Series-9 cards checks but also
> changes logic for Series-6 controllers which leads to controller
> hangs/resets under high io load.

> So revert to original arc ctrl checks for Series-6 controllers.

> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1777586
> https://bugzilla.redhat.com/show_bug.cgi?id=1724077
> https://jira.sw.ru/browse/PSBM-95736

> Fixes: 395e5df79a95 ("scsi: aacraid: Remove reference to Series-9")
> Cc: stable@vger.kernel.org

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  drivers/scsi/aacraid/aacraid.h  | 11 -----------
>  drivers/scsi/aacraid/comminit.c | 14 ++++++++++----
>  drivers/scsi/aacraid/commsup.c  |  4 +++-
>  drivers/scsi/aacraid/linit.c    |  7 +++++--
>  4 files changed, 18 insertions(+), 18 deletions(-)

> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index 3fa03230f6ba..b674fb645523 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -2729,17 +2729,6 @@ int _aac_rx_init(struct aac_dev *dev);
>  int aac_rx_select_comm(struct aac_dev *dev, int comm);
>  int aac_rx_deliver_producer(struct fib * fib);
>  
> -static inline int aac_is_src(struct aac_dev *dev)
> -{
> -       u16 device = dev->pdev->device;
> -
> -       if (device == PMC_DEVICE_S6 ||
> -               device == PMC_DEVICE_S7 ||
> -               device == PMC_DEVICE_S8)
> -               return 1;
> -       return 0;
> -}
> -

Why remove helper?

>  static inline int aac_supports_2T(struct aac_dev *dev)
>  {
>         return (dev->adapter_info.options & AAC_OPT_NEW_COMM_64);
> diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
> index d4fcfa1e54e0..b8046b6c1239 100644
> --- a/drivers/scsi/aacraid/comminit.c
> +++ b/drivers/scsi/aacraid/comminit.c
> @@ -41,7 +41,9 @@ static inline int aac_is_msix_mode(struct aac_dev *dev)
>  {
>         u32 status = 0;
>  
> -       if (aac_is_src(dev))
> +       if (dev->pdev->device == PMC_DEVICE_S6 ||
> +           dev->pdev->device == PMC_DEVICE_S7 ||
> +           dev->pdev->device == PMC_DEVICE_S8)
>                 status = src_readl(dev, MUnit.OMR);
>         return (status & AAC_INT_MODE_MSIX);
>  }
> @@ -349,7 +351,8 @@ int aac_send_shutdown(struct aac_dev * dev)
>         /* FIB should be freed only after getting the response from the F/W */
>         if (status != -ERESTARTSYS)
>                 aac_fib_free(fibctx);
Fix this
> -       if (aac_is_src(dev) &&
> +       if ((dev->pdev->device == PMC_DEVICE_S7 ||
> +            dev->pdev->device == PMC_DEVICE_S8) &&
>              dev->msi_enabled)
>                 aac_set_intx_mode(dev);
>         return status;
> @@ -605,7 +608,8 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
>                 dev->max_fib_size = status[1] & 0xFFE0;
>                 host->sg_tablesize = status[2] >> 16;
>                 dev->sg_tablesize = status[2] & 0xFFFF;
this one
> -               if (aac_is_src(dev)) {
> +               if (dev->pdev->device == PMC_DEVICE_S7 ||
> +                   dev->pdev->device == PMC_DEVICE_S8) {
>                         if (host->can_queue > (status[3] >> 16) -
>                                         AAC_NUM_MGT_FIB)
>                                 host->can_queue = (status[3] >> 16) -
> @@ -624,7 +628,9 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
>                         pr_warn("numacb=%d ignored\n", numacb);
>         }
>  
> -       if (aac_is_src(dev))
> +       if (dev->pdev->device == PMC_DEVICE_S6 ||
> +           dev->pdev->device == PMC_DEVICE_S7 ||
> +           dev->pdev->device == PMC_DEVICE_S8)
>                 aac_define_int_mode(dev);
>         /*
>          *      Ok now init the communication subsystem
> diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
> index 2142a649e865..705e003caa95 100644
> --- a/drivers/scsi/aacraid/commsup.c
> +++ b/drivers/scsi/aacraid/commsup.c
> @@ -2574,7 +2574,9 @@ void aac_free_irq(struct aac_dev *dev)
>  {
>         int i;
>  
> -       if (aac_is_src(dev)) {
> +       if (dev->pdev->device == PMC_DEVICE_S6 ||
> +           dev->pdev->device == PMC_DEVICE_S7 ||
> +           dev->pdev->device == PMC_DEVICE_S8) {
>                 if (dev->max_msix > 1) {
>                         for (i = 0; i < dev->max_msix; i++)
>                                 free_irq(pci_irq_vector(dev->pdev, i),
> diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
> index 644f7f5c61a2..3b7968b17169 100644
> --- a/drivers/scsi/aacraid/linit.c
> +++ b/drivers/scsi/aacraid/linit.c
> @@ -1560,7 +1560,9 @@ static void __aac_shutdown(struct aac_dev * aac)
>  
>         aac_adapter_disable_int(aac);
>  
> -       if (aac_is_src(aac)) {
> +       if (aac->pdev->device == PMC_DEVICE_S6 ||
> +           aac->pdev->device == PMC_DEVICE_S7 ||
> +           aac->pdev->device == PMC_DEVICE_S8) {
>                 if (aac->max_msix > 1) {
>                         for (i = 0; i < aac->max_msix; i++) {
>                                 free_irq(pci_irq_vector(aac->pdev, i),
> @@ -1835,7 +1837,8 @@ static int aac_acquire_resources(struct aac_dev *dev)
>         aac_adapter_enable_int(dev);
>  
>  
and this.
> -       if (aac_is_src(dev))
> +       if (dev->pdev->device == PMC_DEVICE_S7 ||
> +           dev->pdev->device == PMC_DEVICE_S8)
>                 aac_define_int_mode(dev);
>  
>         if (dev->msi_enabled)


