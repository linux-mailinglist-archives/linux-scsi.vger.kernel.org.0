Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E629B388A8F
	for <lists+linux-scsi@lfdr.de>; Wed, 19 May 2021 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbhESJXJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 May 2021 05:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344887AbhESJWo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 May 2021 05:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621416085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7Sstcm/XS+sd5snufYPwZMEgEGKfXoYui6wco+MXec=;
        b=S4bDdxwd4Qk/wgsxPDE34E2sicL/VrVsliLwUb59Ydjx+Zu6c1uqLD3r64d71wD4WJ5bQF
        kdBTSzUpr6uMzaqGINfl9u6n8rN8QLU9y0gIx/7pZ2Jq+RYp+XEAdTsKOwQyNDUtYRG3o/
        EFGx6hSv59dPeQYKc+Jk/8lRVKZyc7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-L7JyPNgvOaqVDUZlgDT4Hg-1; Wed, 19 May 2021 05:21:21 -0400
X-MC-Unique: L7JyPNgvOaqVDUZlgDT4Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757E2107ACCA;
        Wed, 19 May 2021 09:21:19 +0000 (UTC)
Received: from T590 (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 253401037EA6;
        Wed, 19 May 2021 09:21:09 +0000 (UTC)
Date:   Wed, 19 May 2021 17:21:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/8] block: split __blkdev_get
Message-ID: <YKTYgaL4nAej+jeY@T590>
References: <20210512061856.47075-1-hch@lst.de>
 <20210512061856.47075-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512061856.47075-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 12, 2021 at 08:18:49AM +0200, Christoph Hellwig wrote:
> Split __blkdev_get into one helper for the whole device, and one for
> opening partitions.  This removes the (bounded) recursion when opening
> a partition.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice cleanup, now the blkdev get code becomes more readable than before:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

