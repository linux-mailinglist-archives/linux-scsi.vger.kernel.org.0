Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A5373A1
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfFFL5b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 07:57:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54034 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfFFL5b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 07:57:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so1492716wmj.3
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VvMAoYB96Ne6gNiw7p4GFcBlSUcy3tQ2OsEurFpYOpk=;
        b=GdLHRxhx1Eu+J3NK1DpIviyVH+JsheaELn3+MZJvUpurQ7ZbpnhuXpC98K777RsjtZ
         Ur0j4Bq8CVjlMS01NwZh+H91f9E6zGSmWvoOhDoE6UZ5w/HSwnwM9yKARE9w96fkBwjD
         M7QoOMIYuwT23+B/IzP2d22c2QtofMPh61bSS3AEXKDZJgHwtO/mo5BRHDStfYb5F+8Y
         xxYCNpLUck7plVgsMT0yAVLkh704eDLhMqpNJRxofjGuniSOhR1RspZPAGN5+vD8NAhE
         gajHo5nNnB4NS/LLe5CDX989n5WFdK31oJuJaK4s5mjlJZUzxUR/qIiU7zj07bvp5ufw
         SCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VvMAoYB96Ne6gNiw7p4GFcBlSUcy3tQ2OsEurFpYOpk=;
        b=dkDP5wESiOoQtrK4nLDpgIgpk0RV/QDoA6MXwt+Yyxn6bH83a1gK4t/qpYyFHWjsFP
         lki2dwpxrMcH7+FtFJ+iP3imZQAeiwjNYoF2RzeHbXpSGYPOZjO+W/WJYfAiNx1/7/lH
         zbTJLY3IrK4WQlCfkMoK/RUSrVpFONszPQsX1sR9c+7WsBUgaWXZiILusqn9AbOt9ayW
         bSW18+eMT+QcUHQ0Uc5beSH4WqwSBVd1sQG45b5Y2V4Yl8mEp0ZGXtnCbY/xAAJQFh4G
         Y8o0SGHbwSATbIXvCUujGRQNVD+vsC1yXmDVeFJsG4EntHx3mdKoRMxSakdUFhUX+cqp
         4PJg==
X-Gm-Message-State: APjAAAXKty4kIjCd8wcpx7dIDoY3z8UXzQR+yKkt2dZ1m86hz+w+MpIp
        HLId0kknTw5gOOGsz+cmdeLhfBEqqDCHNYkK5G7vzw==
X-Google-Smtp-Source: APXvYqyIYIhNq+jLA2tljFH0wmKipdNhIUGNWVtC+4lfUpeq8DUgGzbXumkypig2mMkTG/JN0tYfjKDoyp2nwimAn8c=
X-Received: by 2002:a1c:c915:: with SMTP id f21mr24578674wmb.123.1559822249364;
 Thu, 06 Jun 2019 04:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <1559751143-168560-1-git-send-email-john.garry@huawei.com> <e8ad370e-6528-2ab1-5001-ab3fa4dc5ae8@huawei.com>
In-Reply-To: <e8ad370e-6528-2ab1-5001-ab3fa4dc5ae8@huawei.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 6 Jun 2019 13:57:18 +0200
Message-ID: <CAMGffEnFWGdAYEr4mvTKfeDR4xRQwQneeDjaDSaj3gmGHY=i3Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: libsas, lldds: Use dev_is_expander()
To:     Jason Yan <yanaijie@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
        Jack Wang <jinpu.wang@profitbricks.com>,
        lindar_liu <lindar_liu@usish.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 6, 2019 at 3:35 AM Jason Yan <yanaijie@huawei.com> wrote:
>
>
>
> On 2019/6/6 0:12, John Garry wrote:
> > Many times in libsas, and in LLDDs which use libsas, the check for an
> > expander device is re-implemented or open coded.
> >
> > Use dev_is_expander() instead. We rename this from
> > sas_dev_type_is_expander() to not spill so many lines in referencing.
> >
> > Signed-off-by: John Garry<john.garry@huawei.com>
>
> Cannot agree more=EF=BC=8C
>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
>
Looks good, thanks Jason!

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
