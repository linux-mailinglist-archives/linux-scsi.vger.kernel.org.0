Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6E03D45E4
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Jul 2021 09:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhGXGuZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 24 Jul 2021 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhGXGuZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 24 Jul 2021 02:50:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83568C061575;
        Sat, 24 Jul 2021 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0AdV8EfTDwooqnuo7WLHjinbM89v+NjAEY1GwzU/gOU=; b=O27ZhMx8aWsAWGKC7/zcO5RkoV
        uy1eLwg4vhSIZg703YBmUV7UeLOwe18wOJhreuIbPJiTXBD59nHy9ZJx1gEkJ3yb9coy3QxVmcF7w
        ki9DctkoFXl0hsNOtOrV/F/DKrcCthp6+fHnSdMshZWhCUZmJtg+RR2kB/7bI0jS9rQwipmVKm4dl
        FoEtFUebBUSB/BPRSL0euVJs1+vt5oOTr+3zM7LzTm67uHlkdcx8bfaKSJbKAH0edPivXQvyYiBPs
        Lc8NkYltzyMW8eSXf85dg1TZXStDIxA/xJcD1awB0xXC7WaFiTjS7h+7mh/g6pUJXnB3xAe1v8ir+
        Kj2Jve/A==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7C6U-00C5Rn-1u; Sat, 24 Jul 2021 07:29:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 17/24] scsi_ioctl: simplify SCSI passthrough permission checking
Date:   Sat, 24 Jul 2021 09:20:26 +0200
Message-Id: <20210724072033.1284840-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724072033.1284840-1-hch@lst.de>
References: <20210724072033.1284840-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove the separate command filter structure and just use a switch
statement (which also cought two duplicate commands), return a bool
and give the function a sensible name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/scsi_ioctl.c      | 219 ++++++++++++++++++----------------------
 drivers/scsi/scsi_bsg.c |   2 +-
 drivers/scsi/sg.c       |   5 +-
 include/linux/blkdev.h  |   2 +-
 4 files changed, 104 insertions(+), 124 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index 4d023f2f43f0..3642e145108a 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -22,13 +22,6 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/sg.h>
 
-struct blk_cmd_filter {
-	unsigned long read_ok[BLK_SCSI_CMD_PER_LONG];
-	unsigned long write_ok[BLK_SCSI_CMD_PER_LONG];
-};
-
-static struct blk_cmd_filter blk_default_cmd_filter;
-
 static int sg_get_version(int __user *p)
 {
 	static const int sg_version_num = 30527;
@@ -80,115 +73,108 @@ static int sg_emulated_host(struct request_queue *q, int __user *p)
 	return put_user(1, p);
 }
 
-static void blk_set_cmd_filter_defaults(struct blk_cmd_filter *filter)
-{
-	/* Basic read-only commands */
-	__set_bit(TEST_UNIT_READY, filter->read_ok);
-	__set_bit(REQUEST_SENSE, filter->read_ok);
-	__set_bit(READ_6, filter->read_ok);
-	__set_bit(READ_10, filter->read_ok);
-	__set_bit(READ_12, filter->read_ok);
-	__set_bit(READ_16, filter->read_ok);
-	__set_bit(READ_BUFFER, filter->read_ok);
-	__set_bit(READ_DEFECT_DATA, filter->read_ok);
-	__set_bit(READ_CAPACITY, filter->read_ok);
-	__set_bit(READ_LONG, filter->read_ok);
-	__set_bit(INQUIRY, filter->read_ok);
-	__set_bit(MODE_SENSE, filter->read_ok);
-	__set_bit(MODE_SENSE_10, filter->read_ok);
-	__set_bit(LOG_SENSE, filter->read_ok);
-	__set_bit(START_STOP, filter->read_ok);
-	__set_bit(GPCMD_VERIFY_10, filter->read_ok);
-	__set_bit(VERIFY_16, filter->read_ok);
-	__set_bit(REPORT_LUNS, filter->read_ok);
-	__set_bit(SERVICE_ACTION_IN_16, filter->read_ok);
-	__set_bit(RECEIVE_DIAGNOSTIC, filter->read_ok);
-	__set_bit(MAINTENANCE_IN, filter->read_ok);
-	__set_bit(GPCMD_READ_BUFFER_CAPACITY, filter->read_ok);
-
-	/* Audio CD commands */
-	__set_bit(GPCMD_PLAY_CD, filter->read_ok);
-	__set_bit(GPCMD_PLAY_AUDIO_10, filter->read_ok);
-	__set_bit(GPCMD_PLAY_AUDIO_MSF, filter->read_ok);
-	__set_bit(GPCMD_PLAY_AUDIO_TI, filter->read_ok);
-	__set_bit(GPCMD_PAUSE_RESUME, filter->read_ok);
-
-	/* CD/DVD data reading */
-	__set_bit(GPCMD_READ_CD, filter->read_ok);
-	__set_bit(GPCMD_READ_CD_MSF, filter->read_ok);
-	__set_bit(GPCMD_READ_DISC_INFO, filter->read_ok);
-	__set_bit(GPCMD_READ_CDVD_CAPACITY, filter->read_ok);
-	__set_bit(GPCMD_READ_DVD_STRUCTURE, filter->read_ok);
-	__set_bit(GPCMD_READ_HEADER, filter->read_ok);
-	__set_bit(GPCMD_READ_TRACK_RZONE_INFO, filter->read_ok);
-	__set_bit(GPCMD_READ_SUBCHANNEL, filter->read_ok);
-	__set_bit(GPCMD_READ_TOC_PMA_ATIP, filter->read_ok);
-	__set_bit(GPCMD_REPORT_KEY, filter->read_ok);
-	__set_bit(GPCMD_SCAN, filter->read_ok);
-	__set_bit(GPCMD_GET_CONFIGURATION, filter->read_ok);
-	__set_bit(GPCMD_READ_FORMAT_CAPACITIES, filter->read_ok);
-	__set_bit(GPCMD_GET_EVENT_STATUS_NOTIFICATION, filter->read_ok);
-	__set_bit(GPCMD_GET_PERFORMANCE, filter->read_ok);
-	__set_bit(GPCMD_SEEK, filter->read_ok);
-	__set_bit(GPCMD_STOP_PLAY_SCAN, filter->read_ok);
-
-	/* Basic writing commands */
-	__set_bit(WRITE_6, filter->write_ok);
-	__set_bit(WRITE_10, filter->write_ok);
-	__set_bit(WRITE_VERIFY, filter->write_ok);
-	__set_bit(WRITE_12, filter->write_ok);
-	__set_bit(WRITE_VERIFY_12, filter->write_ok);
-	__set_bit(WRITE_16, filter->write_ok);
-	__set_bit(WRITE_LONG, filter->write_ok);
-	__set_bit(WRITE_LONG_2, filter->write_ok);
-	__set_bit(WRITE_SAME, filter->write_ok);
-	__set_bit(WRITE_SAME_16, filter->write_ok);
-	__set_bit(WRITE_SAME_32, filter->write_ok);
-	__set_bit(ERASE, filter->write_ok);
-	__set_bit(GPCMD_MODE_SELECT_10, filter->write_ok);
-	__set_bit(MODE_SELECT, filter->write_ok);
-	__set_bit(LOG_SELECT, filter->write_ok);
-	__set_bit(GPCMD_BLANK, filter->write_ok);
-	__set_bit(GPCMD_CLOSE_TRACK, filter->write_ok);
-	__set_bit(GPCMD_FLUSH_CACHE, filter->write_ok);
-	__set_bit(GPCMD_FORMAT_UNIT, filter->write_ok);
-	__set_bit(GPCMD_REPAIR_RZONE_TRACK, filter->write_ok);
-	__set_bit(GPCMD_RESERVE_RZONE_TRACK, filter->write_ok);
-	__set_bit(GPCMD_SEND_DVD_STRUCTURE, filter->write_ok);
-	__set_bit(GPCMD_SEND_EVENT, filter->write_ok);
-	__set_bit(GPCMD_SEND_KEY, filter->write_ok);
-	__set_bit(GPCMD_SEND_OPC, filter->write_ok);
-	__set_bit(GPCMD_SEND_CUE_SHEET, filter->write_ok);
-	__set_bit(GPCMD_SET_SPEED, filter->write_ok);
-	__set_bit(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL, filter->write_ok);
-	__set_bit(GPCMD_LOAD_UNLOAD, filter->write_ok);
-	__set_bit(GPCMD_SET_STREAMING, filter->write_ok);
-	__set_bit(GPCMD_SET_READ_AHEAD, filter->write_ok);
-
-	/* ZBC Commands */
-	__set_bit(ZBC_OUT, filter->write_ok);
-	__set_bit(ZBC_IN, filter->read_ok);
-}
-
-int blk_verify_command(unsigned char *cmd, fmode_t mode)
+/*
+ * Check if the given command is allowed.
+ *
+ * For unprivileged users only a small set of whitelisted command is allowed so
+ * that they can't format the drive or update the firmware.
+ */
+bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode)
 {
-	struct blk_cmd_filter *filter = &blk_default_cmd_filter;
-
 	/* root can do any command. */
 	if (capable(CAP_SYS_RAWIO))
-		return 0;
+		return true;
 
 	/* Anybody who can open the device can do a read-safe command */
-	if (test_bit(cmd[0], filter->read_ok))
-		return 0;
-
-	/* Write-safe commands require a writable open */
-	if (test_bit(cmd[0], filter->write_ok) && (mode & FMODE_WRITE))
-		return 0;
-
-	return -EPERM;
+	switch (cmd[0]) {
+	/* Basic read-only commands */
+	case TEST_UNIT_READY:
+	case REQUEST_SENSE:
+	case READ_6:
+	case READ_10:
+	case READ_12:
+	case READ_16:
+	case READ_BUFFER:
+	case READ_DEFECT_DATA:
+	case READ_CAPACITY: /* also GPCMD_READ_CDVD_CAPACITY */
+	case READ_LONG:
+	case INQUIRY:
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+	case LOG_SENSE:
+	case START_STOP:
+	case GPCMD_VERIFY_10:
+	case VERIFY_16:
+	case REPORT_LUNS:
+	case SERVICE_ACTION_IN_16:
+	case RECEIVE_DIAGNOSTIC:
+	case MAINTENANCE_IN: /* also GPCMD_SEND_KEY, which is a write command */
+	case GPCMD_READ_BUFFER_CAPACITY:
+	/* Audio CD commands */
+	case GPCMD_PLAY_CD:
+	case GPCMD_PLAY_AUDIO_10:
+	case GPCMD_PLAY_AUDIO_MSF:
+	case GPCMD_PLAY_AUDIO_TI:
+	case GPCMD_PAUSE_RESUME:
+	/* CD/DVD data reading */
+	case GPCMD_READ_CD:
+	case GPCMD_READ_CD_MSF:
+	case GPCMD_READ_DISC_INFO:
+	case GPCMD_READ_DVD_STRUCTURE:
+	case GPCMD_READ_HEADER:
+	case GPCMD_READ_TRACK_RZONE_INFO:
+	case GPCMD_READ_SUBCHANNEL:
+	case GPCMD_READ_TOC_PMA_ATIP:
+	case GPCMD_REPORT_KEY:
+	case GPCMD_SCAN:
+	case GPCMD_GET_CONFIGURATION:
+	case GPCMD_READ_FORMAT_CAPACITIES:
+	case GPCMD_GET_EVENT_STATUS_NOTIFICATION:
+	case GPCMD_GET_PERFORMANCE:
+	case GPCMD_SEEK:
+	case GPCMD_STOP_PLAY_SCAN:
+	/* ZBC */
+	case ZBC_IN:
+		return true;
+	/* Basic writing commands */
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_VERIFY:
+	case WRITE_12:
+	case WRITE_VERIFY_12:
+	case WRITE_16:
+	case WRITE_LONG:
+	case WRITE_LONG_2:
+	case WRITE_SAME:
+	case WRITE_SAME_16:
+	case WRITE_SAME_32:
+	case ERASE:
+	case GPCMD_MODE_SELECT_10:
+	case MODE_SELECT:
+	case LOG_SELECT:
+	case GPCMD_BLANK:
+	case GPCMD_CLOSE_TRACK:
+	case GPCMD_FLUSH_CACHE:
+	case GPCMD_FORMAT_UNIT:
+	case GPCMD_REPAIR_RZONE_TRACK:
+	case GPCMD_RESERVE_RZONE_TRACK:
+	case GPCMD_SEND_DVD_STRUCTURE:
+	case GPCMD_SEND_EVENT:
+	case GPCMD_SEND_OPC:
+	case GPCMD_SEND_CUE_SHEET:
+	case GPCMD_SET_SPEED:
+	case GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL:
+	case GPCMD_LOAD_UNLOAD:
+	case GPCMD_SET_STREAMING:
+	case GPCMD_SET_READ_AHEAD:
+	/* ZBC */
+	case ZBC_OUT:
+		return (mode & FMODE_WRITE);
+	default:
+		return false;
+	}
 }
-EXPORT_SYMBOL(blk_verify_command);
+EXPORT_SYMBOL(scsi_cmd_allowed);
 
 static int blk_fill_sghdr_rq(struct request_queue *q, struct request *rq,
 			     struct sg_io_hdr *hdr, fmode_t mode)
@@ -197,7 +183,7 @@ static int blk_fill_sghdr_rq(struct request_queue *q, struct request *rq,
 
 	if (copy_from_user(req->cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
-	if (blk_verify_command(req->cmd, mode))
+	if (!scsi_cmd_allowed(req->cmd, mode))
 		return -EPERM;
 
 	/*
@@ -428,8 +414,8 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
 	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))
 		goto error;
 
-	err = blk_verify_command(req->cmd, mode);
-	if (err)
+	err = -EPERM;
+	if (!scsi_cmd_allowed(req->cmd, mode))
 		goto error;
 
 	/* default.  possible overriden later */
@@ -808,10 +794,3 @@ int scsi_cmd_ioctl(struct request_queue *q, struct gendisk *bd_disk, fmode_t mod
 	return err;
 }
 EXPORT_SYMBOL(scsi_cmd_ioctl);
-
-static int __init blk_scsi_ioctl_init(void)
-{
-	blk_set_cmd_filter_defaults(&blk_default_cmd_filter);
-	return 0;
-}
-fs_initcall(blk_scsi_ioctl_init);
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 3bdb28940460..68f60316adf1 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -36,7 +36,7 @@ static int scsi_bsg_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 
 	if (copy_from_user(sreq->cmd, uptr64(hdr->request), sreq->cmd_len))
 		return -EFAULT;
-	if (blk_verify_command(sreq->cmd, mode))
+	if (!scsi_cmd_allowed(sreq->cmd, mode))
 		return -EPERM;
 	return 0;
 }
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 6cb1e4b6eac2..c86fa4476334 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -238,8 +238,9 @@ static int sg_allow_access(struct file *filp, unsigned char *cmd)
 
 	if (sfp->parentdp->device->type == TYPE_SCANNER)
 		return 0;
-
-	return blk_verify_command(cmd, filp->f_mode);
+	if (!scsi_cmd_allowed(cmd, filp->f_mode))
+		return -EPERM;
+	return 0;
 }
 
 static int
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d36b67bd7267..e28679e63373 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1343,7 +1343,7 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 				    gfp_mask, 0);
 }
 
-extern int blk_verify_command(unsigned char *cmd, fmode_t mode);
+bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode);
 
 static inline bool bdev_is_partition(struct block_device *bdev)
 {
-- 
2.30.2

