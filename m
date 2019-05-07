Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5713016A32
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfEGScK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:32:10 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:43410 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfEGScK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:32:10 -0400
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
   d="scan'208";a="32364541"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:32:09 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:08 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:08 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 11:32:07 -0700
Subject: [PATCH 2/7] hpsa: use local workqueues instead of system workqueues
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:32:07 -0500
Message-ID: <155725392705.27200.14485937801924389250.stgit@brunhilda>
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

- avoid system stalls by switching to local workqueue

Reviewed-by: Justin Lindley <justin.lindley@microsemi.com>
Reviewed-by: David Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |   22 +++++++++++++++++++---
 drivers/scsi/hpsa.h |    1 +
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 410941afcb7e..ade0d505a32c 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -8113,6 +8113,11 @@ static void hpsa_undo_allocations_after_kdump_soft_reset(struct ctlr_info *h)
 		destroy_workqueue(h->rescan_ctlr_wq);
 		h->rescan_ctlr_wq = NULL;
 	}
+	if (h->monitor_ctlr_wq) {
+		destroy_workqueue(h->monitor_ctlr_wq);
+		h->monitor_ctlr_wq = NULL;
+	}
+
 	kfree(h);				/* init_one 1 */
 }
 
@@ -8448,8 +8453,8 @@ static void hpsa_event_monitor_worker(struct work_struct *work)
 
 	spin_lock_irqsave(&h->lock, flags);
 	if (!h->remove_in_progress)
-		schedule_delayed_work(&h->event_monitor_work,
-					HPSA_EVENT_MONITOR_INTERVAL);
+		queue_delayed_work(h->monitor_ctlr_wq, &h->event_monitor_work,
+				HPSA_EVENT_MONITOR_INTERVAL);
 	spin_unlock_irqrestore(&h->lock, flags);
 }
 
@@ -8494,7 +8499,7 @@ static void hpsa_monitor_ctlr_worker(struct work_struct *work)
 
 	spin_lock_irqsave(&h->lock, flags);
 	if (!h->remove_in_progress)
-		schedule_delayed_work(&h->monitor_ctlr_work,
+		queue_delayed_work(h->monitor_ctlr_wq, &h->monitor_ctlr_work,
 				h->heartbeat_sample_interval);
 	spin_unlock_irqrestore(&h->lock, flags);
 }
@@ -8662,6 +8667,12 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto clean7;	/* aer/h */
 	}
 
+	h->monitor_ctlr_wq = hpsa_create_controller_wq(h, "monitor");
+	if (!h->monitor_ctlr_wq) {
+		rc = -ENOMEM;
+		goto clean7;
+	}
+
 	/*
 	 * At this point, the controller is ready to take commands.
 	 * Now, if reset_devices and the hard reset didn't work, try
@@ -8791,6 +8802,10 @@ static int hpsa_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		destroy_workqueue(h->rescan_ctlr_wq);
 		h->rescan_ctlr_wq = NULL;
 	}
+	if (h->monitor_ctlr_wq) {
+		destroy_workqueue(h->monitor_ctlr_wq);
+		h->monitor_ctlr_wq = NULL;
+	}
 	kfree(h);
 	return rc;
 }
@@ -8938,6 +8953,7 @@ static void hpsa_remove_one(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&h->event_monitor_work);
 	destroy_workqueue(h->rescan_ctlr_wq);
 	destroy_workqueue(h->resubmit_wq);
+	destroy_workqueue(h->monitor_ctlr_wq);
 
 	hpsa_delete_sas_host(h);
 
diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 59e023696fff..7aa7378f70dd 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -300,6 +300,7 @@ struct ctlr_info {
 	int	needs_abort_tags_swizzled;
 	struct workqueue_struct *resubmit_wq;
 	struct workqueue_struct *rescan_ctlr_wq;
+	struct workqueue_struct *monitor_ctlr_wq;
 	atomic_t abort_cmds_available;
 	wait_queue_head_t event_sync_wait_queue;
 	struct mutex reset_mutex;

