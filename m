Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADF44473
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfFMQhW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbfFMHPM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:15:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5801B30C0DFE;
        Thu, 13 Jun 2019 07:15:12 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94B8C1001E60;
        Thu, 13 Jun 2019 07:15:11 +0000 (UTC)
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
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH V2 15/15] NCR5380: Support chained sg lists
Date:   Thu, 13 Jun 2019 15:13:35 +0800
Message-Id: <20190613071335.5679-16-ming.lei@redhat.com>
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Jun 2019 07:15:12 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

My understanding is that support for chained scatterlists is to
become mandatory for LLDs.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/NCR5380.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index fe0535affc14..4ef44fafe6ca 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -149,12 +149,10 @@ static inline void initialize_SCp(struct scsi_cmnd *cmd)
 
 	if (scsi_bufflen(cmd)) {
 		cmd->SCp.buffer = scsi_sglist(cmd);
-		cmd->SCp.buffers_residual = scsi_sg_count(cmd) - 1;
 		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
 		cmd->SCp.this_residual = cmd->SCp.buffer->length;
 	} else {
 		cmd->SCp.buffer = NULL;
-		cmd->SCp.buffers_residual = 0;
 		cmd->SCp.ptr = NULL;
 		cmd->SCp.this_residual = 0;
 	}
@@ -163,6 +161,17 @@ static inline void initialize_SCp(struct scsi_cmnd *cmd)
 	cmd->SCp.Message = 0;
 }
 
+static inline void advance_sg_buffer(struct scsi_cmnd *cmd)
+{
+	struct scatterlist *s = cmd->SCp.buffer;
+
+	if (!cmd->SCp.this_residual && s && !sg_is_last(s)) {
+		cmd->SCp.buffer = sg_next(s);
+		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
+		cmd->SCp.this_residual = cmd->SCp.buffer->length;
+	}
+}
+
 /**
  * NCR5380_poll_politely2 - wait for two chip register values
  * @hostdata: host private data
@@ -1672,12 +1681,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 			    sun3_dma_setup_done != cmd) {
 				int count;
 
-				if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
-					++cmd->SCp.buffer;
-					--cmd->SCp.buffers_residual;
-					cmd->SCp.this_residual = cmd->SCp.buffer->length;
-					cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
-				}
+				advance_sg_buffer(cmd);
 
 				count = sun3scsi_dma_xfer_len(hostdata, cmd);
 
@@ -1727,15 +1731,11 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				 * scatter-gather list, move onto the next one.
 				 */
 
-				if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
-					++cmd->SCp.buffer;
-					--cmd->SCp.buffers_residual;
-					cmd->SCp.this_residual = cmd->SCp.buffer->length;
-					cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
-					dsprintk(NDEBUG_INFORMATION, instance, "%d bytes and %d buffers left\n",
-					         cmd->SCp.this_residual,
-					         cmd->SCp.buffers_residual);
-				}
+				advance_sg_buffer(cmd);
+				dsprintk(NDEBUG_INFORMATION, instance,
+					"this residual %d, sg ents %d\n",
+					cmd->SCp.this_residual,
+					sg_nents(cmd->SCp.buffer));
 
 				/*
 				 * The preferred transfer method is going to be
@@ -2136,12 +2136,7 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 	if (sun3_dma_setup_done != tmp) {
 		int count;
 
-		if (!tmp->SCp.this_residual && tmp->SCp.buffers_residual) {
-			++tmp->SCp.buffer;
-			--tmp->SCp.buffers_residual;
-			tmp->SCp.this_residual = tmp->SCp.buffer->length;
-			tmp->SCp.ptr = sg_virt(tmp->SCp.buffer);
-		}
+		advance_sg_buffer(tmp);
 
 		count = sun3scsi_dma_xfer_len(hostdata, tmp);
 
-- 
2.20.1

