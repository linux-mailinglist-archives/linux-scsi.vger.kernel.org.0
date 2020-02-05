Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D7153A64
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Feb 2020 22:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBEVnY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Feb 2020 16:43:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:52424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEVnY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Feb 2020 16:43:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37A2EACD0;
        Wed,  5 Feb 2020 21:43:23 +0000 (UTC)
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 2/3] scsi: qla2xxx: don't shut down firmware before closing sessions
Date:   Wed,  5 Feb 2020 22:44:21 +0100
Message-Id: <20200205214422.3657-3-mwilck@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205214422.3657-1-mwilck@suse.com>
References: <20200205214422.3657-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

Since 45235022da99, the firmware is shut down early in the controller
shutdown process. This causes commands sent to the firmware (such as LOGO)
to hang forever. Eventually one or more timeouts will be triggered.
Move the stopping of the firmware until after sessions have terminated.

Fixes: 45235022da99 ("scsi: qla2xxx: Fix driver unload by shutting down chip")
Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 2dafb46..e81080d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3720,6 +3720,16 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	}
 	qla2x00_wait_for_hba_ready(base_vha);
 
+	qla2x00_wait_for_sess_deletion(base_vha);
+
+	/*
+	 * if UNLOAD flag is already set, then continue unload,
+	 * where it was set first.
+	 */
+	if (test_bit(UNLOADING, &base_vha->dpc_flags))
+		return;
+
+	set_bit(UNLOADING, &base_vha->dpc_flags);
 	if (IS_QLA25XX(ha) || IS_QLA2031(ha) || IS_QLA27XX(ha) ||
 	    IS_QLA28XX(ha)) {
 		if (ha->flags.fw_started)
@@ -3736,17 +3746,6 @@ qla2x00_remove_one(struct pci_dev *pdev)
 		qla2x00_try_to_stop_firmware(base_vha);
 	}
 
-	qla2x00_wait_for_sess_deletion(base_vha);
-
-	/*
-	 * if UNLOAD flag is already set, then continue unload,
-	 * where it was set first.
-	 */
-	if (test_bit(UNLOADING, &base_vha->dpc_flags))
-		return;
-
-	set_bit(UNLOADING, &base_vha->dpc_flags);
-
 	qla_nvme_delete(base_vha);
 
 	dma_free_coherent(&ha->pdev->dev,
-- 
2.25.0

