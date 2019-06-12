Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77392419FF
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 03:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407442AbfFLBj5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Jun 2019 21:39:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405937AbfFLBj5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 Jun 2019 21:39:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 322DE3084242;
        Wed, 12 Jun 2019 01:39:49 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51C2019C70;
        Wed, 12 Jun 2019 01:39:35 +0000 (UTC)
Date:   Wed, 12 Jun 2019 09:39:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
Message-ID: <20190612013930.GC17522@ming.t460p>
References: <20190610150317.29546-1-ming.lei@redhat.com>
 <20190610150317.29546-3-ming.lei@redhat.com>
 <1560191829.3698.8.camel@HansenPartnership.com>
 <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
 <1560207747.3698.30.camel@HansenPartnership.com>
 <20190611002856.GA32621@ming.t460p>
 <yq1k1drfzrq.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1k1drfzrq.fsf@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 12 Jun 2019 01:39:57 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

On Tue, Jun 11, 2019 at 07:50:01PM -0400, Martin K. Petersen wrote:
> 
> Ming,
> 
> > 1) revert the 3 first, then re-organize the whole patchset in correct
> > order(convert drivers first, then the 3 above drivers)
> >
> > 2) simply apply the 5 patches now
> >
> > Any comments?
> 
> I'm on the fence about this. Your patches were some of the first ones
> that went into the 5.3 tree. So I'd have to rebase pretty much the whole
> 5.3 queue.
> 
> Whereas merging your updates leaves a sequence of 100+ commits that
> could lead to bisection problems in the future. I'm particularly worried
> about ipr and lpfc but all these drivers are actively used.

The issue has been introduced, and people has complained, so I think we
have to do something.

> 
> As much as I like to see all drivers, without exception, use the sg
> iterators, it would have been nice to have a smoother transition.

All the 5 drivers are found via static code analysis by eyes, and not see
other ways for looking at this issue. That said it is quite hard to prove
'all drivers, without exception, use the sg iterators'.

Even though some of them is missed, it should have been triggered
easily if drivers are actively used, then it can be fixed easily too.

Thanks,
Ming
