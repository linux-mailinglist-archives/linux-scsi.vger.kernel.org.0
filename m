Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1201C2F183F
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Jan 2021 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbhAKO0h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 09:26:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46926 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbhAKO0g (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610375150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ubsV0ogsPR6zBl9lZYAJGLqjTuIfhgtNlVMsPLHCR+o=;
        b=ZHpLm6VdxksaPw95c9oOOEZPT8Ve6aAWjMoDMLBUXSE6Kr462mIuy/Xnymd42Z1jX9hgL1
        dZOoOnIy9irX4t88g0sItcLSjj2OxzvZ1/Liy75BW+7MVHB3+BzuUOrGmr7m6CiAZsliXm
        8HXJqpcRm96pJK0ffxg/qLhB3WjyqaI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB24DAB3E;
        Mon, 11 Jan 2021 14:25:50 +0000 (UTC)
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-scsi@vger.kernel.org,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Martin Wilck <mwilck@suse.com>
Subject: [PATCH] scsi: scsi_transport_srp: don't block target in failfast state
Date:   Mon, 11 Jan 2021 15:25:41 +0100
Message-Id: <20210111142541.21534-1-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

If the port is in SRP_RPORT_FAIL_FAST state when srp_reconnect_rport()
is entered, a transition to SDEV_BLOCK would be illegal, and a kernel
WARNING would be triggered. Skip scsi_target_block() in this case.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 drivers/scsi/scsi_transport_srp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_srp.c b/drivers/scsi/scsi_transport_srp.c
index cba1cf6a1c12..1e939a2a387f 100644
--- a/drivers/scsi/scsi_transport_srp.c
+++ b/drivers/scsi/scsi_transport_srp.c
@@ -541,7 +541,14 @@ int srp_reconnect_rport(struct srp_rport *rport)
 	res = mutex_lock_interruptible(&rport->mutex);
 	if (res)
 		goto out;
-	scsi_target_block(&shost->shost_gendev);
+	if (rport->state != SRP_RPORT_FAIL_FAST)
+		/*
+		 * sdev state must be SDEV_TRANSPORT_OFFLINE, transition
+		 * to SDEV_BLOCK is illegal. Calling scsi_target_unblock()
+		 * later is ok though, scsi_internal_device_unblock_nowait()
+		 * treats SDEV_TRANSPORT_OFFLINE like SDEV_BLOCK.
+		 */
+		scsi_target_block(&shost->shost_gendev);
 	res = rport->state != SRP_RPORT_LOST ? i->f->reconnect(rport) : -ENODEV;
 	pr_debug("%s (state %d): transport.reconnect() returned %d\n",
 		 dev_name(&shost->shost_gendev), rport->state, res);
-- 
2.29.2

