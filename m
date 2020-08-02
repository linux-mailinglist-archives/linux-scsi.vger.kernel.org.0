Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA22356A8
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Aug 2020 13:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHBLPb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 2 Aug 2020 07:15:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49842 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgHBLPb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 2 Aug 2020 07:15:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U4TCtAZ_1596366927;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4TCtAZ_1596366927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:28 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, quinn.tran@cavium.com,
        himanshu.madhani@cavium.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: [PATCH] scsi: qla2xxx: Remove redundant variable initialization
Date:   Sun,  2 Aug 2020 19:15:27 +0800
Message-Id: <20200802111527.4928-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The initialization value of `rc` is wrong. It is unnecessary to
initialize `rc` variables, so remove its initialization operation.

Fixes: 84905dfe78d28 ("scsi: qla2xxx: Fix TMF and Multi-Queue config")
Cc: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index fbb80a043b4f..c2c0e6049da4 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -2025,7 +2025,7 @@ static void qlt_do_tmr_work(struct work_struct *work)
 	struct qla_tgt_mgmt_cmd *mcmd =
 		container_of(work, struct qla_tgt_mgmt_cmd, work);
 	struct qla_hw_data *ha = mcmd->vha->hw;
-	int rc = EIO;
+	int rc;
 	uint32_t tag;
 	unsigned long flags;
 
-- 
2.26.2

