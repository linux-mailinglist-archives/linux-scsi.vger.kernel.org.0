Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8ABE496DD
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 03:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFRBiu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 21:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfFRBit (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 17 Jun 2019 21:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2693A3082208;
        Tue, 18 Jun 2019 01:38:49 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42B2710027B7;
        Tue, 18 Jun 2019 01:38:45 +0000 (UTC)
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
Subject: [PATCH V5 06/16] scsi: pmcraid: use sg helper to operate scatterlist
Date:   Tue, 18 Jun 2019 09:37:47 +0800
Message-Id: <20190618013757.22401-7-ming.lei@redhat.com>
In-Reply-To: <20190618013757.22401-1-ming.lei@redhat.com>
References: <20190618013757.22401-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 18 Jun 2019 01:38:49 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/pmcraid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e338d7a4f571..286cac59cb5f 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3270,7 +3270,7 @@ static int pmcraid_copy_sglist(
 	int direction
 )
 {
-	struct scatterlist *scatterlist;
+	struct scatterlist *sg;
 	void *kaddr;
 	int bsize_elem;
 	int i;
@@ -3279,10 +3279,10 @@ static int pmcraid_copy_sglist(
 	/* Determine the actual number of bytes per element */
 	bsize_elem = PAGE_SIZE * (1 << sglist->order);
 
-	scatterlist = sglist->scatterlist;
+	sg = sglist->scatterlist;
 
-	for (i = 0; i < (len / bsize_elem); i++, buffer += bsize_elem) {
-		struct page *page = sg_page(&scatterlist[i]);
+	for (i = 0; i < (len / bsize_elem); i++, sg = sg_next(sg), buffer += bsize_elem) {
+		struct page *page = sg_page(sg);
 
 		kaddr = kmap(page);
 		if (direction == DMA_TO_DEVICE)
@@ -3297,11 +3297,11 @@ static int pmcraid_copy_sglist(
 			return -EFAULT;
 		}
 
-		scatterlist[i].length = bsize_elem;
+		sg->length = bsize_elem;
 	}
 
 	if (len % bsize_elem) {
-		struct page *page = sg_page(&scatterlist[i]);
+		struct page *page = sg_page(sg);
 
 		kaddr = kmap(page);
 
@@ -3312,7 +3312,7 @@ static int pmcraid_copy_sglist(
 
 		kunmap(page);
 
-		scatterlist[i].length = len % bsize_elem;
+		sg->length = len % bsize_elem;
 	}
 
 	if (rc) {
-- 
2.20.1

