Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389E3496E6
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 03:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfFRBjH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 21:39:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFRBjH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 21:39:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3403309265C;
        Tue, 18 Jun 2019 01:39:06 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A483A3781;
        Tue, 18 Jun 2019 01:39:03 +0000 (UTC)
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
        Kim Bradley <kim.jamie.bradley@gmail.com>
Subject: [PATCH V5 09/16] staging: rtsx: use sg helper to operate scatterlist
Date:   Tue, 18 Jun 2019 09:37:50 +0800
Message-Id: <20190618013757.22401-10-ming.lei@redhat.com>
In-Reply-To: <20190618013757.22401-1-ming.lei@redhat.com>
References: <20190618013757.22401-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 01:39:07 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Cc: Kim Bradley <kim.jamie.bradley@gmail.com>
Cc: devel@driverdev.osuosl.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 32 +++++++++++-------------
 drivers/staging/rts5208/rtsx_transport.h |  2 +-
 drivers/staging/rts5208/spi.c            | 14 ++++++-----
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d7895608..7a9f42ccebec 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -32,7 +32,7 @@
 unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 				       unsigned int buflen,
 				       struct scsi_cmnd *srb,
-				       unsigned int *index,
+				       struct scatterlist **sg,
 				       unsigned int *offset,
 				       enum xfer_buf_dir dir)
 {
@@ -60,23 +60,20 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 * each page has to be kmap()'ed separately.
 	 */
 	} else {
-		struct scatterlist *sg =
-				(struct scatterlist *)scsi_sglist(srb)
-				+ *index;
-
 		/*
 		 * This loop handles a single s-g list entry, which may
 		 * include multiple pages.  Find the initial page structure
 		 * and the starting offset within the page, and update
-		 * the *offset and *index values for the next loop.
+		 * the *offset and current sg for the next loop.
 		 */
 		cnt = 0;
-		while (cnt < buflen && *index < scsi_sg_count(srb)) {
-			struct page *page = sg_page(sg) +
-					((sg->offset + *offset) >> PAGE_SHIFT);
-			unsigned int poff = (sg->offset + *offset) &
+		while (cnt < buflen && *sg) {
+			struct page *page = sg_page(*sg) +
+					(((*sg)->offset + *offset) >>
+					 PAGE_SHIFT);
+			unsigned int poff = ((*sg)->offset + *offset) &
 					    (PAGE_SIZE - 1);
-			unsigned int sglen = sg->length - *offset;
+			unsigned int sglen = (*sg)->length - *offset;
 
 			if (sglen > buflen - cnt) {
 				/* Transfer ends within this s-g entry */
@@ -85,8 +82,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			} else {
 				/* Transfer continues to next s-g entry */
 				*offset = 0;
-				++*index;
-				++sg;
+				*sg = sg_next(*sg);
 			}
 
 			while (sglen > 0) {
@@ -120,9 +116,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 			    unsigned int buflen, struct scsi_cmnd *srb)
 {
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = scsi_sglist(srb);
 
-	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &index, &offset,
+	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &sg, &offset,
 				  TO_XFER_BUF);
 	if (buflen < scsi_bufflen(srb))
 		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
@@ -131,9 +128,10 @@ void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 void rtsx_stor_get_xfer_buf(unsigned char *buffer,
 			    unsigned int buflen, struct scsi_cmnd *srb)
 {
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = scsi_sglist(srb);
 
-	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &index, &offset,
+	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &sg, &offset,
 				  FROM_XFER_BUF);
 	if (buflen < scsi_bufflen(srb))
 		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
diff --git a/drivers/staging/rts5208/rtsx_transport.h b/drivers/staging/rts5208/rtsx_transport.h
index 097efed24b79..e3ebc3759d92 100644
--- a/drivers/staging/rts5208/rtsx_transport.h
+++ b/drivers/staging/rts5208/rtsx_transport.h
@@ -20,7 +20,7 @@
 unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 				       unsigned int buflen,
 				       struct scsi_cmnd *srb,
-				       unsigned int *index,
+				       struct scatterlist **sg,
 				       unsigned int *offset,
 				       enum xfer_buf_dir dir);
 void rtsx_stor_set_xfer_buf(unsigned char *buffer, unsigned int buflen,
diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index f1e9e80044ed..af10916ff00b 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -554,7 +554,8 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 {
 	int retval;
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = scsi_sglist(srb);
 	u8 ins, slow_read;
 	u32 addr;
 	u16 len;
@@ -631,7 +632,7 @@ int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			return STATUS_FAIL;
 		}
 
-		rtsx_stor_access_xfer_buf(buf, pagelen, srb, &index, &offset,
+		rtsx_stor_access_xfer_buf(buf, pagelen, srb, &sg, &offset,
 					  TO_XFER_BUF);
 
 		addr += pagelen;
@@ -651,7 +652,8 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	u32 addr;
 	u16 len;
 	u8 *buf;
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = scsi_sglist(srb);
 
 	spi_set_err_code(chip, SPI_NO_ERR);
 
@@ -679,7 +681,7 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 				return STATUS_FAIL;
 			}
 
-			rtsx_stor_access_xfer_buf(buf, 1, srb, &index, &offset,
+			rtsx_stor_access_xfer_buf(buf, 1, srb, &sg, &offset,
 						  FROM_XFER_BUF);
 
 			rtsx_init_cmd(chip);
@@ -722,7 +724,7 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 			return STATUS_ERROR;
 
 		while (len) {
-			rtsx_stor_access_xfer_buf(buf, 1, srb, &index, &offset,
+			rtsx_stor_access_xfer_buf(buf, 1, srb, &sg, &offset,
 						  FROM_XFER_BUF);
 
 			rtsx_init_cmd(chip);
@@ -788,7 +790,7 @@ int spi_write_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 			rtsx_send_cmd_no_wait(chip);
 
-			rtsx_stor_access_xfer_buf(buf, pagelen, srb, &index,
+			rtsx_stor_access_xfer_buf(buf, pagelen, srb, &sg,
 						  &offset, FROM_XFER_BUF);
 
 			retval = rtsx_transfer_data(chip, 0, buf, pagelen, 0,
-- 
2.20.1

