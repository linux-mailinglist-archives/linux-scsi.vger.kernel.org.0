Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6243040CF88
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhIOWm3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 18:42:29 -0400
Received: from smtp.infotech.no ([82.134.31.41]:36519 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232477AbhIOWm2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Sep 2021 18:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 25558204270;
        Thu, 16 Sep 2021 00:33:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gLDxKdY4sRoH; Thu, 16 Sep 2021 00:33:37 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-207-107.dyn.295.ca [45.78.207.107])
        by smtp.infotech.no (Postfix) with ESMTPA id 4333020425B;
        Thu, 16 Sep 2021 00:33:32 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v20 29/46] sg: add 8 byte SCSI LUN to sg_scsi_id
Date:   Wed, 15 Sep 2021 18:32:48 -0400
Message-Id: <20210915223305.256429-30-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915223305.256429-1-dgilbert@interlog.com>
References: <20210915223305.256429-1-dgilbert@interlog.com>
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
index 70799911e051..e83d24891ca4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1214,7 +1214,7 @@ sg_receive_v4(struct sg_fd *sfp, struct sg_request *srp, void __user *p,
 	h4p->din_resid = srp->in_resid;
 	h4p->dout_resid = srp->s_hdr4.out_resid;
 	h4p->usr_ptr = srp->s_hdr4.usr_ptr;
-	h4p->response = (u64)srp->s_hdr4.sbp;
+	h4p->response = (uintptr_t)srp->s_hdr4.sbp;
 	h4p->request_extra = srp->pack_id;
 	if (p) {
 		if (copy_to_user(p, h4p, SZ_SG_IO_V4))
@@ -1779,6 +1779,7 @@ static int
 sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_fd *sfp, void __user *p)
 {
 	struct sg_scsi_id ss_id;
+	struct scsi_lun lun8b;
 
 	SG_LOG(3, sfp, "%s:    SG_GET_SCSI_ID\n", __func__);
 	ss_id.host_no = sdev->host->host_no;
@@ -1788,8 +1789,9 @@ sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_fd *sfp, void __user *p)
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
index 489f8f7dfca5..ca2c1da0691d 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -170,7 +170,10 @@ typedef struct sg_scsi_id {
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

