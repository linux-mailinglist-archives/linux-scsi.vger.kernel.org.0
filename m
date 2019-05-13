Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818EC1BECC
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEMUpo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 16:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfEMUpo (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 13 May 2019 16:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F0E913A82;
        Mon, 13 May 2019 20:45:44 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C08600C6;
        Mon, 13 May 2019 20:45:43 +0000 (UTC)
Message-ID: <ca15a1a0ff4d530d991ea310ecbc885f1588b16e.camel@redhat.com>
Subject: Re: [PATCH] qla2xxx: always allocate qla_tgt_wq
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Date:   Mon, 13 May 2019 16:45:42 -0400
In-Reply-To: <85494ec8-b20a-621e-25f8-cf4a069d7855@acm.org>
References: <20190509131821.87338-1-hare@suse.de>
         <1df9eb38-8ff9-bf21-4a49-4190eea9f2b4@acm.org>
         <aa620cdf3f987107656adab7e4825d3ca583ee09.camel@redhat.com>
         <85494ec8-b20a-621e-25f8-cf4a069d7855@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 13 May 2019 20:45:44 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-05-09 at 15:55 -0700, Bart Van Assche wrote:
> On 5/9/19 11:58 AM, Ewan D. Milne wrote:
> > On Thu, 2019-05-09 at 07:06 -0700, Bart Van Assche wrote:
> > > On 5/9/19 6:18 AM, Hannes Reinecke wrote:
> > > > The 'qla_tgt_wq' workqueue is used for generic command aborts,
> > > > not just target-related functions. So allocate the workqueue
> > > > always to avoid a kernel crash when aborting commands.
> > > 
> > > Can the abort code be called directly? This means not queueing the abort
> > > work? Do you perhaps know why the target workqueue is used for
> > > processing aborts? In other words, can the abort functions be modified
> > > to use one of the system workqueues instead of always allocating the
> > > target workqueue?
> > 
> > How exactly is the qla_tgt_wq used for generic command aborts?
> > Do you mean initiator mode aborts from the SCSI EH calls?  Those look
> > like they issue mailbox commands to the HBA directly.
> > Or do we get frames received even if we are not using target mode or something?
> 
> Hi Ewan,
> 
> To me your questions seem like questions about the original patch. Are
> your questions perhaps intended for Hannes?
> 
> Bart.

Yes, you are correct, sorry I responded to the wrong msg in the thread.

-Ewan

