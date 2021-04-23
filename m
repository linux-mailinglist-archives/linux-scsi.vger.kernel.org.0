Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2643F369155
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbhDWLlE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:41:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:46952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242281AbhDWLkm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A15C2B1DE;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 26/39] acornscsi: remove acornscsi_reportstatus()
Date:   Fri, 23 Apr 2021 13:39:31 +0200
Message-Id: <20210423113944.42672-27-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Unused.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/arm/acornscsi.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index 248a5bfad153..8b75d896f393 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2506,31 +2506,6 @@ static int acornscsi_queuecmd_lck(struct scsi_cmnd *SCpnt,
 
 DEF_SCSI_QCMD(acornscsi_queuecmd)
 
-/*
- * Prototype: void acornscsi_reportstatus(struct scsi_cmnd **SCpntp1, struct scsi_cmnd **SCpntp2, int result)
- * Purpose  : pass a result to *SCpntp1, and check if *SCpntp1 = *SCpntp2
- * Params   : SCpntp1 - pointer to command to return
- *	      SCpntp2 - pointer to command to check
- *	      result  - result to pass back to mid-level done function
- * Returns  : *SCpntp2 = NULL if *SCpntp1 is the same command structure as *SCpntp2.
- */
-static inline void acornscsi_reportstatus(struct scsi_cmnd **SCpntp1,
-					  struct scsi_cmnd **SCpntp2,
-					  int result)
-{
-	struct scsi_cmnd *SCpnt = *SCpntp1;
-
-    if (SCpnt) {
-	*SCpntp1 = NULL;
-
-	SCpnt->result = result;
-	SCpnt->scsi_done(SCpnt);
-    }
-
-    if (SCpnt == *SCpntp2)
-	*SCpntp2 = NULL;
-}
-
 enum res_abort { res_not_running, res_success, res_success_clear, res_snooze };
 
 /*
-- 
2.29.2

