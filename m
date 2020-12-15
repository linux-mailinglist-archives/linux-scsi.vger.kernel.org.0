Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504422DACB2
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Dec 2020 13:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgLOMFx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Dec 2020 07:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728974AbgLOMFp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 15 Dec 2020 07:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608033859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMM7E9TuXF5eeNr/08yqebR2Dt2ctyis2zH1H/npDvk=;
        b=Auq/MJBbaQY4p0cKbU4wJjc1Oz193XkbYEdYkSFNNrqmYIo4S58v46mZ1l0Bs8p2YwNX2a
        PL4voJyDm5qduFUHAlyHLoxQh5YwZoU+2/ezm55pSfhOK9bxMVhSHIZPLS4UMpODDjQhJz
        AOGw0GPKwzWJvDZnpqSsRDAORv+dhTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-YS-IJu5KMfS3eRNExERwJw-1; Tue, 15 Dec 2020 07:04:16 -0500
X-MC-Unique: YS-IJu5KMfS3eRNExERwJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 551CF180A096;
        Tue, 15 Dec 2020 12:04:14 +0000 (UTC)
Received: from T590 (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40F5019C44;
        Tue, 15 Dec 2020 12:04:01 +0000 (UTC)
Date:   Tue, 15 Dec 2020 20:03:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 0/6] no-copy bvec
Message-ID: <20201215120357.GA1798021@T590>
References: <cover.1607976425.git.asml.silence@gmail.com>
 <20201215014114.GA1777020@T590>
 <103235c1-e7d0-0b55-65d0-013d1a09304e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103235c1-e7d0-0b55-65d0-013d1a09304e@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Dec 15, 2020 at 11:14:20AM +0000, Pavel Begunkov wrote:
> On 15/12/2020 01:41, Ming Lei wrote:
> > On Tue, Dec 15, 2020 at 12:20:19AM +0000, Pavel Begunkov wrote:
> >> Instead of creating a full copy of iter->bvec into bio in direct I/O,
> >> the patchset makes use of the one provided. It changes semantics and
> >> obliges users of asynchronous kiocb to track bvec lifetime, and [1/6]
> >> converts the only place that doesn't.
> > 
> > Just think of one corner case: iov_iter(BVEC) may pass bvec table with zero
> > length bvec, which may not be supported by block layer or driver, so
> > this patchset has to address this case first.
> 
> The easiest for me would be to fallback to copy if there are zero bvecs,
> e.g. finding such during iov_iter_alignment(), but do we know from where
> zero bvecs can came? As it's internals we may want to forbid them if
> there is not too much hassle.

You may find clue from the following link:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2262077.html


Thanks,
Ming

