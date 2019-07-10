Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C1646E2
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jul 2019 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfGJNWL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jul 2019 09:22:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42711 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNWL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Jul 2019 09:22:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id a10so2444112wrp.9
        for <linux-scsi@vger.kernel.org>; Wed, 10 Jul 2019 06:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iuCuePR1Hu7EgnZWVvGENfWaqsk17G7vC4PclLSX4FU=;
        b=emAfHO/5J/fj+ibbMe9RY6mRAE6Rif/6Mm/RyvEmo7WRwz8LzoF+zvl0xeX4/EZwVs
         ZSds5GDyd73K4n15pGghz0OiLrby8xMhhRB3FWlnOjVr8lDVcrUGnXF1LHMRkiE+YvPX
         4rF7cF5YE6x1qEo11TmDAt6ADReEfFPW0SHf1xq9nPQnhA+qSPTOJH4s466lBXZhBuX1
         ovt6BY4wc9zzXlqD116GsLNTy6uSvPLCf6/GZ0R3S0cHIZ63kkG3bhnV8WevdLosRnZE
         /of4px1Gyxzo1ILwwKBjl+ncKcqvcbYGQwsTdrXvGs24ihKmG9FQa+CTY8O+jvx1pDM8
         1DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iuCuePR1Hu7EgnZWVvGENfWaqsk17G7vC4PclLSX4FU=;
        b=W5OA9UPCbmmLq8LZp7v3qDnD1M8oJBzFqRuPWxC5flM0BP3pyuVf/jsT9gmSOiO5fX
         z1MCKeNTChc95K9qJGE2vwD0uztDU23kBI7QU05yw+XElCThx7Gg2nrbiiomPp7+rUbC
         219MaUq748ic/ekq47oPEyPRSzr2smv2p8Nq6mhzJC7QC7HaiOqlYnygTKColzvPX3XD
         r3sHdNZoYIC72u4pXmcCk5Mxv9pytBgMemRUqoA6ShADilDt+LvpYNr/1B/2gEWgzBwy
         6J/QWbwx49fbjt4ogaFTCVGk/keHdJq1UaqfPepLH+y5nOKbUHKpjw0cfRMILyiQ10qa
         adrA==
X-Gm-Message-State: APjAAAXeqRgG1/rBGZYOBB79m4eEhUtiwDpxr8ZGgrC4t7/CWAOx4e5r
        ghdklzITYJuQQmGqM9JjbkcbDSUDumlN6Zy5hK4GKpemVb8=
X-Google-Smtp-Source: APXvYqzFd163g0WrFppDIN2YqJDvTQPbR9WWhUGoiMoHhU2OProDoAD7jnH/nrtGGPMHpIi1rYBd1uugiYlxY1oi5YI=
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr33131509wrq.202.1562764929657;
 Wed, 10 Jul 2019 06:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190709100050.6947-1-deepak.ukey@microchip.com> <20190709100050.6947-2-deepak.ukey@microchip.com>
In-Reply-To: <20190709100050.6947-2-deepak.ukey@microchip.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 10 Jul 2019 15:21:58 +0200
Message-ID: <CAMGffEkOAqv=+3hTObkNX5t5qn90Zdw33QxFcOMS61ziFMqfzQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] pm80xx : Fixed kernel panic during error recovery
 for SATA drive.
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Vasanthalakshmi.Tharmarajan@microchip.com, Viswas.G@microchip.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jul 9, 2019 at 12:00 PM Deepak Ukey <deepak.ukey@microchip.com> wrote:
>
> Disabling the SATA drive interface cause kernel panic. When the drive
> Interface is disabled, device should be deregistered after aborting
> all pending IO's. Also changed the port recovery timeout to 10000 ms
> for PM8006 controller.
>
>         V2:
>                 -Acquired spin lock after aborting all requests.
>
> Signed-off-by: Deepak Ukey <deepak.ukey@microchip.com>
> Signed-off-by: Viswas G <Viswas.G@microchip.com>
There other 2 patches already picked up by Martin.

This new version looks fine. Thanks, Deepak.
Reviewed-by:  Jack Wang <jinpu.wang@cloud.ionos.com>
