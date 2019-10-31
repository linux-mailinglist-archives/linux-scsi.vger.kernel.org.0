Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA954EAE57
	for <lists+linux-scsi@lfdr.de>; Thu, 31 Oct 2019 12:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJaLFc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 07:05:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:37476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbfJaLFc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 31 Oct 2019 07:05:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BFE6B38C;
        Thu, 31 Oct 2019 11:05:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 19/24] scsi_ioctl: return error code when blk_rq_map_kern() fails
Date:   Thu, 31 Oct 2019 12:04:47 +0100
Message-Id: <20191031110452.73463-20-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191031110452.73463-1-hare@suse.de>
References: <20191031110452.73463-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The callers of sg_scsi_ioctl() already need to check for
negative return values, so we can drop the usage of DRIVER_ERROR
and return the error from blk_rq_map_kern() instead.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/scsi_ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index f5e0ad65e86a..1ab1b8d9641c 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -485,9 +485,10 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
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
 
 	blk_execute_rq(q, disk, rq, 0);
-- 
2.16.4

