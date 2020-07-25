Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FD922D6B8
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Jul 2020 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYKYK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 Jul 2020 06:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYKYJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 25 Jul 2020 06:24:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C402C0619D3;
        Sat, 25 Jul 2020 03:24:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k71so6669234pje.0;
        Sat, 25 Jul 2020 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xya5iI6mez6VslA4WdyUYY4hYny+oShJ8iGDbkTMdog=;
        b=CuqnYAU7N/48bI5+Re7xSER7U0PmBoiTZMFXzwKrLovKAZSCrcZGp0tqyIzHE89WED
         5D8i7ovJ2GSa5gbDx6uIi4SaEA6Gkdzd5tYYMZOOV59Z1BleX3fktbSILxWJecNUv9JG
         Z7U9r853PPne6Jjv3kzqB9Q9EIFM7N8xqXD+wbmwMBeumVF7akdhdghYi15pjPtWYE31
         oORnDkHE1wHmQkrhiYKnDGP1pgUjnjGWaG9AY687angKKQbI7oMfP6qBIvwRhSaXc69F
         BPURuIRgGpimIylas2PUB99IEghQW1IEG+StN0XnSNb8Cz0RVdBZnJKL05y8fkHLiJB+
         OIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xya5iI6mez6VslA4WdyUYY4hYny+oShJ8iGDbkTMdog=;
        b=Dg1rJmfv9z4XtpdBTTN9JcyNpH0qnYRzojEgIenyCDpl2pobp0K94i5Oel/pVuk/Xh
         eHl6DMmyFyWqwoexsuRSMt0IFakkNTOiAvIZQu1fAFjNPX61m1GRPOcLbqDTyt4jDDjr
         9auaT6NWek0tan59x91csisipcaTsxksiHuarlpQsxyTXMwxYq6xBnVbZPf6GEouHgnG
         49FBPNPEsVrZNCCdhOzRaLa9f/+ltyrPT/sgg5kvjZcg6wMR5MGgOFLfDFrYKLB54Ulv
         YVZVCuJQ/nQthmrqm7K2HV57qOW7ruj9gOM8sthCtTMjTjiZEkY6FtOw6arYZ83ZdZ1y
         RZNg==
X-Gm-Message-State: AOAM5301jPT1Y7xNL/wqVO4rzZks6w0+0PlKUF6Wr79sPEPGThCDdR+Y
        PoA+ZzqBYdl/LhqmratsWQsfVheU+Mk1Z6MClok=
X-Google-Smtp-Source: ABdhPJxZDi30ldujm27ky8oI7MBOqxieiu1hysjQsqeG6INm3eAisFNDfHQewgGivDRncMAbee+CvYgrdtqqInaoAAg=
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr9956403pjh.129.1595672647801;
 Sat, 25 Jul 2020 03:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200724171706.1550403-1-tasleson@redhat.com> <20200724171706.1550403-6-tasleson@redhat.com>
In-Reply-To: <20200724171706.1550403-6-tasleson@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Jul 2020 13:23:51 +0300
Message-ID: <CAHp75Ve8oanxSj5Uj4N6nv5xP42kAo0-gyfTjtrgRVFX8Mi3dQ@mail.gmail.com>
Subject: Re: [v4 05/11] nvme: Add durable name for dev_printk
To:     Tony Asleson <tasleson@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jul 24, 2020 at 8:19 PM Tony Asleson <tasleson@redhat.com> wrote:
>
> Corrections from Keith Busch review comments.

Good! And where is the commit message?



> +static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
> +                       char *buf);
> +
> +static int dev_to_nvme_durable_name(const struct device *dev, char *buf, size_t len)
> +{
> +       char serial[144];       /* Max 141 for wwid_show */
> +       ssize_t serial_len = wwid_show((struct device *)dev, NULL, serial);
> +
> +       if (serial_len > 0 && serial_len < len) {
> +               serial_len -= 1;  /* Remove the '\n' from the string */
> +               strncpy(buf, serial, serial_len);
> +               return serial_len;
> +       }
> +       return 0;
> +}

Sorry, but this is ugly. Can we rather get some common code from
wwid_show() and reuse it there and here w/o above dances with \n?

-- 
With Best Regards,
Andy Shevchenko
