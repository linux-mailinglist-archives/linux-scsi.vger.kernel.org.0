Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B9213A79
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGCNBb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jul 2020 09:01:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgGCNB3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 3 Jul 2020 09:01:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DBC5AF37;
        Fri,  3 Jul 2020 13:01:27 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/21] scsi: use real inquiry data when initialising devices
Date:   Fri,  3 Jul 2020 15:01:08 +0200
Message-Id: <20200703130122.111448-8-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200703130122.111448-1-hare@suse.de>
References: <20200703130122.111448-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use dummy inquiry data when initialising devices and not just
some 'nullnullnull' string.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_scan.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f2437a7570ce..871c7609c159 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -81,7 +81,27 @@
 #define SCSI_SCAN_TARGET_PRESENT	1
 #define SCSI_SCAN_LUN_PRESENT		2
 
-static const char *scsi_null_device_strs = "nullnullnullnull";
+/*
+ * Dummy inquiry for virtual LUNs:
+ *
+ * standard INQUIRY: [qualifier indicates no connected LU]
+ *  PQual=1  Device_type=31  RMB=0  LU_CONG=0  version=0x05  [SPC-3]
+ *  [AERC=0]  [TrmTsk=0]  NormACA=0  HiSUP=0  Resp_data_format=2
+ *  SCCS=0  ACC=0  TPGS=0  3PC=0  Protect=0  [BQue=0]
+ *  EncServ=0  MultiP=0  [MChngr=0]  [ACKREQQ=0]  Addr16=0
+ *  [RelAdr=0]  WBus16=0  Sync=0  [Linked=0]  [TranDis=0]  CmdQue=0
+ *    length=36 (0x24)   Peripheral device type: no physical device on this lu
+ * Vendor identification: LINUX
+ * Product identification: VIRTUALLUN
+ * Product revision level: 1.0
+ */
+static const unsigned char scsi_null_inquiry[36] = {
+	0x3f, 0x00, 0x05, 0x02, 0x1f, 0x00, 0x00, 0x00,
+	0x4c, 0x49, 0x4e, 0x55, 0x58, 0x20, 0x20, 0x20,
+	0x56, 0x49, 0x52, 0x54, 0x55, 0x41, 0x4c, 0x4c,
+	0x55, 0x4e, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+	0x31, 0x2e, 0x30, 0x20
+};
 
 #define MAX_SCSI_LUNS	512
 
@@ -224,9 +244,10 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	if (!sdev)
 		goto out;
 
-	sdev->vendor = scsi_null_device_strs;
-	sdev->model = scsi_null_device_strs;
-	sdev->rev = scsi_null_device_strs;
+	sdev->type = scsi_null_inquiry[0] & 0x1f;
+	sdev->vendor = scsi_null_inquiry + 8;
+	sdev->model = scsi_null_inquiry + 16;
+	sdev->rev = scsi_null_inquiry + 32;
 	sdev->host = shost;
 	sdev->queue_ramp_up_period = SCSI_DEFAULT_RAMP_UP_PERIOD;
 	sdev->id = starget->id;
@@ -253,11 +274,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	 * slave_configure function */
 	sdev->max_device_blocked = SCSI_DEFAULT_DEVICE_BLOCKED;
 
-	/*
-	 * Some low level driver could use device->type
-	 */
-	sdev->type = -1;
-
 	/*
 	 * Assume that the device will have handshaking problems,
 	 * and then fix this field later if it turns out it
-- 
2.16.4

