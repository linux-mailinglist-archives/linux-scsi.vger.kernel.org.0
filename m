Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AF82FBED
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfE3NHf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 09:07:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43113 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfE3NHf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 May 2019 09:07:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn7so2538470plb.10
        for <linux-scsi@vger.kernel.org>; Thu, 30 May 2019 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOdVi6fwe9K5mBPmNUI6xWk51mf3nHLJonFE1hrhvMo=;
        b=JglBaoWrFUmdoCOebx43wyCxXFFCDcpRCCZsrxd5TYc1PUbwecwGFICzqe56SKLmE1
         9iJuiBU8aC3GowiVm/zPB3SvPtk0v0O8vQQnTZtduLgzlRTpiBHY8hpU7KMrR1/8ec9v
         JftZmm3I3z0JN5/aA4boqlSO8nFqrhFhgn+Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOdVi6fwe9K5mBPmNUI6xWk51mf3nHLJonFE1hrhvMo=;
        b=S3MtrWn+dEFyMIkKPBKxGi59FrUQ45W6BVs6fpkld66+vSy6TCPVMYYQowoCKM3jcG
         bYuOB8r0SGlnUbiZKjhezLYTV2ZBIjAYmXqwFxTbUCEdCNhmf6arlNmuZnayr+nUiaYP
         lgkcNJlrQwQWhVjpdYE0vXIOXdKsym8F4OWqViBPwUYImqwB0AOJ8wOwafOAMMZYoonP
         EG0oa88ptnqd1Bzqvi1L8Hf3IsFMxukY6cdaWPh0YsBHR4giAaqohQkdLlzt0L/bQ6Ck
         Dg3rL9F1pfPIcN1AjoE0ZQ8HYifqmRsR2iD8IsmmkoaT6eEiK4m8znn1yP4O2ks+WFzD
         DLAg==
X-Gm-Message-State: APjAAAXFNNs4SXoGt34QjAwmxL52hKNA77CkPLnZPwAI5TP9mTopLDk9
        QuZW260yek41V49wc0jw+4GTqyNGFv4LnhQvDnMyYA==
X-Google-Smtp-Source: APXvYqwcEUcT9bHsiacEBp63tEkwYwzAxhK2iASAs4IIiRHV3KTWsU3QaIu7ECGUrggo6blJCqAEse0K5VVdzEQwwSU=
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr3380430pld.276.1559221654744;
 Thu, 30 May 2019 06:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
 <20190520102604.3466-9-suganath-prabu.subramani@broadcom.com> <yq1ftow21l5.fsf@oracle.com>
In-Reply-To: <yq1ftow21l5.fsf@oracle.com>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Thu, 30 May 2019 18:37:22 +0530
Message-ID: <CAK=zhgrq51xU_wYdPWs45Pxbb-2v=7rL0+HA0ZQuyKZ0zyST6Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] mpt3sas: Enable interrupt coalescing on high iops
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 30, 2019 at 6:36 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Suganath,
>
> > This configuration should reset during driver unload or shutdown to
> > the default settings. For this driver takes copy of default ioc page 1
> > and copy backs the default or unmodified ioc page1 during unload and
> > shutdown. so that on next driver load (e.g. if older version driver is
> > loaded by user), current modified changes on ioc page1 won't take
> > effect.
>
> What happens if the system crashes before the old page is put back?

Any changes done on the pages from 'current region' will persist until
HBA firmware is alive. if diag reset happens or cold boot/reboot
occurs then firmware will get reinitialize and it will overwrite
current region pages with NVRAM region pages. So the changes done on
the 'current region' will be erased.

Now when system crashes, kdump utility will trigger a warm reboot into
kdump kernel. when mpt3sas driver getting loaded then it observes that
 HBA is in OPERATIONAL state. So it issues the diag reset to move the
HBA state to READY state and hence the changes made in the 'current
region' will be erased. After memory is dumped into the pre-configured
location, kdump utility will do cold reboot to boot in to standard
kernel. As cold reboot occurs HBA firmware will initialize  from day
one and if any changes done on 'current region' will overwrite with
NVRAM region.

In normal warm reboot case, driver issues the Message Unit Reset (to
move HBA state to READY state) from shutdown callback before going for
reboot operation and hence in this case driver has to copy back the
default settings.

Thanks,
Sreekanth

>
> --
> Martin K. Petersen      Oracle Linux Engineering
