Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504C650AE7
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 14:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfFXMk3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 08:40:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfFXMk3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 08:40:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so13708045wrl.11;
        Mon, 24 Jun 2019 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnvjlQhC/7Et11abmkpDCqQIB2gjhtQScdpEp4BPRAk=;
        b=IJwRiOMjSX/w5BWgGlZQZ9bO90jdc0+KM32ORdrRTsrLD4JapA4h+HBSPgOzE2qqe6
         rjOcgVPUk6100JIWkFmgBq1YE43D+bmy5H29HOmj0A6kR4tNNyE/gN9o9MMCDGMFjY7Y
         00eLm0HLt7VZ1FzPAJS45gtqgwB+c1sHOiN2pgEJc6/m3Px5oTiOMT0PooiKOUXEVINY
         2IzqjgpYcmL9xJ6bvC5rAQQ3jsuZSwdB5gEYGupQeSUoRt++PVMNrNg155zKLsxeKhWN
         EdoWXhRu718+gHnmGznw7LK+N2Eq6KEdoyP373WaoqJ+tvbux4pOZNueekR23kR7NHwg
         khTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnvjlQhC/7Et11abmkpDCqQIB2gjhtQScdpEp4BPRAk=;
        b=H9LS52O8Rtlfxdm3C/2gNbEid036D3Fw+L0Hqpze0s3DootMuq0MzSIGmKSZbic1yz
         Z9q403xQSeC78xzpV5h+onaDc8ptOPrwKZrJcAvDQ9cmi63cFkTbwcfeprkqmd96z1o0
         7sfft36jFowzYenBSSQJQtFS+zVQodOG2sHEHhGmVoXBfHANczNv/j7P5/hqOj5mu8n5
         vFV1HmtdP/515rUSQpcku8tAl3l33KF9XYt86KCY0ZnfnIgdPAOJrqvs+AKxCTH2mr3d
         5Z+1qktB862fy+dIZgYJ2EJByZ9PjKKK7RlOPufvvtuhP/anly+9xjtiaEN7Y7bo6qG2
         3WYg==
X-Gm-Message-State: APjAAAXljaK0BrffOKpaj8+yc877sg3Z94Zt7wRh7/4UyT6xABVIHm/y
        7Xke5Dg6KfAreVeu9AJyan1HSiMMctf36fN9Y0c=
X-Google-Smtp-Source: APXvYqzaqzwih3tQFkvlRDCwHwFzZ6erk2/fNTqHXRJcb+ekQD6iTm9/Z1RQTcchouCyONjVxR78nifgjxj/BHbCyBg=
X-Received: by 2002:adf:b1ce:: with SMTP id r14mr47843265wra.0.1561380026930;
 Mon, 24 Jun 2019 05:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190618013757.22401-1-ming.lei@redhat.com> <yq11rzqzacx.fsf@oracle.com>
 <3df71d64-78fb-c6fc-f456-a0b626abff3b@acm.org> <yq1wohhs62v.fsf@oracle.com>
In-Reply-To: <yq1wohhs62v.fsf@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 24 Jun 2019 20:40:15 +0800
Message-ID: <CACVXFVM2ZiSwqy9QpE2A2VDWY5-dny-H=Lw2J0bEh7zuA5aj5Q@mail.gmail.com>
Subject: Re: [PATCH V5 00/16] use sg helper to operate scatterlist
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

On Thu, Jun 20, 2019 at 3:57 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Bart,
>
> > Do you perhaps plan to push out these patches at a later time? It
> > seems like that branch has not been updated recently:
>
> I had a test failure on this end, that's why I didn't push. Appears to
> be hardware-related, though. Still looking into it.

Today I found the whole patchset disappears from 5.3/scsi-queue, seems
something is wrong?


Thanks,
Ming Lei
