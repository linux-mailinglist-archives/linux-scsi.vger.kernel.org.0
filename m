Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6441A5F
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 04:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406365AbfFLC1g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Jun 2019 22:27:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60102 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405046AbfFLC1g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 Jun 2019 22:27:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 572DB8EE170;
        Tue, 11 Jun 2019 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560306455;
        bh=lt/GsxG5KxOYOwF6bURvZlmyKmTvL7xcHotR7D0zn/8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Az+8V31y260XgV/yGiQbG6z3rcVKP/CFbuNTpTzpbNzxGEJlgsUfINmZJzmK3mBgc
         2U+pZlp9z7oWEj7X+qCXJIQbdsBLrvpjQ8ZWue/beBBSO1Og8fLkudP9ja8Snph/Kq
         AgxxBKeb66AEeAb5CEE9hhJmYln27pqKpIVzhJ4o=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hYI9bJhsLIxY; Tue, 11 Jun 2019 19:27:35 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AE2408EE134;
        Tue, 11 Jun 2019 19:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560306455;
        bh=lt/GsxG5KxOYOwF6bURvZlmyKmTvL7xcHotR7D0zn/8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Az+8V31y260XgV/yGiQbG6z3rcVKP/CFbuNTpTzpbNzxGEJlgsUfINmZJzmK3mBgc
         2U+pZlp9z7oWEj7X+qCXJIQbdsBLrvpjQ8ZWue/beBBSO1Og8fLkudP9ja8Snph/Kq
         AgxxBKeb66AEeAb5CEE9hhJmYln27pqKpIVzhJ4o=
Message-ID: <1560306453.20425.19.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Date:   Tue, 11 Jun 2019 19:27:33 -0700
In-Reply-To: <20190612013930.GC17522@ming.t460p>
References: <20190610150317.29546-1-ming.lei@redhat.com>
         <20190610150317.29546-3-ming.lei@redhat.com>
         <1560191829.3698.8.camel@HansenPartnership.com>
         <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
         <1560207747.3698.30.camel@HansenPartnership.com>
         <20190611002856.GA32621@ming.t460p> <yq1k1drfzrq.fsf@oracle.com>
         <20190612013930.GC17522@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2019-06-12 at 09:39 +0800, Ming Lei wrote:
> Hi Martin,
> 
> On Tue, Jun 11, 2019 at 07:50:01PM -0400, Martin K. Petersen wrote:
> > 
> > Ming,
> > 
> > > 1) revert the 3 first, then re-organize the whole patchset in
> > > correct order(convert drivers first, then the 3 above drivers)
> > > 
> > > 2) simply apply the 5 patches now
> > > 
> > > Any comments?
> > 
> > I'm on the fence about this. Your patches were some of the first
> > ones that went into the 5.3 tree. So I'd have to rebase pretty much
> > the whole 5.3 queue.
> > 
> > Whereas merging your updates leaves a sequence of 100+ commits that
> > could lead to bisection problems in the future. I'm particularly
> > worried about ipr and lpfc but all these drivers are actively used.
> 
> The issue has been introduced, and people has complained, so I think
> we have to do something.

Studying the issue further, I think we have to do the rebase.  The
problem is that any driver which hasn't been updated can be persuaded
to walk of the end of the request and dereference the next struct
request.  It's not impossible for userspace to set up both requests, so
it looks like this could be used at least to leak information from the
kernel if not exploit it outright.  I think that means we have to have
every driver updated before this goes in.

> > As much as I like to see all drivers, without exception, use the sg
> > iterators, it would have been nice to have a smoother transition.
> 
> All the 5 drivers are found via static code analysis by eyes, and not
> see other ways for looking at this issue.

Can't coccinelle be persuaded?  All we're looking for is a semantic
search where we have a struct scatterlist that is either incremented or
indexed.

That said, it looks like the microtek scanner is yet another driver
that needs updating.

James


>  That said it is quite hard to prove 'all drivers, without exception,
> use the sg iterators'.
> 
> Even though some of them is missed, it should have been triggered
> easily if drivers are actively used, then it can be fixed easily too.


