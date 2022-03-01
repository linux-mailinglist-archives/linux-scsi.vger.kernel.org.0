Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416E24C8C1E
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Mar 2022 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiCANA5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Mar 2022 08:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiCANAz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Mar 2022 08:00:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950EF90CE9;
        Tue,  1 Mar 2022 05:00:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A50768AFE; Tue,  1 Mar 2022 14:00:11 +0100 (CET)
Date:   Tue, 1 Mar 2022 14:00:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: move more work to disk_release v2
Message-ID: <20220301130010.GA4000@lst.de>
References: <20220227172144.508118-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227172144.508118-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

FYI, this patchset has acquired some trivial conflicts against the
latest for-5.18/block tree.

The git branch below has been rebased to fix that.

> Git branch:
> 
>     git://git.infradead.org/users/hch/block.git freeze-5.18
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/freeze-5.18
> 
> Changes since v1:
>  - fix a refcounting bug in sd
>  - rename a function
> 
> Diffstat:
>  block/blk-core.c           |    7 --
>  block/blk-mq.c             |   10 +--
>  block/blk-sysfs.c          |   25 --------
>  block/blk.h                |    2 
>  block/elevator.c           |    7 +-
>  block/genhd.c              |   38 ++++++++++++-
>  drivers/scsi/sd.c          |  114 +++++++++------------------------------
>  drivers/scsi/sd.h          |   13 +++-
>  drivers/scsi/sr.c          |  129 +++++++++------------------------------------
>  drivers/scsi/sr.h          |    5 -
>  drivers/scsi/st.c          |    1 
>  drivers/scsi/st.h          |    1 
>  include/scsi/scsi_cmnd.h   |    9 ---
>  include/scsi/scsi_driver.h |    9 ++-
>  14 files changed, 117 insertions(+), 253 deletions(-)
---end quoted text---
