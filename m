Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3303FFB6C
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Sep 2021 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347597AbhICIAR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Sep 2021 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhICIAR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Sep 2021 04:00:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CDC061575;
        Fri,  3 Sep 2021 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=quE3z4xC195VtvSPtHx4IVlWpjfXNxo5cVGhrWgtGhA=; b=bLHr+KMkw/ZxeQLvQXrOallvZ2
        RdnoqBQe9yzJOg0DzvIYPWKnmBQh7Gzafji0+3Axmze3gmsPP3gpg2Ef6urXBfSiv1VpjqqMs0V4g
        QNh25dDfz6phJcDefu1NGDOixoKze1wHtATiGEabPTYxa2OrFXV1aYWw70xsiZ53rBwxqdg+O3eQO
        LbQ6WrqMU0lUExdOfw2pKmeM/NHt/G09gdYDKNQyxDZpvIeZev1gYv5onXXdZnClkb54ILTErR+UF
        SH6BF0Esp7GRCDGEibKBvSMaA8IsTLBRKFyW7xjmL41xeO49kaRcVUDkzoJ8kFGpH+Yt6mw4ndVWu
        YvH68rxA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mM44R-004GLf-FA; Fri, 03 Sep 2021 07:57:27 +0000
Date:   Fri, 3 Sep 2021 08:57:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.14+ merge window
Message-ID: <YTHVUxc5xZzr77er@infradead.org>
References: <fc14fbbf0d7c27b7356bc6271ba2a5599d46af58.camel@HansenPartnership.com>
 <CAHk-=wi99u+xj93-pLG0Na7SZmjvWg6n60Pq9Wt9PgO6=exdUA@mail.gmail.com>
 <26c12f13870a2276f41aebfea6e467d576f70860.camel@HansenPartnership.com>
 <YTGkLhfYWcvj4YRn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTGkLhfYWcvj4YRn@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Sep 03, 2021 at 05:27:26AM +0100, Christoph Hellwig wrote:
> On Thu, Sep 02, 2021 at 04:23:43PM -0700, James Bottomley wrote:
> > > 
> > > Just checking that was fine, and I notice how *many* places do that.
> > > 
> > > Should the blk_execute_rq() function even take that "struct gendisk
> > > *bd_disk" argument at all?
> 
> No, it shouldn't.  rq->rq_disk should go away and use rq->q->disk
> instead.  This has been on my TODO list, but didn't make the cut for
> this merge window.

Here is a quick draft of that:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-remove-rq_disk


