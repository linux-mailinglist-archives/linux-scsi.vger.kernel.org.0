Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86273EE953
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhHQJR1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 05:17:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbhHQJRQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Aug 2021 05:17:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E8FA320018;
        Tue, 17 Aug 2021 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629191801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCMwj80Z35RUcyzd2OH6eR1knBzfRuU3aCTjlPRqgZs=;
        b=j/JoaWEPGQ78ssTraHV2e90ZdmAubSoTs59Ix+GQfYHIKR3jHSVc6XmSlpw+DfM4GkrxsK
        Om6C6eDJXffo63Z4e/qns1w5q4kUyL/TWpsnIkPBcyktYQGUQ3rFGDNB21jVhaRZUai8yV
        ahyl8IPQ1p8gUz91YBaViQCbq3TMptg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629191801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCMwj80Z35RUcyzd2OH6eR1knBzfRuU3aCTjlPRqgZs=;
        b=zD2LEXenjzsX8yLN3TH5A+0F032wbsZGSxM6+UFs39v/DuzirZzWjh0pKJ1Ykf0IyxeszH
        AENAltmUcwNeMBAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E3A7BA3BA0;
        Tue, 17 Aug 2021 09:16:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E0D58518CE77; Tue, 17 Aug 2021 11:16:41 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 12/51] mptfusion: correct definitions for mptscsih_dev_reset()
Date:   Tue, 17 Aug 2021 11:14:17 +0200
Message-Id: <20210817091456.73342-13-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817091456.73342-1-hare@suse.de>
References: <20210817091456.73342-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

mptscsih_dev_reset() is _not_ a device reset, but rather a
target reset. Nevertheless it's being used for either purpose.
This patch adds a correct implementation for mptscsih_dev_reset(),
and renames the original function to mptscsih_target_reset().

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/message/fusion/mptscsih.c | 55 ++++++++++++++++++++++++++++++-
 drivers/message/fusion/mptscsih.h |  1 +
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 4b994cadb51e..3bf06dfcd4f9 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -1794,7 +1794,7 @@ mptscsih_abort(struct scsi_cmnd * SCpnt)
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /**
- *	mptscsih_dev_reset - Perform a SCSI TARGET_RESET!  new_eh variant
+ *	mptscsih_dev_reset - Perform a SCSI LOGICAL_UNIT_RESET!
  *	@SCpnt: Pointer to scsi_cmnd structure, IO which reset is due to
  *
  *	(linux scsi_host_template.eh_dev_reset_handler routine)
@@ -1809,6 +1809,58 @@ mptscsih_dev_reset(struct scsi_cmnd * SCpnt)
 	VirtDevice	 *vdevice;
 	MPT_ADAPTER	*ioc;
 
+	/* If we can't locate our host adapter structure, return FAILED status.
+	 */
+	if ((hd = shost_priv(SCpnt->device->host)) == NULL){
+		printk(KERN_ERR MYNAM ": lun reset: "
+		   "Can't locate host! (sc=%p)\n", SCpnt);
+		return FAILED;
+	}
+
+	ioc = hd->ioc;
+	printk(MYIOC_s_INFO_FMT "attempting lun reset! (sc=%p)\n",
+	       ioc->name, SCpnt);
+	scsi_print_command(SCpnt);
+
+	vdevice = SCpnt->device->hostdata;
+	if (!vdevice || !vdevice->vtarget) {
+		retval = 0;
+		goto out;
+	}
+
+	retval = mptscsih_IssueTaskMgmt(hd,
+				MPI_SCSITASKMGMT_TASKTYPE_LOGICAL_UNIT_RESET,
+				vdevice->vtarget->channel,
+				vdevice->vtarget->id, vdevice->lun, 0,
+				mptscsih_get_tm_timeout(ioc));
+
+ out:
+	printk (MYIOC_s_INFO_FMT "lun reset: %s (sc=%p)\n",
+	    ioc->name, ((retval == 0) ? "SUCCESS" : "FAILED" ), SCpnt);
+
+	if (retval == 0)
+		return SUCCESS;
+	else
+		return FAILED;
+}
+
+/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
+/**
+ *	mptscsih_target_reset - Perform a SCSI TARGET_RESET!
+ *	@SCpnt: Pointer to scsi_cmnd structure, IO which reset is due to
+ *
+ *	(linux scsi_host_template.eh_target_reset_handler routine)
+ *
+ *	Returns SUCCESS or FAILED.
+ **/
+int
+mptscsih_target_reset(struct scsi_cmnd * SCpnt)
+{
+	MPT_SCSI_HOST	*hd;
+	int		 retval;
+	VirtDevice	 *vdevice;
+	MPT_ADAPTER	*ioc;
+
 	/* If we can't locate our host adapter structure, return FAILED status.
 	 */
 	if ((hd = shost_priv(SCpnt->device->host)) == NULL){
@@ -3248,6 +3300,7 @@ EXPORT_SYMBOL(mptscsih_slave_destroy);
 EXPORT_SYMBOL(mptscsih_slave_configure);
 EXPORT_SYMBOL(mptscsih_abort);
 EXPORT_SYMBOL(mptscsih_dev_reset);
+EXPORT_SYMBOL(mptscsih_target_reset);
 EXPORT_SYMBOL(mptscsih_bus_reset);
 EXPORT_SYMBOL(mptscsih_host_reset);
 EXPORT_SYMBOL(mptscsih_bios_param);
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/mptscsih.h
index 6ab82548e49e..50af52a81505 100644
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -120,6 +120,7 @@ extern void mptscsih_slave_destroy(struct scsi_device *device);
 extern int mptscsih_slave_configure(struct scsi_device *device);
 extern int mptscsih_abort(struct scsi_cmnd * SCpnt);
 extern int mptscsih_dev_reset(struct scsi_cmnd * SCpnt);
+extern int mptscsih_target_reset(struct scsi_cmnd * SCpnt);
 extern int mptscsih_bus_reset(struct scsi_cmnd * SCpnt);
 extern int mptscsih_host_reset(struct Scsi_Host *sh);
 extern int mptscsih_bios_param(struct scsi_device * sdev, struct block_device *bdev, sector_t capacity, int geom[]);
-- 
2.29.2

