Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6E13671D0
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbhDURtS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244979AbhDURtB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78DECB0E5;
        Wed, 21 Apr 2021 17:48:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/42] xen-scsiback: use DID_ERROR instead of DRIVER_ERROR
Date:   Wed, 21 Apr 2021 19:47:17 +0200
Message-Id: <20210421174749.11221-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

DRIVER_ERROR was supposed to signal an error generated by the driver,
which xen-scsiback arguably isn't. Also the driver bytes don't have
a detailed error recovery, so we should rather return DID_ERROR
instead of DRIVER_ERROR.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/xen/xen-scsiback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 499b94702e2b..f274e078312e 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -719,10 +719,10 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 				result = DID_NO_CONNECT;
 				break;
 			default:
-				result = DRIVER_ERROR;
+				result = DID_ERROR;
 				break;
 			}
-			scsiback_send_response(info, NULL, result << 24, 0,
+			scsiback_send_response(info, NULL, result << 16, 0,
 					       ring_req.rqid);
 			return 1;
 		}
@@ -732,7 +732,7 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 			if (scsiback_gnttab_data_map(&ring_req, pending_req)) {
 				scsiback_fast_flush_area(pending_req);
 				scsiback_do_resp_with_sense(NULL,
-						DRIVER_ERROR << 24, 0, pending_req);
+						DID_ERROR << 16, 0, pending_req);
 				transport_generic_free_cmd(&pending_req->se_cmd, 0);
 			} else {
 				scsiback_cmd_exec(pending_req);
@@ -747,7 +747,7 @@ static int scsiback_do_cmd_fn(struct vscsibk_info *info,
 			break;
 		default:
 			pr_err_ratelimited("invalid request\n");
-			scsiback_do_resp_with_sense(NULL, DRIVER_ERROR << 24, 0,
+			scsiback_do_resp_with_sense(NULL, DID_ERROR << 16, 0,
 						    pending_req);
 			transport_generic_free_cmd(&pending_req->se_cmd, 0);
 			break;
-- 
2.29.2

