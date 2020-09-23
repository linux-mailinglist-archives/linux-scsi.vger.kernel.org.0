Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6B275279
	for <lists+linux-scsi@lfdr.de>; Wed, 23 Sep 2020 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIWHvd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 23 Sep 2020 03:51:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIWHvd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 23 Sep 2020 03:51:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C748EAE0D;
        Wed, 23 Sep 2020 07:52:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] scsi_dh_alua: do not call 'BUG_ON' for non-existing sdev
Date:   Wed, 23 Sep 2020 09:51:30 +0200
Message-Id: <20200923075130.12943-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When evaluating the target port group state we might race with
device removal, causing the code to iterate over sdevs which have
been removed.
This situation doesn't warrant a BUG_ON() statement as we can
easily recover from here.
So replace the BUG_ON() with a simple 'if' condition.

Reported-by: Brian Bunker <brian@purestorage.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index f32da0ca529e..e97b1d1ea123 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -659,7 +659,8 @@ static int alua_rtpg(struct scsi_device *sdev, struct alua_port_group *pg)
 					list_for_each_entry_rcu(h,
 						&tmp_pg->dh_list, node) {
 						/* h->sdev should always be valid */
-						BUG_ON(!h->sdev);
+						if (!h->sdev)
+							continue;
 						h->sdev->access_state = desc[0];
 					}
 					rcu_read_unlock();
@@ -705,7 +706,8 @@ static int alua_rtpg(struct scsi_device *sdev, struct alua_port_group *pg)
 			pg->expiry = 0;
 			rcu_read_lock();
 			list_for_each_entry_rcu(h, &pg->dh_list, node) {
-				BUG_ON(!h->sdev);
+				if (!h->sdev)
+					continue;
 				h->sdev->access_state =
 					(pg->state & SCSI_ACCESS_STATE_MASK);
 				if (pg->pref)
-- 
2.26.2

