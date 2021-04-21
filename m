Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC93671CF
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbhDURtR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:52322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245018AbhDURtA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 795B5B154;
        Wed, 21 Apr 2021 17:48:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/42] scsi: Drop the now obsolete driver_byte definitions
Date:   Wed, 21 Apr 2021 19:47:19 +0200
Message-Id: <20210421174749.11221-13-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

The driver_byte field in the result is now unused, so we can drop
the definitions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 Documentation/scsi/scsi_mid_low_api.rst |  3 +--
 block/bsg-lib.c                         |  2 +-
 block/bsg.c                             |  2 +-
 block/scsi_ioctl.c                      |  2 +-
 drivers/scsi/constants.c                | 15 ---------------
 drivers/scsi/scsi_logging.c             | 10 ++--------
 drivers/scsi/sd.c                       |  9 ++++-----
 drivers/scsi/sr.c                       |  2 +-
 drivers/scsi/sr_ioctl.c                 |  2 +-
 drivers/scsi/st.c                       |  4 ++--
 drivers/xen/xen-scsiback.c              |  4 ++--
 include/scsi/scsi.h                     | 16 ----------------
 include/scsi/scsi_cmnd.h                |  4 ----
 include/scsi/sg.h                       |  2 ++
 include/trace/events/scsi.h             | 15 +--------------
 15 files changed, 19 insertions(+), 73 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 5bc17d012b25..2c87eaa36296 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -1178,8 +1178,7 @@ Members of interest:
                    target device). 'result' is a 32 bit unsigned integer that
                    can be viewed as 4 related bytes. The SCSI status value is
                    in the LSB. See include/scsi/scsi.h status_byte(),
-                   msg_byte(), host_byte() and driver_byte() macros and
-                   related constants.
+                   msg_byte() and host_byte() macros and related constants.
     sense_buffer
 		 - an array (maximum size: SCSI_SENSE_BUFFERSIZE bytes) that
                    should be written when the SCSI status (LSB of 'result')
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 330fede77271..cf1811261722 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -84,7 +84,7 @@ static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 	 */
 	hdr->device_status = job->result & 0xff;
 	hdr->transport_status = host_byte(job->result);
-	hdr->driver_status = driver_byte(job->result);
+	hdr->driver_status = 0;
 	hdr->info = 0;
 	if (hdr->device_status || hdr->transport_status || hdr->driver_status)
 		hdr->info |= SG_INFO_CHECK;
diff --git a/block/bsg.c b/block/bsg.c
index bd10922d5cbb..dadc72052a14 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -96,7 +96,7 @@ static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 	 */
 	hdr->device_status = sreq->result & 0xff;
 	hdr->transport_status = host_byte(sreq->result);
-	hdr->driver_status = driver_byte(sreq->result);
+	hdr->driver_status = 0;
 	hdr->info = 0;
 	if (hdr->device_status || hdr->transport_status || hdr->driver_status)
 		hdr->info |= SG_INFO_CHECK;
diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 99d58786e0d5..ab2579467316 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -256,7 +256,7 @@ static int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
 	hdr->masked_status = status_byte(req->result);
 	hdr->msg_status = msg_byte(req->result);
 	hdr->host_status = host_byte(req->result);
-	hdr->driver_status = driver_byte(req->result);
+	hdr->driver_status = 0;
 	hdr->info = 0;
 	if (hdr->masked_status || hdr->host_status || hdr->driver_status)
 		hdr->info |= SG_INFO_CHECK;
diff --git a/drivers/scsi/constants.c b/drivers/scsi/constants.c
index 84d73f57292b..41bcfed08260 100644
--- a/drivers/scsi/constants.c
+++ b/drivers/scsi/constants.c
@@ -406,10 +406,6 @@ static const char * const hostbyte_table[]={
 "DID_TRANSPORT_DISRUPTED", "DID_TRANSPORT_FAILFAST", "DID_TARGET_FAILURE",
 "DID_NEXUS_FAILURE", "DID_ALLOC_FAILURE", "DID_MEDIUM_ERROR" };
 
-static const char * const driverbyte_table[]={
-"DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA", "DRIVER_ERROR",
-"DRIVER_INVALID", "DRIVER_TIMEOUT", "DRIVER_HARD", "DRIVER_SENSE"};
-
 const char *scsi_hostbyte_string(int result)
 {
 	const char *hb_string = NULL;
@@ -421,17 +417,6 @@ const char *scsi_hostbyte_string(int result)
 }
 EXPORT_SYMBOL(scsi_hostbyte_string);
 
-const char *scsi_driverbyte_string(int result)
-{
-	const char *db_string = NULL;
-	int db = driver_byte(result);
-
-	if (db < ARRAY_SIZE(driverbyte_table))
-		db_string = driverbyte_table[db];
-	return db_string;
-}
-EXPORT_SYMBOL(scsi_driverbyte_string);
-
 #define scsi_mlreturn_name(result)	{ result, #result }
 static const struct value_name_pair scsi_mlreturn_arr[] = {
 	scsi_mlreturn_name(NEEDS_RETRY),
diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 8ea44c6595ef..2317717935e9 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -385,7 +385,6 @@ void scsi_print_result(const struct scsi_cmnd *cmd, const char *msg,
 	size_t off, logbuf_len;
 	const char *mlret_string = scsi_mlreturn_string(disposition);
 	const char *hb_string = scsi_hostbyte_string(cmd->result);
-	const char *db_string = scsi_driverbyte_string(cmd->result);
 	unsigned long cmd_age = (jiffies - cmd->jiffies_at_alloc) / HZ;
 
 	logbuf = scsi_log_reserve_buffer(&logbuf_len);
@@ -426,13 +425,8 @@ void scsi_print_result(const struct scsi_cmnd *cmd, const char *msg,
 	if (WARN_ON(off >= logbuf_len))
 		goto out_printk;
 
-	if (db_string)
-		off += scnprintf(logbuf + off, logbuf_len - off,
-				 "driverbyte=%s ", db_string);
-	else
-		off += scnprintf(logbuf + off, logbuf_len - off,
-				 "driverbyte=0x%02x ",
-				 driver_byte(cmd->result));
+	off += scnprintf(logbuf + off, logbuf_len - off,
+			 "driverbyte=DRIVER_OK ");
 
 	off += scnprintf(logbuf + off, logbuf_len - off,
 			 "cmd_age=%lus", cmd_age);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7537c2873efd..681b6b237347 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3811,15 +3811,14 @@ void sd_print_sense_hdr(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 void sd_print_result(const struct scsi_disk *sdkp, const char *msg, int result)
 {
 	const char *hb_string = scsi_hostbyte_string(result);
-	const char *db_string = scsi_driverbyte_string(result);
 
-	if (hb_string || db_string)
+	if (hb_string)
 		sd_printk(KERN_INFO, sdkp,
 			  "%s: Result: hostbyte=%s driverbyte=%s\n", msg,
 			  hb_string ? hb_string : "invalid",
-			  db_string ? db_string : "invalid");
+			  "DRIVER_OK");
 	else
 		sd_printk(KERN_INFO, sdkp,
-			  "%s: Result: hostbyte=0x%02x driverbyte=0x%02x\n",
-			  msg, host_byte(result), driver_byte(result));
+			  "%s: Result: hostbyte=0x%02x driverbyte=%s\n",
+			  msg, host_byte(result), "DRIVER_OK");
 }
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 9b2ccf0c9a8c..e9cb874f6891 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -338,7 +338,7 @@ static int sr_done(struct scsi_cmnd *SCpnt)
 	 * care is taken to avoid unnecessary additional work such as
 	 * memcpy's that could be avoided.
 	 */
-	if (driver_byte(result) != 0 &&		/* An error occurred */
+	if (status_byte(result) == SAM_STAT_CHECK_CONDITION &&
 	    (SCpnt->sense_buffer[0] & 0x7f) == 0x70) { /* Sense current */
 		switch (SCpnt->sense_buffer[2]) {
 		case MEDIUM_ERROR:
diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index a78f2138d784..74348ead5b11 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -209,7 +209,7 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 		err = result;
 		goto out;
 	}
-	if (driver_byte(result) != 0) {
+	if (status_byte(result) == SAM_STAT_CHECK_CONDITION) {
 		switch (sshdr->sense_key) {
 		case UNIT_ATTENTION:
 			SDev->changed = 1;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 23be6447e576..8ab12d07de31 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -390,8 +390,8 @@ static int st_chk_result(struct scsi_tape *STp, struct st_request * SRpnt)
 	if (!debugging) { /* Abnormal conditions for tape */
 		if (!cmdstatp->have_sense)
 			st_printk(KERN_WARNING, STp,
-			       "Error %x (driver bt 0x%x, host bt 0x%x).\n",
-			       result, driver_byte(result), host_byte(result));
+			       "Error %x (driver bt 0, host bt 0x%x).\n",
+			       result, host_byte(result));
 		else if (cmdstatp->have_sense &&
 			 scode != NO_SENSE &&
 			 scode != RECOVERED_ERROR &&
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index f274e078312e..8efeddd96367 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -222,10 +222,10 @@ static void scsiback_print_status(char *sense_buffer, int errors,
 {
 	struct scsiback_tpg *tpg = pending_req->v2p->tpg;
 
-	pr_err("[%s:%d] cmnd[0]=%02x -> st=%02x msg=%02x host=%02x drv=%02x\n",
+	pr_err("[%s:%d] cmnd[0]=%02x -> st=%02x msg=%02x host=%02x\n",
 	       tpg->tport->tport_name, pending_req->v2p->lun,
 	       pending_req->cmnd[0], status_byte(errors), msg_byte(errors),
-	       host_byte(errors), driver_byte(errors));
+	       host_byte(errors));
 }
 
 static void scsiback_fast_flush_area(struct vscsibk_pend *req)
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index d0a24e55ad63..5ed1c256ea94 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -166,20 +166,6 @@ static inline int scsi_is_wlun(u64 lun)
 #define DID_TRANSPORT_MARGINAL 0x14 /* Transport marginal errors */
 #define DRIVER_OK       0x00	/* Driver status                           */
 
-/*
- *  These indicate the error that occurred, and what is available.
- */
-
-#define DRIVER_BUSY         0x01
-#define DRIVER_SOFT         0x02
-#define DRIVER_MEDIA        0x03
-#define DRIVER_ERROR        0x04
-
-#define DRIVER_INVALID      0x05
-#define DRIVER_TIMEOUT      0x06
-#define DRIVER_HARD         0x07
-#define DRIVER_SENSE	    0x08
-
 /*
  * Internal return values.
  */
@@ -211,12 +197,10 @@ enum scsi_disposition {
  *      status byte = set from target device
  *      msg_byte    = return status from host adapter itself.
  *      host_byte   = set by low-level driver to indicate status.
- *      driver_byte = set by mid-level.
  */
 #define status_byte(result) (((result) >> 1) & 0x7f)
 #define msg_byte(result)    (((result) >> 8) & 0xff)
 #define host_byte(result)   (((result) >> 16) & 0xff)
-#define driver_byte(result) (((result) >> 24) & 0xff)
 
 #define sense_class(sense)  (((sense) >> 4) & 0x7)
 #define sense_error(sense)  ((sense) & 0xf)
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index b3eaf4b74b72..a1eb7732aa1b 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -326,10 +326,6 @@ static inline void set_host_byte(struct scsi_cmnd *cmd, char status)
 	cmd->result = (cmd->result & 0xff00ffff) | (status << 16);
 }
 
-static inline void set_driver_byte(struct scsi_cmnd *cmd, char status)
-{
-	cmd->result = (cmd->result & 0x00ffffff) | (status << 24);
-}
 
 static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 {
diff --git a/include/scsi/sg.h b/include/scsi/sg.h
index a90703cf15f4..350470298aef 100644
--- a/include/scsi/sg.h
+++ b/include/scsi/sg.h
@@ -133,6 +133,8 @@ struct compat_sg_io_hdr {
 
 /* Obsolete DRIVER_SENSE setting */
 #define DRIVER_SENSE 0x08
+/* Obsolete driver_byte() declaration */
+#define driver_byte(result) (((result) >> 24) & 0xff)
 
 typedef struct sg_scsi_id { /* used by SG_GET_SCSI_ID ioctl() */
     int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index f624969a4f14..428cca71c2ba 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -124,19 +124,6 @@
 		scsi_hostbyte_name(DID_TRANSPORT_DISRUPTED),	\
 		scsi_hostbyte_name(DID_TRANSPORT_FAILFAST))
 
-#define scsi_driverbyte_name(result)	{ result, #result }
-#define show_driverbyte_name(val)				\
-	__print_symbolic(val,					\
-		scsi_driverbyte_name(DRIVER_OK),		\
-		scsi_driverbyte_name(DRIVER_BUSY),		\
-		scsi_driverbyte_name(DRIVER_SOFT),		\
-		scsi_driverbyte_name(DRIVER_MEDIA),		\
-		scsi_driverbyte_name(DRIVER_ERROR),		\
-		scsi_driverbyte_name(DRIVER_INVALID),		\
-		scsi_driverbyte_name(DRIVER_TIMEOUT),		\
-		scsi_driverbyte_name(DRIVER_HARD),		\
-		scsi_driverbyte_name(DRIVER_SENSE))
-
 #define scsi_msgbyte_name(result)	{ result, #result }
 #define show_msgbyte_name(val)					\
 	__print_symbolic(val,					\
@@ -327,7 +314,7 @@ DECLARE_EVENT_CLASS(scsi_cmd_done_timeout_template,
 		  show_opcode_name(__entry->opcode),
 		  __parse_cdb(__get_dynamic_array(cmnd), __entry->cmd_len),
 		  __print_hex(__get_dynamic_array(cmnd), __entry->cmd_len),
-		  show_driverbyte_name(((__entry->result) >> 24) & 0xff),
+		  "DRIVER_OK",
 		  show_hostbyte_name(((__entry->result) >> 16) & 0xff),
 		  show_msgbyte_name(((__entry->result) >> 8) & 0xff),
 		  show_statusbyte_name(__entry->result & 0xff))
-- 
2.29.2

