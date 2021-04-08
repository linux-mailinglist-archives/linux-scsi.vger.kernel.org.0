Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10A357EB1
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Apr 2021 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhDHJHB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Apr 2021 05:07:01 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:43842 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhDHJHA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Apr 2021 05:07:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UUspZKb_1617872787;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UUspZKb_1617872787)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Apr 2021 17:06:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: message: fusion: Remove useless variable
Date:   Thu,  8 Apr 2021 17:06:20 +0800
Message-Id: <1617872780-126448-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following gcc warning:

drivers/message/fusion/mptbase.c:3087:9: warning: variable ‘status’ set
but not used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/message/fusion/mptbase.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 549797d..f37ea06 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -3084,7 +3084,7 @@ static int mpt_remove_dead_ioc_func(void *arg)
 	int			 req_sz;
 	int			 reply_sz;
 	int			 sz;
-	u32			 status, vv;
+	u32			 vv;
 	u8			 shiftFactor=1;
 
 	/* IOC *must* NOT be in RESET state! */
@@ -3142,7 +3142,6 @@ static int mpt_remove_dead_ioc_func(void *arg)
 		facts->IOCExceptions = le16_to_cpu(facts->IOCExceptions);
 		facts->IOCStatus = le16_to_cpu(facts->IOCStatus);
 		facts->IOCLogInfo = le32_to_cpu(facts->IOCLogInfo);
-		status = le16_to_cpu(facts->IOCStatus) & MPI_IOCSTATUS_MASK;
 		/* CHECKME! IOCStatus, IOCLogInfo */
 
 		facts->ReplyQueueDepth = le16_to_cpu(facts->ReplyQueueDepth);
-- 
1.8.3.1

