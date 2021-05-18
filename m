Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0A387EAF
	for <lists+linux-scsi@lfdr.de>; Tue, 18 May 2021 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351202AbhERRqX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 May 2021 13:46:23 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:43586 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347101AbhERRqU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 May 2021 13:46:20 -0400
Received: by mail-pl1-f176.google.com with SMTP id v12so5507875plo.10
        for <linux-scsi@vger.kernel.org>; Tue, 18 May 2021 10:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3zfjdcXICQaCuBGw+/82htv5ZGZEI5sLVxDqg4zuq08=;
        b=uGKpnyENk2IOa+4jSnEqeQYcRGPJ6/cVtZqXY72uuRAIsaPPPJ8bdIWlFl+gnx7Hdy
         PK25A9MxuHCmwfG56K1ZcQQ0717QPCrDhYkqxkGYAPdMmU+r4RivtkKYkvLJUlUWf/Ft
         lxH2AaB8vzTmx9u57sypcrLSSrZ+ysOeYVrZlY53UhceXkoH8QhjN04Hb1rC/5WTxtrE
         FXgKJU7DIm2erIbiywoXiH5F80qVRBHlmSH1MLM6/ruvtWjzd1ejdUjbQQTD/NWZOZZR
         9sE9i6Re3035Q+fVGO4KZJ+iJFjRjTvu3WfFNTDat1ReuHg0ZZfAUXYyf1iU7EkYMnMQ
         YpOQ==
X-Gm-Message-State: AOAM532EcrUxZxPXjCETqhIojn4NBJdXe08VPUWifnCsT50HSo5RrhOV
        0pcCZjHi85b3Bln+UN9TwJ4=
X-Google-Smtp-Source: ABdhPJx4MGFRSa6ixhf1Yyu9EyQtOd2lfWEy5GcSqjqYIBq5YSmKW4KoLRJFisgfNN9oxEEpKtYHCg==
X-Received: by 2002:a17:90a:b885:: with SMTP id o5mr6323670pjr.91.1621359900673;
        Tue, 18 May 2021 10:45:00 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:4ae4:fc49:eafe:4150])
        by smtp.gmail.com with ESMTPSA id z27sm12656920pfr.46.2021.05.18.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:45:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 03/50] sd: Use scsi_cmd_to_rq() instead of scsi_cmnd.request
Date:   Tue, 18 May 2021 10:44:03 -0700
Message-Id: <20210518174450.20664-4-bvanassche@acm.org>
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
 drivers/scsi/sd.c     | 33 +++++++++++++++++----------------
 drivers/scsi/sd_zbc.c | 10 +++++-----
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cb3c37d1e009..cb7f8a343b67 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -779,8 +779,9 @@ static unsigned int sd_prot_flag_mask(unsigned int prot_op)
 static unsigned char sd_setup_protect_cmnd(struct scsi_cmnd *scmd,
 					   unsigned int dix, unsigned int dif)
 {
-	struct bio *bio = scmd->request->bio;
-	unsigned int prot_op = sd_prot_op(rq_data_dir(scmd->request), dix, dif);
+	struct request *rq = scsi_cmd_to_rq(scmd);
+	struct bio *bio = rq->bio;
+	unsigned int prot_op = sd_prot_op(rq_data_dir(rq), dix, dif);
 	unsigned int protect = 0;
 
 	if (dix) {				/* DIX Type 0, 1, 2, 3 */
@@ -871,7 +872,7 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdp = cmd->device;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
@@ -907,7 +908,7 @@ static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 		bool unmap)
 {
 	struct scsi_device *sdp = cmd->device;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
@@ -939,7 +940,7 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
 		bool unmap)
 {
 	struct scsi_device *sdp = cmd->device;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
@@ -969,7 +970,7 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
 
 static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_device *sdp = cmd->device;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
@@ -1066,7 +1067,7 @@ static void sd_config_write_same(struct scsi_disk *sdkp)
  **/
 static blk_status_t sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_device *sdp = cmd->device;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	struct bio *bio = rq->bio;
@@ -1115,7 +1116,7 @@ static blk_status_t sd_setup_write_same_cmnd(struct scsi_cmnd *cmd)
 
 static blk_status_t sd_setup_flush_cmnd(struct scsi_cmnd *cmd)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 
 	/* flush requests don't perform I/O, zero the S/G table */
@@ -1213,7 +1214,7 @@ static blk_status_t sd_setup_rw6_cmnd(struct scsi_cmnd *cmd, bool write,
 
 static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_device *sdp = cmd->device;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t lba = sectors_to_logical(sdp, blk_rq_pos(rq));
@@ -1327,7 +1328,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 
 static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 
 	switch (req_op(rq)) {
 	case REQ_OP_DISCARD:
@@ -1373,7 +1374,7 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 
 static void sd_uninit_command(struct scsi_cmnd *SCpnt)
 {
-	struct request *rq = SCpnt->request;
+	struct request *rq = scsi_cmd_to_rq(SCpnt);
 	u8 *cmnd;
 
 	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
@@ -1906,7 +1907,7 @@ static const struct block_device_operations sd_fops = {
  **/
 static void sd_eh_reset(struct scsi_cmnd *scmd)
 {
-	struct scsi_disk *sdkp = scsi_disk(scmd->request->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(scsi_cmd_to_rq(scmd)->rq_disk);
 
 	/* New SCSI EH run, reset gate variable */
 	sdkp->ignore_medium_access_errors = false;
@@ -1926,7 +1927,7 @@ static void sd_eh_reset(struct scsi_cmnd *scmd)
  **/
 static int sd_eh_action(struct scsi_cmnd *scmd, int eh_disp)
 {
-	struct scsi_disk *sdkp = scsi_disk(scmd->request->rq_disk);
+	struct scsi_disk *sdkp = scsi_disk(scsi_cmd_to_rq(scmd)->rq_disk);
 	struct scsi_device *sdev = scmd->device;
 
 	if (!scsi_device_online(sdev) ||
@@ -1967,7 +1968,7 @@ static int sd_eh_action(struct scsi_cmnd *scmd, int eh_disp)
 
 static unsigned int sd_completed_bytes(struct scsi_cmnd *scmd)
 {
-	struct request *req = scmd->request;
+	struct request *req = scsi_cmd_to_rq(scmd);
 	struct scsi_device *sdev = scmd->device;
 	unsigned int transferred, good_bytes;
 	u64 start_lba, end_lba, bad_lba;
@@ -2022,8 +2023,8 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	unsigned int sector_size = SCpnt->device->sector_size;
 	unsigned int resid;
 	struct scsi_sense_hdr sshdr;
-	struct scsi_disk *sdkp = scsi_disk(SCpnt->request->rq_disk);
-	struct request *req = SCpnt->request;
+	struct request *req = scsi_cmd_to_rq(SCpnt);
+	struct scsi_disk *sdkp = scsi_disk(req->rq_disk);
 	int sense_valid = 0;
 	int sense_deferred = 0;
 
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index e45d8d94574c..d2afaa11e2ee 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -244,7 +244,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 
 static blk_status_t sd_zbc_cmnd_checks(struct scsi_cmnd *cmd)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t sector = blk_rq_pos(rq);
 
@@ -322,7 +322,7 @@ static void sd_zbc_update_wp_offset_workfn(struct work_struct *work)
 blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 					unsigned int nr_blocks)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	unsigned int wp_offset, zno = blk_rq_zone_no(rq);
 	unsigned long flags;
@@ -387,7 +387,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all)
 {
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	sector_t sector = blk_rq_pos(rq);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	sector_t block = sectors_to_logical(sdkp->device, sector);
@@ -443,7 +443,7 @@ static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
 					  unsigned int good_bytes)
 {
 	int result = cmd->result;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
 	unsigned int zno = blk_rq_zone_no(rq);
 	enum req_opf op = req_op(rq);
@@ -517,7 +517,7 @@ unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 		     struct scsi_sense_hdr *sshdr)
 {
 	int result = cmd->result;
-	struct request *rq = cmd->request;
+	struct request *rq = scsi_cmd_to_rq(cmd);
 
 	if (op_is_zone_mgmt(req_op(rq)) &&
 	    result &&
