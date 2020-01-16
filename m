Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3025F13D7D0
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2020 11:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAPKU4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jan 2020 05:20:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:33998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgAPKU4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Jan 2020 05:20:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C4F4AD8E;
        Thu, 16 Jan 2020 10:20:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Satish Kharat <satishkh@cisco.com>
Cc:     Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] fnic: do not queue commands during fwreset
Date:   Thu, 16 Jan 2020 11:20:53 +0100
Message-Id: <20200116102053.62755-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When a link is going down the driver will be calling fnic_cleanup_io(),
which will traverse all commands and calling 'done' for each found command.
While the traversal is handled under the host_lock, calling 'done' happens
after the host_lock is being dropped.

As fnic_queuecommand_lck() is being called with the host_lock held, it might
well be that it will pick the command being selected for abortion from the
above routine and enqueue it for sending, but then 'done' is being called
on that very command from the above routine.

Which of course confuses the hell out of the scsi midlayer.

So fix this by not queueing commands when fnic_cleanup_io is active.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/fnic/fnic_scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 8ef150dfb6f7..b60795893994 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -439,6 +439,9 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc, void (*done)(struct scsi_
 	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED)))
 		return SCSI_MLQUEUE_HOST_BUSY;
 
+	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET)))
+		return SCSI_MLQUEUE_HOST_BUSY;
+
 	rport = starget_to_rport(scsi_target(sc->device));
 	if (!rport) {
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-- 
2.16.4

