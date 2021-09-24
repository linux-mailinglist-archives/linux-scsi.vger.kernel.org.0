Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAF416F95
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Sep 2021 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245423AbhIXJxm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Sep 2021 05:53:42 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58243 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245310AbhIXJxm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Sep 2021 05:53:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UpPvmra_1632477120;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UpPvmra_1632477120)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Sep 2021 17:52:07 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: ses: Fix unsigned comparison with less than zero
Date:   Fri, 24 Sep 2021 17:51:53 +0800
Message-Id: <1632477113-90378-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

./drivers/scsi/ses.c:137:10-16: WARNING: Unsigned expression compared
with zero: result > 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/ses.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 43e6822..0a1734f 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -118,7 +118,7 @@ static int ses_recv_diag(struct scsi_device *sdev, int page_code,
 static int ses_send_diag(struct scsi_device *sdev, int page_code,
 			 void *buf, int bufflen)
 {
-	u32 result;
+	int result;
 
 	unsigned char cmd[] = {
 		SEND_DIAGNOSTIC,
-- 
1.8.3.1

