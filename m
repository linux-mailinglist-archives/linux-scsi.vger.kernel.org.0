Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5A2194B63
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Mar 2020 23:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCZWPQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 26 Mar 2020 18:15:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbgCZWPP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 26 Mar 2020 18:15:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6F020ADF1;
        Thu, 26 Mar 2020 22:15:12 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     target-devel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        bvanassche@acm.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 3/5] scsi: target: avoid per-loop XCOPY buffer allocations
Date:   Thu, 26 Mar 2020 23:15:03 +0100
Message-Id: <20200326221505.5303-4-ddiss@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200326221505.5303-1-ddiss@suse.de>
References: <20200326221505.5303-1-ddiss@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The main target_xcopy_do_work() loop unnecessarily allocates an I/O
buffer with each synchronous READ / WRITE pair. This commit
significantly reduces allocations by reusing the XCOPY I/O buffer when
possible.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/target/target_core_xcopy.c | 96 ++++++++++++--------------------------
 drivers/target/target_core_xcopy.h |  1 +
 2 files changed, 31 insertions(+), 66 deletions(-)

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 66b68295c50f..d61c41f33f81 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -499,7 +499,6 @@ void target_xcopy_release_pt(void)
  * @cdb:	 SCSI CDB to be copied into @xpt_cmd.
  * @remote_port: If false, use the LUN through which the XCOPY command has
  *		 been received. If true, use @se_dev->xcopy_lun.
- * @alloc_mem:	 Whether or not to allocate an SGL list.
  *
  * Set up a SCSI command (READ or WRITE) that will be used to execute an
  * XCOPY command.
@@ -509,12 +508,9 @@ static int target_xcopy_setup_pt_cmd(
 	struct xcopy_op *xop,
 	struct se_device *se_dev,
 	unsigned char *cdb,
-	bool remote_port,
-	bool alloc_mem)
+	bool remote_port)
 {
 	struct se_cmd *cmd = &xpt_cmd->se_cmd;
-	sense_reason_t sense_rc;
-	int ret = 0, rc;
 
 	/*
 	 * Setup LUN+port to honor reservations based upon xop->op_origin for
@@ -530,46 +526,17 @@ static int target_xcopy_setup_pt_cmd(
 	cmd->se_cmd_flags |= SCF_SE_LUN_CMD;
 
 	cmd->tag = 0;
-	sense_rc = target_setup_cmd_from_cdb(cmd, cdb);
-	if (sense_rc) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (target_setup_cmd_from_cdb(cmd, cdb))
+		return -EINVAL;
 
-	if (alloc_mem) {
-		rc = target_alloc_sgl(&cmd->t_data_sg, &cmd->t_data_nents,
-				      cmd->data_length, false, false);
-		if (rc < 0) {
-			ret = rc;
-			goto out;
-		}
-		/*
-		 * Set this bit so that transport_free_pages() allows the
-		 * caller to release SGLs + physical memory allocated by
-		 * transport_generic_get_mem()..
-		 */
-		cmd->se_cmd_flags |= SCF_PASSTHROUGH_SG_TO_MEM_NOALLOC;
-	} else {
-		/*
-		 * Here the previously allocated SGLs for the internal READ
-		 * are mapped zero-copy to the internal WRITE.
-		 */
-		sense_rc = transport_generic_map_mem_to_cmd(cmd,
-					xop->xop_data_sg, xop->xop_data_nents,
-					NULL, 0);
-		if (sense_rc) {
-			ret = -EINVAL;
-			goto out;
-		}
+	if (transport_generic_map_mem_to_cmd(cmd, xop->xop_data_sg,
+					xop->xop_data_nents, NULL, 0))
+		return -EINVAL;
 
-		pr_debug("Setup PASSTHROUGH_NOALLOC t_data_sg: %p t_data_nents:"
-			 " %u\n", cmd->t_data_sg, cmd->t_data_nents);
-	}
+	pr_debug("Setup PASSTHROUGH_NOALLOC t_data_sg: %p t_data_nents:"
+		 " %u\n", cmd->t_data_sg, cmd->t_data_nents);
 
 	return 0;
-
-out:
-	return ret;
 }
 
 static int target_xcopy_issue_pt_cmd(struct xcopy_pt_cmd *xpt_cmd)
@@ -626,15 +593,13 @@ static int target_xcopy_read_source(
 	xop->src_pt_cmd = xpt_cmd;
 
 	rc = target_xcopy_setup_pt_cmd(xpt_cmd, xop, src_dev, &cdb[0],
-				remote_port, true);
+				remote_port);
 	if (rc < 0) {
 		ec_cmd->scsi_status = xpt_cmd->se_cmd.scsi_status;
 		transport_generic_free_cmd(se_cmd, 0);
 		return rc;
 	}
 
-	xop->xop_data_sg = se_cmd->t_data_sg;
-	xop->xop_data_nents = se_cmd->t_data_nents;
 	pr_debug("XCOPY-READ: Saved xop->xop_data_sg: %p, num: %u for READ"
 		" memory\n", xop->xop_data_sg, xop->xop_data_nents);
 
@@ -644,12 +609,6 @@ static int target_xcopy_read_source(
 		transport_generic_free_cmd(se_cmd, 0);
 		return rc;
 	}
-	/*
-	 * Clear off the allocated t_data_sg, that has been saved for
-	 * zero-copy WRITE submission reuse in struct xcopy_op..
-	 */
-	se_cmd->t_data_sg = NULL;
-	se_cmd->t_data_nents = 0;
 
 	return 0;
 }
@@ -688,19 +647,9 @@ static int target_xcopy_write_destination(
 	xop->dst_pt_cmd = xpt_cmd;
 
 	rc = target_xcopy_setup_pt_cmd(xpt_cmd, xop, dst_dev, &cdb[0],
-				remote_port, false);
+				remote_port);
 	if (rc < 0) {
-		struct se_cmd *src_cmd = &xop->src_pt_cmd->se_cmd;
 		ec_cmd->scsi_status = xpt_cmd->se_cmd.scsi_status;
-		/*
-		 * If the failure happened before the t_mem_list hand-off in
-		 * target_xcopy_setup_pt_cmd(), Reset memory + clear flag so that
-		 * core releases this memory on error during X-COPY WRITE I/O.
-		 */
-		src_cmd->se_cmd_flags &= ~SCF_PASSTHROUGH_SG_TO_MEM_NOALLOC;
-		src_cmd->t_data_sg = xop->xop_data_sg;
-		src_cmd->t_data_nents = xop->xop_data_nents;
-
 		transport_generic_free_cmd(se_cmd, 0);
 		return rc;
 	}
@@ -708,7 +657,6 @@ static int target_xcopy_write_destination(
 	rc = target_xcopy_issue_pt_cmd(xpt_cmd);
 	if (rc < 0) {
 		ec_cmd->scsi_status = xpt_cmd->se_cmd.scsi_status;
-		se_cmd->se_cmd_flags &= ~SCF_PASSTHROUGH_SG_TO_MEM_NOALLOC;
 		transport_generic_free_cmd(se_cmd, 0);
 		return rc;
 	}
@@ -724,7 +672,7 @@ static void target_xcopy_do_work(struct work_struct *work)
 	sector_t src_lba, dst_lba, end_lba;
 	unsigned int max_sectors;
 	int rc = 0;
-	unsigned short nolb, cur_nolb, max_nolb, copied_nolb = 0;
+	unsigned short nolb, max_nolb, copied_nolb = 0;
 
 	if (target_parse_xcopy_cmd(xop) != TCM_NO_SENSE)
 		goto err_free;
@@ -754,7 +702,23 @@ static void target_xcopy_do_work(struct work_struct *work)
 			(unsigned long long)src_lba, (unsigned long long)dst_lba);
 
 	while (src_lba < end_lba) {
-		cur_nolb = min(nolb, max_nolb);
+		unsigned short cur_nolb = min(nolb, max_nolb);
+		u32 cur_bytes = cur_nolb * src_dev->dev_attrib.block_size;
+
+		if (cur_bytes != xop->xop_data_bytes) {
+			/*
+			 * (Re)allocate a buffer large enough to hold the XCOPY
+			 * I/O size, which can be reused each read / write loop.
+			 */
+			target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
+			rc = target_alloc_sgl(&xop->xop_data_sg,
+					      &xop->xop_data_nents,
+					      cur_bytes,
+					      false, false);
+			if (rc < 0)
+				goto out;
+			xop->xop_data_bytes = cur_bytes;
+		}
 
 		pr_debug("target_xcopy_do_work: Calling read src_dev: %p src_lba: %llu,"
 			" cur_nolb: %hu\n", src_dev, (unsigned long long)src_lba, cur_nolb);
@@ -785,12 +749,11 @@ static void target_xcopy_do_work(struct work_struct *work)
 		nolb -= cur_nolb;
 
 		transport_generic_free_cmd(&xop->src_pt_cmd->se_cmd, 0);
-		xop->dst_pt_cmd->se_cmd.se_cmd_flags &= ~SCF_PASSTHROUGH_SG_TO_MEM_NOALLOC;
-
 		transport_generic_free_cmd(&xop->dst_pt_cmd->se_cmd, 0);
 	}
 
 	xcopy_pt_undepend_remotedev(xop);
+	target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
 	kfree(xop);
 
 	pr_debug("target_xcopy_do_work: Final src_lba: %llu, dst_lba: %llu\n",
@@ -804,6 +767,7 @@ static void target_xcopy_do_work(struct work_struct *work)
 
 out:
 	xcopy_pt_undepend_remotedev(xop);
+	target_free_sgl(xop->xop_data_sg, xop->xop_data_nents);
 
 err_free:
 	kfree(xop);
diff --git a/drivers/target/target_core_xcopy.h b/drivers/target/target_core_xcopy.h
index 0840b03e8faa..9558974185ea 100644
--- a/drivers/target/target_core_xcopy.h
+++ b/drivers/target/target_core_xcopy.h
@@ -39,6 +39,7 @@ struct xcopy_op {
 	struct xcopy_pt_cmd *src_pt_cmd;
 	struct xcopy_pt_cmd *dst_pt_cmd;
 
+	u32 xop_data_bytes;
 	u32 xop_data_nents;
 	struct scatterlist *xop_data_sg;
 	struct work_struct xop_work;
-- 
2.16.4

