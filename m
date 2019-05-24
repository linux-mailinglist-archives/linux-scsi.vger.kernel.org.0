Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5229E5A
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 20:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbfEXSsb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 14:48:31 -0400
Received: from smtp.infotech.no ([82.134.31.41]:56379 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391612AbfEXSsb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 14:48:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id E3965204190;
        Fri, 24 May 2019 20:48:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kz9-U9VyNGfg; Fri, 24 May 2019 20:48:28 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id F12C3204198;
        Fri, 24 May 2019 20:48:20 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: [PATCH 08/19] sg: add 8 byte SCSI LUN to sg_scsi_id
Date:   Fri, 24 May 2019 14:47:58 -0400
Message-Id: <20190524184809.25121-9-dgilbert@interlog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524184809.25121-1-dgilbert@interlog.com>
References: <20190524184809.25121-1-dgilbert@interlog.com>
Sender: linux-scsi-owner@vger.kernel.org
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
should do the same as it does with the version 3 driver.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c      | 5 +++--
 include/uapi/scsi/sg.h | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 3b78b8c8304b..454abfdd4f74 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1694,6 +1694,7 @@ static int
 sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_device *sdp, void __user *p)
 {
 	struct sg_scsi_id __user *sg_idp = p;
+	struct scsi_lun lun8b;
 
 	SG_LOG(3, sdp, "%s:    SG_GET_SCSI_ID\n", __func__);
 	if (!access_ok(p, sizeof(struct sg_scsi_id)))
@@ -1711,8 +1712,8 @@ sg_ctl_scsi_id(struct scsi_device *sdev, struct sg_device *sdp, void __user *p)
 		   &sg_idp->h_cmd_per_lun);
 	__put_user((short)sdev->queue_depth,
 		   &sg_idp->d_queue_depth);
-	__put_user(0, &sg_idp->unused[0]);
-	__put_user(0, &sg_idp->unused[1]);
+	int_to_scsilun(sdev->lun, &lun8b);
+	__copy_to_user(sg_idp->scsi_lun, lun8b.scsi_lun, 8);
 	return 0;
 }
 
diff --git a/include/uapi/scsi/sg.h b/include/uapi/scsi/sg.h
index 7557c1be01e0..db86d1ae7e29 100644
--- a/include/uapi/scsi/sg.h
+++ b/include/uapi/scsi/sg.h
@@ -135,7 +135,10 @@ typedef struct sg_scsi_id {
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
2.17.1

