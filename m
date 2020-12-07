Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095F82D10FD
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgLGMuh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 07:50:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgLGMuh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 07:50:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24EC4AEC1;
        Mon,  7 Dec 2020 12:48:32 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 32/35] storvsc: Return DID_ERROR for invalid commands
Date:   Mon,  7 Dec 2020 13:48:16 +0100
Message-Id: <20201207124819.95822-33-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201207124819.95822-1-hare@suse.de>
References: <20201207124819.95822-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

ILLEGAL_COMMAND is a sense code, not a driver byte.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/storvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 0c65fbd41035..c6ba1878b1e6 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1641,7 +1641,7 @@ static bool storvsc_scsi_cmd_ok(struct scsi_cmnd *scmnd)
 	 * this. So, don't send it.
 	 */
 	case SET_WINDOW:
-		scmnd->result = ILLEGAL_REQUEST << 16;
+		scmnd->result = DID_ERROR << 16;
 		allowed = false;
 		break;
 	default:
-- 
2.16.4

