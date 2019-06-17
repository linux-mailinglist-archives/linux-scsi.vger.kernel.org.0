Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE194786A
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfFQDG0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:06:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfFQDG0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 23:06:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E031E307D859;
        Mon, 17 Jun 2019 03:06:25 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19CAA5884C;
        Mon, 17 Jun 2019 03:06:09 +0000 (UTC)
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
Subject: [PATCH V4 09/16] staging: rtsx: use sg helper to operate scatterlist
Date:   Mon, 17 Jun 2019 11:03:42 +0800
Message-Id: <20190617030349.26415-10-ming.lei@redhat.com>
In-Reply-To: <20190617030349.26415-1-ming.lei@redhat.com>
References: <20190617030349.26415-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 17 Jun 2019 03:06:26 +0000 (UTC)
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
 drivers/staging/rts5208/rtsx_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d7895608..407c9079b052 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -63,6 +63,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 		struct scatterlist *sg =
 				(struct scatterlist *)scsi_sglist(srb)
 				+ *index;
+		if (sg_is_chain(sg))
+			sg = sg_chain_ptr(sg);
 
 		/*
 		 * This loop handles a single s-g list entry, which may
@@ -86,7 +88,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 				/* Transfer continues to next s-g entry */
 				*offset = 0;
 				++*index;
-				++sg;
+				sg = sg_next(sg);
 			}
 
 			while (sglen > 0) {
-- 
2.20.1

