Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D382EDB25
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfKDJCh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:57242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbfKDJCO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8391EB447;
        Mon,  4 Nov 2019 09:02:10 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/52] dc395: drop private SAM status code definitions
Date:   Mon,  4 Nov 2019 10:01:15 +0100
Message-Id: <20191104090151.129140-17-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We don't need to duplicate definitions from the common include
files.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/dc395x.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/scsi/dc395x.h b/drivers/scsi/dc395x.h
index 5379a936141a..a7786a6d462e 100644
--- a/drivers/scsi/dc395x.h
+++ b/drivers/scsi/dc395x.h
@@ -156,15 +156,6 @@
 #define H_ABORT				0x0FF
 
 /* SCSI BUS Status byte codes */
-#define SCSI_STAT_GOOD			0x0	/* Good status				*/
-#define SCSI_STAT_CHECKCOND		0x02	/* SCSI Check Condition			*/
-#define SCSI_STAT_CONDMET		0x04	/* Condition Met			*/
-#define SCSI_STAT_BUSY			0x08	/* Target busy status			*/
-#define SCSI_STAT_INTER			0x10	/* Intermediate status			*/
-#define SCSI_STAT_INTERCONDMET		0x14	/* Intermediate condition met		*/
-#define SCSI_STAT_RESCONFLICT		0x18	/* Reservation conflict			*/
-#define SCSI_STAT_CMDTERM		0x22	/* Command Terminated			*/
-#define SCSI_STAT_QUEUEFULL		0x28	/* Queue Full				*/
 #define SCSI_STAT_UNEXP_BUS_F		0xFD	/* Unexpect Bus Free			*/
 #define SCSI_STAT_BUS_RST_DETECT	0xFE	/* Scsi Bus Reset detected		*/
 #define SCSI_STAT_SEL_TIMEOUT		0xFF	/* Selection Time out			*/
@@ -203,13 +194,6 @@
 #define MSG_IDENTIFY			0x80
 #define MSG_HOST_ID			0xC0
 
-/* SCSI STATUS BYTE */
-#define STATUS_GOOD			0x00
-#define CHECK_CONDITION_		0x02
-#define STATUS_BUSY			0x08
-#define STATUS_INTERMEDIATE		0x10
-#define RESERVE_CONFLICT		0x18
-
 /* cmd->result */
 #define STATUS_MASK_			0xFF
 #define MSG_MASK			0xFF00
-- 
2.16.4

