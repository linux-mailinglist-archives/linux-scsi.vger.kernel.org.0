Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D813DEDB24
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfKDJCi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbfKDJCO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87074B496;
        Mon,  4 Nov 2019 09:02:10 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/52] qla4xxx: use standard SAM status definitions
Date:   Mon,  4 Nov 2019 10:01:16 +0100
Message-Id: <20191104090151.129140-18-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard SAM status definitions and drop the
driver-defined ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/qla4xxx/ql4_fw.h  | 1 -
 drivers/scsi/qla4xxx/ql4_isr.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_fw.h b/drivers/scsi/qla4xxx/ql4_fw.h
index 699575efc9ba..0108deb1fb5c 100644
--- a/drivers/scsi/qla4xxx/ql4_fw.h
+++ b/drivers/scsi/qla4xxx/ql4_fw.h
@@ -1182,7 +1182,6 @@ struct status_entry {
 	uint32_t handle;	/* 04-07 */
 
 	uint8_t scsiStatus;	/* 08 */
-#define SCSI_CHECK_CONDITION		  0x02
 
 	uint8_t iscsiFlags;	/* 09 */
 #define ISCSI_FLAG_RESIDUAL_UNDER	  0x02
diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index d2cd33d8d67f..8944fcc571e2 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -183,7 +183,7 @@ static void qla4xxx_status_entry(struct scsi_qla_host *ha,
 
 		cmd->result = DID_OK << 16 | scsi_status;
 
-		if (scsi_status != SCSI_CHECK_CONDITION)
+		if (scsi_status != SAM_STAT_CHECK_CONDITION)
 			break;
 
 		/* Copy Sense Data into sense buffer. */
-- 
2.16.4

