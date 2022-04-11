Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9CC4FB1D8
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Apr 2022 04:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244367AbiDKCdF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 10 Apr 2022 22:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbiDKCcZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 10 Apr 2022 22:32:25 -0400
Received: from smtp.infotech.no (smtp.infotech.no [82.134.31.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E97B3B3
        for <linux-scsi@vger.kernel.org>; Sun, 10 Apr 2022 19:29:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 0BEE92041C0;
        Mon, 11 Apr 2022 04:29:35 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LDFtNvVA8IXV; Mon, 11 Apr 2022 04:29:32 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        by smtp.infotech.no (Postfix) with ESMTPA id 827C92041B2;
        Mon, 11 Apr 2022 04:29:31 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org
Subject: [PATCH v24 44/46] sg: add bio_poll support
Date:   Sun, 10 Apr 2022 22:28:34 -0400
Message-Id: <20220411022836.11871-45-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411022836.11871-1-dgilbert@interlog.com>
References: <20220411022836.11871-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Adds the SGV4_FLAG_POLLED command flag which causes REQ_POLLED to be
set on the request. This will attempt to do polling in the associated
SCSI low level driver (LLD) for completion. An example of an LLD is
the driver for a SAS HBA (host bus adapter) such as mpt3sas.

Before waiting on an inflight request, a check is made to see if the
SGV4_FLAG_POLLED is set and if so, bio_poll() is called instead of
the wait. In situations where only the file descriptor is known (e.g.
sg_poll() and ioctl(SG_GET_NUM_WAITING)) all inflight requests
associated with the file descriptor that have SGV4_FLAG_POLLED set,
have bio_poll() called on them.

It is important to know blk_execute_rq_nowait() has finished before
sending bio_poll() on that request. The SG_RS_INFLIGHT state is set
just before blk_execute_rq_nowait() is called so a new bit setting
SG_FRQ_ISSUED has been added that is set just after that calls
returns.

bio_poll() is char device/driver unfriendly. It needs information
such as the associated request_queue placed in a struct block_device
object, something the a char device (e.g. a sg device) does not
normally have. Enter the new dummy_bdev pointer placed in struct
sg_device. It remains NULL until the first time a SGV4_FLAG_POLLED
flag is set on a command for a given device. Only then is the
dummy block_object created. It would be much easier if bio_poll()
just accepted a request_queue argument.

Note that the implementation of bio_poll() calls mq_poll() in the
LLD associated with the request. Then for any request found to be
ready, bio_poll() invokes the scsi_done() callback. When bio_poll()
returns > 0 , sg_rq_end_io() may have been called on the given
request. If so the given request will be in await_rcv state.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 169 +++++++++++++++++++++++++++++++++++++++--
 include/uapi/scsi/sg.h |   1 +
 2 files changed, 164 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index eaf0bb9bd004..b6fee732eb7b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -120,12 +120,15 @@ enum sg_rq_state {	/* N.B. sg_rq_state_arr assumes SG_RS_AWAIT_RCV==2 */
 #define SG_FRQ_RECEIVING	7	/* guard against multiple receivers */
 #define SG_FRQ_FOR_MMAP		8	/* request needs PAGE_SIZE elements */
 #define SG_FRQ_COUNT_ACTIVE	9	/* sfp->submitted + waiting active */
+#define SG_FRQ_ISSUED		10	/* blk_execute_rq_nowait() finished */
+#define SG_FRQ_POLLING		11	/* to stop co-incident bio_poll()s */
 
 /* Bit positions (flags) for sg_fd::ffd_bm bitmask follow */
 #define SG_FFD_FORCE_PACKID	0	/* receive only given pack_id/tag */
 #define SG_FFD_CMD_Q		1	/* clear: only 1 active req per fd */
 #define SG_FFD_KEEP_ORPHAN	2	/* policy for this fd */
-#define SG_FFD_Q_AT_TAIL	3	/* set: queue reqs at tail of blk q */
+#define SG_FFD_POLLED_SEEN	3	/* could have POLLED requests active */
+#define SG_FFD_Q_AT_TAIL	4	/* set: queue reqs at tail of blk q */
 
 /* Bit positions (flags) for sg_device::fdev_bm bitmask follow */
 #define SG_FDEV_EXCLUDE		0	/* have fd open with O_EXCL */
@@ -259,6 +262,7 @@ struct sg_device { /* holds the state of each scsi generic device */
 	unsigned long fdev_bm[1];	/* see SG_FDEV_* defines above */
 	char name[DISK_NAME_LEN];
 	struct cdev *cdev;
+	struct block_device *dummy_bdev;	/* hack for REQ_POLLED */
 	struct xarray sfp_arr;
 	struct kref d_ref;
 };
@@ -304,6 +308,9 @@ static struct sg_device *sg_get_dev(int min_dev);
 static void sg_device_destroy(struct kref *kref);
 static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
 					 int db_len);
+static int sg_sfp_bio_poll(struct sg_fd *sfp, int loop_count);
+static int sg_srp_q_bio_poll(struct sg_request *srp, struct request_queue *q,
+			     int loop_count);
 #if IS_ENABLED(CONFIG_SCSI_LOGGING) && IS_ENABLED(SG_DEBUG)
 static const char *sg_rq_st_str(enum sg_rq_state rq_st, bool long_str);
 #endif
@@ -1008,6 +1015,7 @@ static void
 sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 {
 	bool at_head, is_v4h, sync;
+	struct request *rqq = READ_ONCE(srp->rqq);
 
 	is_v4h = test_bit(SG_FRQ_IS_V4I, srp->frq_bm);
 	sync = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
@@ -1031,7 +1039,21 @@ sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 		atomic_inc(&sfp->submitted);
 		set_bit(SG_FRQ_COUNT_ACTIVE, srp->frq_bm);
 	}
-	blk_execute_rq_nowait(READ_ONCE(srp->rqq), (int)at_head, sg_rq_end_io);
+	if (srp->rq_flags & SGV4_FLAG_POLLED) {
+		if (test_bit(QUEUE_FLAG_POLL, &rqq->q->queue_flags)) {
+			set_bit(SG_FFD_POLLED_SEEN, sfp->ffd_bm);
+			rqq->cmd_flags |= REQ_POLLED;
+			if (srp->bio)
+				srp->bio->bi_opf |= REQ_POLLED;
+		} else {
+			if (srp->bio && (srp->bio->bi_opf & REQ_POLLED))
+				srp->bio->bi_opf &= ~REQ_POLLED;
+			clear_bit(SG_FFD_POLLED_SEEN, sfp->ffd_bm);
+			srp->rq_flags &= ~SGV4_FLAG_POLLED;
+		}
+	}
+	blk_execute_rq_nowait(rqq, (int)at_head, sg_rq_end_io);
+	set_bit(SG_FRQ_ISSUED, srp->frq_bm);
 }
 
 /*
@@ -1693,6 +1715,13 @@ sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
 
 	if (atomic_read(&srp->rq_st) != SG_RS_INFLIGHT)
 		goto skip_wait;		/* and skip _acquire() */
+	if (srp->rq_flags & SGV4_FLAG_POLLED) {
+		/* call bio_poll(), spinning till found */
+		res = sg_srp_q_bio_poll(srp, sdp->device->request_queue, -1);
+		if (res != -ENODATA && unlikely(res < 0))
+			return res;
+		goto skip_wait;
+	}
 	SG_LOG(3, sfp, "%s: about to wait_event...()\n", __func__);
 	/* usually will be woken up by sg_rq_end_io() callback */
 	res = wait_event_interruptible(sfp->read_wait,
@@ -1972,6 +2001,8 @@ sg_ioctl_common(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 		SG_LOG(3, sfp, "%s:    SG_GET_PACK_ID=%d\n", __func__, val);
 		return put_user(val, ip);
 	case SG_GET_NUM_WAITING:
+		if (test_bit(SG_FFD_POLLED_SEEN, sfp->ffd_bm))
+			sg_sfp_bio_poll(sfp, 0);	/* LLD may have some ready */
 		val = atomic_read(&sfp->waiting);
 		if (val)
 			return put_user(val, ip);
@@ -2156,6 +2187,102 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	return scsi_ioctl(sdp->device, filp->f_mode, cmd_in, p);
 }
 
+/*
+ * If the sg_request object is in SG_RS_AWAIT_RCV state, return 1. Otherwise,
+ * if it is not inflight, return -ENODATA. This function returns 1 if the
+ * given object was in inflight state and is in await_rcv state after
+ * bio_poll() returns 1 or more. If bio_poll() fails, then that (negative)
+ * value is returned. Otherwise returns 0. Note that bio_poll() may complete
+ * unrelated requests that share the same q.
+ */
+static int
+sg_srp_q_bio_poll(struct sg_request *srp, struct request_queue *q, int loop_count)
+{
+	int n = 0;
+	int k, num;
+	struct bio *biop;
+	struct sg_fd *sfp = srp->parentfp;
+	enum sg_rq_state sr_st = atomic_read(&srp->rq_st);
+
+	if (sr_st == SG_RS_AWAIT_RCV)
+		return 1;
+	else if (sr_st != SG_RS_INFLIGHT)
+		return -ENODATA;
+	if (test_and_set_bit(SG_FRQ_POLLING, srp->frq_bm))
+		return 0;	/* something else is polling this request */
+	biop = READ_ONCE(srp->bio);
+	if (!biop) {
+		clear_bit(SG_FRQ_POLLING, srp->frq_bm);
+		return 0;
+	}
+	bio_get(biop);
+	if (READ_ONCE(biop->bi_cookie) == BLK_QC_T_NONE) {
+		if (atomic_read(&srp->rq_st) == SG_RS_AWAIT_RCV)
+			n = 1;
+		else
+			SG_LOG(6, sfp, "%s: cookie==BLK_QC_T_NONE\n", __func__);
+		goto fini;
+	}
+	if (!READ_ONCE(biop->bi_bdev))
+		WRITE_ONCE(biop->bi_bdev, sfp->parentdp->dummy_bdev);
+
+	num = (loop_count < 1) ? 1 : loop_count;
+	for (n = 0, k = 0; k < num; ++k) {
+		n = bio_poll(biop, NULL, (loop_count < 0) ? BLK_POLL_NOSLEEP : 0);
+		if (n > 0) {
+			n = !!(atomic_read(&srp->rq_st) == SG_RS_AWAIT_RCV);
+			break;
+		} else if (n < 0) {
+			break;
+		}
+		if (atomic_read(&srp->rq_st) != SG_RS_INFLIGHT)
+			break;
+	}
+fini:
+	clear_bit(SG_FRQ_POLLING, srp->frq_bm);
+	bio_put(biop);
+	return n;
+}
+
+/*
+ * Check all requests on this sfp that are both inflight and POLLED. That check involves calling
+ * bio_poll(spin<-false) loop_count times. If loop_count is 0 then call bio_poll once.
+ * If loop_count is negative then call bio_poll(spin <- true)) once for each request.
+ * Returns number found (could be 0) or a negated errno value.
+ */
+static int
+sg_sfp_bio_poll(struct sg_fd *sfp, int loop_count)
+{
+	int res = 0;
+	int n;
+	unsigned long idx, iflags;
+	struct sg_request *srp;
+	struct scsi_device *sdev = sfp->parentdp->device;
+	struct request_queue *q = sdev ? sdev->request_queue : NULL;
+	struct xarray *xafp = &sfp->srp_arr;
+
+	if (!q)
+		return -EINVAL;
+	xa_lock_irqsave(xafp, iflags);
+	xa_for_each(xafp, idx, srp) {
+		if ((srp->rq_flags & SGV4_FLAG_POLLED) &&
+		    !test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm) &&
+		    atomic_read(&srp->rq_st) == SG_RS_INFLIGHT &&
+		    test_bit(SG_FRQ_ISSUED, srp->frq_bm)) {
+			xa_unlock_irqrestore(xafp, iflags);
+			n = sg_srp_q_bio_poll(srp, q, loop_count);
+			if (n == -ENODATA)
+				n = 0;
+			if (unlikely(n < 0))
+				return n;
+			xa_lock_irqsave(xafp, iflags);
+			res += n;
+		}
+	}
+	xa_unlock_irqrestore(xafp, iflags);
+	return res;
+}
+
 /*
  * Implements the poll(2) system call for this driver. Returns various EPOLL*
  * flags OR-ed together.
@@ -2167,6 +2294,8 @@ sg_poll(struct file *filp, poll_table * wait)
 	__poll_t p_res = 0;
 	struct sg_fd *sfp = filp->private_data;
 
+	if (test_bit(SG_FFD_POLLED_SEEN, sfp->ffd_bm))
+		sg_sfp_bio_poll(sfp, 0);	/* LLD may have some ready to push up */
 	num = atomic_read(&sfp->waiting);
 	if (num < 1) {
 		poll_wait(filp, &sfp->read_wait, wait);
@@ -2450,6 +2579,7 @@ sg_rq_end_io(struct request *rqq, blk_status_t status)
 		}
 	}
 	xa_lock_irqsave(&sfp->srp_arr, iflags);
+	__set_bit(SG_FRQ_ISSUED, srp->frq_bm);
 	sg_rq_chg_state_force_ulck(srp, rqq_state);
 	WRITE_ONCE(srp->rqq, NULL);
 	if (test_bit(SG_FRQ_COUNT_ACTIVE, srp->frq_bm)) {
@@ -2475,7 +2605,8 @@ sg_rq_end_io(struct request *rqq, blk_status_t status)
 
 	if (likely(rqq_state == SG_RS_AWAIT_RCV)) {
 		/* Wake any sg_read()/ioctl(SG_IORECEIVE) awaiting this req */
-		wake_up_interruptible(&sfp->read_wait);
+		if (!(srp->rq_flags & SGV4_FLAG_POLLED))
+			wake_up_interruptible(&sfp->read_wait);
 		kill_fasync(&sfp->async_qp, SIGPOLL, POLL_IN);
 		kref_put(&sfp->f_ref, sg_remove_sfp);
 	} else {        /* clean up orphaned request that aren't being kept */
@@ -2515,6 +2646,7 @@ sg_add_device_helper(struct scsi_device *scsidp)
 	sdp = kzalloc(sizeof(*sdp), GFP_KERNEL);
 	if (!sdp)
 		return ERR_PTR(-ENOMEM);
+	/* sdp->dummy_bdev starts as NULL until a POLLED command sent on this device */
 
 	idr_preload(GFP_KERNEL);
 	write_lock_irqsave(&sg_index_lock, iflags);
@@ -2620,6 +2752,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	write_lock_irqsave(&sg_index_lock, iflags);
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, iflags);
+	kfree(sdp->dummy_bdev);
 	kfree(sdp);
 
 out:
@@ -2648,6 +2781,7 @@ sg_device_destroy(struct kref *kref)
 	idr_remove(&sg_index_idr, sdp->index);
 	write_unlock_irqrestore(&sg_index_lock, flags);
 
+	kfree(sdp->dummy_bdev);
 	kfree(sdp);
 }
 
@@ -3009,6 +3143,25 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		blk_mq_free_request(rqq);
 	} else {
 		srp->bio = rqq->bio;
+		/* check if first POLLED command on this device */
+		if (unlikely((rq_flags & SGV4_FLAG_POLLED) && !READ_ONCE(sdp->dummy_bdev))) {
+			bool success = false;
+			unsigned long iflags;
+			struct xarray *xadp = &sdp->sfp_arr;
+			struct block_device *bdevp = kzalloc(sizeof(*bdevp), GFP_KERNEL);
+
+			xa_lock_irqsave(xadp, iflags);
+			if (bdevp && !sdp->dummy_bdev) {
+				bdevp->bd_queue = sdp->device->request_queue;
+				sdp->dummy_bdev = bdevp;
+				success = true;
+			}
+			xa_unlock_irqrestore(xadp, iflags);
+			if (!bdevp)
+				res = -ENOMEM;
+			if (!success)
+				kfree(bdevp);
+		}
 	}
 	SG_LOG((res ? 1 : 4), sfp, "%s: %s res=%d [0x%pK]\n", __func__, cp,
 	       res, srp);
@@ -3032,7 +3185,8 @@ sg_finish_scsi_blk_rq(struct sg_request *srp)
 	SG_LOG(4, sfp, "%s: srp=0x%pK%s\n", __func__, srp,
 	       (srp->parentfp->rsv_srp == srp) ? " rsv" : "");
 	if (test_and_clear_bit(SG_FRQ_COUNT_ACTIVE, srp->frq_bm)) {
-		atomic_dec(&sfp->submitted);
+		if (atomic_dec_and_test(&sfp->submitted))
+			clear_bit(SG_FFD_POLLED_SEEN, sfp->ffd_bm);
 		atomic_dec(&sfp->waiting);
 	}
 
@@ -3222,6 +3376,8 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 	struct sg_request *srp = NULL;
 	struct xarray *xafp = &sfp->srp_arr;
 
+	if (test_bit(SG_FFD_POLLED_SEEN, sfp->ffd_bm))
+		sg_sfp_bio_poll(sfp, 0);	/* LLD may have some ready to push up */
 	if (num_waiting < 1) {
 		num_waiting = atomic_read_acquire(&sfp->waiting);
 		if (num_waiting < 1)
@@ -4030,8 +4186,9 @@ sg_proc_debug_sreq(struct sg_request *srp, int to, char *obp, int len)
 	else if (dur < U32_MAX)	/* in-flight or busy (so ongoing) */
 		n += scnprintf(obp + n, len - n, " t_o/elap=%us/%ums",
 			       to / 1000, dur);
-	n += scnprintf(obp + n, len - n, " sgat=%d op=0x%02x\n",
-		       srp->sgat_h.num_sgat, srp->cmd_opcode);
+	cp = (srp->rq_flags & SGV4_FLAG_POLLED) ? "polled " : "";
+	n += scnprintf(obp + n, len - n, " sgat=%d %sop=0x%02x\n",
+		       srp->sgat_h.num_sgat, cp, srp->cmd_opcode);
 	return n;
 }
 
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 9060c40957f9..2e1e0cf5d686 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -109,6 +109,7 @@ typedef struct sg_io_hdr {
 #define SGV4_FLAG_Q_AT_TAIL SG_FLAG_Q_AT_TAIL
 #define SGV4_FLAG_Q_AT_HEAD SG_FLAG_Q_AT_HEAD
 #define SGV4_FLAG_IMMED 0x400 /* for polling with SG_IOR, ignored in SG_IOS */
+#define SGV4_FLAG_POLLED 0x800	/* request polls LLD for completion */
 
 /* Output (potentially OR-ed together) in v3::info or v4::info field */
 #define SG_INFO_OK_MASK 0x1
-- 
2.25.1

