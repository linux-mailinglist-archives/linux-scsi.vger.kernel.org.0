Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0C496EF
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfFRBjS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 21:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfFRBjS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 21:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B52943082E70;
        Tue, 18 Jun 2019 01:39:17 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9996F7C655;
        Tue, 18 Jun 2019 01:39:14 +0000 (UTC)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 11/16] scsi: aha152x: use sg helper to operate scatterlist
Date:   Tue, 18 Jun 2019 09:37:52 +0800
Message-Id: <20190618013757.22401-12-ming.lei@redhat.com>
In-Reply-To: <20190618013757.22401-1-ming.lei@redhat.com>
References: <20190618013757.22401-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 18 Jun 2019 01:39:17 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Finn added the change to replace SCp.buffers_residual with sg_is_last()
for fixing updating it, and the similar change has been applied on
NCR5380.c

Cc: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/aha152x.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 97872838b983..f07f3fa9b58d 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -948,7 +948,6 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 	   SCp.ptr              : buffer pointer
 	   SCp.this_residual    : buffer length
 	   SCp.buffer           : next buffer
-	   SCp.buffers_residual : left buffers in list
 	   SCp.phase            : current state of the command */
 
 	if ((phase & resetting) || !scsi_sglist(SCpnt)) {
@@ -956,13 +955,11 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
 		SCpnt->SCp.this_residual = 0;
 		scsi_set_resid(SCpnt, 0);
 		SCpnt->SCp.buffer           = NULL;
-		SCpnt->SCp.buffers_residual = 0;
 	} else {
 		scsi_set_resid(SCpnt, scsi_bufflen(SCpnt));
 		SCpnt->SCp.buffer           = scsi_sglist(SCpnt);
 		SCpnt->SCp.ptr              = SG_ADDRESS(SCpnt->SCp.buffer);
 		SCpnt->SCp.this_residual    = SCpnt->SCp.buffer->length;
-		SCpnt->SCp.buffers_residual = scsi_sg_count(SCpnt) - 1;
 	}
 
 	DO_LOCK(flags);
@@ -2030,10 +2027,9 @@ static void datai_run(struct Scsi_Host *shpnt)
 				}
 
 				if (CURRENT_SC->SCp.this_residual == 0 &&
-				    CURRENT_SC->SCp.buffers_residual > 0) {
+				    !sg_is_last(CURRENT_SC->SCp.buffer)) {
 					/* advance to next buffer */
-					CURRENT_SC->SCp.buffers_residual--;
-					CURRENT_SC->SCp.buffer++;
+					CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
 					CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
 					CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 				}
@@ -2136,10 +2132,10 @@ static void datao_run(struct Scsi_Host *shpnt)
 			CMD_INC_RESID(CURRENT_SC, -2 * data_count);
 		}
 
-		if(CURRENT_SC->SCp.this_residual==0 && CURRENT_SC->SCp.buffers_residual>0) {
+		if (CURRENT_SC->SCp.this_residual == 0 &&
+		    !sg_is_last(CURRENT_SC->SCp.buffer)) {
 			/* advance to next buffer */
-			CURRENT_SC->SCp.buffers_residual--;
-			CURRENT_SC->SCp.buffer++;
+			CURRENT_SC->SCp.buffer = sg_next(CURRENT_SC->SCp.buffer);
 			CURRENT_SC->SCp.ptr           = SG_ADDRESS(CURRENT_SC->SCp.buffer);
 			CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length;
 		}
@@ -2158,22 +2154,26 @@ static void datao_run(struct Scsi_Host *shpnt)
 static void datao_end(struct Scsi_Host *shpnt)
 {
 	if(TESTLO(DMASTAT, DFIFOEMP)) {
-		int data_count = (DATA_LEN - scsi_get_resid(CURRENT_SC)) -
-			GETSTCNT();
+		u32 datao_cnt = GETSTCNT();
+		int datao_out = DATA_LEN - scsi_get_resid(CURRENT_SC);
+		int done;
+		struct scatterlist *sg = scsi_sglist(CURRENT_SC);
 
-		CMD_INC_RESID(CURRENT_SC, data_count);
+		CMD_INC_RESID(CURRENT_SC, datao_out - datao_cnt);
 
-		data_count -= CURRENT_SC->SCp.ptr -
-			SG_ADDRESS(CURRENT_SC->SCp.buffer);
-		while(data_count>0) {
-			CURRENT_SC->SCp.buffer--;
-			CURRENT_SC->SCp.buffers_residual++;
-			data_count -= CURRENT_SC->SCp.buffer->length;
+		done = scsi_bufflen(CURRENT_SC) - scsi_get_resid(CURRENT_SC);
+		/* Locate the first SG entry not yet sent */
+		while (done > 0 && !sg_is_last(sg)) {
+			if (done < sg->length)
+				break;
+			done -= sg->length;
+			sg = sg_next(sg);
 		}
-		CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) -
-			data_count;
-		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length +
-			data_count;
+
+		CURRENT_SC->SCp.buffer = sg;
+		CURRENT_SC->SCp.ptr = SG_ADDRESS(CURRENT_SC->SCp.buffer) + done;
+		CURRENT_SC->SCp.this_residual = CURRENT_SC->SCp.buffer->length -
+			done;
 	}
 
 	SETPORT(SXFRCTL0, CH1|CLRCH1|CLRSTCNT);
@@ -2501,7 +2501,7 @@ static void get_command(struct seq_file *m, struct scsi_cmnd * ptr)
 
 	seq_printf(m, "); resid=%d; residual=%d; buffers=%d; phase |",
 		scsi_get_resid(ptr), ptr->SCp.this_residual,
-		ptr->SCp.buffers_residual);
+		sg_nents(ptr->SCp.buffer) - 1);
 
 	if (ptr->SCp.phase & not_issued)
 		seq_puts(m, "not issued|");
-- 
2.20.1

