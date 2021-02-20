Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914413202D0
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Feb 2021 03:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBTCC6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Feb 2021 21:02:58 -0500
Received: from smtp.infotech.no ([82.134.31.41]:43675 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhBTCCc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3AEB72041BD;
        Sat, 20 Feb 2021 03:01:13 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XLNrfmEhQy8w; Sat, 20 Feb 2021 03:01:10 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id D847F20425C;
        Sat, 20 Feb 2021 03:01:04 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v16 04/45] sg: rework sg_poll(), minor changes
Date:   Fri, 19 Feb 2021 21:00:15 -0500
Message-Id: <20210220020056.77483-5-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220020056.77483-1-dgilbert@interlog.com>
References: <20210220020056.77483-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Re-arrange code in sg_poll(). Rename sg_read_oxfer() to
sg_rd_append(). In sg_start_req() rename rw to r0w.
Plus associated changes demanded by checkpatch.pl

Reviewed-by: Hannes Reinecke <hare@suse.com>

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 65 ++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index a4290a8069d4..4b8e6a3d243f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -182,8 +182,8 @@ static ssize_t sg_new_write(struct sg_fd *sfp, struct file *file,
 			    struct sg_request **o_srp);
 static int sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 			   u8 *cmnd, int timeout, int blocking);
-static int sg_read_oxfer(struct sg_request *srp, char __user *outp,
-			 int num_xfer);
+static int sg_rd_append(struct sg_request *srp, char __user *outp,
+			int num_xfer);
 static void sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp);
 static void sg_build_reserve(struct sg_fd *sfp, int req_size);
 static void sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp,
@@ -797,7 +797,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
 		if (!old_hdr)
 			return -ENOMEM;
-		if (__copy_from_user(old_hdr, buf, SZ_SG_HEADER)) {
+		if (copy_from_user(old_hdr, buf, SZ_SG_HEADER)) {
 			retval = -EFAULT;
 			goto free_old_hdr;
 		}
@@ -810,7 +810,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 					retval = -ENOMEM;
 					goto free_old_hdr;
 				}
-				retval = __copy_from_user
+				retval = copy_from_user
 				    (new_hdr, buf, SZ_SG_IO_HDR);
 				req_pack_id = new_hdr->pack_id;
 				kfree(new_hdr);
@@ -905,7 +905,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 
 	/* Now copy the result back to the user buffer.  */
 	if (count >= SZ_SG_HEADER) {
-		if (__copy_to_user(buf, old_hdr, SZ_SG_HEADER)) {
+		if (copy_to_user(buf, old_hdr, SZ_SG_HEADER)) {
 			retval = -EFAULT;
 			goto free_old_hdr;
 		}
@@ -913,7 +913,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 		if (count > old_hdr->reply_len)
 			count = old_hdr->reply_len;
 		if (count > SZ_SG_HEADER) {
-			if (sg_read_oxfer(srp, buf, count - SZ_SG_HEADER)) {
+			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER)) {
 				retval = -EFAULT;
 				goto free_old_hdr;
 			}
@@ -1279,38 +1279,34 @@ sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 static __poll_t
 sg_poll(struct file *filp, poll_table * wait)
 {
-	__poll_t res = 0;
-	struct sg_device *sdp;
-	struct sg_fd *sfp;
+	__poll_t p_res = 0;
+	struct sg_fd *sfp = filp->private_data;
 	struct sg_request *srp;
 	int count = 0;
 	unsigned long iflags;
 
-	sfp = filp->private_data;
 	if (!sfp)
 		return EPOLLERR;
-	sdp = sfp->parentdp;
-	if (!sdp)
-		return EPOLLERR;
 	poll_wait(filp, &sfp->read_wait, wait);
 	read_lock_irqsave(&sfp->rq_list_lock, iflags);
 	list_for_each_entry(srp, &sfp->rq_list, entry) {
 		/* if any read waiting, flag it */
-		if ((0 == res) && (1 == srp->done) && (!srp->sg_io_owned))
-			res = EPOLLIN | EPOLLRDNORM;
+		if (p_res == 0 && srp->done == 1 && !srp->sg_io_owned)
+			p_res = EPOLLIN | EPOLLRDNORM;
 		++count;
 	}
 	read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
 
-	if (atomic_read(&sdp->detaching))
-		res |= EPOLLHUP;
-	else if (!sfp->cmd_q) {
-		if (0 == count)
-			res |= EPOLLOUT | EPOLLWRNORM;
-	} else if (count < SG_MAX_QUEUE)
-		res |= EPOLLOUT | EPOLLWRNORM;
-	SG_LOG(3, sfp, "%s: res=0x%x\n", __func__, (__force u32)res);
-	return res;
+	if (sfp->parentdp && atomic_read(&sfp->parentdp->detaching)) {
+		p_res |= EPOLLHUP;
+	} else if (!sfp->cmd_q) {
+		if (count == 0)
+			p_res |= EPOLLOUT | EPOLLWRNORM;
+	} else if (count < SG_MAX_QUEUE) {
+		p_res |= EPOLLOUT | EPOLLWRNORM;
+	}
+	SG_LOG(3, sfp, "%s: p_res=0x%x\n", __func__, (__force u32)p_res);
+	return p_res;
 }
 
 static int
@@ -1828,7 +1824,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 	struct sg_scatter_hold *rsv_schp = &sfp->reserve;
 	struct request_queue *q = sfp->parentdp->device->request_queue;
 	struct rq_map_data *md, map_data;
-	int rw = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
+	int r0w = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
 	u8 *long_cmdp = NULL;
 
 	if (hp->cmd_len > BLK_MAX_CDB) {
@@ -1838,7 +1834,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 		SG_LOG(5, sfp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
 	}
 	SG_LOG(4, sfp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
-	       (rw ? "OUT" : "IN"));
+	       (r0w ? "OUT" : "IN"));
 
 	/*
 	 * NOTE
@@ -1915,7 +1911,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 		struct iovec *iov = NULL;
 		struct iov_iter i;
 
-		res = import_iovec(rw, hp->dxferp, iov_count, 0, &iov, &i);
+		res = import_iovec(r0w, hp->dxferp, iov_count, 0, &iov, &i);
 		if (res < 0)
 			return res;
 
@@ -2084,33 +2080,32 @@ sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp)
  * appended to given struct sg_header object.
  */
 static int
-sg_read_oxfer(struct sg_request *srp, char __user *outp, int num_read_xfer)
+sg_rd_append(struct sg_request *srp, char __user *outp, int num_xfer)
 {
 	struct sg_scatter_hold *schp = &srp->data;
 	int k, num;
 
-	SG_LOG(4, srp->parentfp, "%s: num_xfer=%d\n", __func__, num_read_xfer);
-	if ((!outp) || (num_read_xfer <= 0))
+	SG_LOG(4, srp->parentfp, "%s: num_xfer=%d\n", __func__, num_xfer);
+	if (!outp || num_xfer <= 0)
 		return 0;
 
 	num = 1 << (PAGE_SHIFT + schp->page_order);
 	for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
-		if (num > num_read_xfer) {
+		if (num > num_xfer) {
 			if (copy_to_user(outp, page_address(schp->pages[k]),
-					   num_read_xfer))
+					   num_xfer))
 				return -EFAULT;
 			break;
 		} else {
 			if (copy_to_user(outp, page_address(schp->pages[k]),
 					   num))
 				return -EFAULT;
-			num_read_xfer -= num;
-			if (num_read_xfer <= 0)
+			num_xfer -= num;
+			if (num_xfer <= 0)
 				break;
 			outp += num;
 		}
 	}
-
 	return 0;
 }
 
-- 
2.25.1

