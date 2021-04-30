Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE136F7CA
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Apr 2021 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhD3JZI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Apr 2021 05:25:08 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37368 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231646AbhD3JZB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 30 Apr 2021 05:25:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UXFS4v5_1619774628;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UXFS4v5_1619774628)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Apr 2021 17:24:11 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: target: configfs: Remove redundant assignment to ret
Date:   Fri, 30 Apr 2021 17:23:47 +0800
Message-Id: <1619774627-118766-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Variable ret is set to '-EINVAL' but this value is never read as it is
overwritten later on, hence it is a redundant assignment and can be
removed.

Clean up the following clang-analyzer warning:

drivers/target/target_core_configfs.c:2037:5: warning: Value stored to
'ret' is never read [clang-analyzer-deadcode.DeadStores].

drivers/target/target_core_configfs.c:1973:5: warning: Value stored to
'ret' is never read [clang-analyzer-deadcode.DeadStores].

drivers/target/target_core_configfs.c:1959:5: warning: Value stored to
'ret' is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/target/target_core_configfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 4b2e493..bda05c3 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1956,7 +1956,6 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 				pr_err("APTPL metadata initiator_node="
 					" exceeds PR_APTPL_MAX_IPORT_LEN: %d\n",
 					PR_APTPL_MAX_IPORT_LEN);
-				ret = -EINVAL;
 				break;
 			}
 			break;
@@ -1970,7 +1969,6 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 				pr_err("APTPL metadata initiator_isid"
 					"= exceeds PR_REG_ISID_LEN: %d\n",
 					PR_REG_ISID_LEN);
-				ret = -EINVAL;
 				break;
 			}
 			break;
@@ -2034,7 +2032,6 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 				pr_err("APTPL metadata target_node="
 					" exceeds PR_APTPL_MAX_TPORT_LEN: %d\n",
 					PR_APTPL_MAX_TPORT_LEN);
-				ret = -EINVAL;
 				break;
 			}
 			break;
-- 
1.8.3.1

