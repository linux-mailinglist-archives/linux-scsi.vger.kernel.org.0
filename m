Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE303671D8
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Apr 2021 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbhDURt2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 21 Apr 2021 13:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245093AbhDURtO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 21 Apr 2021 13:49:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39C3FB302;
        Wed, 21 Apr 2021 17:48:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 39/42] fdomain: drop last argument to fdomain_finish_cmd()
Date:   Wed, 21 Apr 2021 19:47:46 +0200
Message-Id: <20210421174749.11221-40-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210421174749.11221-1-hare@suse.de>
References: <20210421174749.11221-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set the SCSI host status before calling fdomein_finish_cmd(),
and drop the last argument to that function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/fdomain.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 772bdc93930a..294dbfa5c761 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -202,11 +202,10 @@ static int fdomain_select(struct Scsi_Host *sh, int target)
 	return 1;
 }
 
-static void fdomain_finish_cmd(struct fdomain *fd, int result)
+static void fdomain_finish_cmd(struct fdomain *fd)
 {
 	outb(0, fd->base + REG_ICTL);
 	fdomain_make_bus_idle(fd);
-	fd->cur_cmd->result = result;
 	fd->cur_cmd->scsi_done(fd->cur_cmd);
 	fd->cur_cmd = NULL;
 }
@@ -273,7 +272,8 @@ static void fdomain_work(struct work_struct *work)
 	if (cmd->SCp.phase & in_arbitration) {
 		status = inb(fd->base + REG_ASTAT);
 		if (!(status & ASTAT_ARB)) {
-			fdomain_finish_cmd(fd, DID_BUS_BUSY << 16);
+			set_host_byte(cmd, DID_BUS_BUSY);
+			fdomain_finish_cmd(fd);
 			goto out;
 		}
 		cmd->SCp.phase = in_selection;
@@ -290,7 +290,8 @@ static void fdomain_work(struct work_struct *work)
 		if (!(status & BSTAT_BSY)) {
 			/* Try again, for slow devices */
 			if (fdomain_select(cmd->device->host, scmd_id(cmd))) {
-				fdomain_finish_cmd(fd, DID_NO_CONNECT << 16);
+				set_host_byte(cmd, DID_NO_CONNECT);
+				fdomain_finish_cmd(fd);
 				goto out;
 			}
 			/* Stop arbitration and enable parity */
@@ -333,7 +334,7 @@ static void fdomain_work(struct work_struct *work)
 			break;
 		case BSTAT_MSG | BSTAT_CMD | BSTAT_IO:	/* MESSAGE IN */
 			cmd->SCp.Message = inb(fd->base + REG_SCSI_DATA);
-			if (!cmd->SCp.Message)
+			if (cmd->SCp.Message == COMMAND_COMPLETE)
 				++done;
 			break;
 		}
@@ -359,9 +360,10 @@ static void fdomain_work(struct work_struct *work)
 		fdomain_read_data(cmd);
 
 	if (done) {
-		fdomain_finish_cmd(fd, (cmd->SCp.Status & 0xff) |
-				   ((cmd->SCp.Message & 0xff) << 8) |
-				   (DID_OK << 16));
+		set_status_byte(cmd, cmd->SCp.Status);
+		set_msg_byte(cmd, cmd->SCp.Message);
+		set_host_byte(cmd, DID_OK);
+		fdomain_finish_cmd(fd);
 	} else {
 		if (cmd->SCp.phase & disconnect) {
 			outb(ICTL_FIFO | ICTL_SEL | ICTL_REQ | FIFO_COUNT,
@@ -439,10 +441,10 @@ static int fdomain_abort(struct scsi_cmnd *cmd)
 
 	fdomain_make_bus_idle(fd);
 	fd->cur_cmd->SCp.phase |= aborted;
-	fd->cur_cmd->result = DID_ABORT << 16;
 
 	/* Aborts are not done well. . . */
-	fdomain_finish_cmd(fd, DID_ABORT << 16);
+	set_host_byte(fd->cur_cmd, DID_ABORT);
+	fdomain_finish_cmd(fd);
 	spin_unlock_irqrestore(sh->host_lock, flags);
 	return SUCCESS;
 }
-- 
2.29.2

