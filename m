Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABA6FC06
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfGVJUx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 05:20:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfGVJUx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 05:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rozEWPkakpWOVwCBsdppdcawJNVVlIw+Eg8lASKNsgg=; b=tpkF1ayflIjh50YVCiIn61zsk
        585NNt4GTav6znbiEh1nk7blBJDc4sIiGh980AUQln3qSyxICFWhCLRT0GbPYuDr6OYKmlMA+MYn4
        YKX1UgcCicQwtRrLctNcdiEyYNDJWADTfK90HK3wQidBEL3ehgl2tjmh7J1mLtWu33buFKJDQLLG2
        ctnqQimtuNqiaNzB7V5E0GCta+pc88Y6jjomsupaMd2evzlP002O4FNs9nH2xkE1q06lb00ItDuKT
        p7y4RNQw3rVvV+bJqbDefPnWuXcS5g8+A7gWxtwwYSCf75AexTWccRKIeIBdDmmnPn3KAvb+jyrGW
        XM4Jvxkpw==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUUs-0002Si-9l; Mon, 22 Jul 2019 09:20:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com
Cc:     bvanassche@acm.org, tom.leiming@gmail.com, dexuan.linux@gmail.com,
        Damien.LeMoal@wdc.com, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: fix the dma_max_mapping_size call
Date:   Mon, 22 Jul 2019 11:20:38 +0200
Message-Id: <20190722092038.17659-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We should only call dma_max_mapping_size for devices that have a DMA
mask set, otherwise we can run into a NULL pointer dereference that
will crash the system.

Also we need to do right shift to get the sectors from the size in
bytes, not a left shift.

Fixes: bdd17bdef7d8 ("scsi: core: take the DMA max mapping size into account")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Reported-by: Ming Lei <tom.leiming@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9381171c2fc0..11e64b50497f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1784,8 +1784,10 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
 	}
 
-	shost->max_sectors = min_t(unsigned int, shost->max_sectors,
-			dma_max_mapping_size(dev) << SECTOR_SHIFT);
+	if (dev->dma_mask) {
+		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
+				dma_max_mapping_size(dev) >> SECTOR_SHIFT);
+	}
 	blk_queue_max_hw_sectors(q, shost->max_sectors);
 	if (shost->unchecked_isa_dma)
 		blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);
-- 
2.20.1

