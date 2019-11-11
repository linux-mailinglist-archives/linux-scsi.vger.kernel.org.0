Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE0F7267
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Nov 2019 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKKpa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Nov 2019 05:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:53156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbfKKKp3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 Nov 2019 05:45:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48096B296;
        Mon, 11 Nov 2019 10:45:28 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] scsi_dh_rdac: avoid crash during rescan
Date:   Mon, 11 Nov 2019 11:45:22 +0100
Message-Id: <20191111104522.99531-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During rescanning the device might already have been removed, so
we should drop the BUG_ON and just ignore the non-existing device.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/device_handler/scsi_dh_rdac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 5efc959493ec..33a71df5ee59 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -424,8 +424,8 @@ static int check_ownership(struct scsi_device *sdev, struct rdac_dh_data *h)
 		rcu_read_lock();
 		list_for_each_entry_rcu(tmp, &h->ctlr->dh_list, node) {
 			/* h->sdev should always be valid */
-			BUG_ON(!tmp->sdev);
-			tmp->sdev->access_state = access_state;
+			if (tmp->sdev) {
+				tmp->sdev->access_state = access_state;
 		}
 		rcu_read_unlock();
 		err = SCSI_DH_OK;
-- 
2.16.4

