Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D374C82D
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfFTHSC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 03:18:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40412 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTHSC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 03:18:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so1245191qkg.7
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLCAlHwAV59KipcYAs6JDS7NjR2Bz+Umvzb+EPHiAMQ=;
        b=aFoFZJbubFQdIzb80M3XMF34bA+rS9rc4Pv2y2BcHdwE/A/plJ0UHn352pl5lhFzVv
         BTmSF6iMoapsAu+0kCG69Db4fvOnwgLhaOpylhry7p1XGP57fo7ioC2E1pZkLypaqRY0
         VKf0/bThGSKGsqPp8HqnNeoMDW8VXVIBLd5ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLCAlHwAV59KipcYAs6JDS7NjR2Bz+Umvzb+EPHiAMQ=;
        b=q5EYfMWvYzkcnRCBOBYQcRNgKpkTVrVaWo8hIQnpWWjlhm7/kvzVK/j1rpowqC6EhL
         m2J0iWLJZWbbgB+ovDuZb2S5Caqh0FZ0HausM/pVzrpwU8bgQftbfWS4TjsJ6emI2d5+
         pLlvZN3XzDaibwrbVxDd1wTsHdS2ZsT1Ct4Y0ZsHvnxdYcGBsim71VWZRweejFf67rfa
         zui4strO/to0oirEHYXIaXXI2bx1bHn+yNE16lXLp7AJaFsifJssNgJxxpGV+XP2JQX7
         fvvsdOZoWfxbLRpuhTz98rQnbM8CFYBPBhQMHGMBW3aIyhr4tAvTuM5LLCp0qbDrHM1/
         b3Bg==
X-Gm-Message-State: APjAAAV4JACaw0CUxNCc47JPR2+pW/E1JtAsYqM5o13vnfMkFS60V8Ga
        vNHgS/AcwwCSw3Gy5yrDzUonG1tElZ+hBBHeOCgM6A==
X-Google-Smtp-Source: APXvYqwqKCqhSBx5oEwr8e9D2iMl1IG4YsDV20OsP9wmsgtLZ+rmq0Ui/hq08Tke7vV1KmjyMt1vMmRVJIqKtIK+0H4=
X-Received: by 2002:a37:9cc4:: with SMTP id f187mr84596865qke.23.1561015080712;
 Thu, 20 Jun 2019 00:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190614144144.6448-1-thenzl@redhat.com> <20190614144144.6448-2-thenzl@redhat.com>
In-Reply-To: <20190614144144.6448-2-thenzl@redhat.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 20 Jun 2019 12:52:39 +0530
Message-ID: <CA+RiK65BdoDOKvaCTQD-Yuk9vGQA98JKyVGZc0==X4QKcgVYBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: mpt3sas: make driver options visible in sys
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Acked-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

On Fri, Jun 14, 2019 at 8:12 PM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Support is easier with all driver parameters visible in sysfs.
> Also I've replaced a constant with an octal permission.
>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c  | 14 +++++++-------
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 +++++++-------
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index e6377ec07..839930764 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -74,28 +74,28 @@ static MPT_CALLBACK mpt_callbacks[MPT_MAX_CALLBACKS];
>  #define MAX_HBA_QUEUE_DEPTH    30000
>  #define MAX_CHAIN_DEPTH                100000
>  static int max_queue_depth = -1;
> -module_param(max_queue_depth, int, 0);
> +module_param(max_queue_depth, int, 0444);
>  MODULE_PARM_DESC(max_queue_depth, " max controller queue depth ");
>
>  static int max_sgl_entries = -1;
> -module_param(max_sgl_entries, int, 0);
> +module_param(max_sgl_entries, int, 0444);
>  MODULE_PARM_DESC(max_sgl_entries, " max sg entries ");
>
>  static int msix_disable = -1;
> -module_param(msix_disable, int, 0);
> +module_param(msix_disable, int, 0444);
>  MODULE_PARM_DESC(msix_disable, " disable msix routed interrupts (default=0)");
>
>  static int smp_affinity_enable = 1;
> -module_param(smp_affinity_enable, int, S_IRUGO);
> +module_param(smp_affinity_enable, int, 0444);
>  MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
>
>  static int max_msix_vectors = -1;
> -module_param(max_msix_vectors, int, 0);
> +module_param(max_msix_vectors, int, 0444);
>  MODULE_PARM_DESC(max_msix_vectors,
>         " max msix vectors");
>
>  static int irqpoll_weight = -1;
> -module_param(irqpoll_weight, int, 0);
> +module_param(irqpoll_weight, int, 0444);
>  MODULE_PARM_DESC(irqpoll_weight,
>         "irq poll weight (default= one fourth of HBA queue depth)");
>
> @@ -104,7 +104,7 @@ MODULE_PARM_DESC(mpt3sas_fwfault_debug,
>         " enable detection of firmware fault and halt firmware - (default=0)");
>
>  static int perf_mode = -1;
> -module_param(perf_mode, int, 0);
> +module_param(perf_mode, int, 0444);
>  MODULE_PARM_DESC(perf_mode,
>         "Performance mode (only for Aero/Sea Generation), options:\n\t\t"
>         "0 - balanced: high iops mode is enabled &\n\t\t"
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 1f6aa8b19..27c731a3f 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -113,22 +113,22 @@ MODULE_PARM_DESC(logging_level,
>
>
>  static ushort max_sectors = 0xFFFF;
> -module_param(max_sectors, ushort, 0);
> +module_param(max_sectors, ushort, 0444);
>  MODULE_PARM_DESC(max_sectors, "max sectors, range 64 to 32767  default=32767");
>
>
>  static int missing_delay[2] = {-1, -1};
> -module_param_array(missing_delay, int, NULL, 0);
> +module_param_array(missing_delay, int, NULL, 0444);
>  MODULE_PARM_DESC(missing_delay, " device missing delay , io missing delay");
>
>  /* scsi-mid layer global parmeter is max_report_luns, which is 511 */
>  #define MPT3SAS_MAX_LUN (16895)
>  static u64 max_lun = MPT3SAS_MAX_LUN;
> -module_param(max_lun, ullong, 0);
> +module_param(max_lun, ullong, 0444);
>  MODULE_PARM_DESC(max_lun, " max lun, default=16895 ");
>
>  static ushort hbas_to_enumerate;
> -module_param(hbas_to_enumerate, ushort, 0);
> +module_param(hbas_to_enumerate, ushort, 0444);
>  MODULE_PARM_DESC(hbas_to_enumerate,
>                 " 0 - enumerates both SAS 2.0 & SAS 3.0 generation HBAs\n \
>                   1 - enumerates only SAS 2.0 generation HBAs\n \
> @@ -142,17 +142,17 @@ MODULE_PARM_DESC(hbas_to_enumerate,
>   * Either bit can be set, or both
>   */
>  static int diag_buffer_enable = -1;
> -module_param(diag_buffer_enable, int, 0);
> +module_param(diag_buffer_enable, int, 0444);
>  MODULE_PARM_DESC(diag_buffer_enable,
>         " post diag buffers (TRACE=1/SNAPSHOT=2/EXTENDED=4/default=0)");
>  static int disable_discovery = -1;
> -module_param(disable_discovery, int, 0);
> +module_param(disable_discovery, int, 0444);
>  MODULE_PARM_DESC(disable_discovery, " disable discovery ");
>
>
>  /* permit overriding the host protection capabilities mask (EEDP/T10 PI) */
>  static int prot_mask = -1;
> -module_param(prot_mask, int, 0);
> +module_param(prot_mask, int, 0444);
>  MODULE_PARM_DESC(prot_mask, " host protection capabilities mask, def=7 ");
>
>
> --
> 2.20.1
>
