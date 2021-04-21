Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459D8366F5F
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhDUPqM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 11:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240962AbhDUPqL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 11:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619019938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j3DI/4Geichl/TbrPjnTy999JUzvhPwYbEhTyaEY468=;
        b=UUxyJx6p+ID1mhSLUVdR0eSSH8VOEi8mIlnKVsDYQPluOzcmvpaqZ0Sc2QdfPXZ/vlhVpm
        GMzM8kHh0/lHX8f6we0NP9PRgUk9HBxvcFsrDAYBPf1oHY1cTncBp6UZs1bOKDeW/UklUn
        8VPA6CkRlU6fHE6pDwUic9yVpcGbvSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-VJRPhCXoNtiooLSIbIe5aw-1; Wed, 21 Apr 2021 11:45:34 -0400
X-MC-Unique: VJRPhCXoNtiooLSIbIe5aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B09E9107ACFE;
        Wed, 21 Apr 2021 15:45:32 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A580E6091B;
        Wed, 21 Apr 2021 15:45:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] blk-mq: fix build warning when making htmldocs
Date:   Wed, 21 Apr 2021 23:45:26 +0800
Message-Id: <20210421154526.1954174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes the following warning when running 'make htmldocs'.

Fixes: d022d18c045f ("scsi: blk-mq: Add callbacks for storing & retrieving budget token")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
Martin, please apply it against 5.13/scsi-queue.

 include/linux/blk-mq.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3bd3ee651143..359486940fa0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -313,12 +313,12 @@ struct blk_mq_ops {
 	 */
 	void (*put_budget)(struct request_queue *, int);
 
-	/*
-	 * @set_rq_budget_toekn: store rq's budget token
+	/**
+	 * @set_rq_budget_token: store rq's budget token
 	 */
 	void (*set_rq_budget_token)(struct request *, int);
-	/*
-	 * @get_rq_budget_toekn: retrieve rq's budget token
+	/**
+	 * @get_rq_budget_token: retrieve rq's budget token
 	 */
 	int (*get_rq_budget_token)(struct request *);
 
-- 
2.29.2

