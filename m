Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B178136C0FA
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Apr 2021 10:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhD0Ic2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Apr 2021 04:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:49412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235214AbhD0IcG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:32:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D52A6B16A;
        Tue, 27 Apr 2021 08:31:06 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 36/40] fdomain: translate message to host byte status
Date:   Tue, 27 Apr 2021 10:30:42 +0200
Message-Id: <20210427083046.31620-37-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210427083046.31620-1-hare@suse.de>
References: <20210427083046.31620-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Instead of setting the message byte translate it to the appropriate
host byte. As error recovery would return DID_ERROR for any non-zero
message byte the translation doesn't change the error handling.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/fdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 294dbfa5c761..eda2be534aa7 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -361,8 +361,8 @@ static void fdomain_work(struct work_struct *work)
 
 	if (done) {
 		set_status_byte(cmd, cmd->SCp.Status);
-		set_msg_byte(cmd, cmd->SCp.Message);
 		set_host_byte(cmd, DID_OK);
+		scsi_msg_to_host_byte(cmd, cmd->SCp.Message);
 		fdomain_finish_cmd(fd);
 	} else {
 		if (cmd->SCp.phase & disconnect) {
-- 
2.29.2

