Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B851172436
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Feb 2020 17:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgB0Q7g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Feb 2020 11:59:36 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47185 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbgB0Q7f (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:59:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7CBDF204197;
        Thu, 27 Feb 2020 17:59:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QZC1kxGeMPCw; Thu, 27 Feb 2020 17:59:32 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 50A31204194;
        Thu, 27 Feb 2020 17:59:26 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v7 14/38] sg: sg_common_write add structure for arguments
Date:   Thu, 27 Feb 2020 11:58:38 -0500
Message-Id: <20200227165902.11861-15-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227165902.11861-1-dgilbert@interlog.com>
References: <20200227165902.11861-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As the number of arguments to sg_common_write() starts to grow
(more in later patches) add a structure to hold most of these
arguments.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0d9bf2c840bf..1b56cce3b212 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -174,6 +174,13 @@ struct sg_device { /* holds the state of each scsi generic device */
 	struct kref d_ref;
 };
 
+struct sg_comm_wr_t {  /* arguments to sg_common_write() */
+	int timeout;
+	int blocking;
+	struct sg_request *srp;
+	u8 *cmnd;
+};
+
 /* tasklet or soft irq callback */
 static void sg_rq_end_io(struct request *rq, blk_status_t status);
 /* Declarations of other static functions used before they are defined */
@@ -186,8 +193,7 @@ static ssize_t sg_submit(struct sg_fd *sfp, struct file *filp,
 			 const char __user *buf, size_t count, bool blocking,
 			 bool read_only, bool sg_io_owned,
 			 struct sg_request **o_srp);
-static int sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
-			   u8 *cmnd, int timeout, int blocking);
+static int sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwp);
 static int sg_read_append(struct sg_request *srp, void __user *outp,
 			  int num_xfer);
 static void sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp);
@@ -487,6 +493,7 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	struct sg_io_hdr v3hdr;
 	struct sg_header *ohp = &ov2hdr;
 	struct sg_io_hdr *h3p = &v3hdr;
+	struct sg_comm_wr_t cwr;
 	u8 cmnd[SG_MAX_CDB_SIZE];
 
 	res = sg_check_file_access(filp, __func__);
@@ -588,7 +595,11 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 				   input_size, (unsigned int) cmnd[0],
 				   current->comm);
 	}
-	res = sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
+	cwr.timeout = sfp->timeout;
+	cwr.blocking = blocking;
+	cwr.srp = srp;
+	cwr.cmnd = cmnd;
+	res = sg_common_write(sfp, &cwr);
 	return (res < 0) ? res : count;
 }
 
@@ -611,6 +622,7 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 	int k;
 	struct sg_request *srp;
 	struct sg_io_hdr *hp;
+	struct sg_comm_wr_t cwr;
 	u8 cmnd[SG_MAX_CDB_SIZE];
 	int timeout;
 	unsigned long ul_timeout;
@@ -661,23 +673,28 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 		sg_remove_request(sfp, srp);
 		return -EPERM;
 	}
-	k = sg_common_write(sfp, srp, cmnd, timeout, blocking);
+	cwr.timeout = timeout;
+	cwr.blocking = blocking;
+	cwr.srp = srp;
+	cwr.cmnd = cmnd;
+	k = sg_common_write(sfp, &cwr);
 	if (k < 0)
 		return k;
 	if (o_srp)
-		*o_srp = srp;
+		*o_srp = cwr.srp;
 	return count;
 }
 
 static int
-sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
-		u8 *cmnd, int timeout, int blocking)
+sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 {
-	int k, at_head;
+	bool at_head;
+	int k;
 	struct sg_device *sdp = sfp->parentdp;
+	struct sg_request *srp = cwrp->srp;
 	struct sg_io_hdr *hp = &srp->header;
 
-	srp->data.cmd_opcode = cmnd[0];	/* hold opcode of command */
+	srp->data.cmd_opcode = cwrp->cmnd[0];	/* hold opcode of command */
 	hp->status = 0;
 	hp->masked_status = 0;
 	hp->msg_status = 0;
@@ -686,12 +703,12 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 	hp->driver_status = 0;
 	hp->resid = 0;
 	SG_LOG(4, sfp, "%s:  opcode=0x%02x, cmd_sz=%d\n", __func__,
-	       (int)cmnd[0], hp->cmd_len);
+	       (int)cwrp->cmnd[0], hp->cmd_len);
 
 	if (hp->dxfer_len >= SZ_256M)
 		return -EINVAL;
 
-	k = sg_start_req(srp, cmnd);
+	k = sg_start_req(srp, cwrp->cmnd);
 	if (k) {
 		SG_LOG(1, sfp, "%s: start_req err=%d\n", __func__, k);
 		sg_finish_scsi_blk_rq(srp);
@@ -713,13 +730,13 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 	hp->duration = jiffies_to_msecs(jiffies);
 	if (hp->interface_id != '\0' &&	/* v3 (or later) interface */
 	    (SG_FLAG_Q_AT_TAIL & hp->flags))
-		at_head = 0;
+		at_head = false;
 	else
-		at_head = 1;
+		at_head = true;
 
-	if (!blocking)
+	if (!srp->sg_io_owned)
 		atomic_inc(&sfp->submitted);
-	srp->rq->timeout = timeout;
+	srp->rq->timeout = cwrp->timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
 	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
 			      srp->rq, at_head, sg_rq_end_io);
-- 
2.25.1

