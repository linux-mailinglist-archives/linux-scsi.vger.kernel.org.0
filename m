Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C249F16A31
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEGScD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 14:32:03 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:24111 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfEGScD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 14:32:03 -0400
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
   d="scan'208";a="30471182"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 May 2019 11:32:03 -0700
Received: from AVMBX2.microsemi.net (10.100.34.32) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 May 2019
 11:32:01 -0700
Received: from [127.0.1.1] (10.238.32.34) by avmbx2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 May 2019 11:32:00 -0700
Subject: [PATCH 1/7] hpsa: correct simple mode
From:   Don Brace <don.brace@microsemi.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 7 May 2019 13:32:00 -0500
Message-ID: <155725392043.27200.2692724380711995269.stgit@brunhilda>
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

- correct issue with hpsa_simple_mode module parameter
  . driver was hanging due to incorrect interrupt setup

Reviewed-by: Justin Lindley <justin.lindley@microsemi.com>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
---
 drivers/scsi/hpsa.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index f044e7d10d63..410941afcb7e 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5511,6 +5511,9 @@ static int hpsa_ioaccel_submit(struct ctlr_info *h,
 	if (!dev)
 		return SCSI_MLQUEUE_HOST_BUSY;
 
+	if (hpsa_simple_mode)
+		return IO_ACCEL_INELIGIBLE;
+
 	cmd->host_scribble = (unsigned char *) c;
 
 	if (dev->offload_enabled) {
@@ -7963,10 +7966,15 @@ static int hpsa_alloc_cmd_pool(struct ctlr_info *h)
 static void hpsa_free_irqs(struct ctlr_info *h)
 {
 	int i;
+	int irq_vector = 0;
+
+	if (hpsa_simple_mode)
+		irq_vector = h->intr_mode;
 
 	if (!h->msix_vectors || h->intr_mode != PERF_MODE_INT) {
 		/* Single reply queue, only one irq to free */
-		free_irq(pci_irq_vector(h->pdev, 0), &h->q[h->intr_mode]);
+		free_irq(pci_irq_vector(h->pdev, irq_vector),
+				&h->q[h->intr_mode]);
 		h->q[h->intr_mode] = 0;
 		return;
 	}
@@ -7985,6 +7993,10 @@ static int hpsa_request_irqs(struct ctlr_info *h,
 	irqreturn_t (*intxhandler)(int, void *))
 {
 	int rc, i;
+	int irq_vector = 0;
+
+	if (hpsa_simple_mode)
+		irq_vector = h->intr_mode;
 
 	/*
 	 * initialize h->q[x] = x so that interrupt handlers know which
@@ -8020,14 +8032,14 @@ static int hpsa_request_irqs(struct ctlr_info *h,
 		if (h->msix_vectors > 0 || h->pdev->msi_enabled) {
 			sprintf(h->intrname[0], "%s-msi%s", h->devname,
 				h->msix_vectors ? "x" : "");
-			rc = request_irq(pci_irq_vector(h->pdev, 0),
+			rc = request_irq(pci_irq_vector(h->pdev, irq_vector),
 				msixhandler, 0,
 				h->intrname[0],
 				&h->q[h->intr_mode]);
 		} else {
 			sprintf(h->intrname[h->intr_mode],
 				"%s-intx", h->devname);
-			rc = request_irq(pci_irq_vector(h->pdev, 0),
+			rc = request_irq(pci_irq_vector(h->pdev, irq_vector),
 				intxhandler, IRQF_SHARED,
 				h->intrname[0],
 				&h->q[h->intr_mode]);
@@ -8035,7 +8047,7 @@ static int hpsa_request_irqs(struct ctlr_info *h,
 	}
 	if (rc) {
 		dev_err(&h->pdev->dev, "failed to get irq %d for %s\n",
-		       pci_irq_vector(h->pdev, 0), h->devname);
+		       pci_irq_vector(h->pdev, irq_vector), h->devname);
 		hpsa_free_irqs(h);
 		return -ENODEV;
 	}

