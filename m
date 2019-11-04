Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF09FEDB19
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 10:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfKDJCd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 04:02:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfKDJCQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 4 Nov 2019 04:02:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02887B4B0;
        Mon,  4 Nov 2019 09:02:11 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/52] nsp_cs: use standard SAM status codes
Date:   Mon,  4 Nov 2019 10:01:13 +0100
Message-Id: <20191104090151.129140-15-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104090151.129140-1-hare@suse.de>
References: <20191104090151.129140-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use standard SAM status codes and omit the explicit shift to convert
from linux-specific ones.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/pcmcia/nsp_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 97416e1dcc5b..8e905fb94fd3 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -223,7 +223,7 @@ static int nsp_queuecommand_lck(struct scsi_cmnd *SCpnt,
 
 	data->CurrentSC		= SCpnt;
 
-	SCpnt->SCp.Status	= CHECK_CONDITION;
+	SCpnt->SCp.Status	= SAM_STAT_CHECK_CONDITION;
 	SCpnt->SCp.Message	= 0;
 	SCpnt->SCp.have_data_in = IO_UNKNOWN;
 	SCpnt->SCp.sent_command = 0;
-- 
2.16.4

