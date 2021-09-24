Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9518416DC8
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Sep 2021 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbhIXIfG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Sep 2021 04:35:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3854 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbhIXIfF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Sep 2021 04:35:05 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG4xM1Vtsz67lqG;
        Fri, 24 Sep 2021 16:31:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:33:30 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 09:33:28 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <ming.lei@redhat.com>,
        <hare@suse.de>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 00/13] blk-mq: Reduce static requests memory footprint for shared sbitmap
Date:   Fri, 24 Sep 2021 16:28:17 +0800
Message-ID: <1632472110-244938-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Currently a full set of static requests are allocated per hw queue per
tagset when shared sbitmap is used.

However, only tagset->queue_depth number of requests may be active at
any given time. As such, only tagset->queue_depth number of static
requests are required.

The same goes for using an IO scheduler, which allocates a full set of
static requests per hw queue per request queue.

This series changes shared sbitmap support by using a shared tags per
tagset and request queue. Ming suggested something along those lines in
v1 review. But we'll keep name "shared sbitmap" name as it is familiar. In
using a shared tags, the static rqs also become shared, reducing the
number of sets of static rqs, reducing memory usage.

Patch "blk-mq: Use shared tags for shared sbitmap support" is a bit big,
and could potentially be broken down. But then maintaining ability to
bisect becomes harder and each sub-patch would get more convoluted.

For megaraid sas driver on my 128-CPU arm64 system with 1x SATA disk, we
save approx. 300MB(!) [370MB -> 60MB]

Baseline is v5.15-rc2

Changes since v3:
- Fix transient error handling issue in  05/13
- Add Hannes RB tags (thanks!)

Changes since v2:
- Make blk_mq_clear_rq_mapping() static again
- Various function renaming for conciseness and consistency
- Add/refactor alloc/free map and rqs function
- Drop the new blk_mq_ops init_request method in favour of passing an
  invalid HW queue index for shared sbitmap
- Add patch to not clear rq mapping for driver tags
- Remove blk_mq_init_bitmap_tags()
- Add some more RB tags (thanks!)

Changes since v1:
- Switch to use blk_mq_tags for shared sbitmap
- Add new blk_mq_ops init request callback
- Add some RB tags (thanks!)


John Garry (13):
  blk-mq: Change rqs check in blk_mq_free_rqs()
  block: Rename BLKDEV_MAX_RQ -> BLKDEV_DEFAULT_RQ
  blk-mq: Relocate shared sbitmap resize in blk_mq_update_nr_requests()
  blk-mq: Invert check in blk_mq_update_nr_requests()
  blk-mq-sched: Rename blk_mq_sched_alloc_{tags -> map_and_rqs}()
  blk-mq-sched: Rename blk_mq_sched_free_{requests -> rqs}()
  blk-mq: Pass driver tags to blk_mq_clear_rq_mapping()
  blk-mq: Don't clear driver tags own mapping
  blk-mq: Add blk_mq_tag_update_sched_shared_sbitmap()
  blk-mq: Add blk_mq_alloc_map_and_rqs()
  blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()
  blk-mq: Use shared tags for shared sbitmap support
  blk-mq: Stop using pointers for blk_mq_tags bitmap tags

 block/bfq-iosched.c    |   4 +-
 block/blk-core.c       |   4 +-
 block/blk-mq-debugfs.c |   8 +-
 block/blk-mq-sched.c   | 116 +++++++++++------------
 block/blk-mq-sched.h   |   4 +-
 block/blk-mq-tag.c     | 125 +++++++++----------------
 block/blk-mq-tag.h     |  14 +--
 block/blk-mq.c         | 208 ++++++++++++++++++++++++-----------------
 block/blk-mq.h         |  18 ++--
 block/blk.h            |   2 +-
 block/kyber-iosched.c  |   4 +-
 block/mq-deadline.c    |   2 +-
 drivers/block/rbd.c    |   2 +-
 include/linux/blk-mq.h |  15 ++-
 include/linux/blkdev.h |   5 +-
 15 files changed, 255 insertions(+), 276 deletions(-)

-- 
2.26.2

