Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBC3EDB11
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfKDJC2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:57308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728290AbfKDJCR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3327AB4B6;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 43/52] scsi: Kill DRIVER_TIMEOUT
Date:   Mon,  4 Nov 2019 10:01:42 +0100
Message-Id: <20191104090151.129140-44-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Unused now.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/constants.c    | 2 +-
 include/scsi/scsi.h         | 1 -
 include/trace/events/scsi.h | 3 +--
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/constants.c b/drivers/scsi/constants.c
index b2ba83e6b98d..1780837ea11e 100644
--- a/drivers/scsi/constants.c
+++ b/drivers/scsi/constants.c
@@ -408,7 +408,7 @@ static const char * const hostbyte_table[]={
 
 static const char * const driverbyte_table[]={
 "DRIVER_OK", "DRIVER_BUSY", "DRIVER_SOFT",  "DRIVER_MEDIA", "DRIVER_ERROR",
-"DRIVER_INVALID", "DRIVER_TIMEOUT"};
+"DRIVER_INVALID"};
 
 const char *scsi_hostbyte_string(int result)
 {
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 407e188a0aae..274cc9e77634 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -171,7 +171,6 @@ static inline int scsi_is_wlun(u64 lun)
 #define DRIVER_ERROR        0x04
 
 #define DRIVER_INVALID      0x05
-#define DRIVER_TIMEOUT      0x06
 
 /*
  * Internal return values.
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index e15373917d1e..a1b4da442c5c 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -132,8 +132,7 @@
 		scsi_driverbyte_name(DRIVER_SOFT),		\
 		scsi_driverbyte_name(DRIVER_MEDIA),		\
 		scsi_driverbyte_name(DRIVER_ERROR),		\
-		scsi_driverbyte_name(DRIVER_INVALID),		\
-		scsi_driverbyte_name(DRIVER_TIMEOUT))
+		scsi_driverbyte_name(DRIVER_INVALID))
 
 #define scsi_msgbyte_name(result)	{ result, #result }
 #define show_msgbyte_name(val)					\
-- 
2.16.4

