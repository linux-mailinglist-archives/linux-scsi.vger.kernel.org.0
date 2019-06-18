Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B503496E1
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 03:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFRBjB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 21:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFRBjB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 21:39:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C99D93086205;
        Tue, 18 Jun 2019 01:38:55 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C286C7DF63;
        Tue, 18 Jun 2019 01:38:51 +0000 (UTC)
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
        Ming Lei <ming.lei@redhat.com>,
        Oliver Neukum <oliver@neukum.org>
Subject: [PATCH V5 07/16] usb: image: microtek: use sg helper to operate scatterlist
Date:   Tue, 18 Jun 2019 09:37:48 +0800
Message-Id: <20190618013757.22401-8-ming.lei@redhat.com>
In-Reply-To: <20190618013757.22401-1-ming.lei@redhat.com>
References: <20190618013757.22401-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 18 Jun 2019 01:39:01 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/usb/image/microtek.c | 20 ++++++++------------
 drivers/usb/image/microtek.h |  2 +-
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
index 607be1f4fe27..0a57c2cc8e5a 100644
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -488,7 +488,6 @@ static void mts_command_done( struct urb *transfer )
 
 static void mts_do_sg (struct urb* transfer)
 {
-	struct scatterlist * sg;
 	int status = transfer->status;
 	MTS_INT_INIT();
 
@@ -500,13 +499,12 @@ static void mts_do_sg (struct urb* transfer)
 		mts_transfer_cleanup(transfer);
         }
 
-	sg = scsi_sglist(context->srb);
-	context->fragment++;
+	context->curr_sg = sg_next(context->curr_sg);
 	mts_int_submit_urb(transfer,
 			   context->data_pipe,
-			   sg_virt(&sg[context->fragment]),
-			   sg[context->fragment].length,
-			   context->fragment + 1 == scsi_sg_count(context->srb) ?
+			   sg_virt(context->curr_sg),
+			   context->curr_sg->length,
+			   sg_is_last(context->curr_sg) ?
 			   mts_data_done : mts_do_sg);
 }
 
@@ -526,22 +524,20 @@ static void
 mts_build_transfer_context(struct scsi_cmnd *srb, struct mts_desc* desc)
 {
 	int pipe;
-	struct scatterlist * sg;
-	
+
 	MTS_DEBUG_GOT_HERE();
 
 	desc->context.instance = desc;
 	desc->context.srb = srb;
-	desc->context.fragment = 0;
 
 	if (!scsi_bufflen(srb)) {
 		desc->context.data = NULL;
 		desc->context.data_length = 0;
 		return;
 	} else {
-		sg = scsi_sglist(srb);
-		desc->context.data = sg_virt(&sg[0]);
-		desc->context.data_length = sg[0].length;
+		desc->context.curr_sg = scsi_sglist(srb);
+		desc->context.data = sg_virt(desc->context.curr_sg);
+		desc->context.data_length = desc->context.curr_sg->length;
 	}
 
 
diff --git a/drivers/usb/image/microtek.h b/drivers/usb/image/microtek.h
index 66685e59241a..7bd5f4639c4a 100644
--- a/drivers/usb/image/microtek.h
+++ b/drivers/usb/image/microtek.h
@@ -21,7 +21,7 @@ struct mts_transfer_context
 	void *data;
 	unsigned data_length;
 	int data_pipe;
-	int fragment;
+	struct scatterlist *curr_sg;
 
 	u8 *scsi_status; /* status returned from ep_response after command completion */
 };
-- 
2.20.1

