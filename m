Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7049830D10C
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Feb 2021 02:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBCBuk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Feb 2021 20:50:40 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38016 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230369AbhBCBuj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Feb 2021 20:50:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNiznmg_1612316993;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNiznmg_1612316993)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 09:49:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bootc@bootc.net
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: target: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 09:49:52 +0800
Message-Id: <1612316992-71443-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/target/sbp/sbp_target.c:1009:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/target/sbp/sbp_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/sbp/sbp_target.c b/drivers/target/sbp/sbp_target.c
index e4a9b9f..2a6165f 100644
--- a/drivers/target/sbp/sbp_target.c
+++ b/drivers/target/sbp/sbp_target.c
@@ -1006,7 +1006,7 @@ static void tgt_agent_fetch_work(struct work_struct *work)
 			agent->state = AGENT_STATE_SUSPENDED;
 
 		spin_unlock_bh(&agent->lock);
-	};
+	}
 }
 
 static struct sbp_target_agent *sbp_target_agent_register(
-- 
1.8.3.1

