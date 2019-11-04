Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856B9EDB0E
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfKDJC1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728310AbfKDJCR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DFB3B445;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 51/52] scsi: Kill DRIVER_MEDIA, DRIVER_SOFT, and DRIVER_BUSY
Date:   Mon,  4 Nov 2019 10:01:50 +0100
Message-Id: <20191104090151.129140-52-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Unused.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/message/fusion/mptscsih.c | 2 +-
 drivers/scsi/constants.c          | 2 +-
 include/scsi/scsi.h               | 8 --------
 include/trace/events/scsi.h       | 5 +----
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index f0737c57ed5f..0064547cef1a 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -703,7 +703,7 @@ mptscsih_io_done(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *mr)
 		case MPI_IOCSTATUS_BUSY:			/* 0x0002 */
 		case MPI_IOCSTATUS_INSUFFICIENT_RESOURCES:	/* 0x0006 */
 			/* CHECKME!
-			 * Maybe: DRIVER_BUSY | SUGGEST_RETRY | DID_SOFT_ERROR (retry)
+			 * Maybe: SUGGEST_RETRY | DID_SOFT_ERROR (retry)
 			 * But not: DID_BUS_BUSY lest one risk
 			 * killing interrupt handler:-(
 			 */
diff --git a/drivers/scsi/constants.c b/drivers/scsi/constants.c
index 57c544fd8c6b..be7eacb67841 100644
--- a/drivers/scsi/constants.c
+++ b/drivers/scsi/constants.c
@@ -407,7 +407,7 @@ static const char * const hostbyte_table[]={
 "DID_NEXUS_FAILURE" };
 
 static const char * const driverbyte_table[]={
-"DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA"};
+"DRIVER_OK"};
 
 const char *scsi_hostbyte_string(int result)
 {
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index af9f9ed5321e..acd0b2182db1 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -161,14 +161,6 @@ static inline int scsi_is_wlun(u64 lun)
 #define DID_MEDIUM_ERROR  0x13  /* Medium error */
 #define DRIVER_OK       0x00	/* Driver status                           */
 
-/*
- *  These indicate the error that occurred, and what is available.
- */
-
-#define DRIVER_BUSY         0x01
-#define DRIVER_SOFT         0x02
-#define DRIVER_MEDIA        0x03
-
 /*
  * Internal return values.
  */
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index b2d3ce9e3990..5984db6996bb 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -127,10 +127,7 @@
 #define scsi_driverbyte_name(result)	{ result, #result }
 #define show_driverbyte_name(val)				\
 	__print_symbolic(val,					\
-		scsi_driverbyte_name(DRIVER_OK),		\
-		scsi_driverbyte_name(DRIVER_BUSY),		\
-		scsi_driverbyte_name(DRIVER_SOFT),		\
-		scsi_driverbyte_name(DRIVER_MEDIA))
+		scsi_driverbyte_name(DRIVER_OK))
 
 #define scsi_msgbyte_name(result)	{ result, #result }
 #define show_msgbyte_name(val)					\
-- 
2.16.4

