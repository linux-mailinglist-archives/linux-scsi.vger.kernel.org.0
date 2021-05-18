Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31262387EAD
	for <lists+linux-scsi@lfdr.de>; Tue, 18 May 2021 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351179AbhERRqT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 May 2021 13:46:19 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:36560 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351139AbhERRqT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 May 2021 13:46:19 -0400
Received: by mail-pl1-f180.google.com with SMTP id a11so5523548plh.3
        for <linux-scsi@vger.kernel.org>; Tue, 18 May 2021 10:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSo7M6n0o/5cKnCi/pe9gsGOcYpa5IQIyNYHD0ZDovU=;
        b=O6l4OQ9xWNtqIJuFrVlHbtXU0dN9pqIvG0ExyhFzvb+U6xpqb+EGaCswp+Pc1arAwc
         t72goD1vi2IQ6XcXwMu6sWieGVksHqbpUbkQclZdBRNFZfgs038ne+QLWm79tEvrBOZ/
         t+hdWT05PX69wYj1Z6aRWr5Z7idiA2dPkYGJeeNQUsI3FfCmdAfSSzPolIbqhh8adFWS
         oOyDDjXqssN3Szqtywj/Xz3tmyqKNGJgdnVTpQoAryRFgUzgjO26XWrVbXAejUKEmleN
         FltXW/cseP5BTh/7muGwqeWC3zWagRggUtx48mkElrW8gpTbScalxv125vPlmA6W5+Bw
         ia5w==
X-Gm-Message-State: AOAM5331iZhzBaPFiO1E1anyuHGssR7ra3KvriQQq3ztYB5D1xMjdGiq
        GVQvcA5L/GCy78ELLCb7vdiTXsY+qZw=
X-Google-Smtp-Source: ABdhPJx1mlulLMCiecYI1PpeQB0uV0KTx3oaEVTj4HpIMKTxIO9/Sb5t0EK5/1fbdhasf+i6Sbar8w==
X-Received: by 2002:a17:902:bf0b:b029:ed:c29a:2166 with SMTP id bi11-20020a170902bf0bb02900edc29a2166mr5944373plb.75.1621359899586;
        Tue, 18 May 2021 10:44:59 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:4ae4:fc49:eafe:4150])
        by smtp.gmail.com with ESMTPSA id z27sm12656920pfr.46.2021.05.18.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:44:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 02/50] core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request
Date:   Tue, 18 May 2021 10:44:02 -0700
Message-Id: <20210518174450.20664-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518174450.20664-1-bvanassche@acm.org>
References: <20210518174450.20664-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Prepare for removal of the request pointer by using scsi_cmd_to_rq()
instead. This patch does not change any functionality.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c         |  2 +-
 drivers/scsi/scsi_error.c   | 14 +++++++-------
 drivers/scsi/scsi_lib.c     | 28 +++++++++++++++-------------
 drivers/scsi/scsi_logging.c | 18 ++++++++++--------
 include/scsi/scsi_cmnd.h    |  6 ++++--
 include/scsi/scsi_device.h  | 16 +++++++++-------
 6 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index e9e2f0e15ac8..7d545223dd59 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -197,7 +197,7 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
 				"(result %x)\n", cmd->result));
 
 	good_bytes = scsi_bufflen(cmd);
-	if (!blk_rq_is_passthrough(cmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
 		int old_good_bytes = good_bytes;
 		drv = scsi_cmd_to_driver(cmd);
 		if (drv->done)
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index d8fafe77dbbe..5af6d87e83aa 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -242,7 +242,7 @@ scsi_abort_command(struct scsi_cmnd *scmd)
  */
 static void scsi_eh_reset(struct scsi_cmnd *scmd)
 {
-	if (!blk_rq_is_passthrough(scmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_reset)
 			sdrv->eh_reset(scmd);
@@ -1188,7 +1188,7 @@ static enum scsi_disposition scsi_request_sense(struct scsi_cmnd *scmd)
 static enum scsi_disposition
 scsi_eh_action(struct scsi_cmnd *scmd, enum scsi_disposition rtn)
 {
-	if (!blk_rq_is_passthrough(scmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(scmd))) {
 		struct scsi_driver *sdrv = scsi_cmd_to_driver(scmd);
 		if (sdrv->eh_action)
 			rtn = sdrv->eh_action(scmd, rtn);
@@ -1762,16 +1762,16 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	case DID_TIME_OUT:
 		goto check_type;
 	case DID_BUS_BUSY:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_TRANSPORT);
+		return scsi_cmd_to_rq(scmd)->cmd_flags & REQ_FAILFAST_TRANSPORT;
 	case DID_PARITY:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_DEV);
+		return scsi_cmd_to_rq(scmd)->cmd_flags & REQ_FAILFAST_DEV;
 	case DID_ERROR:
 		if (msg_byte(scmd->result) == COMMAND_COMPLETE &&
 		    status_byte(scmd->result) == RESERVATION_CONFLICT)
 			return 0;
 		fallthrough;
 	case DID_SOFT_ERROR:
-		return (scmd->request->cmd_flags & REQ_FAILFAST_DRIVER);
+		return scsi_cmd_to_rq(scmd)->cmd_flags & REQ_FAILFAST_DRIVER;
 	}
 
 	if (status_byte(scmd->result) != CHECK_CONDITION)
@@ -1782,8 +1782,8 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	 * assume caller has checked sense and determined
 	 * the check condition was retryable.
 	 */
-	if (scmd->request->cmd_flags & REQ_FAILFAST_DEV ||
-	    blk_rq_is_passthrough(scmd->request))
+	if (scsi_cmd_to_rq(scmd)->cmd_flags & REQ_FAILFAST_DEV ||
+	    blk_rq_is_passthrough(scsi_cmd_to_rq(scmd)))
 		return 1;
 
 	return 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 532304d42f00..2e9598c91cee 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -119,13 +119,15 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
-	if (cmd->request->rq_flags & RQF_DONTPREP) {
-		cmd->request->rq_flags &= ~RQF_DONTPREP;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+
+	if (rq->rq_flags & RQF_DONTPREP) {
+		rq->rq_flags &= ~RQF_DONTPREP;
 		scsi_mq_uninit_cmd(cmd);
 	} else {
 		WARN_ON_ONCE(true);
 	}
-	blk_mq_requeue_request(cmd->request, true);
+	blk_mq_requeue_request(rq, true);
 }
 
 /**
@@ -164,7 +166,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 */
 	cmd->result = 0;
 
-	blk_mq_requeue_request(cmd->request, true);
+	blk_mq_requeue_request(scsi_cmd_to_rq(cmd), true);
 }
 
 /**
@@ -475,7 +477,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	if (!blk_rq_is_passthrough(cmd->request)) {
+	if (!blk_rq_is_passthrough(scsi_cmd_to_rq(cmd))) {
 		struct scsi_driver *drv = scsi_cmd_to_driver(cmd);
 
 		if (drv->uninit_command)
@@ -626,7 +628,7 @@ static void scsi_io_completion_reprep(struct scsi_cmnd *cmd,
 
 static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 {
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	unsigned long wait_for;
 
 	if (cmd->allowed == SCSI_CMD_RETRIES_NO_LIMIT)
@@ -645,7 +647,7 @@ static bool scsi_cmd_runtime_exceeced(struct scsi_cmnd *cmd)
 static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 {
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	int level = 0;
 	enum {ACTION_FAIL, ACTION_REPREP, ACTION_RETRY,
 	      ACTION_DELAYED_RETRY} action;
@@ -819,7 +821,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 {
 	bool sense_valid;
 	bool sense_current = true;	/* false implies "deferred sense" */
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	struct scsi_sense_hdr sshdr;
 
 	sense_valid = scsi_command_normalize_sense(cmd, &sshdr);
@@ -908,7 +910,7 @@ void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
 	struct request_queue *q = cmd->device->request_queue;
-	struct request *req = cmd->request;
+	struct request *req = scsi_cmd_to_rq(cmd);
 	blk_status_t blk_stat = BLK_STS_OK;
 
 	if (unlikely(result))	/* a nz result may or may not be an error */
@@ -979,7 +981,7 @@ static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
 blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdev = cmd->device;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
 	struct scatterlist *last_sg = NULL;
 	blk_status_t ret;
@@ -1108,7 +1110,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
 	void *buf = cmd->sense_buffer;
 	void *prot = cmd->prot_sdb;
-	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned int flags = cmd->flags & SCMD_PRESERVED_FLAGS;
 	unsigned long jiffies_at_alloc;
 	int retries, to_clear;
@@ -1573,12 +1575,12 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
-	if (unlikely(blk_should_fake_timeout(cmd->request->q)))
+	if (unlikely(blk_should_fake_timeout(scsi_cmd_to_rq(cmd)->q)))
 		return;
 	if (unlikely(test_and_set_bit(SCMD_STATE_COMPLETE, &cmd->state)))
 		return;
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+	blk_mq_complete_request(scsi_cmd_to_rq(cmd));
 }
 
 static void scsi_mq_put_budget(struct request_queue *q, int budget_token)
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 8ea44c6595ef..f0ae55ad0973 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -28,8 +28,9 @@ static void scsi_log_release_buffer(char *bufptr)
 
 static inline const char *scmd_name(const struct scsi_cmnd *scmd)
 {
-	return scmd->request->rq_disk ?
-		scmd->request->rq_disk->disk_name : NULL;
+	struct request *rq = scsi_cmd_to_rq((struct scsi_cmnd *)scmd);
+
+	return rq->rq_disk ? rq->rq_disk->disk_name : NULL;
 }
 
 static size_t sdev_format_header(char *logbuf, size_t logbuf_len,
@@ -91,7 +92,7 @@ void scmd_printk(const char *level, const struct scsi_cmnd *scmd,
 	if (!logbuf)
 		return;
 	off = sdev_format_header(logbuf, logbuf_len, scmd_name(scmd),
-				 scmd->request->tag);
+				 scsi_cmd_to_rq((struct scsi_cmnd *)scmd)->tag);
 	if (off < logbuf_len) {
 		va_start(args, fmt);
 		off += vscnprintf(logbuf + off, logbuf_len - off, fmt, args);
@@ -188,7 +189,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 		return;
 
 	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), cmd->request->tag);
+				 scmd_name(cmd), scsi_cmd_to_rq(cmd)->tag);
 	if (off >= logbuf_len)
 		goto out_printk;
 	off += scnprintf(logbuf + off, logbuf_len - off, "CDB: ");
@@ -210,7 +211,7 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 
 			off = sdev_format_header(logbuf, logbuf_len,
 						 scmd_name(cmd),
-						 cmd->request->tag);
+						 scsi_cmd_to_rq(cmd)->tag);
 			if (!WARN_ON(off > logbuf_len - 58)) {
 				off += scnprintf(logbuf + off, logbuf_len - off,
 						 "CDB[%02x]: ", k);
@@ -373,7 +374,8 @@ EXPORT_SYMBOL(__scsi_print_sense);
 /* Normalize and print sense buffer in SCSI command */
 void scsi_print_sense(const struct scsi_cmnd *cmd)
 {
-	scsi_log_print_sense(cmd->device, scmd_name(cmd), cmd->request->tag,
+	scsi_log_print_sense(cmd->device, scmd_name(cmd),
+			     scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag,
 			     cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 }
 EXPORT_SYMBOL(scsi_print_sense);
@@ -392,8 +394,8 @@ void scsi_print_result(const struct scsi_cmnd *cmd, const char *msg,
 	if (!logbuf)
 		return;
 
-	off = sdev_format_header(logbuf, logbuf_len,
-				 scmd_name(cmd), cmd->request->tag);
+	off = sdev_format_header(logbuf, logbuf_len, scmd_name(cmd),
+				 scsi_cmd_to_rq((struct scsi_cmnd *)cmd)->tag);
 
 	if (off >= logbuf_len)
 		goto out_printk;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 6787670d0d16..bd7f73f035be 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -164,7 +164,9 @@ static inline void *scsi_cmd_priv(struct scsi_cmnd *cmd)
 /* make sure not to use it with passthrough commands */
 static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 {
-	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
+	struct request *rq = scsi_cmd_to_rq(cmd);
+
+	return *(struct scsi_driver **)rq->rq_disk->private_data;
 }
 
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
@@ -290,7 +292,7 @@ static inline unsigned char scsi_get_prot_type(struct scsi_cmnd *scmd)
 
 static inline sector_t scsi_get_lba(struct scsi_cmnd *scmd)
 {
-	return blk_rq_pos(scmd->request);
+	return blk_rq_pos(scsi_cmd_to_rq(scmd));
 }
 
 static inline unsigned int scsi_prot_interval(struct scsi_cmnd *scmd)
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index ac6ab16abee7..09797a2b779d 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -265,13 +265,15 @@ sdev_prefix_printk(const char *, const struct scsi_device *, const char *,
 __printf(3, 4) void
 scmd_printk(const char *, const struct scsi_cmnd *, const char *, ...);
 
-#define scmd_dbg(scmd, fmt, a...)					   \
-	do {								   \
-		if ((scmd)->request->rq_disk)				   \
-			sdev_dbg((scmd)->device, "[%s] " fmt,		   \
-				 (scmd)->request->rq_disk->disk_name, ##a);\
-		else							   \
-			sdev_dbg((scmd)->device, fmt, ##a);		   \
+#define scmd_dbg(scmd, fmt, a...)				\
+	do {							\
+		struct request *rq = scsi_cmd_to_rq((scmd));	\
+								\
+		if (rq->rq_disk)				\
+			sdev_dbg((scmd)->device, "[%s] " fmt,	\
+				 rq->rq_disk->disk_name, ##a);	\
+		else						\
+			sdev_dbg((scmd)->device, fmt, ##a);	\
 	} while (0)
 
 enum scsi_target_state {
