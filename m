Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60BA191A7
	for <lists+linux-scsi@lfdr.de>; Thu,  9 May 2019 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfEIS6f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 May 2019 14:58:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfEIS6e (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 May 2019 14:58:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 728D23084295;
        Thu,  9 May 2019 18:58:34 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88FD41001E67;
        Thu,  9 May 2019 18:58:33 +0000 (UTC)
Message-ID: <aa620cdf3f987107656adab7e4825d3ca583ee09.camel@redhat.com>
Subject: Re: [PATCH] qla2xxx: always allocate qla_tgt_wq
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Date:   Thu, 09 May 2019 14:58:33 -0400
In-Reply-To: <1df9eb38-8ff9-bf21-4a49-4190eea9f2b4@acm.org>
References: <20190509131821.87338-1-hare@suse.de>
         <1df9eb38-8ff9-bf21-4a49-4190eea9f2b4@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 09 May 2019 18:58:34 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-05-09 at 07:06 -0700, Bart Van Assche wrote:
> On 5/9/19 6:18 AM, Hannes Reinecke wrote:
> > The 'qla_tgt_wq' workqueue is used for generic command aborts,
> > not just target-related functions. So allocate the workqueue
> > always to avoid a kernel crash when aborting commands.
> 
> Hi Hannes,
> 
> Can the abort code be called directly? This means not queueing the abort
> work? Do you perhaps know why the target workqueue is used for
> processing aborts? In other words, can the abort functions be modified
> to use one of the system workqueues instead of always allocating the
> target workqueue?
> 
> Thanks,
> 
> Bart.

How exactly is the qla_tgt_wq used for generic command aborts?
Do you mean initiator mode aborts from the SCSI EH calls?  Those look
like they issue mailbox commands to the HBA directly.
Or do we get frames received even if we are not using target mode or something?

-Ewan

