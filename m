Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9715E46124
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2019 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfFNOl7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 10:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfFNOl7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Jun 2019 10:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 563A73086275;
        Fri, 14 Jun 2019 14:41:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 377D6605C9;
        Fri, 14 Jun 2019 14:41:49 +0000 (UTC)
From:   Tomas Henzl <thenzl@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com, Sathya.Prakash@broadcom.com
Subject: [PATCH 1/2] scsi: mpt3sas: make driver options visible in sys
Date:   Fri, 14 Jun 2019 16:41:43 +0200
Message-Id: <20190614144144.6448-2-thenzl@redhat.com>
In-Reply-To: <20190614144144.6448-1-thenzl@redhat.com>
References: <20190614144144.6448-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 14:41:59 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Support is easier with all driver parameters visible in sysfs.
Also I've replaced a constant with an octal permission.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  | 14 +++++++-------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e6377ec07..839930764 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -74,28 +74,28 @@ static MPT_CALLBACK	mpt_callbacks[MPT_MAX_CALLBACKS];
 #define MAX_HBA_QUEUE_DEPTH	30000
 #define MAX_CHAIN_DEPTH		100000
 static int max_queue_depth = -1;
-module_param(max_queue_depth, int, 0);
+module_param(max_queue_depth, int, 0444);
 MODULE_PARM_DESC(max_queue_depth, " max controller queue depth ");
 
 static int max_sgl_entries = -1;
-module_param(max_sgl_entries, int, 0);
+module_param(max_sgl_entries, int, 0444);
 MODULE_PARM_DESC(max_sgl_entries, " max sg entries ");
 
 static int msix_disable = -1;
-module_param(msix_disable, int, 0);
+module_param(msix_disable, int, 0444);
 MODULE_PARM_DESC(msix_disable, " disable msix routed interrupts (default=0)");
 
 static int smp_affinity_enable = 1;
-module_param(smp_affinity_enable, int, S_IRUGO);
+module_param(smp_affinity_enable, int, 0444);
 MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
 
 static int max_msix_vectors = -1;
-module_param(max_msix_vectors, int, 0);
+module_param(max_msix_vectors, int, 0444);
 MODULE_PARM_DESC(max_msix_vectors,
 	" max msix vectors");
 
 static int irqpoll_weight = -1;
-module_param(irqpoll_weight, int, 0);
+module_param(irqpoll_weight, int, 0444);
 MODULE_PARM_DESC(irqpoll_weight,
 	"irq poll weight (default= one fourth of HBA queue depth)");
 
@@ -104,7 +104,7 @@ MODULE_PARM_DESC(mpt3sas_fwfault_debug,
 	" enable detection of firmware fault and halt firmware - (default=0)");
 
 static int perf_mode = -1;
-module_param(perf_mode, int, 0);
+module_param(perf_mode, int, 0444);
 MODULE_PARM_DESC(perf_mode,
 	"Performance mode (only for Aero/Sea Generation), options:\n\t\t"
 	"0 - balanced: high iops mode is enabled &\n\t\t"
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1f6aa8b19..27c731a3f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -113,22 +113,22 @@ MODULE_PARM_DESC(logging_level,
 
 
 static ushort max_sectors = 0xFFFF;
-module_param(max_sectors, ushort, 0);
+module_param(max_sectors, ushort, 0444);
 MODULE_PARM_DESC(max_sectors, "max sectors, range 64 to 32767  default=32767");
 
 
 static int missing_delay[2] = {-1, -1};
-module_param_array(missing_delay, int, NULL, 0);
+module_param_array(missing_delay, int, NULL, 0444);
 MODULE_PARM_DESC(missing_delay, " device missing delay , io missing delay");
 
 /* scsi-mid layer global parmeter is max_report_luns, which is 511 */
 #define MPT3SAS_MAX_LUN (16895)
 static u64 max_lun = MPT3SAS_MAX_LUN;
-module_param(max_lun, ullong, 0);
+module_param(max_lun, ullong, 0444);
 MODULE_PARM_DESC(max_lun, " max lun, default=16895 ");
 
 static ushort hbas_to_enumerate;
-module_param(hbas_to_enumerate, ushort, 0);
+module_param(hbas_to_enumerate, ushort, 0444);
 MODULE_PARM_DESC(hbas_to_enumerate,
 		" 0 - enumerates both SAS 2.0 & SAS 3.0 generation HBAs\n \
 		  1 - enumerates only SAS 2.0 generation HBAs\n \
@@ -142,17 +142,17 @@ MODULE_PARM_DESC(hbas_to_enumerate,
  * Either bit can be set, or both
  */
 static int diag_buffer_enable = -1;
-module_param(diag_buffer_enable, int, 0);
+module_param(diag_buffer_enable, int, 0444);
 MODULE_PARM_DESC(diag_buffer_enable,
 	" post diag buffers (TRACE=1/SNAPSHOT=2/EXTENDED=4/default=0)");
 static int disable_discovery = -1;
-module_param(disable_discovery, int, 0);
+module_param(disable_discovery, int, 0444);
 MODULE_PARM_DESC(disable_discovery, " disable discovery ");
 
 
 /* permit overriding the host protection capabilities mask (EEDP/T10 PI) */
 static int prot_mask = -1;
-module_param(prot_mask, int, 0);
+module_param(prot_mask, int, 0444);
 MODULE_PARM_DESC(prot_mask, " host protection capabilities mask, def=7 ");
 
 
-- 
2.20.1

