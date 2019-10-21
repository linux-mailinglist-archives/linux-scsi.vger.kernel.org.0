Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD002DE895
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Oct 2019 11:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJUJxh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 05:53:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbfJUJxh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:53:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FF7ABACA;
        Mon, 21 Oct 2019 09:53:29 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/24] scsi: stop using DRIVER_ERROR
Date:   Mon, 21 Oct 2019 11:53:20 +0200
Message-Id: <20191021095322.137969-23-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021095322.137969-1-hare@suse.de>
References: <20191021095322.137969-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Return the actual error code in __scsi_execute() (which, according
to the documentation, should have happened anyway).
And audit all callers to cope with negative return values from
__scsi_execute() and friends.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/ch.c           |  2 ++
 drivers/scsi/constants.c    |  2 +-
 drivers/scsi/scsi.c         |  2 ++
 drivers/scsi/scsi_lib.c     | 15 +++++++++------
 drivers/scsi/ufs/ufshcd.c   |  4 +---
 include/scsi/scsi.h         |  1 -
 include/trace/events/scsi.h |  3 +--
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 380a519b1757..173f2c065116 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -199,6 +199,8 @@ ch_do_scsi(scsi_changer *ch, unsigned char *cmd, int cmd_len,
 	result = scsi_execute_req(ch->device, cmd, direction, buffer,
 				  buflength, &sshdr, timeout * HZ,
 				  MAX_RETRIES, NULL);
+	if (result < 0)
+		return result;
 	if (status_byte(result) == SAM_STAT_CHECK_CONDITION) {
 		if (debug)
 			scsi_print_sense_hdr(ch->device, ch->name, &sshdr);
diff --git a/drivers/scsi/constants.c b/drivers/scsi/constants.c
index 1cee98534bfd..57c544fd8c6b 100644
--- a/drivers/scsi/constants.c
+++ b/drivers/scsi/constants.c
@@ -407,7 +407,7 @@ static const char * const hostbyte_table[]={
 "DID_NEXUS_FAILURE" };
 
 static const char * const driverbyte_table[]={
-"DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA", "DRIVER_ERROR"};
+"DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA"};
 
 const char *scsi_hostbyte_string(int result)
 {
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d6ecb773c512..96a204ff5bf4 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -509,6 +509,8 @@ int scsi_report_opcode(struct scsi_device *sdev, unsigned char *buffer,
 	result = scsi_execute_req(sdev, cmd, DMA_FROM_DEVICE, buffer, len,
 				  &sshdr, 30 * HZ, 3, NULL);
 
+	if (result < 0)
+		return result;
 	if (result && scsi_sense_valid(&sshdr) &&
 	    sshdr.sense_key == ILLEGAL_REQUEST &&
 	    (sshdr.asc == 0x20 || sshdr.asc == 0x24) && sshdr.ascq == 0x00)
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index eac14ecc82dc..530d6a6815a1 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -253,19 +253,22 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 {
 	struct request *req;
 	struct scsi_request *rq;
-	int ret = DRIVER_ERROR << 24;
+	int ret;
 
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
 	if (IS_ERR(req))
-		return ret;
-	rq = scsi_req(req);
+		return PTR_ERR(req);
 
-	if (bufflen &&	blk_rq_map_kern(sdev->request_queue, req,
-					buffer, bufflen, GFP_NOIO))
-		goto out;
+	rq = scsi_req(req);
 
+	if (bufflen) {
+		ret = blk_rq_map_kern(sdev->request_queue, req,
+				      buffer, bufflen, GFP_NOIO);
+		if (ret)
+			goto out;
+	}
 	rq->cmd_len = COMMAND_SIZE(cmd[0]);
 	memcpy(rq->cmd, cmd, rq->cmd_len);
 	rq->retries = retries;
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index e411aadb6da7..87a11289202e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7602,9 +7602,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 			    pwr_mode, ret);
 		if (scsi_sense_valid(&sshdr))
 			scsi_print_sense_hdr(sdp, NULL, &sshdr);
-	}
-
-	if (!ret)
+	} else
 		hba->curr_dev_pwr_mode = pwr_mode;
 out:
 	scsi_device_put(sdp);
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 57caf1f91673..b7960ec46c9c 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -168,7 +168,6 @@ static inline int scsi_is_wlun(u64 lun)
 #define DRIVER_BUSY         0x01
 #define DRIVER_SOFT         0x02
 #define DRIVER_MEDIA        0x03
-#define DRIVER_ERROR        0x04
 
 /*
  * Internal return values.
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index 83bc7d97a469..b2d3ce9e3990 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -130,8 +130,7 @@
 		scsi_driverbyte_name(DRIVER_OK),		\
 		scsi_driverbyte_name(DRIVER_BUSY),		\
 		scsi_driverbyte_name(DRIVER_SOFT),		\
-		scsi_driverbyte_name(DRIVER_MEDIA),		\
-		scsi_driverbyte_name(DRIVER_ERROR))
+		scsi_driverbyte_name(DRIVER_MEDIA))
 
 #define scsi_msgbyte_name(result)	{ result, #result }
 #define show_msgbyte_name(val)					\
-- 
2.16.4

