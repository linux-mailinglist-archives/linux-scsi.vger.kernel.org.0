Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2124236913F
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbhDWLkj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:40:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236856AbhDWLkd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39B46B1AB;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/39] scsi: do not use DRIVER_INVALID
Date:   Fri, 23 Apr 2021 13:39:14 +0200
Message-Id: <20210423113944.42672-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There is no point in returning DID_ABORT together with DRIVER_INVALID,
as the caller couldn't care less where the abort originated.
So drop the use of DRIVER_INVALID.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/hptiop.c     | 2 +-
 drivers/scsi/mvumi.c      | 4 ++--
 drivers/scsi/vmw_pvscsi.c | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index db4c7a7ff4dd..61cda7b7624f 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -760,7 +760,7 @@ static void hptiop_finish_scsi_req(struct hptiop_hba *hba, u32 tag,
 		goto skip_resid;
 
 	default:
-		scp->result = DRIVER_INVALID << 24 | DID_ABORT << 16;
+		scp->result = DID_ABORT << 16;
 		break;
 	}
 
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index f61250545025..6bb03d7a254d 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1320,7 +1320,7 @@ static void mvumi_complete_cmd(struct mvumi_hba *mhba, struct mvumi_cmd *cmd,
 		}
 		break;
 	default:
-		scmd->result |= (DRIVER_INVALID << 24) | (DID_ABORT << 16);
+		scmd->result |= (DID_ABORT << 16);
 		break;
 	}
 
@@ -2127,7 +2127,7 @@ static enum blk_eh_timer_return mvumi_timed_out(struct scsi_cmnd *scmd)
 	else
 		atomic_dec(&mhba->fw_outstanding);
 
-	scmd->result = (DRIVER_INVALID << 24) | (DID_ABORT << 16);
+	scmd->result = (DID_ABORT << 16);
 	scmd->SCp.ptr = NULL;
 	if (scsi_bufflen(scmd)) {
 		dma_unmap_sg(&mhba->pdev->dev, scsi_sglist(scmd),
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index f0707eaad9f7..f57f8bc037d2 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -601,9 +601,6 @@ static void pvscsi_complete_request(struct pvscsi_adapter *adapter,
 		case BTSTAT_LUNMISMATCH:
 		case BTSTAT_TAGREJECT:
 		case BTSTAT_BADMSG:
-			cmd->result = (DRIVER_INVALID << 24);
-			fallthrough;
-
 		case BTSTAT_HAHARDWARE:
 		case BTSTAT_INVPHASE:
 		case BTSTAT_HATIMEOUT:
-- 
2.29.2

