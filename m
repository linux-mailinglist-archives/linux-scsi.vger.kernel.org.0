Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65BB2FFE63
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 09:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbhAVIk6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Jan 2021 03:40:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:56210 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbhAVIkr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 Jan 2021 03:40:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 1048DE0496;
        Fri, 22 Jan 2021 00:39:31 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fBzHxDwNO5Fp; Fri, 22 Jan 2021 00:39:30 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     dgilbert@interlog.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] scsi_logging: print cdb into new line after opcode
Date:   Fri, 22 Jan 2021 09:39:18 +0100
Message-Id: <20210122083918.901-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current log message results in a line like the following where
the first byte is duplicated, giving a wrong impression:

sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 60 40 00 00 01 00

Print the cdb into a new line in any case, not only when cmd_len is
greater than 16. The above example error will then read:

sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x28
28 00 01 c0 09 00 00 00 08 00

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/scsi/scsi_logging.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_logging.c b/drivers/scsi/scsi_logging.c
index 8ea44c6595ef..0081d3936f83 100644
--- a/drivers/scsi/scsi_logging.c
+++ b/drivers/scsi/scsi_logging.c
@@ -200,10 +200,11 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 	if (off >= logbuf_len)
 		goto out_printk;
 
+	/* Print opcode in one line and use separate lines for CDB */
+	off += scnprintf(logbuf + off, logbuf_len - off, "\n");
+
 	/* print out all bytes in cdb */
 	if (cmd->cmd_len > 16) {
-		/* Print opcode in one line and use separate lines for CDB */
-		off += scnprintf(logbuf + off, logbuf_len - off, "\n");
 		dev_printk(KERN_INFO, &cmd->device->sdev_gendev, "%s", logbuf);
 		for (k = 0; k < cmd->cmd_len; k += 16) {
 			size_t linelen = min(cmd->cmd_len - k, 16);
@@ -224,7 +225,6 @@ void scsi_print_command(struct scsi_cmnd *cmd)
 		goto out;
 	}
 	if (!WARN_ON(off > logbuf_len - 49)) {
-		off += scnprintf(logbuf + off, logbuf_len - off, " ");
 		hex_dump_to_buffer(cmd->cmnd, cmd->cmd_len, 16, 1,
 				   logbuf + off, logbuf_len - off,
 				   false);
-- 
2.20.1

