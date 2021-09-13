Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C56409715
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Sep 2021 17:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346780AbhIMPUL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Sep 2021 11:20:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3780 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346248AbhIMPSy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Sep 2021 11:18:54 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H7VR65gJGz67nJX;
        Mon, 13 Sep 2021 23:15:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 17:17:36 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 13 Sep 2021 16:17:34 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <ming.lei@redhat.com>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RESEND v3 08/13] blk-mq: Don't clear driver tags own mapping
Date:   Mon, 13 Sep 2021 23:12:25 +0800
Message-ID: <1631545950-56586-9-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Function blk_mq_clear_rq_mapping() is required to clear the sched tags
mappings in driver tags rqs[].

But there is no need for a driver tags to clear its own mapping, so skip
clearing the mapping in this scenario.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 block/blk-mq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4bae8afdfbe1..5229c5420b85 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2308,6 +2308,10 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
 	struct page *page;
 	unsigned long flags;
 
+	/* There is no need to clear a driver tags own mapping */
+	if (drv_tags == tags)
+		return;
+
 	list_for_each_entry(page, &tags->page_list, lru) {
 		unsigned long start = (unsigned long)page_address(page);
 		unsigned long end = start + order_to_size(page->private);
-- 
2.26.2

