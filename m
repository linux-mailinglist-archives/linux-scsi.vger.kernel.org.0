Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD47EDB07
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfKDJCW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728307AbfKDJCR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E47DB4C3;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 25/52] scsi: introduce scsi_build_sense()
Date:   Mon,  4 Nov 2019 10:01:24 +0100
Message-Id: <20191104090151.129140-26-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce scsi_build_sense() as a wrapper around
scsi_build_sense_buffer() to format the buffer and set
the correct SCSI status.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_lib.c  | 18 ++++++++++++++++++
 include/scsi/scsi_cmnd.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a0db8d8766a8..2babf6df8066 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3117,3 +3117,21 @@ int scsi_vpd_tpg_id(struct scsi_device *sdev, int *rel_id)
 	return group_id;
 }
 EXPORT_SYMBOL(scsi_vpd_tpg_id);
+
+/**
+ * scsi_build_sense - build sense data for a command
+ * @scmd:	scsi command for which the sense should be formatted
+ * @desc:	Sense format (non-zero == descriptor format,
+ *              0 == fixed format)
+ * @key:	Sense key
+ * @asc:	Additional sense code
+ * @ascq:	Additional sense code qualifier
+ *
+ **/
+void scsi_build_sense(struct scsi_cmnd *scmd, int desc, u8 key, u8 asc, u8 ascq)
+{
+	scsi_build_sense_buffer(desc, scmd->sense_buffer, key, asc, ascq);
+	scmd->result = (DRIVER_SENSE << 24) | (DID_OK << 16) |
+		SAM_STAT_CHECK_CONDITION;
+}
+EXPORT_SYMBOL_GPL(scsi_build_sense);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 6932d91472d5..9b9ca629097d 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -338,4 +338,7 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 	return xfer_len;
 }
 
+extern void scsi_build_sense(struct scsi_cmnd *scmd, int desc,
+			     u8 key, u8 asc, u8 ascq);
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.16.4

