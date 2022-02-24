Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD74C3427
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Feb 2022 18:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiBXR4j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Feb 2022 12:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiBXR4i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Feb 2022 12:56:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DE727908D;
        Thu, 24 Feb 2022 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2tQscuyUJS5H62TdCWXl0tnh2zr3P1Q6Q1dT6FdogMs=; b=LLrkR2h3TiZWCED9NPYdn9l9l0
        JYx3WD1UCNT46hVWVOAVwXlwH5TedsDYPTKhEY9PaVqrv9qig/SkxNgRY8Ct+2hnuQ+j9tt+Ap9+B
        Msmy7tdndokwxiqDtYPyK2svlbBlAEK7P+yH2BJF+dtexDPvCEwUTMLhII1G/1E/5JsXJoWL3BdEK
        VzSXXdLgLyKvYlsetJXasCNB4iCHLeksU1dBU/JhOzjvZ5aC+sh8SQ3m0O7sPhSZithoTYKPhNlkM
        LgCxGinXBg369+sSl5jHlIYh+lSkO1cQ8J0IWEPPIG0hs7WptUSaskaRpCgFhyof5IiDCDzlzSBd1
        IxCH7LIA==;
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNILX-001uVe-Gy; Thu, 24 Feb 2022 17:56:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 4/8] scsi: remove the sense and sense_len fields from struct scsi_request
Date:   Thu, 24 Feb 2022 18:55:48 +0100
Message-Id: <20220224175552.988286-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224175552.988286-1-hch@lst.de>
References: <20220224175552.988286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Just use the sense_buffer field in struct scsi_cmnd for the sense data
and move the sense_len field over to struct scsi_cmnd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_bsg.c            |  7 ++++---
 drivers/scsi/scsi_ioctl.c          | 16 ++++++++--------
 drivers/scsi/scsi_lib.c            | 18 +++++++-----------
 drivers/scsi/sg.c                  |  7 ++++---
 drivers/scsi/sr.c                  |  2 +-
 drivers/scsi/st.c                  |  5 +++--
 drivers/target/target_core_pscsi.c |  3 ++-
 include/scsi/scsi_cmnd.h           |  1 +
 include/scsi/scsi_request.h        |  2 --
 9 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index f8b65bd75ee10..0a6f6140501be 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -76,11 +76,12 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 		hdr->info |= SG_INFO_CHECK;
 	hdr->response_len = 0;
 
-	if (sreq->sense_len && hdr->response) {
+	if (scmd->sense_len && hdr->response) {
 		int len = min_t(unsigned int, hdr->max_response_len,
-					sreq->sense_len);
+				scmd->sense_len);
 
-		if (copy_to_user(uptr64(hdr->response), sreq->sense, len))
+		if (copy_to_user(uptr64(hdr->response), scmd->sense_buffer,
+				 len))
 			ret = -EFAULT;
 		else
 			hdr->response_len = len;
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 6d9f1b44566d1..5d0ec21a7e5fe 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -369,6 +369,7 @@ static int scsi_fill_sghdr_rq(struct scsi_device *sdev, struct request *rq,
 static int scsi_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
 		struct bio *bio)
 {
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
 	struct scsi_request *req = scsi_req(rq);
 	int r, ret = 0;
 
@@ -388,10 +389,10 @@ static int scsi_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
 	hdr->resid = req->resid_len;
 	hdr->sb_len_wr = 0;
 
-	if (req->sense_len && hdr->sbp) {
-		int len = min((unsigned int) hdr->mx_sb_len, req->sense_len);
+	if (scmd->sense_len && hdr->sbp) {
+		int len = min((unsigned int) hdr->mx_sb_len, scmd->sense_len);
 
-		if (!copy_to_user(hdr->sbp, req->sense, len))
+		if (!copy_to_user(hdr->sbp, scmd->sense_buffer, len))
 			hdr->sb_len_wr = len;
 		else
 			ret = -EFAULT;
@@ -520,7 +521,6 @@ static int sg_io(struct scsi_device *sdev, struct sg_io_hdr *hdr, fmode_t mode)
 static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		struct scsi_ioctl_command __user *sic)
 {
-	enum { OMAX_SB_LEN = 16 };	/* For backward compatibility */
 	struct request *rq;
 	struct scsi_request *req;
 	int err;
@@ -613,10 +613,10 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 
 	err = req->result & 0xff;	/* only 8 bit SCSI status */
 	if (err) {
-		if (req->sense_len && req->sense) {
-			bytes = (OMAX_SB_LEN > req->sense_len) ?
-				req->sense_len : OMAX_SB_LEN;
-			if (copy_to_user(sic->data, req->sense, bytes))
+		if (scmd->sense_len && scmd->sense_buffer) {
+			/* limit sense len for backward compatibility */
+			if (copy_to_user(sic->data, scmd->sense_buffer,
+					 min(scmd->sense_len, 16U)))
 				err = -EFAULT;
 		}
 	} else {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 623c8cbcaef83..896b3ecdce8e8 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -256,10 +256,11 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 
 	if (resid)
 		*resid = rq->resid_len;
-	if (sense && rq->sense_len)
-		memcpy(sense, rq->sense, SCSI_SENSE_BUFFERSIZE);
+	if (sense && scmd->sense_len)
+		memcpy(sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 	if (sshdr)
-		scsi_normalize_sense(rq->sense, rq->sense_len, sshdr);
+		scsi_normalize_sense(scmd->sense_buffer, scmd->sense_len,
+				     sshdr);
 	ret = rq->result;
  out:
 	blk_mq_free_request(req);
@@ -876,9 +877,8 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 			/*
 			 * SG_IO wants current and deferred errors
 			 */
-			scsi_req(req)->sense_len =
-				min(8 + cmd->sense_buffer[7],
-				    SCSI_SENSE_BUFFERSIZE);
+			cmd->sense_len = min(8 + cmd->sense_buffer[7],
+					     SCSI_SENSE_BUFFERSIZE);
 		}
 		if (sense_current)
 			*blk_statp = scsi_result_to_blk_status(cmd, result);
@@ -1126,13 +1126,10 @@ EXPORT_SYMBOL(scsi_alloc_sgtables);
 static void scsi_initialize_rq(struct request *rq)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(rq);
-	struct scsi_request *req = &cmd->req;
 
 	memset(cmd->cmnd, 0, sizeof(cmd->cmnd));
 	cmd->cmd_len = MAX_COMMAND_SIZE;
-
-	req->sense_len = 0;
-
+	cmd->sense_len = 0;
 	init_rcu_head(&cmd->rcu);
 	cmd->jiffies_at_alloc = jiffies;
 	cmd->retries = 0;
@@ -1824,7 +1821,6 @@ static int scsi_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 		kmem_cache_alloc_node(scsi_sense_cache, GFP_KERNEL, numa_node);
 	if (!cmd->sense_buffer)
 		return -ENOMEM;
-	cmd->req.sense = cmd->sense_buffer;
 
 	if (scsi_host_get_prot(shost)) {
 		sg = (void *)cmd + sizeof(struct scsi_cmnd) +
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index cc3f11270dc23..0f96c7cde9e51 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1323,6 +1323,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 static void
 sg_rq_end_io(struct request *rq, blk_status_t status)
 {
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(rq);
 	struct sg_request *srp = rq->end_io_data;
 	struct scsi_request *req = scsi_req(rq);
 	Sg_device *sdp;
@@ -1343,7 +1344,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	if (unlikely(atomic_read(&sdp->detaching)))
 		pr_info("%s: device detaching\n", __func__);
 
-	sense = req->sense;
+	sense = scmd->sense_buffer;
 	result = req->result;
 	resid = req->resid_len;
 
@@ -1380,8 +1381,8 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 		}
 	}
 
-	if (req->sense_len)
-		memcpy(srp->sense_b, req->sense, SCSI_SENSE_BUFFERSIZE);
+	if (scmd->sense_len)
+		memcpy(srp->sense_b, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 
 	/* Rely on write phase to clean out srp status values, so no "else" */
 
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 3adba389cae51..1d19dd13d7f01 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -999,7 +999,7 @@ static int sr_read_cdda_bpc(struct cdrom_device_info *cdi, void __user *ubuf,
 	if (scsi_req(rq)->result) {
 		struct scsi_sense_hdr sshdr;
 
-		scsi_normalize_sense(req->sense, req->sense_len,
+		scsi_normalize_sense(scmd->sense_buffer, scmd->sense_len,
 				     &sshdr);
 		*last_sense = sshdr.sense_key;
 		ret = -EIO;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 229e819a1797e..9b98e848d78c1 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -514,6 +514,7 @@ static void st_do_stats(struct scsi_tape *STp, struct request *req)
 
 static void st_scsi_execute_end(struct request *req, blk_status_t status)
 {
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	struct st_request *SRpnt = req->end_io_data;
 	struct scsi_request *rq = scsi_req(req);
 	struct scsi_tape *STp = SRpnt->stp;
@@ -525,8 +526,8 @@ static void st_scsi_execute_end(struct request *req, blk_status_t status)
 	st_do_stats(STp, req);
 
 	tmp = SRpnt->bio;
-	if (rq->sense_len)
-		memcpy(SRpnt->sense, rq->sense, SCSI_SENSE_BUFFERSIZE);
+	if (scmd->sense_len)
+		memcpy(SRpnt->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
 	if (SRpnt->waiting)
 		complete(SRpnt->waiting);
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 0a8078db923d3..9146193d0576a 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1031,6 +1031,7 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
 static void pscsi_req_done(struct request *req, blk_status_t status)
 {
 	struct se_cmd *cmd = req->end_io_data;
+	struct scsi_cmnd *scmd = blk_mq_rq_to_pdu(req);
 	int result = scsi_req(req)->result;
 	enum sam_status scsi_status = result & 0xff;
 	u8 *cdb = cmd->priv;
@@ -1040,7 +1041,7 @@ static void pscsi_req_done(struct request *req, blk_status_t status)
 			" 0x%02x Result: 0x%08x\n", cmd, cdb[0], result);
 	}
 
-	pscsi_complete_cmd(cmd, scsi_status, scsi_req(req)->sense);
+	pscsi_complete_cmd(cmd, scsi_status, scmd->sense_buffer);
 
 	switch (host_byte(result)) {
 	case DID_OK:
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 3e432e25645ac..47add5b32f460 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -112,6 +112,7 @@ struct scsi_cmnd {
 				   reconnects.   Probably == sector
 				   size */
 
+	unsigned sense_len;
 	unsigned char *sense_buffer;
 				/* obtained by REQUEST SENSE when
 				 * CHECK CONDITION is received on original
diff --git a/include/scsi/scsi_request.h b/include/scsi/scsi_request.h
index aeee0611bcbe1..bed1cc49132ab 100644
--- a/include/scsi/scsi_request.h
+++ b/include/scsi/scsi_request.h
@@ -6,10 +6,8 @@
 
 struct scsi_request {
 	int		result;
-	unsigned int	sense_len;
 	unsigned int	resid_len;	/* residual count */
 	int		retries;
-	void		*sense;
 };
 
 static inline struct scsi_request *scsi_req(struct request *rq)
-- 
2.30.2

