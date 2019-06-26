Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E921A5647C
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Jun 2019 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFZIYY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 04:24:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41221 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZIYY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 04:24:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so1609883wrm.8
        for <linux-scsi@vger.kernel.org>; Wed, 26 Jun 2019 01:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoHDUC0TOnPRAuFJuw7NvCRlP+IzdmmkS0BHV8cdSyw=;
        b=QZCh9yshaHtx0WHoUXe2mAGJWifAWUjdlflN8ak0BrgUD6NBfMzr6ivwrDt8OV34h5
         O+fI+Krr0h1SEyfgYAm/fFqfHbxZoIbnCehj7WzHJLgTNVC60+5kSaA+6/58yOzvLOSx
         vWKEALIj3p9Mhtn9MGdK0wwsjqvACh4+5d4ys9mWCGdbOFMM4QZjs0fG8xGgC+j0/7Tm
         4xfg9pbIZCQYfTrAWwvbsIYyoRYmugGtvwYe32wIYJ9llSAQnK5H1RMTkgTQCMTdlSXm
         OVoPr03+kU25GW3n0lpjmgqJeV0CuOQoFc1160zBnr3IqkOdMD5P7cORwfMmXGlJzHYk
         uPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoHDUC0TOnPRAuFJuw7NvCRlP+IzdmmkS0BHV8cdSyw=;
        b=Q0FSIk/sofjMr3BSUmF7xPP6cPo1caEtgV2qmKwWzSf79Ya6W1D0HXwiNRWAISStZ/
         yNK5YFhwVBIlxchkfMOXqAosXt5MrUB7b9Em1+y4NvDjROVhoWQOA8ytUzOcGCdiNQOt
         XK0dKGKJZF9TGUBeMMKgAjeDSGWNpt2xShkKjzl8TEd7TU7EO2V4YDN1Aiw3+Uzr0LFH
         ojuuTQs98lxjqFrHK+iex6Fakbp/lOGEQYy2f5cEifDAKZt5l4eyc7rCSBESqwzcL6h6
         GiPWgulnIcGaGrOLBw8ZPnFOncHzWON2pwaobGQdrBx+I3+Dle4vQFFZrQSlriljMG8G
         DH9g==
X-Gm-Message-State: APjAAAVde2PrbZu2qQd4Tl+rw7ilCTgHewncV5pQ0yrCdkXYcomz7RG8
        2sF9WEV7L6T4rmyrenxKm6rv28L+oQaVsMcgj0jDlQ==
X-Google-Smtp-Source: APXvYqzF12NoOlXK812hIqYOZ7DP+jhw/dTCwwKhVaPBbW1QEybMOEJixqIxgWUjgUxqm58NmQnO/vWbAdUGFpExBgU=
X-Received: by 2002:a5d:4752:: with SMTP id o18mr2530464wrs.74.1561537462272;
 Wed, 26 Jun 2019 01:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190624082228.27433-1-deepak.ukey@microchip.com> <20190624082228.27433-4-deepak.ukey@microchip.com>
In-Reply-To: <20190624082228.27433-4-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 26 Jun 2019 10:24:11 +0200
Message-ID: <CAMGffEmwjfQCST+=6a3dV92q0_J+te8cb-H2YM1PG7LZ-SM13Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] pm80xx : Modified the logic to collect IOP event logs.
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com, Viswas.G@microcchip.com,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 24, 2019 at 10:22 AM Deepak Ukey <deepak.ukey@microchip.com> wrote:
>
> Added the logic for collecting IOP log respective to event log size.
>
> Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
> ---
Thanks, looks fine.
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>

>  drivers/scsi/pm8001/pm8001_ctl.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
> index c7e0a42c..6b85016 100644
> --- a/drivers/scsi/pm8001/pm8001_ctl.c
> +++ b/drivers/scsi/pm8001/pm8001_ctl.c
> @@ -492,25 +492,26 @@ static ssize_t pm8001_ctl_iop_log_show(struct device *cdev,
>         struct Scsi_Host *shost = class_to_shost(cdev);
>         struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
>         struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
> -#define IOP_MEMMAP(r, c) \
> -       (*(u32 *)((u8*)pm8001_ha->memoryMap.region[IOP].virt_ptr + (r) * 32 \
> -       + (c)))
> -       int i;
>         char *str = buf;
> -       int max = 2;
> -       for (i = 0; i < max; i++) {
> -               str += sprintf(str, "0x%08x 0x%08x 0x%08x 0x%08x 0x%08x 0x%08x"
> -                              "0x%08x 0x%08x\n",
> -                              IOP_MEMMAP(i, 0),
> -                              IOP_MEMMAP(i, 4),
> -                              IOP_MEMMAP(i, 8),
> -                              IOP_MEMMAP(i, 12),
> -                              IOP_MEMMAP(i, 16),
> -                              IOP_MEMMAP(i, 20),
> -                              IOP_MEMMAP(i, 24),
> -                              IOP_MEMMAP(i, 28));
> +       u32 read_size =
> +               pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size / 1024;
> +       static u32 start, end, count;
> +       u32 max_read_times = 32;
> +       u32 max_count = (read_size * 1024) / (max_read_times * 4);
> +       u32 *temp = (u32 *)pm8001_ha->memoryMap.region[IOP].virt_ptr;
> +
> +       if ((count % max_count) == 0) {
> +               start = 0;
> +               end = max_read_times;
> +               count = 0;
> +       } else {
> +               start = end;
> +               end = end + max_read_times;
>         }
>
> +       for (; start < end; start++)
> +               str += sprintf(str, "%08x ", *(temp+start));
> +       count++;
>         return str - buf;
>  }
>  static DEVICE_ATTR(iop_log, S_IRUGO, pm8001_ctl_iop_log_show, NULL);
> --
> 1.8.5.6
>
