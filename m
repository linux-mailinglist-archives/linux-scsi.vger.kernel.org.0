Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60154300307
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Jan 2021 13:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhAVJ04 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Jan 2021 04:26:56 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43305 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbhAVJNH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 Jan 2021 04:13:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UMW2KyW_1611306614;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMW2KyW_1611306614)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jan 2021 17:10:48 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, anil.gurumurthy@qlogic.com,
        sudarsana.kalluru@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] scsi: bfa: remove redundant NULL check
Date:   Fri, 22 Jan 2021 17:10:12 +0800
Message-Id: <1611306612-98486-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/scsi/bfa/bfad_debugfs.c:375:2-7: WARNING: NULL check before
some freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/scsi/bfa/bfad_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index fd1b378..52db147 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -371,8 +371,7 @@ struct bfad_debug_info {
 	if (!fw_debug)
 		return 0;
 
-	if (fw_debug->debug_buffer)
-		vfree(fw_debug->debug_buffer);
+	vfree(fw_debug->debug_buffer);
 
 	file->private_data = NULL;
 	kfree(fw_debug);
-- 
1.8.3.1

