Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF64D9261
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Mar 2022 02:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbiCOB7f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Mar 2022 21:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbiCOB7e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Mar 2022 21:59:34 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 18:58:23 PDT
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5E1263F
        for <linux-scsi@vger.kernel.org>; Mon, 14 Mar 2022 18:58:23 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 15 Mar
 2022 09:57:16 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 15 Mar
 2022 09:57:15 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] scsi: bfa: remove redundant NULL check
Date:   Tue, 15 Mar 2022 09:57:14 +0800
Message-ID: <1647309434-13936-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix below warnings reported by coccicheck:
drivers/scsi/bfa/bfad_debugfs.c:375:2-7: WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/scsi/bfa/bfad_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index fd1b378..52db147 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -371,8 +371,7 @@ bfad_debugfs_release_fwtrc(struct inode *inode, struct file *file)
 	if (!fw_debug)
 		return 0;
 
-	if (fw_debug->debug_buffer)
-		vfree(fw_debug->debug_buffer);
+	vfree(fw_debug->debug_buffer);
 
 	file->private_data = NULL;
 	kfree(fw_debug);
-- 
2.7.4

