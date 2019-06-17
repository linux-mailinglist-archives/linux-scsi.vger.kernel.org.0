Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D023B47864
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 05:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfFQDF7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 16 Jun 2019 23:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfFQDF7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 16 Jun 2019 23:05:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 303092F8BD2;
        Mon, 17 Jun 2019 03:05:59 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E731691731;
        Mon, 17 Jun 2019 03:05:47 +0000 (UTC)
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
Subject: [PATCH V4 08/16] staging: unisys: visorhba: use sg helper to operate scatterlist
Date:   Mon, 17 Jun 2019 11:03:41 +0800
Message-Id: <20190617030349.26415-9-ming.lei@redhat.com>
In-Reply-To: <20190617030349.26415-1-ming.lei@redhat.com>
References: <20190617030349.26415-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 17 Jun 2019 03:05:59 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use the scatterlist iterators and remove direct indexing of the
scatterlist array.

This way allows us to pre-allocate one small scatterlist, which can be
chained with one runtime allocated scatterlist if the pre-allocated one
isn't enough for the whole request.

Cc: devel@driverdev.osuosl.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/staging/unisys/visorhba/visorhba_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 2dad36a05518..dd979ee4dcf1 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -871,12 +871,11 @@ static void do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp,
 			return;
 		}
 
-		sg = scsi_sglist(scsicmd);
-		for (i = 0; i < scsi_sg_count(scsicmd); i++) {
-			this_page_orig = kmap_atomic(sg_page(sg + i));
+		scsi_for_each_sg(scsicmd, sg, scsi_sg_count(scsicmd), i) {
+			this_page_orig = kmap_atomic(sg_page(sg));
 			this_page = (void *)((unsigned long)this_page_orig |
-					     sg[i].offset);
-			memcpy(this_page, buf + bufind, sg[i].length);
+					     sg->offset);
+			memcpy(this_page, buf + bufind, sg->length);
 			kunmap_atomic(this_page_orig);
 		}
 		kfree(buf);
-- 
2.20.1

