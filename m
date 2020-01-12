Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D091388E1
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jan 2020 00:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbgALX6T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jan 2020 18:58:19 -0500
Received: from smtp.infotech.no ([82.134.31.41]:51997 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgALX6T (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 12 Jan 2020 18:58:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3FCE220424C;
        Mon, 13 Jan 2020 00:58:17 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qkmUkMqmgMRi; Mon, 13 Jan 2020 00:58:14 +0100 (CET)
Received: from xtwo70.bingwo.ca (unknown [213.52.86.138])
        by smtp.infotech.no (Postfix) with ESMTPA id 9F26E204273;
        Mon, 13 Jan 2020 00:57:58 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v6 13/37] sg: split sg_read
Date:   Mon, 13 Jan 2020 00:57:31 +0100
Message-Id: <20200112235755.14197-14-dgilbert@interlog.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112235755.14197-1-dgilbert@interlog.com>
References: <20200112235755.14197-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As sg_read() is getting quite long, split out the v1 and v2
processing into sg_read_v1v2(). Rename sg_new_read() to
sg_receive_v3() as the v3 interface is now older than the v4
interface which is being added in a later patch.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 286 +++++++++++++++++++++++-----------------------
 1 file changed, 140 insertions(+), 146 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 86634596dcf8..9556fc56d9cc 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -188,8 +188,8 @@ static ssize_t sg_submit(struct sg_fd *sfp, struct file *filp,
 			 struct sg_request **o_srp);
 static int sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
 			   u8 *cmnd, int timeout, int blocking);
-static int sg_rd_append(struct sg_request *srp, void __user *outp,
-			int num_xfer);
+static int sg_read_append(struct sg_request *srp, void __user *outp,
+			  int num_xfer);
 static void sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp);
 static void sg_build_reserve(struct sg_fd *sfp, int req_size);
 static void sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp,
@@ -241,7 +241,7 @@ static void sg_device_destroy(struct kref *kref);
 			pr_info("sg: sdp or sfp NULL, " fmt, ##a);	\
 	} while (0)
 #else
-#define SG_LOG(depth, sfp, fmt, a...)
+#define SG_LOG(depth, sfp, fmt, a...) { }
 #endif	/* end of CONFIG_SCSI_LOGGING && SG_DEBUG conditional */
 
 
@@ -760,17 +760,12 @@ sg_get_rq_mark(struct sg_fd *sfp, int pack_id)
 }
 
 static ssize_t
-sg_new_read(struct sg_fd *sfp, char __user *buf, size_t count,
-	    struct sg_request *srp)
+sg_receive_v3(struct sg_fd *sfp, char __user *buf, struct sg_request *srp)
 {
 	struct sg_io_hdr *hp = &srp->header;
 	int err = 0, err2;
 	int len;
 
-	if (count < SZ_SG_IO_HDR) {
-		err = -EINVAL;
-		goto err_out;
-	}
 	hp->sb_len_wr = 0;
 	if ((hp->mx_sb_len > 0) && hp->sbp) {
 		if ((CHECK_CONDITION & hp->masked_status) ||
@@ -791,14 +786,15 @@ sg_new_read(struct sg_fd *sfp, char __user *buf, size_t count,
 	}
 	if (hp->masked_status || hp->host_status || hp->driver_status)
 		hp->info |= SG_INFO_CHECK;
-	if (copy_to_user(buf, hp, SZ_SG_IO_HDR)) {
+	if (copy_to_user(buf, hp, SZ_SG_IO_HDR))
 		err = -EFAULT;
-		goto err_out;
-	}
+
 err_out:
 	err2 = sg_finish_scsi_blk_rq(srp);
+	if (err2)
+		err = err ? err : err2;
 	sg_remove_request(sfp, srp);
-	return err ? : err2 ? : count;
+	return err ? err : 0;
 }
 
 static int
@@ -813,166 +809,165 @@ srp_done(struct sg_fd *sfp, struct sg_request *srp)
 	return ret;
 }
 
-static ssize_t
-sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
+static int
+sg_read_v1v2(void __user *buf, int count, struct sg_fd *sfp,
+	     struct sg_request *srp)
 {
-	struct sg_device *sdp;
-	struct sg_fd *sfp;
-	struct sg_request *srp;
-	int req_pack_id = -1;
-	int ret = 0;
-	struct sg_io_hdr *hp;
-	struct sg_header *old_hdr = NULL;
-
-	/*
-	 * This could cause a response to be stranded. Close the associated
-	 * file descriptor to free up any resources being held.
-	 */
-	ret = sg_check_file_access(filp, __func__);
-	if (ret)
-		return ret;
-
-	sfp = filp->private_data;
-	sdp = sfp->parentdp;
-	SG_LOG(3, sfp, "%s: read() count=%d\n", __func__, (int)count);
-	ret = sg_allow_if_err_recovery(sdp, false);
-	if (ret)
-		return ret;
-
-	if (!access_ok(buf, count))
-		return -EFAULT;
-	if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
-		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
-		if (!old_hdr)
-			return -ENOMEM;
-		if (copy_from_user(old_hdr, buf, SZ_SG_HEADER)) {
-			ret = -EFAULT;
-			goto free_old_hdr;
-		}
-		if (old_hdr->reply_len < 0) {
-			if (count >= SZ_SG_IO_HDR) {
-				struct sg_io_hdr *new_hdr;
-
-				new_hdr = kmalloc(SZ_SG_IO_HDR, GFP_KERNEL);
-				if (!new_hdr) {
-					ret = -ENOMEM;
-					goto free_old_hdr;
-				}
-				ret = copy_from_user
-				    (new_hdr, buf, SZ_SG_IO_HDR);
-				req_pack_id = new_hdr->pack_id;
-				kfree(new_hdr);
-				if (ret) {
-					ret = -EFAULT;
-					goto free_old_hdr;
-				}
-			}
-		} else
-			req_pack_id = old_hdr->pack_id;
-	}
-	srp = sg_get_rq_mark(sfp, req_pack_id);
-	if (!srp) {		/* now wait on packet to arrive */
-		if (SG_IS_DETACHING(sdp)) {
-			ret = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (filp->f_flags & O_NONBLOCK) {
-			ret = -EAGAIN;
-			goto free_old_hdr;
-		}
-		ret = wait_event_interruptible
-				(sfp->read_wait,
-				 (SG_IS_DETACHING(sdp) ||
-				  (srp = sg_get_rq_mark(sfp, req_pack_id))));
-		if (SG_IS_DETACHING(sdp)) {
-			ret = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (ret) {
-			/* -ERESTARTSYS as signal hit process */
-			goto free_old_hdr;
-		}
-	}
-	if (srp->header.interface_id != '\0') {
-		ret = sg_new_read(sfp, buf, count, srp);
-		goto free_old_hdr;
-	}
-
-	hp = &srp->header;
-	if (old_hdr == NULL) {
-		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
-		if (!old_hdr) {
-			ret = -ENOMEM;
-			goto free_old_hdr;
-		}
-	}
-	memset(old_hdr, 0, SZ_SG_HEADER);
-	old_hdr->reply_len = (int) hp->timeout;
-	old_hdr->pack_len = old_hdr->reply_len; /* old, strange behaviour */
-	old_hdr->pack_id = hp->pack_id;
-	old_hdr->twelve_byte =
-	    ((srp->data.cmd_opcode >= 0xc0) && (hp->cmd_len == 12)) ? 1 : 0;
-	old_hdr->target_status = hp->masked_status;
-	old_hdr->host_status = hp->host_status;
-	old_hdr->driver_status = hp->driver_status;
-	if ((hp->masked_status & CHECK_CONDITION) ||
-	    (hp->driver_status & DRIVER_SENSE))
-		memcpy(old_hdr->sense_buffer, srp->sense_b,
-		       sizeof(old_hdr->sense_buffer));
-	switch (hp->host_status) {
+	int res = 0;
+	struct sg_io_hdr *sh3p = &srp->header;
+	struct sg_header *h2p;
+	struct sg_header a_v2hdr;
+
+	h2p = &a_v2hdr;
+	memset(h2p, 0, SZ_SG_HEADER);
+	h2p->reply_len = (int)sh3p->timeout;
+	h2p->pack_len = h2p->reply_len; /* old, strange behaviour */
+	h2p->pack_id = sh3p->pack_id;
+	h2p->twelve_byte = (srp->data.cmd_opcode >= 0xc0 &&
+			    sh3p->cmd_len == 12);
+	h2p->target_status = sh3p->masked_status;
+	h2p->host_status = sh3p->host_status;
+	h2p->driver_status = sh3p->driver_status;
+	if ((CHECK_CONDITION & h2p->target_status) ||
+	    (DRIVER_SENSE & sh3p->driver_status)) {
+		memcpy(h2p->sense_buffer, srp->sense_b,
+		       sizeof(h2p->sense_buffer));
+	}
+	switch (h2p->host_status) {
 	/*
-	 * This setup of 'result' is for backward compatibility and is best
-	 * ignored by the user who should use target, host + driver status
+	 * This foolowing setting of 'result' is for backward compatibility
+	 * and is best ignored by the user who should use target, host and
+	 * driver status.
 	 */
 	case DID_OK:
 	case DID_PASSTHROUGH:
 	case DID_SOFT_ERROR:
-		old_hdr->result = 0;
+		h2p->result = 0;
 		break;
 	case DID_NO_CONNECT:
 	case DID_BUS_BUSY:
 	case DID_TIME_OUT:
-		old_hdr->result = EBUSY;
+		h2p->result = EBUSY;
 		break;
 	case DID_BAD_TARGET:
 	case DID_ABORT:
 	case DID_PARITY:
 	case DID_RESET:
 	case DID_BAD_INTR:
-		old_hdr->result = EIO;
+		h2p->result = EIO;
 		break;
 	case DID_ERROR:
-		old_hdr->result = (srp->sense_b[0] == 0 &&
-				  hp->masked_status == GOOD) ? 0 : EIO;
+		h2p->result = (h2p->target_status == GOOD) ? 0 : EIO;
 		break;
 	default:
-		old_hdr->result = EIO;
+		h2p->result = EIO;
 		break;
 	}
 
 	/* Now copy the result back to the user buffer.  */
 	if (count >= SZ_SG_HEADER) {
-		if (copy_to_user(buf, old_hdr, SZ_SG_HEADER)) {
-			ret = -EFAULT;
-			goto free_old_hdr;
-		}
+		if (copy_to_user(buf, h2p, SZ_SG_HEADER))
+			return -EFAULT;
 		buf += SZ_SG_HEADER;
-		if (count > old_hdr->reply_len)
-			count = old_hdr->reply_len;
+		if (count > h2p->reply_len)
+			count = h2p->reply_len;
 		if (count > SZ_SG_HEADER) {
-			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER)) {
-				ret = -EFAULT;
-				goto free_old_hdr;
-			}
+			if (sg_read_append(srp, buf, count - SZ_SG_HEADER))
+				return -EFAULT;
 		}
 	} else
-		count = (old_hdr->result == 0) ? 0 : -EIO;
+		res = (h2p->result == 0) ? 0 : -EIO;
 	sg_finish_scsi_blk_rq(srp);
 	sg_remove_request(sfp, srp);
-	ret = count;
-free_old_hdr:
-	kfree(old_hdr);
-	return ret;
+	return res;
+}
+
+static ssize_t
+sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
+{
+	bool could_be_v3;
+	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	int want_id = -1;
+	int hlen, ret;
+	struct sg_device *sdp;
+	struct sg_fd *sfp;
+	struct sg_request *srp;
+	struct sg_header *h2p = NULL;
+	struct sg_io_hdr a_sg_io_hdr;
+
+	/*
+	 * This could cause a response to be stranded. Close the associated
+	 * file descriptor to free up any resources being held.
+	 */
+	ret = sg_check_file_access(filp, __func__);
+	if (ret)
+		return ret;
+
+	sfp = filp->private_data;
+	sdp = sfp->parentdp;
+	SG_LOG(3, sfp, "%s: read() count=%d\n", __func__, (int)count);
+	ret = sg_allow_if_err_recovery(sdp, false);
+	if (ret)
+		return ret;
+
+	could_be_v3 = (count >= SZ_SG_IO_HDR);
+	hlen = could_be_v3 ? SZ_SG_IO_HDR : SZ_SG_HEADER;
+	h2p = (struct sg_header *)&a_sg_io_hdr;
+
+	if (sfp->force_packid && count >= hlen) {
+		/*
+		 * Even though this is a user space read() system call, this
+		 * code is cheating to fetch the pack_id.
+		 * Only need first three 32 bit ints to determine interface.
+		 */
+		if (unlikely(copy_from_user(h2p, p, 3 * sizeof(int))))
+			return -EFAULT;
+		if (h2p->reply_len < 0 && could_be_v3) {
+			struct sg_io_hdr *v3_hdr = (struct sg_io_hdr *)h2p;
+
+			if (likely(v3_hdr->interface_id == 'S')) {
+				struct sg_io_hdr __user *h3_up;
+
+				h3_up = (struct sg_io_hdr __user *)p;
+				ret = get_user(want_id, &h3_up->pack_id);
+				if (unlikely(ret))
+					return ret;
+			} else if (v3_hdr->interface_id == 'Q') {
+				pr_info_once("sg: %s: v4 interface%s here\n",
+					     __func__, " disallowed");
+				return -EPERM;
+			} else {
+				return -EPERM;
+			}
+		} else { /* for v1+v2 interfaces, this is the 3rd integer */
+			want_id = h2p->pack_id;
+		}
+	}
+	srp = sg_get_rq_mark(sfp, want_id);
+	if (!srp) {		/* now wait on packet to arrive */
+		if (SG_IS_DETACHING(sdp))
+			return -ENODEV;
+		if (non_block) /* O_NONBLOCK or v3::flags & SGV4_FLAG_IMMED */
+			return -EAGAIN;
+		ret = wait_event_interruptible
+				(sfp->read_wait,
+				 (SG_IS_DETACHING(sdp) ||
+				  (srp = sg_get_rq_mark(sfp, want_id))));
+		if (SG_IS_DETACHING(sdp))
+			return -ENODEV;
+		if (ret)	/* -ERESTARTSYS as signal hit process */
+			return ret;
+	}
+	if (srp->header.interface_id == '\0') {
+		ret = sg_read_v1v2(p, (int)count, sfp, srp);
+	} else {
+		if ((int)count < SZ_SG_IO_HDR)
+			return -EINVAL;
+		ret = sg_receive_v3(sfp, p, srp);
+	}
+	if (ret < 0)
+		SG_LOG(1, sfp, "%s: negated errno: %d\n", __func__, ret);
+	return ret < 0 ? ret : (int)count;
 }
 
 static int
@@ -1045,7 +1040,7 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	if (srp->done) {
 		srp->done = 2;
 		spin_unlock_irq(&sfp->rq_list_lock);
-		res = sg_new_read(sfp, p, SZ_SG_IO_HDR, srp);
+		res = sg_receive_v3(sfp, p, srp);
 		return (res < 0) ? res : 0;
 	}
 	srp->orphan = 1;
@@ -2183,7 +2178,7 @@ sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp)
  * appended to given struct sg_header object.
  */
 static int
-sg_rd_append(struct sg_request *srp, void __user *outp, int num_xfer)
+sg_read_append(struct sg_request *srp, void __user *outp, int num_xfer)
 {
 	struct sg_scatter_hold *schp = &srp->data;
 	int k, num;
@@ -2254,9 +2249,8 @@ sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp, int size)
 			rem -= num;
 	}
 
-	if (k >= rsv_schp->num_sgat) {
+	if (k >= rsv_schp->num_sgat)
 		SG_LOG(1, sfp, "%s: BAD size\n", __func__);
-	}
 }
 
 static void
-- 
2.24.1

