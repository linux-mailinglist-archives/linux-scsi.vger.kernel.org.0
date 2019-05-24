Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948AF29E5D
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403760AbfEXSse (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:34 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56364 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391503AbfEXSse (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 60B0920419B;
        Fri, 24 May 2019 20:48:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rKtciVTT4TkV; Fri, 24 May 2019 20:48:22 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 1F5CB204190;
        Fri, 24 May 2019 20:48:16 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 05/19] sg: replace rq array with lists
Date:   Fri, 24 May 2019 14:47:55 -0400
Message-Id: <20190524184809.25121-6-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove the fixed size array of 16 request elements per file descriptor
and replace with two linked lists (per fd). One list is for active
commands, the other list is a free list. sg_request objects are now
kept, available for re-use, until their owning file descriptor is
closed. The associated block request and scsi_request objects are
released much earlier; their lifetime is the same as it was in the
v3 sg driver. The lifetime of the bio is also the same (but is
stretched in a later patch).

Add an enum for request state (sg_rq_state) and collect various flags
into bit maps: one for requests (SG_FRQ_*) and the other for file
descriptors (SG_FFD_*).

Since the above changes touch almost every function and low level
structures, this patch is big. With so many changes, the diff
utility that generates the patch sometimes loses track.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 3451 +++++++++++++++++++++++++++++----------------
 1 file changed, 2231 insertions(+), 1220 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 291c278451ef..72ce51b3198c 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -57,28 +57,79 @@ static char *sg_version_date = "20140603";
 
 #define SG_MAX_DEVS 32768
 
-/* SG_MAX_CDB_SIZE should be 260 (spc4r37 section 3.1.30) however the type
+/* Comment out the following line to compile out SCSI_LOGGING stuff */
+#define SG_DEBUG 1
+
+#if !IS_ENABLED(SG_DEBUG)
+#if IS_ENABLED(DEBUG)    /* If SG_DEBUG not defined, check for DEBUG */
+#define SG_DEBUG DEBUG
+#endif
+#endif
+
+/*
+ * SG_MAX_CDB_SIZE should be 260 (spc4r37 section 3.1.30) however the type
  * of sg_io_hdr::cmd_len can only represent 255. All SCSI commands greater
- * than 16 bytes are "variable length" whose length is a multiple of 4
+ * than 16 bytes are "variable length" whose length is a multiple of 4, so
  */
 #define SG_MAX_CDB_SIZE 252
 
+#define uptr64(val) ((void __user *)(uintptr_t)(val))
+#define cuptr64(val) ((const void __user *)(uintptr_t)(val))
+
+/* Following enum contains the states of sg_request::rq_st */
+enum sg_rq_state {
+	SG_RS_INACTIVE = 0,	/* request not in use (e.g. on fl) */
+	SG_RS_INFLIGHT,		/* active: cmd/req issued, no response yet */
+	SG_RS_AWAIT_RD,		/* response received, awaiting read */
+	SG_RS_DONE_RD,		/* read is ongoing or done */
+	SG_RS_BUSY,		/* temporary state should rarely be seen */
+};
+
+#define SG_TIME_UNIT_MS 0	/* milliseconds */
+#define SG_DEF_TIME_UNIT SG_TIME_UNIT_MS
 #define SG_DEFAULT_TIMEOUT mult_frac(SG_DEFAULT_TIMEOUT_USER, HZ, USER_HZ)
+#define SG_FD_Q_AT_HEAD 0
+#define SG_DEFAULT_Q_AT SG_FD_Q_AT_HEAD /* for backward compatibility */
+#define SG_FL_MMAP_DIRECT (SG_FLAG_MMAP_IO | SG_FLAG_DIRECT_IO)
+
+/* Only take lower 4 bits of driver byte, all host byte and sense byte */
+#define SG_ML_RESULT_MSK 0x0fff00ff	/* mid-level's 32 bit result value */
+
+#define SG_SHARE_FD_UNUSED (-1)
+#define SG_SHARE_FD_MASTER (-2)		/* values >= 0 imply FD_SLAVE */
+
+#define SG_PACK_ID_WILDCARD (-1)
+
+#define SG_ADD_RQ_MAX_RETRIES 40	/* to stop infinite _trylock(s) */
+
+/* Bit positions (flags) for sg_request::frq_bm bitmask follow */
+#define SG_FRQ_IS_ORPHAN	1	/* owner of request gone */
+#define SG_FRQ_SYNC_INVOC	2	/* synchronous (blocking) invocation */
+#define SG_FRQ_DIO_IN_USE	3	/* false->indirect_IO,mmap; 1->dio */
+#define SG_FRQ_NO_US_XFER	4	/* no user space transfer of data */
+#define SG_FRQ_DEACT_ORPHAN	7	/* not keeping orphan so de-activate */
+#define SG_FRQ_BLK_PUT_REQ	9	/* set when blk_put_request() called */
+
+/* Bit positions (flags) for sg_fd::ffd_bm bitmask follow */
+#define SG_FFD_FORCE_PACKID	0	/* receive only given pack_id/tag */
+#define SG_FFD_CMD_Q		1	/* clear: only 1 active req per fd */
+#define SG_FFD_KEEP_ORPHAN	2	/* policy for this fd */
+#define SG_FFD_MMAP_CALLED	3	/* mmap(2) system call made on fd */
+#define SG_FFD_Q_AT_TAIL	5	/* set: queue reqs at tail of blk q */
+
 
 int sg_big_buff = SG_DEF_RESERVED_SIZE;
-/* N.B. This variable is readable and writeable via
-   /proc/scsi/sg/def_reserved_size . Each time sg_open() is called a buffer
-   of this size (or less if there is not enough memory) will be reserved
-   for use by this file descriptor. [Deprecated usage: this variable is also
-   readable via /proc/sys/kernel/sg-big-buff if the sg driver is built into
-   the kernel (i.e. it is not a module).] */
-static int def_reserved_size = -1;	/* picks up init parameter */
+/*
+ * This variable is accessible via /proc/scsi/sg/def_reserved_size . Each
+ * time sg_open() is called a sg_request of this size (or less if there is
+ * not enough memory) will be reserved for use by this file descriptor.
+ */
+static int def_reserved_size = -1;      /* picks up init parameter */
 static int sg_allow_dio = SG_ALLOW_DIO_DEF;
 
 static int scatter_elem_sz = SG_SCATTER_SZ;
-static int scatter_elem_sz_prev = SG_SCATTER_SZ;
 
-#define SG_SECTOR_SZ 512
+#define SG_DEF_SECTOR_SZ 512
 
 static int sg_add_device(struct device *, struct class_interface *);
 static void sg_remove_device(struct device *, struct class_interface *);
@@ -91,106 +142,155 @@ static struct class_interface sg_interface = {
 	.remove_dev     = sg_remove_device,
 };
 
-struct sg_scatter_hold { /* holding area for scsi scatter gather info */
-	u16 k_use_sg; /* Count of kernel scatter-gather pieces */
-	unsigned int sglist_len; /* size of malloc'd scatter-gather list ++ */
-	unsigned int bufflen;	/* Size of (aggregate) data buffer */
-	struct page **pages;
-	int page_order;
-	char dio_in_use;	/* 0->indirect IO (or mmap), 1->dio */
-	u8 cmd_opcode;		/* first byte of command */
+/* Subset of sg_io_hdr found in <scsi/sg.h>, has only [i] and [i->o] fields */
+struct sg_slice_hdr3 {
+	int interface_id;
+	int dxfer_direction;
+	u8 cmd_len;
+	u8 mx_sb_len;
+	u16 iovec_count;
+	unsigned int dxfer_len;
+	void __user *dxferp;
+	u8 __user *cmdp;
+	void __user *sbp;
+	unsigned int timeout;
+	unsigned int flags;
+	int pack_id;
+	void __user *usr_ptr;
+};
+
+struct sg_scatter_hold {     /* holding area for scsi scatter gather info */
+	struct page **pages;	/* num_sgat element array of struct page* */
+	int buflen;		/* capacity in bytes (dlen<=buflen) */
+	int dlen;		/* current valid data length of this req */
+	u16 page_order;		/* byte_len = (page_size*(2**page_order)) */
+	u16 num_sgat;		/* actual number of scatter-gather segments */
 };
 
 struct sg_device;		/* forward declarations */
 struct sg_fd;
 
-struct sg_request {	/* SG_MAX_QUEUE requests outstanding per file */
-	struct list_head entry;	/* list entry */
-	struct sg_fd *parentfp;	/* NULL -> not in use */
-	struct sg_scatter_hold data;	/* hold buffer, perhaps scatter list */
-	sg_io_hdr_t header;	/* scsi command+info, see <scsi/sg.h> */
-	u8 sense_b[SCSI_SENSE_BUFFERSIZE];
-	char res_used;		/* 1 -> using reserve buffer, 0 -> not ... */
-	char orphan;		/* 1 -> drop on sight, 0 -> normal */
-	char sg_io_owned;	/* 1 -> packet belongs to SG_IO */
-	/* done protected by rq_list_lock */
-	char done;		/* 0->before bh, 1->before read, 2->read */
-	struct request *rq;
-	struct bio *bio;
-	struct execute_work ew;
+struct sg_request {	/* active SCSI command or inactive on free list (fl) */
+	struct list_head rq_entry;	/* member of rq_list (active cmd) */
+	struct list_head fl_entry;	/* member of rq_fl */
+	spinlock_t req_lck;
+	struct sg_scatter_hold sgat_h;	/* hold buffer, perhaps scatter list */
+	struct sg_slice_hdr3 s_hdr3;  /* subset of sg_io_hdr */
+	u32 duration;		/* cmd duration in milliseconds */
+	u32 rq_flags;		/* hold user supplied flags */
+	u32 rq_info;		/* info supplied by v3 and v4 interfaces */
+	u32 rq_result;		/* packed scsi request result from LLD */
+	int in_resid;		/* requested-actual byte count on data-in */
+	int pack_id;		/* user provided packet identifier field */
+	int sense_len;		/* actual sense buffer length (data-in) */
+	atomic_t rq_st;		/* request state, holds a enum sg_rq_state */
+	u8 cmd_opcode;		/* first byte of SCSI cdb */
+	u64 start_ns;		/* starting point of command duration calc */
+	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
+	u8 *sense_bp;		/* alloc-ed sense buffer, as needed */
+	struct sg_fd *parentfp;	/* pointer to owning fd, even when on fl */
+	struct request *rq;	/* released in sg_rq_end_io(), bio kept */
+	struct bio *bio;	/* kept until this req -->SG_RS_INACTIVE */
+	struct execute_work ew_orph;	/* harvest orphan request */
 };
 
 struct sg_fd {		/* holds the state of a file descriptor */
-	struct list_head sfd_siblings;  /* protected by device's sfd_lock */
+	struct list_head sfd_entry;	/* member sg_device::sfds list */
 	struct sg_device *parentdp;	/* owning device */
 	wait_queue_head_t read_wait;	/* queue read until command done */
-	rwlock_t rq_list_lock;	/* protect access to list in req_arr */
-	struct mutex f_mutex;	/* protect against changes in this fd */
+	struct mutex f_mutex;	/* serialize ioctls on this fd */
+	spinlock_t rq_list_lock;/* for rw-lock on sg_request lists [rcu] */
+	struct list_head rq_list; /* head of inflight sg_request list */
+	struct list_head rq_fl; /* head of sg_request free list */
 	int timeout;		/* defaults to SG_DEFAULT_TIMEOUT      */
 	int timeout_user;	/* defaults to SG_DEFAULT_TIMEOUT_USER */
-	struct sg_scatter_hold reserve;	/* buffer for this file descriptor */
-	struct list_head rq_list; /* head of request list */
-	struct fasync_struct *async_qp;	/* used by asynchronous notification */
-	struct sg_request req_arr[SG_MAX_QUEUE];/* use as singly-linked list */
-	char force_packid;	/* 1 -> pack_id input to read(), 0 -> ignored */
-	char cmd_q;		/* 1 -> allow command queuing, 0 -> don't */
+	int sgat_elem_sz;	/* initialized to scatter_elem_sz */
+	atomic_t submitted;	/* number inflight or awaiting read */
+	atomic_t waiting;	/* number of requests awaiting read */
+	unsigned long ffd_bm[1];	/* see SG_FFD_* defines above */
+	pid_t tid;		/* thread id when opened */
 	u8 next_cmd_len;	/* 0: automatic, >0: use on next write() */
-	char keep_orphan;	/* 0 -> drop orphan (def), 1 -> keep for read() */
-	char mmap_called;	/* 0 -> mmap() never called on this fd */
-	char res_in_use;	/* 1 -> 'reserve' array in use */
+	struct sg_request *rsv_srp;/* one reserve request per fd */
+	struct fasync_struct *async_qp; /* used by asynchronous notification */
 	struct kref f_ref;
-	struct execute_work ew;
+	struct execute_work ew_fd;  /* harvest all fd resources and lists */
 };
 
-struct sg_device { /* holds the state of each scsi generic device */
+struct sg_device {	/* holds the state of each scsi generic device */
 	struct scsi_device *device;
-	wait_queue_head_t open_wait;    /* queue open() when O_EXCL present */
-	struct mutex open_rel_lock;     /* held when in open() or release() */
-	int sg_tablesize;	/* adapter's max scatter-gather table size */
+	wait_queue_head_t open_wait;	/* queue open() when O_EXCL present */
+	struct mutex open_rel_lock;	/* held when in open() or release() */
+	int max_sgat_elems;	/* adapter's max sgat number of elements */
+	int max_sgat_sz;	/* max number of bytes in sgat list */
 	u32 index;		/* device index number */
-	struct list_head sfds;
-	rwlock_t sfd_lock;      /* protect access to sfd list */
-	atomic_t detaching;     /* 0->device usable, 1->device detaching */
+	struct list_head sfds;	/* head of sg_fd::sfd_entry list */
+	rwlock_t sfd_llock;	/* protect access to sfds list */
+	atomic_t detaching;	/* 0->device usable, 1->device detaching */
 	bool exclude;		/* 1->open(O_EXCL) succeeded and is active */
+	u8 sgdebug;	/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
 	int open_cnt;		/* count of opens (perhaps < num(sfds) ) */
-	char sgdebug;		/* 0->off, 1->sense, 9->dump dev, 10-> all devs */
 	struct gendisk *disk;
 	struct cdev * cdev;	/* char_dev [sysfs: /sys/cdev/major/sg<n>] */
 	struct kref d_ref;
 };
 
+struct sg_comm_wr_t {	/* arguments to sg_common_write() */
+	int timeout;
+	unsigned long frq_bm[1];	/* see SG_FRQ_* defines above */
+	struct sg_io_hdr *h3p;
+	u8 *cmnd;
+};
+
 /* tasklet or soft irq callback */
 static void sg_rq_end_io(struct request *rq, blk_status_t status);
 /* Declarations of other static functions used before they are defined */
 static int sg_proc_init(void);
-static int sg_start_req(struct sg_request *srp, u8 *cmd);
-static int sg_finish_rem_req(struct sg_request *srp);
-static int sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
-			     int buff_size);
-static ssize_t sg_new_write(struct sg_fd *sfp, struct file *file,
-			const char __user *buf, size_t count, int blocking,
-			int read_only, int sg_io_owned,
-			struct sg_request **o_srp);
-static int sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
-			   u8 *cmnd, int timeout, int blocking);
-static int sg_rd_append(struct sg_request *srp, char __user *outp,
+static int sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len,
+			int dxfer_dir);
+// static int sg_finish_rem_req(struct sg_request *srp);
+static void sg_finish_scsi_blk_rq(struct sg_request *srp);
+static int sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen);
+static int sg_submit(struct file *filp, struct sg_fd *sfp,
+		     struct sg_io_hdr *hp, bool sync,
+		     struct sg_request **o_srp);
+static struct sg_request *sg_common_write(struct sg_fd *sfp,
+					  struct sg_comm_wr_t *cwp);
+static int sg_rd_append(struct sg_request *srp, void __user *outp,
 			int num_xfer);
-static void sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp);
-static void sg_build_reserve(struct sg_fd *sfp, int req_size);
-static void sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp,
-			    int size);
-static void sg_unlink_reserve(struct sg_fd *sfp, struct sg_request *srp);
+static void sg_remove_sgat(struct sg_request *srp);
 static struct sg_fd *sg_add_sfp(struct sg_device *sdp);
 static void sg_remove_sfp(struct kref *);
-static struct sg_request *sg_add_request(struct sg_fd *sfp);
-static int sg_remove_request(struct sg_fd *sfp, struct sg_request *srp);
+static struct sg_request *sg_find_srp_by_id(struct sg_fd *sfp, int pack_id);
+static struct sg_request *sg_add_request(struct sg_fd *sfp, int dxfr_len,
+					 struct sg_comm_wr_t *cwrp);
+static void sg_deact_request(struct sg_fd *sfp, struct sg_request *srp);
 static struct sg_device *sg_get_dev(int dev);
 static void sg_device_destroy(struct kref *kref);
+static struct sg_request *sg_mk_srp_sgat(struct sg_fd *sfp, bool first,
+					 int db_len);
+static void sg_calc_sgat_param(struct sg_device *sdp);
+static const char *sg_rq_st_str(enum sg_rq_state rq_st, bool long_str);
+static void sg_rep_rq_state_fail(struct sg_device *sdp,
+				 enum sg_rq_state exp_old_st,
+				 enum sg_rq_state want_st,
+				 enum sg_rq_state act_old_st);
+
+#define SZ_SG_HEADER ((int)sizeof(struct sg_header))    /* v1 and v2 header */
+#define SZ_SG_IO_HDR ((int)sizeof(struct sg_io_hdr))	/* v3 header */
+#define SZ_SG_REQ_INFO ((int)sizeof(struct sg_req_info))
+
+#define SG_RS_ACTIVE(srp) (atomic_read(&(srp)->rq_st) != SG_RS_INACTIVE)
+#define SG_RS_AWAIT_READ(srp) (atomic_read(&(srp)->rq_st) == SG_RS_AWAIT_RD)
+
+/*
+ * Kernel needs to be built with CONFIG_SCSI_LOGGING to see log messages.
+ * 'depth' is a number between 1 (most severe) and 7 (most noisy, most
+ * information). All messages are logged as informational (KERN_INFO). In
+ * the unexpected situation where sdp is NULL the macro reverts to a pr_info
+ * and ignores CONFIG_SCSI_LOGGING and always prints to the log.
+ */
 
-#define SZ_SG_HEADER sizeof(struct sg_header)
-#define SZ_SG_IO_HDR sizeof(sg_io_hdr_t)
-#define SZ_SG_IOVEC sizeof(sg_iovec_t)
-#define SZ_SG_REQ_INFO sizeof(sg_req_info_t)
+#define SG_PROC_DEBUG_SZ 8192
 
 #if IS_ENABLED(CONFIG_SCSI_LOGGING)
 #define SG_LOG(depth, sdp, fmt, a...)					\
@@ -280,6 +380,25 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 	return retval;
 }
 
+/*
+ * scsi_block_when_processing_errors() returns 0 when dev was taken offline by
+ * error recovery, 1 otherwise (i.e. okay). Even if in error recovery, let
+ * user continue if O_NONBLOCK set. Permits SCSI commands to be issued during
+ * error recovery. Tread carefully.
+ * Returns 0 for ok (i.e. allow), -EPROTO if sdp is NULL, otherwise -ENXIO .
+ */
+static inline int
+sg_allow_if_err_recovery(struct sg_device *sdp, bool non_block)
+{
+	if (!sdp)
+		return -EPROTO;
+	if (non_block)
+		return 0;
+	if (likely(scsi_block_when_processing_errors(sdp->device)))
+		return 0;
+	return -ENXIO;
+}
+
 /*
  * Corresponds to the open() system call on sg devices. Implements O_EXCL on
  * a per device basis using 'open_cnt'. If O_EXCL and O_NONBLOCK and there is
@@ -290,16 +409,16 @@ sg_wait_open_event(struct sg_device *sdp, bool o_excl)
 static int
 sg_open(struct inode *inode, struct file *filp)
 {
-	bool o_excl;
+	bool o_excl, non_block;
 	int min_dev = iminor(inode);
 	int op_flags = filp->f_flags;
-	struct request_queue *q;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	int retval;
 
 	nonseekable_open(inode, filp);
 	o_excl = !!(op_flags & O_EXCL);
+	non_block = !!(op_flags & O_NONBLOCK);
 	if (o_excl && ((op_flags & O_ACCMODE) == O_RDONLY))
 		return -EPERM; /* Can't lock it with read only access */
 	sdp = sg_get_dev(min_dev);
@@ -320,15 +439,9 @@ sg_open(struct inode *inode, struct file *filp)
 	if (retval)
 		goto sdp_put;
 
-	/* scsi_block_when_processing_errors() may block so bypass
-	 * check if O_NONBLOCK. Permits SCSI commands to be issued
-	 * during error recovery. Tread carefully. */
-	if (!((op_flags & O_NONBLOCK) ||
-	      scsi_block_when_processing_errors(sdp->device))) {
-		retval = -ENXIO;
-		/* we are in error recovery for this device */
+	retval = sg_allow_if_err_recovery(sdp, non_block);
+	if (retval)
 		goto error_out;
-	}
 
 	mutex_lock(&sdp->open_rel_lock);
 	if (op_flags & O_NONBLOCK) {
@@ -355,8 +468,8 @@ sg_open(struct inode *inode, struct file *filp)
 
 	if (sdp->open_cnt < 1) {  /* no existing opens */
 		sdp->sgdebug = 0;
-		q = sdp->device->request_queue;
-		sdp->sg_tablesize = queue_max_segments(q);
+		/* Next done in sg_alloc(), repeat here to pick up change? */
+		sg_calc_sgat_param(sdp);
 	}
 	sfp = sg_add_sfp(sdp);
 	if (IS_ERR(sfp)) {
@@ -425,255 +538,278 @@ sg_release(struct inode *inode, struct file *filp)
  * the SCSI device by using write(2), ioctl(SG_IOSUBMIT) or the first half
  * of the synchronous ioctl(SG_IO) system call.
  */
+
 static ssize_t
-sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
+sg_write(struct file *filp, const char __user *p, size_t count, loff_t *ppos)
 {
-	int mxsize, cmd_size, k;
-	int input_size, blocking;
+	int mxsize, cmd_size, input_size, res;
 	u8 opcode;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	struct sg_request *srp;
-	struct sg_header old_hdr;
-	sg_io_hdr_t *hp;
 	u8 cmnd[SG_MAX_CDB_SIZE];
-	int retval;
-
-	retval = sg_check_file_access(filp, __func__);
-	if (retval)
-		return retval;
+	struct sg_header ov2hdr;
+	struct sg_io_hdr v3hdr;
+	struct sg_header *ohp = &ov2hdr;
+	struct sg_io_hdr *h3p = &v3hdr;
+	struct sg_comm_wr_t cwr;
+
+	res = sg_check_file_access(filp, __func__);
+	if (res)
+		return res;
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
 	SG_LOG(3, sdp, "%s: write(3rd arg) count=%d\n", __func__, (int)count);
-	if (!sdp)
-		return -ENXIO;
-	if (atomic_read(&sdp->detaching))
+	res = sg_allow_if_err_recovery(sdp, !!(filp->f_flags & O_NONBLOCK));
+	if (res)
+		return res;
+	if (unlikely(atomic_read(&sdp->detaching)))
 		return -ENODEV;
-	if (!((filp->f_flags & O_NONBLOCK) ||
-	      scsi_block_when_processing_errors(sdp->device)))
-		return -ENXIO;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
 	if (count < SZ_SG_HEADER)
 		return -EIO;
-	if (__copy_from_user(&old_hdr, buf, SZ_SG_HEADER))
+	if (copy_from_user(ohp, p, SZ_SG_HEADER))
 		return -EFAULT;
-	blocking = !(filp->f_flags & O_NONBLOCK);
-	if (old_hdr.reply_len < 0)
-		return sg_new_write(sfp, filp, buf, count,
-				    blocking, 0, 0, NULL);
-	if (count < (SZ_SG_HEADER + 6))
-		return -EIO;	/* The minimum scsi command length is 6 bytes. */
+	if (ohp->reply_len < 0) {	/* assume this is v3 */
+		struct sg_io_hdr *reinter_2p = (struct sg_io_hdr *)ohp;
+		u8 *h3u8p = (u8 *)&v3hdr;
 
-	if (!(srp = sg_add_request(sfp))) {
-		SG_LOG(1, sdp, "%s: queue full\n", __func__);
-		return -EDOM;
+		if (count < SZ_SG_IO_HDR)
+			return -EIO;
+		if (reinter_2p->interface_id != 'S') {
+			pr_info_once("sg: %s: v3 interface only here\n",
+				     __func__);
+			return -EPERM;
+		}
+		memcpy(h3p, ohp, SZ_SG_HEADER);
+		if (__copy_from_user(h3u8p + SZ_SG_HEADER, p + SZ_SG_HEADER,
+				     SZ_SG_IO_HDR - SZ_SG_HEADER))
+			return -EFAULT;
+		res = sg_submit(filp, sfp, h3p, false, NULL);
+		return res < 0 ? res : (int)count;
 	}
-	buf += SZ_SG_HEADER;
-	__get_user(opcode, buf);
+	/* v1 and v2 interfaces processed below this point */
+	if (count < (SZ_SG_HEADER + 6))
+		return -EIO;    /* minimum scsi command length is 6 bytes */
+	p += SZ_SG_HEADER;
+	__get_user(opcode, p);
 	mutex_lock(&sfp->f_mutex);
 	if (sfp->next_cmd_len > 0) {
 		cmd_size = sfp->next_cmd_len;
-		sfp->next_cmd_len = 0;	/* reset so only this write() effected */
+		sfp->next_cmd_len = 0;  /* reset, only this write() effected */
 	} else {
-		cmd_size = COMMAND_SIZE(opcode);	/* based on SCSI command group */
-		if ((opcode >= 0xc0) && old_hdr.twelve_byte)
+		cmd_size = COMMAND_SIZE(opcode);/* old; SCSI command group */
+		if (opcode >= 0xc0 && ohp->twelve_byte)
 			cmd_size = 12;
 	}
 	mutex_unlock(&sfp->f_mutex);
 	SG_LOG(4, sdp, "%s:   scsi opcode=0x%02x, cmd_size=%d\n", __func__,
 	       (unsigned int)opcode, cmd_size);
 	input_size = count - cmd_size;
-	mxsize = max_t(int, input_size, old_hdr.reply_len);
+	mxsize = max_t(int, input_size, ohp->reply_len);
 	mxsize -= SZ_SG_HEADER;
 	input_size -= SZ_SG_HEADER;
-	if (input_size < 0) {
-		sg_remove_request(sfp, srp);
-		return -EIO;	/* User did not pass enough bytes for this command. */
-	}
-	hp = &srp->header;
-	hp->interface_id = '\0';	/* indicator of old interface tunnelled */
-	hp->cmd_len = (u8) cmd_size;
-	hp->iovec_count = 0;
-	hp->mx_sb_len = 0;
+	if (input_size < 0)
+		return -EIO; /* Insufficient bytes passed for this command. */
+	memset(h3p, 0, sizeof(*h3p));
+	h3p->interface_id = '\0';/* indicate v1 or v2 interface (tunnelled) */
+	h3p->cmd_len = (u8)cmd_size;
+	h3p->iovec_count = 0;
+	h3p->mx_sb_len = 0;
 	if (input_size > 0)
-		hp->dxfer_direction = (old_hdr.reply_len > SZ_SG_HEADER) ?
+		h3p->dxfer_direction = (ohp->reply_len > SZ_SG_HEADER) ?
 		    SG_DXFER_TO_FROM_DEV : SG_DXFER_TO_DEV;
 	else
-		hp->dxfer_direction = (mxsize > 0) ? SG_DXFER_FROM_DEV : SG_DXFER_NONE;
-	hp->dxfer_len = mxsize;
-	if ((hp->dxfer_direction == SG_DXFER_TO_DEV) ||
-	    (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV))
-		hp->dxferp = (char __user *)buf + cmd_size;
+		h3p->dxfer_direction = (mxsize > 0) ? SG_DXFER_FROM_DEV :
+						      SG_DXFER_NONE;
+	h3p->dxfer_len = mxsize;
+	if (h3p->dxfer_direction == SG_DXFER_TO_DEV ||
+	    h3p->dxfer_direction == SG_DXFER_TO_FROM_DEV)
+		h3p->dxferp = (u8 __user *)p + cmd_size;
 	else
-		hp->dxferp = NULL;
-	hp->sbp = NULL;
-	hp->timeout = old_hdr.reply_len;	/* structure abuse ... */
-	hp->flags = input_size;	/* structure abuse ... */
-	hp->pack_id = old_hdr.pack_id;
-	hp->usr_ptr = NULL;
-	if (__copy_from_user(cmnd, buf, cmd_size))
+		h3p->dxferp = NULL;
+	h3p->sbp = NULL;
+	h3p->timeout = ohp->reply_len;   /* structure abuse ... */
+	h3p->flags = input_size;         /* structure abuse ... */
+	h3p->pack_id = ohp->pack_id;
+	h3p->usr_ptr = NULL;
+	cmnd[0] = opcode;
+	if (__copy_from_user(cmnd + 1, p + 1, cmd_size - 1))
 		return -EFAULT;
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
-	 * but is is possible that the app intended SG_DXFER_TO_DEV, because there
-	 * is a non-zero input_size, so emit a warning.
+	 * but it is possible that the app intended SG_DXFER_TO_DEV, because
+	 * there is a non-zero input_size, so emit a warning.
 	 */
-	if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV) {
+	if (h3p->dxfer_direction == SG_DXFER_TO_FROM_DEV) {
 		printk_ratelimited(KERN_WARNING
-				   "sg_write: data in/out %d/%d bytes "
-				   "for SCSI command 0x%x-- guessing "
-				   "data in;\n   program %s not setting "
-				   "count and/or reply_len properly\n",
-				   old_hdr.reply_len - (int)SZ_SG_HEADER,
-				   input_size, (unsigned int) cmnd[0],
-				   current->comm);
-	}
-	k = sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
-	return (k < 0) ? k : count;
+			"%s: data in/out %d/%d bytes for SCSI command 0x%x-- guessing data in;\n"
+			"   program %s not setting count and/or reply_len properly\n",
+			__func__, ohp->reply_len - (int)SZ_SG_HEADER,
+			input_size, (unsigned int)cmnd[0], current->comm);
+	}
+	cwr.frq_bm[0] = 0;	/* initial state clear for all req flags */
+	cwr.h3p = h3p;
+	cwr.timeout = sfp->timeout;
+	cwr.cmnd = cmnd;
+	srp = sg_common_write(sfp, &cwr);
+	return (IS_ERR(srp)) ? PTR_ERR(srp) : (int)count;
 }
 
-static int
-sg_allow_access(struct file *filp, u8 *cmd)
+static inline int
+sg_chk_mmap(struct sg_fd *sfp, int rq_flags, int len)
 {
-	struct sg_fd *sfp = filp->private_data;
-
-	if (sfp->parentdp->device->type == TYPE_SCANNER)
-		return 0;
+	if (!list_empty(&sfp->rq_list))
+		return -EBUSY;  /* already active requests on fd */
+	if (len > sfp->rsv_srp->sgat_h.buflen)
+		return -ENOMEM; /* MMAP_IO size must fit in reserve */
+	if (rq_flags & SG_FLAG_DIRECT_IO)
+		return -EINVAL; /* not both MMAP_IO and DIRECT_IO */
+	return 0;
+}
 
-	return blk_verify_command(cmd, filp->f_mode);
+static int
+sg_fetch_cmnd(struct file *filp, struct sg_fd *sfp, const u8 __user *u_cdbp,
+	      int len, u8 *cdbp)
+{
+	if (!u_cdbp || len < 6 || len > SG_MAX_CDB_SIZE)
+		return -EMSGSIZE;
+	if (copy_from_user(cdbp, u_cdbp, len))
+		return -EFAULT;
+	if (O_RDWR != (filp->f_flags & O_ACCMODE)) {	/* read-only */
+		switch (sfp->parentdp->device->type) {
+		case TYPE_DISK:
+		case TYPE_RBC:
+		case TYPE_ZBC:
+			return blk_verify_command(cdbp, filp->f_mode);
+		default:	/* SSC, SES, etc cbd_s may differ from SBC */
+			break;
+		}
+	}
+	return 0;
 }
 
-static ssize_t
-sg_new_write(struct sg_fd *sfp, struct file *file, const char __user *buf,
-		 size_t count, int blocking, int read_only, int sg_io_owned,
-		 struct sg_request **o_srp)
+static int
+sg_submit(struct file *filp, struct sg_fd *sfp, struct sg_io_hdr *hp,
+	  bool sync, struct sg_request **o_srp)
 {
-	int k;
+	int res, timeout;
+	unsigned long ul_timeout;
 	struct sg_request *srp;
-	sg_io_hdr_t *hp;
+	struct sg_comm_wr_t cwr;
 	u8 cmnd[SG_MAX_CDB_SIZE];
-	int timeout;
-	unsigned long ul_timeout;
-
-	if (count < SZ_SG_IO_HDR)
-		return -EINVAL;
-	if (!access_ok(buf, count))
-		return -EFAULT; /* protects following copy_from_user()s + get_user()s */
 
-	sfp->cmd_q = 1;	/* when sg_io_hdr seen, set command queuing on */
-	if (!(srp = sg_add_request(sfp))) {
-		SG_LOG(1, sfp->parentdp, "%s: queue full\n", __func__);
-		return -EDOM;
-	}
-	srp->sg_io_owned = sg_io_owned;
-	hp = &srp->header;
-	if (__copy_from_user(hp, buf, SZ_SG_IO_HDR)) {
-		sg_remove_request(sfp, srp);
-		return -EFAULT;
-	}
-	if (hp->interface_id != 'S') {
-		sg_remove_request(sfp, srp);
-		return -ENOSYS;
-	}
+	/* now doing v3 blocking (sync) or non-blocking submission */
 	if (hp->flags & SG_FLAG_MMAP_IO) {
-		if (hp->dxfer_len > sfp->reserve.bufflen) {
-			sg_remove_request(sfp, srp);
-			return -ENOMEM;	/* MMAP_IO size must fit in reserve buffer */
-		}
-		if (hp->flags & SG_FLAG_DIRECT_IO) {
-			sg_remove_request(sfp, srp);
-			return -EINVAL;	/* either MMAP_IO or DIRECT_IO (not both) */
-		}
-		if (sfp->res_in_use) {
-			sg_remove_request(sfp, srp);
-			return -EBUSY;	/* reserve buffer already being used */
-		}
-	}
-	ul_timeout = msecs_to_jiffies(srp->header.timeout);
-	timeout = (ul_timeout < INT_MAX) ? ul_timeout : INT_MAX;
-	if ((!hp->cmdp) || (hp->cmd_len < 6) || (hp->cmd_len > sizeof (cmnd))) {
-		sg_remove_request(sfp, srp);
-		return -EMSGSIZE;
-	}
-	if (!access_ok(hp->cmdp, hp->cmd_len)) {
-		sg_remove_request(sfp, srp);
-		return -EFAULT;	/* protects following copy_from_user()s + get_user()s */
-	}
-	if (__copy_from_user(cmnd, hp->cmdp, hp->cmd_len)) {
-		sg_remove_request(sfp, srp);
-		return -EFAULT;
-	}
-	if (read_only && sg_allow_access(file, cmnd)) {
-		sg_remove_request(sfp, srp);
-		return -EPERM;
+		res = sg_chk_mmap(sfp, hp->flags, hp->dxfer_len);
+		if (res)
+			return res;
 	}
-	k = sg_common_write(sfp, srp, cmnd, timeout, blocking);
-	if (k < 0)
-		return k;
+	/* when v3 seen, allow cmd_q on this fd (def: no cmd_q) */
+	set_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
+	ul_timeout = msecs_to_jiffies(hp->timeout);
+	timeout = min_t(unsigned long, ul_timeout, INT_MAX);
+	res = sg_fetch_cmnd(filp, sfp, hp->cmdp, hp->cmd_len, cmnd);
+	if (res)
+		return res;
+	cwr.frq_bm[0] = 0;
+	assign_bit(SG_FRQ_SYNC_INVOC, cwr.frq_bm, (int)sync);
+	cwr.h3p = hp;
+	cwr.timeout = timeout;
+	cwr.cmnd = cmnd;
+	srp = sg_common_write(sfp, &cwr);
+	if (IS_ERR(srp))
+		return PTR_ERR(srp);
 	if (o_srp)
 		*o_srp = srp;
-	return count;
+	return 0;
 }
 
-static int
-sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
-		u8 *cmnd, int timeout, int blocking)
+/*
+ * All writes and submits converge on this function to launch the SCSI
+ * command/request (via blk_execute_rq_nowait). Returns a pointer to a
+ * sg_request object holding the request just issued or a negated errno
+ * value twisted by ERR_PTR.
+ */
+static struct sg_request *
+sg_common_write(struct sg_fd *sfp, struct sg_comm_wr_t *cwrp)
 {
-	int k, at_head;
+	bool at_head;
+	int res = 0;
+	int dxfr_len, dir, cmd_len;
+	int pack_id = SG_PACK_ID_WILDCARD;
+	u32 rq_flags;
 	struct sg_device *sdp = sfp->parentdp;
-	sg_io_hdr_t *hp = &srp->header;
-
-	srp->data.cmd_opcode = cmnd[0];	/* hold opcode of command */
-	hp->status = 0;
-	hp->masked_status = 0;
-	hp->msg_status = 0;
-	hp->info = 0;
-	hp->host_status = 0;
-	hp->driver_status = 0;
-	hp->resid = 0;
-	SG_LOG(4, sfp->parentdp, "%s:  opcode=0x%02x, cmd_sz=%d\n", __func__,
-	       (int)cmnd[0], hp->cmd_len);
-
-	if (hp->dxfer_len >= SZ_256M)
-		return -EINVAL;
-
-	k = sg_start_req(srp, cmnd);
-	if (k) {
-		SG_LOG(1, sfp->parentdp, "%s: start_req err=%d\n", __func__,
-		       k);
-		sg_finish_rem_req(srp);
-		sg_remove_request(sfp, srp);
-		return k;	/* probably out of space --> ENOMEM */
+	struct sg_request *srp;
+	struct sg_io_hdr *hi_p;
+
+	hi_p = cwrp->h3p;
+	dir = hi_p->dxfer_direction;
+	dxfr_len = hi_p->dxfer_len;
+	rq_flags = hi_p->flags;
+	pack_id = hi_p->pack_id;
+	if (dxfr_len >= SZ_256M)
+		return ERR_PTR(-EINVAL);
+
+	srp = sg_add_request(sfp, dxfr_len, cwrp);
+	if (IS_ERR(srp))
+		return srp;
+	srp->rq_flags = rq_flags;
+	srp->pack_id = pack_id;
+
+	cmd_len = hi_p->cmd_len;
+	memcpy(&srp->s_hdr3, hi_p, sizeof(srp->s_hdr3));
+	srp->cmd_opcode = cwrp->cmnd[0];/* hold opcode of command for debug */
+	SG_LOG(4, sdp, "%s: opcode=0x%02x, cdb_sz=%d, pack_id=%d\n", __func__,
+	       (int)cwrp->cmnd[0], cmd_len, pack_id);
+
+	res = sg_start_req(srp, cwrp->cmnd, cmd_len, dir);
+	if (res < 0)		/* probably out of space --> -ENOMEM */
+		goto err_out;
+	if (unlikely(atomic_read(&sdp->detaching))) {
+		res = -ENODEV;
+		goto err_out;
 	}
-	if (atomic_read(&sdp->detaching)) {
-		if (srp->bio) {
-			scsi_req_free_cmd(scsi_req(srp->rq));
-			blk_put_request(srp->rq);
-			srp->rq = NULL;
-		}
-
-		sg_finish_rem_req(srp);
-		sg_remove_request(sfp, srp);
-		return -ENODEV;
+	if (unlikely(test_bit(SG_FRQ_BLK_PUT_REQ, srp->frq_bm) || !srp->rq)) {
+		res = -EIDRM;	/* this failure unexpected but observed */
+		goto err_out;
 	}
-
-	hp->duration = jiffies_to_msecs(jiffies);
-	if (hp->interface_id != '\0' &&	/* v3 (or later) interface */
-	    (SG_FLAG_Q_AT_TAIL & hp->flags))
-		at_head = 0;
-	else
-		at_head = 1;
-
-	srp->rq->timeout = timeout;
+	srp->rq->timeout = cwrp->timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
+	srp->start_ns = ktime_get_boot_ns();
+	srp->duration = 0;
+
+	if (srp->s_hdr3.interface_id == '\0')
+		at_head = true; /* backward compatibility: v1+v2 interfaces */
+	else if (test_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm))
+	/* cmd flags can override sfd setting */
+		at_head = !!(srp->rq_flags & SG_FLAG_Q_AT_HEAD);
+	else            /* this sfd is defaulting to head */
+		at_head = !(srp->rq_flags & SG_FLAG_Q_AT_TAIL);
 	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
 			      srp->rq, at_head, sg_rq_end_io);
-	return 0;
+	return srp;
+err_out:
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return ERR_PTR(res);
 }
 
+static inline int
+sg_rstate_chg(struct sg_request *srp, enum sg_rq_state old_st,
+	      enum sg_rq_state new_st)
+{
+	enum sg_rq_state act_old_st = (enum sg_rq_state)
+				atomic_cmpxchg(&srp->rq_st, old_st, new_st);
+
+	if (act_old_st == old_st)
+		return 0;       /* implies new_st --> srp->rq_st */
+	else if (IS_ENABLED(CONFIG_SCSI_LOGGING))
+		sg_rep_rq_state_fail(srp->parentfp->parentdp, old_st, new_st,
+				     act_old_st);
+	return -EPROTOTYPE;
+}
 
 /*
  * read(2) related functions follow. They are shown after write(2) related
@@ -681,238 +817,309 @@ sg_common_write(struct sg_fd *sfp, struct sg_request *srp,
  * half of the ioctl(SG_IO) share code with read(2).
  */
 
-static struct sg_request *
-sg_get_rq_mark(struct sg_fd *sfp, int pack_id)
+/*
+ * This function is called by wait_event_interruptible in sg_read() and
+ * sg_ctl_ioreceive(). wait_event_interruptible will return if this one
+ * returns true (or an event like a signal (e.g. control-C) occurs).
+ */
+static inline bool
+sg_get_ready_srp(struct sg_fd *sfp, struct sg_request **srpp, int pack_id)
 {
-	struct sg_request *resp;
-	unsigned long iflags;
+	struct sg_request *srp;
 
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
-	list_for_each_entry(resp, &sfp->rq_list, entry) {
-		/* look for requests that are ready + not SG_IO owned */
-		if ((resp->done == 1) && (!resp->sg_io_owned) &&
-		    ((-1 == pack_id) || (resp->header.pack_id == pack_id))) {
-			resp->done = 2;	/* guard against other readers */
-			write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-			return resp;
-		}
+	if (unlikely(atomic_read(&sfp->parentdp->detaching))) {
+		*srpp = NULL;
+		return true;
 	}
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return NULL;
+	srp = sg_find_srp_by_id(sfp, pack_id);
+	*srpp = srp;
+	return !!srp;
 }
 
-static ssize_t
-sg_new_read(struct sg_fd *sfp, char __user *buf, size_t count,
-	    struct sg_request *srp)
+/*
+ * Returns number of bytes copied to user space provided sense buffer or
+ * negated errno value.
+ */
+static int
+sg_copy_sense(struct sg_request *srp)
 {
-	sg_io_hdr_t *hp = &srp->header;
-	int err = 0, err2;
-	int len;
-
-	if (count < SZ_SG_IO_HDR) {
-		err = -EINVAL;
-		goto err_out;
-	}
-	hp->sb_len_wr = 0;
-	if ((hp->mx_sb_len > 0) && hp->sbp) {
-		if ((CHECK_CONDITION & hp->masked_status) ||
-		    (DRIVER_SENSE & hp->driver_status)) {
-			int sb_len = SCSI_SENSE_BUFFERSIZE;
-
-			sb_len = (hp->mx_sb_len > sb_len) ? sb_len :
-							    hp->mx_sb_len;
+	int sb_len_wr = 0;
+	int scsi_stat;
+
+	/* If need be, copy the sense buffer to the user space */
+	scsi_stat = srp->rq_result & 0xff;
+	if ((scsi_stat & SAM_STAT_CHECK_CONDITION) ||
+	    (driver_byte(srp->rq_result) & DRIVER_SENSE)) {
+		int sb_len = min_t(int, SCSI_SENSE_BUFFERSIZE, srp->sense_len);
+		int mx_sb_len;
+		void __user *up;
+
+		up = (void __user *)srp->s_hdr3.sbp;
+		mx_sb_len = srp->s_hdr3.mx_sb_len;
+		if (up && mx_sb_len > 0 && srp->sense_bp) {
+			sb_len = min_t(int, sb_len, mx_sb_len);
 			/* Additional sense length field */
-			len = 8 + (int) srp->sense_b[7];
-			len = (len > sb_len) ? sb_len : len;
-			if (copy_to_user(hp->sbp, srp->sense_b, len)) {
-				err = -EFAULT;
-				goto err_out;
-			}
-			hp->sb_len_wr = len;
+			sb_len_wr = 8 + (int)srp->sense_bp[7];
+			sb_len_wr = min_t(int, sb_len, sb_len_wr);
+			if (copy_to_user(up, srp->sense_bp, sb_len_wr))
+				sb_len_wr = -EFAULT;
 		}
+		kfree(srp->sense_bp);
+		srp->sense_bp = NULL;
 	}
-	if (hp->masked_status || hp->host_status || hp->driver_status)
-		hp->info |= SG_INFO_CHECK;
-	if (copy_to_user(buf, hp, SZ_SG_IO_HDR)) {
-		err = -EFAULT;
-		goto err_out;
-	}
-err_out:
-	err2 = sg_finish_rem_req(srp);
-	sg_remove_request(sfp, srp);
-	return err ? : err2 ? : count;
+	return sb_len_wr;
 }
 
-static int
-srp_done(struct sg_fd *sfp, struct sg_request *srp)
+#if IS_ENABLED(CONFIG_SCSI_LOGGING)
+static void
+sg_rep_rq_state_fail(struct sg_device *sdp, enum sg_rq_state exp_old_st,
+		     enum sg_rq_state want_st, enum sg_rq_state act_old_st)
 {
-	unsigned long flags;
-	int ret;
+	const char *eors = "expected old rq_st: ";
+	const char *aors = "actual old rq_st: ";
 
-	read_lock_irqsave(&sfp->rq_list_lock, flags);
-	ret = srp->done;
-	read_unlock_irqrestore(&sfp->rq_list_lock, flags);
-	return ret;
+	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
+		SG_LOG(1, sdp, "%s: %s%s, %s%s, wanted rq_st: %s\n", __func__,
+		       eors, sg_rq_st_str(exp_old_st, false),
+		       aors, sg_rq_st_str(act_old_st, false),
+		       sg_rq_st_str(want_st, false));
+	else
+		pr_info("sg: %s: %s%d, %s%d, wanted rq_st: %d\n", __func__,
+			eors, (int)exp_old_st, aors, (int)act_old_st,
+			(int)want_st);
 }
-
-static ssize_t
-sg_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
+#else
+static void
+sg_rep_rq_state_fail(struct sg_device *sdp, enum sg_rq_state exp_old_st,
+		     enum sg_rq_state want_st, enum sg_rq_state act_old_st)
 {
-	struct sg_device *sdp;
-	struct sg_fd *sfp;
-	struct sg_request *srp;
-	int req_pack_id = -1;
-	sg_io_hdr_t *hp;
-	struct sg_header *old_hdr = NULL;
-	int retval = 0;
-
-	/*
-	 * This could cause a response to be stranded. Close the associated
-	 * file descriptor to free up any resources being held.
-	 */
-	retval = sg_check_file_access(filp, __func__);
-	if (retval)
-		return retval;
+}
+#endif
 
-	sfp = filp->private_data;
-	sdp = sfp->parentdp;
-	SG_LOG(3, sdp, "%s: read() count=%d\n", __func__, (int)count);
-	if (!sdp)
-		return -ENXIO;
+static int
+sg_rec_v3_state(struct sg_fd *sfp, struct sg_request *srp)
+{
+	int err = 0;
+	int sb_len_wr;
+	u32 rq_res = srp->rq_result;
+
+	sb_len_wr = sg_copy_sense(srp);
+	if (sb_len_wr < 0)
+		return sb_len_wr;
+	if (rq_res & SG_ML_RESULT_MSK)
+		srp->rq_info |= SG_INFO_CHECK;
+	if (unlikely(atomic_read(&sfp->parentdp->detaching)))
+		srp->rq_info |= SG_INFO_DEVICE_DETACHING;
+	return err;
+}
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
-	if (sfp->force_packid && (count >= SZ_SG_HEADER)) {
-		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
-		if (!old_hdr)
-			return -ENOMEM;
-		if (__copy_from_user(old_hdr, buf, SZ_SG_HEADER)) {
-			retval = -EFAULT;
-			goto free_old_hdr;
-		}
-		if (old_hdr->reply_len < 0) {
-			if (count >= SZ_SG_IO_HDR) {
-				sg_io_hdr_t *new_hdr;
-
-				new_hdr = kmalloc(SZ_SG_IO_HDR, GFP_KERNEL);
-				if (!new_hdr) {
-					retval = -ENOMEM;
-					goto free_old_hdr;
-				}
-				retval = __copy_from_user
-				    (new_hdr, buf, SZ_SG_IO_HDR);
-				req_pack_id = new_hdr->pack_id;
-				kfree(new_hdr);
-				if (retval) {
-					retval = -EFAULT;
-					goto free_old_hdr;
-				}
-			}
-		} else
-			req_pack_id = old_hdr->pack_id;
-	}
-	srp = sg_get_rq_mark(sfp, req_pack_id);
-	if (!srp) {		/* now wait on packet to arrive */
-		if (atomic_read(&sdp->detaching)) {
-			retval = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (filp->f_flags & O_NONBLOCK) {
-			retval = -EAGAIN;
-			goto free_old_hdr;
-		}
-		retval = wait_event_interruptible(sfp->read_wait,
-			(atomic_read(&sdp->detaching) ||
-			(srp = sg_get_rq_mark(sfp, req_pack_id))));
-		if (atomic_read(&sdp->detaching)) {
-			retval = -ENODEV;
-			goto free_old_hdr;
-		}
-		if (retval) {
-			/* -ERESTARTSYS as signal hit process */
-			goto free_old_hdr;
-		}
-	}
-	if (srp->header.interface_id != '\0') {
-		retval = sg_new_read(sfp, buf, count, srp);
-		goto free_old_hdr;
-	}
+/*
+ * Completes a v3 request/command. Called from sg_read {v2 or v3},
+ * ioctl(SG_IO) {for v3}, or from ioctl(SG_IORECEIVE) when its
+ * completing a v3 request/command.
+ */
+static int
+sg_v3_receive(struct sg_fd *sfp, struct sg_request *srp, void __user *p)
+{
+	int err, err2;
+	int rq_result = srp->rq_result;
+	struct sg_io_hdr hdr3;
+	struct sg_io_hdr *hp = &hdr3;
+
+	SG_LOG(3, sfp->parentdp, "%s: srp=0x%p\n", __func__, srp);
+	err = sg_rec_v3_state(sfp, srp);
+	memset(hp, 0, sizeof(*hp));
+	memcpy(hp, &srp->s_hdr3, sizeof(srp->s_hdr3));
+	hp->sb_len_wr = srp->sense_len;
+	hp->info = srp->rq_info;
+	hp->resid = srp->in_resid;
+	hp->duration = srp->duration;
+	hp->status = rq_result & 0xff;
+	hp->masked_status = status_byte(rq_result);
+	hp->msg_status = msg_byte(rq_result);
+	hp->host_status = host_byte(rq_result);
+	hp->driver_status = driver_byte(rq_result);
+	/* copy_*_user() [without leading underscores] checks access */
+	if (copy_to_user(p, hp, SZ_SG_IO_HDR))
+		err = err ? err : -EFAULT;
+	err2 = sg_rstate_chg(srp, atomic_read(&srp->rq_st), SG_RS_DONE_RD);
+	if (err2)
+		err = err ? err : err2;
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return err ? err : 0;
+}
 
-	hp = &srp->header;
-	if (old_hdr == NULL) {
-		old_hdr = kmalloc(SZ_SG_HEADER, GFP_KERNEL);
-		if (!old_hdr) {
-			retval = -ENOMEM;
-			goto free_old_hdr;
+static int
+sg_rd_v1v2(void __user *buf, int count, struct sg_fd *sfp,
+	   struct sg_request *srp)
+{
+	int res = 0;
+	u32 rq_result = srp->rq_result;
+	struct sg_header *h2p;
+	struct sg_slice_hdr3 *sh3p;
+	struct sg_header a_v2hdr;
+
+	h2p = &a_v2hdr;
+	memset(h2p, 0, SZ_SG_HEADER);
+	sh3p = &srp->s_hdr3;
+	h2p->reply_len = (int)sh3p->timeout;
+	h2p->pack_len = h2p->reply_len; /* old, strange behaviour */
+	h2p->pack_id = sh3p->pack_id;
+	h2p->twelve_byte = (srp->cmd_opcode >= 0xc0 && sh3p->cmd_len == 12);
+	h2p->target_status = status_byte(rq_result);
+	h2p->host_status = host_byte(rq_result);
+	h2p->driver_status = driver_byte(rq_result);
+	if ((CHECK_CONDITION & status_byte(rq_result)) ||
+	    (DRIVER_SENSE & driver_byte(rq_result))) {
+		if (srp->sense_bp) {
+			memcpy(h2p->sense_buffer, srp->sense_bp,
+			       sizeof(h2p->sense_buffer));
+			kfree(srp->sense_bp);
+			srp->sense_bp = NULL;
 		}
 	}
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
+	switch (host_byte(rq_result)) {
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
+		h2p->result = (srp->sense_bp &&
+				status_byte(rq_result) == GOOD) ? 0 : EIO;
 		break;
 	default:
-		old_hdr->result = EIO;
+		h2p->result = EIO;
 		break;
 	}
 
 	/* Now copy the result back to the user buffer.  */
 	if (count >= SZ_SG_HEADER) {
-		if (__copy_to_user(buf, old_hdr, SZ_SG_HEADER)) {
-			retval = -EFAULT;
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
-				retval = -EFAULT;
-				goto free_old_hdr;
-			}
+			if (sg_rd_append(srp, buf, count - SZ_SG_HEADER))
+				return -EFAULT;
 		}
 	} else
-		count = (old_hdr->result == 0) ? 0 : -EIO;
-	sg_finish_rem_req(srp);
-	sg_remove_request(sfp, srp);
-	retval = count;
-free_old_hdr:
-	kfree(old_hdr);
-	return retval;
+		res = (h2p->result == 0) ? 0 : -EIO;
+	atomic_set(&srp->rq_st, SG_RS_DONE_RD);
+	sg_finish_scsi_blk_rq(srp);
+	sg_deact_request(sfp, srp);
+	return res;
+}
+
+/*
+ * This is the read(2) system call entry point (see sg_fops) for this driver.
+ * Accepts v1, v2 or v3 type headers (not v4). Returns count or negated
+ * errno; if count is 0 then v3: returns -EINVAL; v1+v2: 0 when no other
+ * error detected or -EIO.
+ */
+static ssize_t
+sg_read(struct file *filp, char __user *p, size_t count, loff_t *ppos)
+{
+	bool could_be_v3;
+	bool non_block = !!(filp->f_flags & O_NONBLOCK);
+	int want_id = SG_PACK_ID_WILDCARD;
+	int hlen, ret;
+	struct sg_device *sdp = NULL;
+	struct sg_fd *sfp;
+	struct sg_request *srp = NULL;
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
+	SG_LOG(3, sdp, "%s: read() count=%d\n", __func__, (int)count);
+	ret = sg_allow_if_err_recovery(sdp, non_block);
+	if (ret)
+		return ret;
+	if (unlikely(atomic_read(&sdp->detaching)))
+		return -ENODEV;
+
+	could_be_v3 = (count >= SZ_SG_IO_HDR);
+	hlen = could_be_v3 ? SZ_SG_IO_HDR : SZ_SG_HEADER;
+	h2p = (struct sg_header *)&a_sg_io_hdr;
+
+	if (test_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm) && (int)count >= hlen) {
+		/*
+		 * Even though this is a user space read() system call, this
+		 * code is cheating to fetch the pack_id.
+		 * Only need first three 32 bit ints to determine interface.
+		 */
+		if (copy_from_user(h2p, p, 3 * sizeof(int)))
+			return -EFAULT;
+		if (h2p->reply_len < 0 && could_be_v3) {
+			struct sg_io_hdr *v3_hdr = (struct sg_io_hdr *)h2p;
+
+			if (v3_hdr->interface_id == 'S') {/* v3, new sanity */
+				struct sg_io_hdr __user *h3_up;
+
+				h3_up = (struct sg_io_hdr __user *)p;
+				ret = get_user(want_id, &h3_up->pack_id);
+				if (ret)
+					return ret;
+			} else {
+				return -EPERM;
+			}
+		} else { /* for v1+v2 interfaces, this is the 3rd integer */
+			want_id = h2p->pack_id;
+		}
+	}
+	srp = sg_find_srp_by_id(sfp, want_id);
+	if (!srp) {     /* nothing available so wait on packet to arrive or */
+		if (unlikely(atomic_read(&sdp->detaching)))
+			return -ENODEV;
+		if (non_block) /* O_NONBLOCK or v3::flags & SGV4_FLAG_IMMED */
+			return -EAGAIN;
+		ret = wait_event_interruptible(sfp->read_wait,
+					       sg_get_ready_srp(sfp, &srp,
+								want_id));
+		if (unlikely(atomic_read(&sdp->detaching)))
+			return -ENODEV;
+		if (ret)	/* -ERESTARTSYS as signal hit process */
+			return ret;
+		/* otherwise srp should be valid */
+	}
+	if (srp->s_hdr3.interface_id == '\0') {
+		ret = sg_rd_v1v2(p, (int)count, sfp, srp);
+	} else {
+		if ((int)count < SZ_SG_IO_HDR)
+			return -EINVAL;
+		ret = sg_v3_receive(sfp, srp, p);
+	}
+	if (ret < 0)
+		SG_LOG(1, sdp, "%s: negated errno: %d\n", __func__, ret);
+	return ret < 0 ? ret : (int)count;
 }
 
 static int
@@ -921,289 +1128,573 @@ max_sectors_bytes(struct request_queue *q)
 	unsigned int max_sectors = queue_max_sectors(q);
 
 	max_sectors = min_t(unsigned int, max_sectors, INT_MAX >> 9);
-
 	return max_sectors << 9;
 }
 
+/*
+ * Calculates sg_device::max_sgat_elems and sg_device::max_sgat_sz. It uses
+ * the device's request queue. If q not available sets max_sgat_elems to 1
+ * and max_sgat_sz to PAGE_SIZE. If potential max_sgat_sz is greater than
+ * 2^30 scales down the implied max_segment_size so the product of the
+ * max_segment_size and max_sgat_elems is less than or equal to 2^30 .
+ */
 static void
-sg_fill_request_table(struct sg_fd *sfp, struct sg_req_info *rinfo)
+sg_calc_sgat_param(struct sg_device *sdp)
 {
-	struct sg_request *srp;
-	int val;
-	unsigned int ms;
+	int sz;
+	u64 m;
+	struct scsi_device *sdev = sdp->device;
+	struct request_queue *q = sdev ? sdev->request_queue : NULL;
+
+	if (!q) {
+		sdp->max_sgat_elems = 1;
+		sdp->max_sgat_sz = PAGE_SIZE;
+		return;
+	}
+	sdp->max_sgat_elems = queue_max_segments(q);
+	m = (u64)queue_max_segment_size(q) * queue_max_segments(q);
+	if (m < PAGE_SIZE) {
+		sdp->max_sgat_elems = 1;
+		sdp->max_sgat_sz = PAGE_SIZE;
+		return;
+	}
+	sz = (int)min_t(u64, m, 1 << 30);
+	if (sz == (1 << 30))	/* round down so: sz = elems * elem_sz */
+		sz = ((1 << 30) / sdp->max_sgat_elems) * sdp->max_sgat_elems;
+	sdp->max_sgat_sz = sz;
+}
 
-	val = 0;
-	list_for_each_entry(srp, &sfp->rq_list, entry) {
-		if (val >= SG_MAX_QUEUE)
+static u32
+sg_calc_rq_dur(const struct sg_request *srp)
+{
+	ktime_t ts0 = srp->start_ns;
+	ktime_t now_ts;
+	s64 diff;
+
+	if (ts0 == 0)
+		return 0;
+	if (unlikely(ts0 == U64_MAX))	/* _prior_ to issuing req */
+		return 999999999;	/* eye catching */
+	now_ts = ktime_get_boot_ns();
+	if (unlikely(ts0 > now_ts))
+		return 999999998;
+	/* unlikely req duration will exceed 2**32 milliseconds */
+	diff = ktime_ms_delta(now_ts, ts0);
+	return (diff > (s64)U32_MAX) ? 3999999999U : (u32)diff;
+}
+
+/* Return of U32_MAX means srp is inactive or in slave waiting state */
+static u32
+sg_get_dur(struct sg_request *srp, const enum sg_rq_state *sr_stp,
+	   bool *is_durp)
+{
+	bool is_dur = false;
+	u32 res = U32_MAX;
+
+	switch (sr_stp ? *sr_stp : atomic_read(&srp->rq_st)) {
+	case SG_RS_INFLIGHT:
+	case SG_RS_BUSY:
+		res = sg_calc_rq_dur(srp);
+		break;
+	case SG_RS_AWAIT_RD:
+	case SG_RS_DONE_RD:
+		res = srp->duration;
+		is_dur = true;	/* completion has occurred, timing finished */
+		break;
+	case SG_RS_INACTIVE:
+	default:
+		break;
+	}
+	if (is_durp)
+		*is_durp = is_dur;
+	return res;
+}
+
+static void
+sg_fill_request_element(struct sg_fd *sfp, struct sg_request *srp,
+			struct sg_req_info *rip)
+		__must_hold(&sfp->rq_list_lock)
+{
+	spin_lock(&srp->req_lck);
+	rip->duration = sg_get_dur(srp, NULL, NULL);
+	if (rip->duration == U32_MAX)
+		rip->duration = 0;
+	rip->orphan = test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm);
+	rip->sg_io_owned = test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
+	rip->problem = !!(srp->rq_result & SG_ML_RESULT_MSK);
+	rip->pack_id = srp->pack_id;
+	rip->usr_ptr = srp->s_hdr3.usr_ptr;
+	spin_unlock(&srp->req_lck);
+}
+
+static inline bool
+sg_rq_landed(struct sg_device *sdp, struct sg_request *srp)
+{
+	return atomic_read(&srp->rq_st) != SG_RS_INFLIGHT ||
+	       unlikely(atomic_read(&sdp->detaching));
+}
+
+/*
+ * This is a blocking wait for a specific srp. When h4p is non-NULL, it is
+ * the blocking multiple request case
+ */
+static int
+sg_wait_event_srp(struct file *filp, struct sg_fd *sfp, void __user *p,
+		  struct sg_request *srp)
+{
+	int res;
+	enum sg_rq_state sr_st;
+	struct sg_device *sdp = sfp->parentdp;
+
+	SG_LOG(3, sdp, "%s: about to wait_event...()\n", __func__);
+	/* usually will be woken up by sg_rq_end_io() callback */
+	res = wait_event_interruptible(sfp->read_wait,
+				       sg_rq_landed(sdp, srp));
+	if (unlikely(res)) { /* -ERESTARTSYS because signal hit thread */
+		set_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm);
+		/* orphans harvested when sfp->keep_orphan is false */
+		atomic_set(&srp->rq_st, SG_RS_INFLIGHT);
+		SG_LOG(1, sdp, "%s:  wait_event_interruptible gave %d\n",
+		       __func__, res);
+		return res;
+	}
+	if (unlikely(atomic_read(&sdp->detaching))) {
+		atomic_set(&srp->rq_st, SG_RS_INACTIVE);
+		return -ENODEV;
+	}
+	sr_st = atomic_read(&srp->rq_st);
+	if (unlikely(sr_st != SG_RS_AWAIT_RD))
+		return -EPROTO;         /* Logic error */
+	res = sg_rstate_chg(srp, sr_st, SG_RS_BUSY);
+	if (unlikely(res))
+		return res;
+	res = sg_v3_receive(sfp, srp, p);
+	return (res < 0) ? res : 0;
+}
+
+/*
+ * Handles ioctl(SG_IO) for blocking (sync) usage of v3 or v4 interface.
+ * Returns 0 on success else a negated errno.
+ */
+static int
+sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
+	     void __user *p)
+{
+	int res;
+	struct sg_request *srp = NULL;
+	u8 hu8arr[SZ_SG_IO_HDR];
+	struct sg_io_hdr *h3p = (struct sg_io_hdr *)hu8arr;
+
+	SG_LOG(3, sdp, "%s:  SG_IO%s\n", __func__,
+	       ((filp->f_flags & O_NONBLOCK) ? " O_NONBLOCK ignored" : ""));
+	res = sg_allow_if_err_recovery(sdp, false);
+	if (res)
+		return res;
+	if (atomic_read(&sdp->detaching))
+		return -ENODEV;
+	if (copy_from_user(h3p, p, SZ_SG_IO_HDR))
+		return -EFAULT;
+	if (h3p->interface_id == 'S')
+		res = sg_submit(filp, sfp, h3p, true, &srp);
+	else
+		return -EPERM;
+	if (unlikely(res < 0))
+		return res;
+	if (!srp)	/* mrq case: already processed all responses */
+		return res;
+	res = sg_wait_event_srp(filp, sfp, p, srp);
+	if (res) {
+		SG_LOG(1, sdp, "%s: %s=0x%p  state: %s\n", __func__,
+		       "unexpected srp", srp,
+		       sg_rq_st_str(atomic_read(&srp->rq_st), false));
+	}
+	return res;
+}
+
+/*
+ * First normalize want_rsv_sz to be >= sfp->sgat_elem_sz and
+ * <= max_segment_size. Exit if that is the same as old size; otherwise
+ * create a new candidate request of the new size. Then decide whether to
+ * re-use an existing free list request (least buflen >= required size) or
+ * use the new candidate. If new one used, leave old one but it is no longer
+ * the reserved request. Returns 0 on success, else a negated errno value.
+ */
+static int
+sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
+	__must_hold(&sfp->f_mutex)
+{
+	bool use_new_srp = false;
+	int res = 0;
+	int new_sz, blen;
+	unsigned long iflags;
+	struct sg_request *o_srp;       /* prior reserve sg_request */
+	struct sg_request *n_srp;       /* new sg_request, may be used */
+	struct sg_request *t_srp;       /* other fl entries */
+	struct sg_device *sdp = sfp->parentdp;
+
+	rcu_read_lock();
+	o_srp = sfp->rsv_srp;
+	if (!o_srp) {
+		rcu_read_unlock();
+		return -EPROTO;
+	}
+	new_sz = min_t(int, want_rsv_sz, sdp->max_sgat_sz);
+	new_sz = max_t(int, new_sz, sfp->sgat_elem_sz);
+	blen = o_srp->sgat_h.buflen;
+	rcu_read_unlock();
+	SG_LOG(3, sdp, "%s: was=%d, ask=%d, new=%d (sgat_elem_sz=%d)\n",
+	       __func__, blen, want_rsv_sz, new_sz, sfp->sgat_elem_sz);
+	if (blen == new_sz)
+		return 0;
+	n_srp = sg_mk_srp_sgat(sfp, true /* can take time */, new_sz);
+	if (IS_ERR(n_srp))
+		return PTR_ERR(n_srp);
+	/* new sg_request object, sized correctly is now available */
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	o_srp = sfp->rsv_srp;
+	if (!o_srp) {
+		res = -EPROTO;
+		goto wr_unlock;
+	}
+	if (SG_RS_ACTIVE(o_srp) ||
+	    test_bit(SG_FFD_MMAP_CALLED, sfp->ffd_bm)) {
+		res = -EBUSY;
+		goto wr_unlock;
+	}
+	use_new_srp = true;
+	list_for_each_entry(t_srp, &sfp->rq_fl, fl_entry) {
+		if (t_srp != o_srp && new_sz <= t_srp->sgat_h.buflen &&
+		    !SG_RS_ACTIVE(t_srp)) {
+			/* good candidate on free list, use */
+			use_new_srp = false;
+			sfp->rsv_srp = t_srp;
 			break;
-		rinfo[val].req_state = srp->done + 1;
-		rinfo[val].problem =
-			srp->header.masked_status &
-			srp->header.host_status &
-			srp->header.driver_status;
-		if (srp->done)
-			rinfo[val].duration =
-				srp->header.duration;
-		else {
-			ms = jiffies_to_msecs(jiffies);
-			rinfo[val].duration =
-				(ms > srp->header.duration) ?
-				(ms - srp->header.duration) : 0;
 		}
-		rinfo[val].orphan = srp->orphan;
-		rinfo[val].sg_io_owned = srp->sg_io_owned;
-		rinfo[val].pack_id = srp->header.pack_id;
-		rinfo[val].usr_ptr = srp->header.usr_ptr;
-		val++;
 	}
+	if (use_new_srp) {
+		sfp->rsv_srp = n_srp;
+		/* add to front of free list */
+		list_add_rcu(&n_srp->fl_entry, &sfp->rq_fl);
+		SG_LOG(6, sdp, "%s: new rsv srp=0x%p ++\n", __func__, n_srp);
+	}
+wr_unlock:
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	if (!use_new_srp) {
+		sg_remove_sgat(n_srp);
+		kfree(n_srp);   /* no-one else has seen n_srp, so safe */
+	}
+	return res;
+}
+
+/*
+ * For backward compatibility, output SG_MAX_QUEUE sg_req_info objects. First
+ * fetch from the active list then, if there is still room, from the free
+ * list. Some of the trailing elements may be empty which is indicated by all
+ * fields being zero. Any requests beyond SG_MAX_QUEUE are ignored.
+ */
+static int
+sg_ctl_req_tbl(struct sg_fd *sfp, void __user *p)
+{
+	int k, len, result, val, n;
+	struct sg_request *srp;
+	struct sg_req_info *rinfop;
+	struct sg_req_info *rip;
+
+	SG_LOG(3, sfp->parentdp, "%s:    SG_GET_REQUEST_TABLE\n", __func__);
+	k = SG_MAX_QUEUE;
+	len = SZ_SG_REQ_INFO * k;
+	rinfop = kcalloc(k, SZ_SG_REQ_INFO, GFP_KERNEL);
+	if (!rinfop)
+		return -ENOMEM;
+	val = 0;
+	rcu_read_lock();
+	list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry)
+		++val;
+
+	if (val > 0) {
+		int max_num = min_t(int, k, val);
+
+		n = 0;
+		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+			if (n >= max_num)
+				break;
+			rip = &rinfop[n];
+			sg_fill_request_element(sfp, srp, rip);
+			n++;
+		}
+		list_for_each_entry_rcu(srp, &sfp->rq_fl, fl_entry) {
+			if (n >= max_num)
+				break;
+			rip = &rinfop[n];
+			sg_fill_request_element(sfp, srp, rip);
+			n++;
+		}
+	}
+	rcu_read_unlock();
+	result = copy_to_user(p, rinfop, len);
+	result = result ? -EFAULT : 0;
+	kfree(rinfop);
+	return result;
+}
+
+static int
+sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_device *sdp, void __user *p)
+{
+	struct sg_scsi_id __user *sg_idp = p;
+
+	SG_LOG(3, sdp, "%s:    SG_GET_SCSI_ID\n", __func__);
+	if (!access_ok(p, sizeof(struct sg_scsi_id)))
+		return -EFAULT;
+
+	if (unlikely(atomic_read(&sdp->detaching)))
+		return -ENODEV;
+	__put_user((int)sdev->host->host_no,
+		   &sg_idp->host_no);
+	__put_user((int)sdev->channel, &sg_idp->channel);
+	__put_user((int)sdev->id, &sg_idp->scsi_id);
+	__put_user((int)sdev->lun, &sg_idp->lun);
+	__put_user((int)sdev->type, &sg_idp->scsi_type);
+	__put_user((short)sdev->host->cmd_per_lun,
+		   &sg_idp->h_cmd_per_lun);
+	__put_user((short)sdev->queue_depth,
+		   &sg_idp->d_queue_depth);
+	__put_user(0, &sg_idp->unused[0]);
+	__put_user(0, &sg_idp->unused[1]);
+	return 0;
 }
 
 static long
 sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 {
-	void __user *p = (void __user *)arg;
+	bool read_only = O_RDWR != (filp->f_flags & O_ACCMODE);
+	bool check_detach = false;
+	int val;
+	int result = 0;
+	void __user *p = uptr64(arg);
 	int __user *ip = p;
-	int result, val, read_only;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
 	struct sg_request *srp;
-	unsigned long iflags;
+	struct scsi_device *sdev;
+	__maybe_unused const char *pmlp = ", pass to mid-level";
 
 	sfp = filp->private_data;
 	sdp = sfp->parentdp;
-	if (!sdp)
-		return -ENXIO;
 	SG_LOG(6, sdp, "%s: cmd=0x%x, O_NONBLOCK=%d\n", __func__, cmd_in,
 	       !!(filp->f_flags & O_NONBLOCK));
-	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
+	if (!sdp)
+		return -ENXIO;
+	if (unlikely(atomic_read(&sdp->detaching)))
+		return -ENODEV;
+	sdev = sdp->device;
 
 	switch (cmd_in) {
 	case SG_IO:
-		if (atomic_read(&sdp->detaching))
-			return -ENODEV;
-		if (!scsi_block_when_processing_errors(sdp->device))
-			return -ENXIO;
-		if (!access_ok(p, SZ_SG_IO_HDR))
-			return -EFAULT;
-		result = sg_new_write(sfp, filp, p, SZ_SG_IO_HDR,
-				 1, read_only, 1, &srp);
-		if (result < 0)
-			return result;
-		result = wait_event_interruptible(sfp->read_wait,
-			(srp_done(sfp, srp) || atomic_read(&sdp->detaching)));
-		if (atomic_read(&sdp->detaching))
-			return -ENODEV;
-		write_lock_irq(&sfp->rq_list_lock);
-		if (srp->done) {
-			srp->done = 2;
-			write_unlock_irq(&sfp->rq_list_lock);
-			result = sg_new_read(sfp, p, SZ_SG_IO_HDR, srp);
-			return (result < 0) ? result : 0;
-		}
-		srp->orphan = 1;
-		write_unlock_irq(&sfp->rq_list_lock);
-		return result;	/* -ERESTARTSYS because signal hit process */
-	case SG_SET_TIMEOUT:
-		result = get_user(val, ip);
-		if (result)
-			return result;
-		if (val < 0)
-			return -EIO;
-		if (val >= mult_frac((s64)INT_MAX, USER_HZ, HZ))
-			val = min_t(s64, mult_frac((s64)INT_MAX, USER_HZ, HZ),
-				    INT_MAX);
-		sfp->timeout_user = val;
-		sfp->timeout = mult_frac(val, HZ, USER_HZ);
-
-		return 0;
-	case SG_GET_TIMEOUT:	/* N.B. User receives timeout as return value */
-				/* strange ..., for backward compatibility */
-		return sfp->timeout_user;
-	case SG_SET_FORCE_LOW_DMA:
-		/*
-		 * N.B. This ioctl never worked properly, but failed to
-		 * return an error value. So returning '0' to keep compability
-		 * with legacy applications.
-		 */
-		return 0;
-	case SG_GET_LOW_DMA:
-		return put_user((int) sdp->device->host->unchecked_isa_dma, ip);
+		return sg_ctl_sg_io(filp, sdp, sfp, p);
 	case SG_GET_SCSI_ID:
-		if (!access_ok(p, sizeof (sg_scsi_id_t)))
-			return -EFAULT;
-		else {
-			sg_scsi_id_t __user *sg_idp = p;
-
-			if (atomic_read(&sdp->detaching))
-				return -ENODEV;
-			__put_user((int) sdp->device->host->host_no,
-				   &sg_idp->host_no);
-			__put_user((int) sdp->device->channel,
-				   &sg_idp->channel);
-			__put_user((int) sdp->device->id, &sg_idp->scsi_id);
-			__put_user((int) sdp->device->lun, &sg_idp->lun);
-			__put_user((int) sdp->device->type, &sg_idp->scsi_type);
-			__put_user((short) sdp->device->host->cmd_per_lun,
-				   &sg_idp->h_cmd_per_lun);
-			__put_user((short) sdp->device->queue_depth,
-				   &sg_idp->d_queue_depth);
-			__put_user(0, &sg_idp->unused[0]);
-			__put_user(0, &sg_idp->unused[1]);
-			return 0;
-		}
+		return sg_ctl_scsi_id(sdev, sdp, p);
 	case SG_SET_FORCE_PACK_ID:
+		SG_LOG(3, sdp, "%s:    SG_SET_FORCE_PACK_ID\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
-		sfp->force_packid = val ? 1 : 0;
+		assign_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm, !!val);
 		return 0;
-	case SG_GET_PACK_ID:
-		if (!access_ok(ip, sizeof (int)))
-			return -EFAULT;
-		read_lock_irqsave(&sfp->rq_list_lock, iflags);
-		list_for_each_entry(srp, &sfp->rq_list, entry) {
-			if ((1 == srp->done) && (!srp->sg_io_owned)) {
-				read_unlock_irqrestore(&sfp->rq_list_lock,
-						       iflags);
-				__put_user(srp->header.pack_id, ip);
-				return 0;
+	case SG_GET_PACK_ID:    /* or tag of oldest "read"-able, -1 if none */
+		rcu_read_lock();
+		val = -1;
+		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+			if (SG_RS_AWAIT_READ(srp) &&
+			    !test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm)) {
+				val = srp->pack_id;
+				break;
 			}
 		}
-		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-		__put_user(-1, ip);
-		return 0;
+		rcu_read_unlock();
+		SG_LOG(3, sdp, "%s:    SG_GET_PACK_ID=%d\n", __func__, val);
+		return put_user(val, ip);
 	case SG_GET_NUM_WAITING:
-		read_lock_irqsave(&sfp->rq_list_lock, iflags);
-		val = 0;
-		list_for_each_entry(srp, &sfp->rq_list, entry) {
-			if ((1 == srp->done) && (!srp->sg_io_owned))
-				++val;
-		}
-		read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+		/* SG_GET_NUM_WAITING + num_inflight == SG_SEIRV_SUBMITTED */
+		val = atomic_read(&sfp->waiting);
+		SG_LOG(3, sdp, "%s:    SG_GET_NUM_WAITING=%d\n", __func__,
+		       val);
 		return put_user(val, ip);
 	case SG_GET_SG_TABLESIZE:
-		return put_user(sdp->sg_tablesize, ip);
+		SG_LOG(3, sdp, "%s:    SG_GET_SG_TABLESIZE=%d\n", __func__,
+		       sdp->max_sgat_elems);
+		return put_user(sdp->max_sgat_elems, ip);
 	case SG_SET_RESERVED_SIZE:
-		result = get_user(val, ip);
-		if (result)
-			return result;
-                if (val < 0)
-                        return -EINVAL;
-		val = min_t(int, val,
-			    max_sectors_bytes(sdp->device->request_queue));
 		mutex_lock(&sfp->f_mutex);
-		if (val != sfp->reserve.bufflen) {
-			if (sfp->mmap_called ||
-			    sfp->res_in_use) {
-				mutex_unlock(&sfp->f_mutex);
-				return -EBUSY;
+		result = get_user(val, ip);
+		if (!result) {
+			if (val >= 0 && val <= (1024 * 1024 * 1024)) {
+				result = sg_set_reserved_sz(sfp, val);
+			} else {
+				SG_LOG(3, sdp, "%s: invalid size\n", __func__);
+				result = -EINVAL;
 			}
-
-			sg_remove_scat(sfp, &sfp->reserve);
-			sg_build_reserve(sfp, val);
 		}
 		mutex_unlock(&sfp->f_mutex);
-		return 0;
+		return result;
 	case SG_GET_RESERVED_SIZE:
-		val = min_t(int, sfp->reserve.bufflen,
-			    max_sectors_bytes(sdp->device->request_queue));
-		return put_user(val, ip);
+		mutex_lock(&sfp->f_mutex);
+		val = min_t(int, sfp->rsv_srp->sgat_h.buflen,
+			    sdp->max_sgat_sz);
+		SG_LOG(3, sdp, "%s:    SG_GET_RESERVED_SIZE=%d\n",
+		       __func__, val);
+		result = put_user(val, ip);
+		mutex_unlock(&sfp->f_mutex);
+		return result;
 	case SG_SET_COMMAND_Q:
+		SG_LOG(3, sdp, "%s:    SG_SET_COMMAND_Q\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
-		sfp->cmd_q = val ? 1 : 0;
+		assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, !!val);
 		return 0;
 	case SG_GET_COMMAND_Q:
-		return put_user((int) sfp->cmd_q, ip);
+		SG_LOG(3, sdp, "%s:    SG_GET_COMMAND_Q\n", __func__);
+		return put_user(test_bit(SG_FFD_CMD_Q, sfp->ffd_bm), ip);
 	case SG_SET_KEEP_ORPHAN:
+		SG_LOG(3, sdp, "%s:    SG_SET_KEEP_ORPHAN\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
-		sfp->keep_orphan = val;
+		assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, !!val);
 		return 0;
 	case SG_GET_KEEP_ORPHAN:
-		return put_user((int) sfp->keep_orphan, ip);
-	case SG_NEXT_CMD_LEN:
+		SG_LOG(3, sdp, "%s:    SG_GET_KEEP_ORPHAN\n", __func__);
+		return put_user(test_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm),
+				ip);
+	case SG_GET_VERSION_NUM:
+		SG_LOG(3, sdp, "%s:    SG_GET_VERSION_NUM\n", __func__);
+		return put_user(sg_version_num, ip);
+	case SG_GET_REQUEST_TABLE:
+		return sg_ctl_req_tbl(sfp, p);
+	case SG_SCSI_RESET:
+		SG_LOG(3, sdp, "%s:    SG_SCSI_RESET\n", __func__);
+		check_detach = true;
+		break;
+	case SG_SET_TIMEOUT:
+		SG_LOG(3, sdp, "%s:    SG_SET_TIMEOUT\n", __func__);
+		result = get_user(val, ip);
+		if (result)
+			return result;
+		if (val < 0)
+			return -EIO;
+		if (val >= mult_frac((s64)INT_MAX, USER_HZ, HZ))
+			val = min_t(s64, mult_frac((s64)INT_MAX, USER_HZ, HZ),
+				    INT_MAX);
+		sfp->timeout_user = val;
+		sfp->timeout = mult_frac(val, HZ, USER_HZ);
+		return 0;
+	case SG_GET_TIMEOUT:    /* N.B. User receives timeout as return value */
+				/* strange ..., for backward compatibility */
+		SG_LOG(3, sdp, "%s:    SG_GET_TIMEOUT\n", __func__);
+		return sfp->timeout_user;
+	case SG_SET_FORCE_LOW_DMA:
+		/*
+		 * N.B. This ioctl never worked properly, but failed to
+		 * return an error value. So returning '0' to keep
+		 * compatibility with legacy applications.
+		 */
+		SG_LOG(3, sdp, "%s:    SG_SET_FORCE_LOW_DMA\n", __func__);
+		return 0;
+	case SG_GET_LOW_DMA:
+		SG_LOG(3, sdp, "%s:    SG_GET_LOW_DMA\n", __func__);
+		return put_user((int)sdev->host->unchecked_isa_dma, ip);
+	case SG_NEXT_CMD_LEN:   /* active only in v2 interface */
+		SG_LOG(3, sdp, "%s:    SG_NEXT_CMD_LEN\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
 		if (val > SG_MAX_CDB_SIZE)
 			return -ENOMEM;
-		sfp->next_cmd_len = (val > 0) ? val : 0;
+		mutex_lock(&sfp->f_mutex);
+		sfp->next_cmd_len = max_t(int, val, 0);
+		mutex_unlock(&sfp->f_mutex);
 		return 0;
-	case SG_GET_VERSION_NUM:
-		return put_user(sg_version_num, ip);
 	case SG_GET_ACCESS_COUNT:
+		SG_LOG(3, sdp, "%s:    SG_GET_ACCESS_COUNT\n", __func__);
 		/* faked - we don't have a real access count anymore */
-		val = (sdp->device ? 1 : 0);
+		val = (sdev ? 1 : 0);
 		return put_user(val, ip);
-	case SG_GET_REQUEST_TABLE:
-		if (!access_ok(p, SZ_SG_REQ_INFO * SG_MAX_QUEUE))
-			return -EFAULT;
-		else {
-			sg_req_info_t *rinfo;
-
-			rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
-					GFP_KERNEL);
-			if (!rinfo)
-				return -ENOMEM;
-			read_lock_irqsave(&sfp->rq_list_lock, iflags);
-			sg_fill_request_table(sfp, rinfo);
-			read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-			result = __copy_to_user(p, rinfo,
-						SZ_SG_REQ_INFO * SG_MAX_QUEUE);
-			result = result ? -EFAULT : 0;
-			kfree(rinfo);
-			return result;
-		}
 	case SG_EMULATED_HOST:
-		if (atomic_read(&sdp->detaching))
+		SG_LOG(3, sdp, "%s:    SG_EMULATED_HOST\n", __func__);
+		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
-		return put_user(sdp->device->host->hostt->emulated, ip);
+		return put_user(sdev->host->hostt->emulated, ip);
 	case SCSI_IOCTL_SEND_COMMAND:
-		if (atomic_read(&sdp->detaching))
+		SG_LOG(3, sdp, "%s:    SCSI_IOCTL_SEND_COMMAND\n", __func__);
+		if (unlikely(atomic_read(&sdp->detaching)))
 			return -ENODEV;
-		return sg_scsi_ioctl(sdp->device->request_queue, NULL, filp->f_mode, p);
+		return sg_scsi_ioctl(sdev->request_queue, NULL,
+				     filp->f_mode, p);
 	case SG_SET_DEBUG:
+		SG_LOG(3, sdp, "%s:    SG_SET_DEBUG\n", __func__);
 		result = get_user(val, ip);
 		if (result)
 			return result;
-		sdp->sgdebug = (char) val;
+		sdp->sgdebug = (u8)val;
 		return 0;
 	case BLKSECTGET:
-		return put_user(max_sectors_bytes(sdp->device->request_queue),
-				ip);
+		SG_LOG(3, sdp, "%s:    BLKSECTGET\n", __func__);
+		return put_user(max_sectors_bytes(sdev->request_queue), ip);
 	case BLKTRACESETUP:
-		return blk_trace_setup(sdp->device->request_queue,
+		SG_LOG(3, sdp, "%s:    BLKTRACESETUP\n", __func__);
+		return blk_trace_setup(sdev->request_queue,
 				       sdp->disk->disk_name,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
 				       NULL, p);
 	case BLKTRACESTART:
-		return blk_trace_startstop(sdp->device->request_queue, 1);
+		SG_LOG(3, sdp, "%s:    BLKTRACESTART\n", __func__);
+		return blk_trace_startstop(sdev->request_queue, 1);
 	case BLKTRACESTOP:
-		return blk_trace_startstop(sdp->device->request_queue, 0);
+		SG_LOG(3, sdp, "%s:    BLKTRACESTOP\n", __func__);
+		return blk_trace_startstop(sdev->request_queue, 0);
 	case BLKTRACETEARDOWN:
-		return blk_trace_remove(sdp->device->request_queue);
+		SG_LOG(3, sdp, "%s:    BLKTRACETEARDOWN\n", __func__);
+		return blk_trace_remove(sdev->request_queue);
 	case SCSI_IOCTL_GET_IDLUN:
+		SG_LOG(3, sdp, "%s:    SCSI_IOCTL_GET_IDLUN %s\n", __func__,
+		       pmlp);
+		check_detach = true;
+		break;
 	case SCSI_IOCTL_GET_BUS_NUMBER:
+		SG_LOG(3, sdp, "%s:    SCSI_IOCTL_GET_BUS_NUMBER%s\n",
+		       __func__, pmlp);
+		check_detach = true;
+		break;
 	case SCSI_IOCTL_PROBE_HOST:
+		SG_LOG(3, sdp, "%s:    SCSI_IOCTL_PROBE_HOST%s\n", __func__,
+		       pmlp);
+		check_detach = true;
+		break;
 	case SG_GET_TRANSFORM:
-	case SG_SCSI_RESET:
-		if (atomic_read(&sdp->detaching))
-			return -ENODEV;
+		SG_LOG(3, sdp, "%s:    SG_GET_TRANSFORM%s\n", __func__, pmlp);
+		check_detach = true;
+		break;
+	case SG_SET_TRANSFORM:
+		SG_LOG(3, sdp, "%s:    SG_SET_TRANSFORM%s\n", __func__, pmlp);
+		check_detach = true;
 		break;
 	default:
+		SG_LOG(3, sdp, "%s:    unrecognized ioctl [0x%x]%s\n",
+		       __func__, cmd_in, pmlp);
 		if (read_only)
-			return -EPERM;	/* don't know so take safe approach */
+			return -EPERM;  /* don't know, so take safer approach */
 		break;
 	}
 
-	result = scsi_ioctl_block_when_processing_errors(sdp->device,
-			cmd_in, filp->f_flags & O_NDELAY);
+	if (check_detach) {
+		if (unlikely(atomic_read(&sdp->detaching)))
+			return -ENODEV;
+	}
+	result = sg_allow_if_err_recovery(sdp, (filp->f_flags & O_NDELAY));
 	if (result)
 		return result;
-	return scsi_ioctl(sdp->device, cmd_in, p);
+	/* ioctl that reach here are forwarded to the mid-level */
+	return scsi_ioctl(sdev, cmd_in, p);
 }
 
 #if IS_ENABLED(CONFIG_COMPAT)
@@ -1232,43 +1723,36 @@ sg_compat_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 }
 #endif
 
+/*
+ * Implements the poll(2) system call for this driver. Returns various EPOLL*
+ * flags OR-ed together.
+ */
 static __poll_t
 sg_poll(struct file *filp, poll_table * wait)
 {
 	__poll_t p_res = 0;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
-	struct sg_request *srp;
-	int count = 0;
-	unsigned long iflags;
 
 	sfp = filp->private_data;
-	if (!sfp)
-		return EPOLLERR;
 	sdp = sfp->parentdp;
 	if (!sdp)
 		return EPOLLERR;
 	poll_wait(filp, &sfp->read_wait, wait);
-	read_lock_irqsave(&sfp->rq_list_lock, iflags);
-	list_for_each_entry(srp, &sfp->rq_list, entry) {
-		/* if any read waiting, flag it */
-		if ((p_res == 0) && (srp->done == 1) && (!srp->sg_io_owned))
-			p_res = EPOLLIN | EPOLLRDNORM;
-		++count;
-	}
-	read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	if (atomic_read(&sfp->waiting) > 0)
+		p_res = EPOLLIN | EPOLLRDNORM;
 
-	if (atomic_read(&sdp->detaching))
+	if (unlikely(atomic_read(&sdp->detaching)))
 		p_res |= EPOLLHUP;
-	else if (!sfp->cmd_q) {
-		if (0 == count)
-			p_res |= EPOLLOUT | EPOLLWRNORM;
-	} else if (count < SG_MAX_QUEUE)
+	else if (likely(test_bit(SG_FFD_CMD_Q, sfp->ffd_bm)))
+		p_res |= EPOLLOUT | EPOLLWRNORM;
+	else if (atomic_read(&sfp->submitted) == 0)
 		p_res |= EPOLLOUT | EPOLLWRNORM;
 	SG_LOG(3, sdp, "%s: p_res=0x%x\n", __func__, (__force u32)p_res);
 	return p_res;
 }
 
+/* Entry point for fasync() related to fcntl(SET_FL(flags | O_ASYNC)) call */
 static int
 sg_fasync(int fd, struct file *filp, int mode)
 {
@@ -1283,15 +1767,17 @@ sg_fasync(int fd, struct file *filp, int mode)
 	return fasync_helper(fd, filp, mode, &sfp->async_qp);
 }
 
+/* Note: the error return: VM_FAULT_SIGBUS causes a "bus error" */
 static vm_fault_t
 sg_vma_fault(struct vm_fault *vmf)
 {
+	int k, length;
+	unsigned long offset, len, sa, iflags;
 	struct vm_area_struct *vma = vmf->vma;
+	struct sg_scatter_hold *rsv_schp;
+	struct sg_request *srp;
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
-	unsigned long offset, len, sa;
-	struct sg_scatter_hold *rsv_schp;
-	int k, length;
 	const char *nbp = "==NULL, bad";
 
 	if (!vma) {
@@ -1304,26 +1790,45 @@ sg_vma_fault(struct vm_fault *vmf)
 		goto out_err;
 	}
 	sdp = sfp->parentdp;
-	rsv_schp = &sfp->reserve;
+	if (sdp && unlikely(atomic_read(&sdp->detaching))) {
+		SG_LOG(1, sdp, "%s: device detaching\n", __func__);
+		goto out_err;
+	}
+	srp = sfp->rsv_srp;
+	if (!srp) {
+		SG_LOG(1, sdp, "%s: srp%s\n", __func__, nbp);
+		goto out_err;
+	}
+	spin_lock_irqsave(&srp->req_lck, iflags);
+	rsv_schp = &srp->sgat_h;
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rsv_schp->bufflen)
-		return VM_FAULT_SIGBUS;
+	if (offset >= (unsigned int)rsv_schp->buflen) {
+		SG_LOG(1, sdp, "%s: offset[%lu] >= rsv.buflen\n", __func__,
+		       offset);
+		goto out_err_unlock;
+	}
 	sa = vma->vm_start;
 	SG_LOG(3, sdp, "%s: vm_start=0x%lx, off=%lu\n", __func__, sa, offset);
 	length = 1 << (PAGE_SHIFT + rsv_schp->page_order);
-	for (k = 0; k < rsv_schp->k_use_sg && sa < vma->vm_end; k++) {
+	for (k = 0; k < rsv_schp->num_sgat && sa < vma->vm_end; ++k) {
 		len = vma->vm_end - sa;
-		len = (len < length) ? len : length;
+		len = min_t(int, len, (int)length);
 		if (offset < len) {
-			struct page *page = nth_page(rsv_schp->pages[k],
-						     offset >> PAGE_SHIFT);
-			get_page(page);	/* increment page count */
+			struct page *page;
+			struct page *pp;
+
+			pp = rsv_schp->pages[k];
+			spin_unlock_irqrestore(&srp->req_lck, iflags);
+			page = nth_page(pp, offset >> PAGE_SHIFT);
+			get_page(page); /* increment page count */
 			vmf->page = page;
 			return 0; /* success */
 		}
 		sa += len;
 		offset -= len;
 	}
+out_err_unlock:
+	spin_unlock_irqrestore(&srp->req_lck, iflags);
 out_err:
 	return VM_FAULT_SIGBUS;
 }
@@ -1332,14 +1837,16 @@ static const struct vm_operations_struct sg_mmap_vm_ops = {
 	.fault = sg_vma_fault,
 };
 
+/* Entry point for mmap(2) system call */
 static int
 sg_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	struct sg_fd *sfp;
-	unsigned long req_sz, len, sa;
-	struct sg_scatter_hold *rsv_schp;
 	int k, length;
 	int ret = 0;
+	unsigned long req_sz, len, sa, iflags;
+	struct sg_scatter_hold *rsv_schp;
+	struct sg_fd *sfp;
+	struct sg_request *srp;
 
 	if (!filp || !vma)
 		return -ENXIO;
@@ -1352,141 +1859,207 @@ sg_mmap(struct file *filp, struct vm_area_struct *vma)
 	SG_LOG(3, sfp->parentdp, "%s: vm_start=%p, len=%d\n", __func__,
 	       (void *)vma->vm_start, (int)req_sz);
 	if (vma->vm_pgoff)
-		return -EINVAL;	/* want no offset */
-	rsv_schp = &sfp->reserve;
+		return -EINVAL; /* only an offset of 0 accepted */
+	/* Check reserve request is inactive and has large enough buffer */
 	mutex_lock(&sfp->f_mutex);
-	if (req_sz > rsv_schp->bufflen) {
-		ret = -ENOMEM;	/* cannot map more than reserved buffer */
+	srp = sfp->rsv_srp;
+	spin_lock_irqsave(&srp->req_lck, iflags);
+	if (SG_RS_ACTIVE(srp)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	rsv_schp = &srp->sgat_h;
+	if (req_sz > (unsigned long)rsv_schp->buflen) {
+		ret = -ENOMEM;
 		goto out;
 	}
-
 	sa = vma->vm_start;
 	length = 1 << (PAGE_SHIFT + rsv_schp->page_order);
-	for (k = 0; k < rsv_schp->k_use_sg && sa < vma->vm_end; k++) {
+	for (k = 0; k < rsv_schp->num_sgat && sa < vma->vm_end; ++k) {
 		len = vma->vm_end - sa;
-		len = (len < length) ? len : length;
+		len = min_t(unsigned long, len, (unsigned long)length);
 		sa += len;
 	}
 
-	sfp->mmap_called = 1;
+	set_bit(SG_FFD_MMAP_CALLED, sfp->ffd_bm);
 	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_private_data = sfp;
 	vma->vm_ops = &sg_mmap_vm_ops;
 out:
+	spin_unlock_irqrestore(&srp->req_lck, iflags);
 	mutex_unlock(&sfp->f_mutex);
 	return ret;
 }
 
+/*
+ * This user context function is called from sg_rq_end_io() in 2 situations.
+ * The first case is when a slave was in SWAIT state and sg_rq_end_io() has
+ * just been called on the corresponding master request.
+ * The second case is an orphaned request that needs to be cleaned up (e.g.
+ * when control C is typed while an ioctl(SG_IO) is active).
+ */
 static void
 sg_rq_end_io_usercontext(struct work_struct *work)
 {
-	struct sg_request *srp = container_of(work, struct sg_request, ew.work);
-	struct sg_fd *sfp = srp->parentfp;
+	struct sg_request *srp = container_of(work, struct sg_request,
+					      ew_orph.work);
+	struct sg_fd *sfp;
 
-	sg_finish_rem_req(srp);
-	sg_remove_request(sfp, srp);
+	if (!srp) {
+		WARN_ONCE("%s: srp unexpectedly NULL\n", __func__);
+		return;
+	}
+	sfp = srp->parentfp;
+	if (!sfp) {
+		WARN_ONCE(1, "%s: sfp unexpectedly NULL\n", __func__);
+		return;
+	}
+	SG_LOG(3, sfp->parentdp, "%s: srp=0x%p\n", __func__, srp);
+	if (test_bit(SG_FRQ_DEACT_ORPHAN, srp->frq_bm)) {
+		sg_finish_scsi_blk_rq(srp);	/* clean up orphan case */
+		sg_deact_request(sfp, srp);
+	}
 	kref_put(&sfp->f_ref, sg_remove_sfp);
 }
 
+static void
+sg_check_sense(struct sg_device *sdp, struct sg_request *srp, int sense_len)
+{
+	int driver_stat;
+	u32 rq_res = srp->rq_result;
+	struct scsi_request *scsi_rp = scsi_req(srp->rq);
+	u8 *sbp = scsi_rp ? scsi_rp->sense : NULL;
+
+	if (!sbp)
+		return;
+	driver_stat = driver_byte(rq_res);
+	if (driver_stat & DRIVER_SENSE) {
+		struct scsi_sense_hdr ssh;
+
+		if (scsi_normalize_sense(sbp, sense_len, &ssh)) {
+			if (!scsi_sense_is_deferred(&ssh)) {
+				if (ssh.sense_key == UNIT_ATTENTION) {
+					if (sdp->device->removable)
+						sdp->device->changed = 1;
+				}
+			}
+		}
+	}
+	if (sdp->sgdebug > 0) {
+		int scsi_stat = rq_res & 0xff;
+
+		if (scsi_stat == SAM_STAT_CHECK_CONDITION ||
+		    scsi_stat == SAM_STAT_COMMAND_TERMINATED)
+			__scsi_print_sense(sdp->device, __func__, sbp,
+					   sense_len);
+	}
+}
+
 /*
- * This function is a "bottom half" handler that is called by the mid
- * level when a command is completed (or has failed).
+ * This "bottom half" (soft interrupt) handler is called by the mid-level
+ * when a request has completed or failed. This callback is registered in a
+ * blk_execute_rq_nowait() call in the sg_common_write(). For ioctl(SG_IO)
+ * (sync) usage, sg_ctl_sg_io() waits to be woken up by this callback.
  */
 static void
 sg_rq_end_io(struct request *rq, blk_status_t status)
 {
+	enum sg_rq_state rqq_state = SG_RS_AWAIT_RD;
+	int a_resid, slen;
 	struct sg_request *srp = rq->end_io_data;
-	struct scsi_request *req = scsi_req(rq);
+	struct scsi_request *scsi_rp = scsi_req(rq);
 	struct sg_device *sdp;
 	struct sg_fd *sfp;
-	unsigned long iflags;
-	unsigned int ms;
-	char *sense;
-	int result, resid, done = 1;
 
-	if (WARN_ON(srp->done != 0))
+	if (!scsi_rp) {
+		WARN_ONCE("%s: scsi_req(rq) unexpectedly NULL\n", __func__);
 		return;
-
-	sfp = srp->parentfp;
-	if (WARN_ON(sfp == NULL))
+	}
+	if (!srp) {
+		WARN_ONCE("%s: srp unexpectedly NULL\n", __func__);
 		return;
-
+	}
+	/* Expect 0 --> 1 transition, otherwise processed elsewhere */
+	if (unlikely(test_and_set_bit(SG_FRQ_BLK_PUT_REQ, srp->frq_bm))) {
+		pr_info("%s: srp=%p already completed\n", __func__, srp);
+		return;
+	}
+	if (WARN_ON(atomic_read(&srp->rq_st) != SG_RS_INFLIGHT)) {
+		pr_warn("%s: bad rq_st=%d\n", __func__,
+			atomic_read(&srp->rq_st));
+		goto early_err;
+	}
+	sfp = srp->parentfp;
+	if (unlikely(!sfp)) {
+		WARN_ONCE(1, "%s: sfp unexpectedly NULL", __func__);
+		goto early_err;
+	}
 	sdp = sfp->parentdp;
 	if (unlikely(atomic_read(&sdp->detaching)))
 		pr_info("%s: device detaching\n", __func__);
 
-	sense = req->sense;
-	result = req->result;
-	resid = req->resid_len;
-
-	srp->header.resid = resid;
-	SG_LOG(6, sdp, "%s: pack_id=%d, res=0x%x\n", __func__,
-	       srp->header.pack_id, result);
-	ms = jiffies_to_msecs(jiffies);
-	srp->header.duration = (ms > srp->header.duration) ?
-				(ms - srp->header.duration) : 0;
-	if (0 != result) {
-		struct scsi_sense_hdr sshdr;
-
-		srp->header.status = 0xff & result;
-		srp->header.masked_status = status_byte(result);
-		srp->header.msg_status = msg_byte(result);
-		srp->header.host_status = host_byte(result);
-		srp->header.driver_status = driver_byte(result);
-		if ((sdp->sgdebug > 0) &&
-		    ((CHECK_CONDITION == srp->header.masked_status) ||
-		     (COMMAND_TERMINATED == srp->header.masked_status)))
-			__scsi_print_sense(sdp->device, __func__, sense,
-					   SCSI_SENSE_BUFFERSIZE);
-
-		/* Following if statement is a patch supplied by Eric Youngdale */
-		if (driver_byte(result) != 0
-		    && scsi_normalize_sense(sense, SCSI_SENSE_BUFFERSIZE, &sshdr)
-		    && !scsi_sense_is_deferred(&sshdr)
-		    && sshdr.sense_key == UNIT_ATTENTION
-		    && sdp->device->removable) {
-			/* Detected possible disc change. Set the bit - this */
-			/* may be used if there are filesystems using this device */
-			sdp->device->changed = 1;
+	srp->rq_result = scsi_rp->result;
+	slen = min_t(int, scsi_rp->sense_len, SCSI_SENSE_BUFFERSIZE);
+	a_resid = scsi_rp->resid_len;
+
+	if (a_resid)
+		srp->in_resid = a_resid;
+
+	SG_LOG(6, sdp, "%s: pack_id=%d, res=0x%x\n", __func__, srp->pack_id,
+	       srp->rq_result);
+	srp->duration = sg_calc_rq_dur(srp);
+	if (unlikely((srp->rq_result & SG_ML_RESULT_MSK) && slen > 0))
+		sg_check_sense(sdp, srp, slen);
+	if (slen > 0) {
+		if (scsi_rp->sense) {
+			srp->sense_bp = kzalloc(SCSI_SENSE_BUFFERSIZE,
+						GFP_ATOMIC);
+			if (srp->sense_bp)
+				memcpy(srp->sense_bp, scsi_rp->sense, slen);
+		} else {
+			pr_warn("%s: scsi_request::sense==NULL\n", __func__);
+			slen = 0;
 		}
 	}
-
-	if (req->sense_len)
-		memcpy(srp->sense_b, req->sense, SCSI_SENSE_BUFFERSIZE);
-
-	/* Rely on write phase to clean out srp status values, so no "else" */
-
+	srp->sense_len = slen;
+	if (unlikely(test_bit(SG_FRQ_IS_ORPHAN, srp->frq_bm))) {
+		spin_lock(&srp->req_lck);
+		if (test_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm)) {
+			clear_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm);
+		} else {
+			rqq_state = SG_RS_BUSY;
+			set_bit(SG_FRQ_DEACT_ORPHAN, srp->frq_bm);
+		}
+		spin_unlock(&srp->req_lck);
+	}
+	if (!test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+		atomic_inc(&sfp->waiting);
+	if (unlikely(sg_rstate_chg(srp, SG_RS_INFLIGHT, rqq_state)))
+		pr_warn("%s: can't set rq_st\n", __func__);
 	/*
-	 * Free the request as soon as it is complete so that its resources
-	 * can be reused without waiting for userspace to read() the
-	 * result.  But keep the associated bio (if any) around until
-	 * blk_rq_unmap_user() can be called from user context.
+	 * Free the mid-level resources apart from the bio (if any). The bio's
+	 * blk_rq_unmap_user() can be called later from user context.
 	 */
 	srp->rq = NULL;
-	scsi_req_free_cmd(scsi_req(rq));
+	scsi_req_free_cmd(scsi_rp);
 	blk_put_request(rq);
 
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
-	if (unlikely(srp->orphan)) {
-		if (sfp->keep_orphan)
-			srp->sg_io_owned = 0;
-		else
-			done = 0;
-	}
-	srp->done = done;
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-
-	if (likely(done)) {
-		/* Now wake up any sg_read() that is waiting for this
-		 * packet.
-		 */
+	if (likely(rqq_state == SG_RS_AWAIT_RD)) {
+		/* Wake any sg_read()/ioctl(SG_IORECEIVE) awaiting this req */
 		wake_up_interruptible(&sfp->read_wait);
 		kill_fasync(&sfp->async_qp, SIGPOLL, POLL_IN);
 		kref_put(&sfp->f_ref, sg_remove_sfp);
-	} else {
-		INIT_WORK(&srp->ew.work, sg_rq_end_io_usercontext);
-		schedule_work(&srp->ew.work);
+	} else {        /* clean up orphaned request that aren't being kept */
+		INIT_WORK(&srp->ew_orph.work, sg_rq_end_io_usercontext);
+		schedule_work(&srp->ew_orph.work);
 	}
+	return;
+
+early_err:
+	srp->rq = NULL;
+	if (scsi_rp)
+		scsi_req_free_cmd(scsi_rp);
+	blk_put_request(rq);
 }
 
 static const struct file_operations sg_fops = {
@@ -1507,16 +2080,16 @@ static const struct file_operations sg_fops = {
 
 static struct class *sg_sysfs_class;
 
-static int sg_sysfs_valid = 0;
+static bool sg_sysfs_valid;
 
+/* Returns valid pointer to sg_device or negated errno twisted by ERR_PTR */
 static struct sg_device *
 sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 {
-	struct request_queue *q = scsidp->request_queue;
 	struct sg_device *sdp;
-	unsigned long iflags;
 	int error;
 	u32 k;
+	unsigned long iflags;
 
 	sdp = kzalloc(sizeof(struct sg_device), GFP_KERNEL);
 	if (!sdp)
@@ -1534,7 +2107,7 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 			error = -ENODEV;
 		} else {
 			sdev_printk(KERN_WARNING, scsidp,
-				    "%s: idr alloc sg_device failure: %d\n",
+				"%s: idr allocation sg_device failure: %d\n",
 				    __func__, error);
 		}
 		goto out_unlock;
@@ -1551,8 +2124,8 @@ sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 	INIT_LIST_HEAD(&sdp->sfds);
 	init_waitqueue_head(&sdp->open_wait);
 	atomic_set(&sdp->detaching, 0);
-	rwlock_init(&sdp->sfd_lock);
-	sdp->sg_tablesize = queue_max_segments(q);
+	rwlock_init(&sdp->sfd_llock);
+	sg_calc_sgat_param(sdp);
 	sdp->index = k;
 	kref_init(&sdp->d_ref);
 	error = 0;
@@ -1685,13 +2258,13 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 
 	SG_LOG(3, sdp, "%s: 0x%p\n", __func__, sdp);
 
-	read_lock_irqsave(&sdp->sfd_lock, iflags);
-	list_for_each_entry(sfp, &sdp->sfds, sfd_siblings) {
+	read_lock_irqsave(&sdp->sfd_llock, iflags);
+	list_for_each_entry(sfp, &sdp->sfds, sfd_entry) {
 		wake_up_interruptible_all(&sfp->read_wait);
 		kill_fasync(&sfp->async_qp, SIGPOLL, POLL_HUP);
 	}
 	wake_up_interruptible_all(&sdp->open_wait);
-	read_unlock_irqrestore(&sdp->sfd_lock, iflags);
+	read_unlock_irqrestore(&sdp->sfd_llock, iflags);
 
 	sysfs_remove_link(&scsidp->sdev_gendev.kobj, "generic");
 	device_destroy(sg_sysfs_class, MKDEV(SCSI_GENERIC_MAJOR, sdp->index));
@@ -1722,32 +2295,39 @@ init_sg(void)
 {
 	int rc;
 
-	if (scatter_elem_sz < PAGE_SIZE) {
+	/* check scatter_elem_sz module parameter, change if inappropriate */
+	if (scatter_elem_sz < (int)PAGE_SIZE)
 		scatter_elem_sz = PAGE_SIZE;
-		scatter_elem_sz_prev = scatter_elem_sz;
-	}
+	else if (scatter_elem_sz != (1 << ilog2(scatter_elem_sz)))
+		scatter_elem_sz = 1 << ilog2(scatter_elem_sz);
+	/* scatter_elem_sz rounded down to power of 2, or PAGE_SIZE */
 	if (def_reserved_size >= 0)
 		sg_big_buff = def_reserved_size;
 	else
 		def_reserved_size = sg_big_buff;
 
-	rc = register_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), 
+	rc = register_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				    SG_MAX_DEVS, "sg");
 	if (rc)
 		return rc;
-        sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
-        if ( IS_ERR(sg_sysfs_class) ) {
+
+	pr_info("Registered %s[char major=0x%x], version: %s, date: %s\n",
+		"sg device ", SCSI_GENERIC_MAJOR, SG_VERSION_STR,
+		sg_version_date);
+	sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
+	if (IS_ERR(sg_sysfs_class)) {
 		rc = PTR_ERR(sg_sysfs_class);
-		goto err_out;
-        }
-	sg_sysfs_valid = 1;
+		goto err_out_unreg;
+	}
+	sg_sysfs_valid = true;
 	rc = scsi_register_interface(&sg_interface);
 	if (0 == rc) {
 		sg_proc_init();
 		return 0;
 	}
 	class_destroy(sg_sysfs_class);
-err_out:
+
+err_out_unreg:
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0), SG_MAX_DEVS);
 	return rc;
 }
@@ -1767,40 +2347,72 @@ exit_sg(void)
 		remove_proc_subtree("scsi/sg", NULL);
 	scsi_unregister_interface(&sg_interface);
 	class_destroy(sg_sysfs_class);
-	sg_sysfs_valid = 0;
+	sg_sysfs_valid = false;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);
 	idr_destroy(&sg_index_idr);
 }
 
+static inline bool
+sg_chk_dio_allowed(struct sg_device *sdp, struct sg_fd *sfp,
+		   struct sg_request *srp, int iov_count, int dir)
+{
+	if (sg_allow_dio && (srp->rq_flags & SG_FLAG_DIRECT_IO)) {
+		if (dir != SG_DXFER_UNKNOWN && !iov_count) {
+			if (!sdp->device->host->unchecked_isa_dma)
+				return true;
+		}
+	}
+	return false;
+}
+
+static void
+sg_set_map_data(const struct sg_scatter_hold *schp, bool up_valid,
+		struct rq_map_data *mdp)
+{
+	memset(mdp, 0, sizeof(*mdp));
+	mdp->pages = schp->pages;
+	mdp->page_order = schp->page_order;
+	mdp->nr_entries = schp->num_sgat;
+	mdp->offset = 0;
+	mdp->null_mapped = !up_valid;
+}
+
 static int
-sg_start_req(struct sg_request *srp, u8 *cmd)
+sg_start_req(struct sg_request *srp, u8 *cmd, int cmd_len, int dxfer_dir)
 {
-	int res;
+	bool reserved, us_xfer;
+	int res = 0;
+	int dxfer_len = 0;
+	int r0w = READ;
+	unsigned int iov_count = 0;
+	void __user *up;
 	struct request *rq;
-	struct scsi_request *req;
-	struct sg_device *sdp;
+	struct scsi_request *scsi_rp;
 	struct sg_fd *sfp = srp->parentfp;
-	sg_io_hdr_t *hp = &srp->header;
-	int dxfer_len = (int) hp->dxfer_len;
-	int dxfer_dir = hp->dxfer_direction;
-	unsigned int iov_count = hp->iovec_count;
-	struct sg_scatter_hold *req_schp = &srp->data;
-	struct sg_scatter_hold *rsv_schp = &sfp->reserve;
-	struct request_queue *q = sfp->parentdp->device->request_queue;
-	struct rq_map_data *md, map_data;
-	int r0w = hp->dxfer_direction == SG_DXFER_TO_DEV ? WRITE : READ;
+	struct sg_device *sdp;
+	struct sg_scatter_hold *req_schp;
+	struct request_queue *q;
+	struct rq_map_data *md = (void *)srp; /* want any non-NULL value */
 	u8 *long_cmdp = NULL;
+	__maybe_unused const char *cp = "";
+	struct sg_slice_hdr3 *sh3p = &srp->s_hdr3;
+	struct rq_map_data map_data;
 
 	sdp = sfp->parentdp;
-	if (hp->cmd_len > BLK_MAX_CDB) {
-		long_cmdp = kzalloc(hp->cmd_len, GFP_KERNEL);
+	if (cmd_len > BLK_MAX_CDB) {	/* for longer SCSI cdb_s */
+		long_cmdp = kzalloc(cmd_len, GFP_KERNEL);
 		if (!long_cmdp)
 			return -ENOMEM;
 		SG_LOG(5, sdp, "%s: long_cmdp=0x%p ++\n", __func__, long_cmdp);
 	}
+	up = sh3p->dxferp;
+	dxfer_len = (int)sh3p->dxfer_len;
+	iov_count = sh3p->iovec_count;
+	r0w = dxfer_dir == SG_DXFER_TO_DEV ? WRITE : READ;
 	SG_LOG(4, sdp, "%s: dxfer_len=%d, data-%s\n", __func__, dxfer_len,
 	       (r0w ? "OUT" : "IN"));
+	q = sdp->device->request_queue;
 
 	/*
 	 * NOTE
@@ -1813,234 +2425,247 @@ sg_start_req(struct sg_request *srp, u8 *cmd)
 	 * do not want to use BLK_MQ_REQ_NOWAIT here because userspace might
 	 * not expect an EWOULDBLOCK from this condition.
 	 */
-	rq = blk_get_request(q, hp->dxfer_direction == SG_DXFER_TO_DEV ?
-			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, 0);
-	if (IS_ERR(rq)) {
+	rq = blk_get_request(q, (r0w ? REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN), 0);
+	if (unlikely(IS_ERR(rq))) {
 		kfree(long_cmdp);
 		return PTR_ERR(rq);
 	}
-	req = scsi_req(rq);
-
-	if (hp->cmd_len > BLK_MAX_CDB)
-		req->cmd = long_cmdp;
-	memcpy(req->cmd, cmd, hp->cmd_len);
-	req->cmd_len = hp->cmd_len;
-
+	/* current sg_request protected by SG_RS_BUSY state */
+	scsi_rp = scsi_req(rq);
 	srp->rq = rq;
-	rq->end_io_data = srp;
-	req->retries = SG_DEFAULT_RETRIES;
-
-	if ((dxfer_len <= 0) || (dxfer_dir == SG_DXFER_NONE))
-		return 0;
 
-	if (sg_allow_dio && hp->flags & SG_FLAG_DIRECT_IO &&
-	    dxfer_dir != SG_DXFER_UNKNOWN && !iov_count &&
-	    !sfp->parentdp->device->host->unchecked_isa_dma &&
-	    blk_rq_aligned(q, (unsigned long)hp->dxferp, dxfer_len))
+	if (cmd_len > BLK_MAX_CDB)
+		scsi_rp->cmd = long_cmdp;
+	memcpy(scsi_rp->cmd, cmd, cmd_len);
+	scsi_rp->cmd_len = cmd_len;
+	us_xfer = !(srp->rq_flags & SG_FLAG_NO_DXFER);
+	assign_bit(SG_FRQ_NO_US_XFER, srp->frq_bm, !us_xfer);
+	reserved = (sfp->rsv_srp == srp);
+	rq->end_io_data = srp;
+	scsi_rp->retries = SG_DEFAULT_RETRIES;
+	req_schp = &srp->sgat_h;
+
+	if (dxfer_len <= 0 || dxfer_dir == SG_DXFER_NONE) {
+		SG_LOG(4, sdp, "%s: no data xfer [0x%p]\n", __func__, srp);
+		set_bit(SG_FRQ_NO_US_XFER, srp->frq_bm);
+		goto fini;	/* path of reqs with no din nor dout */
+	} else if (sg_chk_dio_allowed(sdp, sfp, srp, iov_count, dxfer_dir) &&
+		   blk_rq_aligned(q, (unsigned long)up, dxfer_len)) {
+		set_bit(SG_FRQ_DIO_IN_USE, srp->frq_bm);
+		srp->rq_info |= SG_INFO_DIRECT_IO;
 		md = NULL;
-	else
+		if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
+			cp = "direct_io, ";
+	} else {	/* normal IO and failed conditions for dio path */
 		md = &map_data;
+	}
 
-	if (md) {
-		mutex_lock(&sfp->f_mutex);
-		if (dxfer_len <= rsv_schp->bufflen &&
-		    !sfp->res_in_use) {
-			sfp->res_in_use = 1;
-			sg_link_reserve(sfp, srp, dxfer_len);
-		} else if (hp->flags & SG_FLAG_MMAP_IO) {
-			res = -EBUSY; /* sfp->res_in_use == 1 */
-			if (dxfer_len > rsv_schp->bufflen)
-				res = -ENOMEM;
-			mutex_unlock(&sfp->f_mutex);
-			return res;
-		} else {
-			res = sg_build_indirect(req_schp, sfp, dxfer_len);
-			if (res) {
-				mutex_unlock(&sfp->f_mutex);
-				return res;
-			}
+	if (likely(md)) {	/* normal, "indirect" IO */
+		if (unlikely((srp->rq_flags & SG_FLAG_MMAP_IO))) {
+			/* mmap IO must use and fit in reserve request */
+			if (!reserved || dxfer_len > req_schp->buflen)
+				res = reserved ? -ENOMEM : -EBUSY;
+		} else if (req_schp->buflen == 0) {
+			int up_sz = max_t(int, dxfer_len, sfp->sgat_elem_sz);
+
+			res = sg_mk_sgat(srp, sfp, up_sz);
 		}
-		mutex_unlock(&sfp->f_mutex);
+		if (res)
+			goto fini;
 
-		md->pages = req_schp->pages;
-		md->page_order = req_schp->page_order;
-		md->nr_entries = req_schp->k_use_sg;
-		md->offset = 0;
-		md->null_mapped = hp->dxferp ? 0 : 1;
-		if (dxfer_dir == SG_DXFER_TO_FROM_DEV)
-			md->from_user = 1;
-		else
-			md->from_user = 0;
+		sg_set_map_data(req_schp, !!up, md);
+		md->from_user = (dxfer_dir == SG_DXFER_TO_FROM_DEV);
 	}
 
-	if (iov_count) {
+	if (unlikely(iov_count)) {
 		struct iovec *iov = NULL;
 		struct iov_iter i;
 
-		res = import_iovec(r0w, hp->dxferp, iov_count, 0, &iov, &i);
+		res = import_iovec(r0w, up, iov_count, 0, &iov, &i);
 		if (res < 0)
-			return res;
+			goto fini;
 
-		iov_iter_truncate(&i, hp->dxfer_len);
+		iov_iter_truncate(&i, dxfer_len);
 		if (!iov_iter_count(&i)) {
 			kfree(iov);
-			return -EINVAL;
+			res = -EINVAL;
+			goto fini;
 		}
 
-		res = blk_rq_map_user_iov(q, rq, md, &i, GFP_ATOMIC);
+		if (us_xfer)
+			res = blk_rq_map_user_iov(q, rq, md, &i, GFP_ATOMIC);
 		kfree(iov);
-	} else
-		res = blk_rq_map_user(q, rq, md, hp->dxferp,
-				      hp->dxfer_len, GFP_ATOMIC);
-
-	if (!res) {
-		srp->bio = rq->bio;
-
-		if (!md) {
-			req_schp->dio_in_use = 1;
-			hp->info |= SG_INFO_DIRECT_IO;
+		if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
+			cp = "iov_count > 0";
+	} else if (us_xfer) { /* setup for transfer data to/from user space */
+		res = blk_rq_map_user(q, rq, md, up, dxfer_len, GFP_ATOMIC);
+		if (IS_ENABLED(CONFIG_SCSI_PROC_FS) && res)
+			SG_LOG(1, sdp, "%s: blk_rq_map_user() res=%d\n",
+			       __func__, res);
+	}
+fini:
+	if (likely(res == 0)) {
+		res = sg_rstate_chg(srp, SG_RS_BUSY, SG_RS_INFLIGHT);
+		if (likely(res == 0))
+			srp->bio = rq->bio;
+	}
+	if (unlikely(res && rq)) {		/* failure, free up resources */
+		scsi_req_free_cmd(scsi_rp);
+		if (likely(!test_and_set_bit(SG_FRQ_BLK_PUT_REQ,
+					     srp->frq_bm))) {
+			srp->rq = NULL;
+			blk_put_request(rq);
 		}
 	}
+	SG_LOG((res ? 1 : 4), sdp, "%s: %s res=%d [0x%p]\n", __func__, cp,
+	       res, srp);
 	return res;
 }
 
-static int
-sg_finish_rem_req(struct sg_request *srp)
+/*
+ * Clean up mid-level and block layer resources of finished request. Sometimes
+ * blk_rq_unmap_user() returns -4 (-EINTR) and this is why: "If we're in a
+ * workqueue, the request is orphaned, so don't copy into a random user
+ * address space, just free and return -EINTR so user space doesn't expect
+ * any data." [block/bio.c]
+ */
+static void
+sg_finish_scsi_blk_rq(struct sg_request *srp)
 {
-	int ret = 0;
-
+	int ret;
 	struct sg_fd *sfp = srp->parentfp;
-	struct sg_scatter_hold *req_schp = &srp->data;
 
 	SG_LOG(4, sfp->parentdp, "%s: srp=0x%p%s\n", __func__, srp,
-	       (srp->res_used) ? " rsv" : "");
-	if (srp->bio)
-		ret = blk_rq_unmap_user(srp->bio);
-
-	if (srp->rq) {
-		scsi_req_free_cmd(scsi_req(srp->rq));
-		blk_put_request(srp->rq);
+	       (srp->parentfp->rsv_srp == srp) ? " rsv" : "");
+	if (!test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm)) {
+		atomic_dec(&sfp->submitted);
+		atomic_dec(&sfp->waiting);
+	}
+	if (srp->bio) {
+		bool us_xfer = !test_bit(SG_FRQ_NO_US_XFER, srp->frq_bm);
+
+		if (us_xfer) {
+			ret = blk_rq_unmap_user(srp->bio);
+			if (ret) {	/* -EINTR (-4) can be ignored */
+				SG_LOG(6, sfp->parentdp,
+				       "%s: blk_rq_unmap_user() --> %d\n",
+				       __func__, ret);
+			}
+		}
+		srp->bio = NULL;
 	}
+	/* In worst case READ data returned to user space by this point */
 
-	if (srp->res_used)
-		sg_unlink_reserve(sfp, srp);
-	else
-		sg_remove_scat(sfp, req_schp);
-
-	return ret;
-}
-
-static int
-sg_build_sgat(struct sg_scatter_hold *schp, const struct sg_fd *sfp,
-	      int tablesize)
-{
-	int sg_bufflen = tablesize * sizeof(struct page *);
-	gfp_t gfp_flags = GFP_ATOMIC | __GFP_NOWARN;
+	/* Expect blk_put_request(rq) already called in sg_rq_end_io() */
+	if (unlikely(!test_and_set_bit(SG_FRQ_BLK_PUT_REQ, srp->frq_bm))) {
+		struct request *rq = srp->rq;
 
-	schp->pages = kzalloc(sg_bufflen, gfp_flags);
-	if (!schp->pages)
-		return -ENOMEM;
-	schp->sglist_len = sg_bufflen;
-	return tablesize;	/* number of scat_gath elements allocated */
+		if (rq) {	/* blk_get_request() may have failed */
+			if (scsi_req(rq))
+				scsi_req_free_cmd(scsi_req(rq));
+			srp->rq = NULL;
+			blk_put_request(rq);
+		}
+	}
 }
 
 static int
-sg_build_indirect(struct sg_scatter_hold *schp, struct sg_fd *sfp,
-		  int buff_size)
+sg_mk_sgat(struct sg_request *srp, struct sg_fd *sfp, int minlen)
 {
-	int ret_sz = 0, i, k, rem_sz, num, mx_sc_elems;
-	int sg_tablesize = sfp->parentdp->sg_tablesize;
-	int blk_size = buff_size, order;
-	gfp_t gfp_mask = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN | __GFP_ZERO;
+	int j, k, rem_sz, order, align_sz;
+	int m_size = minlen;
+	int rup_sz = 0;
+	int mx_sgat_elems = sfp->parentdp->max_sgat_elems;
+	u32 elem_sz;
+	const size_t struct_page_sz = sizeof(struct page *);
+	gfp_t mask_ap = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN | __GFP_ZERO;
+	gfp_t mask_kz = GFP_ATOMIC | __GFP_NOWARN;
 	struct sg_device *sdp = sfp->parentdp;
+	struct sg_scatter_hold *schp = &srp->sgat_h;
 
-	if (blk_size < 0)
+	if (unlikely(m_size < 0))
 		return -EFAULT;
-	if (0 == blk_size)
-		++blk_size;	/* don't know why */
-	/* round request up to next highest SG_SECTOR_SZ byte boundary */
-	blk_size = ALIGN(blk_size, SG_SECTOR_SZ);
-	SG_LOG(4, sfp->parentdp, "%s: buff_size=%d, blk_size=%d\n",
-	       __func__, buff_size, blk_size);
-
-	/* N.B. ret_sz carried into this block ... */
-	mx_sc_elems = sg_build_sgat(schp, sfp, sg_tablesize);
-	if (mx_sc_elems < 0)
-		return mx_sc_elems;	/* most likely -ENOMEM */
-
-	num = scatter_elem_sz;
-	if (unlikely(num != scatter_elem_sz_prev)) {
-		if (num < PAGE_SIZE) {
-			scatter_elem_sz = PAGE_SIZE;
-			scatter_elem_sz_prev = PAGE_SIZE;
-		} else
-			scatter_elem_sz_prev = num;
-	}
-
-	if (sdp->device->host->unchecked_isa_dma)
-		gfp_mask |= GFP_DMA;
-
-	order = get_order(num);
-retry:
-	ret_sz = 1 << (PAGE_SHIFT + order);
-
-	for (k = 0, rem_sz = blk_size; rem_sz > 0 && k < mx_sc_elems;
-	     k++, rem_sz -= ret_sz) {
-
-		num = (rem_sz > scatter_elem_sz_prev) ?
-			scatter_elem_sz_prev : rem_sz;
+	if (unlikely(m_size == 0))
+		++m_size;	/* don't remember why */
+	/* round request up to next highest SG_DEF_SECTOR_SZ byte boundary */
+	align_sz = ALIGN(m_size, SG_DEF_SECTOR_SZ);
+
+	schp->pages = kcalloc(mx_sgat_elems, struct_page_sz, mask_kz);
+	SG_LOG(4, sdp, "%s: minlen=%d, align_sz=%d [sz=%zu, 0x%p ++]\n",
+	       __func__, minlen, align_sz, mx_sgat_elems * struct_page_sz,
+	       schp->pages);
+	if (unlikely(!schp->pages))
+		return -ENOMEM;
 
-		schp->pages[k] = alloc_pages(gfp_mask, order);
+	elem_sz = sfp->sgat_elem_sz;    /* power of 2 and >= PAGE_SIZE */
+	if (sdp && unlikely(sdp->device->host->unchecked_isa_dma))
+		mask_ap |= GFP_DMA;
+	/* PAGE_SIZE == (1 << PAGE_SHIFT) == (2 ** PAGE_SHIFT) */
+	order = get_order(elem_sz); /* --> ilog2(1+((elem_sz-1)/PAGE_SIZE)) */
+again:
+	rup_sz = 1 << (PAGE_SHIFT + order);	/* round up size */
+
+	for (k = 0, rem_sz = align_sz; rem_sz > 0 && k < mx_sgat_elems;
+	     ++k, rem_sz -= rup_sz) {
+		schp->pages[k] = alloc_pages(mask_ap, order);
 		if (!schp->pages[k])
-			goto out;
-
-		if (num == scatter_elem_sz_prev) {
-			if (unlikely(ret_sz > scatter_elem_sz_prev)) {
-				scatter_elem_sz = ret_sz;
-				scatter_elem_sz_prev = ret_sz;
-			}
-		}
-		SG_LOG(5, sfp->parentdp, "%s: k=%d, num=%d, ret_sz=%d\n",
-		       __func__, k, num, ret_sz);
-	}		/* end of for loop */
-
+			goto err_out;
+		SG_LOG(5, sdp, "%s: k=%d, rup_sz=%d [0x%p ++]\n", __func__, k,
+		       rup_sz, schp->pages[k]);
+	}
 	schp->page_order = order;
-	schp->k_use_sg = k;
-	SG_LOG(5, sfp->parentdp, "%s: k_use_sg=%d, order=%d\n", __func__,
-	       k, order);
-	schp->bufflen = blk_size;
-	if (rem_sz > 0)	/* must have failed */
+	schp->num_sgat = k;
+	SG_LOG(5, sdp, "%s: num_sgat=%d, order=%d\n", __func__, k, order);
+	if (unlikely(rem_sz > 0))       /* must have failed */
 		return -ENOMEM;
+	schp->buflen = align_sz;
 	return 0;
-out:
-	for (i = 0; i < k; i++)
-		__free_pages(schp->pages[i], order);
+err_out:
+	for (j = 0; j < k; ++j)
+		__free_pages(schp->pages[j], order);
 
 	if (--order >= 0)
-		goto retry;
-
+		goto again;
+	kfree(schp->pages);
 	return -ENOMEM;
 }
 
 static void
-sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp)
-{
-	SG_LOG(4, sfp->parentdp, "%s: num_sgat=%d\n", __func__,
-	       schp->k_use_sg);
-	if (schp->pages && schp->sglist_len > 0) {
-		if (!schp->dio_in_use) {
-			int k;
-
-			for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
-				SG_LOG(5, sfp->parentdp,
-				       "%s: pg[%d]=0x%p --\n", __func__, k,
-				       schp->pages[k]);
-				__free_pages(schp->pages[k], schp->page_order);
-			}
-			kfree(schp->pages);
-		}
-	}
-	memset(schp, 0, sizeof (*schp));
+sg_remove_sgat_helper(struct sg_device *sdp, struct sg_scatter_hold *schp)
+{
+	int k;
+	void *p;
+
+	if (!schp->pages)
+		return;
+	for (k = 0; k < schp->num_sgat; ++k) {
+		p = schp->pages[k];
+		SG_LOG(5, sdp, "%s: pg[%d]=0x%p --\n", __func__, k, p);
+		if (unlikely(!p))
+			continue;
+		__free_pages(p, schp->page_order);
+	}
+	SG_LOG(5, sdp, "%s: pg_order=%u, free pgs=0x%p --\n", __func__,
+	       schp->page_order, schp->pages);
+	kfree(schp->pages);
+}
+
+/* Remove the data (possibly a sgat list) held by srp, not srp itself */
+static void
+sg_remove_sgat(struct sg_request *srp)
+{
+	struct sg_scatter_hold *schp = &srp->sgat_h; /* care: remove own data */
+	struct sg_fd *sfp = srp->parentfp;
+	struct sg_device *sdp;
+
+	sdp = (sfp ? sfp->parentdp : NULL);
+	SG_LOG(4, sdp, "%s: num_sgat=%d%s\n", __func__, schp->num_sgat,
+	       ((srp->parentfp ? (sfp->rsv_srp == srp) : false) ?
+		" [rsv]" : ""));
+	if (!test_bit(SG_FRQ_DIO_IN_USE, srp->frq_bm))
+		sg_remove_sgat_helper(sdp, schp);
+
+	memset(schp, 0, sizeof(*schp));         /* zeros buflen and dlen */
 }
 
 /*
@@ -2049,241 +2674,514 @@ sg_remove_scat(struct sg_fd *sfp, struct sg_scatter_hold *schp)
  * appended to given struct sg_header object.
  */
 static int
-sg_rd_append(struct sg_request *srp, char __user *outp, int num_xfer)
+sg_rd_append(struct sg_request *srp, void __user *outp, int num_xfer)
 {
-	struct sg_scatter_hold *schp = &srp->data;
-	int k, num;
+	int k, num, res;
+	struct page *pgp;
+	struct sg_scatter_hold *schp = &srp->sgat_h;
 
 	SG_LOG(4, srp->parentfp->parentdp, "%s: num_xfer=%d\n", __func__,
 	       num_xfer);
-	if ((!outp) || (num_xfer <= 0))
-		return 0;
+	if (unlikely(!outp || num_xfer <= 0))
+		return (num_xfer == 0 && outp) ? 0 : -EINVAL;
 
 	num = 1 << (PAGE_SHIFT + schp->page_order);
-	for (k = 0; k < schp->k_use_sg && schp->pages[k]; k++) {
+	for (k = 0, res = 0; k < schp->num_sgat; ++k) {
+		pgp = schp->pages[k];
+		if (unlikely(!pgp)) {
+			res = -ENXIO;
+			break;
+		}
 		if (num > num_xfer) {
-			if (__copy_to_user(outp, page_address(schp->pages[k]),
-					   num_xfer))
-				return -EFAULT;
+			if (__copy_to_user(outp, page_address(pgp), num_xfer))
+				res = -EFAULT;
 			break;
 		} else {
-			if (__copy_to_user(outp, page_address(schp->pages[k]),
-					   num))
-				return -EFAULT;
+			if (__copy_to_user(outp, page_address(pgp), num)) {
+				res = -EFAULT;
+				break;
+			}
 			num_xfer -= num;
 			if (num_xfer <= 0)
 				break;
 			outp += num;
 		}
 	}
-
-	return 0;
+	return res;
 }
 
-static void
-sg_build_reserve(struct sg_fd *sfp, int req_size)
+/*
+ * If there are multiple requests outstanding, the speed of this function is
+ * important. SG_PACK_ID_WILDCARD is -1 and that case is typically
+ * the fast path. This function is only used in the non-blocking cases.
+ * Returns pointer to (first) matching sg_request or NULL. If found,
+ * sg_request state is moved from SG_RS_AWAIT_RD to SG_RS_BUSY.
+ */
+static struct sg_request *
+sg_find_srp_by_id(struct sg_fd *sfp, int pack_id)
 {
-	struct sg_scatter_hold *schp = &sfp->reserve;
-
-	SG_LOG(3, sfp ? sfp->parentdp : NULL, "%s: buflen=%d\n", __func__,
-	       req_size);
-	do {
-		if (req_size < PAGE_SIZE)
-			req_size = PAGE_SIZE;
-		if (0 == sg_build_indirect(schp, sfp, req_size))
-			return;
-		else
-			sg_remove_scat(sfp, schp);
-		req_size >>= 1;	/* divide by 2 */
-	} while (req_size > (PAGE_SIZE / 2));
+	__maybe_unused bool is_bad_st = false;
+	__maybe_unused enum sg_rq_state bad_sr_st;
+	bool search_for_1 = (pack_id != SG_PACK_ID_WILDCARD);
+	enum sg_rq_state sr_st;
+	int res;
+	struct sg_request *srp = NULL;
+
+	rcu_read_lock();
+	if (unlikely(search_for_1)) {
+		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+			if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+				continue;
+			if (srp->pack_id != pack_id)
+				continue;
+			sr_st = atomic_read(&srp->rq_st);
+			switch (sr_st) {
+			case SG_RS_AWAIT_RD:
+				res = sg_rstate_chg(srp, sr_st, SG_RS_BUSY);
+				if (likely(res == 0))
+					goto good;
+				/* else another caller got it, move on */
+				if (IS_ENABLED(CONFIG_SCSI_PROC_FS)) {
+					is_bad_st = true;
+					bad_sr_st = atomic_read(&srp->rq_st);
+				}
+				break;
+			case SG_RS_INFLIGHT:
+				break;
+			default:
+				if (IS_ENABLED(CONFIG_SCSI_PROC_FS)) {
+					is_bad_st = true;
+					bad_sr_st = sr_st;
+				}
+				break;
+			}
+			break;	/* problem if same id on > 1 requests */
+		}
+	} else {        /* search for any request is more likely */
+		list_for_each_entry_rcu(srp, &sfp->rq_list, rq_entry) {
+			if (test_bit(SG_FRQ_SYNC_INVOC, srp->frq_bm))
+				continue;
+			sr_st = atomic_read(&srp->rq_st);
+			if (sr_st == SG_RS_AWAIT_RD) {
+				if (likely(sg_rstate_chg(srp, sr_st,
+							 SG_RS_BUSY) == 0))
+					goto good;
+			}
+		}
+	}
+	/* here if one of above loops does _not_ find a match */
+	rcu_read_unlock();
+	if (IS_ENABLED(CONFIG_SCSI_PROC_FS)) {
+		if (search_for_1) {
+			struct sg_device *sdp = sfp->parentdp;
+			const char *cptp = "pack_id=";
+
+			if (is_bad_st)
+				SG_LOG(1, sdp, "%s: %s%d wrong state: %s\n",
+				       __func__, cptp, pack_id,
+				       sg_rq_st_str(bad_sr_st, true));
+			else
+				SG_LOG(6, sdp, "%s: %s%d not awaiting read\n",
+				       __func__, cptp, pack_id);
+		}
+	}
+	return NULL;
+good:
+	rcu_read_unlock();
+	if (search_for_1) {
+		SG_LOG(6, sfp->parentdp, "%s: %s%d found [srp=0x%p]\n",
+		       __func__, "pack_id=", pack_id, srp);
+	}
+	return srp;
 }
 
-static void
-sg_link_reserve(struct sg_fd *sfp, struct sg_request *srp, int size)
+/*
+ * Makes a new sg_request object. If 'first' is set then use GFP_KERNEL which
+ * may take time but has improved chance of success, otherwise use GFP_ATOMIC.
+ * Note that basic initialization is done but srp is not added to either sfp
+ * list. On error returns twisted negated errno value (not NULL).
+ */
+static struct sg_request *
+sg_mk_srp(struct sg_fd *sfp, bool first)
 {
-	struct sg_scatter_hold *req_schp = &srp->data;
-	struct sg_scatter_hold *rsv_schp = &sfp->reserve;
-	int k, num, rem;
-
-	srp->res_used = 1;
-	SG_LOG(4, sfp->parentdp, "%s: size=%d\n", __func__, size);
-	rem = size;
-
-	num = 1 << (PAGE_SHIFT + rsv_schp->page_order);
-	for (k = 0; k < rsv_schp->k_use_sg; k++) {
-		if (rem <= num) {
-			req_schp->k_use_sg = k + 1;
-			req_schp->sglist_len = rsv_schp->sglist_len;
-			req_schp->pages = rsv_schp->pages;
+	struct sg_request *srp;
+	int gfp =  __GFP_NOWARN;
 
-			req_schp->bufflen = size;
-			req_schp->page_order = rsv_schp->page_order;
-			break;
-		} else
-			rem -= num;
+	if (first)      /* prepared to wait if none already outstanding */
+		srp = kzalloc(sizeof(*srp), gfp | GFP_KERNEL);
+	else
+		srp = kzalloc(sizeof(*srp), gfp | GFP_ATOMIC);
+	if (srp) {
+		spin_lock_init(&srp->req_lck);
+		atomic_set(&srp->rq_st, SG_RS_INACTIVE);
+		srp->parentfp = sfp;
+		return srp;
+	} else {
+		return ERR_PTR(-ENOMEM);
 	}
+}
 
-	if (k >= rsv_schp->k_use_sg)
-		SG_LOG(1, sfp->parentdp, "%s: BAD size\n", __func__);
+static struct sg_request *
+sg_mk_srp_sgat(struct sg_fd *sfp, bool first, int db_len)
+{
+	int res;
+	struct sg_request *n_srp = sg_mk_srp(sfp, first);
+
+	if (IS_ERR(n_srp))
+		return n_srp;
+	if (db_len > 0) {
+		res = sg_mk_sgat(n_srp, sfp, db_len);
+		if (res) {
+			kfree(n_srp);
+			return ERR_PTR(res);
+		}
+	}
+	return n_srp;
 }
 
-static void
-sg_unlink_reserve(struct sg_fd *sfp, struct sg_request *srp)
+/*
+ * Irrespective of the given reserve request size, the minimum size requested
+ * will be PAGE_SIZE (often 4096 bytes). Returns a pointer to reserve object or
+ * a negated errno value twisted by ERR_PTR() macro. The actual number of bytes
+ * allocated (maybe less than buflen) is in srp->sgat_h.buflen . Note that this
+ * function is only called in contexts where locking is not required.
+ */
+static struct sg_request *
+sg_build_reserve(struct sg_fd *sfp, int buflen)
 {
-	struct sg_scatter_hold *req_schp = &srp->data;
+	bool go_out = false;
+	int res;
+	struct sg_request *srp;
 
-	SG_LOG(4, srp->parentfp->parentdp, "%s: req->k_use_sg=%d\n", __func__,
-	       (int)req_schp->k_use_sg);
-	req_schp->k_use_sg = 0;
-	req_schp->bufflen = 0;
-	req_schp->pages = NULL;
-	req_schp->page_order = 0;
-	req_schp->sglist_len = 0;
-	srp->res_used = 0;
-	/* Called without mutex lock to avoid deadlock */
-	sfp->res_in_use = 0;
+	SG_LOG(3, sfp ? sfp->parentdp : NULL, "%s: buflen=%d\n", __func__,
+	       buflen);
+	srp = sg_mk_srp(sfp, list_empty(&sfp->rq_fl));
+	if (IS_ERR(srp))
+		return srp;
+	sfp->rsv_srp = srp;
+	do {
+		if (buflen < (int)PAGE_SIZE) {
+			buflen = PAGE_SIZE;
+			go_out = true;
+		}
+		res = sg_mk_sgat(srp, sfp, buflen);
+		if (res == 0) {
+			SG_LOG(4, sfp ? sfp->parentdp : NULL,
+			       "%s: final buflen=%d, srp=0x%p ++\n", __func__,
+			       buflen, srp);
+			return srp;
+		}
+		if (go_out)
+			return ERR_PTR(res);
+		/* failed so remove, halve buflen, try again */
+		sg_remove_sgat(srp);
+		buflen >>= 1;   /* divide by 2 */
+	} while (true);
 }
 
-/* always adds to end of list */
+/*
+ * Adds an active request (soon to carry a SCSI command) to the current file
+ * descriptor by creating a new one or re-using a request from the free
+ * list (fl). If successful returns a valid pointer in SG_RS_BUSY state. On
+ * failure returns a negated errno value twisted by ERR_PTR() macro.
+ */
 static struct sg_request *
-sg_add_request(struct sg_fd *sfp)
+sg_add_request(struct sg_fd *sfp, int dxfr_len, struct sg_comm_wr_t *cwrp)
 {
-	int k;
+	bool act_empty = false;
+	bool mk_new_srp = true;
 	unsigned long iflags;
-	struct sg_request *rp = sfp->req_arr;
+	enum sg_rq_state sr_st;
+	struct sg_request *r_srp = NULL;	/* request to return */
+	struct sg_request *rsv_srp;	/* current fd's reserve request */
+	__maybe_unused struct sg_device *sdp;
+	__maybe_unused const char *cp;
+
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	sdp = sfp->parentdp;
+	rsv_srp = sfp->rsv_srp;
+	cp = "";
+	/*
+	 * Check the free list (fl) for candidates. Pick zero data length
+	 * requests from the back of the fl, the rest from the front.
+	 */
+	if (list_empty(&sfp->rq_fl)) {
+		act_empty = true;
+	} else if (dxfr_len < 1) {  /* 0 data length requests at back of fl */
+		list_for_each_entry_reverse(r_srp, &sfp->rq_fl, fl_entry) {
+			sr_st = atomic_read(&r_srp->rq_st);
+			if (sr_st == SG_RS_INACTIVE) {
+				if (likely(sg_rstate_chg(r_srp, sr_st,
+							 SG_RS_BUSY) == 0)) {
+					cp = "from back of fl";
+					mk_new_srp = false;
+					break;
+				}
+			}
+		}
+	} else { /*     find request with large enough dlen */
+		list_for_each_entry(r_srp, &sfp->rq_fl, fl_entry) {
+			sr_st = atomic_read(&r_srp->rq_st);
+			if (sr_st == SG_RS_INACTIVE &&
+			    r_srp->sgat_h.buflen >= dxfr_len) {
+				if (likely(sg_rstate_chg(r_srp, sr_st,
+							 SG_RS_BUSY) == 0)) {
+					cp = "from front of fl";
+					mk_new_srp = false;
+					break;
+				} /* else other got it, move on */
+			}
+		}
+	}
 
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
-	if (!list_empty(&sfp->rq_list)) {
-		if (!sfp->cmd_q)
-			goto out_unlock;
+	if (mk_new_srp) {	/* Need new sg_request object */
+		bool allow_cmd_q = test_bit(SG_FFD_CMD_Q, sfp->ffd_bm);
 
-		for (k = 0; k < SG_MAX_QUEUE; ++k, ++rp) {
-			if (!rp->parentfp)
-				break;
+		r_srp = NULL;
+		if (!allow_cmd_q && !list_empty(&sfp->rq_list)) {
+			r_srp = ERR_PTR(-EDOM);
+			SG_LOG(6, sdp, "%s: trying 2nd req but cmd_q=false\n",
+			       __func__);
 		}
-		if (k >= SG_MAX_QUEUE)
-			goto out_unlock;
-	}
-	memset(rp, 0, sizeof(struct sg_request));
-	rp->parentfp = sfp;
-	rp->header.duration = jiffies_to_msecs(jiffies);
-	list_add_tail(&rp->entry, &sfp->rq_list);
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return rp;
-out_unlock:
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return NULL;
+		spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+		if (IS_ERR(r_srp))        /* NULL is not an ERR here */
+			goto err_no_lock;
+		/* releasing rq_list_lock because next line could take time */
+		r_srp = sg_mk_srp_sgat(sfp, act_empty, dxfr_len);
+		if (IS_ERR(r_srp))
+			goto err_no_lock;
+		cp = "new";
+		SG_LOG(4, sdp, "%s: mk_new_srp=0x%p ++\n", __func__, r_srp);
+		atomic_set(&r_srp->rq_st, SG_RS_BUSY);
+	} else {	/* otherwise found srp is on fl, remove from fl */
+		list_del_rcu(&r_srp->fl_entry);
+		r_srp->in_resid = 0;
+		r_srp->rq_info = 0;
+		r_srp->sense_len = 0;
+	}
+	if (!mk_new_srp)
+		spin_lock(&r_srp->req_lck);
+	r_srp->frq_bm[0] = cwrp->frq_bm[0];	/* assumes <= 32 req flags */
+	r_srp->sgat_h.dlen = dxfr_len;/* must be <= r_srp->sgat_h.buflen */
+	r_srp->cmd_opcode = 0xff;  /* set invalid opcode (VS), 0x0 is TUR */
+	if (mk_new_srp)
+		spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	list_add_tail_rcu(&r_srp->rq_entry, &sfp->rq_list);
+	if (!mk_new_srp)
+		spin_unlock(&r_srp->req_lck);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+err_no_lock:
+	if (IS_ERR(r_srp))
+		SG_LOG(1, sdp, "%s: err=%ld\n", __func__, PTR_ERR(r_srp));
+	if (!IS_ERR(r_srp))
+		SG_LOG(4, sdp, "%s: %s %sr_srp=0x%p\n", __func__, cp,
+		       ((r_srp == rsv_srp) ? "[rsv] " : ""), r_srp);
+	return r_srp;
 }
 
-/* Return of 1 for found; 0 for not found */
-static int
-sg_remove_request(struct sg_fd *sfp, struct sg_request *srp)
+/*
+ * Moves a completed sg_request object to the free list and sets it to
+ * SG_RS_INACTIVE which makes it available for re-use. Requests with no data
+ * associated are appended to the tail of the free list while other requests
+ * are prepended to the head of the free list.
+ */
+static void
+sg_deact_request(struct sg_fd *sfp, struct sg_request *srp)
 {
+	bool on_fl = false;
+	int dlen, buflen;
 	unsigned long iflags;
-	int res = 0;
+	struct sg_request *t_srp;
+	struct sg_scatter_hold *schp;
+	const char *cp = "head";
 
-	if (!sfp || !srp || list_empty(&sfp->rq_list))
-		return res;
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
-	if (!list_empty(&srp->entry)) {
-		list_del(&srp->entry);
-		srp->parentfp = NULL;
-		res = 1;
+	if (WARN_ON(!sfp || !srp))
+		return;
+	schp = &srp->sgat_h;	/* make sure it is own data buffer */
+	spin_lock_irqsave(&sfp->rq_list_lock, iflags);
+	atomic_set(&srp->rq_st, SG_RS_BUSY);
+	list_del_rcu(&srp->rq_entry);
+	/*
+	 * N.B. sg_request object is not de-allocated (freed). The contents
+	 * of the rq_list and rq_fl lists are de-allocated (freed) when
+	 * the owning file descriptor is closed. The free list acts as a LIFO
+	 * for same size (buflen) sg_request objects. This can improve the
+	 * chance of a cache hit when the sg_request object is re-used.
+	 */
+	dlen = schp->dlen;
+	buflen = schp->buflen;
+	/* want ascending free list by dlen, but dlen==0 at end */
+	if (dlen > 0) {
+		list_for_each_entry(t_srp, &sfp->rq_fl, fl_entry) {
+			if (buflen <= t_srp->sgat_h.buflen ||
+			    t_srp->sgat_h.buflen == 0) {
+				/* add srp _before_ t_srp on fl */
+				list_add_tail_rcu(&srp->fl_entry,
+						  &t_srp->fl_entry);
+				on_fl = true;
+				cp = "ascending pos";
+				break;
+			}
+		}
 	}
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-	return res;
+	if (!on_fl) { /* either empty list, dlen=0 or buflen highest */
+		list_add_tail_rcu(&srp->fl_entry, &sfp->rq_fl);
+		cp = "tail";
+	}
+	SG_LOG(5, sfp->parentdp, "%s: %ssrp=0x%p move to fl %s\n", __func__,
+	       ((sfp->rsv_srp == srp) ? "rsv " : ""), srp, cp);
+	spin_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	atomic_set(&srp->rq_st, SG_RS_INACTIVE);
 }
 
+/* Returns pointer to sg_fd object or negated errno twisted by ERR_PTR */
 static struct sg_fd *
 sg_add_sfp(struct sg_device *sdp)
 {
-	struct sg_fd *sfp;
+	bool reduced = false;
+	int rbuf_len;
 	unsigned long iflags;
-	int bufflen;
+	long err;
+	struct sg_fd *sfp;
+	struct sg_request *srp;
 
 	sfp = kzalloc(sizeof(*sfp), GFP_ATOMIC | __GFP_NOWARN);
-	if (!sfp)
+	if (!sfp) {
+		SG_LOG(1, sdp, "%s: sfp allocation failed\n", __func__);
 		return ERR_PTR(-ENOMEM);
-
+	}
 	init_waitqueue_head(&sfp->read_wait);
-	rwlock_init(&sfp->rq_list_lock);
+	spin_lock_init(&sfp->rq_list_lock);
 	INIT_LIST_HEAD(&sfp->rq_list);
+	INIT_LIST_HEAD(&sfp->rq_fl);
 	kref_init(&sfp->f_ref);
 	mutex_init(&sfp->f_mutex);
 	sfp->timeout = SG_DEFAULT_TIMEOUT;
 	sfp->timeout_user = SG_DEFAULT_TIMEOUT_USER;
-	sfp->force_packid = SG_DEF_FORCE_PACK_ID;
-	sfp->cmd_q = SG_DEF_COMMAND_Q;
-	sfp->keep_orphan = SG_DEF_KEEP_ORPHAN;
+	/* other bits in sfp->ffd_bm[1] cleared by kzalloc() above */
+	assign_bit(SG_FFD_FORCE_PACKID, sfp->ffd_bm, SG_DEF_FORCE_PACK_ID);
+	assign_bit(SG_FFD_CMD_Q, sfp->ffd_bm, SG_DEF_COMMAND_Q);
+	assign_bit(SG_FFD_KEEP_ORPHAN, sfp->ffd_bm, SG_DEF_KEEP_ORPHAN);
+	assign_bit(SG_FFD_Q_AT_TAIL, sfp->ffd_bm, SG_DEFAULT_Q_AT);
+	/*
+	 * SG_SCATTER_SZ initializes scatter_elem_sz but different value may
+	 * be given as driver/module parameter (e.g. 'scatter_elem_sz=8192').
+	 * Any user provided number will be changed to be PAGE_SIZE as a
+	 * minimum, otherwise it will be rounded down (if required) to a
+	 * power of 2. So it will always be a power of 2.
+	 */
+	sfp->sgat_elem_sz = scatter_elem_sz;
 	sfp->parentdp = sdp;
-	write_lock_irqsave(&sdp->sfd_lock, iflags);
 	if (atomic_read(&sdp->detaching)) {
-		write_unlock_irqrestore(&sdp->sfd_lock, iflags);
 		kfree(sfp);
+		SG_LOG(1, sdp, "%s: detaching\n", __func__);
 		return ERR_PTR(-ENODEV);
 	}
-	list_add_tail(&sfp->sfd_siblings, &sdp->sfds);
-	write_unlock_irqrestore(&sdp->sfd_lock, iflags);
-	SG_LOG(3, sdp, "%s: sfp=0x%p\n", __func__, sfp);
 	if (unlikely(sg_big_buff != def_reserved_size))
 		sg_big_buff = def_reserved_size;
 
-	bufflen = min_t(int, sg_big_buff,
-			max_sectors_bytes(sdp->device->request_queue));
-	sg_build_reserve(sfp, bufflen);
-	SG_LOG(3, sdp, "%s: bufflen=%d, k_use_sg=%d\n", __func__,
-	       sfp->reserve.bufflen, sfp->reserve.k_use_sg);
-
+	rbuf_len = min_t(int, sg_big_buff, sdp->max_sgat_sz);
+	if (rbuf_len > 0) {
+		srp = sg_build_reserve(sfp, rbuf_len);
+		if (IS_ERR(srp)) {
+			kfree(sfp);
+			err = PTR_ERR(srp);
+			SG_LOG(1, sdp, "%s: build reserve err=%ld\n", __func__,
+			       -err);
+			return ERR_PTR(err);
+		}
+		if (srp->sgat_h.buflen < rbuf_len) {
+			reduced = true;
+			SG_LOG(2, sdp,
+			       "%s: reserve reduced from %d to buflen=%d\n",
+			       __func__, rbuf_len, srp->sgat_h.buflen);
+		}
+		/* will be first element so head or tail doesn't matter */
+		list_add_tail_rcu(&srp->fl_entry, &sfp->rq_fl);
+	}
+	if (!reduced) {
+		SG_LOG(4, sdp, "%s: built reserve buflen=%d\n", __func__,
+		       rbuf_len);
+	}
+	write_lock_irqsave(&sdp->sfd_llock, iflags);
+	list_add_tail(&sfp->sfd_entry, &sdp->sfds);
 	kref_get(&sdp->d_ref);
 	__module_get(THIS_MODULE);
+	write_unlock_irqrestore(&sdp->sfd_llock, iflags);
+	SG_LOG(3, sdp, "%s: success, sfp=0x%p ++\n", __func__, sfp);
 	return sfp;
 }
 
+/*
+ * A successful call to sg_release() will result, at some later time, to this
+ * function being invoked. All requests associated with this file descriptor
+ * should be completed or cancelled when this function is called (due to
+ * sfp->f_ref). Also the file descriptor itself has not been accessible since
+ * it was list_del()-ed by the preceding sg_remove_sfp() call. So no locking
+ * is required. sdp should never be NULL but to make debugging more robust,
+ * this function will not blow up in that case.
+ */
 static void
 sg_remove_sfp_usercontext(struct work_struct *work)
 {
-	struct sg_fd *sfp = container_of(work, struct sg_fd, ew.work);
-	struct sg_device *sdp = sfp->parentdp;
+	struct sg_fd *sfp = container_of(work, struct sg_fd, ew_fd.work);
+	struct sg_device *sdp;
 	struct sg_request *srp;
-	unsigned long iflags;
-
-	/* Cleanup any responses which were never read(). */
-	write_lock_irqsave(&sfp->rq_list_lock, iflags);
-	while (!list_empty(&sfp->rq_list)) {
-		srp = list_first_entry(&sfp->rq_list, struct sg_request, entry);
-		sg_finish_rem_req(srp);
-		list_del(&srp->entry);
-		srp->parentfp = NULL;
-	}
-	write_unlock_irqrestore(&sfp->rq_list_lock, iflags);
+	__maybe_unused const char *cp = " srp=0x";
 
-	if (sfp->reserve.bufflen > 0) {
-		SG_LOG(6, sdp, "%s:    bufflen=%d, k_use_sg=%d\n", __func__,
-		       (int)sfp->reserve.bufflen, (int)sfp->reserve.k_use_sg);
-		sg_remove_scat(sfp, &sfp->reserve);
+	if (!sfp) {
+		pr_warn("sg: %s: sfp is NULL\n", __func__);
+		return;
 	}
+	sdp = sfp->parentdp;
 
-	SG_LOG(6, sdp, "%s: sfp=0x%p\n", __func__, sfp);
+	/* Cleanup any responses which were never read(). */
+	while (!list_empty(&sfp->rq_list)) {
+		srp = list_last_entry(&sfp->rq_list, struct sg_request,
+				      rq_entry);
+		if (!srp)
+			continue;
+		sg_finish_scsi_blk_rq(srp);
+		list_del(&srp->rq_entry);
+		if (srp->sgat_h.buflen > 0)
+			sg_remove_sgat(srp);
+		SG_LOG(6, sdp, "%s:%s%p --\n", __func__, cp, srp);
+		kfree(srp);
+	}
+	while (!list_empty(&sfp->rq_fl)) {
+		srp = list_last_entry(&sfp->rq_fl, struct sg_request,
+				      fl_entry);
+		if (!srp)
+			continue;
+		list_del(&srp->fl_entry);
+		if (srp->sgat_h.buflen > 0)
+			sg_remove_sgat(srp);
+		SG_LOG(6, sdp, "%s: fl%s%p --\n", __func__, cp, srp);
+		kfree(srp);
+	}
+	SG_LOG(3, sdp, "%s: kfree: sfp=0x%p --\n", __func__, sfp);
 	kfree(sfp);
 
-	scsi_device_put(sdp->device);
-	kref_put(&sdp->d_ref, sg_device_destroy);
+	if (sdp) {
+		scsi_device_put(sdp->device);
+		kref_put(&sdp->d_ref, sg_device_destroy);
+	}
 	module_put(THIS_MODULE);
 }
 
 static void
 sg_remove_sfp(struct kref *kref)
 {
+	unsigned long iflags;
 	struct sg_fd *sfp = container_of(kref, struct sg_fd, f_ref);
 	struct sg_device *sdp = sfp->parentdp;
-	unsigned long iflags;
 
-	write_lock_irqsave(&sdp->sfd_lock, iflags);
-	list_del(&sfp->sfd_siblings);
-	write_unlock_irqrestore(&sdp->sfd_lock, iflags);
+	write_lock_irqsave(&sdp->sfd_llock, iflags);
+	list_del(&sfp->sfd_entry);
+	write_unlock_irqrestore(&sdp->sfd_llock, iflags);
 
-	INIT_WORK(&sfp->ew.work, sg_remove_sfp_usercontext);
-	schedule_work(&sfp->ew.work);
+	INIT_WORK(&sfp->ew_fd.work, sg_remove_sfp_usercontext);
+	schedule_work(&sfp->ew_fd.work);
 }
 
 static int
@@ -2326,10 +3224,37 @@ sg_get_dev(int dev)
 	return sdp;
 }
 
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS)
+static const char *
+sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
+{
+	switch (rq_st) {	/* request state */
+	case SG_RS_INACTIVE:
+		return long_str ? "inactive" :  "ina";
+	case SG_RS_INFLIGHT:
+		return long_str ? "inflight" : "act";
+	case SG_RS_AWAIT_RD:
+		return long_str ? "await_read" : "rcv";
+	case SG_RS_DONE_RD:
+		return long_str ? "done_read" : "fin";
+	case SG_RS_BUSY:
+		return long_str ? "busy" : "bsy";
+	default:
+		return long_str ? "unknown" : "unk";
+	}
+}
+#else
+static const char *
+sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
+{
+	return "";
+}
+#endif
+
 #if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* long, almost to end of file */
 static int sg_proc_seq_show_int(struct seq_file *s, void *v);
 
-static int sg_proc_single_open_adio(struct inode *inode, struct file *file);
+static int sg_proc_single_open_adio(struct inode *inode, struct file *filp);
 static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
 			          size_t count, loff_t *off);
 static const struct file_operations adio_fops = {
@@ -2341,7 +3266,7 @@ static const struct file_operations adio_fops = {
 	.release = single_release,
 };
 
-static int sg_proc_single_open_dressz(struct inode *inode, struct file *file);
+static int sg_proc_single_open_dressz(struct inode *inode, struct file *filp);
 static ssize_t sg_proc_write_dressz(struct file *filp, 
 		const char __user *buffer, size_t count, loff_t *off);
 static const struct file_operations dressz_fops = {
@@ -2374,12 +3299,12 @@ static const struct seq_operations devstrs_seq_ops = {
 	.show  = sg_proc_seq_show_devstrs,
 };
 
-static int sg_proc_seq_show_debug(struct seq_file *s, void *v);
-static const struct seq_operations debug_seq_ops = {
+static int sg_proc_seq_show_dbg(struct seq_file *s, void *v);
+static const struct seq_operations dbg_seq_ops = {
 	.start = dev_seq_start,
 	.next  = dev_seq_next,
 	.stop  = dev_seq_stop,
-	.show  = sg_proc_seq_show_debug,
+	.show  = sg_proc_seq_show_dbg,
 };
 
 static int
@@ -2391,13 +3316,13 @@ sg_proc_init(void)
 	if (!p)
 		return 1;
 
-	proc_create("allow_dio", S_IRUGO | S_IWUSR, p, &adio_fops);
-	proc_create_seq("debug", S_IRUGO, p, &debug_seq_ops);
-	proc_create("def_reserved_size", S_IRUGO | S_IWUSR, p, &dressz_fops);
-	proc_create_single("device_hdr", S_IRUGO, p, sg_proc_seq_show_devhdr);
-	proc_create_seq("devices", S_IRUGO, p, &dev_seq_ops);
-	proc_create_seq("device_strs", S_IRUGO, p, &devstrs_seq_ops);
-	proc_create_single("version", S_IRUGO, p, sg_proc_seq_show_version);
+	proc_create("allow_dio", 0644, p, &adio_fops);
+	proc_create_seq("debug", 0444, p, &dbg_seq_ops);
+	proc_create("def_reserved_size", 0644, p, &dressz_fops);
+	proc_create_single("device_hdr", 0444, p, sg_proc_seq_show_devhdr);
+	proc_create_seq("devices", 0444, p, &dev_seq_ops);
+	proc_create_seq("device_strs", 0444, p, &devstrs_seq_ops);
+	proc_create_single("version", 0444, p, sg_proc_seq_show_version);
 	return 0;
 }
 
@@ -2421,9 +3346,9 @@ sg_proc_seq_show_int(struct seq_file *s, void *v)
 }
 
 static int
-sg_proc_single_open_adio(struct inode *inode, struct file *file)
+sg_proc_single_open_adio(struct inode *inode, struct file *filp)
 {
-	return single_open(file, sg_proc_seq_show_int, &sg_allow_dio);
+	return single_open(filp, sg_proc_seq_show_int, &sg_allow_dio);
 }
 
 static ssize_t 
@@ -2443,9 +3368,9 @@ sg_proc_write_adio(struct file *filp, const char __user *buffer,
 }
 
 static int
-sg_proc_single_open_dressz(struct inode *inode, struct file *file)
+sg_proc_single_open_dressz(struct inode *inode, struct file *filp)
 {
-	return single_open(file, sg_proc_seq_show_int, &sg_big_buff);
+	return single_open(filp, sg_proc_seq_show_int, &sg_big_buff);
 }
 
 static ssize_t 
@@ -2486,12 +3411,13 @@ sg_proc_seq_show_devhdr(struct seq_file *s, void *v)
 struct sg_proc_deviter {
 	loff_t	index;
 	size_t	max;
+	int fd_index;
 };
 
 static void *
 dev_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct sg_proc_deviter * it = kmalloc(sizeof(*it), GFP_KERNEL);
+	struct sg_proc_deviter *it = kzalloc(sizeof(*it), GFP_KERNEL);
 
 	s->private = it;
 	if (! it)
@@ -2507,7 +3433,7 @@ dev_seq_start(struct seq_file *s, loff_t *pos)
 static void *
 dev_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct sg_proc_deviter * it = s->private;
+	struct sg_proc_deviter *it = s->private;
 
 	*pos = ++it->index;
 	return (it->index < it->max) ? it : NULL;
@@ -2522,7 +3448,7 @@ dev_seq_stop(struct seq_file *s, void *v)
 static int
 sg_proc_seq_show_dev(struct seq_file *s, void *v)
 {
-	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
+	struct sg_proc_deviter *it = (struct sg_proc_deviter *)v;
 	struct sg_device *sdp;
 	struct scsi_device *scsidp;
 	unsigned long iflags;
@@ -2549,7 +3475,7 @@ sg_proc_seq_show_dev(struct seq_file *s, void *v)
 static int
 sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 {
-	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
+	struct sg_proc_deviter *it = (struct sg_proc_deviter *)v;
 	struct sg_device *sdp;
 	struct scsi_device *scsidp;
 	unsigned long iflags;
@@ -2566,111 +3492,196 @@ sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 	return 0;
 }
 
-/* must be called while holding sg_index_lock */
-static void
-sg_proc_debug_helper(struct seq_file *s, struct sg_device *sdp)
+/* Writes debug info for one sg_request in obp buffer */
+static int
+sg_proc_dbg_sreq(struct sg_request *srp, int to, char *obp, int len)
+	__must_hold(&srp->req_lck)
+{
+	bool is_v3, is_dur;
+	int n = 0;
+	u32 dur;
+	enum sg_rq_state rq_st;
+	const char *cp;
+
+	if (len < 1)
+		return 0;
+	is_v3 = (srp->s_hdr3.interface_id != '\0');
+	if (srp->parentfp->rsv_srp == srp)
+		cp = (is_v3 && (srp->rq_flags & SG_FLAG_MMAP_IO)) ?
+				"     mmap>> " : "     rsv>> ";
+	else
+		cp = (srp->rq_info & SG_INFO_DIRECT_IO_MASK) ?
+				"     dio>> " : "     ";
+	rq_st = atomic_read(&srp->rq_st);
+	dur = sg_get_dur(srp, &rq_st, &is_dur);
+	n += scnprintf(obp + n, len - n, "%s%s: dlen=%d/%d id=%d", cp,
+		       sg_rq_st_str(rq_st, false), srp->sgat_h.dlen,
+		       srp->sgat_h.buflen, (int)srp->pack_id);
+	if (is_dur)	/* cmd/req has completed, waiting for ... */
+		n += scnprintf(obp + n, len - n, " dur=%ums", dur);
+	else if (dur < U32_MAX)	/* in-flight or busy (so ongoing) */
+		n += scnprintf(obp + n, len - n, " t_o/elap=%us/%ums",
+			       to / 1000, dur);
+	n += scnprintf(obp + n, len - n, " sgat=%d op=0x%02x\n",
+		       srp->sgat_h.num_sgat, srp->cmd_opcode);
+	return n;
+}
+
+/* Writes debug info for one sg fd (including its sg requests) in obp buffer */
+static int
+sg_proc_dbg_fd(struct sg_fd *fp, char *obp, int len)
+	__must_hold(&sfp->rq_list_lock)
 {
-	int k, new_interface, blen, usg;
+	bool first_fl;
+	int n = 0;
+	int to;
 	struct sg_request *srp;
-	struct sg_fd *fp;
-	const sg_io_hdr_t *hp;
-	const char * cp;
-	unsigned int ms;
-
-	k = 0;
-	list_for_each_entry(fp, &sdp->sfds, sfd_siblings) {
-		k++;
-		read_lock(&fp->rq_list_lock); /* irqs already disabled */
-		seq_printf(s, "   FD(%d): timeout=%dms bufflen=%d "
-			   "(res)sgat=%d low_dma=%d\n", k,
-			   jiffies_to_msecs(fp->timeout),
-			   fp->reserve.bufflen,
-			   (int) fp->reserve.k_use_sg,
-			   (int) sdp->device->host->unchecked_isa_dma);
-		seq_printf(s, "   cmd_q=%d f_packid=%d k_orphan=%d closed=0\n",
-			   (int) fp->cmd_q, (int) fp->force_packid,
-			   (int) fp->keep_orphan);
-		list_for_each_entry(srp, &fp->rq_list, entry) {
-			hp = &srp->header;
-			new_interface = (hp->interface_id == '\0') ? 0 : 1;
-			if (srp->res_used) {
-				if (new_interface &&
-				    (SG_FLAG_MMAP_IO & hp->flags))
-					cp = "     mmap>> ";
-				else
-					cp = "     rb>> ";
-			} else {
-				if (SG_INFO_DIRECT_IO_MASK & hp->info)
-					cp = "     dio>> ";
-				else
-					cp = "     ";
-			}
-			seq_puts(s, cp);
-			blen = srp->data.bufflen;
-			usg = srp->data.k_use_sg;
-			seq_puts(s, srp->done ?
-				 ((1 == srp->done) ?  "rcv:" : "fin:")
-				  : "act:");
-			seq_printf(s, " id=%d blen=%d",
-				   srp->header.pack_id, blen);
-			if (srp->done)
-				seq_printf(s, " dur=%d", hp->duration);
-			else {
-				ms = jiffies_to_msecs(jiffies);
-				seq_printf(s, " t_o/elap=%d/%d",
-					(new_interface ? hp->timeout :
-						  jiffies_to_msecs(fp->timeout)),
-					(ms > hp->duration ? ms - hp->duration : 0));
-			}
-			seq_printf(s, "ms sgat=%d op=0x%02x\n", usg,
-				   (int) srp->data.cmd_opcode);
+
+	/* sgat=-1 means unavailable */
+	to = jiffies_to_msecs(fp->timeout);
+	if (to % 1000)
+		n += scnprintf(obp + n, len - n, "timeout=%dms rs", to);
+	else
+		n += scnprintf(obp + n, len - n, "timeout=%ds rs", to / 1000);
+	n += scnprintf(obp + n, len - n, "v_buflen=%d\n   cmd_q=%d ",
+		       fp->rsv_srp->sgat_h.buflen,
+		       (int)test_bit(SG_FFD_CMD_Q, fp->ffd_bm));
+	n += scnprintf(obp + n, len - n,
+		       "f_packid=%d k_orphan=%d ffd_bm=0x%lx\n",
+		       (int)test_bit(SG_FFD_FORCE_PACKID, fp->ffd_bm),
+		       (int)test_bit(SG_FFD_KEEP_ORPHAN, fp->ffd_bm),
+		       fp->ffd_bm[0]);
+	n += scnprintf(obp + n, len - n, "   mmap_called=%d\n",
+		       test_bit(SG_FFD_MMAP_CALLED, fp->ffd_bm));
+	n += scnprintf(obp + n, len - n,
+		       "   submitted=%d waiting=%d   open thr_id=%d\n",
+		       atomic_read(&fp->submitted),
+		       atomic_read(&fp->waiting), fp->tid);
+	list_for_each_entry_rcu(srp, &fp->rq_list, rq_entry) {
+		spin_lock(&srp->req_lck);
+		n += sg_proc_dbg_sreq(srp, fp->timeout, obp + n, len - n);
+		spin_unlock(&srp->req_lck);
+	}
+	if (list_empty(&fp->rq_list))
+		n += scnprintf(obp + n, len - n, "     No requests active\n");
+	first_fl = true;
+	list_for_each_entry_rcu(srp, &fp->rq_fl, fl_entry) {
+		if (first_fl) {
+			n += scnprintf(obp + n, len - n, "   Free list:\n");
+			first_fl = false;
 		}
-		if (list_empty(&fp->rq_list))
-			seq_puts(s, "     No requests active\n");
-		read_unlock(&fp->rq_list_lock);
+		spin_lock(&srp->req_lck);
+		n += sg_proc_dbg_sreq(srp, fp->timeout, obp + n, len - n);
+		spin_unlock(&srp->req_lck);
 	}
+	return n;
 }
 
+/* Writes debug info for one sg device (including its sg fds) in obp buffer */
 static int
-sg_proc_seq_show_debug(struct seq_file *s, void *v)
+sg_proc_dbg_sdev(struct sg_device *sdp, char *obp, int len, int *fd_counterp)
+	__must_hold(&sdp->sfd_llock)
 {
-	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
-	struct sg_device *sdp;
+	int n = 0;
+	int my_count = 0;
+	struct scsi_device *ssdp = sdp->device;
+	struct sg_fd *fp;
+	char *disk_name;
+	int *countp;
+
+	countp = fd_counterp ? fd_counterp : &my_count;
+	disk_name = (sdp->disk ? sdp->disk->disk_name : "?_?");
+	n += scnprintf(obp + n, len - n, " >>> device=%s ", disk_name);
+	n += scnprintf(obp + n, len - n, "%d:%d:%d:%llu ", ssdp->host->host_no,
+		       ssdp->channel, ssdp->id, ssdp->lun);
+	n += scnprintf(obp + n, len - n,
+		       "  max_sgat_sz,elems=2^%d,%d excl=%d open_cnt=%d\n",
+		       ilog2(sdp->max_sgat_sz), sdp->max_sgat_elems,
+		       sdp->exclude, sdp->open_cnt);
+	list_for_each_entry(fp, &sdp->sfds, sfd_entry) {
+		++*countp;
+		rcu_read_lock(); /* assume irqs disabled */
+		n += scnprintf(obp + n, len - n, "  FD(%d): ", *countp);
+		n += sg_proc_dbg_fd(fp, obp + n, len - n);
+		rcu_read_unlock();
+	}
+	return n;
+}
+
+/* Called via dbg_seq_ops once for each sg device */
+static int
+sg_proc_seq_show_dbg(struct seq_file *s, void *v)
+{
+	bool found = false;
+	bool trunc = false;
+	const int bp_len = SG_PROC_DEBUG_SZ;
+	int n = 0;
+	int k = 0;
 	unsigned long iflags;
+	struct sg_proc_deviter *it = (struct sg_proc_deviter *)v;
+	struct sg_device *sdp;
+	int *fdi_p;
+	char *bp;
+	char *disk_name;
+	char b1[128];
 
+	b1[0] = '\0';
 	if (it && (0 == it->index))
 		seq_printf(s, "max_active_device=%d  def_reserved_size=%d\n",
-			   (int)it->max, sg_big_buff);
-
+			   (int)it->max, def_reserved_size);
+	fdi_p = it ? &it->fd_index : &k;
+	bp = kzalloc(bp_len, __GFP_NOWARN | GFP_KERNEL);
+	if (!bp) {
+		seq_printf(s, "%s: Unable to allocate %d on heap, finish\n",
+			   __func__, bp_len);
+		return -1;
+	}
 	read_lock_irqsave(&sg_index_lock, iflags);
 	sdp = it ? sg_lookup_dev(it->index) : NULL;
 	if (NULL == sdp)
 		goto skip;
-	read_lock(&sdp->sfd_lock);
+	read_lock(&sdp->sfd_llock);
 	if (!list_empty(&sdp->sfds)) {
-		seq_printf(s, " >>> device=%s ", sdp->disk->disk_name);
+		found = true;
+		disk_name = (sdp->disk ? sdp->disk->disk_name : "?_?");
 		if (atomic_read(&sdp->detaching))
-			seq_puts(s, "detaching pending close ");
+			snprintf(b1, sizeof(b1), " >>> device=%s  %s\n",
+				 disk_name, "detaching pending close\n");
 		else if (sdp->device) {
-			struct scsi_device *scsidp = sdp->device;
-
-			seq_printf(s, "%d:%d:%d:%llu   em=%d",
-				   scsidp->host->host_no,
-				   scsidp->channel, scsidp->id,
-				   scsidp->lun,
-				   scsidp->host->hostt->emulated);
+			n = sg_proc_dbg_sdev(sdp, bp, bp_len, fdi_p);
+			if (n >= bp_len - 1) {
+				trunc = true;
+				if (bp[bp_len - 2] != '\n')
+					bp[bp_len - 2] = '\n';
+			}
+		} else {
+			snprintf(b1, sizeof(b1), " >>> device=%s  %s\n",
+				 disk_name, "sdp->device==NULL, skip");
 		}
-		seq_printf(s, " sg_tablesize=%d excl=%d open_cnt=%d\n",
-			   sdp->sg_tablesize, sdp->exclude, sdp->open_cnt);
-		sg_proc_debug_helper(s, sdp);
 	}
-	read_unlock(&sdp->sfd_lock);
+	read_unlock(&sdp->sfd_llock);
 skip:
 	read_unlock_irqrestore(&sg_index_lock, iflags);
+	if (found) {
+		if (n > 0) {
+			seq_puts(s, bp);
+			if (seq_has_overflowed(s))
+				goto s_ovfl;
+			if (trunc)
+				seq_printf(s, "   >> Output truncated %s\n",
+					   "due to buffer size");
+		} else if (b1[0]) {
+			seq_puts(s, b1);
+			if (seq_has_overflowed(s))
+				goto s_ovfl;
+		}
+	}
+s_ovfl:
+	kfree(bp);
 	return 0;
 }
 
-#endif				/* CONFIG_SCSI_PROC_FS (~800 lines back) */
+#endif			/* CONFIG_SCSI_PROC_FS (~600 lines back) */
 
 module_init(init_sg);
 module_exit(exit_sg);
-- 
2.17.1

