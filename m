Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644B2DE894
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfJUJxh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 05:53:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727885AbfJUJxe (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:53:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 277E8BAC9;
        Mon, 21 Oct 2019 09:53:29 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/24] st: return error code in st_scsi_execute()
Date:   Mon, 21 Oct 2019 11:53:16 +0200
Message-Id: <20191021095322.137969-19-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021095322.137969-1-hare@suse.de>
References: <20191021095322.137969-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We should return the actual error code in st_scsi_execute(),
avoiding the need to use DRIVER_ERROR.

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

