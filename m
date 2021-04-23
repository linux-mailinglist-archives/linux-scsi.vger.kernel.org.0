Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826A4369158
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbhDWLlH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236905AbhDWLks (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0A5DB1F7;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 32/39] fas216: Use get_status_byte() to avoid using linux-specific status codes
Date:   Fri, 23 Apr 2021 13:39:37 +0200
Message-Id: <20210423113944.42672-33-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The driver should be using the standard SAM_STAT_ values, and not
the linux-specific ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/arm/fas216.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 96db9058d61b..a2337863e3d8 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2060,15 +2060,15 @@ fas216_std_done(FAS216_Info *info, struct scsi_cmnd *SCpnt, unsigned int result)
 	 * If the command returned CHECK_CONDITION or COMMAND_TERMINATED
 	 * status, request the sense information.
 	 */
-	if (status_byte(SCpnt->result) == CHECK_CONDITION ||
-	    status_byte(SCpnt->result) == COMMAND_TERMINATED)
+	if (get_status_byte(SCpnt) == SAM_STAT_CHECK_CONDITION ||
+	    get_status_byte(SCpnt) == SAM_STAT_COMMAND_TERMINATED)
 		goto request_sense;
 
 	/*
 	 * If the command did not complete with GOOD status,
 	 * we are all done here.
 	 */
-	if (status_byte(SCpnt->result) != GOOD)
+	if (get_status_byte(SCpnt) != SAM_STAT_GOOD)
 		goto done;
 
 	/*
-- 
2.29.2

