Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6B3671C6
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhDURs7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:48:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244935AbhDURsf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:48:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4071CAF95;
        Wed, 21 Apr 2021 17:48:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/42] scsi_ioctl: return error code when blk_rq_map_kern() fails
Date:   Wed, 21 Apr 2021 19:47:09 +0200
Message-Id: <20210421174749.11221-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The callers of sg_scsi_ioctl() already check for negative
return values, so we can drop the usage of DRIVER_ERROR
and return the error from blk_rq_map_kern() instead.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/scsi_ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 6599bac0a78c..99d58786e0d5 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -488,9 +488,10 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 		break;
 	}
 
-	if (bytes && blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO)) {
-		err = DRIVER_ERROR << 24;
-		goto error;
+	if (bytes) {
+		err = blk_rq_map_kern(q, rq, buffer, bytes, GFP_NOIO);
+		if (err)
+			goto error;
 	}
 
 	blk_execute_rq(disk, rq, 0);
-- 
2.29.2

