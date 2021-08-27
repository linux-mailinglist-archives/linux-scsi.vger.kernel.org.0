Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA23F98B9
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Aug 2021 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245103AbhH0MHl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Aug 2021 08:07:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3696 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbhH0MHl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 Aug 2021 08:07:41 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gwz1n2F5Tz67fqW;
        Fri, 27 Aug 2021 20:05:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 27 Aug 2021 14:06:50 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 27 Aug 2021 13:06:48 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ming.lei@redhat.com>, <linux-scsi@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 01/13] blk-mq: Change rqs check in blk_mq_free_rqs()
Date:   Fri, 27 Aug 2021 20:01:52 +0800
Message-ID: <1630065724-69146-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1630065724-69146-1-git-send-email-john.garry@huawei.com>
References: <1630065724-69146-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The original code in commit 24d2f90309b23 ("blk-mq: split out tag
initialization, support shared tags") would check tags->rqs is non-NULL and
then dereference tags->rqs[].

Then in commit 2af8cbe30531 ("blk-mq: split tag ->rqs[] into two"), we
started to dereference tags->static_rqs[], but continued to check non-NULL
tags->rqs.

Check tags->static_rqs as non-NULL instead, which is more logical.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a33d16a7298..7927e62d6395 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2348,7 +2348,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 {
 	struct page *page;
 
-	if (tags->rqs && set->ops->exit_request) {
+	if (tags->static_rqs && set->ops->exit_request) {
 		int i;
 
 		for (i = 0; i < tags->nr_tags; i++) {
-- 
2.26.2

