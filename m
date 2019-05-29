Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214F42E1CC
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE2QAv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 12:00:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfE2QAv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 12:00:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D354307D977;
        Wed, 29 May 2019 16:00:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 656045C706;
        Wed, 29 May 2019 16:00:46 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com
Subject: [PATCH 2/3] megaraid_sas: use octal permissions instead of constants
Date:   Wed, 29 May 2019 18:00:40 +0200
Message-Id: <20190529160041.7242-3-thenzl@redhat.com>
In-Reply-To: <20190529160041.7242-1-thenzl@redhat.com>
References: <20190529160041.7242-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 29 May 2019 16:00:50 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Checkpatch emits a warning when using symbolic permissions. Use octal
permissions instead.
No functional change.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 20 ++++++++++----------
 drivers/scsi/megaraid/megaraid_sas_fp.c   |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3752daab0..0522821a5 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -64,45 +64,45 @@
  * Will be set in megasas_init_mfi if user does not provide
  */
 static unsigned int max_sectors;
-module_param_named(max_sectors, max_sectors, int, S_IRUGO);
+module_param_named(max_sectors, max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors,
 	"Maximum number of sectors per IO command");
 
 static int msix_disable;
-module_param(msix_disable, int, S_IRUGO);
+module_param(msix_disable, int, 0444);
 MODULE_PARM_DESC(msix_disable, "Disable MSI-X interrupt handling. Default: 0");
 
 static unsigned int msix_vectors;
-module_param(msix_vectors, int, S_IRUGO);
+module_param(msix_vectors, int, 0444);
 MODULE_PARM_DESC(msix_vectors, "MSI-X max vector count. Default: Set by FW");
 
 static int allow_vf_ioctls;
-module_param(allow_vf_ioctls, int, S_IRUGO);
+module_param(allow_vf_ioctls, int, 0444);
 MODULE_PARM_DESC(allow_vf_ioctls, "Allow ioctls in SR-IOV VF mode. Default: 0");
 
 static unsigned int throttlequeuedepth = MEGASAS_THROTTLE_QUEUE_DEPTH;
-module_param(throttlequeuedepth, int, S_IRUGO);
+module_param(throttlequeuedepth, int, 0444);
 MODULE_PARM_DESC(throttlequeuedepth,
 	"Adapter queue depth when throttled due to I/O timeout. Default: 16");
 
 unsigned int resetwaittime = MEGASAS_RESET_WAIT_TIME;
-module_param(resetwaittime, int, S_IRUGO);
+module_param(resetwaittime, int, 0444);
 MODULE_PARM_DESC(resetwaittime, "Wait time in (1-180s) after I/O timeout before resetting adapter. Default: 180s");
 
 int smp_affinity_enable = 1;
-module_param(smp_affinity_enable, int, S_IRUGO);
+module_param(smp_affinity_enable, int, 0444);
 MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
 
 int rdpq_enable = 1;
-module_param(rdpq_enable, int, S_IRUGO);
+module_param(rdpq_enable, int, 0444);
 MODULE_PARM_DESC(rdpq_enable, "Allocate reply queue in chunks for large queue depth enable/disable Default: enable(1)");
 
 unsigned int dual_qdepth_disable;
-module_param(dual_qdepth_disable, int, S_IRUGO);
+module_param(dual_qdepth_disable, int, 0444);
 MODULE_PARM_DESC(dual_qdepth_disable, "Disable dual queue depth feature. Default: 0");
 
 unsigned int scmd_timeout = MEGASAS_DEFAULT_CMD_TIMEOUT;
-module_param(scmd_timeout, int, S_IRUGO);
+module_param(scmd_timeout, int, 0444);
 MODULE_PARM_DESC(scmd_timeout, "scsi command timeout (10-90s), default 90s. See megasas_reset_timer.");
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 9ac357619..d296255a4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -58,7 +58,7 @@
 
 #define LB_PENDING_CMDS_DEFAULT 4
 static unsigned int lb_pending_cmds = LB_PENDING_CMDS_DEFAULT;
-module_param(lb_pending_cmds, int, S_IRUGO);
+module_param(lb_pending_cmds, int, 0444);
 MODULE_PARM_DESC(lb_pending_cmds, "Change raid-1 load balancing outstanding "
 	"threshold. Valid Values are 1-128. Default: 4");
 
-- 
2.20.1

