Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF1378340
	for <lists+linux-scsi@lfdr.de>; Mon, 10 May 2021 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhEJKnh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 May 2021 06:43:37 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:56878 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231684AbhEJKlj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 May 2021 06:41:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UYNGRwz_1620643207;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UYNGRwz_1620643207)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 May 2021 18:40:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: qla2xxx: Remove redundant assignment to rval
Date:   Mon, 10 May 2021 18:40:06 +0800
Message-Id: <1620643206-127930-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Variable rval is set to QLA_SUCCESS, but this value is never read as
it is overwritten later on, hence it is a redundant assignment and
can be removed.

Clean up the following clang-analyzer warning:

drivers/scsi/qla2xxx/qla_init.c:4359:2: warning: Value stored to 'rval'
is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 0de2505..eb82531 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4356,8 +4356,6 @@ void qla_init_iocb_limit(scsi_qla_host_t *vha)
 	if (IS_QLAFX00(vha->hw))
 		return qlafx00_fw_ready(vha);
 
-	rval = QLA_SUCCESS;
-
 	/* Time to wait for loop down */
 	if (IS_P3P_TYPE(ha))
 		min_wait = 30;
-- 
1.8.3.1

