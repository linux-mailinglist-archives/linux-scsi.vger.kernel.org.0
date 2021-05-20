Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF365389EEE
	for <lists+linux-scsi@lfdr.de>; Thu, 20 May 2021 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhETHc5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 May 2021 03:32:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETHc4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 May 2021 03:32:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35D55B144;
        Thu, 20 May 2021 07:31:34 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] scsi: scsi_transport_fc: Remove double FC_FPORT_DELETED in mask creation
Date:   Thu, 20 May 2021 09:31:27 +0200
Message-Id: <20210520073127.132456-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove the double listed FC_FPORT_DELETING from the mask creation.

Commit 260f4aeddb48 ("scsi: scsi_transport_fc: return -EBUSY for
deleted vport") added VC_VPORT_DELETING to the flag masks. This is not
necessary as FC_FPORT_DEL is defined as VC_FPORT_DELETED |
FC_FPORT_DELETING.

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/scsi_transport_fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index da5b503dc7a1..49748cd817a5 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1686,7 +1686,7 @@ store_fc_vport_delete(struct device *dev, struct device_attribute *attr,
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	if (vport->flags & (FC_VPORT_DEL | FC_VPORT_CREATING | FC_VPORT_DELETING)) {
+	if (vport->flags & (FC_VPORT_DEL | FC_VPORT_CREATING)) {
 		spin_unlock_irqrestore(shost->host_lock, flags);
 		return -EBUSY;
 	}
-- 
2.29.2

