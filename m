Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45E4E888
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfFUNHt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 09:07:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35101 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfFUNHf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Jun 2019 09:07:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so5921117ljh.2
        for <linux-scsi@vger.kernel.org>; Fri, 21 Jun 2019 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVCd7IM94kgrsu/Yv7f6wO5b46wgz2NUp+wKu6X3WWs=;
        b=bh3KhdObg8D6t3pFPfo82I+WgXWKJv4G/TsizdGYb0daA49HCACx94aagx/rw6jaqw
         /ZzfGfVqRjlnDv1HZhNcCNyzKArU3/hZFwQ7MPiUzuBWLfF6Ux728pFvpTmkq3lMDBX0
         HBKgvsvZyrLyLgpgWGTt/LhFGvwi1bgHEfF9WxT5x99CvhDkO14Cemg706vbghHEog2i
         8H/QSVs3K7J9inUJMijKmrYt4Mjvi93SgUgwlwll1NDy1EaYQ/TlnaNsgHZ0xzR25O+e
         i7C9XEPsIw0HJvQwp9Djf7w/xTjNHEy2wOCWz/4tBq7YkpngS5zdV39v0j1B5uGNW77r
         JUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVCd7IM94kgrsu/Yv7f6wO5b46wgz2NUp+wKu6X3WWs=;
        b=Jkw0brIR+IyX78bc5OCkzGwbuXFtMaHFuOkbuAafJThJZSe1dz2fN5IXGWD8WKIdkj
         Lf9uVo6vv0fAelG45nHLiMLSeB7iYgsEX1yCojykw+vYUz/FqUjryAQQYS9kjOtvTjPb
         HFNVi871mhAJzlCOkaJ6oUruptYd4m5LOkvUi4mhz+SVWX4TfoFUql4VGWEoctr8036O
         RPZ4NFSPclRhQKOxBDsd/nX8nBkbyt4Ha09U1H0VnGJHPn8GN6pCP9P1CGZWsiBDwzOH
         nTkoZlfVwvXrPlewDkXjWd+ax+hSJeAb8BlTHJfggXdaMMwMW4Y5HOJ6Mhpw+zCAAy7B
         TQ8A==
X-Gm-Message-State: APjAAAW5T3CDU1jCy99NlqDp69oIJb84Iln1x9Nfzx/p+K8GWSqmWvzV
        iaUXFNW791gyKvtYbog+qT3Btg==
X-Google-Smtp-Source: APXvYqwPhCxAWSqz1UWNxNr2CLd1C+Iim3YPxHMo0WKMl0NrncG/ekCweu9ZZy7aeqkjvNbWfd1WUQ==
X-Received: by 2002:a2e:5548:: with SMTP id j69mr26896248ljb.48.1561122452415;
        Fri, 21 Jun 2019 06:07:32 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:31 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish support
Date:   Fri, 21 Jun 2019 15:07:10 +0200
Message-Id: <20190621130711.21986-4-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621130711.21986-1-mb@lightnvm.io>
References: <20190621130711.21986-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ajay Joshi <ajay.joshi@wdc.com>

Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH
support to allow explicit control of zone states.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
---
 drivers/scsi/sd.c     | 15 ++++++++++++++-
 drivers/scsi/sd.h     |  6 ++++--
 drivers/scsi/sd_zbc.c | 18 +++++++++++++-----
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a3406bd62391..89f955a01d44 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1292,7 +1292,17 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 	case REQ_OP_WRITE:
 		return sd_setup_read_write_cmnd(cmd);
 	case REQ_OP_ZONE_RESET:
-		return sd_zbc_setup_reset_cmnd(cmd);
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_RESET_WRITE_POINTER);
+	case REQ_OP_ZONE_OPEN:
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_OPEN_ZONE);
+	case REQ_OP_ZONE_CLOSE:
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_CLOSE_ZONE);
+	case REQ_OP_ZONE_FINISH:
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_FINISH_ZONE);
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_NOTSUPP;
@@ -1958,6 +1968,9 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
 		if (!result) {
 			good_bytes = blk_rq_bytes(req);
 			scsi_set_resid(SCpnt, 0);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5796ace76225..9a20633caefa 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -209,7 +209,8 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 
 extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
 extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
-extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);
+extern blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,
+						   unsigned char op);
 extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			    struct scsi_sense_hdr *sshdr);
 extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
@@ -226,7 +227,8 @@ static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
 
 static inline void sd_zbc_print_zones(struct scsi_disk *sdkp) {}
 
-static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+static inline blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,
+							  unsigned char op)
 {
 	return BLK_STS_TARGET;
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7334024b64f1..41020db5353a 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -168,12 +168,17 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 }
 
 /**
- * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.
- * @cmd: the command to setup
+ * sd_zbc_setup_zone_mgmt_op_cmnd - Prepare a zone ZBC_OUT command. The
+ *                                  operations can be RESET WRITE POINTER,
+ *                                  OPEN, CLOSE or FINISH.
+ * @cmd: The command to setup
+ * @op: Operation to be performed
  *
- * Called from sd_init_command() for a REQ_OP_ZONE_RESET request.
+ * Called from sd_init_command() for REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN,
+ * REQ_OP_ZONE_CLOSE or REQ_OP_ZONE_FINISH requests.
  */
-blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,
+					    unsigned char op)
 {
 	struct request *rq = cmd->request;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
@@ -194,7 +199,7 @@ blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 	cmd->cmd_len = 16;
 	memset(cmd->cmnd, 0, cmd->cmd_len);
 	cmd->cmnd[0] = ZBC_OUT;
-	cmd->cmnd[1] = ZO_RESET_WRITE_POINTER;
+	cmd->cmnd[1] = op;
 	put_unaligned_be64(block, &cmd->cmnd[2]);
 
 	rq->timeout = SD_TIMEOUT;
@@ -222,6 +227,9 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 
 	switch (req_op(rq)) {
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
 
 		if (result &&
 		    sshdr->sense_key == ILLEGAL_REQUEST &&
-- 
2.19.1

