Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E532FBFB
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 15:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfE3NJG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 09:09:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46938 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3NJG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 May 2019 09:09:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so3913454pfm.13
        for <linux-scsi@vger.kernel.org>; Thu, 30 May 2019 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKVy6+bOkoWZvH8HSwjy5Gzy0e/rDTP85W29F2K7oMQ=;
        b=UQCf1Ml14nWpznUDcpVjxnZyRB5iCTwUcDJtowgIKxuuH731SQ1qkJ92eZ9Pq3Oqg8
         QBQ8t6v7+uBcnfWuJSFwTptD08bGRtH8G0PjgV9rQXdCigrPATDPbOgk2IMAWe041LPs
         2CB/gnq4yqqmfYCXvPVYJikhewzwM9Z02F2fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKVy6+bOkoWZvH8HSwjy5Gzy0e/rDTP85W29F2K7oMQ=;
        b=bU5ZFj7b4bYslFIUksGpsC67CW4KOgLpAKbyxWHWU+Lg8opTsbqGZn6Yk4ML/hZC5I
         VsW3BPW18HQ2jc6/gTOss4R5NYXMqurgsm2DgiU5O/aOGzuOMVS6mvoZDdcOA5oTs4zG
         OF598tl4epWe/n4IJ3V8WhoKJEmptlZ3m/UUBaRJumefS7yzOasunp8uKjsfVAaQbrnZ
         ey9vzWMFqOYvLMvt/bUCngh8PJI22gBaZKvP3PC6KLs7ScojuC8IFEMQBjia1LLDRhAB
         qzR46NwV04Fg5dXSoJ3SCExs160+RVJyI2kHw0MgMiyKtWVdtecmoqOifuBO8WGYn+rE
         pT2Q==
X-Gm-Message-State: APjAAAVZbnc5te9u1Mrr1oShoL1xpd3YZlntk7cMxLgYM2z/GncC/Ogd
        c7VWpDtnU/loTrbt1Z+q9LIbqmfAgEs/WM1hDgJ9PQ==
X-Google-Smtp-Source: APXvYqx619odIILRP7LgRc8KQdn/tpJiJ53PszwSNZQOUPU1PcFbFvZrsBFJ72xOGbmJzazuPThKDfvCN1giHO/tDLk=
X-Received: by 2002:a63:f64e:: with SMTP id u14mr1188704pgj.107.1559221745822;
 Thu, 30 May 2019 06:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
 <20190520102604.3466-7-suganath-prabu.subramani@broadcom.com> <yq1k1e821n3.fsf@oracle.com>
In-Reply-To: <yq1k1e821n3.fsf@oracle.com>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Thu, 30 May 2019 18:38:54 +0530
Message-ID: <CAK=zhgo_-toSCcqs4SYJZAuQ4TC99FaO66dbeF3FvbB2L12kmw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mpt3sas:save msix index and use same while
 posting RD
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 30, 2019 at 6:34 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Suganath,
>
> > +static u8
> > +_base_set_and_get_msix_index(struct MPT3SAS_ADAPTER *ioc, u16 smid)
> > +{
> > +     struct scsiio_tracker *st;
> > +
> > +     st = (smid < ioc->hi_priority_smid) ?
> > +             (_get_st_from_smid(ioc, smid)) : (NULL);
>
> Please make this an if statement for clarity.

Agreed. We will post patches again with this change.

Thanks,
Sreekanth

>
> > +
> > +     if (st == NULL)
> > +             return  _base_get_msix_index(ioc, NULL);
> > +
> > +     st->msix_io = ioc->get_msix_index_for_smlio(ioc, st->scmd);
> > +     return st->msix_io;
> > +}
>
> --
> Martin K. Petersen      Oracle Linux Engineering
