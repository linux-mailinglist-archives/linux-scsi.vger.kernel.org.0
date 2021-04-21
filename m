Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EB83671DA
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbhDURtd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:52320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245092AbhDURtO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AA3DB2FF;
        Wed, 21 Apr 2021 17:48:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 37/42] fas216: translate message to host byte status
Date:   Wed, 21 Apr 2021 19:47:44 +0200
Message-Id: <20210421174749.11221-38-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of setting the message byte translate it to the appropriate
host byte. As error recovery would return DID_ERROR for any non-zero
message byte the translation doesn't change the error handling.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/arm/fas216.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 2e687ce60753..659bcfe5e2e6 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2042,8 +2042,10 @@ fas216_std_done(FAS216_Info *info, struct scsi_cmnd *SCpnt, unsigned int result)
 {
 	info->stats.fins += 1;
 
-	SCpnt->result = result << 16 | info->scsi.SCp.Message << 8 |
-			info->scsi.SCp.Status;
+	set_host_byte(SCpnt, result);
+	if (get_host_byte(SCpnt) == DID_OK)
+		translate_msg_byte(SCpnt, info->scsi.SCp.Message);
+	set_status_byte(SCpnt, info->scsi.SCp.Status);
 
 	fas216_log_command(info, LOG_CONNECT, SCpnt,
 		"command complete, result=0x%08x", SCpnt->result);
@@ -2051,8 +2053,7 @@ fas216_std_done(FAS216_Info *info, struct scsi_cmnd *SCpnt, unsigned int result)
 	/*
 	 * If the driver detected an error, we're all done.
 	 */
-	if (host_byte(SCpnt->result) != DID_OK ||
-	    msg_byte(SCpnt->result) != COMMAND_COMPLETE)
+	if (host_byte(SCpnt->result) != DID_OK)
 		goto done;
 
 	/*
-- 
2.29.2

