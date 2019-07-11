Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C749564FC3
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jul 2019 03:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfGKBFA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 21:05:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53401 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGKBFA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 21:05:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so3988832wmj.3
        for <linux-scsi@vger.kernel.org>; Wed, 10 Jul 2019 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IfhzGaTMvR1JoBV5xWHOxO+UIF3B/TY2O/RfSWHRnA=;
        b=uT1qSazn70ZQddcoZ26D5t2b1na+DrLMLGHaUiJ08qaKIh3NdBYIM5V/8hpuOotEML
         VBmMLmNuHLDTxVqQaOnxdDllNP0jtnZVdBL4yvXFPgGqF6BOD06uO1p9f1desq7OPJ1k
         Gx8FnMW2yJGnRsC8+TAdKI8UcxGYUwCsjXPnLp/0Q2w2zHz31HIE1uq8uz7NVQYTNU/Z
         QVi/PPxkBsv2Lb8j1RfD7DVytwn6gyiupwRDFOCkbn1OBqBVKAiVMLRZJfSItSXwJDWU
         25TY9t/qxh2uidL6r2r3i5wP7CaHTlwIRh1qzluPnolyGev6ZfdYA8kGnh0ld6UYHmtF
         8k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IfhzGaTMvR1JoBV5xWHOxO+UIF3B/TY2O/RfSWHRnA=;
        b=ce67nGYmQzDRy+/KS1zM5Q2/pwo6B2+H9YvuY7TadSCNQociL8790OijaoNFHxIsBn
         bMDTZeHn0g1J57veM2UY32DVLounv2QH/O8IXY9V/6K1tavb1IPuTaWYuAJjjlmlKHDz
         h2N3nOUsobbzJDZVU/9IhE9t21TE6Al/wYOJj4lFzOl4nWI2iyTl4hM0CfXLlonm6ahj
         4xdSxBxUPofgt70OYe1O6QzgD1pok93IwKXeViJftDcDVDal6d8mMoapKLeX4pwNApsA
         Az1jnh1hBxjcUe26DSk48T3sjCiqQHwHGceaRkyOreICt0ZcuiMplAor5vZEifi2OtDQ
         tTcQ==
X-Gm-Message-State: APjAAAUtIaXTGe/Z9q7Nxq4IH0N9ZMCOqhOGp1vtIj2PJ1zRlvT7DW1z
        AVouRjifQ5zoEyvS+/9SBZTb+DAjHMGUsJPXuAM=
X-Google-Smtp-Source: APXvYqy/mA8amvZpJht5/7/95orE0LZyTM55YTzcw4pwmDSz/0Nxgb4zJEn0Hewo7827BBuI2fexG1Hpno7AnfZCZQg=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr480500wme.146.1562807099003;
 Wed, 10 Jul 2019 18:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190702112705.30458-1-mlombard@redhat.com>
In-Reply-To: <20190702112705.30458-1-mlombard@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 11 Jul 2019 09:04:47 +0800
Message-ID: <CACVXFVOCAuitQDiykJeTTHPp2uxMpBz=sd=2CzAQoBxJX4_=BA@mail.gmail.com>
Subject: Re: [PATCH] scsi: use scmd_printk() to print which command timed out
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 2, 2019 at 7:28 PM Maurizio Lombardi <mlombard@redhat.com> wrote:
>
> With a possibly faulty disk the following messages may appear in the logs:
>
> kernel: sd 0:0:9:0: timing out command, waited 180s
> kernel: sd 0:0:9:0: timing out command, waited 20s
> kernel: sd 0:0:9:0: timing out command, waited 20s
> kernel: sd 0:0:9:0: timing out command, waited 60s
> kernel: sd 0:0:9:0: timing out command, waited 20s
>
> This is not very informative because it's not possible to identify
> the command that timed out.
>
> This patch replaces sdev_printk() with scmd_printk().
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f6437b98296b..97ed233fa469 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1501,7 +1501,7 @@ static void scsi_softirq_done(struct request *rq)
>         disposition = scsi_decide_disposition(cmd);
>         if (disposition != SUCCESS &&
>             time_before(cmd->jiffies_at_alloc + wait_for, jiffies)) {
> -               sdev_printk(KERN_ERR, cmd->device,
> +               scmd_printk(KERN_ERR, cmd,
>                             "timing out command, waited %lus\n",
>                             wait_for/HZ);
>                 disposition = SUCCESS;
> --
> Maurizio Lombardi
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
