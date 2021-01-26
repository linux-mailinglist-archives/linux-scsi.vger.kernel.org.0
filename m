Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F073046DF
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Jan 2021 19:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbhAZRTV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Jan 2021 12:19:21 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37649 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388545AbhAZGgm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Jan 2021 01:36:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UMxNWQf_1611642950;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMxNWQf_1611642950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 14:35:54 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] scsi/qla4xxx: Simplify the calculation of variables
Date:   Tue, 26 Jan 2021 14:35:48 +0800
Message-Id: <1611642948-43192-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/qla4xxx/ql4_83xx.c:475:23-25: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/scsi/qla4xxx/ql4_83xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_83xx.c b/drivers/scsi/qla4xxx/ql4_83xx.c
index 5f56122..64244a6 100644
--- a/drivers/scsi/qla4xxx/ql4_83xx.c
+++ b/drivers/scsi/qla4xxx/ql4_83xx.c
@@ -471,9 +471,7 @@ int qla4_83xx_can_perform_reset(struct scsi_qla_host *ha)
 			}
 		} else if (device_map[i].device_type == ISCSI_CLASS) {
 			if (drv_active & (1 << device_map[i].func_num)) {
-				if (!iscsi_present ||
-				    (iscsi_present &&
-				     (iscsi_func_low > device_map[i].func_num)))
+				if (!iscsi_present || (iscsi_func_low > device_map[i].func_num))
 					iscsi_func_low = device_map[i].func_num;
 
 				iscsi_present++;
-- 
1.8.3.1

