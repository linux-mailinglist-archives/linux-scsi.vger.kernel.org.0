Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED3A18A72
	for <lists+linux-scsi@lfdr.de>; Thu,  9 May 2019 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEINSY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 May 2019 09:18:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfEINSX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 May 2019 09:18:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC1D0AC66;
        Thu,  9 May 2019 13:18:22 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Himanshu Madhani <himanshu.madhani@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH] qla2xxx: always allocate qla_tgt_wq
Date:   Thu,  9 May 2019 15:18:21 +0200
Message-Id: <20190509131821.87338-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The 'qla_tgt_wq' workqueue is used for generic command aborts,
not just target-related functions. So allocate the workqueue
always to avoid a kernel crash when aborting commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 582d1663f971..e35b84d9c1c1 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -7419,6 +7419,13 @@ int __init qlt_init(void)
 		return -EINVAL;
 	}
 
+	qla_tgt_wq = alloc_workqueue("qla_tgt_wq", 0, 0);
+	if (!qla_tgt_wq) {
+		ql_log(ql_log_fatal, NULL, 0xe06f,
+		    "alloc_workqueue for qla_tgt_wq failed\n");
+		return -ENOMEM;
+	}
+
 	if (!QLA_TGT_MODE_ENABLED())
 		return 0;
 
@@ -7428,7 +7435,8 @@ int __init qlt_init(void)
 	if (!qla_tgt_mgmt_cmd_cachep) {
 		ql_log(ql_log_fatal, NULL, 0xd04b,
 		    "kmem_cache_create for qla_tgt_mgmt_cmd_cachep failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_workqueue;
 	}
 
 	qla_tgt_plogi_cachep = kmem_cache_create("qla_tgt_plogi_cachep",
@@ -7451,33 +7459,27 @@ int __init qlt_init(void)
 		goto out_plogi_cachep;
 	}
 
-	qla_tgt_wq = alloc_workqueue("qla_tgt_wq", 0, 0);
-	if (!qla_tgt_wq) {
-		ql_log(ql_log_fatal, NULL, 0xe06f,
-		    "alloc_workqueue for qla_tgt_wq failed\n");
-		ret = -ENOMEM;
-		goto out_cmd_mempool;
-	}
 	/*
 	 * Return 1 to signal that initiator-mode is being disabled
 	 */
 	return (ql2x_ini_mode == QLA2XXX_INI_MODE_DISABLED) ? 1 : 0;
 
-out_cmd_mempool:
-	mempool_destroy(qla_tgt_mgmt_cmd_mempool);
 out_plogi_cachep:
 	kmem_cache_destroy(qla_tgt_plogi_cachep);
 out_mgmt_cmd_cachep:
 	kmem_cache_destroy(qla_tgt_mgmt_cmd_cachep);
+out_workqueue:
+	destroy_workqueue(qla_tgt_wq);
 	return ret;
 }
 
 void qlt_exit(void)
 {
+	destroy_workqueue(qla_tgt_wq);
+
 	if (!QLA_TGT_MODE_ENABLED())
 		return;
 
-	destroy_workqueue(qla_tgt_wq);
 	mempool_destroy(qla_tgt_mgmt_cmd_mempool);
 	kmem_cache_destroy(qla_tgt_plogi_cachep);
 	kmem_cache_destroy(qla_tgt_mgmt_cmd_cachep);
-- 
2.16.4

