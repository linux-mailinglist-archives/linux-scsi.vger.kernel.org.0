Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19B35B8C9
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Apr 2021 05:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhDLDDv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Apr 2021 23:03:51 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59805 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235857AbhDLDDv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 11 Apr 2021 23:03:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UVCfw3p_1618196607;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVCfw3p_1618196607)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Apr 2021 11:03:32 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     aradford@gmail.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: 3w-9xxx: remove useless variable
Date:   Mon, 12 Apr 2021 11:03:24 +0800
Message-Id: <1618196604-101870-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following gcc warning:

drivers/scsi/3w-9xxx.c:942:24: warning: variable ‘response_que_value’
set but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/3w-9xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index b96e82d..1856a99 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -939,13 +939,13 @@ static int twa_decode_bits(TW_Device_Extension *tw_dev, u32 status_reg_value)
 /* This function will empty the response queue */
 static int twa_empty_response_queue(TW_Device_Extension *tw_dev)
 {
-	u32 status_reg_value, response_que_value;
+	u32 status_reg_value;
 	int count = 0, retval = 1;
 
 	status_reg_value = readl(TW_STATUS_REG_ADDR(tw_dev));
 
 	while (((status_reg_value & TW_STATUS_RESPONSE_QUEUE_EMPTY) == 0) && (count < TW_MAX_RESPONSE_DRAIN)) {
-		response_que_value = readl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
+		readl(TW_RESPONSE_QUEUE_REG_ADDR(tw_dev));
 		status_reg_value = readl(TW_STATUS_REG_ADDR(tw_dev));
 		count++;
 	}
-- 
1.8.3.1

