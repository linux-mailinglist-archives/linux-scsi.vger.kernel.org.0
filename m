Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC7236C0FF
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhD0Icb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235166AbhD0IcM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:32:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F217DB16E;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 40/40] scsi: drop obsolete linux-specific SCSI status codes
Date:   Tue, 27 Apr 2021 10:30:46 +0200
Message-Id: <20210427083046.31620-41-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Originally the SCSI subsystem has been using 'special' SCSI status
codes, which were the SAM-specified ones but shifted by 1.
As most drivers have now been modified to use the SAM-specified
ones having two nearly identical sets of definitions only causes
confusion for no good reason.
And the linux-specifed SCSI status codes are marked obsolete since
several years now.
So drop them and use the SAM-specified status codes throughout.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libata-scsi.c             |  2 +-
 drivers/infiniband/ulp/srp/ib_srp.c   |  2 +-
 drivers/scsi/3w-9xxx.c                |  2 +-
 drivers/scsi/3w-xxxx.c                |  4 +--
 drivers/scsi/53c700.c                 |  6 ++--
 drivers/scsi/NCR5380.c                |  2 +-
 drivers/scsi/arcmsr/arcmsr_hba.c      |  4 +--
 drivers/scsi/esas2r/esas2r_main.c     |  2 +-
 drivers/scsi/megaraid.c               |  4 +--
 drivers/scsi/megaraid/megaraid_mbox.c |  4 +--
 drivers/scsi/scsi_error.c             | 48 +++++++++++++--------------
 drivers/scsi/scsi_lib.c               |  2 +-
 drivers/scsi/sr.c                     |  2 +-
 drivers/scsi/sr_ioctl.c               |  2 +-
 drivers/xen/xen-scsiback.c            |  2 +-
 include/scsi/scsi.h                   |  1 -
 include/scsi/scsi_proto.h             | 22 +-----------
 include/scsi/sg.h                     | 20 +++++++++++
 18 files changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 401990e87d50..3aa4bb666616 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -642,7 +642,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 		if (cmd->request->rq_flags & RQF_QUIET)
 			qc->flags |= ATA_QCFLAG_QUIET;
 	} else {
-		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
+		cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
 		cmd->scsi_done(cmd);
 	}
 
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 31f8aa2c40ed..62d9b70f7c63 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2232,7 +2232,7 @@ static int srp_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd)
 		 * to reduce queue depth temporarily.
 		 */
 		scmnd->result = len == -ENOMEM ?
-			DID_OK << 16 | QUEUE_FULL << 1 : DID_ERROR << 16;
+			DID_OK << 16 | SAM_STAT_TASK_SET_FULL : DID_ERROR << 16;
 		goto err_iu;
 	}
 
diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 47028f5e57ab..259393726ecb 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1342,7 +1342,7 @@ static irqreturn_t twa_interrupt(int irq, void *dev_instance)
 				/* If error, command failed */
 				if (error == 1) {
 					/* Ask for a host reset */
-					cmd->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+					cmd->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
 				}
 
 				/* Report residual bytes for single sgl */
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 7a0b4a44395d..4ee485ab2714 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -429,7 +429,7 @@ static int tw_decode_sense(TW_Device_Extension *tw_dev, int request_id, int fill
 					/* Additional sense code qualifier */
 					tw_dev->srb[request_id]->sense_buffer[13] = tw_sense_table[i][3];
 
-					tw_dev->srb[request_id]->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+					tw_dev->srb[request_id]->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
 					return TW_ISR_DONT_RESULT; /* Special case for isr to not over-write result */
 				}
 			}
@@ -2159,7 +2159,7 @@ static irqreturn_t tw_interrupt(int irq, void *dev_instance)
 				/* If error, command failed */
 				if (error == 1) {
 					/* Ask for a host reset */
-					tw_dev->srb[request_id]->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+					tw_dev->srb[request_id]->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
 				}
 
 				/* Now complete the io */
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index ab42feab233f..601a8df0bef3 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -979,10 +979,10 @@ process_script_interrupt(__u32 dsps, __u32 dsp, struct scsi_cmnd *SCp,
 		if (NCR_700_get_tag_neg_state(SCp->device) == NCR_700_DURING_TAG_NEGOTIATION)
 			NCR_700_set_tag_neg_state(SCp->device,
 						  NCR_700_FINISHED_TAG_NEGOTIATION);
-			
+
 		/* check for contingent allegiance conditions */
-		if (hostdata->status[0] >> 1 == CHECK_CONDITION ||
-		    hostdata->status[0] >> 1 == COMMAND_TERMINATED) {
+		if (hostdata->status[0] == SAM_STAT_CHECK_CONDITION ||
+		    hostdata->status[0] == SAM_STAT_COMMAND_TERMINATED) {
 			struct NCR_700_command_slot *slot =
 				(struct NCR_700_command_slot *)SCp->host_scribble;
 			if(slot->flags == NCR_700_FLAG_AUTOSENSE) {
diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index a74674941e7d..8aa964cd54df 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -538,7 +538,7 @@ static void complete_cmd(struct Scsi_Host *instance,
 
 	if (hostdata->sensing == cmd) {
 		/* Autosense processing ends here */
-		if (status_byte(cmd->result) != GOOD) {
+		if (get_status_byte(cmd) != SAM_STAT_GOOD) {
 			scsi_eh_restore_cmnd(cmd, &hostdata->ses);
 		} else {
 			scsi_eh_restore_cmnd(cmd, &hostdata->ses);
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 8e4d7d0e649c..5ea5e6010449 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -1326,7 +1326,7 @@ static void arcmsr_report_sense_info(struct CommandControlBlock *ccb)
 
 	struct scsi_cmnd *pcmd = ccb->pcmd;
 	struct SENSE_DATA *sensebuffer = (struct SENSE_DATA *)pcmd->sense_buffer;
-	pcmd->result = (DID_OK << 16) | (CHECK_CONDITION << 1);
+	pcmd->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
 	if (sensebuffer) {
 		int sense_data_length =
 			sizeof(struct SENSE_DATA) < SCSI_SENSE_BUFFERSIZE
@@ -3242,7 +3242,7 @@ static int arcmsr_queue_command_lck(struct scsi_cmnd *cmd,
 	if (!ccb)
 		return SCSI_MLQUEUE_HOST_BUSY;
 	if (arcmsr_build_ccb( acb, ccb, cmd ) == FAILED) {
-		cmd->result = (DID_ERROR << 16) | (RESERVATION_CONFLICT << 1);
+		cmd->result = (DID_ERROR << 16) | SAM_STAT_RESERVATION_CONFLICT;
 		cmd->scsi_done(cmd);
 		return 0;
 	}
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index a9dd6345f064..f7818df175a5 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -1525,7 +1525,7 @@ void esas2r_complete_request_cb(struct esas2r_adapter *a,
 
 		rq->cmd->result =
 			((esas2r_req_status_to_error(rq->req_stat) << 16)
-			 | (rq->func_rsp.scsi_rsp.scsi_stat & STATUS_MASK));
+			 | rq->func_rsp.scsi_rsp.scsi_stat);
 
 		if (rq->req_stat == RS_UNDERRUN)
 			scsi_set_resid(rq->cmd,
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 1880471c632a..56910e94dbf2 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1611,7 +1611,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 			 */
 			if( cmd->cmnd[0] == TEST_UNIT_READY ) {
 				cmd->result |= (DID_ERROR << 16) |
-					(RESERVATION_CONFLICT << 1);
+					SAM_STAT_RESERVATION_CONFLICT;
 			}
 			else
 			/*
@@ -1623,7 +1623,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 					 cmd->cmnd[0] == RELEASE) ) {
 
 				cmd->result |= (DID_ERROR << 16) |
-					(RESERVATION_CONFLICT << 1);
+					SAM_STAT_RESERVATION_CONFLICT;
 			}
 			else
 #endif
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 674f1c6829f5..db36e4369c2d 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -2327,7 +2327,7 @@ megaraid_mbox_dpc(unsigned long devp)
 			 */
 			if (scp->cmnd[0] == TEST_UNIT_READY) {
 				scp->result = DID_ERROR << 16 |
-					RESERVATION_CONFLICT << 1;
+					SAM_STAT_RESERVATION_CONFLICT;
 			}
 			else
 			/*
@@ -2338,7 +2338,7 @@ megaraid_mbox_dpc(unsigned long devp)
 					 scp->cmnd[0] == RELEASE)) {
 
 				scp->result = DID_ERROR << 16 |
-					RESERVATION_CONFLICT << 1;
+					SAM_STAT_RESERVATION_CONFLICT;
 			}
 			else {
 				scp->result = DID_BAD_TARGET << 16 | status;
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3e6e456816fc..c6cd5a8e5c85 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -745,32 +745,32 @@ static enum scsi_disposition scsi_eh_completed_normally(struct scsi_cmnd *scmd)
 	 * now, check the status byte to see if this indicates
 	 * anything special.
 	 */
-	switch (status_byte(scmd->result)) {
-	case GOOD:
+	switch (get_status_byte(scmd)) {
+	case SAM_STAT_GOOD:
 		scsi_handle_queue_ramp_up(scmd->device);
 		fallthrough;
-	case COMMAND_TERMINATED:
+	case SAM_STAT_COMMAND_TERMINATED:
 		return SUCCESS;
-	case CHECK_CONDITION:
+	case SAM_STAT_CHECK_CONDITION:
 		return scsi_check_sense(scmd);
-	case CONDITION_GOOD:
-	case INTERMEDIATE_GOOD:
-	case INTERMEDIATE_C_GOOD:
+	case SAM_STAT_CONDITION_MET:
+	case SAM_STAT_INTERMEDIATE:
+	case SAM_STAT_INTERMEDIATE_CONDITION_MET:
 		/*
 		 * who knows?  FIXME(eric)
 		 */
 		return SUCCESS;
-	case RESERVATION_CONFLICT:
+	case SAM_STAT_RESERVATION_CONFLICT:
 		if (scmd->cmnd[0] == TEST_UNIT_READY)
 			/* it is a success, we probed the device and
 			 * found it */
 			return SUCCESS;
 		/* otherwise, we failed to send the command */
 		return FAILED;
-	case QUEUE_FULL:
+	case SAM_STAT_TASK_SET_FULL:
 		scsi_handle_queue_full(scmd->device);
 		fallthrough;
-	case BUSY:
+	case SAM_STAT_BUSY:
 		return NEEDS_RETRY;
 	default:
 		return FAILED;
@@ -1760,7 +1760,7 @@ int scsi_noretry_cmd(struct scsi_cmnd *scmd)
 	case DID_PARITY:
 		return (scmd->request->cmd_flags & REQ_FAILFAST_DEV);
 	case DID_ERROR:
-		if (status_byte(scmd->result) == RESERVATION_CONFLICT)
+		if (get_status_byte(scmd) == SAM_STAT_RESERVATION_CONFLICT)
 			return 0;
 		fallthrough;
 	case DID_SOFT_ERROR:
@@ -1876,7 +1876,7 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 		 */
 		return SUCCESS;
 	case DID_ERROR:
-		if (status_byte(scmd->result) == RESERVATION_CONFLICT)
+		if (get_status_byte(scmd) == SAM_STAT_RESERVATION_CONFLICT)
 			/*
 			 * execute reservation conflict processing code
 			 * lower down
@@ -1907,15 +1907,15 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 	/*
 	 * check the status byte to see if this indicates anything special.
 	 */
-	switch (status_byte(scmd->result)) {
-	case QUEUE_FULL:
+	switch (get_status_byte(scmd)) {
+	case SAM_STAT_TASK_SET_FULL:
 		scsi_handle_queue_full(scmd->device);
 		/*
 		 * the case of trying to send too many commands to a
 		 * tagged queueing device.
 		 */
 		fallthrough;
-	case BUSY:
+	case SAM_STAT_BUSY:
 		/*
 		 * device can't talk to us at the moment.  Should only
 		 * occur (SAM-3) when the task queue is empty, so will cause
@@ -1923,16 +1923,16 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 		 * device.
 		 */
 		return ADD_TO_MLQUEUE;
-	case GOOD:
+	case SAM_STAT_GOOD:
 		if (scmd->cmnd[0] == REPORT_LUNS)
 			scmd->device->sdev_target->expecting_lun_change = 0;
 		scsi_handle_queue_ramp_up(scmd->device);
 		fallthrough;
-	case COMMAND_TERMINATED:
+	case SAM_STAT_COMMAND_TERMINATED:
 		return SUCCESS;
-	case TASK_ABORTED:
+	case SAM_STAT_TASK_ABORTED:
 		goto maybe_retry;
-	case CHECK_CONDITION:
+	case SAM_STAT_CHECK_CONDITION:
 		rtn = scsi_check_sense(scmd);
 		if (rtn == NEEDS_RETRY)
 			goto maybe_retry;
@@ -1941,16 +1941,16 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 		 * to collect the sense and redo the decide
 		 * disposition */
 		return rtn;
-	case CONDITION_GOOD:
-	case INTERMEDIATE_GOOD:
-	case INTERMEDIATE_C_GOOD:
-	case ACA_ACTIVE:
+	case SAM_STAT_CONDITION_MET:
+	case SAM_STAT_INTERMEDIATE:
+	case SAM_STAT_INTERMEDIATE_CONDITION_MET:
+	case SAM_STAT_ACA_ACTIVE:
 		/*
 		 * who knows?  FIXME(eric)
 		 */
 		return SUCCESS;
 
-	case RESERVATION_CONFLICT:
+	case SAM_STAT_RESERVATION_CONFLICT:
 		sdev_printk(KERN_INFO, scmd->device,
 			    "reservation conflict\n");
 		set_host_byte(scmd, DID_NEXUS_FAILURE);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e8617c6bbf7a..89b1bef5877c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -907,7 +907,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 	 * if it can't fit). Treat SAM_STAT_CONDITION_MET and the related
 	 * intermediate statuses (both obsolete in SAM-4) as good.
 	 */
-	if (status_byte(result) && scsi_status_is_good(result)) {
+	if ((result & 0xff) && scsi_status_is_good(result)) {
 		result = 0;
 		*blk_statp = BLK_STS_OK;
 	}
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index e9cb874f6891..482a07b662a9 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -338,7 +338,7 @@ static int sr_done(struct scsi_cmnd *SCpnt)
 	 * care is taken to avoid unnecessary additional work such as
 	 * memcpy's that could be avoided.
 	 */
-	if (status_byte(result) == SAM_STAT_CHECK_CONDITION &&
+	if (scsi_status_is_check_condition(result) &&
 	    (SCpnt->sense_buffer[0] & 0x7f) == 0x70) { /* Sense current */
 		switch (SCpnt->sense_buffer[2]) {
 		case MEDIUM_ERROR:
diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index 74348ead5b11..b34a5332fd2d 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -209,7 +209,7 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)
 		err = result;
 		goto out;
 	}
-	if (status_byte(result) == SAM_STAT_CHECK_CONDITION) {
+	if (scsi_status_is_check_condition(result)) {
 		switch (sshdr->sense_key) {
 		case UNIT_ATTENTION:
 			SDev->changed = 1;
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index bea22f71c782..61ce0d142eea 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -224,7 +224,7 @@ static void scsiback_print_status(char *sense_buffer, int errors,
 
 	pr_err("[%s:%d] cmnd[0]=%02x -> st=%02x msg=%02x host=%02x\n",
 	       tpg->tport->tport_name, pending_req->v2p->lun,
-	       pending_req->cmnd[0], status_byte(errors), COMMAND_COMPLETE,
+	       pending_req->cmnd[0], errors & 0xff, COMMAND_COMPLETE,
 	       host_byte(errors));
 }
 
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 8fe0c628d20b..e39057c38208 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -213,7 +213,6 @@ enum scsi_disposition {
  *      msg_byte    (unused)
  *      host_byte   = set by low-level driver to indicate status.
  */
-#define status_byte(result) (((result) >> 1) & 0x7f)
 #define host_byte(result)   (((result) >> 16) & 0xff)
 
 #define sense_class(sense)  (((sense) >> 4) & 0x7)
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index c36860111932..80bb1c5f11f1 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -202,27 +202,7 @@ struct scsi_varlen_cdb_hdr {
 #define SAM_STAT_ACA_ACTIVE      0x30
 #define SAM_STAT_TASK_ABORTED    0x40
 
-/*
- *  Status codes. These are deprecated as they are shifted 1 bit right
- *  from those found in the SCSI standards. This causes confusion for
- *  applications that are ported to several OSes. Prefer SAM Status codes
- *  above.
- */
-
-#define GOOD                 0x00
-#define CHECK_CONDITION      0x01
-#define CONDITION_GOOD       0x02
-#define BUSY                 0x04
-#define INTERMEDIATE_GOOD    0x08
-#define INTERMEDIATE_C_GOOD  0x0a
-#define RESERVATION_CONFLICT 0x0c
-#define COMMAND_TERMINATED   0x11
-#define QUEUE_FULL           0x14
-#define ACA_ACTIVE           0x18
-#define TASK_ABORTED         0x20
-
-#define STATUS_MASK          0xfe
-
+#define STATUS_MASK         0xfe
 /*
  *  SENSE KEYS
  */
diff --git a/include/scsi/sg.h b/include/scsi/sg.h
index f6b18591ed9d..49a393694b29 100644
--- a/include/scsi/sg.h
+++ b/include/scsi/sg.h
@@ -145,6 +145,26 @@ struct compat_sg_io_hdr {
 /* Obsolete driver_byte() declaration */
 #define driver_byte(result) (((result) >> 24) & 0xff)
 
+/*
+ *  Original linux SCSI Status codes. They are shifted 1 bit right
+ *  from those found in the SCSI standards.
+ */
+
+#define GOOD                 0x00
+#define CHECK_CONDITION      0x01
+#define CONDITION_GOOD       0x02
+#define BUSY                 0x04
+#define INTERMEDIATE_GOOD    0x08
+#define INTERMEDIATE_C_GOOD  0x0a
+#define RESERVATION_CONFLICT 0x0c
+#define COMMAND_TERMINATED   0x11
+#define QUEUE_FULL           0x14
+#define ACA_ACTIVE           0x18
+#define TASK_ABORTED         0x20
+
+/* Obsolete status_byte() declaration */
+#define status_byte(result) (((result) >> 1) & 0x7f)
+
 typedef struct sg_scsi_id { /* used by SG_GET_SCSI_ID ioctl() */
     int host_no;        /* as in "scsi<n>" where 'n' is one of 0, 1, 2 etc */
     int channel;
-- 
2.29.2

