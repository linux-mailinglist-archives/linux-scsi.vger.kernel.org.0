Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6433152942
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 12:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfFYKRn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 06:17:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40667 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFYKRm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 06:17:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2348354wmj.5
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixyRyFiZlDxzjg5HBbCvjwMQM2+1lGKbOGSLPdBR+m8=;
        b=G6IKKGxP7i4HHd58jFg1/Nbu19I34FDnRQTT74/xCBldz6Nq+M97hU9bDipoRuS6a6
         ZzhmuTvacpm3bJqLsUSTS50XsFG1y1VwjnOrz3723mlG+7AybhQ4GEPWKfxHTb32ZWIB
         kzr8kMnBcH76AM/Q+//jFiglacd0Iax6ZAaovV7F84qQzXvyp1rL1l3SNoQfORaQtCLT
         zcABY6CaLOMpL6XtnVZc4KHXchE/L4G1gO5G0P95djw3ddjZVtQwM7GogBYrBiGsa/d/
         M7HCjNBNKeg/kQSfOekq6J1BXx6b/B39VB9F2jE+gk3jBj7jvJqfWnk0r+gFjqpphscq
         Bzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixyRyFiZlDxzjg5HBbCvjwMQM2+1lGKbOGSLPdBR+m8=;
        b=oVObziBahBy0GnK64xeQsYBelKbzN27cHg6lGjSpkMAspBUJ4DA46LQ2j4xhf4npcg
         6TTa/YfA8HxXhfYXKbGbFx2j3AfayKB7LpcohSpH2DqsAKLBUxcDgtw0EB5Qsno7UgLX
         WiUsE5bFbdQ98xO3DwR1UxTeijhxR/7Aujc/3AzCr93rKvffifbdfUZF4iY2b6wOQouE
         5k3RocMwqzbAUi+faRg+u9rWvkwAKJow7Z0JLSFmGHa2RYjob6NeggwSluRZME88K7FR
         BMFjgmM0wo1nnfQ/psmqD6QZEITgUlwU1UEtf+Ft66vQWseDf/mqjtU3F+ke1cR5Ar1E
         LwKg==
X-Gm-Message-State: APjAAAXIAsj144T7MQvzyHm9rDiUiHJ3PqRakdC6MZxsTOcpn4L9CbA8
        KhUxpD45zT6JQ6g/DhRb+YRSMMkgK37q+hND1W33O8iI
X-Google-Smtp-Source: APXvYqwww31tQb1jB12tJb0MnxyLvvzkPEU66FtNNyRUkmX0yPwcHT+RRs6X62l45sC8+jUTNvnXxpxASnDIvkoqJ1Y=
X-Received: by 2002:a1c:5f56:: with SMTP id t83mr18108162wmb.37.1561457860647;
 Tue, 25 Jun 2019 03:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190624082228.27433-1-deepak.ukey@microchip.com> <20190624082228.27433-3-deepak.ukey@microchip.com>
In-Reply-To: <20190624082228.27433-3-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 25 Jun 2019 12:17:29 +0200
Message-ID: <CAMGffEnmoDwGzTWD3=j85NDSnUKJ8adYjciUsk-iY-c6crDbHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pm80xx : Event log size through sysfs.
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
> Added support to read event log size from MPI configuration table
> and export through sysfs.
>
> Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
Thanks, looks fine.
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
