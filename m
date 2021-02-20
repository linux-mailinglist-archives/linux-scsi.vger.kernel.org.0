Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F883202EC
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Feb 2021 03:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhBTCGY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Feb 2021 21:06:24 -0500
Received: from smtp.infotech.no ([82.134.31.41]:43735 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhBTCEC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Feb 2021 21:04:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id C7C3B2042B5;
        Sat, 20 Feb 2021 03:01:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mu2FCX-VLFSl; Sat, 20 Feb 2021 03:01:40 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 9DA162042AD;
        Sat, 20 Feb 2021 03:01:34 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v16 29/45] sg: add 8 byte SCSI LUN to sg_scsi_id
Date:   Fri, 19 Feb 2021 21:00:40 -0500
Message-Id: <20210220020056.77483-30-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220020056.77483-1-dgilbert@interlog.com>
References: <20210220020056.77483-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The existing ioctl(SG_GET_SCSI_ID) fills a object of type
struct sg_scsi_id whose last field is int unused[2]. Add
an anonymous union with u8 scsi_lun[8] sharing those last
8 bytes. This patch will place the current device's full
LUN in the scsi_lun array using T10's preferred LUN
format (i.e. an array of 8 bytes) when
ioctl(SG_GET_SCSI_ID) is called.

Note that structure already contains a 'lun' field but that
is a 32 bit integer. Users of this upgrade should choose
the scsi_lun array field henceforth but existing code
can remain as it is and will get the same 'lun' value with
the version 3 or version 4 driver.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 8 +++++---
 include/uapi/scsi/sg.h | 5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3fc2dbee95cc..0eba01b040eb 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1226,7 +1226,7 @@ sg_receive_v4(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	h4p->din_resid = srp->in_resid;
 	h4p->dout_resid = srp->s_hdr4.out_resid;
 	h4p->usr_ptr = srp->s_hdr4.usr_ptr;
-	h4p->response = (u64)srp->s_hdr4.sbp;
+	h4p->response = (uintptr_t)srp->s_hdr4.sbp;
 	h4p->request_extra = srp->pack_id;
 	if (p) {
 		if (copy_to_user(p, h4p, SZ_SG_IO_V4))
@@ -1839,6 +1839,7 @@ static int
 sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_fd *sfp, void __user *p)
 {
 	struct sg_scsi_id ss_id;
+	struct scsi_lun lun8b;
 
 	SG_LOG(3, sfp, "%s:    SG_GET_SCSI_ID\n", __func__);
 	ss_id.host_no = sdev->host->host_no;
@@ -1848,8 +1849,9 @@ sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_fd *sfp, void __user *p)
 	ss_id.scsi_type = sdev->type;
 	ss_id.h_cmd_per_lun = sdev->host->cmd_per_lun;
 	ss_id.d_queue_depth = sdev->queue_depth;
-	ss_id.unused[0] = 0;
-	ss_id.unused[1] = 0;
+	int_to_scsilun(sdev->lun, &lun8b);
+	/* ss_id.scsi_lun is in an anonymous union with 'int unused[2]' */
+	memcpy(ss_id.scsi_lun, lun8b.scsi_lun, 8);
 	if (copy_to_user(p, &ss_id, sizeof(struct sg_scsi_id)))
 		return -EFAULT;
 	return 0;
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 75017cc49850..af14379d5dcb 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -136,7 +136,10 @@ typedef struct sg_scsi_id {
 	int scsi_type;	/* TYPE_... defined in scsi/scsi.h */
 	short h_cmd_per_lun;/* host (adapter) maximum commands per lun */
 	short d_queue_depth;/* device (or adapter) maximum queue length */
-	int unused[2];
+	union {
+		int unused[2];  /* as per version 3 driver */
+		__u8 scsi_lun[8];  /* full 8 byte SCSI LUN [in v4 driver] */
+	};
 } sg_scsi_id_t;
 
 /* For backward compatibility v4 driver yields at most SG_MAX_QUEUE of these */
-- 
2.25.1

