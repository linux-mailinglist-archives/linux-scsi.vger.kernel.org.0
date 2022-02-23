Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CD04C0D61
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Feb 2022 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiBWHgp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Feb 2022 02:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiBWHgo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 23 Feb 2022 02:36:44 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B6710CF;
        Tue, 22 Feb 2022 23:36:18 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8185A68AFE; Wed, 23 Feb 2022 08:36:14 +0100 (CET)
Date:   Wed, 23 Feb 2022 08:36:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/12] blk-mq: do not include passthrough requests in
 I/O accounting
Message-ID: <20220223073614.GA32169@lst.de>
References: <20220222141450.591193-1-hch@lst.de> <20220222141450.591193-2-hch@lst.de> <YhWXFMhdms1QO1dL@T590> <20220223064226.GA31307@lst.de> <YhXb8CrfBqQZhYyZ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhXb8CrfBqQZhYyZ@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 23, 2022 at 03:02:08PM +0800, Ming Lei wrote:
> There are small amount of in-kernel passthrough requests(admin, or driver
> private) which shouldn't be accounted, but passthrough RW IO requests from
> userspace can be lots of, and user may rely on diskstat to account them.

/dev/sg won't be accounted either.  But most importantly they are
accounted wrongly: the accounting buckets into read/write/discard.  Any
most pass through commands are everything but.

Also the way how this accounting works is completely broken.
Passthrough requests are sent through a request_queue, and it does
not make sense to account them to a block_device which sits way about
that.
