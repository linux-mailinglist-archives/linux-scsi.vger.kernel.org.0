Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18B44CBD
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfFMT6u (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 15:58:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35795 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbfFMT6u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Jun 2019 15:58:50 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so715131ioo.2
        for <linux-scsi@vger.kernel.org>; Thu, 13 Jun 2019 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=0g3LShZij9OvLky32ww/mm8nsliTsm7gD3njRd6NCQk=;
        b=VvRUdVRnyB4TuhZ+9+/oPM6pb8vxTclPrmvRFZ9PzavJCtkYfSYgjGNiCUQTux1nUl
         9VjOQatdu+aPOowyvOuIY8hKioFj1wntgGyBXavSkEATXrC/5DcyjhYCe5Ag1uW/q8zp
         fQGdKjxC19RzzJyIAL/Mw4avblUSP65mKGcmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=0g3LShZij9OvLky32ww/mm8nsliTsm7gD3njRd6NCQk=;
        b=DRv71RUFqJj73G7z7wKuYls1Uc52YH23KWkZ4w8/mUYXrY3JQ1QICh3A2jTq43cvLA
         WMNEUfWgx15aoVfnzbKBzDSfIOvmluWOMnxAaoWoaszMSmFGzrkzadwwGhnv81zVogMs
         3Zx0M2wUpGL80yl7o8zycqzDneC0jUC1dE86NpKxE+JjCOYVRlf2iNZaDvZe8XfE2NmJ
         50B8TbMyrmbKkSUGT2twkqVypRRpGqjStx5scHjJBZPY/oeD/GLx42hKDg+22FwXcdu1
         zukowhvTES4f8eG+tBBk9JpmeRn1umyLooJaFxLPrpG68h/3ZSPff61EAvw/8aj0kQRD
         EJGA==
X-Gm-Message-State: APjAAAWCOHGK/nCXeXVZouqHl0dUQ3EYrEX9OsC2zy/+UjPPzW/D7ecP
        9z/eTEJV1TwYj4ijIO9iFqkuYD36Yk+TDHIk9KkBBw==
X-Google-Smtp-Source: APXvYqxdGc8NyPROiaW5qZ3CjU9Mi5BWb0Y5+Ghq0hcByTKiBd2ar5O9a3Vi002QTGCiPnE/Sx2A/4naPXD8YwkquS4=
X-Received: by 2002:a6b:f910:: with SMTP id j16mr7292522iog.256.1560455929090;
 Thu, 13 Jun 2019 12:58:49 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com> <20190608081400.GA19573@lst.de>
In-Reply-To: <20190608081400.GA19573@lst.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQNLjZIO2zMn7N+9xPobnDbFSu4o5gI2RJdJAgF+bYgBfxw4kaN/cE8Q
Date:   Fri, 14 Jun 2019 01:28:47 +0530
Message-ID: <98f6557ae91a7cdfe8069fcf7d788c88@mail.gmail.com>
Subject: RE: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        PDL-MPT-FUSIONLINUX <mpt-fusionlinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>
> On Thu, Jun 06, 2019 at 09:07:27PM +0530, Kashyap Desai wrote:
> > Hi Christoph, Changes for <megaraid_sas> and <mpt3sas> looks good. We
> > want to confirm few sanity before ACK. BTW, what benefit we will see
> > moving virt_boundry setting to SCSI mid layer ? Is it just modular
> > approach OR any functional fix ?
>
> The big difference is that virt_boundary now also changes the
> max_segment_size, and this ensures that this limit is also communicated
to
> the DMA mapping layer.
Is there any changes in API  blk_queue_virt_boundary? I could not find
relevant code which account for this. Can you help ?
Which git repo shall I use for testing ? That way I can confirm, I didn't
miss relevant changes.

From your above explanation, it means (after this patch) max segment size
of the MR controller will be set to 4K.
Earlier it is possible to receive single SGE of 64K datalength (Since max
seg size was 64K), but now the same buffer will reach the driver having 16
SGEs (Each SGE will contain 4K length).
Right ?

Kashyap
