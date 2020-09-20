Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DD2712CD
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Sep 2020 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgITH51 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Sep 2020 03:57:27 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:39736 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgITH51 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Sep 2020 03:57:27 -0400
Received: from localhost.localdomain ([93.22.151.141])
        by mwinf5d49 with ME
        id W7xP2300C33He5H037xPyx; Sun, 20 Sep 2020 09:57:25 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Sep 2020 09:57:25 +0200
X-ME-IP: 93.22.151.141
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        jthumshirn@suse.de, hare@suse.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: pmcraid: Fix memory allocation in 'pmcraid_alloc_sglist()'
Date:   Sun, 20 Sep 2020 09:57:22 +0200
Message-Id: <20200920075722.376644-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When the scatter list is allocated in 'pmcraid_alloc_sglist()', the
corresponding pointer should be stored in 'scatterlist' within the
'pmcraid_sglist' structure. Otherwise, 'scatterlist' is NULL.

This leads to a potential memory leak and NULL pointer dereference.

Fixes: ed4414cef2ad ("scsi: pmcraid: Use sgl_alloc_order() and sgl_free_order()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely speculative and untested.

Should it be correct, I think that their should be some trouble somewhere.
Either NULL pointer dereference or incorrect behavior.
The patch that introduced this potential bug is 2 years 1/2 old. This
should have been spotted earlier.

So unless this driver is mostly unused, this looks odd to me.
Feedback appreciated.
---
 drivers/scsi/pmcraid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index d99568fdf4af..00e155c88f03 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3230,8 +3230,9 @@ static struct pmcraid_sglist *pmcraid_alloc_sglist(int buflen)
 		return NULL;
 
 	sglist->order = order;
-	sgl_alloc_order(buflen, order, false,
-			GFP_KERNEL | GFP_DMA | __GFP_ZERO, &sglist->num_sg);
+	sglist->scatterlist = sgl_alloc_order(buflen, order, false,
+					      GFP_KERNEL | GFP_DMA | __GFP_ZERO,
+					      &sglist->num_sg);
 
 	return sglist;
 }
-- 
2.25.1

