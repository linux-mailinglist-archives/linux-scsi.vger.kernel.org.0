Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C576675A
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfGLHBD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Jul 2019 03:01:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbfGLHBD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Jul 2019 03:01:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F03FAFF3;
        Fri, 12 Jul 2019 07:01:02 +0000 (UTC)
Message-ID: <8aaff38833d8105782caf3e98e1c6e1855b35bdf.camel@suse.de>
Subject: Re: [PATCH] qla2xxx: always allocate qla_tgt_wq
From:   Martin Wilck <mwilck@suse.de>
To:     "Ewan D. Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Tran,Quinn" <Quinn.Tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@marvell.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     James Bottomley <james.bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org
Date:   Fri, 12 Jul 2019 09:01:01 +0200
In-Reply-To: <aa620cdf3f987107656adab7e4825d3ca583ee09.camel@redhat.com>
References: <20190509131821.87338-1-hare@suse.de>
         <1df9eb38-8ff9-bf21-4a49-4190eea9f2b4@acm.org>
         <aa620cdf3f987107656adab7e4825d3ca583ee09.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-05-09 at 14:58 -0400,  Ewan D. Milne wrote:
> On Thu, 2019-05-09 at 07:06 -0700, Bart Van Assche wrote:
> > On 5/9/19 6:18 AM, Hannes Reinecke wrote:
> > > The 'qla_tgt_wq' workqueue is used for generic command aborts,
> > > not just target-related functions. So allocate the workqueue
> > > always to avoid a kernel crash when aborting commands.
> > 
> > Hi Hannes,
> > 
> > Can the abort code be called directly? This means not queueing the
> > abort
> > work? Do you perhaps know why the target workqueue is used for
> > processing aborts? In other words, can the abort functions be
> > modified
> > to use one of the system workqueues instead of always allocating
> > the
> > target workqueue?
> > 
> > Thanks,
> > 
> > Bart.
> 
> How exactly is the qla_tgt_wq used for generic command aborts?
> Do you mean initiator mode aborts from the SCSI EH calls?  Those look
> like they issue mailbox commands to the HBA directly.
> Or do we get frames received even if we are not using target mode or
> something?

Sorry for jumping late onto this thread.

The code in question has been introduced by 2f424b9b36ad "qla2xxx: Move
atioq to a different lock to reduce lock contention", with the purpose
to "ensure that the ATIO queue is empty", for certain controller types,
if a ABTS_RECV_24XX element is encountered on the response queue.

Maybe Quinn or Himanshu can shed light on the question under which
conditions this would happen.

Martin


