Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9A2D10FE
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgLGMuh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 07:50:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgLGMuh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 07:50:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A7E8B19B;
        Mon,  7 Dec 2020 12:48:32 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/35] scsi_debug: do not set COMMAND_COMPLETE
Date:   Mon,  7 Dec 2020 13:48:06 +0100
Message-Id: <20201207124819.95822-23-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201207124819.95822-1-hare@suse.de>
References: <20201207124819.95822-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

COMMAND_COMPLETE is defined as '0', so setting it is quite pointless.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 24c0f7ec0351..93048f13a4e3 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -853,7 +853,7 @@ static const int illegal_condition_result =
 	(DRIVER_SENSE << 24) | (DID_ABORT << 16) | SAM_STAT_CHECK_CONDITION;
 
 static const int device_qfull_result =
-	(DID_OK << 16) | (COMMAND_COMPLETE << 8) | SAM_STAT_TASK_SET_FULL;
+	(DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
 
 static const int condition_met_result = SAM_STAT_CONDITION_MET;
 
-- 
2.16.4

