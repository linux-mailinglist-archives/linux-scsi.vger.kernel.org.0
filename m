Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6294C777
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 08:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFTG03 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 02:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFTG03 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Jun 2019 02:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09722307D910;
        Thu, 20 Jun 2019 06:26:29 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13F3A608A5;
        Thu, 20 Jun 2019 06:26:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH] scsi: mvumi: fix build warning
Date:   Thu, 20 Jun 2019 14:26:22 +0800
Message-Id: <20190620062622.9979-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 20 Jun 2019 06:26:29 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The local variable 'sg' should be initialized in the failure path of
mvumi_make_sgl(), otherwise the following build warning is triggered:

	In file included from include/linux/pci-dma-compat.h:8,
	                 from include/linux/pci.h:2408,
	                 from drivers/scsi/mvumi.c:13:
	drivers/scsi/mvumi.c: In function 'mvumi_queue_command':
	include/linux/dma-mapping.h:608:34: warning: 'sg' may be used uninitialized in this function
	+[-Wmaybe-uninitialized]
	 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
	                                  ^~~~~~~~~~~~~~~~~~
	drivers/scsi/mvumi.c:192:22: note: 'sg' was declared here
	  struct scatterlist *sg;
                      ^~
Fixed it by removing the local variable reference in failure path.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Fixes: 350d66a72adc ("scsi: mvumi: use sg helper to iterate over scatterlist")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/mvumi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 0022cd31500a..53f3563aca22 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -217,7 +217,7 @@ static int mvumi_make_sgl(struct mvumi_hba *mhba, struct scsi_cmnd *scmd,
 		dev_err(&mhba->pdev->dev,
 			"sg count[0x%x] is bigger than max sg[0x%x].\n",
 			*sg_count, mhba->max_sge);
-		dma_unmap_sg(&mhba->pdev->dev, sg, sgnum,
+		dma_unmap_sg(&mhba->pdev->dev, scsi_sglist(scmd), sgnum,
 			     scmd->sc_data_direction);
 		return -1;
 	}
-- 
2.20.1

