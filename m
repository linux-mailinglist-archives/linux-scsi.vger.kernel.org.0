Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500D29A228
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Oct 2020 02:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503819AbgJ0BWo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 21:22:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52307 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437035AbgJ0BWn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Oct 2020 21:22:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id c194so17727wme.2
        for <linux-scsi@vger.kernel.org>; Mon, 26 Oct 2020 18:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iIJeX2Fh5ytYIob9dHSaaH2/ylmiguRy29mP6CRcfZs=;
        b=feNTJdGsXTjsVMkZKs9iln2pR4eBAorp3CbBgbvbwtk1DlLjfk9KwaRBwPzdWJ61pz
         7mEcI8f4oc30bQ0NVA1iPE5HQkHODfQyvkrG18GycAip4H/NEm+O69gpTrHhTuCwyBLd
         dIINZrweFqAkGn3WBloEj7u/XBn5HP5+HzaqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iIJeX2Fh5ytYIob9dHSaaH2/ylmiguRy29mP6CRcfZs=;
        b=lKMOrv7SjiTa+yQYl+1ftXYLJECfh7cyaHAicYV/op9Hp1oCH9Q/waRMQA9a0jdmjx
         3nW8CSwmx6egIl+XaTar0nkMqW7yXc2kKbN6pYde89rV6bEr64FprRLbQbaFYTYViexO
         XStPKb6Tg6oL+tHh3GZ0Ehvi1D3ru+66CzJERptwMI7qmmKwzY4qnFRfO2dd3FE4R+9d
         9uq90neB9rg+HqFwq3BbiyPXEZ6mSwbWqnGHpNZ8eRKFgregi6ikj2v/OOfP0uaHfqPg
         4anpoz0qlO831b8UqevDDDxAwDTtZdBAEzwLCVwI2gKPYmaMR15lJtuxldqnOu1IY+LJ
         P3Cw==
X-Gm-Message-State: AOAM531soMGrC9Fa++P2gZG7N/x7FZ5yCIESYizL3vDSAMAihGfUIRAy
        J58SQV5gwxe/87ezfIEUBeoNDLT6gYn5cD9w3hivjg==
X-Google-Smtp-Source: ABdhPJzgOTg9sDSj8N9OjuJdjilCzmNwktb9eWS/su5d41VkIrCCcgtFW3D2Czhyq3JKxI67Wz3PAGi3QBy1O5EWvpQ=
X-Received: by 2002:a1c:6804:: with SMTP id d4mr57273wmc.94.1603761761836;
 Mon, 26 Oct 2020 18:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200930155100.11528-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <yq1d0148xza.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1d0148xza.fsf@ca-mkp.ca.oracle.com>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Tue, 27 Oct 2020 10:22:31 +0900
Message-ID: <CAEYrHjmJRmcKX+F8R_wjd146FXnSHekodauG_eNQBXArE4OBeA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] scsi: hpsa: fix memory leak in hpsa_init_one
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Scott Teel <scott.teel@microsemi.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

Thanks for the review.

> I suggest you submit a fix for just the leak. And then, if the hpsa
> maintainers agree, we can entertain a separate patch to improve the
> naming.

I'll revert the labels to numbered labels and resend the patch.

Thanks,
Keita

2020=E5=B9=B410=E6=9C=8827=E6=97=A5(=E7=81=AB) 6:49 Martin K. Petersen <mar=
tin.petersen@oracle.com>:
>
>
> Keita,
>
> > When hpsa_scsi_add_host fails, h->lastlogicals is leaked since it lacks
> > free in the error handler.
> >
> > Fix this by adding free when hpsa_scsi_add_host fails.
> >
> > This patch also renames the numbered labels to detailed names.
>
> While I am no fan of numbered labels, these initialization stages are
> referenced several other places in the driver. As a result, renaming the
> labels makes the rest of the code harder to follow.
>
> I suggest you submit a fix for just the leak. And then, if the hpsa
> maintainers agree, we can entertain a separate patch to improve the
> naming.
>
> Thank you!
>
> --
> Martin K. Petersen      Oracle Linux Engineering
