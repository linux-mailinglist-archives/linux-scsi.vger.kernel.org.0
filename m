Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFE2356A7
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Aug 2020 13:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHBLPd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 2 Aug 2020 07:15:33 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59415 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgHBLPc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 2 Aug 2020 07:15:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U4TpvX4_1596366929;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4TpvX4_1596366929)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:29 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, himanshu.madhani@cavium.com,
        quinn.tran@cavium.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: [PATCH] scsi: qla2xxx: Fix wrong return value in qlt_chk_unresolv_exchg()
Date:   Sun,  2 Aug 2020 19:15:28 +0800
Message-Id: <20200802111528.4974-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In the case of a failed retry, a positive value EIO is returned here.
I think this is a typo error. It is necessary to return an error value.

Fixes: 0691094ff3f2c ("scsi: qla2xxx: Add logic to detect ABTS hang and response completion")
Cc: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index c2c0e6049da4..f2bb841c2059 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -5668,7 +5668,7 @@ static int qlt_chk_unresolv_exchg(struct scsi_qla_host *vha,
 		/* found existing exchange */
 		qpair->retry_term_cnt++;
 		if (qpair->retry_term_cnt >= 5) {
-			rc = EIO;
+			rc = -EIO;
 			qpair->retry_term_cnt = 0;
 			ql_log(ql_log_warn, vha, 0xffff,
 			    "Unable to send ABTS Respond. Dumping firmware.\n");
-- 
2.26.2

