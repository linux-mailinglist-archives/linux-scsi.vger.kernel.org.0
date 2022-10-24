Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC36098CB
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Oct 2022 05:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJXDZd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 23 Oct 2022 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJXDXD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 23 Oct 2022 23:23:03 -0400
Received: from smtp.infotech.no (smtp.infotech.no [82.134.31.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 810F374B82
        for <linux-scsi@vger.kernel.org>; Sun, 23 Oct 2022 20:21:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 167C42041CB;
        Mon, 24 Oct 2022 05:21:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zn5SEYlK2NOZ; Mon, 24 Oct 2022 05:21:50 +0200 (CEST)
Received: from treten.bingwo.ca (unknown [10.16.20.11])
        by smtp.infotech.no (Postfix) with ESMTPA id B74782041AF;
        Mon, 24 Oct 2022 05:21:49 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bvanassche@acm.org
Subject: [PATCH v25 33/44] sg: first debugfs support
Date:   Sun, 23 Oct 2022 23:20:47 -0400
Message-Id: <20221024032058.14077-34-dgilbert@interlog.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024032058.14077-1-dgilbert@interlog.com>
References: <20221024032058.14077-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Duplicate the semantics of 'cat /proc/scsi/sg/debug' on
'cat /sys/kernel/debug/scsi_generic/snapshot'. Make code
that generates the snapshot conditional on either
CONFIG_SCSI_PROC_FS or CONFIG_DEBUG_FS being defined.

Also add snapshot_devs which can be written with a list of
comma separated integers corresponding to sg (minor) device
numbers. That file can also be read showing that list. Minus
one (or any negative number) means accept all when in the
first position (the default) or means the end of the list
in a later position. When a subsequent
cat /sys/kernel/debug/scsi_generic/snapshot
is performed, only sg device numbers matching an element
in that list are output.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 404 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 332 insertions(+), 72 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 5079a449111e..5ccd410e4a53 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -44,6 +44,7 @@ static char *sg_version_date = "20190606";
 #include <linux/cred.h>			/* for sg_check_file_access() */
 #include <linux/proc_fs.h>
 #include <linux/xarray.h>
+#include <linux/debugfs.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -71,6 +72,10 @@ static char *sg_version_date = "20190606";
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS) || IS_ENABLED(CONFIG_DEBUG_FS)
+#define CONFIG_SG_PROC_OR_DEBUG_FS 1
+#endif
+
 /* SG_MAX_CDB_SIZE should be 260 (spc4r37 section 3.1.30) however the type
  * of sg_io_hdr::cmd_len can only represent 255. All SCSI commands greater
  * than 16 bytes are "variable length" whose length is a multiple of 4, so:
@@ -271,6 +276,8 @@ struct sg_comm_wr_t {  /* arguments to sg_common_write() */
 static enum rq_end_io_ret sg_rq_end_io(struct request *rq, blk_status_t status);
 /* Declarations of other static functions used before they are defined */
 static int sg_proc_init(void);
+static void sg_dfs_init(void);
+static void sg_dfs_exit(void);
 static int sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp,
 			int dxfer_dir);
 static void sg_finish_scsi_blk_rq(struct sg_request *srp);
@@ -2629,22 +2636,6 @@ sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
 	kref_put(&sdp->d_ref, sg_device_destroy);
 }
 
-module_param_named(scatter_elem_sz, scatter_elem_sz, int, S_IRUGO | S_IWUSR);
-module_param_named(def_reserved_size, def_reserved_size, int,
-		   S_IRUGO | S_IWUSR);
-module_param_named(allow_dio, sg_allow_dio, int, S_IRUGO | S_IWUSR);
-
-MODULE_AUTHOR("Douglas Gilbert");
-MODULE_DESCRIPTION("SCSI generic (sg) driver");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(SG_VERSION_STR);
-MODULE_ALIAS_CHARDEV_MAJOR(SCSI_GENERIC_MAJOR);
-
-MODULE_PARM_DESC(scatter_elem_sz, "scatter gather element "
-                "size (default: max(SG_SCATTER_SZ, PAGE_SIZE))");
-MODULE_PARM_DESC(def_reserved_size, "size of buffer reserved for each fd");
-MODULE_PARM_DESC(allow_dio, "allow direct I/O (default: 0 (disallow))");
-
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 
@@ -2725,6 +2716,7 @@ init_sg(void)
 	rc = scsi_register_interface(&sg_interface);
 	if (rc == 0) {
 		sg_proc_init();
+		sg_dfs_init();
 		return 0;
 	}
 	class_destroy(sg_sysfs_class);
@@ -2742,6 +2734,7 @@ init_sg(void)
 static void __exit
 exit_sg(void)
 {
+	sg_dfs_exit();
 	unregister_sg_sysctls();
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS))
 		remove_proc_subtree("scsi/sg", NULL);
@@ -3148,7 +3141,7 @@ sg_find_srp_by_id(struct sg_fd *sfp, int pack_id, bool *busy)
 	}
 	if (IS_ENABLED(CONFIG_SCSI_PROC_FS)) {
 		if (search_for_1) {
-			const char *cptp = "pack_id=";
+			__maybe_unused const char *cptp = "pack_id=";
 
 			if (is_bad_st)
 				SG_LOG(1, sfp, "%s: %s%d wrong state: %s\n",
@@ -3585,17 +3578,6 @@ sg_remove_sfp(struct kref *kref)
 	schedule_work(&sfp->ew_fd.work);
 }
 
-static int
-sg_idr_max_id(int id, void *p, void *data)
-		__must_hold(sg_index_lock)
-{
-	int *k = data;
-
-	if (*k < id)
-		*k = id;
-	return 0;
-}
-
 /* must be called with sg_index_lock held */
 static struct sg_device *
 sg_lookup_dev(int dev)
@@ -3625,7 +3607,7 @@ sg_get_dev(int dev)
 	return sdp;
 }
 
-#if IS_ENABLED(CONFIG_SCSI_PROC_FS)
+#if IS_ENABLED(CONFIG_SG_PROC_OR_DEBUG_FS)
 static const char *
 sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 {
@@ -3652,7 +3634,35 @@ sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* long, almost to end of file */
+#if IS_ENABLED(CONFIG_SG_PROC_OR_DEBUG_FS)
+
+#define SG_SNAPSHOT_DEV_MAX 4
+
+/*
+ * For snapshot_devs array, -1 or two adjacent the same is terminator.
+ * -1 in first element of first two elements the same implies all.
+ */
+static struct sg_dfs_context_t {
+	struct dentry *dfs_rootdir;
+	int snapshot_devs[SG_SNAPSHOT_DEV_MAX];
+} sg_dfs_cxt;
+
+struct sg_proc_deviter {
+	loff_t	index;
+	size_t	max;
+	int fd_index;
+};
+
+static int
+sg_idr_max_id(int id, void *p, void *data)
+		__must_hold(sg_index_lock)
+{
+	int *k = data;
+
+	if (*k < id)
+		*k = id;
+	return 0;
+}
 
 static int
 sg_last_dev(void)
@@ -3666,6 +3676,41 @@ sg_last_dev(void)
 	return k + 1;		/* origin 1 */
 }
 
+static void *
+dev_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct sg_proc_deviter *it = kzalloc(sizeof(*it), GFP_KERNEL);
+
+	s->private = it;
+	if (!it)
+		return NULL;
+
+	it->index = *pos;
+	it->max = sg_last_dev();
+	if (it->index >= it->max)
+		return NULL;
+	return it;
+}
+
+static void *
+dev_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct sg_proc_deviter *it = s->private;
+
+	*pos = ++it->index;
+	return (it->index < it->max) ? it : NULL;
+}
+
+static void
+dev_seq_stop(struct seq_file *s, void *v)
+{
+	kfree(s->private);
+}
+
+#endif			/* SG_PROC_OR_DEBUG_FS */
+
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* around 100 lines */
+
 static int
 sg_proc_seq_show_int(struct seq_file *s, void *v)
 {
@@ -3679,7 +3724,7 @@ sg_proc_single_open_adio(struct inode *inode, struct file *filp)
 	return single_open(filp, sg_proc_seq_show_int, &sg_allow_dio);
 }
 
-static ssize_t 
+static ssize_t
 sg_proc_write_adio(struct file *filp, const char __user *buffer,
 		   size_t count, loff_t *off)
 {
@@ -3701,7 +3746,7 @@ sg_proc_single_open_dressz(struct inode *inode, struct file *filp)
 	return single_open(filp, sg_proc_seq_show_int, &sg_big_buff);
 }
 
-static ssize_t 
+static ssize_t
 sg_proc_write_dressz(struct file *filp, const char __user *buffer,
 		     size_t count, loff_t *off)
 {
@@ -3736,43 +3781,6 @@ sg_proc_seq_show_devhdr(struct seq_file *s, void *v)
 	return 0;
 }
 
-struct sg_proc_deviter {
-	loff_t	index;
-	size_t	max;
-	int fd_index;
-};
-
-static void *
-dev_seq_start(struct seq_file *s, loff_t *pos)
-{
-	struct sg_proc_deviter *it = kzalloc(sizeof(*it), GFP_KERNEL);
-
-	s->private = it;
-	if (! it)
-		return NULL;
-
-	it->index = *pos;
-	it->max = sg_last_dev();
-	if (it->index >= it->max)
-		return NULL;
-	return it;
-}
-
-static void *
-dev_seq_next(struct seq_file *s, void *v, loff_t *pos)
-{
-	struct sg_proc_deviter *it = s->private;
-
-	*pos = ++it->index;
-	return (it->index < it->max) ? it : NULL;
-}
-
-static void
-dev_seq_stop(struct seq_file *s, void *v)
-{
-	kfree(s->private);
-}
-
 static int
 sg_proc_seq_show_dev(struct seq_file *s, void *v)
 {
@@ -3819,6 +3827,10 @@ sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 	return 0;
 }
 
+#endif		/* CONFIG_SCSI_PROC_FS (~100 lines back) */
+
+#if IS_ENABLED(CONFIG_SG_PROC_OR_DEBUG_FS)
+
 /* Writes debug info for one sg_request in obp buffer */
 static int
 sg_proc_debug_sreq(struct sg_request *srp, int to, char *obp, int len)
@@ -3961,18 +3973,20 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	bool found = false;
 	bool trunc = false;
 	const int bp_len = SG_PROC_DEBUG_SZ;
+	int j, sd_n;
 	int n = 0;
 	int k = 0;
 	unsigned long iflags;
 	struct sg_proc_deviter *it = (struct sg_proc_deviter *)v;
 	struct sg_device *sdp;
 	int *fdi_p;
+	const int *dev_arr = sg_dfs_cxt.snapshot_devs;
 	char *bp;
 	char *disk_name;
 	char b1[128];
 
 	b1[0] = '\0';
-	if (it && (0 == it->index))
+	if (it && it->index == 0)
 		seq_printf(s, "max_active_device=%d  def_reserved_size=%d\n",
 			   (int)it->max, def_reserved_size);
 	fdi_p = it ? &it->fd_index : &k;
@@ -3984,8 +3998,31 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	}
 	read_lock_irqsave(&sg_index_lock, iflags);
 	sdp = it ? sg_lookup_dev(it->index) : NULL;
-	if (NULL == sdp)
+	if (!sdp)
 		goto skip;
+	sd_n = dev_arr[0];
+	if (sd_n != -1 && sd_n != sdp->index && sd_n != dev_arr[1]) {
+		for (j = 1; j < SG_SNAPSHOT_DEV_MAX; ) {
+			sd_n = dev_arr[j];
+			if (sd_n < 0)
+				goto skip;
+			++j;
+			if (j >= SG_SNAPSHOT_DEV_MAX) {
+				if (sd_n == sdp->index) {
+					found = true;
+					break;
+				}
+			} else if (sd_n == dev_arr[j]) {
+				goto skip;
+			} else if (sd_n == sdp->index) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			goto skip;
+		found = false;
+	}
 	if (!xa_empty(&sdp->sfp_arr)) {
 		found = true;
 		disk_name = (sdp->name[0] ? sdp->name : "?_?");
@@ -4025,6 +4062,10 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	return 0;
 }
 
+#endif         /* SG_PROC_OR_DEBUG_FS */
+
+#if IS_ENABLED(CONFIG_SCSI_PROC_FS)
+
 static const struct proc_ops adio_proc_ops = {
 	.proc_open      = sg_proc_single_open_adio,
 	.proc_read      = seq_read,
@@ -4085,7 +4126,226 @@ sg_proc_init(void)
 
 /* remove_proc_subtree("scsi/sg", NULL) in exit_sg() does cleanup */
 
-#endif				/* CONFIG_SCSI_PROC_FS (~400 lines back) */
+#else
+
+static int
+sg_proc_init(void)
+{
+	return 0;
+}
+
+#endif			/* CONFIG_SCSI_PROC_FS */
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+struct sg_dfs_attr {
+	const char *name;
+	umode_t mode;
+	int (*show)(void *d, struct seq_file *m);
+	ssize_t (*write)(void *d, const char __user *b, size_t s, loff_t *o);
+	/* Set either .show or .seq_ops. */
+	const struct seq_operations *seq_ops;
+};
+
+static int
+sg_dfs_snapshot_devs_show(void *data, struct seq_file *m)
+{
+	bool last;
+	int k, d;
+	struct sg_dfs_context_t *ctxp = data;
+
+	for (k = 0; k < SG_SNAPSHOT_DEV_MAX; ++k) {
+		d = ctxp->snapshot_devs[k];
+		last = (k + 1 == SG_SNAPSHOT_DEV_MAX);
+		if (d < 0) {
+			if (k == 0)
+				seq_puts(m, "-1");
+			break;
+		}
+		if (!last && d == ctxp->snapshot_devs[k + 1]) {
+			if (k == 0)
+				seq_puts(m, "-1");
+			break;
+		}
+		if (k != 0)
+			seq_puts(m, ",");
+		seq_printf(m, "%d", d);
+	}
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static ssize_t
+sg_dfs_snapshot_devs_write(void *data, const char __user *buf, size_t count,
+			   loff_t *ppos)
+{
+	bool trailing_comma;
+	int k, n;
+	struct sg_dfs_context_t *cxtp = data;
+	char lbuf[64] = { }, *cp, *c2p;
+
+	if (count >= sizeof(lbuf)) {
+		pr_err("%s: operation too long\n", __func__);
+		return -EINVAL;
+	}
+	if (copy_from_user(lbuf, buf, count))
+		return -EFAULT;
+	for (k = 0, n = 0, cp = lbuf; k < SG_SNAPSHOT_DEV_MAX;
+	     ++k, cp = c2p + 1) {
+		c2p = strchr(cp, ',');
+		if (c2p)
+			*c2p = '\0';
+		trailing_comma = !!c2p;
+		/* sscanf is easier to use that this ... */
+		if (kstrtoint(cp, 10, cxtp->snapshot_devs + k))
+			break;
+		++n;
+		if (!trailing_comma)
+			break;
+	}
+	if (n == 0) {
+		return -EINVAL;
+	} else if (k >= SG_SNAPSHOT_DEV_MAX && trailing_comma) {
+		pr_err("%s: only %d elements in snapshot array\n", __func__,
+		       SG_SNAPSHOT_DEV_MAX);
+		return -EINVAL;
+	}
+	if (n < SG_SNAPSHOT_DEV_MAX)
+		cxtp->snapshot_devs[n] = -1;
+	return count;
+}
+
+static int
+sg_dfs_show(struct seq_file *m, void *v)
+{
+	const struct sg_dfs_attr *attr = m->private;
+	void *data = d_inode(m->file->f_path.dentry->d_parent)->i_private;
+
+	return attr->show(data, m);
+}
 
+static ssize_t
+sg_dfs_write(struct file *file, const char __user *buf, size_t count,
+	     loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	const struct sg_dfs_attr *attr = m->private;
+	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+
+	/*
+	 * Attributes that only implement .seq_ops are read-only and 'attr' is
+	 * the same with 'data' in this case.
+	 */
+	if (attr == data || !attr->write)
+		return -EPERM;
+	return attr->write(data, buf, count, ppos);
+}
+
+static int
+sg_dfs_open(struct inode *inode, struct file *file)
+{
+	const struct sg_dfs_attr *attr = inode->i_private;
+	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+	struct seq_file *m;
+	int ret;
+
+	if (attr->seq_ops) {
+		ret = seq_open(file, attr->seq_ops);
+		if (!ret) {
+			m = file->private_data;
+			m->private = data;
+		}
+		return ret;
+	}
+	if (WARN_ON_ONCE(!attr->show))
+		return -EPERM;
+	return single_open(file, sg_dfs_show, inode->i_private);
+}
+
+static int
+sg_dfs_release(struct inode *inode, struct file *file)
+{
+	const struct sg_dfs_attr *attr = inode->i_private;
+
+	if (attr->show)
+		return single_release(inode, file);
+	return seq_release(inode, file);
+}
+
+static const struct file_operations sg_dfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= sg_dfs_open,
+	.read		= seq_read,
+	.write		= sg_dfs_write,
+	.llseek		= seq_lseek,
+	.release	= sg_dfs_release,
+};
+
+static void sg_dfs_mk_files(struct dentry *parent, void *data,
+			    const struct sg_dfs_attr *attr)
+{
+	if (IS_ERR_OR_NULL(parent))
+		return;
+
+	d_inode(parent)->i_private = data;
+	for (; attr->name; ++attr)
+		debugfs_create_file(attr->name, attr->mode, parent,
+				    (void *)attr, &sg_dfs_fops);
+}
+
+static const struct seq_operations sg_snapshot_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = sg_proc_seq_show_debug,
+};
+
+static const struct sg_dfs_attr sg_dfs_attrs[] = {
+	{"snapshot", 0400, .seq_ops = &sg_snapshot_seq_ops},
+	{"snapshot_devs", 0600, sg_dfs_snapshot_devs_show,
+	 sg_dfs_snapshot_devs_write},
+	{ },
+};
+
+static void
+sg_dfs_init(void)
+{
+	/* create and populate /sys/kernel/debug/scsi_generic directory */
+	if (!sg_dfs_cxt.dfs_rootdir) {
+		sg_dfs_cxt.dfs_rootdir = debugfs_create_dir("scsi_generic",
+							    NULL);
+		sg_dfs_mk_files(sg_dfs_cxt.dfs_rootdir, &sg_dfs_cxt,
+				sg_dfs_attrs);
+	}
+	sg_dfs_cxt.snapshot_devs[0] = -1;	/* show all sg devices */
+}
+
+static void
+sg_dfs_exit(void)
+{
+	debugfs_remove_recursive(sg_dfs_cxt.dfs_rootdir);
+	sg_dfs_cxt.dfs_rootdir = NULL;
+}
+
+#else		/* not  defined: CONFIG_DEBUG_FS */
+
+static void sg_dfs_init(void) {}
+static void sg_dfs_exit(void) {}
+
+#endif		/* CONFIG_DEBUG_FS */
+
+module_param_named(scatter_elem_sz, scatter_elem_sz, int, 0644);
+module_param_named(def_reserved_size, def_reserved_size, int, 0644);
+module_param_named(allow_dio, sg_allow_dio, int, 0644);
+
+MODULE_AUTHOR("Douglas Gilbert");
+MODULE_DESCRIPTION("SCSI generic (sg) driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(SG_VERSION_STR);
+MODULE_ALIAS_CHARDEV_MAJOR(SCSI_GENERIC_MAJOR);
+
+MODULE_PARM_DESC(scatter_elem_sz, "scatter gather element size (default: max(SG_SCATTER_SZ, PAGE_SIZE))");
+MODULE_PARM_DESC(def_reserved_size, "size of buffer reserved for each fd");
+MODULE_PARM_DESC(allow_dio, "allow direct I/O (default: 0 (disallow))");
 module_init(init_sg);
 module_exit(exit_sg);
-- 
2.37.3

