Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B2F47E1C
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 11:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfFQJPu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 05:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbfFQJPu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 05:15:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A733E3024552;
        Mon, 17 Jun 2019 09:15:49 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8515E7DF5D;
        Mon, 17 Jun 2019 09:15:31 +0000 (UTC)
Date:   Mon, 17 Jun 2019 17:15:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, Jim Gill <jgill@vmware.com>,
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
        Kim Bradley <kim.jamie.bradley@gmail.com>
Subject: Re: [PATCH V4 09/16] staging: rtsx: use sg helper to operate
 scatterlist
Message-ID: <20190617091524.GB31002@ming.t460p>
References: <20190617030349.26415-1-ming.lei@redhat.com>
 <20190617030349.26415-10-ming.lei@redhat.com>
 <20190617082706.GI7455@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082706.GI7455@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 17 Jun 2019 09:15:49 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 17, 2019 at 10:27:06AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 17, 2019 at 11:03:42AM +0800, Ming Lei wrote:
> > Use the scatterlist iterators and remove direct indexing of the
> > scatterlist array.
> > 
> > This way allows us to pre-allocate one small scatterlist, which can be
> > chained with one runtime allocated scatterlist if the pre-allocated one
> > isn't enough for the whole request.
> 
> The scatterlist handling here looks completely bogus, it really
> needs to stop using the index and switch to proper sg_next-based
> iteration.

Yeah, I agree, looks we may convert in the following way by
storing current 'sg', and the 'offset' already stores the actual offset
on the current 'sg'.

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d7895608..861b4cc4562e 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -32,7 +32,7 @@
 unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 				       unsigned int buflen,
 				       struct scsi_cmnd *srb,
-				       unsigned int *index,
+				       struct scatterlist **cur_sg,
 				       unsigned int *offset,
 				       enum xfer_buf_dir dir)
 {
@@ -60,18 +60,18 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 * each page has to be kmap()'ed separately.
 	 */
 	} else {
-		struct scatterlist *sg =
-				(struct scatterlist *)scsi_sglist(srb)
-				+ *index;
+		struct scatterlist *sg = *cur_sg ?:
+				(struct scatterlist *)scsi_sglist(srb);
+
 
 		/*
 		 * This loop handles a single s-g list entry, which may
 		 * include multiple pages.  Find the initial page structure
 		 * and the starting offset within the page, and update
-		 * the *offset and *index values for the next loop.
+		 * the *offset values for the next loop.
 		 */
 		cnt = 0;
-		while (cnt < buflen && *index < scsi_sg_count(srb)) {
+		while (cnt < buflen && sg) {
 			struct page *page = sg_page(sg) +
 					((sg->offset + *offset) >> PAGE_SHIFT);
 			unsigned int poff = (sg->offset + *offset) &
@@ -85,8 +85,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			} else {
 				/* Transfer continues to next s-g entry */
 				*offset = 0;
-				++*index;
-				++sg;
+				sg = sg_next(sg);
 			}
 
 			while (sglen > 0) {
@@ -120,9 +119,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 			    unsigned int buflen, struct scsi_cmnd *srb)
 {
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = NULL;
 
-	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &index, &offset,
+	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &sg, &offset,
 				  TO_XFER_BUF);
 	if (buflen < scsi_bufflen(srb))
 		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
@@ -131,9 +131,10 @@ void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 void rtsx_stor_get_xfer_buf(unsigned char *buffer,
 			    unsigned int buflen, struct scsi_cmnd *srb)
 {
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = NULL;
 
-	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &index, &offset,
+	rtsx_stor_access_xfer_buf(buffer, buflen, srb, &sg, &offset,
 				  FROM_XFER_BUF);
 	if (buflen < scsi_bufflen(srb))
 		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index f1e9e80044ed..6ad4278de531 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -554,7 +554,8 @@ int spi_read_flash_id(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 int spi_read_flash(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 {
 	int retval;
-	unsigned int index = 0, offset = 0;
+	unsigned int offset = 0;
+	struct scatterlist *sg = NULL;
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
+	struct scatterlist *sg = NULL;
 
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

Thanks,
Ming
