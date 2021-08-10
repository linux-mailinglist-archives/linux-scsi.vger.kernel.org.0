Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43503E47BD
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Aug 2021 16:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhHIOim (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Aug 2021 10:38:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3606 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHIOfA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Aug 2021 10:35:00 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gjz9K62K8z6D9Lc;
        Mon,  9 Aug 2021 22:33:57 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 9 Aug 2021 16:34:24 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 15:34:21 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <kashyap.desai@broadcom.com>,
        <hare@suse.de>, <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 00/11] blk-mq: Reduce static requests memory footprint for shared sbitmap
Date:   Mon, 9 Aug 2021 22:29:27 +0800
Message-ID: <1628519378-211232-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
v1. But we'll keep name "shared sbitmap" name as it is fimilar. In using
a shared tags, the static rqs also become shared, reducing the number of
sets of static rqs, reducing memory usage.

Patch "blk-mq: Use shared tags for shared sbitmap support" is a bit big,
and could be broken down. But then maintaining ability to bisect
becomes harder and each sub-patch would get more convoluted.

For megaraid sas driver on my 128-CPU arm64 system with 1x SATA disk, we
save approx. 300MB(!) [370MB -> 60MB]

Baseline is 2112f5c1330a (for-5.15/block) loop: Select I/O scheduler ...

Changes since v1:
- Switch to use blk_mq_tags for shared sbitmap
- Add new blk_mq_ops init request callback
- Add some RB tags (thanks!)

John Garry (11):
  blk-mq: Change rqs check in blk_mq_free_rqs()
  block: Rename BLKDEV_MAX_RQ -> BLKDEV_DEFAULT_RQ
  blk-mq: Relocate shared sbitmap resize in blk_mq_update_nr_requests()
  blk-mq: Invert check in blk_mq_update_nr_requests()
  blk-mq-sched: Rename blk_mq_sched_alloc_{tags -> map_and_request}()
  blk-mq: Pass driver tags to blk_mq_clear_rq_mapping()
  blk-mq: Add blk_mq_tag_update_sched_shared_sbitmap()
  blk-mq: Add blk_mq_ops.init_request_no_hctx()
  scsi: Set blk_mq_ops.init_request_no_hctx
  blk-mq: Use shared tags for shared sbitmap support
  blk-mq: Stop using pointers for blk_mq_tags bitmap tags

 block/bfq-iosched.c      |   4 +-
 block/blk-core.c         |   2 +-
 block/blk-mq-debugfs.c   |   8 +--
 block/blk-mq-sched.c     |  92 +++++++++++++------------
 block/blk-mq-sched.h     |   2 +-
 block/blk-mq-tag.c       | 111 +++++++++++++-----------------
 block/blk-mq-tag.h       |  12 ++--
 block/blk-mq.c           | 144 +++++++++++++++++++++++----------------
 block/blk-mq.h           |   8 +--
 block/kyber-iosched.c    |   4 +-
 block/mq-deadline-main.c |   2 +-
 drivers/block/rbd.c      |   2 +-
 drivers/scsi/scsi_lib.c  |   6 +-
 include/linux/blk-mq.h   |  20 +++---
 include/linux/blkdev.h   |   5 +-
 15 files changed, 218 insertions(+), 204 deletions(-)

-- 
2.26.2

