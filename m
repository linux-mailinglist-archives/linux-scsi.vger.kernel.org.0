Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE87341341
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Mar 2021 03:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCSC4H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Mar 2021 22:56:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13990 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhCSCzl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Mar 2021 22:55:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F1pPN5sFHzrYRY;
        Fri, 19 Mar 2021 10:53:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Fri, 19 Mar 2021
 10:55:33 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <hch@lst.de>,
        <keescook@chromium.org>, <kbusch@kernel.org>,
        <linux-block@vger.kernel.org>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/3] scsi: check the whole result in some places
Date:   Fri, 19 Mar 2021 11:01:25 +0800
Message-ID: <20210319030128.1345061-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Some bugs have been found related to the result of the command been
returned by the driver or the middle layer in some cases. Such as in
scsi_queue_rq() when the device is offline only the host byte is set.

Jason Yan (3):
  scsi: check the whole result for reading write protect flag
  scsi: only copy data to user when the whole result is good
  scsi: switch to use scsi_result_is_good() in
    scsi_result_to_blk_status()

 block/scsi_ioctl.c      |  2 +-
 drivers/scsi/scsi_lib.c |  2 +-
 drivers/scsi/sd.c       |  6 +++---
 include/scsi/scsi.h     | 13 +++++++++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.25.4

