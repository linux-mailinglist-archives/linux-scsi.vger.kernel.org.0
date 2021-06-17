Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3123ABCD6
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Jun 2021 21:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhFQTgr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Jun 2021 15:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233352AbhFQTgl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Jun 2021 15:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623958473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0QVbZGtUMKX0YcURF5RZf3wyVH9YC9/0j+v5ommj7wg=;
        b=WiX+suhnsAGnaXGZTnC1JjpKjH+hTDHbXayiN13pFL3mtcjowmwQDbB9KiAxkCSbO04PLN
        AlUIy/zswui5E1Vhh2Z1v7xOhic5tjODbCWv1WOYhEqof16LAgj6h9TLe6+zyXyOkTuJkY
        CGnNnWXu/nY4LgX2iyyARJFjNUhBKBU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-5A-dGKpJO86M3ef3hXlo3w-1; Thu, 17 Jun 2021 15:34:31 -0400
X-MC-Unique: 5A-dGKpJO86M3ef3hXlo3w-1
Received: by mail-lj1-f200.google.com with SMTP id t7-20020a2e81470000b02901477fea061cso3815044ljg.12
        for <linux-scsi@vger.kernel.org>; Thu, 17 Jun 2021 12:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QVbZGtUMKX0YcURF5RZf3wyVH9YC9/0j+v5ommj7wg=;
        b=Bv0xW+SBHGc/kE++2qSWQQBIiSAlR7rGOSlLzv4vmtF/XdNiQj48mamvHvwAXWBwBc
         ILqXEs+u7tlKHnjBG7m7hHRSUXXD+lxm1Z2G60hGSZpDchtBmQ3+q80wdnXsvKDUel5d
         I6/hXiqTn+Pj0FmPuJhinMFFxAFrW23Mun46onzCSc8RPIGGoqtdQn9UX6Oui+1Jkrsa
         QKRGLZIvJ/USN83IejLkcbr8arcF7hsmUZPJ/NNqutleIO/tg8mxussVJvkstOVIlIIS
         XAUjhqxUspvdk4MlDQ4/DcrPyfdbXlgy3heIUdRPVF0Wa+n6b3xp9EY5Abnhl+I7I7Wp
         QfaA==
X-Gm-Message-State: AOAM5339m/01ojTmC4H7Q+RSKsBw+0QUhmWrty7kiJ46WugUxPw1qAEd
        Lqc+YN5v3kabqU2YgEImjUTJCTpIQEproCppC7Q9Z6C0leDAdLA96E0zbw/pLiX8C6bH1eo7lRk
        ZVOUrRl42Y47k+3dGeEU71YllKE7VHvAVjwPCrQ==
X-Received: by 2002:a05:6512:3d15:: with SMTP id d21mr5249837lfv.252.1623958470472;
        Thu, 17 Jun 2021 12:34:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHcTsgvmvxoF61BXQGGx1dFhjz2R0T1Tg7FJZcTOE3TdflaZaCIihOhmtf7XN6SK1XYVxxcMtvKOgOo8AUTTw=
X-Received: by 2002:a05:6512:3d15:: with SMTP id d21mr5249784lfv.252.1623958470194;
 Thu, 17 Jun 2021 12:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210617182242.8637-1-nitesh@redhat.com> <20210617182242.8637-5-nitesh@redhat.com>
 <ddee52a6-ac70-6e2d-b48e-e9bf38c94265@arm.com>
In-Reply-To: <ddee52a6-ac70-6e2d-b48e-e9bf38c94265@arm.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Thu, 17 Jun 2021 15:34:18 -0400
Message-ID: <CAFki+LkTqThGZDGui4N6Ko-Z8PMPtX7m-KPm0BM4SvbAxrOqVw@mail.gmail.com>
Subject: Re: [PATCH v1 04/14] scsi: megaraid_sas: Use irq_set_affinity_and_hint
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pci@vger.kernel.org,
        tglx@linutronix.de, jesse.brandeburg@intel.com,
        mtosatti@redhat.com, mingo@kernel.org, jbrandeb@kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, rostedt@goodmis.org, peterz@infradead.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, chris.friesen@windriver.com,
        maz@kernel.org, nhorman@tuxdriver.com, pjwaskiewicz@gmail.com,
        sassmann@redhat.com, thenzl@redhat.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jkc@redhat.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com, ahleihel@redhat.com,
        kheib@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        benve@cisco.com, govind@gmx.com, jassisinghbrar@gmail.com,
        luobin9@huawei.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 17, 2021 at 3:31 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-17 19:22, Nitesh Narayan Lal wrote:
> > The driver uses irq_set_affinity_hint() specifically for the high IOPS
> > queue interrupts for two purposes:
> >
> > - To set the affinity_hint which is consumed by the userspace for
> >    distributing the interrupts
> >
> > - To apply an affinity that it provides
> >
> > The driver enforces its own affinity to bind the high IOPS queue interrupts
> > to the local NUMA node. However, irq_set_affinity_hint() applying the
> > provided cpumask as an affinity for the interrupt is an undocumented side
> > effect.
> >
> > To remove this side effect irq_set_affinity_hint() has been marked
> > as deprecated and new interfaces have been introduced. Hence, replace the
> > irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
> > that clearly indicates the purpose of the usage and is meant to apply the
> > affinity and set the affinity_hint pointer. Also, replace
> > irq_set_affinity_hint() with irq_update_affinity_hint() when only
> > affinity_hint needs to be updated.
> >
> > Change the megasas_set_high_iops_queue_affinity_hint function name to
> > megasas_set_high_iops_queue_affinity_and_hint to clearly indicate that the
> > function is setting both affinity and affinity_hint.
> >
> > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > ---
> >   drivers/scsi/megaraid/megaraid_sas_base.c | 25 ++++++++++++++---------
> >   1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> > index 4d4e9dbe5193..54f4eac09589 100644
> > --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> > +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> > @@ -5666,7 +5666,7 @@ megasas_setup_irqs_msix(struct megasas_instance *instance, u8 is_probe)
> >                               "Failed to register IRQ for vector %d.\n", i);
> >                       for (j = 0; j < i; j++) {
> >                               if (j < instance->low_latency_index_start)
> > -                                     irq_set_affinity_hint(
> > +                                     irq_update_affinity_hint(
> >                                               pci_irq_vector(pdev, j), NULL);
> >                               free_irq(pci_irq_vector(pdev, j),
> >                                        &instance->irq_context[j]);
> > @@ -5709,7 +5709,7 @@ megasas_destroy_irqs(struct megasas_instance *instance) {
> >       if (instance->msix_vectors)
> >               for (i = 0; i < instance->msix_vectors; i++) {
> >                       if (i < instance->low_latency_index_start)
> > -                             irq_set_affinity_hint(
> > +                             irq_update_affinity_hint(
> >                                   pci_irq_vector(instance->pdev, i), NULL);
> >                       free_irq(pci_irq_vector(instance->pdev, i),
> >                                &instance->irq_context[i]);
> > @@ -5840,22 +5840,27 @@ int megasas_get_device_list(struct megasas_instance *instance)
> >   }
> >
> >   /**
> > - * megasas_set_high_iops_queue_affinity_hint -       Set affinity hint for high IOPS queues
> > - * @instance:                                        Adapter soft state
> > - * return:                                   void
> > + * megasas_set_high_iops_queue_affinity_and_hint -   Set affinity and hint
> > + *                                                   for high IOPS queues
> > + * @instance:                                                Adapter soft state
> > + * return:                                           void
> >    */
> >   static inline void
> > -megasas_set_high_iops_queue_affinity_hint(struct megasas_instance *instance)
> > +megasas_set_high_iops_queue_affinity_and_hint(struct megasas_instance *instance)
> >   {
> >       int i;
> > +     unsigned int irq;
> >       int local_numa_node;
> > +     const struct cpumask *mask;
> >
> >       if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
> >               local_numa_node = dev_to_node(&instance->pdev->dev);
>
> Drive-by nit: you could assign mask in this scope.
>

Sure

> > -             for (i = 0; i < instance->low_latency_index_start; i++)
> > -                     irq_set_affinity_hint(pci_irq_vector(instance->pdev, i),
> > -                             cpumask_of_node(local_numa_node));
> > +             for (i = 0; i < instance->low_latency_index_start; i++) {
> > +                     irq = pci_irq_vector(instance->pdev, i);
> > +                     mask = cpumask_of_node(local_numa_node);
> > +                     irq_update_affinity_hint(irq, mask);
>
> And this doesn't seem to match what the commit message says?
>

Clearly, thanks for catching it.
This should be irq_set_affinity_and_hint().

> Robin.
>
> > +             }
> >       }
> >   }
> >
> > @@ -5944,7 +5949,7 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
> >               instance->msix_vectors = 0;
> >
> >       if (instance->smp_affinity_enable)
> > -             megasas_set_high_iops_queue_affinity_hint(instance);
> > +             megasas_set_high_iops_queue_affinity_and_hint(instance);
> >   }
> >
> >   /**
> >
>


-- 
Thanks
Nitesh

