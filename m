Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1733C17244B
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Feb 2020 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgB0Q76 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Feb 2020 11:59:58 -0500
Received: from smtp.infotech.no ([82.134.31.41]:47293 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbgB0Q76 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Feb 2020 11:59:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id F154320418E;
        Thu, 27 Feb 2020 17:59:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Or4WmvXfx16O; Thu, 27 Feb 2020 17:59:55 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id E0EC4204190;
        Thu, 27 Feb 2020 17:59:47 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v7 33/38] sg: move procfs objects to avoid forward decls
Date:   Thu, 27 Feb 2020 11:58:57 -0500
Message-Id: <20200227165902.11861-34-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227165902.11861-1-dgilbert@interlog.com>
References: <20200227165902.11861-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Move the procfs related file_operations and seq_operations
definitions toward the end of the source file to minimize the
need for forward declarations of the functions they name.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 129 +++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 71 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index f4a02288672a..514f6395eddb 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -3789,77 +3789,6 @@ sg_rq_st_str(enum sg_rq_state rq_st, bool long_str)
 #endif
 
 #if IS_ENABLED(CONFIG_SCSI_PROC_FS)     /* long, almost to end of file */
-static int sg_proc_seq_show_int(struct seq_file *s, void *v);
-
-static int sg_proc_single_open_adio(struct inode *inode, struct file *filp);
-static ssize_t sg_proc_write_adio(struct file *filp, const char __user *buffer,
-			          size_t count, loff_t *off);
-static const struct proc_ops adio_proc_ops = {
-	.proc_open	= sg_proc_single_open_adio,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_write	= sg_proc_write_adio,
-	.proc_release	= single_release,
-};
-
-static int sg_proc_single_open_dressz(struct inode *inode, struct file *filp);
-static ssize_t sg_proc_write_dressz(struct file *filp, 
-		const char __user *buffer, size_t count, loff_t *off);
-static const struct proc_ops dressz_proc_ops = {
-	.proc_open	= sg_proc_single_open_dressz,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_write	= sg_proc_write_dressz,
-	.proc_release	= single_release,
-};
-
-static int sg_proc_seq_show_version(struct seq_file *s, void *v);
-static int sg_proc_seq_show_devhdr(struct seq_file *s, void *v);
-static int sg_proc_seq_show_dev(struct seq_file *s, void *v);
-static void * dev_seq_start(struct seq_file *s, loff_t *pos);
-static void * dev_seq_next(struct seq_file *s, void *v, loff_t *pos);
-static void dev_seq_stop(struct seq_file *s, void *v);
-static const struct seq_operations dev_seq_ops = {
-	.start = dev_seq_start,
-	.next  = dev_seq_next,
-	.stop  = dev_seq_stop,
-	.show  = sg_proc_seq_show_dev,
-};
-
-static int sg_proc_seq_show_devstrs(struct seq_file *s, void *v);
-static const struct seq_operations devstrs_seq_ops = {
-	.start = dev_seq_start,
-	.next  = dev_seq_next,
-	.stop  = dev_seq_stop,
-	.show  = sg_proc_seq_show_devstrs,
-};
-
-static int sg_proc_seq_show_debug(struct seq_file *s, void *v);
-static const struct seq_operations debug_seq_ops = {
-	.start = dev_seq_start,
-	.next  = dev_seq_next,
-	.stop  = dev_seq_stop,
-	.show  = sg_proc_seq_show_debug,
-};
-
-static int
-sg_proc_init(void)
-{
-	struct proc_dir_entry *p;
-
-	p = proc_mkdir("scsi/sg", NULL);
-	if (!p)
-		return 1;
-
-	proc_create("allow_dio", 0644, p, &adio_proc_ops);
-	proc_create_seq("debug", 0444, p, &debug_seq_ops);
-	proc_create("def_reserved_size", 0644, p, &dressz_proc_ops);
-	proc_create_single("device_hdr", 0444, p, sg_proc_seq_show_devhdr);
-	proc_create_seq("devices", 0444, p, &dev_seq_ops);
-	proc_create_seq("device_strs", 0444, p, &devstrs_seq_ops);
-	proc_create_single("version", 0444, p, sg_proc_seq_show_version);
-	return 0;
-}
 
 static int
 sg_last_dev(void)
@@ -4232,6 +4161,64 @@ sg_proc_seq_show_debug(struct seq_file *s, void *v)
 	return 0;
 }
 
+static const struct proc_ops adio_proc_ops = {
+	.proc_open      = sg_proc_single_open_adio,
+	.proc_read      = seq_read,
+	.proc_lseek     = seq_lseek,
+	.proc_write     = sg_proc_write_adio,
+	.proc_release   = single_release,
+};
+
+static const struct proc_ops dressz_proc_ops = {
+	.proc_open      = sg_proc_single_open_dressz,
+	.proc_read      = seq_read,
+	.proc_lseek     = seq_lseek,
+	.proc_write     = sg_proc_write_dressz,
+	.proc_release   = single_release,
+};
+
+static const struct seq_operations dev_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = sg_proc_seq_show_dev,
+};
+
+static const struct seq_operations devstrs_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = sg_proc_seq_show_devstrs,
+};
+
+static const struct seq_operations debug_seq_ops = {
+	.start = dev_seq_start,
+	.next  = dev_seq_next,
+	.stop  = dev_seq_stop,
+	.show  = sg_proc_seq_show_debug,
+};
+
+static int
+sg_proc_init(void)
+{
+	struct proc_dir_entry *p;
+
+	p = proc_mkdir("scsi/sg", NULL);
+	if (!p)
+		return 1;
+
+	proc_create("allow_dio", 0644, p, &adio_proc_ops);
+	proc_create_seq("debug", 0444, p, &debug_seq_ops);
+	proc_create("def_reserved_size", 0644, p, &dressz_proc_ops);
+	proc_create_single("device_hdr", 0444, p, sg_proc_seq_show_devhdr);
+	proc_create_seq("devices", 0444, p, &dev_seq_ops);
+	proc_create_seq("device_strs", 0444, p, &devstrs_seq_ops);
+	proc_create_single("version", 0444, p, sg_proc_seq_show_version);
+	return 0;
+}
+
+/* remove_proc_subtree("scsi/sg", NULL) in exit_sg() does cleanup */
+
 #endif				/* CONFIG_SCSI_PROC_FS (~400 lines back) */
 
 module_init(init_sg);
-- 
2.25.1

