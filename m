Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F644481D
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Nov 2021 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhKCSVX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Nov 2021 14:21:23 -0400
Received: from verein.lst.de ([213.95.11.211]:60724 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhKCSVV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 3 Nov 2021 14:21:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E612668AA6; Wed,  3 Nov 2021 19:18:33 +0100 (CET)
Date:   Wed, 3 Nov 2021 19:18:33 +0100
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
Subject: Re: [PATCH v4 1/4] block: update __register_blkdev() probe
 documentation
Message-ID: <20211103181833.GA7745@lst.de>
References: <20211103181258.1462704-1-mcgrof@kernel.org> <20211103181258.1462704-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103181258.1462704-2-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
