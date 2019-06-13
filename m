Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB744477
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfFMQhX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 12:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfFMHO7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jun 2019 03:14:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CE9530C1320;
        Thu, 13 Jun 2019 07:14:59 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CFF11001B3C;
        Thu, 13 Jun 2019 07:14:56 +0000 (UTC)
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
Subject: [PATCH V2 12/15] scsi: pcmcia: nsp_cs: use sg helper to operate sgl
Date:   Thu, 13 Jun 2019 15:13:32 +0800
Message-Id: <20190613071335.5679-13-ming.lei@redhat.com>
In-Reply-To: <20190613071335.5679-1-ming.lei@redhat.com>
References: <20190613071335.5679-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 13 Jun 2019 07:14:59 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The current way isn't safe for chained sgl, so use sg helper to
operate sgl.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/pcmcia/nsp_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index a81748e6e8fb..97416e1dcc5b 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -789,7 +789,7 @@ static void nsp_pio_read(struct scsi_cmnd *SCpnt)
 		    SCpnt->SCp.buffers_residual != 0 ) {
 			//nsp_dbg(NSP_DEBUG_DATA_IO, "scatterlist next timeout=%d", time_out);
 			SCpnt->SCp.buffers_residual--;
-			SCpnt->SCp.buffer++;
+			SCpnt->SCp.buffer = sg_next(SCpnt->SCp.buffer);
 			SCpnt->SCp.ptr		 = BUFFER_ADDR;
 			SCpnt->SCp.this_residual = SCpnt->SCp.buffer->length;
 			time_out = 1000;
@@ -887,7 +887,7 @@ static void nsp_pio_write(struct scsi_cmnd *SCpnt)
 		    SCpnt->SCp.buffers_residual != 0 ) {
 			//nsp_dbg(NSP_DEBUG_DATA_IO, "scatterlist next");
 			SCpnt->SCp.buffers_residual--;
-			SCpnt->SCp.buffer++;
+			SCpnt->SCp.buffer = sg_next(SCpnt->SCp.buffer);
 			SCpnt->SCp.ptr		 = BUFFER_ADDR;
 			SCpnt->SCp.this_residual = SCpnt->SCp.buffer->length;
 			time_out = 1000;
-- 
2.20.1

