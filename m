Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6E1E5B3A
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2020 10:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgE1IyG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 May 2020 04:54:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgE1IyE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 28 May 2020 04:54:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0B73CB430;
        Thu, 28 May 2020 08:54:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Doug Gilbert <dgilbert@interlog.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/4] target_core_pscsi: use __scsi_device_lookup()
Date:   Thu, 28 May 2020 10:42:25 +0200
Message-Id: <20200528084227.122885-3-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200528084227.122885-1-hare@suse.de>
References: <20200528084227.122885-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of walking the list of devices manually use the helper
function to return the device directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/target/target_core_pscsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 4e37fa9b409d..38799e47b590 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -496,11 +496,9 @@ static int pscsi_configure_device(struct se_device *dev)
 	}
 
 	spin_lock_irq(sh->host_lock);
-	list_for_each_entry(sd, &sh->__devices, siblings) {
-		if ((pdv->pdv_channel_id != sd->channel) ||
-		    (pdv->pdv_target_id != sd->id) ||
-		    (pdv->pdv_lun_id != sd->lun))
-			continue;
+	sd = __scsi_device_lookup(sh, pdv->pdv_channel_id,
+				  pdv->pdv_target_id, pdv->pdv_lun_id);
+	if (sd) {
 		/*
 		 * Functions will release the held struct scsi_host->host_lock
 		 * before calling calling pscsi_add_device_to_list() to register
-- 
2.16.4

