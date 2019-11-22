Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B02106865
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Nov 2019 09:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfKVIx7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Nov 2019 03:53:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33973 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVIxz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Nov 2019 03:53:55 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so7121723iof.1
        for <linux-scsi@vger.kernel.org>; Fri, 22 Nov 2019 00:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=if8y5NFlyeeHTVh2ye2YOtmqiEB2pxeks7g0W56+3es=;
        b=JwHoJJc9ZdDEo2RfCLoHKhgPn33o0v94BCrI2ZMbALFuFVtOHM1a+qalcjViTJfFQT
         wGcdzwIMTaDsA1t3vMYt//MtNtE3uURk5xRuo2xlStXwYIn3bJMXAwFvyYkjueSS4CD1
         zgF9/i0saIRA64YKR74eTiK0B+nP1OrKdDmxAi1y+jpz1jorKEHmjys8nLyksACQpDai
         8LBpdj5FaasX8V3ouc2ihovhAIJJN4RANMDxnmpnA+3eu9lF9Y3J6q9rpdt0xwzYKDBI
         LFz+oY+uQ9v12b95F5t2v5ukYMy77BpLoqRIcmZkF3V7HZ7hw+WQN1KiyW/+7EMtM9MJ
         U0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=if8y5NFlyeeHTVh2ye2YOtmqiEB2pxeks7g0W56+3es=;
        b=gtGODaMQ3EkjVgZwddf2PAvGubdNkoqVRCp9ZCWdl+1rA79VgDFS902ajexmVGYC0i
         WjdkP4GvCOsgyHXcwR1axZ8+n/ldg01QDfmiDcBD29lRnPIhJ0LcLY/clvdo7rk+yeGF
         GpJxkGbrNN6+u1U+GA4uNRNQnwarCFvXo7reJsr7ZCM9y2P3ReAUrlTt7B1o1LSvWNR1
         HzDRmXDo8EfBakGGW6HAC2akFMrN3b5oDxaNu1qO6ESH2bZtVDI1G6et2gHnYUFyVYtI
         HynR54RqT4WZsx6Kmw7MJ2NI8jzI3qexIuIIfwtQNfO4rI1RZODAlSy5pN3b8mgnoRXe
         Yi9g==
X-Gm-Message-State: APjAAAWb30WPKoKr5/eBvAzP6M/SFVR+yE9OEA8Pn3PevES5gZVNHkf6
        VjJCirOhOeCgJw2PvrMB4ZKd/7L8fVtJQ3b2a9B/rw==
X-Google-Smtp-Source: APXvYqxDK3EHEOhKT9JqqXJcN1RlH2l246qXTmKF4IrMpMVi2D/sVuuclWbE+i1Pf3xycShYZT9chaj6eIn92yKanrg=
X-Received: by 2002:a5d:9c15:: with SMTP id 21mr5135825ioe.298.1574412834417;
 Fri, 22 Nov 2019 00:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20191120135031.270708-1-colin.king@canonical.com>
In-Reply-To: <20191120135031.270708-1-colin.king@canonical.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 22 Nov 2019 09:53:43 +0100
Message-ID: <CAMGffE=dHSO8jW4+iVe7xe5n6esdEb0D9V61XvFr3=a-MAMJJw@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: pm80xx: fix logic to break out of loop when
 register value is 2 or 3
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Deepak Ukey <Deepak.Ukey@microchip.com>,
        Viswas G <Viswas.G@microchip.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Nov 20, 2019 at 2:50 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The condition (reg_val != 2) || (reg_val != 3) will always be true because
> reg_val cannot be equal to two different values at the same time. Fix this
> by replacing the || operator with && so that the loop will loop if reg_val
> is not a 2 and not a 3 as was originally intended.
>
> Addresses-Coverity: ("Constant expression result")
> Fixes: 50dc2f221455 ("scsi: pm80xx: Modified the logic to collect fatal dump")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
looks fine. thanks Colin.
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 19601138e889..d41908b23760 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -348,7 +348,7 @@ ssize_t pm80xx_get_fatal_dump(struct device *cdev,
>                         do {
>                                 reg_val = pm8001_mr32(fatal_table_address,
>                                         MPI_FATAL_EDUMP_TABLE_STATUS);
> -                       } while (((reg_val != 2) || (reg_val != 3)) &&
> +                       } while (((reg_val != 2) && (reg_val != 3)) &&
>                                         time_before(jiffies, start));
>
>                         if (reg_val < 2) {
> --
> 2.24.0
>
