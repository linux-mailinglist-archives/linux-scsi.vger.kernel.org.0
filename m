Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12E16A33
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEGScR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:32:17 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24138 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfEGScQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:32:16 -0400
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=don.brace@microsemi.com; spf=None smtp.helo=postmaster@smtp.microsemi.com
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  don.brace@microsemi.com designates 208.19.100.22 as permitted
  sender) identity=mailfrom; client-ip=208.19.100.22;
  receiver=esa5.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="don.brace@microsemi.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:208.19.100.20 ip4:208.19.100.21 ip4:208.19.100.22
  ip4:208.19.100.23 ip4:208.19.99.221 ip4:208.19.99.222
  ip4:208.19.99.223 ip4:208.19.99.225 -all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa5.microchip.iphmx.com;
  envelope-from="don.brace@microsemi.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.60,443,1549954800"; 
   d="scan'208";a="30471219"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:32:16 -0700
Received: from AVMBX1.microsemi.net (10.100.34.31) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:15 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX1.microsemi.net
 (10.100.34.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:14 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 11:32:14 -0700
Subject: [PATCH 3/7] hpsa: check for tag collision
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:32:13 -0500
Message-ID: <155725393386.27200.15540655340982150601.stgit@brunhilda>
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

- correct rare multipath issue where a device is deleted
  with an outstanding cmd which results in a tag collision.
  . The cmd eventually completes. If a collision is detected
    wait until the command slot is cleared.

Reviewed-by: Justin Lindley <justin.lindley@microsemi.com>
Reviewed-by: David Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |   21 ++++++++++++++-------
 drivers/scsi/hpsa.h |    1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index ade0d505a32c..a315d108fdcb 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5620,6 +5620,8 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 		return 0;
 	}
 	c = cmd_tagged_alloc(h, cmd);
+	if (c == NULL)
+		return SCSI_MLQUEUE_DEVICE_BUSY;
 
 	/*
 	 * Call alternate submit routine for I/O accelerated commands.
@@ -6026,7 +6028,6 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 		BUG();
 	}
 
-	atomic_inc(&c->refcount);
 	if (unlikely(!hpsa_is_cmd_idle(c))) {
 		/*
 		 * We expect that the SCSI layer will hand us a unique tag
@@ -6034,14 +6035,20 @@ static struct CommandList *cmd_tagged_alloc(struct ctlr_info *h,
 		 * two requests...because if the selected command isn't idle
 		 * then someone is going to be very disappointed.
 		 */
-		dev_err(&h->pdev->dev,
-			"tag collision (tag=%d) in cmd_tagged_alloc().\n",
-			idx);
-		if (c->scsi_cmd != NULL)
-			scsi_print_command(c->scsi_cmd);
-		scsi_print_command(scmd);
+		if (idx != h->last_collision_tag) { /* Print once per tag */
+			dev_warn(&h->pdev->dev,
+				"%s: tag collision (tag=%d)\n", __func__, idx);
+			if (c->scsi_cmd != NULL)
+				scsi_print_command(c->scsi_cmd);
+			if (scmd)
+				scsi_print_command(scmd);
+			h->last_collision_tag = idx;
+		}
+		return NULL;
 	}
 
+	atomic_inc(&c->refcount);
+
 	hpsa_cmd_partial_init(h, idx, c);
 	return c;
 }
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 7aa7378f70dd..75210de71917 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -174,6 +174,7 @@ struct ctlr_info {
 	struct CfgTable __iomem *cfgtable;
 	int	interrupts_enabled;
 	int 	max_commands;
+	int	last_collision_tag; /* tags are global */
 	atomic_t commands_outstanding;
 #	define PERF_MODE_INT	0
 #	define DOORBELL_INT	1

