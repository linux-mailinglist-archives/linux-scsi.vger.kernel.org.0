Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713261D4C8D
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2020 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOL0y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 May 2020 07:26:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:48402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgEOL0y (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 15 May 2020 07:26:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1635AABF4;
        Fri, 15 May 2020 11:26:56 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] fnic: to not call 'scsi_done()' for unhandled commands
Date:   Fri, 15 May 2020 13:26:47 +0200
Message-Id: <20200515112647.49260-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The fnic drivers assigns an ioreq structure to each command, and
severs this assignment once scsi_done() has been called and the
command has been completed.
So when traversing commands to terminate outstanding I/O we should
not call scsi_done() on commands which do not have a corresponding
ioreq structure; these commands have either never entered the driver
or have already been completed.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/fnic/fnic_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 27535c90b248..8d2798cbd30f 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -1401,7 +1401,7 @@ static void fnic_cleanup_io(struct fnic *fnic, int exclude_id)
 		}
 		if (!io_req) {
 			spin_unlock_irqrestore(io_lock, flags);
-			goto cleanup_scsi_cmd;
+			continue;
 		}
 
 		CMD_SP(sc) = NULL;
-- 
2.16.4

