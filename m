Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70522369159
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Apr 2021 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhDWLlI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Apr 2021 07:41:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:46958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhDWLks (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Apr 2021 07:40:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D48A7B1FC;
        Fri, 23 Apr 2021 11:39:55 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 35/39] fdomain: translate message to host byte status
Date:   Fri, 23 Apr 2021 13:39:40 +0200
Message-Id: <20210423113944.42672-36-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210423113944.42672-1-hare@suse.de>
References: <20210423113944.42672-1-hare@suse.de>
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
index 294dbfa5c761..2b946cb02693 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -361,8 +361,8 @@ static void fdomain_work(struct work_struct *work)
 
 	if (done) {
 		set_status_byte(cmd, cmd->SCp.Status);
-		set_msg_byte(cmd, cmd->SCp.Message);
 		set_host_byte(cmd, DID_OK);
+		translate_msg_byte(cmd, cmd->SCp. Message);
 		fdomain_finish_cmd(fd);
 	} else {
 		if (cmd->SCp.phase & disconnect) {
-- 
2.29.2

