Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637266674BB
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Jan 2023 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjALOL4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Jan 2023 09:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjALOKc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Jan 2023 09:10:32 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56540544C1;
        Thu, 12 Jan 2023 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673532326; x=1705068326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOuCIr+MGJ77HOgz5DJNZUGIKNaNk6JE5lDe7dZCNr8=;
  b=rRFYwcd2qrTF8kOUYxGko7HOl8otgYyaFZShNhJ1kUylQCgB5H6E1thg
   OOn85ZJkZQWOqSz1V/qDgwwNGlWdsG5LJlpfkTiZ5pWEZt1HaNdVyvrUL
   UvU6txJgpIaLRO8st8Ei2ITZ1cObInyTtyVn1Vs2OOC+9AMqFt/WSX2SI
   bhOYQptHgQ9qSViWobDDVN3Cwb0zoRtGeTAEj+BmkSl9FFnN2Oi30COpj
   bHGoABW+XN7bpfSPZtWQHU95+mI6IhnqQrqfYkfYgA2cnBitkCw0XhsRe
   Zg39yY+vSzNo3uDV2NTa8FcCOUDrPzdxhthRfKsouH7h7yTSnmzLYPxrS
   A==;
X-IronPort-AV: E=Sophos;i="5.97,211,1669046400"; 
   d="scan'208";a="332632753"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 22:05:09 +0800
IronPort-SDR: Nw8N7r/djYigBYlfD+VtHWHx07D/vEpC/nePQ9bSNprhJJKGAVOo5IbsHKXcIvrgN476CSleFw
 h5nKRQ5qNsvhXEw+McB7VV/+05dm/5LswQ2h63WxXSIihv9CCoSqvJheqsgpIAkp0T/mPF74Md
 CDubYrmzs9XBHU8sJZqi/tA17vIP7Ft2FYJSCLEhjc6YZcQWlvBotgCnSkR3j4aG6KU5OXMAYr
 mNl+mNdcg+K5tsvqoNOmASp8772ZyvUa+xW273RCCLcA/lxsi3JXn2UTSZqb1yv95Z9KJxUFOw
 0DE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jan 2023 05:17:12 -0800
IronPort-SDR: HpqW0dArthAk5b8cFme+MWpyR2rUdjnEdU3mtCqxs3oUCKR0FancJcFFnynNyDhJJCMLW9qjs0
 JKzDVn5QnYxQwXuRtDCQChIiTS3upbakScslq80lrGNIRY9mgpIjm9t2bpXDJkuuw3eMKyaXQ5
 b7xMzykdggHt1dqjkhwbjJ3yx/M7DhI+qMPCHeBag3fRyshxWchjGHx9HGqePm7zbhrShjWrTY
 ZaYsyUtWvmuBNmr1jfBeIx3ytZLVfds6HtYTLUIixUJWB2szz8hQzPdzbIW47PCjfAVquPSwMj
 1ps=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.12])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Jan 2023 06:05:08 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 17/18] ata: libata: handle completion of CDL commands using policy 0xD
Date:   Thu, 12 Jan 2023 15:04:06 +0100
Message-Id: <20230112140412.667308-18-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112140412.667308-1-niklas.cassel@wdc.com>
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A CDL timeout for policy 0xF is defined as a NCQ error, just with a CDL
specific sk/asc/ascq in the sense data. Therefore, the existing code in
libata does not need to be modified to handle a policy 0xF CDL timeout.

For Command Duration Limits policy 0xD:
The device shall complete the command without error with the additional
sense code set to DATA CURRENTLY UNAVAILABLE.

Since a CDL timeout for policy 0xD is not an error, we cannot use the
NCQ Command Error log (10h).

Instead, we need to read the Sense Data for Successful NCQ Commands
log (0Fh).

In the success case, just like in the error case, we cannot simply read
a log page from the interrupt handler itself, since reading a log page
involves sending a READ LOG DMA EXT or READ LOG EXT command.

Therefore, we add a new EH action ATA_EH_GET_SUCCESS_SENSE.
When a command completes without error, and when the ATA_SENSE bit
is set, this new action is set as pending, and EH is scheduled.

This way, similar to the NCQ error case, the log page will be read
from EH context.

An alternative would have been to add a new kthread or workqueue to
handle this. However, extending EH can be done with minimal changes
and avoids the need to synchronize a new kthread/workqueue with EH.

Co-developed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c |  88 ++++++++++++++++++++++++++++++-
 drivers/ata/libata-eh.c   | 108 +++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata-sata.c |  89 +++++++++++++++++++++++++++++++
 include/linux/ata.h       |   3 ++
 include/linux/libata.h    |  11 +++-
 5 files changed, 295 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2c1531ef169d..e46258dfaa8e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -685,8 +685,12 @@ static inline void ata_set_tf_cdl(struct ata_queued_cmd *qc, int ioprio)
 	else
 		tf->feature |= cdl;
 
-	/* Mark this command as having a CDL */
-	qc->flags |= ATA_QCFLAG_HAS_CDL;
+	/*
+	 * Mark this command as having a CDL and request the result
+	 * task file so that we can inspect the sense data available
+	 * bit on completion.
+	 */
+	qc->flags |= ATA_QCFLAG_HAS_CDL | ATA_QCFLAG_RESULT_TF;
 }
 
 /**
@@ -2431,6 +2435,24 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 		ata_dev_warn(dev,
 			"Command duration guideline is not supported\n");
 
+	/*
+	 * We must have support for the sense data for successful NCQ commands
+	 * log indicated by the successful NCQ command sense data supported bit.
+	 */
+	val = get_unaligned_le64(&ap->sector_buf[8]);
+	if (!(val & BIT_ULL(63)) || !(val & BIT_ULL(47))) {
+		ata_dev_warn(dev,
+			"CDL supported but Successful NCQ Command Sense Data is not supported\n");
+		goto not_supported;
+	}
+
+	/* Without NCQ autosense, the successful NCQ commands log is useless. */
+	if (!ata_id_has_ncq_autosense(dev->id)) {
+		ata_dev_warn(dev,
+			"CDL supported but NCQ autosense is not supported\n");
+		goto not_supported;
+	}
+
 	/*
 	 * If CDL is marked as enabled, make sure the feature is enabled too.
 	 * Conversely, if CDL is disabled, make sure the feature is turned off.
@@ -2465,6 +2487,35 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 		}
 	}
 
+	/*
+	 * While CDL itself has to be enabled using sysfs, CDL requires that
+	 * sense data for successful NCQ commands is enabled to work properly.
+	 * Just like ata_dev_config_sense_reporting(), enable it unconditionally
+	 * if supported.
+	 */
+	if (!(val & BIT_ULL(63)) || !(val & BIT_ULL(18))) {
+		err_mask = ata_dev_set_feature(dev,
+					SETFEATURE_SENSE_DATA_SUCC_NCQ, 0x1);
+		if (err_mask) {
+			ata_dev_warn(dev,
+				     "failed to enable Sense Data for successful NCQ commands, Emask 0x%x\n",
+				     err_mask);
+			goto not_supported;
+		}
+	}
+
+	/*
+	 * Allocate a buffer to handle reading the sense data for successful
+	 * NCQ Commands log page for commands using a CDL with one of the limit
+	 * policy set to 0xD (successful completion with sense data available
+	 * bit set).
+	 */
+	if (!ap->ncq_sense_buf) {
+		ap->ncq_sense_buf = kmalloc(ATA_LOG_SENSE_NCQ_SIZE, GFP_KERNEL);
+		if (!ap->ncq_sense_buf)
+			goto not_supported;
+	}
+
 	/*
 	 * Command duration limits is supported: cache the CDL log page 18h
 	 * (command duration descriptors).
@@ -2482,6 +2533,8 @@ static void ata_dev_config_cdl(struct ata_device *dev)
 
 not_supported:
 	dev->flags &= ~(ATA_DFLAG_CDL | ATA_DFLAG_CDL_ENABLED);
+	kfree(ap->ncq_sense_buf);
+	ap->ncq_sense_buf = NULL;
 }
 
 static int ata_dev_config_lba(struct ata_device *dev)
@@ -4882,6 +4935,36 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			fill_result_tf(qc);
 
 		trace_ata_qc_complete_done(qc);
+
+		/*
+		 * For CDL commands that completed without an error, check if
+		 * we have sense data (ATA_SENSE is set). If we do, then the
+		 * command may have been aborted by the device due to a limit
+		 * timeout using the policy 0xD. For these commands, invoke EH
+		 * to get the command sense data.
+		 */
+		if (qc->result_tf.status & ATA_SENSE &&
+		    ((ata_is_ncq(qc->tf.protocol) &&
+		      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
+		     (!(ata_is_ncq(qc->tf.protocol) &&
+			ata_id_sense_reporting_enabled(dev->id))))) {
+			/*
+			 * Tell SCSI EH to not overwrite scmd->result even if
+			 * this command is finished with result SAM_STAT_GOOD.
+			 */
+			qc->scsicmd->flags |= SCMD_EH_SUCCESS_CMD;
+			qc->flags |= ATA_QCFLAG_EH_SUCCESS_CMD;
+			ehi->dev_action[dev->devno] |= ATA_EH_GET_SUCCESS_SENSE;
+
+			/*
+			 * set pending so that ata_qc_schedule_eh() does not
+			 * trigger fast drain, and freeze the port.
+			 */
+			ap->pflags |= ATA_PFLAG_EH_PENDING;
+			ata_qc_schedule_eh(qc);
+			return;
+		}
+
 		/* Some commands need post-processing after successful
 		 * completion.
 		 */
@@ -5514,6 +5597,7 @@ static void ata_host_release(struct kref *kref)
 
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
+		kfree(ap->ncq_sense_buf);
 		kfree(ap);
 		host->ports[i] = NULL;
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1c3d55fc1cae..c1d08753301c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1913,6 +1913,102 @@ static inline bool ata_eh_quiet(struct ata_queued_cmd *qc)
 	return qc->flags & ATA_QCFLAG_QUIET;
 }
 
+static int ata_eh_read_sense_success_non_ncq(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+	struct ata_queued_cmd *qc;
+
+	qc = __ata_qc_from_tag(ap, link->active_tag);
+	if (!qc)
+		return -EIO;
+
+	if (!(qc->flags & ATA_QCFLAG_EH) ||
+	    !(qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD) ||
+	    qc->err_mask)
+		return -EIO;
+
+	ata_eh_request_sense(qc, false);
+
+	if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
+		return -EIO;
+
+	/*
+	 * If we have sense data, call scsi_check_sense() in order to set the
+	 * correct SCSI ML byte (if any). No point in checking the return value,
+	 * since the command has already completed successfully.
+	 */
+	scsi_check_sense(qc->scsicmd);
+
+	return 0;
+}
+
+static void ata_eh_get_success_sense(struct ata_link *link)
+{
+	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_device *dev = link->device;
+	struct ata_port *ap = link->ap;
+	struct ata_queued_cmd *qc;
+	int tag, ret = 0;
+
+	if (!(ehc->i.dev_action[dev->devno] & ATA_EH_GET_SUCCESS_SENSE))
+		return;
+
+	/* if frozen, we can't do much */
+	if (ata_port_is_frozen(ap)) {
+		ata_dev_warn(dev,
+			"successful sense data available but port frozen\n");
+		goto out;
+	}
+
+	/*
+	 * If the link has sactive set, then we have outstanding NCQ commands
+	 * and have to read the Successful NCQ Commands log to get the sense
+	 * data. Otherwise, we are dealing with a non-NCQ command and use
+	 * request sense ext command to retrieve the sense data.
+	 */
+	if (link->sactive)
+		ret = ata_eh_read_sense_success_ncq_log(link);
+	else
+		ret = ata_eh_read_sense_success_non_ncq(link);
+	if (ret)
+		goto out;
+
+	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
+	return;
+
+out:
+	/*
+	 * If we failed to get sense data for a successful command that ought to
+	 * have sense data, we cannot simply return BLK_STS_OK to user space.
+	 * This is because we can't know if the sense data that we couldn't get
+	 * was actually "DATA CURRENTLY UNAVAILABLE". Reporting such a command
+	 * as success to user space would result in a silent data corruption.
+	 * Thus, add a bogus ABORTED_COMMAND sense data to such commands, such
+	 * that SCSI will report these commands as BLK_STS_IOERR to user space.
+	 */
+	ata_qc_for_each_raw(ap, qc, tag) {
+		if (!(qc->flags & ATA_QCFLAG_EH) ||
+		    !(qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD) ||
+		    qc->err_mask ||
+		    ata_dev_phys_link(qc->dev) != link)
+			continue;
+
+		/* We managed to get sense for this success command, skip. */
+		if (qc->flags & ATA_QCFLAG_SENSE_VALID)
+			continue;
+
+		/* This success command did not have any sense data, skip. */
+		if (!(qc->result_tf.status & ATA_SENSE))
+			continue;
+
+		/* This success command had sense data, but we failed to get. */
+		ata_scsi_set_sense(dev, qc->scsicmd, true, ABORTED_COMMAND,
+				   0, 0);
+		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+	}
+	ata_eh_done(link, dev, ATA_EH_GET_SUCCESS_SENSE);
+}
+
 /**
  *	ata_eh_link_autopsy - analyze error and determine recovery action
  *	@link: host link to perform autopsy on
@@ -1953,6 +2049,14 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	/* analyze NCQ failure */
 	ata_eh_analyze_ncq_error(link);
 
+	/*
+	 * Check if this was a successful command that simply needs sense data.
+	 * Since the sense data is not part of the completion, we need to fetch
+	 * it using an additional command. Since this can't be done from irq
+	 * context, the sense data for successful commands are fetched by EH.
+	 */
+	ata_eh_get_success_sense(link);
+
 	/* any real error trumps AC_ERR_OTHER */
 	if (ehc->i.err_mask & ~AC_ERR_OTHER)
 		ehc->i.err_mask &= ~AC_ERR_OTHER;
@@ -1962,6 +2066,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 	ata_qc_for_each_raw(ap, qc, tag) {
 		if (!(qc->flags & ATA_QCFLAG_EH) ||
 		    qc->flags & ATA_QCFLAG_RETRY ||
+		    qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD ||
 		    ata_dev_phys_link(qc->dev) != link)
 			continue;
 
@@ -3821,7 +3926,8 @@ void ata_eh_finish(struct ata_port *ap)
 			else
 				ata_eh_qc_complete(qc);
 		} else {
-			if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
+			if (qc->flags & ATA_QCFLAG_SENSE_VALID ||
+			    qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD) {
 				ata_eh_qc_complete(qc);
 			} else {
 				/* feed zero TF to sense generation */
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b12f8e9e1f86..1c85e9eee619 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -11,7 +11,9 @@
 #include <linux/module.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
+#include <scsi/scsi_eh.h>
 #include <linux/libata.h>
+#include <asm/unaligned.h>
 
 #include "libata.h"
 #include "libata-transport.h"
@@ -1408,6 +1410,92 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 	return 0;
 }
 
+/**
+ *	ata_eh_read_sense_success_ncq_log - Read the sense data for successful
+ *					    NCQ commands log
+ *	@link: ATA link to get sense data for
+ *
+ *	Read the sense data for successful NCQ commands log page to obtain
+ *	sense data for all NCQ commands that completed successfully with
+ *	the sense data available bit set.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
+{
+	struct ata_device *dev = link->device;
+	struct ata_port *ap = dev->link->ap;
+	u8 *buf = ap->ncq_sense_buf;
+	struct ata_queued_cmd *qc;
+	unsigned int err_mask, tag;
+	u8 *sense, sk = 0, asc = 0, ascq = 0;
+	u64 sense_valid, val;
+	int ret = 0;
+
+	err_mask = ata_read_log_page(dev, ATA_LOG_SENSE_NCQ, 0, buf, 2);
+	if (err_mask) {
+		ata_dev_err(dev,
+			"Failed to read Sense Data for Successful NCQ Commands log\n");
+		return -EIO;
+	}
+
+	/* Check the log header */
+	val = get_unaligned_le64(&buf[0]);
+	if ((val & 0xffff) != 1 || ((val >> 16) & 0xff) != 0x0f) {
+		ata_dev_err(dev,
+			"Invalid Sense Data for Successful NCQ Commands log\n");
+		return -EIO;
+	}
+
+	sense_valid = (u64)buf[8] | ((u64)buf[9] << 8) |
+		((u64)buf[10] << 16) | ((u64)buf[11] << 24);
+
+	ata_qc_for_each_raw(ap, qc, tag) {
+		if (!(qc->flags & ATA_QCFLAG_EH) ||
+		    !(qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD) ||
+		    qc->err_mask ||
+		    ata_dev_phys_link(qc->dev) != link)
+			continue;
+
+		/*
+		 * If the command does not have any sense data, clear ATA_SENSE.
+		 * Keep ATA_QCFLAG_EH_SUCCESS_CMD so that command is finished.
+		 */
+		if (!(sense_valid & (1ULL << tag))) {
+			qc->result_tf.status &= ~ATA_SENSE;
+			continue;
+		}
+
+		sense = &buf[32 + 24 * tag];
+		sk = sense[0];
+		asc = sense[1];
+		ascq = sense[2];
+
+		if (!ata_scsi_sense_is_valid(sk, asc, ascq)) {
+			ret = -EIO;
+			continue;
+		}
+
+		ata_scsi_set_sense(dev, qc->scsicmd, false, sk, asc, ascq);
+		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+
+		/*
+		 * If we have sense data, call scsi_check_sense() in order to
+		 * set the correct SCSI ML byte (if any). No point in checking
+		 * the return value, since the command has already completed
+		 * successfully.
+		 */
+		scsi_check_sense(qc->scsicmd);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ata_eh_read_sense_success_ncq_log);
+
 /**
  *	ata_eh_analyze_ncq_error - analyze NCQ error
  *	@link: ATA link to analyze NCQ error for
@@ -1488,6 +1576,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 
 	ata_qc_for_each_raw(ap, qc, tag) {
 		if (!(qc->flags & ATA_QCFLAG_EH) ||
+		    qc->flags & ATA_QCFLAG_EH_SUCCESS_CMD ||
 		    ata_dev_phys_link(qc->dev) != link)
 			continue;
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index a59b17d6ad11..2e2e22362096 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -326,6 +326,8 @@ enum {
 	ATA_LOG_CDL		= 0x18,
 	ATA_LOG_CDL_SIZE	= ATA_SECT_SIZE,
 	ATA_LOG_IDENTIFY_DEVICE	= 0x30,
+	ATA_LOG_SENSE_NCQ	= 0x0F,
+	ATA_LOG_SENSE_NCQ_SIZE	= ATA_SECT_SIZE * 2,
 	ATA_LOG_CONCURRENT_POSITIONING_RANGES = 0x47,
 
 	/* Identify device log pages: */
@@ -432,6 +434,7 @@ enum {
 	SATA_DEVSLP		= 0x09,	/* Device Sleep */
 
 	SETFEATURE_SENSE_DATA	= 0xC3, /* Sense Data Reporting feature */
+	SETFEATURE_SENSE_DATA_SUCC_NCQ = 0xC4, /* Sense Data for successful NCQ commands */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab8b62036c12..70ac635fe5d7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -214,6 +214,7 @@ enum {
 	ATA_QCFLAG_EH		= (1 << 16), /* cmd aborted and owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
+	ATA_QCFLAG_EH_SUCCESS_CMD = (1 << 19), /* EH should fetch sense for this successful cmd */
 
 	/* host set flags */
 	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
@@ -312,8 +313,10 @@ enum {
 	ATA_EH_RESET		= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 	ATA_EH_ENABLE_LINK	= (1 << 3),
 	ATA_EH_PARK		= (1 << 5), /* unload heads and stop I/O */
+	ATA_EH_GET_SUCCESS_SENSE = (1 << 6), /* Get sense data for successful cmd */
 
-	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_PARK,
+	ATA_EH_PERDEV_MASK	= ATA_EH_REVALIDATE | ATA_EH_PARK |
+				  ATA_EH_GET_SUCCESS_SENSE,
 	ATA_EH_ALL_ACTIONS	= ATA_EH_REVALIDATE | ATA_EH_RESET |
 				  ATA_EH_ENABLE_LINK,
 
@@ -867,6 +870,7 @@ struct ata_port {
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
 	/* owned by EH */
+	u8			*ncq_sense_buf;
 	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
 
@@ -1185,6 +1189,7 @@ extern int sata_link_hardreset(struct ata_link *link,
 			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
+extern int ata_eh_read_sense_success_ncq_log(struct ata_link *link);
 extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
 static inline const unsigned long *
@@ -1222,6 +1227,10 @@ static inline int sata_link_resume(struct ata_link *link,
 {
 	return -EOPNOTSUPP;
 }
+static inline int ata_eh_read_sense_success_ncq_log(struct ata_link *link)
+{
+	return -EOPNOTSUPP;
+}
 static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 extern int sata_link_debounce(struct ata_link *link,
-- 
2.39.0

