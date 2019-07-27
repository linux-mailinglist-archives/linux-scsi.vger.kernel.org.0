Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0F5777E1
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Jul 2019 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfG0J0L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 27 Jul 2019 05:26:11 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:60894 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfG0J0L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 27 Jul 2019 05:26:11 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 38B961008CBC3;
        Sat, 27 Jul 2019 17:26:08 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 25DA720424204;
        Sat, 27 Jul 2019 17:26:08 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7hgHdNnGfx-I; Sat, 27 Jul 2019 17:26:08 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id EE2A920424202;
        Sat, 27 Jul 2019 17:26:07 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     QLogic-Storage-Upstream@cavium.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] scsi/qedf: avoid accessing uninitialized data
Date:   Sat, 27 Jul 2019 17:25:49 +0800
Message-Id: <20190727092549.6169-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Similar to commit b2d3492fc591 ("scsi: bnx2fc: Fix error handling
in probe()"), qedf_cmd_mgr_alloc() allocates cmgr->io_bdt_pool
without initializing it with zero. Though each item of this array
is explicitly initialized with kmalloc() in the for-loop below,
kmalloc() may fail in the middle of the loop and make the caller
go into qedf_cmd_mgr_free(), where some uninitialized
cmgr->io_bdt_pool items are accessed.

Fix this by allocating cmgr->io_bdt_pool with kcalloc().

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/scsi/qedf/qedf_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index d881e822f92c..2851b0cd1df8 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -254,7 +254,7 @@ struct qedf_cmd_mgr *qedf_cmd_mgr_alloc(struct qedf_ctx *qedf)
 	}
 
 	/* Allocate pool of io_bdts - one for each qedf_ioreq */
-	cmgr->io_bdt_pool = kmalloc_array(num_ios, sizeof(struct io_bdt *),
+	cmgr->io_bdt_pool = kcalloc(num_ios, sizeof(struct io_bdt *),
 	    GFP_KERNEL);
 
 	if (!cmgr->io_bdt_pool) {
-- 
2.11.0

