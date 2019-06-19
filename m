Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23C54BB68
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfFSO0Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 10:26:25 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.250]:25358 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729581AbfFSO0Y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 19 Jun 2019 10:26:24 -0400
X-Greylist: delayed 1434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Jun 2019 10:26:24 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id B5722400D05D7
        for <linux-scsi@vger.kernel.org>; Wed, 19 Jun 2019 09:02:29 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id dbAThdwzZ90ondbAThd8Tq; Wed, 19 Jun 2019 09:02:29 -0500
X-Authority-Reason: nr=8
Received: from cablelink-187-160-61-213.pcs.intercable.net ([187.160.61.213]:49078 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hdbAS-001mAC-H7; Wed, 19 Jun 2019 09:02:28 -0500
Date:   Wed, 19 Jun 2019 09:02:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: mvsas: Use struct_size() in kzalloc()
Message-ID: <20190619140227.GA9877@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.160.61.213
X-Source-L: No
X-Exim-ID: 1hdbAS-001mAC-H7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-187-160-61-213.pcs.intercable.net (embeddedor) [187.160.61.213]:49078
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct mvs_info {
        ...
        struct mvs_slot_info slot_info[0];
};

instance = kzalloc(sizeof(sizeof(*mvi) + count * sizeof(struct mvs_slot_info),
                   GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(mvi, slot_info, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/mvsas/mv_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index da719b0694dc..3f2022fd2335 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -350,9 +350,9 @@ static struct mvs_info *mvs_pci_alloc(struct pci_dev *pdev,
 	struct mvs_info *mvi = NULL;
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 
-	mvi = kzalloc(sizeof(*mvi) +
-		(1L << mvs_chips[ent->driver_data].slot_width) *
-		sizeof(struct mvs_slot_info), GFP_KERNEL);
+	mvi = kzalloc(struct_size(mvi, slot_info,
+		      1L << mvs_chips[ent->driver_data].slot_width),
+		      GFP_KERNEL);
 	if (!mvi)
 		return NULL;
 
-- 
2.21.0

