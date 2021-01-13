Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC762F4730
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbhAMJHP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:07:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:53828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbhAMJHG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:07:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9D34B8FC;
        Wed, 13 Jan 2021 09:05:04 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/35] qla4xxx: use standard SAM status definitions
Date:   Wed, 13 Jan 2021 10:04:38 +0100
Message-Id: <20210113090500.129644-14-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard SAM status definitions and drop the
driver-defined ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/qla4xxx/ql4_fw.h  | 1 -
 drivers/scsi/qla4xxx/ql4_isr.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_fw.h b/drivers/scsi/qla4xxx/ql4_fw.h
index b9142464d3f0..4e1764df0a73 100644
--- a/drivers/scsi/qla4xxx/ql4_fw.h
+++ b/drivers/scsi/qla4xxx/ql4_fw.h
@@ -1181,7 +1181,6 @@ struct status_entry {
 	uint32_t handle;	/* 04-07 */
 
 	uint8_t scsiStatus;	/* 08 */
-#define SCSI_CHECK_CONDITION		  0x02
 
 	uint8_t iscsiFlags;	/* 09 */
 #define ISCSI_FLAG_RESIDUAL_UNDER	  0x02
diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index a51910ae9525..6f0e77dc2a34 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -182,7 +182,7 @@ static void qla4xxx_status_entry(struct scsi_qla_host *ha,
 
 		cmd->result = DID_OK << 16 | scsi_status;
 
-		if (scsi_status != SCSI_CHECK_CONDITION)
+		if (scsi_status != SAM_STAT_CHECK_CONDITION)
 			break;
 
 		/* Copy Sense Data into sense buffer. */
-- 
2.29.2

