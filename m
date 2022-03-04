Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8E4CD87B
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Mar 2022 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbiCDQEo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Mar 2022 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiCDQEm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Mar 2022 11:04:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428A1B018C;
        Fri,  4 Mar 2022 08:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CQUvlsmrvEOvao7gpxSccrPKDKA68ZFzfzs9XLF0OFM=; b=kJD0e1KH2Wq8Kt5F0hhF4AtgYP
        /Z4ff3fkEhm2R3zMeMwz8d0iUTRtxWN5MWieqthAUMsprw0MUeGEjU7zothpUCTwnwKHOYiefKDvg
        VjMbPAHhZSuZ5uzXMfgQJrJBgEgj/z8hIXuvjVuQz5b/azqJCWxHXdgYwBxlsNteRoo/Wwqyakssx
        T5tOPvFZmfwb+Cevy6RhDeBfuOpK1hyRW370BUGBfO2dOBYsbj9uctiGDtNk5lMHQwW/YT4R6Rxxx
        vov8ttbl5p949tXk5EOFYEWdGKP+yYncWg7DNUmbr6ZsjTN9+eGFNKIMcls3XwAumx5DqivVjcReE
        A+t3T9bQ==;
Received: from [2001:4bb8:180:5296:7360:567:acd5:aaa2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAPF-00Au0b-Fl; Fri, 04 Mar 2022 16:03:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 05/14] sd: call sd_zbc_release_disk before releasing the scsi_device reference
Date:   Fri,  4 Mar 2022 17:03:22 +0100
Message-Id: <20220304160331.399757-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304160331.399757-1-hch@lst.de>
References: <20220304160331.399757-1-hch@lst.de>
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

