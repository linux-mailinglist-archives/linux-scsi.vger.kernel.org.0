Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846B65179AA
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbiEBWFa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 May 2022 18:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387774AbiEBWDt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 May 2022 18:03:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C3DEE6
        for <linux-scsi@vger.kernel.org>; Mon,  2 May 2022 15:00:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3F7D1F896;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651528800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qg8pe/ZT6UuzTw+xkQ7k5SEqWlac313RiBRByvf/Hwk=;
        b=ochZYEqp6HMSbmJFKA7BDTTxYGGKDdLsDXck/F9I1SbY2L7nXQp4LE0N3+R5nLrajyIIYl
        jv5sQjsOHXmHjQWaD0g5627bR+JQX02SIDRaolbHWpURtXGF+OawLynIbTMASkPjRA6T/d
        vSDTYtoSJ0w1qhFvTIa40JrmsTcH2+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651528800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qg8pe/ZT6UuzTw+xkQ7k5SEqWlac313RiBRByvf/Hwk=;
        b=xRPK2oP0feRQEwPJ1WUM4X8GrfF5rvJS4pAgif8X602i9Eog25h9THsKmNuqLYSn8k+UM0
        +GHEmkwNRPmhzuBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id CD5DA2C15F;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id CA718519415A; Tue,  3 May 2022 00:00:00 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 07/11] aha152x: look for stuck command when resetting device
Date:   Mon,  2 May 2022 23:59:48 +0200
Message-Id: <20220502215953.5463-14-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220502215953.5463-1-hare@suse.de>
References: <20220502215953.5463-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

The LLDD needs a command to send the reset with, so look at the
list of outstanding commands to get one.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aha152x.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index caeebfb67149..7e58f25c599b 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -1070,24 +1070,28 @@ static int aha152x_abort(struct scsi_cmnd *SCpnt)
  */
 static int aha152x_device_reset(struct scsi_cmnd * SCpnt)
 {
-	struct Scsi_Host *shpnt = SCpnt->device->host;
+	struct scsi_device *sdev = SCpnt->device;
+	struct Scsi_Host *shpnt = sdev->host;
 	DECLARE_COMPLETION(done);
 	int ret, issued, disconnected;
-	unsigned char old_cmd_len = SCpnt->cmd_len;
+	unsigned char old_cmd_len;
 	unsigned long flags;
 	unsigned long timeleft;
 
-	if(CURRENT_SC==SCpnt) {
-		scmd_printk(KERN_ERR, SCpnt, "cannot reset current device\n");
-		return FAILED;
-	}
-
 	DO_LOCK(flags);
-	issued       = remove_SC(&ISSUE_SC, SCpnt) == NULL;
-	disconnected = issued && remove_SC(&DISCONNECTED_SC, SCpnt);
+	/* Look for the stuck command */
+	SCpnt = remove_lun_SC(&ISSUE_SC, sdev->id, sdev->lun);
+	if (SCpnt)
+		issued = 1;
+	else
+		SCpnt = remove_lun_SC(&DISCONNECTED_SC, sdev->id, sdev->lun);
+	if (!issued && SCpnt)
+		disconnected = 1;
 	DO_UNLOCK(flags);
-
-	SCpnt->cmd_len         = 0;
+	if (!SCpnt)
+		return FAILED;
+	old_cmd_len = SCpnt->cmd_len;
+	SCpnt->cmd_len = 0;
 
 	aha152x_internal_queue(SCpnt, &done, resetting);
 
-- 
2.29.2

