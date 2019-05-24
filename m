Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4793029E60
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbfEXSsg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:36 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56391 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbfEXSsf (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7C5EB204170;
        Fri, 24 May 2019 20:48:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nNsfDYeV1Kai; Fri, 24 May 2019 20:48:28 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 27BE4204172;
        Fri, 24 May 2019 20:48:22 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 09/19] sg: expand sg_comm_wr_t
Date:   Fri, 24 May 2019 14:47:59 -0400
Message-Id: <20190524184809.25121-10-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The internal struct sg_comm_wr_t was added when the number of
arguments to sg_common_write() became excessive. Expand this idea
so multiple calls to sg_fetch_cmnd() can be deferred until a
scsi_request object is ready to receive the command. This saves
a 252 byte stack allocation on every submit path. Prior to this
and a few other changes, the kernel infrastructure was warning
about excessive stack usage.

Also make open_cnt (count of active open()s on this device) an
atomic. Add more unlikely() and likely() hints on conditionals

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 348 ++++++++++++++++++++++++----------------------
 1 file changed, 183 insertions(+), 165 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 454abfdd4f74..638368ed9e11 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -244,7 +244,7 @@ struct sg_device {	/* holds the state of each scsi generic device */
 	atomic_t detaching;	/* 0->device usable, 1->device detaching */
 	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
 	u8 sgdebug;	/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
-	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
+	atomic_t open_cnt;	/* count of opens (perhaps < num(sfds) ) */
 	struct gendisk *disk;
 	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
 	struct kref d_ref;
@@ -252,36 +252,39 @@ struct sg_device {	/* holds the state of each scsi generic device */
 
 struct sg_comm_wr_t {	/* arguments to sg_common_write() */
 	int timeout;
+	int cmd_len;
 	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
 	union {		/* selector is frq_bm.SG_FRQ_IS_V4I */
 		struct sg_io_hdr *h3p;
 		struct sg_io_v4 *h4p;
 	};
-	u8 *cmnd;
+	struct sg_fd *sfp;
+	struct file *filp;
+	const u8 __user *u_cmdp;
+	const u8 *cmdp;
 };
 
 /* tasklet or soft irq callback */
 static void sg_rq_end_io(struct request *rq, blk_status_t status);
 /* Declarations of other static functions used before they are defined */
 static int sg_proc_init(void);
-static int sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
-			struct sg_io_v4 *h4p, int dxfer_dir);
+static int sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp,
+			int dxfer_dir);
 // static int sg_finish_rem_req(struct sg_request *srp);
 static void sg_finish_scsi_blk_rq(struct sg_request *srp);
 static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
 static int sg_v3_submit(struct file *filp, struct sg_fd *sfp,
 			struct sg_io_hdr *hp, bool sync,
 			struct sg_request **o_srp);
-static struct sg_request *sg_common_write(struct sg_fd *sfp,
-					  struct sg_comm_wr_t *cwp);
+static struct sg_request *sg_common_write(struct sg_comm_wr_t *cwp);
 static int sg_rd_append(struct sg_request *srp, void __user *outp,
 			int num_xfer);
 static void sg_remove_sgat(struct sg_request *srp);
 static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
 static void sg_remove_sfp(struct kref *);
 static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int id);
-static struct sg_request *sg_add_request(struct sg_fd *sfp, int dxfr_len,
-					 struct sg_comm_wr_t *cwrp);
+static struct sg_request *sg_add_request(struct sg_comm_wr_t *cwrp,
+					 int dxfr_len);
 static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
 static struct sg_device *sg_get_dev(int min_dev);
 static void sg_device_destroy(struct kref *kref);
@@ -322,7 +325,7 @@ static void sg_rep_rq_state_fail(struct sg_device *sdp,
 		char _b[160];						\
 		int _tid = (current ? current->pid : -1);		\
 									\
-		if ((sdp) && (sdp)->disk) {				\
+		if (likely((sdp) && (sdp)->disk)) {			\
 			snprintf(_b, sizeof(_b), "%s: tid=%d",		\
 				 (sdp)->disk->disk_name, _tid);		\
 			SCSI_LOG_TIMEOUT(depth,				\
@@ -372,37 +375,38 @@ static int
 sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 	__must_hold(&sdp->open_rel_lock)
 {
-	int retval = 0;
+	int res = 0;
 
 	if (unlikely(o_excl)) {
-		while (sdp->open_cnt > 0) {
+		while (atomic_read(&sdp->open_cnt) > 0) {
 			mutex_unlock(&sdp->open_rel_lock);
-			retval = wait_event_interruptible(sdp->open_wait,
-				    (unlikely(atomic_read(&sdp->detaching)) ||
-				    !sdp->open_cnt));
+			res = wait_event_interruptible
+				(sdp->open_wait,
+				 (unlikely(atomic_read(&sdp->detaching)) ||
+				 !atomic_read(&sdp->open_cnt)));
 			mutex_lock(&sdp->open_rel_lock);
 
-			if (retval) /* -ERESTARTSYS */
-				return retval;
+			if (unlikely(res)) /* -ERESTARTSYS */
+				return res;
 			if (unlikely(atomic_read(&sdp->detaching)))
 				return -ENODEV;
 		}
 	} else {
 		while (unlikely(sdp->exclude)) {
 			mutex_unlock(&sdp->open_rel_lock);
-			retval = wait_event_interruptible(sdp->open_wait,
-				    unlikely((atomic_read(&sdp->detaching)) ||
-					     !sdp->exclude));
+			res = wait_event_interruptible
+				(sdp->open_wait,
+				 unlikely((atomic_read(&sdp->detaching)) ||
+					  !sdp->exclude));
 			mutex_lock(&sdp->open_rel_lock);
 
-			if (retval) /* -ERESTARTSYS */
-				return retval;
+			if (unlikely(res)) /* -ERESTARTSYS */
+				return res;
 			if (unlikely(atomic_read(&sdp->detaching)))
 				return -ENODEV;
 		}
 	}
-
-	return retval;
+	return res;
 }
 
 /*
@@ -415,7 +419,7 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 static inline int
 sg_allow_if_err_recovery(struct sg_device *sdp, bool non_block)
 {
-	if (!sdp)
+	if (unlikely(!sdp))
 		return -EPROTO;
 	if (non_block)
 		return 0;
@@ -439,7 +443,7 @@ sg_open(struct inode *inode, struct file *filp)
 	int op_flags = filp->f_flags;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
-	int retval;
+	int res;
 
 	nonseekable_open(inode, filp);
 	o_excl = !!(op_flags & O_EXCL);
@@ -450,69 +454,70 @@ sg_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(sdp))
 		return PTR_ERR(sdp);
 	SG_LOG(3, sdp, "%s: minor=%d, op_flags=0x%x; %s count prior=%d%s\n",
-	       __func__, min_dev, op_flags, "device open", sdp->open_cnt,
-	       (non_block ? " O_NONBLOCK" : ""));
+	       __func__, min_dev, op_flags, "device open",
+	       atomic_read(&sdp->open_cnt), (non_block ? " O_NONBLOCK" : ""));
 
 	/* This driver's module count bumped by fops_get in <linux/fs.h> */
 	/* Prevent the device driver from vanishing while we sleep */
-	retval = scsi_device_get(sdp->device);
-	if (retval)
+	res = scsi_device_get(sdp->device);
+	if (unlikely(res))
 		goto sg_put;
 
-	retval = scsi_autopm_get_device(sdp->device);
-	if (retval)
+	res = scsi_autopm_get_device(sdp->device);
+	if (unlikely(res))
 		goto sdp_put;
 
-	retval = sg_allow_if_err_recovery(sdp, non_block);
-	if (retval)
+	res = sg_allow_if_err_recovery(sdp, non_block);
+	if (unlikely(res))
 		goto error_out;
 
 	mutex_lock(&sdp->open_rel_lock);
 	if (op_flags & O_NONBLOCK) {
-		if (o_excl) {
-			if (sdp->open_cnt > 0) {
-				retval = -EBUSY;
+		if (unlikely(o_excl)) {
+			if (atomic_read(&sdp->open_cnt) > 0) {
+				res = -EBUSY;
 				goto error_mutex_locked;
 			}
 		} else {
-			if (sdp->exclude) {
-				retval = -EBUSY;
+			if (unlikely(sdp->exclude)) {
+				res = -EBUSY;
 				goto error_mutex_locked;
 			}
 		}
 	} else {
-		retval = sg_wait_open_event(sdp, o_excl);
-		if (retval) /* -ERESTARTSYS or -ENODEV */
+		res = sg_wait_open_event(sdp, o_excl);
+		if (unlikely(res)) /* -ERESTARTSYS or -ENODEV */
 			goto error_mutex_locked;
 	}
 
 	/* N.B. at this point we are holding the open_rel_lock */
-	if (o_excl)
+	if (unlikely(o_excl))
 		sdp->exclude = true;
 
-	if (sdp->open_cnt < 1) {  /* no existing opens */
+	if (atomic_read(&sdp->open_cnt) < 1) {  /* no existing opens */
 		sdp->sgdebug = 0;
 		/* Next done in sg_alloc(), repeat here to pick up change? */
 		sg_calc_sgat_param(sdp);
 	}
 	sfp = sg_add_sfp(sdp);
 	if (IS_ERR(sfp)) {
-		retval = PTR_ERR(sfp);
+		res = PTR_ERR(sfp);
 		goto out_undo;
 	}
 
 	filp->private_data = sfp;
 	sfp->tid = (current ? current->pid : -1);
-	sdp->open_cnt++;
+	sfp->tid = (current ? current->pid : -1);
+	atomic_inc(&sdp->open_cnt);
 	mutex_unlock(&sdp->open_rel_lock);
 
-	retval = 0;
+	res = 0;
 sg_put:
 	kref_put(&sdp->d_ref, sg_device_destroy);
-	return retval;
+	return res;
 
 out_undo:
-	if (o_excl) {
+	if (unlikely(o_excl)) {
 		sdp->exclude = false;   /* undo if error */
 		wake_up_interruptible(&sdp->open_wait);
 	}
@@ -541,21 +546,21 @@ sg_release(struct inode *inode, struct file *filp)
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
 	SG_LOG(3, sdp, "%s: device open count prior=%d\n", __func__,
-	       sdp->open_cnt);
-	if (!sdp)
+	       atomic_read(&sdp->open_cnt));
+	if (unlikely(!sdp))
 		return -ENXIO;
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
 	kref_put(&sfp->f_ref, sg_remove_sfp);
-	sdp->open_cnt--;
+	atomic_dec(&sdp->open_cnt);
 
 	/* possibly many open()s waiting on exlude clearing, start many;
 	 * only open(O_EXCL)s wait on 0==open_cnt so only start one */
-	if (sdp->exclude) {
+	if (unlikely(sdp->exclude)) {
 		sdp->exclude = false;
 		wake_up_interruptible_all(&sdp->open_wait);
-	} else if (0 == sdp->open_cnt) {
+	} else if (atomic_read(&sdp->open_cnt) == 0) {
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
@@ -577,7 +582,6 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	struct sg_request *srp;
-	u8 cmnd[SG_MAX_CDB_SIZE];
 	struct sg_header ov2hdr;
 	struct sg_io_hdr v3hdr;
 	struct sg_header *ohp = &ov2hdr;
@@ -585,14 +589,14 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	struct sg_comm_wr_t cwr;
 
 	res = sg_check_file_access(filp, __func__);
-	if (res)
+	if (unlikely(res))
 		return res;
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
 	SG_LOG(3, sdp, "%s: write(3rd arg) count=%d\n", __func__, (int)count);
 	res = sg_allow_if_err_recovery(sdp, !!(filp->f_flags & O_NONBLOCK));
-	if (res)
+	if (unlikely(res))
 		return res;
 	if (unlikely(atomic_read(&sdp->detaching)))
 		return -ENODEV;
@@ -664,9 +668,6 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 	h3p->flags = input_size;         /* structure abuse ... */
 	h3p->pack_id = ohp->pack_id;
 	h3p->usr_ptr = NULL;
-	cmnd[0] = opcode;
-	if (__copy_from_user(cmnd + 1, p + 1, cmd_size - 1))
-		return -EFAULT;
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
 	 * but it is possible that the app intended SG_DXFER_TO_DEV, because
@@ -677,13 +678,17 @@ sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 			"%s: data in/out %d/%d bytes for SCSI command 0x%x-- guessing data in;\n"
 			"   program %s not setting count and/or reply_len properly\n",
 			__func__, ohp->reply_len - (int)SZ_SG_HEADER,
-			input_size, (unsigned int)cmnd[0], current->comm);
+			input_size, (unsigned int)opcode, current->comm);
 	}
 	cwr.frq_bm[0] = 0;	/* initial state clear for all req flags */
 	cwr.h3p = h3p;
 	cwr.timeout = sfp->timeout;
-	cwr.cmnd = cmnd;
-	srp = sg_common_write(sfp, &cwr);
+	cwr.cmd_len = cmd_size;
+	cwr.filp = filp;
+	cwr.sfp = sfp;
+	cwr.u_cmdp = p;
+	cwr.cmdp = NULL;
+	srp = sg_common_write(&cwr);
 	return (IS_ERR(srp)) ? PTR_ERR(srp) : (int)count;
 }
 
@@ -712,11 +717,9 @@ static int
 sg_v3_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
 	     bool sync, struct sg_request **o_srp)
 {
-	int res, timeout;
 	unsigned long ul_timeout;
 	struct sg_request *srp;
 	struct sg_comm_wr_t cwr;
-	u8 cmnd[SG_MAX_CDB_SIZE];
 
 	/* now doing v3 blocking (sync) or non-blocking submission */
 	if (hp->flags & SG_FLAG_MMAP_IO) {
@@ -730,16 +733,16 @@ sg_v3_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
 	/* when v3 seen, allow cmd_q on this fd (def: no cmd_q) */
 	set_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
 	ul_timeout = msecs_to_jiffies(hp->timeout);
-	timeout = min_t(unsigned long, ul_timeout, INT_MAX);
-	res = sg_fetch_cmnd(filp, sfp, hp->cmdp, hp->cmd_len, cmnd);
-	if (res)
-		return res;
 	cwr.frq_bm[0] = 0;
 	assign_bit(SG_FRQ_SYNC_INVOC, cwr.frq_bm, (int)sync);
 	cwr.h3p = hp;
-	cwr.timeout = timeout;
-	cwr.cmnd = cmnd;
-	srp = sg_common_write(sfp, &cwr);
+	cwr.timeout = min_t(unsigned long, ul_timeout, INT_MAX);
+	cwr.cmd_len = hp->cmd_len;
+	cwr.filp = filp;
+	cwr.sfp = sfp;
+	cwr.u_cmdp = hp->cmdp;
+	cwr.cmdp = NULL;
+	srp = sg_common_write(&cwr);
 	if (IS_ERR(srp))
 		return PTR_ERR(srp);
 	if (o_srp)
@@ -751,12 +754,15 @@ static int
 sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
 	     struct sg_io_v4 *h4p, bool sync, struct sg_request **o_srp)
 {
-	int timeout, res;
+	int res = 0;
 	unsigned long ul_timeout;
 	struct sg_request *srp;
 	struct sg_comm_wr_t cwr;
-	u8 cmnd[SG_MAX_CDB_SIZE];
 
+	memset(&cwr, 0, sizeof(cwr));
+	cwr.filp = filp;
+	cwr.sfp = sfp;
+	cwr.h4p = h4p;
 	if (h4p->flags & SG_FLAG_MMAP_IO) {
 		int len = 0;
 
@@ -774,18 +780,15 @@ sg_v4_submit(struct file *filp, struct sg_fd *sfp, void __user *p,
 	/* once v4 (or v3) seen, allow cmd_q on this fd (def: no cmd_q) */
 	set_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
 	ul_timeout = msecs_to_jiffies(h4p->timeout);
-	timeout = min_t(unsigned long, ul_timeout, INT_MAX);
-	res = sg_fetch_cmnd(filp, sfp, cuptr64(h4p->request), h4p->request_len,
-			    cmnd);
-	if (res)
-		return res;
 	cwr.frq_bm[0] = 0;
 	assign_bit(SG_FRQ_SYNC_INVOC, cwr.frq_bm, (int)sync);
 	set_bit(SG_FRQ_IS_V4I, cwr.frq_bm);
 	cwr.h4p = h4p;
-	cwr.timeout = timeout;
-	cwr.cmnd = cmnd;
-	srp = sg_common_write(sfp, &cwr);
+	cwr.timeout = min_t(unsigned long, ul_timeout, INT_MAX);
+	cwr.cmd_len = h4p->request_len;
+	cwr.u_cmdp = cuptr64(h4p->request);
+	cwr.cmdp = NULL;
+	srp = sg_common_write(&cwr);
 	if (IS_ERR(srp))
 		return PTR_ERR(srp);
 	if (o_srp)
@@ -802,7 +805,7 @@ sg_ctl_iosubmit(struct file *filp, struct sg_fd *sfp, void __user *p)
 	struct sg_device *sdp = sfp->parentdp;
 
 	res = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NONBLOCK));
-	if (res)
+	if (unlikely(res))
 		return res;
 	if (copy_from_user(hdr_store, p, SZ_SG_IO_V4))
 		return -EFAULT;
@@ -863,13 +866,14 @@ sg_rstate_chg(struct sg_request *srp, enum sg_rq_state old_st,
  * N.B. pack_id placed in sg_io_v4::request_extra field.
  */
 static struct sg_request *
-sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
+sg_common_write(struct sg_comm_wr_t *cwrp)
 {
 	int res = 0;
-	int dxfr_len, dir, cmd_len;
+	int dxfr_len, dir;
 	int pack_id = SG_PACK_ID_WILDCARD;
 	u32 rq_flags;
-	struct sg_device *sdp = sfp->parentdp;
+	struct sg_fd *fp = cwrp->sfp;
+	struct sg_device *sdp = fp->parentdp;
 	struct sg_request *srp;
 	struct sg_io_hdr *hi_p;
 	struct sg_io_v4 *h4p;
@@ -901,7 +905,7 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	if (dxfr_len >= SZ_256M)
 		return ERR_PTR(-EINVAL);
 
-	srp = sg_add_request(sfp, dxfr_len, cwrp);
+	srp = sg_add_request(cwrp, dxfr_len);
 	if (IS_ERR(srp))
 		return srp;
 	srp->rq_flags = rq_flags;
@@ -914,18 +918,16 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 		srp->s_hdr4.max_sb_len = h4p->max_response_len;
 		srp->s_hdr4.cmd_len = h4p->request_len;
 		srp->s_hdr4.dir = dir;
-		cmd_len = h4p->request_len;
 	} else {	/* v3 interface active */
-		cmd_len = hi_p->cmd_len;
 		memcpy(&srp->s_hdr3, hi_p, sizeof(srp->s_hdr3));
 	}
-	srp->cmd_opcode = cwrp->cmnd[0];/* hold opcode of command for debug */
-	SG_LOG(4, sdp, "%s: opcode=0x%02x, cdb_sz=%d, pack_id=%d\n", __func__,
-	       (int)cwrp->cmnd[0], cmd_len, pack_id);
 
-	res = sg_start_req(srp, cwrp->cmnd, cmd_len, h4p, dir);
-	if (res < 0)		/* probably out of space --> -ENOMEM */
+	res = sg_start_req(srp, cwrp, dir);
+	if (unlikely(res < 0))	/* probably out of space --> -ENOMEM */
 		goto err_out;
+	SG_LOG(4, sdp, "%s: opcode=0x%02x, cdb_sz=%d, pack_id=%d\n", __func__,
+	       srp->cmd_opcode, cwrp->cmd_len, pack_id);
+
 	if (unlikely(atomic_read(&sdp->detaching))) {
 		res = -ENODEV;
 		goto err_out;
@@ -936,11 +938,11 @@ sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 	}
 	srp->rq->timeout = cwrp->timeout;
 
-	sg_execute_cmd(sfp, srp);
+	sg_execute_cmd(fp, srp);
 	return srp;
 err_out:
 	sg_finish_scsi_blk_rq(srp);
-	sg_deact_request(sfp, srp);
+	sg_deact_request(fp, srp);
 	return ERR_PTR(res);
 }
 
@@ -1155,7 +1157,7 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 	struct sg_request *srp;
 
 	res = sg_allow_if_err_recovery(sdp, non_block);
-	if (res)
+	if (unlikely(res))
 		return res;
 	/* Get first three 32 bit integers: guard, proto+subproto */
 	if (copy_from_user(h4p, p, SZ_SG_IO_V4))
@@ -1179,8 +1181,8 @@ sg_ctl_ioreceive(struct file *filp, struct sg_fd *sfp, void __user *p)
 								id));
 		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
-		if (res)	/* -ERESTARTSYS as signal hit process */
-			return res;
+		if (unlikely(res))
+			return res;	/* signal --> -ERESTARTSYS */
 	}	/* now srp should be valid */
 	return sg_v4_receive(sfp, srp, p, h4p);
 }
@@ -1531,7 +1533,7 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	SG_LOG(3, sdp, "%s:  SG_IO%s\n", __func__,
 	       ((filp->f_flags & O_NONBLOCK) ? " O_NONBLOCK ignored" : ""));
 	res = sg_allow_if_err_recovery(sdp, false);
-	if (res)
+	if (unlikely(res))
 		return res;
 	if (atomic_read(&sdp->detaching))
 		return -ENODEV;
@@ -1556,7 +1558,7 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
 	if (!srp)	/* mrq case: already processed all responses */
 		return res;
 	res = sg_wait_event_srp(filp, sfp, p, h4p, srp);
-	if (res) {
+	if (unlikely(res)) {
 		SG_LOG(1, sdp, "%s: %s=0x%p  state: %s\n", __func__,
 		       "unexpected srp", srp,
 		       sg_rq_st_str(atomic_read(&srp->rq_st), false));
@@ -1605,7 +1607,7 @@ sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
 	/* new sg_request object, sized correctly is now available */
 	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
 	o_srp = sfp->rsv_srp;
-	if (!o_srp) {
+	if (unlikely(!o_srp)) {
 		res = -EPROTO;
 		goto wr_unlock;
 	}
@@ -1736,7 +1738,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	sdp = sfp->parentdp;
 	SG_LOG(6, sdp, "%s: cmd=0x%x, O_NONBLOCK=%d\n", __func__, cmd_in,
 	       !!(filp->f_flags & O_NONBLOCK));
-	if (!sdp)
+	if (unlikely(!sdp))
 		return -ENXIO;
 	if (unlikely(atomic_read(&sdp->detaching)))
 		return -ENODEV;
@@ -1756,7 +1758,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_SET_FORCE_PACK_ID:
 		SG_LOG(3, sdp, "%s:    SG_SET_FORCE_PACK_ID\n", __func__);
 		result = get_user(val, ip);
-		if (result)
+		if (unlikely(result))
 			return result;
 		assign_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm, !!val);
 		return 0;
@@ -1786,7 +1788,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_SET_RESERVED_SIZE:
 		mutex_lock(&sfp->f_mutex);
 		result = get_user(val, ip);
-		if (!result) {
+		if (likely(!result)) {
 			if (val >= 0 && val <= (1024 * 1024 * 1024)) {
 				result = sg_set_reserved_sz(sfp, val);
 			} else {
@@ -1808,7 +1810,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_SET_COMMAND_Q:
 		SG_LOG(3, sdp, "%s:    SG_SET_COMMAND_Q\n", __func__);
 		result = get_user(val, ip);
-		if (result)
+		if (unlikely(result))
 			return result;
 		assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, !!val);
 		return 0;
@@ -1818,7 +1820,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_SET_KEEP_ORPHAN:
 		SG_LOG(3, sdp, "%s:    SG_SET_KEEP_ORPHAN\n", __func__);
 		result = get_user(val, ip);
-		if (result)
+		if (unlikely(result))
 			return result;
 		assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, !!val);
 		return 0;
@@ -1838,7 +1840,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_SET_TIMEOUT:
 		SG_LOG(3, sdp, "%s:    SG_SET_TIMEOUT\n", __func__);
 		result = get_user(val, ip);
-		if (result)
+		if (unlikely(result))
 			return result;
 		if (val < 0)
 			return -EIO;
@@ -1866,7 +1868,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_NEXT_CMD_LEN:   /* active only in v2 interface */
 		SG_LOG(3, sdp, "%s:    SG_NEXT_CMD_LEN\n", __func__);
 		result = get_user(val, ip);
-		if (result)
+		if (unlikely(result))
 			return result;
 		if (val > SG_MAX_CDB_SIZE)
 			return -ENOMEM;
@@ -1893,7 +1895,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 	case SG_SET_DEBUG:
 		SG_LOG(3, sdp, "%s:    SG_SET_DEBUG\n", __func__);
 		result = get_user(val, ip);
-		if (result)
+		if (unlikely(result))
 			return result;
 		sdp->sgdebug = (u8)val;
 		return 0;
@@ -1951,7 +1953,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 			return -ENODEV;
 	}
 	result = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NDELAY));
-	if (result)
+	if (unlikely(result))
 		return result;
 	/* ioctl that reach here are forwarded to the mid-level */
 	return scsi_ioctl(sdev, cmd_in, p);
@@ -1967,7 +1969,7 @@ sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
-	if (!sdp)
+	if (unlikely(!sdp))
 		return -ENXIO;
 
 	sdev = sdp->device;
@@ -1996,7 +1998,7 @@ sg_poll(struct file *filp, poll_table * wait)
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
-	if (!sdp)
+	if (unlikely(!sdp))
 		return EPOLLERR;
 	poll_wait(filp, &sfp->read_wait, wait);
 	if (atomic_read(&sfp->waiting) > 0)
@@ -2022,7 +2024,7 @@ sg_fasync(int fd, struct file *filp, int mode)
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
 	SG_LOG(3, sdp, "%s: mode(%s)\n", __func__, (mode ? "add" : "remove"));
-	if (!sdp)
+	if (unlikely(!sdp))
 		return -ENXIO;
 	return fasync_helper(fd, filp, mode, &sfp->async_qp);
 }
@@ -2040,12 +2042,12 @@ sg_vma_fault(struct vm_fault *vmf)
 	struct sg_fd *sfp;
 	const char *nbp = "==NULL, bad";
 
-	if (!vma) {
+	if (unlikely(!vma)) {
 		pr_warn("%s: vma%s\n", __func__, nbp);
 		goto out_err;
 	}
 	sfp = vma->vm_private_data;
-	if (!sfp) {
+	if (unlikely(!sfp)) {
 		pr_warn("%s: sfp%s\n", __func__, nbp);
 		goto out_err;
 	}
@@ -2055,14 +2057,14 @@ sg_vma_fault(struct vm_fault *vmf)
 		goto out_err;
 	}
 	srp = sfp->rsv_srp;
-	if (!srp) {
+	if (unlikely(!srp)) {
 		SG_LOG(1, sdp, "%s: srp%s\n", __func__, nbp);
 		goto out_err;
 	}
 	spin_lock_irqsave(&srp->req_lck, iflags);
 	rsv_schp = &srp->sgat_h;
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= (unsigned int)rsv_schp->buflen) {
+	if (unlikely(offset >= (unsigned int)rsv_schp->buflen)) {
 		SG_LOG(1, sdp, "%s: offset[%lu] >= rsv.buflen\n", __func__,
 		       offset);
 		goto out_err_unlock;
@@ -2108,28 +2110,28 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct sg_fd *sfp;
 	struct sg_request *srp;
 
-	if (!filp || !vma)
+	if (unlikely(!filp || !vma))
 		return -ENXIO;
 	sfp = filp->private_data;
-	if (!sfp) {
+	if (unlikely(!sfp)) {
 		pr_warn("sg: %s: sfp is NULL\n", __func__);
 		return -ENXIO;
 	}
 	req_sz = vma->vm_end - vma->vm_start;
 	SG_LOG(3, sfp->parentdp, "%s: vm_start=%p, len=%d\n", __func__,
 	       (void *)vma->vm_start, (int)req_sz);
-	if (vma->vm_pgoff)
+	if (unlikely(vma->vm_pgoff))
 		return -EINVAL; /* only an offset of 0 accepted */
 	/* Check reserve request is inactive and has large enough buffer */
 	mutex_lock(&sfp->f_mutex);
 	srp = sfp->rsv_srp;
 	spin_lock_irqsave(&srp->req_lck, iflags);
-	if (SG_RS_ACTIVE(srp)) {
+	if (unlikely(SG_RS_ACTIVE(srp))) {
 		ret = -EBUSY;
 		goto out;
 	}
 	rsv_schp = &srp->sgat_h;
-	if (req_sz > (unsigned long)rsv_schp->buflen) {
+	if (unlikely(req_sz > (unsigned long)rsv_schp->buflen)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2165,12 +2167,12 @@ sg_rq_end_io_usercontext(struct work_struct *work)
 					      ew_orph.work);
 	struct sg_fd *sfp;
 
-	if (!srp) {
+	if (unlikely(!srp)) {
 		WARN_ONCE("%s: srp unexpectedly NULL\n", __func__);
 		return;
 	}
 	sfp = srp->parentfp;
-	if (!sfp) {
+	if (unlikely(!sfp)) {
 		WARN_ONCE(1, "%s: sfp unexpectedly NULL\n", __func__);
 		return;
 	}
@@ -2190,7 +2192,7 @@ sg_check_sense(struct sg_device *sdp, struct sg_request *srp, int sense_len)
 	struct scsi_request *scsi_rp = scsi_req(srp->rq);
 	u8 *sbp = scsi_rp ? scsi_rp->sense : NULL;
 
-	if (!sbp)
+	if (unlikely(!sbp))
 		return;
 	driver_stat = driver_byte(rq_res);
 	if (driver_stat & DRIVER_SENSE) {
@@ -2205,7 +2207,7 @@ sg_check_sense(struct sg_device *sdp, struct sg_request *srp, int sense_len)
 			}
 		}
 	}
-	if (sdp->sgdebug > 0) {
+	if (unlikely(sdp->sgdebug > 0)) {
 		int scsi_stat = rq_res & 0xff;
 
 		if (scsi_stat == SAM_STAT_CHECK_CONDITION ||
@@ -2231,11 +2233,11 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 
-	if (!scsi_rp) {
+	if (unlikely(!scsi_rp)) {
 		WARN_ONCE("%s: scsi_req(rq) unexpectedly NULL\n", __func__);
 		return;
 	}
-	if (!srp) {
+	if (unlikely(!srp)) {
 		WARN_ONCE("%s: srp unexpectedly NULL\n", __func__);
 		return;
 	}
@@ -2360,14 +2362,14 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	unsigned long iflags;
 
 	sdp = kzalloc(sizeof(struct sg_device), GFP_KERNEL);
-	if (!sdp)
+	if (unlikely(!sdp))
 		return ERR_PTR(-ENOMEM);
 
 	idr_preload(GFP_KERNEL);
 	write_lock_irqsave(&sg_index_lock, iflags);
 
 	error = idr_alloc(&sg_index_idr, sdp, 0, SG_MAX_DEVS, GFP_NOWAIT);
-	if (error < 0) {
+	if (unlikely(error < 0)) {
 		if (error == -ENOSPC) {
 			sdev_printk(KERN_WARNING, scsidp,
 				    "Unable to attach sg device type=%d, minor number exceeds %d\n",
@@ -2392,6 +2394,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	INIT_LIST_HEAD(&sdp->sfds);
 	init_waitqueue_head(&sdp->open_wait);
 	atomic_set(&sdp->detaching, 0);
+	atomic_set(&sdp->open_cnt, 0);
 	rwlock_init(&sdp->sfd_llock);
 	sg_calc_sgat_param(sdp);
 	sdp->index = k;
@@ -2402,7 +2405,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	write_unlock_irqrestore(&sg_index_lock, iflags);
 	idr_preload_end();
 
-	if (error) {
+	if (unlikely(error)) {
 		kfree(sdp);
 		return ERR_PTR(error);
 	}
@@ -2420,7 +2423,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	unsigned long iflags;
 
 	disk = alloc_disk(1);
-	if (!disk) {
+	if (unlikely(!disk)) {
 		pr_warn("%s: alloc_disk failed\n", __func__);
 		return -ENOMEM;
 	}
@@ -2428,7 +2431,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 
 	error = -ENOMEM;
 	cdev = cdev_alloc();
-	if (!cdev) {
+	if (unlikely(!cdev)) {
 		pr_warn("%s: cdev_alloc failed\n", __func__);
 		goto out;
 	}
@@ -2443,7 +2446,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	}
 
 	error = cdev_add(cdev, MKDEV(SCSI_GENERIC_MAJOR, sdp->index), 1);
-	if (error)
+	if (unlikely(error))
 		goto cdev_add_err;
 
 	sdp->cdev = cdev;
@@ -2517,7 +2520,7 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 	struct sg_fd *sfp;
 	int val;
 
-	if (!sdp)
+	if (unlikely(!sdp))
 		return;
 	/* want sdp->detaching non-zero as soon as possible */
 	val = atomic_inc_return(&sdp->detaching);
@@ -2576,7 +2579,7 @@ init_sg(void)
 
 	rc = register_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				    SG_MAX_DEVS, "sg");
-	if (rc)
+	if (unlikely(rc))
 		return rc;
 
 	pr_info("Registered %s[char major=0x%x], version: %s, date: %s\n",
@@ -2589,7 +2592,7 @@ init_sg(void)
 	}
 	sg_sysfs_valid = true;
 	rc = scsi_register_interface(&sg_interface);
-	if (0 == rc) {
+	if (likely(rc == 0)) {
 		sg_proc_init();
 		return 0;
 	}
@@ -2647,8 +2650,7 @@ sg_set_map_data(const struct sg_scatter_hold *schp, bool up_valid,
 }
 
 static int
-sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
-	     struct sg_io_v4 *h4p, int dxfer_dir)
+sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 {
 	bool reserved, us_xfer;
 	int res = 0;
@@ -2658,7 +2660,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
 	void __user *up;
 	struct request *rq;
 	struct scsi_request *scsi_rp;
-	struct sg_fd *sfp = srp->parentfp;
+	struct sg_fd *sfp = cwrp->sfp;
 	struct sg_device *sdp;
 	struct sg_scatter_hold *req_schp;
 	struct request_queue *q;
@@ -2668,20 +2670,22 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
 	struct rq_map_data map_data;
 
 	sdp = sfp->parentdp;
-	if (cmd_len > BLK_MAX_CDB) {	/* for longer SCSI cdb_s */
-		long_cmdp = kzalloc(cmd_len, GFP_KERNEL);
+	if (cwrp->cmd_len > BLK_MAX_CDB) {	/* for longer SCSI cdb_s */
+		long_cmdp = kzalloc(cwrp->cmd_len, GFP_KERNEL);
 		if (!long_cmdp)
 			return -ENOMEM;
 		SG_LOG(5, sdp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
 	}
-	if (h4p) {
+	if (test_bit(SG_FRQ_IS_V4I, srp->frq_bm)) {
+		struct sg_io_v4 *h4p = cwrp->h4p;
+
 		if (dxfer_dir == SG_DXFER_TO_DEV) {
 			r0w = WRITE;
 			up = uptr64(h4p->dout_xferp);
 			dxfer_len = (int)h4p->dout_xfer_len;
 			iov_count = h4p->dout_iovec_count;
 		} else if (dxfer_dir == SG_DXFER_FROM_DEV) {
-			r0w = READ;
+			/* r0w = READ; */
 			up = uptr64(h4p->din_xferp);
 			dxfer_len = (int)h4p->din_xfer_len;
 			iov_count = h4p->din_iovec_count;
@@ -2720,10 +2724,21 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
 	scsi_rp = scsi_req(rq);
 	srp->rq = rq;
 
-	if (cmd_len > BLK_MAX_CDB)
+	if (cwrp->cmd_len > BLK_MAX_CDB)
 		scsi_rp->cmd = long_cmdp;
-	memcpy(scsi_rp->cmd, cmd, cmd_len);
-	scsi_rp->cmd_len = cmd_len;
+	if (cwrp->u_cmdp)
+		res = sg_fetch_cmnd(cwrp->filp, sfp, cwrp->u_cmdp,
+				    cwrp->cmd_len, scsi_rp->cmd);
+	else if (cwrp->cmdp)
+		memcpy(scsi_rp->cmd, cwrp->cmdp, cwrp->cmd_len);
+	else
+		res = -EPROTO;
+	if (unlikely(res)) {
+		kfree(long_cmdp);
+		return res;
+	}
+	scsi_rp->cmd_len = cwrp->cmd_len;
+	srp->cmd_opcode = scsi_rp->cmd[0];
 	us_xfer = !(srp->rq_flags & SG_FLAG_NO_DXFER);
 	assign_bit(SG_FRQ_NO_US_XFER, srp->frq_bm, !us_xfer);
 	reserved = (sfp->rsv_srp == srp);
@@ -2756,7 +2771,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
 
 			res = sg_mk_sgat(srp, sfp, up_sz);
 		}
-		if (res)
+		if (unlikely(res))
 			goto fini;
 
 		sg_set_map_data(req_schp, !!up, md);
@@ -2768,7 +2783,7 @@ sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
 		struct iov_iter i;
 
 		res = import_iovec(r0w, up, iov_count, 0, &iov, &i);
-		if (res < 0)
+		if (unlikely(res < 0))
 			goto fini;
 
 		iov_iter_truncate(&i, dxfer_len);
@@ -3117,7 +3132,7 @@ sg_mk_srp_sgat(struct sg_fd *sfp, bool first, int db_len)
 		return n_srp;
 	if (db_len > 0) {
 		res = sg_mk_sgat(n_srp, sfp, db_len);
-		if (res) {
+		if (unlikely(res)) {
 			kfree(n_srp);
 			return ERR_PTR(res);
 		}
@@ -3151,7 +3166,7 @@ sg_build_reserve(struct sg_fd *sfp, int buflen)
 			go_out = true;
 		}
 		res = sg_mk_sgat(srp, sfp, buflen);
-		if (res == 0) {
+		if (likely(res == 0)) {
 			SG_LOG(4, sfp ? sfp->parentdp : NULL,
 			       "%s: final buflen=%d, srp=0x%p ++\n", __func__,
 			       buflen, srp);
@@ -3172,29 +3187,30 @@ sg_build_reserve(struct sg_fd *sfp, int buflen)
  * failure returns a negated errno value twisted by ERR_PTR() macro.
  */
 static struct sg_request *
-sg_add_request(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
+sg_add_request(struct sg_comm_wr_t *cwrp, int dxfr_len)
 {
 	bool act_empty = false;
 	bool mk_new_srp = true;
 	unsigned long iflags;
 	enum sg_rq_state sr_st;
+	struct sg_fd *fp = cwrp->sfp;
 	struct sg_request *r_srp = NULL;	/* request to return */
 	struct sg_request *rsv_srp;	/* current fd's reserve request */
 	__maybe_unused struct sg_device *sdp;
 	__maybe_unused const char *cp;
 
-	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	sdp = sfp->parentdp;
-	rsv_srp = sfp->rsv_srp;
+	spin_lock_irqsave(&fp->rq_list_lock, iflags);
+	sdp = fp->parentdp;
+	rsv_srp = fp->rsv_srp;
 	cp = "";
 	/*
 	 * Check the free list (fl) for candidates. Pick zero data length
 	 * requests from the back of the fl, the rest from the front.
 	 */
-	if (list_empty(&sfp->rq_fl)) {
+	if (list_empty(&fp->rq_fl)) {
 		act_empty = true;
 	} else if (dxfr_len < 1) {  /* 0 data length requests at back of fl */
-		list_for_each_entry_reverse(r_srp, &sfp->rq_fl, fl_entry) {
+		list_for_each_entry_reverse(r_srp, &fp->rq_fl, fl_entry) {
 			sr_st = atomic_read(&r_srp->rq_st);
 			if (sr_st == SG_RS_INACTIVE) {
 				if (likely(sg_rstate_chg(r_srp, sr_st,
@@ -3206,7 +3222,7 @@ sg_add_request(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 			}
 		}
 	} else { /*     find request with large enough dlen */
-		list_for_each_entry(r_srp, &sfp->rq_fl, fl_entry) {
+		list_for_each_entry(r_srp, &fp->rq_fl, fl_entry) {
 			sr_st = atomic_read(&r_srp->rq_st);
 			if (sr_st == SG_RS_INACTIVE &&
 			    r_srp->sgat_h.buflen >= dxfr_len) {
@@ -3221,19 +3237,19 @@ sg_add_request(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 	}
 
 	if (mk_new_srp) {	/* Need new sg_request object */
-		bool allow_cmd_q = test_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
+		bool allow_cmd_q = test_bit(SG_FFD_CMD_Q, fp->ffd_bm);
 
 		r_srp = NULL;
-		if (!allow_cmd_q && !list_empty(&sfp->rq_list)) {
+		if (!allow_cmd_q && !list_empty(&fp->rq_list)) {
 			r_srp = ERR_PTR(-EDOM);
 			SG_LOG(6, sdp, "%s: trying 2nd req but cmd_q=false\n",
 			       __func__);
 		}
-		spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+		spin_unlock_irqrestore(&fp->rq_list_lock, iflags);
 		if (IS_ERR(r_srp))        /* NULL is not an ERR here */
 			goto err_no_lock;
 		/* releasing rq_list_lock because next line could take time */
-		r_srp = sg_mk_srp_sgat(sfp, act_empty, dxfr_len);
+		r_srp = sg_mk_srp_sgat(fp, act_empty, dxfr_len);
 		if (IS_ERR(r_srp))
 			goto err_no_lock;
 		cp = "new";
@@ -3251,11 +3267,11 @@ sg_add_request(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 	r_srp->sgat_h.dlen = dxfr_len;/* must be <= r_srp->sgat_h.buflen */
 	r_srp->cmd_opcode = 0xff;  /* set invalid opcode (VS), 0x0 is TUR */
 	if (mk_new_srp)
-		spin_lock_irqsave(&sfp->rq_list_lock, iflags);
-	list_add_tail_rcu(&r_srp->rq_entry, &sfp->rq_list);
+		spin_lock_irqsave(&fp->rq_list_lock, iflags);
+	list_add_tail_rcu(&r_srp->rq_entry, &fp->rq_list);
 	if (!mk_new_srp)
 		spin_unlock(&r_srp->req_lck);
-	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	spin_unlock_irqrestore(&fp->rq_list_lock, iflags);
 err_no_lock:
 	if (IS_ERR(r_srp))
 		SG_LOG(1, sdp, "%s: err=%ld\n", __func__, PTR_ERR(r_srp));
@@ -3353,6 +3369,8 @@ sg_add_sfp(struct sg_device *sdp)
 	assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, SG_DEF_COMMAND_Q);
 	assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, SG_DEF_KEEP_ORPHAN);
 	assign_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm, SG_DEFAULT_Q_AT);
+	atomic_set(&sfp->submitted, 0);
+	atomic_set(&sfp->waiting, 0);
 	/*
 	 * SG_SCATTER_SZ initializes scatter_elem_sz but different value may
 	 * be given as driver/module parameter (e.g. 'scatter_elem_sz=8192').
@@ -3890,7 +3908,7 @@ sg_proc_dbg_sdev(struct sg_device *sdp, char *obp, int len, int *fd_counterp)
 	n += scnprintf(obp + n, len - n,
 		       "  max_sgat_sz,elems=2^%d,%d excl=%d open_cnt=%d\n",
 		       ilog2(sdp->max_sgat_sz), sdp->max_sgat_elems,
-		       sdp->exclude, sdp->open_cnt);
+		       sdp->exclude, atomic_read(&sdp->open_cnt));
 	list_for_each_entry(fp, &sdp->sfds, sfd_entry) {
 		++*countp;
 		rcu_read_lock(); /* assume irqs disabled */
-- 
2.17.1

