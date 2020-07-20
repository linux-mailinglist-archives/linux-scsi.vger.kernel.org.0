Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C805225600
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 04:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGTC5w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Jul 2020 22:57:52 -0400
Received: from smtp.infotech.no ([82.134.31.41]:42937 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgGTC5w (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 19 Jul 2020 22:57:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 088A920426C;
        Mon, 20 Jul 2020 04:57:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id okjoBkwcWnzf; Mon, 20 Jul 2020 04:57:49 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 0722A204259;
        Mon, 20 Jul 2020 04:57:46 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Bart van Assche <bvanassche@acm.org>
Subject: [PATCH v5 2/9] target_core_pscsi: use __scsi_device_lookup()
Date:   Sun, 19 Jul 2020 22:57:35 -0400
Message-Id: <20200720025742.349296-3-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720025742.349296-1-dgilbert@interlog.com>
References: <20200720025742.349296-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

Instead of walking the list of devices manually use the helper
function to return the device directly.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Bart van Assche <bvanassche@acm.org>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
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
2.25.1

