Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410ED16A34
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfEGScX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:32:23 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43430 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfEGScX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:32:23 -0400
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa3.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa3.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.60,443,1549954800"; 
   d="scan'208";a="32364554"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:32:22 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:21 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:21 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 11:32:20 -0700
Subject: [PATCH 4/7] hpsa: wait longer for ptraid commands
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:32:20 -0500
Message-ID: <155725394027.27200.14498415790023458788.stgit@brunhilda>
In-Reply-To: <155725372104.27200.12250663760304977059.stgit@brunhilda>
References: <155725372104.27200.12250663760304977059.stgit@brunhilda>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- wait longer for outstanding commands before removing
  a multipath device.
- increase the timeout value for ptraid commands.

Reviewed-by: Justin Lindley <justin.lindley@microsemi.com>
Reviewed-by: David Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index a315d108fdcb..5c02163c7cea 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -73,6 +73,8 @@
 
 /*define how many times we will try a command because of bus resets */
 #define MAX_CMD_RETRIES 3
+/* How long to wait before giving up on a command */
+#define HPSA_EH_PTRAID_TIMEOUT (240 * HZ)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
@@ -1842,25 +1844,33 @@ static int hpsa_find_outstanding_commands_for_dev(struct ctlr_info *h,
 	return count;
 }
 
+#define NUM_WAIT 20
 static void hpsa_wait_for_outstanding_commands_for_dev(struct ctlr_info *h,
 						struct hpsa_scsi_dev_t *device)
 {
 	int cmds = 0;
 	int waits = 0;
+	int num_wait = NUM_WAIT;
+
+	if (device->external)
+		num_wait = HPSA_EH_PTRAID_TIMEOUT;
 
 	while (1) {
 		cmds = hpsa_find_outstanding_commands_for_dev(h, device);
 		if (cmds == 0)
 			break;
-		if (++waits > 20)
+		if (++waits > num_wait)
 			break;
 		msleep(1000);
 	}
 
-	if (waits > 20)
+	if (waits > num_wait) {
 		dev_warn(&h->pdev->dev,
-			"%s: removing device with %d outstanding commands!\n",
-			__func__, cmds);
+			"%s: removing device [%d:%d:%d:%d] with %d outstanding commands!\n",
+			__func__,
+			h->scsi_host->host_no,
+			device->bus, device->target, device->lun, cmds);
+	}
 }
 
 static void hpsa_remove_device(struct ctlr_info *h,
@@ -2131,11 +2141,15 @@ static int hpsa_slave_configure(struct scsi_device *sdev)
 	sdev->no_uld_attach = !sd || !sd->expose_device;
 
 	if (sd) {
-		if (sd->external)
+		if (sd->external) {
 			queue_depth = EXTERNAL_QD;
-		else
+			sdev->eh_timeout = HPSA_EH_PTRAID_TIMEOUT;
+			blk_queue_rq_timeout(sdev->request_queue,
+						HPSA_EH_PTRAID_TIMEOUT);
+		} else {
 			queue_depth = sd->queue_depth != 0 ?
 					sd->queue_depth : sdev->host->can_queue;
+		}
 	} else
 		queue_depth = sdev->host->can_queue;
 

