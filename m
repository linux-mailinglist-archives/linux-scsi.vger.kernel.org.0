Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5A41BF8D
	for <lists+linux-scsi@lfdr.de>; Wed, 29 Sep 2021 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbhI2HJR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 Sep 2021 03:09:17 -0400
Received: from verein.lst.de ([213.95.11.211]:54758 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244303AbhI2HJR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 Sep 2021 03:09:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 474126736F; Wed, 29 Sep 2021 09:07:34 +0200 (CEST)
Date:   Wed, 29 Sep 2021 09:07:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: remove ->rq_disk
Message-ID: <20210929070733.GA31869@lst.de>
References: <20210928052211.112801-1-hch@lst.de> <YVMnk/8HIR/yhWYr@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVMnk/8HIR/yhWYr@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Sep 28, 2021 at 10:32:51PM +0800, Ming Lei wrote:
> Hello Christoph,
> 
> On Tue, Sep 28, 2021 at 07:22:06AM +0200, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series removes the rq_disk field in struct request, which isn't
> > needed now that we can get the disk from the request_queue.
> 
> Can we hold on this series until q->disk becomes really reliable[1][2]?

It's not like q->disk isn't reliable.  It is that we don't kill all bios
when tearing down the gendisk, which is an old problem that got worse.

That being said I'm resending this again.
