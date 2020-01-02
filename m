Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA512E609
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jan 2020 13:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgABMVE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jan 2020 07:21:04 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgABMVE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Jan 2020 07:21:04 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so38138776ioj.5
        for <linux-scsi@vger.kernel.org>; Thu, 02 Jan 2020 04:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPXzPi5DdMT3U+gQCRsWNiaGIwoWNFAMsdD1VH87ot8=;
        b=R9OjuKUjTQ+IPlH0otZY5Rg875VDQkWEG5Xom00qvmM5TMiwyYrzThd3rkhqMKtKMu
         ae4qdGlxL7SMrkKfDbc6yD7TwTZXN3lA6tgkBDSnHn6id5l9cPi9IrCtQYZhfziL9VbS
         0k41IgQzyHBkq1uRNfbwo/ap0BfTji0Nc8V7KMu7GPGt9PTvRmBRWFjMvrbkOs8NJCnw
         ckNcWW4Lc2fmHPw3lw8iVly2qVj2XHr6fkwB1JN0wxte1fXCpnkd9UV7zuYWLH4HU6uS
         y38IfvDS93RKPZmCAIaXPK4gPizDsexqkDbafBuZ/Tumi3h/G7e8Zp1Uvy8HgHshkMxt
         5zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPXzPi5DdMT3U+gQCRsWNiaGIwoWNFAMsdD1VH87ot8=;
        b=IYjT7c+R+SclVcfEkFf5BJmVnd8b7g9Ny+0ma0rZhuZDIPDMYPa9nTEZwwDYOgdOJm
         dQSowKdV9isNgFdt+9KqsRnw8A8LrniZHdTen1LxeUQOGIIPOFyEDKr7WR5Lt6bstcAi
         gCkDewHhm54BEXRi2wecUJBYz/IQ1ex1dzKB8OVhZG1x6usMsGMtkH1oCq1BXn7U3DGE
         sUf2pbC4tSRh+KXKEKzS5UKMWvE92qRNuGXI1nQ+jVws4Hk08cmbHaO8MkXJjzCz9uhO
         w5inFYWaa3k7mfDHhTZg1r+zrGHna6y2qx31hqdRxUuKy4P33AmHuEzlOydINfxHIySO
         X1EA==
X-Gm-Message-State: APjAAAWYmEZvZ4ON+crPOwzF35xeBlxuR6eHr5P7YGcA44+xjb5EcMbN
        0CpRHoh7+XPUiSOyvTFNt4MydyeiWHKux4fi5yOkEw==
X-Google-Smtp-Source: APXvYqxVE8yl7mv8bua11Rl2oTTzWqb40WEKzYDaFkvozvtNGAgRPNXpkNzdN9zyoU3ciTg+PYb8YhhrUmis8b/NEOw=
X-Received: by 2002:a5d:84d6:: with SMTP id z22mr51724126ior.54.1577967663920;
 Thu, 02 Jan 2020 04:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20191224044143.8178-1-deepak.ukey@microchip.com> <20191224044143.8178-13-deepak.ukey@microchip.com>
In-Reply-To: <20191224044143.8178-13-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 2 Jan 2020 13:20:53 +0100
Message-ID: <CAMGffE=7egBpma-=KHySYW0QTsqqHhy4yZnZMSnw19ayxYgYMQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] pm80xx : IOCTL functionality for TWI device.
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com,
        Viswas G <Viswas.G@microchip.com>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>, dpf@google.com,
        yuuzheng@google.com, Vikram Auradkar <auradkar@google.com>,
        vishakhavc@google.com, bjashnani@google.com,
        Radha Ramachandran <radha@google.com>, akshatzen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Dec 24, 2019 at 5:41 AM Deepak Ukey <deepak.ukey@microchip.com> wrote:
>
> From: Viswas G <Viswas.G@microchip.com>
>
> Added the IOCTL functionality for TWI device.
>
Please extend the commit message, what's the new functionality, what's
the use case.

Thanks
