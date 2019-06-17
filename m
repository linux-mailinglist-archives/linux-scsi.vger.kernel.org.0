Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F264787B
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfFQDH6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfFQDH6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 23:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E243C7FDCC;
        Mon, 17 Jun 2019 03:07:57 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91DD99F2E8;
        Mon, 17 Jun 2019 03:07:51 +0000 (UTC)
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
Subject: [PATCH V4 13/16] scsi: pcmcia: nsp_cs: use sg helper to operate scatterlist
Date:   Mon, 17 Jun 2019 11:03:46 +0800
Message-Id: <20190617030349.26415-14-ming.lei@redhat.com>
In-Reply-To: <20190617030349.26415-1-ming.lei@redhat.com>
References: <20190617030349.26415-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Jun 2019 03:07:58 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

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

