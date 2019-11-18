Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2F51000E3
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Nov 2019 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKRJBS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 04:01:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36291 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfKRJBR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Nov 2019 04:01:17 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so17868085ioe.3
        for <linux-scsi@vger.kernel.org>; Mon, 18 Nov 2019 01:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pc7PwEHCo4IdBdp2uBWwiWj0wW5Yw6s3tIy+6vLnfa8=;
        b=OB3CvNPTPXoCd0YOScapOUbTvM5VAcE6oiJVT2eqCxtasZP63plW+M21wgS9aJ4ZUU
         BpJDLw/+ce6NEatjRSgUB18CToN5+TPvyXGsO8KI7zfjD6pf7fvjsy+WA//3Fcf7emO4
         zUH+ub3hP5TT0+2Ff6wIGSbFEQUmAWr6Bz5gMTUcSW7U7m73L5Kz7JByf5aVnG2uDDdX
         pQPvXNg1zZZIWsv369Jv+7vHJ8qwSv6EGd8Ro6Ac5BJ7uxk72Fem7NfBIP/iMPTHRDwc
         5RFkVNqYe0KMJXOfo6WbclxKdWXdq0ozmNpN4TUnf3MSPA0K6VvxebbKczwkKkFWhZJd
         ob/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pc7PwEHCo4IdBdp2uBWwiWj0wW5Yw6s3tIy+6vLnfa8=;
        b=tPRDJPEqRidvOaC88XqSa50jeIY3ewA89JZXgEzUu2e3JwKQG7IW6dvN4fcrXbXjyh
         P9AhdSvmkEymCc8ymgee3v29VDecII1tDZ5FMwHeRDlmcD06sqxm2YmZSNok+Nd7ssJG
         ycRQ/le1DCeA4XRLmyTKCcPLiceLdurCGOKq13l9L9C8PJHsgDpjQV4olo2TuBktzaPI
         vxNhC64gEmRzGQXG94Q8tnBRk5E56UiHdxWptvg/sQoAVPkXVwIZzkbhbHGQn/CZEeU/
         DH3hJeGoS2iTBkZcyxpM0k4Pn9VrkM2fmlXiLENz5RysdABLeLipUn+tL5Le7OjFrkjj
         qS6w==
X-Gm-Message-State: APjAAAVi1+OGKG38Bfgo7KFdJV8XwrNqRuQJ8ydJQ8wYl5AEsND5e3nj
        2e6XWhXqypJ0dyHIh8a/aNU93wHCaH6Q22ChlHDnPg==
X-Google-Smtp-Source: APXvYqxX50zUXZuNkpnEXOvOjWkp8W3FtgF9aaT2Xg7Z623DzUF5OrQNl4lvo3CqnY+az0hRBi/ElRz1zxRI5xJaVA8=
X-Received: by 2002:a02:c54b:: with SMTP id g11mr12655120jaj.136.1574067677146;
 Mon, 18 Nov 2019 01:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20191114100910.6153-1-deepak.ukey@microchip.com> <20191114100910.6153-3-deepak.ukey@microchip.com>
In-Reply-To: <20191114100910.6153-3-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 18 Nov 2019 10:01:06 +0100
Message-ID: <CAMGffEmMP3JzyyuyAu+9pjLgHuVA0o0LrNU71fo-Odkb2NjseA@mail.gmail.com>
Subject: Re: [PATCH V2 02/13] pm80xx : Make phy enable completion as NULL.
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com, Viswas.G@microchip.com,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>, dpf@google.com,
        jsperbeck@google.com, Vikram Auradkar <auradkar@google.com>,
        ianyar@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Nov 14, 2019 at 11:08 AM Deepak Ukey <deepak.ukey@microchip.com> wrote:
>
> From: peter chang <dpf@google.com>
>
> After the completing the mpi_phy_start_resp make phy enable completion
> as NULL.
>
> Signed-off-by: peter chang <dpf@google.com>
> Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Thanks
