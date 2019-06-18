Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB54A0A4
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfFRMTt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 08:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRMTs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Jun 2019 08:19:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61E723092677;
        Tue, 18 Jun 2019 12:19:48 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC41462926;
        Tue, 18 Jun 2019 12:19:46 +0000 (UTC)
Message-ID: <19b22c14d7864df5c7f79934a4e1cd39934325b7.camel@redhat.com>
Subject: Re: [PATCH 1/3] qla2xxx: Fix kernel crash after disconnecting NVMe
 devices
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
Date:   Tue, 18 Jun 2019 08:19:46 -0400
In-Reply-To: <271857f5-e4c0-4e1c-2555-57aebcc6dd3e@suse.de>
References: <20190614221020.19173-1-hmadhani@marvell.com>
         <20190614221020.19173-2-hmadhani@marvell.com>
         <271857f5-e4c0-4e1c-2555-57aebcc6dd3e@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 12:19:48 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-06-18 at 12:51 +0200, Hannes Reinecke wrote:
> On 6/15/19 12:10 AM, Himanshu Madhani wrote:
> > From: Arun Easi <aeasi@marvell.com>
> > 
> > BUG: unable to handle kernel NULL pointer dereference at           (null)
> > IP: [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> > PGD 800000084cf41067 PUD 84d288067 PMD 0
> > Oops: 0000 [#1] SMP
> > Call Trace:
> >  [<ffffffff98abcfdf>] process_one_work+0x17f/0x440
> >  [<ffffffff98abdca6>] worker_thread+0x126/0x3c0
> >  [<ffffffff98abdb80>] ? manage_workers.isra.26+0x2a0/0x2a0
> >  [<ffffffff98ac4f81>] kthread+0xd1/0xe0
> >  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> >  [<ffffffff9918ad37>] ret_from_fork_nospec_begin+0x21/0x21
> >  [<ffffffff98ac4eb0>] ? insert_kthread_work+0x40/0x40
> > RIP  [<ffffffffc050d10c>] qla_nvme_unregister_remote_port+0x6c/0xf0 [qla2xxx]
> > 
> > The crash is due to a bad entry in the nvme_rport_list. This list is not
> > protected, and when a remoteport_delete callback is called, driver
> > traverses the list and crashes.
> > 
> > Actually, the list could be removed and driver could traverse the main
> > fcport list instead. Fix does exactly that.
> > 
> > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> > ---
> >  drivers/scsi/qla2xxx/qla_def.h  |  1 -
> >  drivers/scsi/qla2xxx/qla_nvme.c | 52 ++++++++++++++++++++---------------------
> >  drivers/scsi/qla2xxx/qla_nvme.h |  1 -
> >  drivers/scsi/qla2xxx/qla_os.c   |  1 -
> >  4 files changed, 25 insertions(+), 30 deletions(-)
> > 
> 
> [ .. ]
> > diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
> > index d3b8a6440113..2d088add7011 100644
> > --- a/drivers/scsi/qla2xxx/qla_nvme.h
> > +++ b/drivers/scsi/qla2xxx/qla_nvme.h
> > @@ -37,7 +37,6 @@ struct nvme_private {
> >  };
> >  
> >  struct qla_nvme_rport {
> > -	struct list_head list;
> >  	struct fc_port *fcport;
> >  };
> >  
> 
> Where is the point of this structure now?
> Please drop it, and use fc_port directly.

I thought about mentioning that, but nvme_fc_remote_port's
->private field is allocated by .remote_priv_sz in the call to
nvme_fc_register_remoteport(), so I don't see a clean way to
just set ->private to the fc_port.

And, if a driver-specific field needs to be added later, it
would all have to be put back.

-Ewan

> 
> Cheers,
> 
> Hannes
