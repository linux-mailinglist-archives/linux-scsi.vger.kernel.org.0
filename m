Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005BE152717
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Feb 2020 08:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgBEHi0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Feb 2020 02:38:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42856 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBEHi0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Feb 2020 02:38:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so1010113oih.9
        for <linux-scsi@vger.kernel.org>; Tue, 04 Feb 2020 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHCHejlb0Njoieb9nIgel05KYyor/lBS9JeYUsC9YKc=;
        b=UofL/umRod0QO8lZgg6CRjbmkNjWZkVwn3r1XBMKE0TfWNPeXK0LgiOZrrzbXDO+eb
         FHzCaeprjwOblMPI09gaU1lHK54R6RJgXVTiWO6N4KyNuPq6WGVG4Y0G4YVsNDk4RuH6
         RmyzFU+fB/98HPIFgYN+6M+EfQtPluehACWpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHCHejlb0Njoieb9nIgel05KYyor/lBS9JeYUsC9YKc=;
        b=JjZsz+lrrqFQRnYmFkWsuLICbsXdSZslwZ0G2nwjHHgr81ne899B38EMDZnu0IpZMs
         XZ9kTeYoFfJGy/0apnnHufz7zk618rbzdwMP96a9oGJ3U5cHyC19IvDobiIc7+up0Xps
         hG+kG30o6elz1HAsGGms32JlDkio9+QZmiW+UN9JbdhODE/m1lJIh9gSALojhQ32n/NT
         p8rOGvHYtnIDXNC9goUIxWh6Z0i0UUebICbdY7XYsozC3I/qyyCS5tweF3U+fmGVSiaF
         5bcv5EDG5YZIm02EWyQWTrjN9xwPHvv7a3SU7+fXpe6HVuxa/nDnhwhDN8IjBiMQz1RE
         mxHg==
X-Gm-Message-State: APjAAAXzwMcxSUM5H8IiSyAP2uNsQ1TBpfUiBkgHOGOWP5EDk6/YCp4i
        KEGtpaLRF9DpWGHrA46Ro6WuNA/W5zkmHool2RVl2Ys9KMU=
X-Google-Smtp-Source: APXvYqwzHVbXlWGAWzWx8faj8LMSaLw8KP+x9ejAOO6s+JUAycHG2U+8Lbt0Ovxq8Z0VTrF2/+/qa/LHXCLM8IOA33Y=
X-Received: by 2002:a05:6808:4c2:: with SMTP id a2mr1945500oie.118.1580888305224;
 Tue, 04 Feb 2020 23:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20200204152413.7107-1-thenzl@redhat.com>
In-Reply-To: <20200204152413.7107-1-thenzl@redhat.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Wed, 5 Feb 2020 13:07:58 +0530
Message-ID: <CAL2rwxoPTTZsZQC_Razw7eEnudrcpGCFgPbp73Z9rEG+cQ7-GA@mail.gmail.com>
Subject: Re: [PATCH V2] megaraid_sas: silence a warning
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        Lee Duncan <lduncan@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Feb 4, 2020 at 8:54 PM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Add a flag to dma mem allocation to silence a warning.
>
> This code allocates DMA memory for driver's IO frames which may exceed
> MAX_ORDER pages for few megaraid_sas controllers(controllers
> with High Queue Depth). So there is logic to keep on reducing controller
> Queue Depth until DMA memory required for IO frames fits within
> MAX_ORDER. So or impacted megaraid_sas controllers,
> there would be multiple DMA allocation failure until driver settles
> down to Controller Queue Depth which has memory requirement
> within MAX_ORDER. These failed DMA allocation requests causes stack
> traces in system logs which is not harmful and this patch
> would silence those warnings/stack traces.
>
> With CMA (Contiguous Memory Allocator) enabled, it's possible  to
> allocate DMA memory exceeding MAX_ORDER.
> And that is the reason of keeping this retry logic with less
> controller Queue Depth instead of calculating controller Queue depth
> at first hand which has memory requirement less than MAX_ORDER.
>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>

Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
> V2: A change in the description, additional information is added,
> kindly written by Sumit.
>
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 0f5399b3e..1fa2d1449 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -606,7 +606,8 @@ megasas_alloc_request_fusion(struct megasas_instance *instance)
>
>         fusion->io_request_frames =
>                         dma_pool_alloc(fusion->io_request_frames_pool,
> -                               GFP_KERNEL, &fusion->io_request_frames_phys);
> +                               GFP_KERNEL | __GFP_NOWARN,
> +                               &fusion->io_request_frames_phys);
>         if (!fusion->io_request_frames) {
>                 if (instance->max_fw_cmds >= (MEGASAS_REDUCE_QD_COUNT * 2)) {
>                         instance->max_fw_cmds -= MEGASAS_REDUCE_QD_COUNT;
> @@ -644,7 +645,7 @@ megasas_alloc_request_fusion(struct megasas_instance *instance)
>
>                 fusion->io_request_frames =
>                         dma_pool_alloc(fusion->io_request_frames_pool,
> -                                      GFP_KERNEL,
> +                                      GFP_KERNEL | __GFP_NOWARN,
>                                        &fusion->io_request_frames_phys);
>
>                 if (!fusion->io_request_frames) {
> --
> 2.21.1
>
