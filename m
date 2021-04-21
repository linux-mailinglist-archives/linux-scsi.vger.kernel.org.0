Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525E3671C8
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbhDURs7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:48:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244976AbhDURsf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:48:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F923AF88;
        Wed, 21 Apr 2021 17:48:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/42] st: return error code in st_scsi_execute()
Date:   Wed, 21 Apr 2021 19:47:08 +0200
Message-Id: <20210421174749.11221-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The callers to st_scsi_execute already check for negative
return values, so we can drop the use of DRIVER_ERROR and
return the actual error code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 9ca536aae784..23be6447e576 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -551,7 +551,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, 0);
 	if (IS_ERR(req))
-		return DRIVER_ERROR << 24;
+		return PTR_ERR(req);
 	rq = scsi_req(req);
 	req->rq_flags |= RQF_QUIET;
 
@@ -562,7 +562,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 				      GFP_KERNEL);
 		if (err) {
 			blk_put_request(req);
-			return DRIVER_ERROR << 24;
+			return err;
 		}
 	}
 
-- 
2.29.2

