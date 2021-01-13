Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB42F471C
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Jan 2021 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbhAMJGd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 Jan 2021 04:06:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:53818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbhAMJG3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 13 Jan 2021 04:06:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBB85B741;
        Wed, 13 Jan 2021 09:05:03 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/35] aic7xxx,aic79xx: kill pointless forward declarations
Date:   Wed, 13 Jan 2021 10:04:32 +0100
Message-Id: <20210113090500.129644-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113090500.129644-1-hare@suse.de>
References: <20210113090500.129644-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/aic7xxx/aic79xx_osm.h | 23 -----------------------
 drivers/scsi/aic7xxx/aic7xxx_osm.h | 23 -----------------------
 2 files changed, 46 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
index d6e38298f15b..35ec24f28d2c 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -497,29 +497,6 @@ int	ahd_proc_write_seeprom(struct Scsi_Host *, char *, int);
 int	ahd_linux_show_info(struct seq_file *,struct Scsi_Host *);
 
 /*********************** Transaction Access Wrappers **************************/
-static inline void ahd_cmd_set_transaction_status(struct scsi_cmnd *, uint32_t);
-static inline void ahd_set_transaction_status(struct scb *, uint32_t);
-static inline void ahd_cmd_set_scsi_status(struct scsi_cmnd *, uint32_t);
-static inline void ahd_set_scsi_status(struct scb *, uint32_t);
-static inline uint32_t ahd_cmd_get_transaction_status(struct scsi_cmnd *cmd);
-static inline uint32_t ahd_get_transaction_status(struct scb *);
-static inline uint32_t ahd_cmd_get_scsi_status(struct scsi_cmnd *cmd);
-static inline uint32_t ahd_get_scsi_status(struct scb *);
-static inline void ahd_set_transaction_tag(struct scb *, int, u_int);
-static inline u_long ahd_get_transfer_length(struct scb *);
-static inline int ahd_get_transfer_dir(struct scb *);
-static inline void ahd_set_residual(struct scb *, u_long);
-static inline void ahd_set_sense_residual(struct scb *scb, u_long resid);
-static inline u_long ahd_get_residual(struct scb *);
-static inline u_long ahd_get_sense_residual(struct scb *);
-static inline int ahd_perform_autosense(struct scb *);
-static inline uint32_t ahd_get_sense_bufsize(struct ahd_softc *,
-					       struct scb *);
-static inline void ahd_notify_xfer_settings_change(struct ahd_softc *,
-						     struct ahd_devinfo *);
-static inline void ahd_platform_scb_free(struct ahd_softc *ahd,
-					   struct scb *scb);
-static inline void ahd_freeze_scb(struct scb *scb);
 
 static inline
 void ahd_cmd_set_transaction_status(struct scsi_cmnd *cmd, uint32_t status)
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index 125ba5eb175d..53240f53b654 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -515,29 +515,6 @@ int	ahc_linux_show_info(struct seq_file *, struct Scsi_Host *);
 
 /*************************** Domain Validation ********************************/
 /*********************** Transaction Access Wrappers *************************/
-static inline void ahc_cmd_set_transaction_status(struct scsi_cmnd *, uint32_t);
-static inline void ahc_set_transaction_status(struct scb *, uint32_t);
-static inline void ahc_cmd_set_scsi_status(struct scsi_cmnd *, uint32_t);
-static inline void ahc_set_scsi_status(struct scb *, uint32_t);
-static inline uint32_t ahc_cmd_get_transaction_status(struct scsi_cmnd *cmd);
-static inline uint32_t ahc_get_transaction_status(struct scb *);
-static inline uint32_t ahc_cmd_get_scsi_status(struct scsi_cmnd *cmd);
-static inline uint32_t ahc_get_scsi_status(struct scb *);
-static inline void ahc_set_transaction_tag(struct scb *, int, u_int);
-static inline u_long ahc_get_transfer_length(struct scb *);
-static inline int ahc_get_transfer_dir(struct scb *);
-static inline void ahc_set_residual(struct scb *, u_long);
-static inline void ahc_set_sense_residual(struct scb *scb, u_long resid);
-static inline u_long ahc_get_residual(struct scb *);
-static inline u_long ahc_get_sense_residual(struct scb *);
-static inline int ahc_perform_autosense(struct scb *);
-static inline uint32_t ahc_get_sense_bufsize(struct ahc_softc *,
-					       struct scb *);
-static inline void ahc_notify_xfer_settings_change(struct ahc_softc *,
-						     struct ahc_devinfo *);
-static inline void ahc_platform_scb_free(struct ahc_softc *ahc,
-					   struct scb *scb);
-static inline void ahc_freeze_scb(struct scb *scb);
 
 static inline
 void ahc_cmd_set_transaction_status(struct scsi_cmnd *cmd, uint32_t status)
-- 
2.29.2

