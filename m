Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6F271434
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Sep 2020 14:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgITMQT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Sep 2020 08:16:19 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33987 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgITMQS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 20 Sep 2020 08:16:18 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 08:16:17 EDT
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612188"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] target/rd: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:14 +0200
Message-Id: <1600601186-7420-3-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

sg_init_table zeroes its first argument, so the allocation of that argument
doesn't have to.

the semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,n,flags;
@@

x = 
- kcalloc
+ kmalloc_array
  (n,sizeof(*x),flags)
...
sg_init_table(x,n)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/target/target_core_rd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -131,7 +131,7 @@ static int rd_allocate_sgl_table(struct
 		if (sg_per_table < total_sg_needed)
 			chain_entry = 1;
 
-		sg = kcalloc(sg_per_table + chain_entry, sizeof(*sg),
+		sg = kmalloc_array(sg_per_table + chain_entry, sizeof(*sg),
 				GFP_KERNEL);
 		if (!sg)
 			return -ENOMEM;

