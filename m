Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E032C1CCB
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Nov 2020 05:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgKXEgN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Nov 2020 23:36:13 -0500
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:33448 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729090AbgKXEgM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:36:12 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7BB35181D3025;
        Tue, 24 Nov 2020 04:36:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:2914:3138:3139:3140:3141:3142:3352:3865:3866:3867:3870:3872:5007:6261:10004:10848:11026:11658:11914:12043:12296:12297:12555:12895:13069:13221:13229:13311:13357:13894:14181:14384:14394:14721:21060:21080:21451:21627:30054:30064,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: month31_550b9d52736b
X-Filterd-Recvd-Size: 2517
Received: from joe-laptop.perches.com (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Nov 2020 04:36:10 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: pm8001: Fix misindentation
Date:   Mon, 23 Nov 2020 20:36:04 -0800
Message-Id: <9542a8be9954c1dca744f93f53bb1af6dd1436e8.1606192458.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1606192458.git.joe@perches.com>
References: <cover.1606192458.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

kernel robot reported a misindentation of a goto.

Fix it.

At the same time, use a temporary for a repeated entry in the same block
to reduce visual noise.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 38907f45c845..17b29163c13d 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -386,17 +386,17 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
 	pm8001_ha->memoryMap.region[FORENSIC_MEM].element_size = 0x10000;
 	pm8001_ha->memoryMap.region[FORENSIC_MEM].alignment = 0x10000;
 	for (i = 0; i < pm8001_ha->max_memcnt; i++) {
+		struct mpi_mem *region = &pm8001_ha->memoryMap.region[i];
+
 		if (pm8001_mem_alloc(pm8001_ha->pdev,
-			&pm8001_ha->memoryMap.region[i].virt_ptr,
-			&pm8001_ha->memoryMap.region[i].phys_addr,
-			&pm8001_ha->memoryMap.region[i].phys_addr_hi,
-			&pm8001_ha->memoryMap.region[i].phys_addr_lo,
-			pm8001_ha->memoryMap.region[i].total_len,
-			pm8001_ha->memoryMap.region[i].alignment) != 0) {
-			pm8001_dbg(pm8001_ha, FAIL,
-				   "Mem%d alloc failed\n",
-				   i);
-				goto err_out;
+				     &region->virt_ptr,
+				     &region->phys_addr,
+				     &region->phys_addr_hi,
+				     &region->phys_addr_lo,
+				     region->total_len,
+				     region->alignment) != 0) {
+			pm8001_dbg(pm8001_ha, FAIL, "Mem%d alloc failed\n", i);
+			goto err_out;
 		}
 	}
 
-- 
2.26.0

