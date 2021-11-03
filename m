Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346A644452E
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Nov 2021 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhKCQF1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Nov 2021 12:05:27 -0400
Received: from verein.lst.de ([213.95.11.211]:59983 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232680AbhKCQFY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 3 Nov 2021 12:05:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B962E68AA6; Wed,  3 Nov 2021 17:02:43 +0100 (CET)
Date:   Wed, 3 Nov 2021 17:02:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, penguin-kernel@i-love.sakura.ne.jp,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com, efremov@linux.com,
        song@kernel.org, martin.petersen@oracle.com, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org,
        linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] nvdimm/btt: do not call del_gendisk() if not
 needed
Message-ID: <20211103160243.GA31562@lst.de>
References: <20211103122157.1215783-1-mcgrof@kernel.org> <20211103122157.1215783-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103122157.1215783-2-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Nov 03, 2021 at 05:21:45AM -0700, Luis Chamberlain wrote:
> del_gendisk() is not required if the disk has not been added.
> On kernels prior to commit 40b3a52ffc5bc3 ("block: add a sanity
> check for a live disk in del_gendisk") it is mandatory to not
> call del_gendisk() if the underlying device has not been through
> device_add().

And even with the sanity check is it wrong, and will trigger a WARN_ON.
So maybe this commit log could use a little update?

With that fixed I think this should go into 5.16 and -stable.

Reviewed-by: Christoph Hellwig <hch@lst.de>
