Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD1538448
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfFGG1J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 02:27:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33520 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfFGG1I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 02:27:08 -0400
Received: by mail-vk1-f193.google.com with SMTP id v69so194687vke.0
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 23:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uj97E23yMpF9dBoxx0hUPlnQghbrhMurLQZTJ3zBb8=;
        b=gry8t6WgPr+G4n2+hQQD/IijRKY3jj4q9h30+0bKrGME2hyBI6BBOIyctGINlbDtgb
         Owcx5Yvy1jmr5LrLmq+vka2l0guQKY8S4bAE43/9iHcHK+qQs1GemHs28X21bszJpsNz
         8bfDvgSHeoSk957F5D/SASv6coLTNvy/CcC2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uj97E23yMpF9dBoxx0hUPlnQghbrhMurLQZTJ3zBb8=;
        b=JjzeLkp6rnHa6UcVelZZqQU6AUhCgEUYo4VqorSXREdk5B3bMlmGy/2+acJ0NIM/Mu
         EaaCA7BvzEERvxhafIaDUlw1sxKp7XL4OaeaExYZ6Vq7mhVLsCaLIakPS1lQ+PHUZ7/I
         oMK8kI0Yv+f1T5AsBzonSYvP4FL86446TWY5jjM4Hitx82A1bYu1tj1OoO8C15EA6o8J
         izIEJK+vDBN5dP8tJT2EnfD3IQZ9KvJVUsnM2ZX1p7NIwJAxQpT4U8aZxYRwNuSuhjxM
         ZAzSWpUDUn7hOboPA+gfbgGr9oDWXCwu2GAGgHrlzlUKO0phu2xQY5OL0OldVWnwS745
         LSWg==
X-Gm-Message-State: APjAAAUaS+XCjAC8jReHTll/mKRvM5W3Z0OvqXlNTOMzuSBPL9RciqNs
        4Gf/Hv2Y6WeN2FWjFbNup7vCyDoUtXMsSf8o/cmZgVMPPMU=
X-Google-Smtp-Source: APXvYqwdIQYihm6EB9E60l4816GKKf4CRI+MUG4rJpc5rp1+lydGD2iHxGQojX4eNcp9NzUgBPVK+GoB1FdjeEWzNvs=
X-Received: by 2002:a1f:aad2:: with SMTP id t201mr4246806vke.74.1559888827613;
 Thu, 06 Jun 2019 23:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190529160041.7242-1-thenzl@redhat.com> <20190529160041.7242-3-thenzl@redhat.com>
In-Reply-To: <20190529160041.7242-3-thenzl@redhat.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 11:56:56 +0530
Message-ID: <CAL2rwxqU1o=d6p8747Lxv=YNCQZ5gQvvJ6gUUfgKyzb05YL47Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] megaraid_sas: use octal permissions instead of constants
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 9:30 PM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Checkpatch emits a warning when using symbolic permissions. Use octal
> permissions instead.
> No functional change.
>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 20 ++++++++++----------
>  drivers/scsi/megaraid/megaraid_sas_fp.c   |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 3752daab0..0522821a5 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -64,45 +64,45 @@
>   * Will be set in megasas_init_mfi if user does not provide
>   */
>  static unsigned int max_sectors;
> -module_param_named(max_sectors, max_sectors, int, S_IRUGO);
> +module_param_named(max_sectors, max_sectors, int, 0444);
>  MODULE_PARM_DESC(max_sectors,
>         "Maximum number of sectors per IO command");
>
>  static int msix_disable;
> -module_param(msix_disable, int, S_IRUGO);
> +module_param(msix_disable, int, 0444);
>  MODULE_PARM_DESC(msix_disable, "Disable MSI-X interrupt handling. Default: 0");
>
>  static unsigned int msix_vectors;
> -module_param(msix_vectors, int, S_IRUGO);
> +module_param(msix_vectors, int, 0444);
>  MODULE_PARM_DESC(msix_vectors, "MSI-X max vector count. Default: Set by FW");
>
>  static int allow_vf_ioctls;
> -module_param(allow_vf_ioctls, int, S_IRUGO);
> +module_param(allow_vf_ioctls, int, 0444);
>  MODULE_PARM_DESC(allow_vf_ioctls, "Allow ioctls in SR-IOV VF mode. Default: 0");
>
>  static unsigned int throttlequeuedepth = MEGASAS_THROTTLE_QUEUE_DEPTH;
> -module_param(throttlequeuedepth, int, S_IRUGO);
> +module_param(throttlequeuedepth, int, 0444);
>  MODULE_PARM_DESC(throttlequeuedepth,
>         "Adapter queue depth when throttled due to I/O timeout. Default: 16");
>
>  unsigned int resetwaittime = MEGASAS_RESET_WAIT_TIME;
> -module_param(resetwaittime, int, S_IRUGO);
> +module_param(resetwaittime, int, 0444);
>  MODULE_PARM_DESC(resetwaittime, "Wait time in (1-180s) after I/O timeout before resetting adapter. Default: 180s");
>
>  int smp_affinity_enable = 1;
> -module_param(smp_affinity_enable, int, S_IRUGO);
> +module_param(smp_affinity_enable, int, 0444);
>  MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
>
>  int rdpq_enable = 1;
> -module_param(rdpq_enable, int, S_IRUGO);
> +module_param(rdpq_enable, int, 0444);
>  MODULE_PARM_DESC(rdpq_enable, "Allocate reply queue in chunks for large queue depth enable/disable Default: enable(1)");
>
>  unsigned int dual_qdepth_disable;
> -module_param(dual_qdepth_disable, int, S_IRUGO);
> +module_param(dual_qdepth_disable, int, 0444);
>  MODULE_PARM_DESC(dual_qdepth_disable, "Disable dual queue depth feature. Default: 0");
>
>  unsigned int scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
> -module_param(scmd_timeout, int, S_IRUGO);
> +module_param(scmd_timeout, int, 0444);
>  MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), default 90s. See megasas_reset_timer.");
>
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
> index 9ac357619..d296255a4 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fp.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
> @@ -58,7 +58,7 @@
>
>  #define LB_PENDING_CMDS_DEFAULT 4
>  static unsigned int lb_pending_cmds = LB_PENDING_CMDS_DEFAULT;
> -module_param(lb_pending_cmds, int, S_IRUGO);
> +module_param(lb_pending_cmds, int, 0444);
>  MODULE_PARM_DESC(lb_pending_cmds, "Change raid-1 load balancing outstanding "
>         "threshold. Valid Values are 1-128. Default: 4");
>
> --
> 2.20.1
>
