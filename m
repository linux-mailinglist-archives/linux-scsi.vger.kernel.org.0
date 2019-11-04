Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9E1EDB04
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfKDJCU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:57310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728316AbfKDJCR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A96FB4BA;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 45/52] st: return error code in st_scsi_execute()
Date:   Mon,  4 Nov 2019 10:01:44 +0100
Message-Id: <20191104090151.129140-46-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The callers to st_scsi_execute already checks for negative
return values, so we can drop the use of DRIVER_ERROR and
return the actual error code.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/st.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e3266a64a477..5f38369cc62f 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -549,7 +549,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, 0);
 	if (IS_ERR(req))
-		return DRIVER_ERROR << 24;
+		return PTR_ERR(req);
 	rq = scsi_req(req);
 	req->rq_flags |= RQF_QUIET;
 
@@ -560,7 +560,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 				      GFP_KERNEL);
 		if (err) {
 			blk_put_request(req);
-			return DRIVER_ERROR << 24;
+			return err;
 		}
 	}
 
-- 
2.16.4

