Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9246C44478
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfFMQhY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbfFMHOt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 882B130872EC;
        Thu, 13 Jun 2019 07:14:48 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFC7D60C8B;
        Thu, 13 Jun 2019 07:14:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 10/15] scsi: aha152x: use sg helper to operate sgl
Date:   Thu, 13 Jun 2019 15:13:30 +0800
Message-Id: <20190613071335.5679-11-ming.lei@redhat.com>
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Jun 2019 07:14:48 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sg helper to
operate sgl.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/aha152x.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 97872838b983..bc9d12aa7880 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -2033,7 +2033,7 @@ static void datai_run(struct Scsi_Host *shpnt)
 				    CURRENT_SC->SCp.buffers_residual > 0) {
 					/* advance to next buffer */
 					CURRENT_SC->SCp.buffers_residual--;
-					CURRENT_SC->SCp.buffer++;
+					CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
 					CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
 					CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 				}
@@ -2139,7 +2139,7 @@ static void datao_run(struct Scsi_Host *shpnt)
 		if(CURRENT_SC->SCp.this_residual==0 && CURRENT_SC->SCp.buffers_residual>0) {
 			/* advance to next buffer */
 			CURRENT_SC->SCp.buffers_residual--;
-			CURRENT_SC->SCp.buffer++;
+			CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
 			CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 		}
@@ -2160,20 +2160,29 @@ static void datao_end(struct Scsi_Host *shpnt)
 	if(TESTLO(DMASTAT, DFIFOEMP)) {
 		int data_count = (DATA_LEN - scsi_get_resid(CURRENT_SC)) -
 			GETSTCNT();
+		struct scatterlist *sg = scsi_sglist(CURRENT_SC);
+		int left, i = 0;
 
 		CMD_INC_RESID(CURRENT_SC, data_count);
 
 		data_count -= CURRENT_SC->SCp.ptr -
 			SG_ADDRESS(CURRENT_SC->SCp.buffer);
-		while(data_count>0) {
-			CURRENT_SC->SCp.buffer--;
-			CURRENT_SC->SCp.buffers_residual++;
-			data_count -= CURRENT_SC->SCp.buffer->length;
+
+		left = CURRENT_SC->transfersize - data_count;
+		for (i = 0; left > 0 && !sg_is_last(sg); i++, sg = sg_next(sg)) {
+			if (left < sg->length)
+				break;
+			left -= sg->length;
+		}
+
+		if (data_count > 0) {
+			CURRENT_SC->SCp.buffers_residual += i;
+			CURRENT_SC->SCp.buffer = sg;
+
+			CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) + left;
+			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length -
+				left;
 		}
-		CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) -
-			data_count;
-		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length +
-			data_count;
 	}
 
 	SETPORT(SXFRCTL0, CH1|CLRCH1|CLRSTCNT);
-- 
2.20.1

