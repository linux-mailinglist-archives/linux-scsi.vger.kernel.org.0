Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499B1DC6A3
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Oct 2019 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633957AbfJRNzk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Oct 2019 09:55:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633933AbfJRNzk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 18 Oct 2019 09:55:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8996B1E4;
        Fri, 18 Oct 2019 13:55:38 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] scsi_dh_alua: Do not run STPG for implicit ALUA
Date:   Fri, 18 Oct 2019 15:55:37 +0200
Message-Id: <20191018135537.69462-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If a target only supports implicit ALUA sending a SET TARGET PORT GROUPS
command is not only pointless, but might actually cause issues.
So don't.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/device_handler/scsi_dh_alua.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 4971104b1817..0053277721d0 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -832,6 +832,10 @@ static void alua_rtpg_work(struct work_struct *work)
 		if (err != SCSI_DH_OK)
 			pg->flags &= ~ALUA_PG_RUN_STPG;
 	}
+	/* Do not run STPG if only implicit ALUA is supported */
+	if (scsi_device_tpgs(sdev) == TPGS_MODE_IMPLICIT)
+		pg->flags &= ~ALUA_PG_RUN_STPG;
+
 	if (pg->flags & ALUA_PG_RUN_STPG) {
 		pg->flags &= ~ALUA_PG_RUN_STPG;
 		spin_unlock_irqrestore(&pg->lock, flags);
-- 
2.16.4

