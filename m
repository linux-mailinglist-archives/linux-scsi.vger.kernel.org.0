Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA05338CDC1
	for <lists+linux-scsi@lfdr.de>; Fri, 21 May 2021 20:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEUSsn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 May 2021 14:48:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhEUSsm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 May 2021 14:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7FCE611AD;
        Fri, 21 May 2021 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621622839;
        bh=VmUlRfGjNa4LcDhFntuncwex/5YymKqvTplSijr/HJY=;
        h=Subject:To:From:Date:From;
        b=TZe+O1SacpLVFCBOGVsSQytdzKLScOVxrSus0ZyA90KJcshhT9j7YVPhkUcMiUEv/
         c3bQPh4vUD0g1nadoPT3LiAUgirBAiZxgp07ftN/mvrcYvDkiNqazL1kNWh7fX3AcK
         CIGJDn10R6kDnKW3MAjWP6eWp7IH30hKFfSKcjEg=
Subject: patch "scsi: snic: debugfs: remove local storage of debugfs files" added to driver-core-testing
To:     gregkh@linuxfoundation.org, jejb@linux.ibm.com, kartilak@cisco.com,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        sebaddel@cisco.com
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 May 2021 20:47:09 +0200
Message-ID: <1621622829212246@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    scsi: snic: debugfs: remove local storage of debugfs files

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 1be4ec2456a7d110092ad8cc918eef75b878ec4e Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 18 May 2021 18:16:25 +0200
Subject: scsi: snic: debugfs: remove local storage of debugfs files

There is no need to keep the dentry around for the debugfs trace files,
as we can just look it up when we want to remove it later on.  Simplify
the structure by removing the dentries and relying on debugfs to find
the dentry to remove when we want to.

By doing this change, we remove the last in-kernel user that was storing
the result of debugfs_create_bool(), so that api can be cleaned up.

Cc: Karan Tilak Kumar <kartilak@cisco.com>
Cc: Sesidhar Baddela <sebaddel@cisco.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: <linux-scsi@vger.kernel.org>
Link: https://lore.kernel.org/r/20210518161625.3696996-1-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/snic/snic_debugfs.c | 23 +++++++++--------------
 drivers/scsi/snic/snic_trc.h     |  3 ---
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 3aeee856d5c7..5e0faeba516e 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -430,21 +430,19 @@ static const struct seq_operations snic_trc_sops = {
 
 DEFINE_SEQ_ATTRIBUTE(snic_trc);
 
+#define TRC_ENABLE_FILE	"tracing_enable"
+#define TRC_FILE	"trace"
 /*
  * snic_trc_debugfs_init : creates trace/tracing_enable files for trace
  * under debugfs
  */
 void snic_trc_debugfs_init(void)
 {
-	snic_glob->trc.trc_enable = debugfs_create_bool("tracing_enable",
-							S_IFREG | S_IRUGO | S_IWUSR,
-							snic_glob->trc_root,
-							&snic_glob->trc.enable);
-
-	snic_glob->trc.trc_file = debugfs_create_file("trace",
-						      S_IFREG | S_IRUGO | S_IWUSR,
-						      snic_glob->trc_root, NULL,
-						      &snic_trc_fops);
+	debugfs_create_bool(TRC_ENABLE_FILE, S_IFREG | S_IRUGO | S_IWUSR,
+			    snic_glob->trc_root, &snic_glob->trc.enable);
+
+	debugfs_create_file(TRC_FILE, S_IFREG | S_IRUGO | S_IWUSR,
+			    snic_glob->trc_root, NULL, &snic_trc_fops);
 }
 
 /*
@@ -453,9 +451,6 @@ void snic_trc_debugfs_init(void)
 void
 snic_trc_debugfs_term(void)
 {
-	debugfs_remove(snic_glob->trc.trc_file);
-	snic_glob->trc.trc_file = NULL;
-
-	debugfs_remove(snic_glob->trc.trc_enable);
-	snic_glob->trc.trc_enable = NULL;
+	debugfs_remove(debugfs_lookup(TRC_FILE, snic_glob->trc_root));
+	debugfs_remove(debugfs_lookup(TRC_ENABLE_FILE, snic_glob->trc_root));
 }
diff --git a/drivers/scsi/snic/snic_trc.h b/drivers/scsi/snic/snic_trc.h
index 87dcc7457d15..ce305b4b8fa2 100644
--- a/drivers/scsi/snic/snic_trc.h
+++ b/drivers/scsi/snic/snic_trc.h
@@ -46,9 +46,6 @@ struct snic_trc {
 	u32	rd_idx;
 	u32	wr_idx;
 	bool	enable;			/* Control Variable for Tracing */
-
-	struct dentry *trc_enable;	/* debugfs file object */
-	struct dentry *trc_file;
 };
 
 int snic_trc_init(void);
-- 
2.31.1


