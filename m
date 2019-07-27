Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9B7764D
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jul 2019 05:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfG0Dh5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 23:37:57 -0400
Received: from smtp.infotech.no ([82.134.31.41]:54603 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfG0Dh4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 23:37:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 0E16C20417C;
        Sat, 27 Jul 2019 05:37:55 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A4NC6sKgdZVG; Sat, 27 Jul 2019 05:37:53 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id C1A8F2041BB;
        Sat, 27 Jul 2019 05:37:51 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH v2 10/18] sg: remove most access_ok functions
Date:   Fri, 26 Jul 2019 23:37:20 -0400
Message-Id: <20190727033728.21134-11-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190727033728.21134-1-dgilbert@interlog.com>
References: <20190727033728.21134-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since access_ok() has lost it direction (3rd) parameter there
seems to be no benefit in calling access_ok() before
__copy_{to|from}_user(). Simplify code by using the variant of
these functions that do not start with "__".

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 50 ++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 7e188ac2f182..123d8516a9a0 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -502,11 +502,9 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	if (res)
 		return res;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
 	if (count < SZ_SG_HEADER)
 		return -EIO;
-	if (__copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
+	if (copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
 		return -EFAULT;
 	if (old_hdr.reply_len < 0)
 		return sg_submit(sfp, filp, buf, count, blocking, false, false,
@@ -561,7 +559,7 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	hp->flags = input_size;	/* structure abuse ... */
 	hp->pack_id = old_hdr.pack_id;
 	hp->usr_ptr = NULL;
-	if (__copy_from_user(cmnd, buf, cmd_size))
+	if (copy_from_user(cmnd, buf, cmd_size))
 		return -EFAULT;
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
@@ -607,8 +605,6 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 
 	if (count < SZ_SG_IO_HDR)
 		return -EINVAL;
-	if (!access_ok(buf, count))
-		return -EFAULT; /* protects following copy_from_user()s + get_user()s */
 
 	sfp->cmd_q = 1;	/* when sg_io_hdr seen, set command queuing on */
 	if (!(srp = sg_add_request(sfp))) {
@@ -617,7 +613,7 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 	}
 	srp->sg_io_owned = sg_io_owned;
 	hp = &srp->header;
-	if (__copy_from_user(hp, buf, SZ_SG_IO_HDR)) {
+	if (copy_from_user(hp, buf, SZ_SG_IO_HDR)) {
 		sg_remove_request(sfp, srp);
 		return -EFAULT;
 	}
@@ -645,11 +641,7 @@ sg_submit(struct sg_fd *sfp, struct file *filp, const char __user *buf,
 		sg_remove_request(sfp, srp);
 		return -EMSGSIZE;
 	}
-	if (!access_ok(hp->cmdp, hp->cmd_len)) {
-		sg_remove_request(sfp, srp);
-		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
-	}
-	if (__copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
+	if (copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
 		sg_remove_request(sfp, srp);
 		return -EFAULT;
 	}
@@ -829,13 +821,11 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 	if (ret)
 		return ret;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
 		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
 		if (!old_hdr)
 			return -ENOMEM;
-		if (__copy_from_user(old_hdr, buf, SZ_SG_HEADER)) {
+		if (copy_from_user(old_hdr, buf, SZ_SG_HEADER)) {
 			ret = -EFAULT;
 			goto free_old_hdr;
 		}
@@ -848,8 +838,8 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 					ret = -ENOMEM;
 					goto free_old_hdr;
 				}
-				ret = __copy_from_user
-				    (new_hdr, buf, SZ_SG_IO_HDR);
+				ret = copy_from_user(new_hdr, buf,
+						     SZ_SG_IO_HDR);
 				req_pack_id = new_hdr->pack_id;
 				kfree(new_hdr);
 				if (ret) {
@@ -942,7 +932,7 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 
 	/* Now copy the result back to the user buffer.  */
 	if (count >= SZ_SG_HEADER) {
-		if (__copy_to_user(buf, old_hdr, SZ_SG_HEADER)) {
+		if (copy_to_user(buf, old_hdr, SZ_SG_HEADER)) {
 			ret = -EFAULT;
 			goto free_old_hdr;
 		}
@@ -1032,8 +1022,6 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		result = sg_allow_if_err_recovery(sdp, false);
 		if (result)
 			return result;
-		if (!access_ok(p, SZ_SG_IO_HDR))
-			return -EFAULT;
 		result = sg_submit(sfp, filp, p, SZ_SG_IO_HDR, true, read_only,
 				   true, &srp);
 		if (result < 0)
@@ -1107,19 +1095,17 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		sfp->force_packid = val ? 1 : 0;
 		return 0;
 	case SG_GET_PACK_ID:
-		if (!access_ok(ip, sizeof (int)))
-			return -EFAULT;
 		read_lock_irqsave(&sfp->rq_list_lock, iflags);
 		list_for_each_entry(srp, &sfp->rq_list, entry) {
 			if ((1 == srp->done) && (!srp->sg_io_owned)) {
 				read_unlock_irqrestore(&sfp->rq_list_lock,
 						       iflags);
-				__put_user(srp->header.pack_id, ip);
+				put_user(srp->header.pack_id, ip);
 				return 0;
 			}
 		}
 		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-		__put_user(-1, ip);
+		put_user(-1, ip);
 		return 0;
 	case SG_GET_NUM_WAITING:
 		return put_user(atomic_read(&sfp->waiting), ip);
@@ -1181,9 +1167,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		val = (sdp->device ? 1 : 0);
 		return put_user(val, ip);
 	case SG_GET_REQUEST_TABLE:
-		if (!access_ok(p, SZ_SG_REQ_INFO * SG_MAX_QUEUE))
-			return -EFAULT;
-		else {
+		{
 			sg_req_info_t *rinfo;
 
 			rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
@@ -1193,8 +1177,8 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 			read_lock_irqsave(&sfp->rq_list_lock, iflags);
 			sg_fill_request_table(sfp, rinfo);
 			read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-			result = __copy_to_user(p, rinfo,
-						SZ_SG_REQ_INFO * SG_MAX_QUEUE);
+			result = copy_to_user(p, rinfo,
+					      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
 			result = result ? -EFAULT : 0;
 			kfree(rinfo);
 			return result;
@@ -2083,13 +2067,13 @@ sg_rd_append(struct sg_request *srp, void __user *outp, int num_xfer)
 	num = 1 << (PAGE_SHIFT + schp->page_order);
 	for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
 		if (num > num_xfer) {
-			if (__copy_to_user(outp, page_address(schp->pages[k]),
-					   num_xfer))
+			if (copy_to_user(outp, page_address(schp->pages[k]),
+					 num_xfer))
 				return -EFAULT;
 			break;
 		} else {
-			if (__copy_to_user(outp, page_address(schp->pages[k]),
-					   num))
+			if (copy_to_user(outp, page_address(schp->pages[k]),
+					 num))
 				return -EFAULT;
 			num_xfer -= num;
 			if (num_xfer <= 0)
-- 
2.17.1

