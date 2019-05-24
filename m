Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC929E66
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391676AbfEXSsr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:47 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56451 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391360AbfEXSsq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D0F4820417E;
        Fri, 24 May 2019 20:48:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LHCcAIcuonUX; Fri, 24 May 2019 20:48:42 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id B2426204172;
        Fri, 24 May 2019 20:48:32 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 18/19] sg: add slave wait capability
Date:   Fri, 24 May 2019 14:48:08 -0400
Message-Id: <20190524184809.25121-19-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In request sharing, the slave side (i.e. the WRITEr) usually needs
to wait for the master side to complete before the slave can
issue its WRITE (or any other data-out command). This small
optimisation allows the slave WRITE to be submitted directly after
the master side submits its command (e.g. a READ).

Of course that slave command can't be executed until the data from
the master command becomes available. However the slave command
(i.e. its cdb) can be fetched and checked and the resources it
needs can be obtained. Also when the master side completes,
its callback can kick off the slave command prior to returning
to the user space with the response. No context switches
(between the user and kernel space) are saved, but the slave
request and the master response context switches are no longer
necessarily holding up IO.

See the webpage at: http://sg.danny.cz/sg/sg_v40.html
in the section titled: "7.1 Slave waiting"

This patch adds 120 lines and an extra state in the sg_request's
state machine. It may cost more than it is worth and so has been
added (almost) last.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 147 ++++++++++++++++++++++++++++++++++++++---
 include/uapi/scsi/sg.h |  24 ++++---
 2 files changed, 154 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 92a0226cabc2..d048c1f371ce 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -12,9 +12,9 @@
  *
  */
 
-static int sg_version_num = 40001;	/* 2 digits for each component */
-#define SG_VERSION_STR "4.0.01"
-static char *sg_version_date = "20190520";
+static int sg_version_num = 40012;	/* 2 digits for each component */
+#define SG_VERSION_STR "4.0.12"
+static char *sg_version_date = "20190521";
 
 #include <linux/module.h>
 
@@ -92,6 +92,7 @@ enum sg_rq_state {
 	SG_RS_BUSY,		/* temporary state should rarely be seen */
 	SG_RS_SHR_SWAP,		/* swap: master finished, awaiting slave */
 	SG_RS_SHR_SLAVE,	/* master waits while slave inflight */
+	SG_RS_SHR_SWAIT,	/* slave waiting for master to complete */
 };
 
 /* slave sets up sharing: ioctl(sl_fd,SG_SET_GET_EXTENDED(SHARE_FD(ma_fd))) */
@@ -132,6 +133,7 @@ enum sg_shr_var {
 #define SG_FRQ_DIO_IN_USE	3	/* false->indirect_IO,mmap; 1->dio */
 #define SG_FRQ_NO_US_XFER	4	/* no user space transfer of data */
 #define SG_FRQ_ABORTING		5	/* in process of aborting this cmd */
+#define SG_FRQ_DEFER_XFR	6	/* slave waiting will defer transfer */
 #define SG_FRQ_DEACT_ORPHAN	7	/* not keeping orphan so de-activate */
 #define SG_FRQ_MULTI_REQ	8	/* part of a multiple request series */
 #define SG_FRQ_BLK_PUT_REQ	9	/* set when blk_put_request() called */
@@ -1386,6 +1388,18 @@ sg_execute_cmd(struct sg_fd *sfp, struct sg_request *srp)
 	unsigned long iflags;
 	struct sg_device *sdp = sfp->parentdp;
 
+	if (unlikely(srp->sh_var == SG_SHR_SL_RQ && sfp->share_sfp)) {
+		if (test_and_clear_bit(SG_FRQ_DEFER_XFR, srp->frq_bm)) {
+			int res = sg_rq_map_kern(srp,
+						 sdp->device->request_queue,
+						 srp->rq);
+
+			SG_LOG(3, sdp, "%s: deferred xfer\n", __func__);
+			if (unlikely(res))
+				pr_warn("%s: sg_rq_map_kern() --> %d\n",
+					__func__, res);
+		}
+	}
 	is_v4h = test_bit(SG_FRQ_IS_V4I, srp->frq_bm);
 	sync = SG_IS_SYNC_INVOC(srp);
 	SG_LOG(3, sdp, "%s: is_v4h=%d\n", __func__, (int)is_v4h);
@@ -1438,6 +1452,56 @@ sg_rstate_chg(struct sg_request *srp, enum sg_rq_state old_st,
 	return -EPROTOTYPE;
 }
 
+/*
+ * Here when share slave request is being built and SG_FRQ_DEFER_XFR is set.
+ * Returns 0 for SWAIT (i.e. deferred execution), SZ_SG_IO_V4 (positive) for
+ * execute now, and negated errno value for error.
+ */
+static int
+sg_process_swait(struct sg_fd *sl_sfp, struct sg_request *sl_srp)
+{
+	int res = 0;
+	unsigned long iflags;
+	enum sg_rq_state ma_sr_st;
+	struct sg_fd *ma_sfp = sl_sfp->share_sfp;
+	struct sg_request *ma_rsv_srp;
+
+	if (!ma_sfp || !ma_sfp->rsv_srp)
+		return -EPROTO;
+	ma_rsv_srp = ma_sfp->rsv_srp;
+	spin_lock_irqsave(&ma_rsv_srp->req_lck, iflags);
+	ma_sr_st = atomic_read(&ma_rsv_srp->rq_st);
+	SG_LOG(3, sl_sfp->parentdp, "%s: ma_rsv_srp=0x%p, ma_sr_st: %s\n",
+	       __func__, ma_rsv_srp, sg_rq_st_str(ma_sr_st, false));
+
+	switch (ma_sr_st) {	/* master's state held constant by spinlock */
+	case SG_RS_INFLIGHT:
+		res = sg_rstate_chg(sl_srp, SG_RS_INFLIGHT, SG_RS_SHR_SWAIT);
+		goto fini;	/* if that worked res=0 and slave now SWAIT */
+	case SG_RS_AWAIT_RD:
+	case SG_RS_DONE_RD:
+	case SG_RS_SHR_SWAP:
+		res = (ma_rsv_srp->rq_result & SG_ML_RESULT_MSK) ?
+				-ENOSTR : SZ_SG_IO_V4;
+		break;
+	case SG_RS_BUSY:
+		res = -EBUSY;
+		break;
+	case SG_RS_INACTIVE:
+		res = -EAGAIN;
+		break;
+	case SG_RS_SHR_SLAVE:
+		res = -EDOM;
+		break;
+	default:
+		res = -EPROTO;
+		break;
+	}
+fini:
+	spin_unlock_irqrestore(&ma_rsv_srp->req_lck, iflags);
+	return res;
+}
+
 /*
  * All writes and submits converge on this function to launch the SCSI
  * command/request (via blk_execute_rq_nowait). Returns a pointer to a
@@ -1535,6 +1599,15 @@ sg_common_write(struct sg_comm_wr_t *cwrp)
 	}
 	srp->rq->timeout = cwrp->timeout;
 
+	if (sh_var == SG_SHR_SL_RQ &&
+	    test_bit(SG_FRQ_DEFER_XFR, srp->frq_bm)) {
+		res = sg_process_swait(fp, srp);
+		if (!res)
+			return srp;
+		else if (unlikely(res < 0))
+			goto err_out;
+		/* fallthrough when res is SZ_SG_IO_V4 to execute now */
+	}
 	sg_execute_cmd(fp, srp);
 	return srp;
 err_out:
@@ -2501,6 +2574,7 @@ sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
 		is_dur = true;	/* completion has occurred, timing finished */
 		break;
 	case SG_RS_INACTIVE:
+	case SG_RS_SHR_SWAIT:
 	default:
 		break;
 	}
@@ -2731,6 +2805,14 @@ sg_ctl_abort(struct sg_device *sdp, struct sg_fd *sfp, void __user *p)
 		if (srp->rq)
 			blk_abort_request(srp->rq);
 		break;
+	case SG_RS_SHR_SWAIT:
+		srp->rq_result |= (DRIVER_SOFT << 24);
+		if (sg_rstate_chg(srp, SG_RS_SHR_SWAIT, SG_RS_AWAIT_RD))
+			pr_warn("%s: unable to set rq_st?\n", __func__);
+		/* Wake any sg_read()/ioctl(SG_IORECEIVE) awaiting this req */
+		wake_up_interruptible(&sfp->read_wait);
+		kill_fasync(&sfp->async_qp, SIGPOLL, POLL_IN);
+		break;
 	default:
 		clear_bit(SG_FRQ_ABORTING, srp->frq_bm);
 		break;
@@ -3906,6 +3988,7 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 	struct sg_request *srp = container_of(work, struct sg_request,
 					      ew_orph.work);
 	struct sg_fd *sfp;
+	struct sg_request *slrp;
 
 	if (unlikely(!srp)) {
 		WARN_ONCE("%s: srp unexpectedly NULL\n", __func__);
@@ -3916,7 +3999,40 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 		WARN_ONCE(1, "%s: sfp unexpectedly NULL\n", __func__);
 		return;
 	}
-	SG_LOG(3, sfp->parentdp, "%s: srp=0x%p\n", __func__, srp);
+	slrp = sfp->slave_srp;
+	SG_LOG(3, sfp->parentdp, "%s: %s srp=0x%p, rq_st: %s, share: %s\n",
+	       __func__, (slrp ? "swait" : "clean"), srp,
+	       sg_rq_st_str(atomic_read(&srp->rq_st), false),
+	       sg_shr_str(srp->sh_var, false));
+	if (slrp) {
+		unsigned long iflags;
+		enum sg_rq_state rqq_st;
+		struct sg_fd *slave_sfp = slrp->parentfp;
+
+		spin_lock_irqsave(&slrp->req_lck, iflags);
+		rqq_st = atomic_read(&slrp->rq_st);
+		if (slave_sfp && rqq_st == SG_RS_SHR_SWAIT) {
+			if (!(srp->rq_result & SG_ML_RESULT_MSK)) {
+				/* master is error/sense free */
+				sg_rstate_chg(slrp, rqq_st, SG_RS_INFLIGHT);
+				spin_unlock_irqrestore(&slrp->req_lck, iflags);
+				sg_execute_cmd(slave_sfp, slrp);
+				goto chk_second;
+			}
+			/* end slave cmd with ::driver_status=DRIVER_SOFT */
+			sg_rstate_chg(slrp, rqq_st, SG_RS_AWAIT_RD);
+			spin_unlock_irqrestore(&slrp->req_lck, iflags);
+			slrp->rq_result |= (DRIVER_SOFT << 24);
+			if (slave_sfp) {
+				wake_up_interruptible(&slave_sfp->read_wait);
+				kill_fasync(&slave_sfp->async_qp, SIGPOLL,
+					    POLL_IN);
+			}
+		} else {
+			spin_unlock_irqrestore(&slrp->req_lck, iflags);
+		}
+	}
+chk_second:
 	if (test_bit(SG_FRQ_DEACT_ORPHAN, srp->frq_bm)) {
 		sg_finish_scsi_blk_rq(srp);	/* clean up orphan case */
 		sg_deact_request(sfp, srp);
@@ -4062,8 +4178,15 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 		/* Wake any sg_read()/ioctl(SG_IORECEIVE) awaiting this req */
 		wake_up_interruptible(&sfp->read_wait);
 		kill_fasync(&sfp->async_qp, SIGPOLL, POLL_IN);
-		kref_put(&sfp->f_ref, sg_remove_sfp);
-	} else {        /* clean up orphaned request that aren't being kept */
+		if (sfp->slave_srp &&	/* schedule waiting slave rq */
+		    atomic_read(&sfp->slave_srp->rq_st) == SG_RS_SHR_SWAIT) {
+			INIT_WORK(&srp->ew_orph.work,
+				  sg_rq_end_io_usercontext);
+			schedule_work(&srp->ew_orph.work);
+		} else {
+			kref_put(&sfp->f_ref, sg_remove_sfp);
+		}
+	} else {	/* clean up orphaned request that aren't being kept */
 		INIT_WORK(&srp->ew_orph.work, sg_rq_end_io_usercontext);
 		schedule_work(&srp->ew_orph.work);
 	}
@@ -4573,7 +4696,7 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		if (IS_ENABLED(CONFIG_SCSI_PROC_FS) && res)
 			SG_LOG(1, sdp, "%s: blk_rq_map_user() res=%d\n",
 			       __func__, res);
-	} else {
+	} else if (!test_bit(SG_FRQ_DEFER_XFR, srp->frq_bm)) {
 		/* transfer data to/from kernel buffers */
 		res = sg_rq_map_kern(srp, q, rq);
 	}
@@ -4840,6 +4963,7 @@ sg_find_srp_by_id(struct sg_fd *sfp, int id, bool is_tag)
 			case SG_RS_SHR_SLAVE:
 				goto good;
 			case SG_RS_INFLIGHT:
+			case SG_RS_SHR_SWAIT:	/* awaiting master's finish */
 				break;
 			default:
 				if (IS_ENABLED(CONFIG_SCSI_PROC_FS)) {
@@ -5040,17 +5164,18 @@ sg_add_request(struct sg_comm_wr_t *cwrp, enum sg_shr_var sh_var, int dxfr_len)
 	bool allow_rsv = true;
 	bool mk_new_srp = true;
 	bool sl_req = false;
+	bool sl_swait = false;
 	u32 sum_dlen;
 	unsigned long iflags;
 	enum sg_rq_state sr_st;
-	enum sg_rq_state ma_sr_st;
+	enum sg_rq_state uninitialized_var(ma_sr_st);
 	struct sg_fd *fp = cwrp->sfp;
 	struct sg_request *r_srp = NULL;	/* request to return */
 	struct sg_request *rsv_srp;	/* current fd's reserve request */
 	struct sg_request *uninitialized_var(ma_rsv_srp);
 	struct sg_fd *uninitialized_var(ma_sfp);
 	__maybe_unused struct sg_device *sdp;
-	__maybe_unused const char *cp;
+	__maybe_unused const char *uninitialized_var(cp);
 	char b[48];
 
 	spin_lock_irqsave(&fp->rq_list_lock, iflags);
@@ -5110,6 +5235,7 @@ sg_add_request(struct sg_comm_wr_t *cwrp, enum sg_shr_var sh_var, int dxfr_len)
 			break;
 		case  SG_RS_INFLIGHT:
 			sl_req = true;
+			sl_swait = true;
 			break;
 		case SG_RS_INACTIVE:
 			r_srp = ERR_PTR(-EADDRNOTAVAIL);
@@ -5231,6 +5357,7 @@ sg_add_request(struct sg_comm_wr_t *cwrp, enum sg_shr_var sh_var, int dxfr_len)
 		ma_sfp->slave_srp = r_srp;
 		/* slave "shares" the master reserve request's data buffer */
 		r_srp->sgatp = &ma_rsv_srp->sgat_h;
+		assign_bit(SG_FRQ_DEFER_XFR, r_srp->frq_bm, sl_swait);
 	}
 	if (mk_new_srp)
 		spin_lock_irqsave(&fp->rq_list_lock, iflags);
@@ -5530,6 +5657,8 @@ sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 		return long_str ? "share swap" : "s_wp";
 	case SG_RS_SHR_SLAVE:	/* only an active master has this */
 		return long_str ? "share slave active" : "sl_a";
+	case SG_RS_SHR_SWAIT:	/* only an active slave has this */
+		return long_str ? "share slave wait" : "sl_w";
 	default:
 		return long_str ? "unknown" : "unk";
 	}
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index b299e7d1b51d..348918f9e0b0 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -14,7 +14,7 @@
  * Later extensions (versions 2, 3 and 4) to driver:
  *   Copyright (C) 1998 - 2018 Douglas Gilbert
  *
- * Version 4.0.11 (20190502)
+ * Version 4.0.12 (20190521)
  *  This version is for Linux 4 and 5 series kernels.
  *
  * Documentation
@@ -115,7 +115,7 @@ typedef struct sg_io_hdr {
 #define SGV4_FLAG_Q_AT_HEAD SG_FLAG_Q_AT_HEAD
 #define SGV4_FLAG_COMPLETE_B4  0x100
 #define SGV4_FLAG_SIG_ON_OTHER  0x200
-#define SGV4_FLAG_IMMED 0x400 /* for polling with SG_IOR, ignored in SG_IOS */
+#define SGV4_FLAG_IMMED 0x400	/* for polling with SG_IOR, ignored in SG_IOS */
 #define SGV4_FLAG_STOP_IF 0x800	/* Stops sync mrq if error or warning */
 #define SGV4_FLAG_DEV_SCOPE 0x1000 /* permit SG_IOABORT to have wider scope */
 #define SGV4_FLAG_SHARE 0x2000	/* share IO buffer; needs SG_SEIM_SHARE_FD */
@@ -149,7 +149,7 @@ typedef struct sg_scsi_id {
 	short h_cmd_per_lun;/* host (adapter) maximum commands per lun */
 	short d_queue_depth;/* device (or adapter) maximum queue length */
 	union {
-		int unused[2];  /* as per version 3 driver */
+		int unused[2];	/* as per version 3 driver */
 		__u8 scsi_lun[8];  /* full 8 byte SCSI LUN [in v4 driver] */
 	};
 } sg_scsi_id_t;
@@ -161,8 +161,14 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 	/* sg_io_owned set imples synchronous, clear implies asynchronous */
 	char sg_io_owned;/* 0 -> complete with read(), 1 -> owned by SG_IO */
 	char problem;	/* 0 -> no problem detected, 1 -> error to report */
+	/* If SG_CTL_FLAGM_TAG_FOR_PACK_ID set on fd then next field is tag */
 	int pack_id;	/* pack_id, in v4 driver may be tag instead */
 	void __user *usr_ptr;	/* user provided pointer in v3+v4 interface */
+	/*
+	 * millisecs elapsed since the command started (req_state==1) or
+	 * command duration (req_state==2). Will be in nanoseconds after
+	 * the SG_SET_GET_EXTENDED{TIME_IN_NS} ioctl.
+	 */
 	unsigned int duration;
 	int unused;
 } sg_req_info_t;
@@ -198,9 +204,9 @@ typedef struct sg_req_info {	/* used by SG_GET_REQUEST_TABLE ioctl() */
 #define SG_CTL_FLAGM_UNSHARE	0x80	/* undo share after inflight cmd */
 /* rd> 1: master finished 0: not; wr> 1: finish share post master */
 #define SG_CTL_FLAGM_MASTER_FINI 0x100	/* wr> 0: setup for repeat slave req */
-#define SG_CTL_FLAGM_MASTER_ERR 0x200	/* rd: sharing, master got error */
+#define SG_CTL_FLAGM_MASTER_ERR	0x200	/* rd: sharing, master got error */
 #define SG_CTL_FLAGM_NO_DURATION 0x400	/* don't calc command duration */
-#define SG_CTL_FLAGM_MORE_ASYNC	0x800	/* yield EAGAIN in more cases */
+#define SG_CTL_FLAGM_MORE_ASYNC 0x800	/* yield EAGAIN in more cases */
 #define SG_CTL_FLAGM_ALL_BITS	0xfff	/* should be OR of previous items */
 
 /* Write one of the following values to sg_extended_info::read_value, get... */
@@ -433,9 +439,11 @@ struct sg_header {
 /*
  * New ioctls to replace async (non-blocking) write()/read() interface.
  * Present in version 4 and later of the sg driver [>20190427]. The
- * SG_IOSUBMIT and SG_IORECEIVE ioctls accept the sg_v4 interface based on
- * struct sg_io_v4 found in <include/uapi/linux/bsg.h>. These objects are
- * passed by a pointer in the third argument of the ioctl.
+ * SG_IOSUBMIT_V3 and SG_IORECEIVE_V3 ioctls accept the sg_v3 interface
+ * based on struct sg_io_hdr shown above. The SG_IOSUBMIT and SG_IORECEIVE
+ * ioctls accept the sg_v4 interface based on struct sg_io_v4 found in
+ * <include/uapi/linux/bsg.h>. These objects are passed by a pointer in
+ * the third argument of the ioctl.
  *
  * Data may be transferred both from the user space to the driver by these
  * ioctls. Hence the _IOWR macro is used here to generate the ioctl number
-- 
2.17.1

