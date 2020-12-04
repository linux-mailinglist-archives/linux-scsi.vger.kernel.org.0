Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195712CEBB0
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbgLDKDa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:03:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:51216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387825AbgLDKD1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:03:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24D8EAF22;
        Fri,  4 Dec 2020 10:01:48 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 23/37] ufshcd: do not set COMMAND_COMPLETE
Date:   Fri,  4 Dec 2020 11:01:26 +0100
Message-Id: <20201204100140.140863-24-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

COMMAND_COMPLETE is defined as '0', so setting it is quite pointless.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/ufs/ufshcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 80cbce414678..f9b1d3b22ae9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4789,9 +4789,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
 		ufshcd_copy_sense_data(lrbp);
 		fallthrough;
 	case SAM_STAT_GOOD:
-		result |= DID_OK << 16 |
-			  COMMAND_COMPLETE << 8 |
-			  scsi_status;
+		result |= DID_OK << 16 | scsi_status;
 		break;
 	case SAM_STAT_TASK_SET_FULL:
 	case SAM_STAT_BUSY:
-- 
2.16.4

