Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E739622CBE1
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Jul 2020 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGXRRb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jul 2020 13:17:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726972AbgGXRRa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Jul 2020 13:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595611049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKtt2wh9uRF1tNryChAitkxqDvDxcbQGuMV2kP+9zv4=;
        b=g1QPxy0o22JQGmCmPaG9YkcQZSzCecrVsUWvSvlsM8rNVS5aaq6GfY7LDv5MmQNW1pzL6m
        qJJs/WI1fdN3NI6ZS9ymKupPZOu5hDkud8zsy1xZi29tjn2dLaxFl77LvC2LVsiVFNp4yS
        y1iGRhYh+SJDEvOTiMWVK1fXcVr5ugM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-rmKe7uq6NXWrh0QIewwZJQ-1; Fri, 24 Jul 2020 13:17:28 -0400
X-MC-Unique: rmKe7uq6NXWrh0QIewwZJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C13DC8017FB;
        Fri, 24 Jul 2020 17:17:26 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 987B274F64;
        Fri, 24 Jul 2020 17:17:25 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, b.zolnierkie@samsung.com,
        axboe@kernel.dk
Subject: [v4 11/11] buffer_io_error: Use durable_name_printk_ratelimited
Date:   Fri, 24 Jul 2020 12:17:06 -0500
Message-Id: <20200724171706.1550403-12-tasleson@redhat.com>
In-Reply-To: <20200724171706.1550403-1-tasleson@redhat.com>
References: <20200724171706.1550403-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace printk_ratelimited with one that adds the key/value
durable name to log entry.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 fs/buffer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..f35eaaafce0e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -133,10 +133,16 @@ __clear_page_buffers(struct page *page)
 
 static void buffer_io_error(struct buffer_head *bh, char *msg)
 {
-	if (!test_bit(BH_Quiet, &bh->b_state))
-		printk_ratelimited(KERN_ERR
+	if (!test_bit(BH_Quiet, &bh->b_state)) {
+		struct device *gendev;
+
+		gendev = (bh->b_bdev->bd_disk) ?
+			disk_to_dev(bh->b_bdev->bd_disk) : NULL;
+
+		durable_name_printk_ratelimited(KERN_ERR, gendev,
 			"Buffer I/O error on dev %pg, logical block %llu%s\n",
 			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
+	}
 }
 
 /*
-- 
2.26.2

