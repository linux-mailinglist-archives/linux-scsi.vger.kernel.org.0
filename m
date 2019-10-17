Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9EEDB094
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406354AbfJQPAb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 11:00:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731768AbfJQPAb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Oct 2019 11:00:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E0E8B5CC;
        Thu, 17 Oct 2019 15:00:29 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        Martin George <martin.george@netapp.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH] lpfc: remove left-over BUILD_NVME defines
Date:   Thu, 17 Oct 2019 17:00:19 +0200
Message-Id: <20191017150019.75769-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The BUILD_NVME define never got defined anywhere, causing
NVMe commands to be treated as SCSI commands when freeing
the buffers.
This was causing a stuck discovery and a horrible crash
in lpfc_set_rrq_active() later on.

Fixes: c00f62e6c546 ("scsi: lpfc: Merge per-protocol WQ/CQ pairs into single per-cpu pair")

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 --
 drivers/scsi/lpfc/lpfc_scsi.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index a0aa7a555811..6e6bb8da97d6 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -9066,7 +9066,6 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 		}
 	}
 
-#if defined(BUILD_NVME)
 	/* Clear NVME stats */
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
 		for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
@@ -9074,7 +9073,6 @@ lpfc_sli4_queue_create(struct lpfc_hba *phba)
 			       sizeof(phba->sli4_hba.hdwq[idx].nvme_cstat));
 		}
 	}
-#endif
 
 	/* Clear SCSI stats */
 	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_FCP) {
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index f06f63e58596..67b7a1aed45c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -528,7 +528,6 @@ lpfc_sli4_io_xri_aborted(struct lpfc_hba *phba,
 			list_del_init(&psb->list);
 			psb->exch_busy = 0;
 			psb->status = IOSTAT_SUCCESS;
-#ifdef BUILD_NVME
 			if (psb->cur_iocbq.iocb_flag == LPFC_IO_NVME) {
 				qp->abts_nvme_io_bufs--;
 				spin_unlock(&qp->abts_io_buf_list_lock);
@@ -536,7 +535,6 @@ lpfc_sli4_io_xri_aborted(struct lpfc_hba *phba,
 				lpfc_sli4_nvme_xri_aborted(phba, axri, psb);
 				return;
 			}
-#endif
 			qp->abts_scsi_io_bufs--;
 			spin_unlock(&qp->abts_io_buf_list_lock);
 
-- 
2.16.4

