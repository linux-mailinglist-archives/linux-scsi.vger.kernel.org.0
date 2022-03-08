Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E314D0F87
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 06:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbiCHFxS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 00:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiCHFxP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 00:53:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D9F68;
        Mon,  7 Mar 2022 21:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Kmr8DQV2AQKxHmpsIFQdnpKEXmC5Yomzad1nAgCe54c=; b=ftZhHow4+k1jlEl9lab6mIeaan
        xH6DlZ2uGJ2QUJRF9/0qeliz19bxg8qsK3rMJUvqaH5LoTtesatIR01hKYCNOKyDt/7oGsxnGo3Hj
        PlWMEGlt3tvjoal2WrXj69EPOT+mOZSndj+M+GBYSVBorKiXjp1oKPxn20rj61/WghCyziLn8L9r7
        xOUoWUWbxiW3zKitHH/lGHlYibgyB4HYXjZ/l81u2QmM2jBb+mPaaWPGLsz11h061bt4nUUaFdyjS
        hwjbYT8/CMRCKM79ihSLgG6C+9rPRG2w+rRZmbw2PAM3eJB/ceiJxnegwiM0in0JNjCjSAATWaIwl
        dRCwU8Kg==;
Received: from [2001:4bb8:184:7746:6f50:7a98:3141:c37b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRSla-002imd-UX; Tue, 08 Mar 2022 05:52:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 05/14] sd: call sd_zbc_release_disk before releasing the scsi_device reference
Date:   Tue,  8 Mar 2022 06:51:51 +0100
Message-Id: <20220308055200.735835-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308055200.735835-1-hch@lst.de>
References: <20220308055200.735835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

sd_zbc_release_disk accesses disk->device, so ensure that actually still has
a valid reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 7479e7cb36b43..7bfebf5b2832d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3672,9 +3672,9 @@ static void scsi_disk_release(struct device *dev)
 
 	disk->private_data = NULL;
 	put_disk(disk);
-	put_device(&sdkp->device->sdev_gendev);
 
 	sd_zbc_release_disk(sdkp);
+	put_device(&sdkp->device->sdev_gendev);
 
 	kfree(sdkp);
 }
-- 
2.30.2

