Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C043B40D73F
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhIPKQP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Sep 2021 06:16:15 -0400
Received: from verein.lst.de ([213.95.11.211]:39530 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236458AbhIPKQO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Sep 2021 06:16:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C2A467373; Thu, 16 Sep 2021 12:14:52 +0200 (CEST)
Date:   Thu, 16 Sep 2021 12:14:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] scsi: core: cleanup request queue before releasing
 gendisk
Message-ID: <20210916101451.GA26782@lst.de>
References: <20210915092547.990285-1-ming.lei@redhat.com> <20210915134008.GA13933@lst.de> <YUKfl9Qqsluh+5FX@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUKfl9Qqsluh+5FX@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Sep 16, 2021 at 09:36:23AM +0800, Ming Lei wrote:
> >From correctness viewpoint, we need to call blk_cleanup_queue
> before releasing gendisk and after del_gendisk(). Now you have invented
> blk_cleanup_disk(), do you plan to do the three in one helper? :-)

No.  In retrospective blk_cleanup_disk wan't the best idea for a few
reasons.  But at least it consolidated some of the code.

> We don't have to put del_gendisk & blk_cleanup_queue together,

I don't want all of it together.  The important thing is that we have
two different concepts:

 - the gendisk is required to do file system style I/O
 - a standalone request_queue can be used for passthrough I/O.

> and it may cause other trouble at least for scsi disk since sd_shutdown()
> follows del_gendisk() and has to be called before blk_cleanup_queue().

Yes.  So we need to move the bits of blk_cleanup_queue that deal with
the file system I/O state to del_gendisk, and keep blk_cleanup_queue
for anything actually needed for the low-level queue.

To take SCSI as the example.  We can unload the sd/sr drivers and the
queue needs to still be around and work for use with the sg driver.

> BTW, you asked the reproducer of the issue, I just observed the issue
> one or two time when running blktests block/009, but my scsi lifetime
> bpftrace script does show that gendisk is released before blk_cleanup_queue().

Interesting.  What were the symptoms in this case?
