Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6FF1C8277
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 08:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgEGG0p (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 02:26:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGG0p (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 May 2020 02:26:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 428F4AF01;
        Thu,  7 May 2020 06:26:47 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] scsi: remove 'list' entry from struct scsi_cmnd
Date:   Thu,  7 May 2020 08:26:42 +0200
Message-Id: <20200507062642.100612-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Leftover from commandlist removal.

Fixes: c5a9707672fe ("scsi: core: Remove cmd_list functionality")
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/aacraid/aachba.c | 1 -
 include/scsi/scsi_cmnd.h      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index eb72ac8136c3..2b868f8db8ff 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -814,7 +814,6 @@ int aac_probe_container(struct aac_dev *dev, int cid)
 		kfree(scsidev);
 		return -ENOMEM;
 	}
-	scsicmd->list.next = NULL;
 	scsicmd->scsi_done = aac_probe_container_scsi_done;
 
 	scsicmd->device = scsidev;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 80ac89e47b47..7f047fdd34ac 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -68,7 +68,6 @@ struct scsi_pointer {
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
-	struct list_head list;  /* scsi_cmnd participates in queue lists */
 	struct list_head eh_entry; /* entry for the host eh_cmd_q */
 	struct delayed_work abort_work;
 
-- 
2.16.4

