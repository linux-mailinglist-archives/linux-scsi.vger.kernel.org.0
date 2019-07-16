Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364606AF60
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGPS4u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Tue, 16 Jul 2019 14:56:50 -0400
Received: from us-smtp-delivery-131.mimecast.com ([63.128.21.131]:43845 "EHLO
        us-smtp-delivery-131.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728495AbfGPS4u (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Jul 2019 14:56:50 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 14:56:50 EDT
Received: from mailhub4.stratus.com (134.111.1.17 [134.111.1.17]) by
 relay.mimecast.com with ESMTP id us-mta-338-PX2rPO6EOZmpvfP-lTuKFw-1; Tue,
 16 Jul 2019 14:50:39 -0400
Received: from EXHQ1.corp.stratus.com (exhq1.corp.stratus.com [134.111.200.125])
        by mailhub4.stratus.com (8.12.11/8.12.11) with ESMTP id x6GIod05002352;
        Tue, 16 Jul 2019 14:50:39 -0400
Received: from linuxdev.lnx.eng.stratus.com (134.111.220.63) by
 EXHQ1.corp.stratus.com (134.111.200.125) with Microsoft SMTP Server (TLS) id
 14.3.279.2; Tue, 16 Jul 2019 14:50:34 -0400
From:   Bill Kuzeja <William.Kuzeja@stratus.com>
To:     <linux-scsi@vger.kernel.org>
CC:     <qla2xxx-upstream@qlogic.com>, <William.Kuzeja@stratus.com>
Subject: [PATCH] qla2xxx: Fix gnl.l memory leak on adapter init failure
Date:   Tue, 16 Jul 2019 14:50:39 -0400
Message-ID: <1563303039-4367-1-git-send-email-William.Kuzeja@stratus.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MC-Unique: PX2rPO6EOZmpvfP-lTuKFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If HBA initialization fails unexpectedly (exiting via probe_failed:), we 
may fail to free vha->gnl.l. So that we don't attempt to double free,
set this pointer to NULL after a free and check for NULL at probe_failed:
so we know whether or not to call dma_free_coherent. 

Signed-off-by: Bill Kuzeja <william.kuzeja@stratus.com>
---
 drivers/scsi/qla2xxx/qla_attr.c |  2 ++
 drivers/scsi/qla2xxx/qla_os.c   | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 8d560c5..6b7b390 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2956,6 +2956,8 @@ void qla_insert_tgt_attrs(void)
 	dma_free_coherent(&ha->pdev->dev, vha->gnl.size, vha->gnl.l,
 	    vha->gnl.ldma);
 
+	vha->gnl.l = NULL;
+
 	vfree(vha->scan.l);
 
 	if (vha->qpair && vha->qpair->vp_idx == vha->vp_idx) {
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2e58cff..98e60a3 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3440,6 +3440,12 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	return 0;
 
 probe_failed:
+	if (base_vha->gnl.l) {
+		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
+				base_vha->gnl.l, base_vha->gnl.ldma);
+		base_vha->gnl.l = NULL;
+	}
+
 	if (base_vha->timer_active)
 		qla2x00_stop_timer(base_vha);
 	base_vha->flags.online = 0;
@@ -3673,7 +3679,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	if (!atomic_read(&pdev->enable_cnt)) {
 		dma_free_coherent(&ha->pdev->dev, base_vha->gnl.size,
 		    base_vha->gnl.l, base_vha->gnl.ldma);
-
+		base_vha->gnl.l = NULL;
 		scsi_host_put(base_vha->host);
 		kfree(ha);
 		pci_set_drvdata(pdev, NULL);
@@ -3713,6 +3719,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	dma_free_coherent(&ha->pdev->dev,
 		base_vha->gnl.size, base_vha->gnl.l, base_vha->gnl.ldma);
 
+	base_vha->gnl.l = NULL;
+
 	vfree(base_vha->scan.l);
 
 	if (IS_QLAFX00(ha))
@@ -4816,6 +4824,7 @@ struct scsi_qla_host *qla2x00_create_host(struct scsi_host_template *sht,
 		    "Alloc failed for scan database.\n");
 		dma_free_coherent(&ha->pdev->dev, vha->gnl.size,
 		    vha->gnl.l, vha->gnl.ldma);
+		vha->gnl.l = NULL;
 		scsi_remove_host(vha->host);
 		return NULL;
 	}
-- 
1.8.3.1

