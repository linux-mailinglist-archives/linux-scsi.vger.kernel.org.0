Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B399230D18A
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Feb 2021 03:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhBCC1i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Feb 2021 21:27:38 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:48124 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230215AbhBCC1b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Feb 2021 21:27:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNiyMLM_1612319191;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNiyMLM_1612319191)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:26:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: qla2xxx: Simplify the calculation of variables
Date:   Wed,  3 Feb 2021 10:26:30 +0800
Message-Id: <1612319190-111421-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/qla2xxx/qla_target.c:984:12-14: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 0d09480..c48daf5 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -981,8 +981,7 @@ void qlt_free_session_done(struct work_struct *work)
 			int rc;
 
 			if (!own ||
-			    (own &&
-			     (own->iocb.u.isp24.status_subcode == ELS_PLOGI))) {
+			     (own->iocb.u.isp24.status_subcode == ELS_PLOGI)) {
 				rc = qla2x00_post_async_logout_work(vha, sess,
 				    NULL);
 				if (rc != QLA_SUCCESS)
-- 
1.8.3.1

