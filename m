Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA02CEB94
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Dec 2020 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgLDKCa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 05:02:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:50498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729623AbgLDKC3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 4 Dec 2020 05:02:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C60D6AD2F;
        Fri,  4 Dec 2020 10:01:47 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/37] bfa: drop driver-defined SCSI status codes
Date:   Fri,  4 Dec 2020 11:01:12 +0100
Message-Id: <20201204100140.140863-10-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201204100140.140863-1-hare@suse.de>
References: <20201204100140.140863-1-hare@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Drop the driver-defined SCSI status code and use the generic ones
instead.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/bfa/bfa_fc.h    | 15 ---------------
 drivers/scsi/bfa/bfa_fcpim.c |  2 +-
 drivers/scsi/bfa/bfad_im.c   |  2 +-
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fc.h b/drivers/scsi/bfa/bfa_fc.h
index b00fb2409c50..d536270bbe9f 100644
--- a/drivers/scsi/bfa/bfa_fc.h
+++ b/drivers/scsi/bfa/bfa_fc.h
@@ -33,21 +33,6 @@ struct scsi_cdb_s {
 	u8         scsi_cdb[SCSI_MAX_CDBLEN];
 };
 
-/* ------------------------------------------------------------
- * SCSI status byte values
- * ------------------------------------------------------------
- */
-#define SCSI_STATUS_GOOD                   0x00
-#define SCSI_STATUS_CHECK_CONDITION        0x02
-#define SCSI_STATUS_CONDITION_MET          0x04
-#define SCSI_STATUS_BUSY                   0x08
-#define SCSI_STATUS_INTERMEDIATE           0x10
-#define SCSI_STATUS_ICM                    0x14 /* intermediate condition met */
-#define SCSI_STATUS_RESERVATION_CONFLICT   0x18
-#define SCSI_STATUS_COMMAND_TERMINATED     0x22
-#define SCSI_STATUS_QUEUE_FULL             0x28
-#define SCSI_STATUS_ACA_ACTIVE             0x30
-
 #define SCSI_MAX_ALLOC_LEN      0xFF    /* maximum allocarion length */
 
 /*
diff --git a/drivers/scsi/bfa/bfa_fcpim.c b/drivers/scsi/bfa/bfa_fcpim.c
index 38d1c453074d..7ad22288071b 100644
--- a/drivers/scsi/bfa/bfa_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcpim.c
@@ -2146,7 +2146,7 @@ __bfa_cb_ioim_comp(void *cbarg, bfa_boolean_t complete)
 		/*
 		 * setup sense information, if present
 		 */
-		if ((m->scsi_status == SCSI_STATUS_CHECK_CONDITION) &&
+		if ((m->scsi_status == SAM_STAT_CHECK_CONDITION) &&
 					m->sns_len) {
 			sns_len = m->sns_len;
 			snsinfo = BFA_SNSINFO_FROM_TAG(ioim->fcpim->fcp,
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 22f06be2606f..6b5841b1c06e 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -106,7 +106,7 @@ bfa_cb_ioim_good_comp(void *drv, struct bfad_ioim_s *dio)
 	struct bfad_itnim_data_s *itnim_data;
 	struct bfad_itnim_s *itnim;
 
-	cmnd->result = DID_OK << 16 | SCSI_STATUS_GOOD;
+	cmnd->result = DID_OK << 16 | SAM_STAT_GOOD;
 
 	/* Unmap DMA, if host is NULL, it means a scsi passthru cmd */
 	if (cmnd->device->host != NULL)
-- 
2.16.4

