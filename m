Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8B3153A67
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Feb 2020 22:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBEVnZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Feb 2020 16:43:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:52460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgBEVnZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 5 Feb 2020 16:43:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87A3AAD12;
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
Subject: [PATCH v2 3/3] scsi: qla2xxx: set UNLOADING before waiting for session deletion
Date:   Wed,  5 Feb 2020 22:44:22 +0100
Message-Id: <20200205214422.3657-4-mwilck@suse.com>
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

The purpose of the UNLOADING flag is to avoid port login procedures
to continue when a controller is in the process of shutting down.
It makes sense to set this flag before starting session teardown.
The only operations that must be able to continue are LOGO, PRLO,
and the like.

Furthermore, use atomic test_and_set_bit() to avoid the shutdown
being run multiple times in parallel. In qla2x00_disable_board_on_pci_error(),
the test for UNLOADING is postponed until after the check for an already
disabled PCI board.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index e81080d..8329f95 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3720,16 +3720,15 @@ qla2x00_remove_one(struct pci_dev *pdev)
 	}
 	qla2x00_wait_for_hba_ready(base_vha);
 
-	qla2x00_wait_for_sess_deletion(base_vha);
-
 	/*
-	 * if UNLOAD flag is already set, then continue unload,
+	 * if UNLOADING flag is already set, then continue unload,
 	 * where it was set first.
 	 */
-	if (test_bit(UNLOADING, &base_vha->dpc_flags))
+	if (test_and_set_bit(UNLOADING, &base_vha->dpc_flags))
 		return;
 
-	set_bit(UNLOADING, &base_vha->dpc_flags);
+	qla2x00_wait_for_sess_deletion(base_vha);
+
 	if (IS_QLA25XX(ha) || IS_QLA2031(ha) || IS_QLA27XX(ha) ||
 	    IS_QLA28XX(ha)) {
 		if (ha->flags.fw_started)
@@ -6046,13 +6045,6 @@ qla2x00_disable_board_on_pci_error(struct work_struct *work)
 	struct pci_dev *pdev = ha->pdev;
 	scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
 
-	/*
-	 * if UNLOAD flag is already set, then continue unload,
-	 * where it was set first.
-	 */
-	if (test_bit(UNLOADING, &base_vha->dpc_flags))
-		return;
-
 	ql_log(ql_log_warn, base_vha, 0x015b,
 	    "Disabling adapter.\n");
 
@@ -6063,9 +6055,14 @@ qla2x00_disable_board_on_pci_error(struct work_struct *work)
 		return;
 	}
 
-	qla2x00_wait_for_sess_deletion(base_vha);
+	/*
+	 * if UNLOADING flag is already set, then continue unload,
+	 * where it was set first.
+	 */
+	if (test_and_set_bit(UNLOADING, &base_vha->dpc_flags))
+		return;
 
-	set_bit(UNLOADING, &base_vha->dpc_flags);
+	qla2x00_wait_for_sess_deletion(base_vha);
 
 	qla2x00_delete_all_vps(ha, base_vha);
 
-- 
2.25.0

