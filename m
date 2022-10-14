Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9195FEDC3
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Oct 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJNMCM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Oct 2022 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJNMCJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Oct 2022 08:02:09 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACEE18F26D;
        Fri, 14 Oct 2022 05:02:05 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5E4E841223;
        Fri, 14 Oct 2022 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received:received; s=
        mta-01; t=1665748922; x=1667563323; bh=vvj0DKabEFwvHkKOGLh1yeT/k
        zHZ5GPfeIsn6eWZCj8=; b=BL19+ibCk9HmcLYeYuI4qTp945Uj5zAonQAnymuLP
        mIDX9IA3CvCI4wj/P15FjIlRAsQV4hnngHP7zXN3aPcAUOy0Ec2+N5mVlYLCP9iC
        vguwOJwegHTYHb4sw+FOBrr3H3d8BZOOrVGCK7Ia0YUj+DPaES4+2B5AnXpk8HYQ
        Ao=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uDyHMCGwDGgy; Fri, 14 Oct 2022 15:02:02 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (T-EXCH-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id BAC9E41221;
        Fri, 14 Oct 2022 15:01:03 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 14 Oct 2022 15:01:03 +0300
Received: from localhost (10.199.23.220) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Fri, 14 Oct
 2022 15:01:03 +0300
From:   Anastasia Kovaleva <a.kovaleva@yadro.com>
To:     <target-devel@vger.kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux@yadro.com>
Subject: [PATCH v2 2/3] target: core: make hw_max_sectors store the sectors amount in blocks
Date:   Fri, 14 Oct 2022 15:00:55 +0300
Message-ID: <20221014120056.33738-3-a.kovaleva@yadro.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221014120056.33738-1-a.kovaleva@yadro.com>
References: <20221014120056.33738-1-a.kovaleva@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.23.220]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

By default, hw_max_sectors stores its value in 512 blocks in iblock,
despite the fact that the block size can be 4096 bytes. Change
hw_max_sectors to store the number of sectors in hw_block_size blocks.

Signed-off-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
---
 drivers/target/target_core_iblock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 8351c974cee3..2a704926edb9 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -124,7 +124,9 @@ static int iblock_configure_device(struct se_device *dev)
 	q = bdev_get_queue(bd);
 
 	dev->dev_attrib.hw_block_size = bdev_logical_block_size(bd);
-	dev->dev_attrib.hw_max_sectors = queue_max_hw_sectors(q);
+	dev->dev_attrib.hw_max_sectors = mult_frac(queue_max_hw_sectors(q),
+			SECTOR_SIZE,
+			dev->dev_attrib.hw_block_size);
 	dev->dev_attrib.hw_queue_depth = q->nr_requests;
 
 	/*
-- 
2.30.2

