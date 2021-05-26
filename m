Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7215F391537
	for <lists+linux-scsi@lfdr.de>; Wed, 26 May 2021 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhEZKo1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 May 2021 06:44:27 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40420 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234034AbhEZKoX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 May 2021 06:44:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ua9vjBJ_1622025767;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ua9vjBJ_1622025767)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 18:42:50 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kxie@chelsio.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: cxgbi: cxgb3: Fix inconsistent indenting
Date:   Wed, 26 May 2021 18:42:43 +0800
Message-Id: <1622025763-56413-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eliminate the follow smatch warning:

drivers/scsi/cxgbi/cxgb3i/cxgb3i.c:402 push_tx_frames() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index 203f938..0fb42a4 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -395,10 +395,11 @@ static int push_tx_frames(struct cxgbi_sock *csk, int req_completion)
 	struct sk_buff *skb;
 
 	if (unlikely(csk->state < CTP_ESTABLISHED ||
-		csk->state == CTP_CLOSE_WAIT_1 || csk->state >= CTP_ABORTING)) {
-			log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_PDU_TX,
-				"csk 0x%p,%u,0x%lx,%u, in closing state.\n",
-				csk, csk->state, csk->flags, csk->tid);
+		     csk->state == CTP_CLOSE_WAIT_1 ||
+		     csk->state >= CTP_ABORTING)) {
+		log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_PDU_TX,
+			  "csk 0x%p,%u,0x%lx,%u, in closing state.\n",
+			  csk, csk->state, csk->flags, csk->tid);
 		return 0;
 	}
 
-- 
1.8.3.1

