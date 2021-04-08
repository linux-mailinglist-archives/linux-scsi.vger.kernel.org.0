Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4483579C1
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 03:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhDHBqk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Apr 2021 21:46:40 -0400
Received: from smtp.infotech.no ([82.134.31.41]:45235 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhDHBqa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 7 Apr 2021 21:46:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 7474D204278;
        Thu,  8 Apr 2021 03:46:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xbrWKWckz+zC; Thu,  8 Apr 2021 03:46:17 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id CF2A520425B;
        Thu,  8 Apr 2021 03:46:11 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v17 32/45] sg: add some __must_hold macros
Date:   Wed,  7 Apr 2021 21:45:18 -0400
Message-Id: <20210408014531.248890-33-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408014531.248890-1-dgilbert@interlog.com>
References: <20210408014531.248890-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In the case of sg_wait_open_event() which calls mutex_unlock on
sdp->open_rel_lock and later calls mutex_lock on the same
lock; this macro is needed to stop sparse complaining. In
other cases it is a reminder to the coder (a precondition).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index bc54097b1d41..2daa0887463e 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -374,6 +374,7 @@ sg_check_file_access(struct file *filp, const char *caller)
 
 static int
 sg_wait_open_event(struct sg_device *sdp, bool o_excl)
+		__must_hold(sdp->open_rel_lock)
 {
 	int res = 0;
 
@@ -1729,6 +1730,7 @@ sg_ctl_sg_io(struct file *filp, struct sg_device *sdp, struct sg_fd *sfp,
  */
 static int
 sg_set_reserved_sz(struct sg_fd *sfp, int want_rsv_sz)
+		__must_hold(sfp->f_mutex)
 {
 	bool use_new_srp = false;
 	int res = 0;
@@ -3670,12 +3672,12 @@ sg_remove_sfp(struct kref *kref)
 
 static int
 sg_idr_max_id(int id, void *p, void *data)
+		__must_hold(sg_index_lock)
 {
 	int *k = data;
 
 	if (*k < id)
 		*k = id;
-
 	return 0;
 }
 
@@ -3978,6 +3980,7 @@ sg_proc_seq_show_devstrs(struct seq_file *s, void *v)
 /* Writes debug info for one sg_request in obp buffer */
 static int
 sg_proc_debug_sreq(struct sg_request *srp, int to, char *obp, int len)
+		__must_hold(sfp->srp_arr.xa_lock)
 {
 	bool is_v3v4, v4, is_dur;
 	int n = 0;
@@ -4080,6 +4083,7 @@ sg_proc_debug_fd(struct sg_fd *fp, char *obp, int len, unsigned long idx)
 /* Writes debug info for one sg device (including its sg fds) in obp buffer */
 static int
 sg_proc_debug_sdev(struct sg_device *sdp, char *obp, int len, int *fd_counterp)
+		__must_hold(sg_index_lock)
 {
 	int n = 0;
 	int my_count = 0;
-- 
2.25.1

