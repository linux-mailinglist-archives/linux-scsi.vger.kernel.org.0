Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218992AB338
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Nov 2020 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgKIJKP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Nov 2020 04:10:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7158 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgKIJKP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Nov 2020 04:10:15 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CV4vd5l9vz15RwB;
        Mon,  9 Nov 2020 17:10:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 17:10:05 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] scsi: ufshcd: fix missing destroy_workqueue() on error in ufshcd_init
Date:   Mon, 9 Nov 2020 17:15:22 +0800
Message-ID: <20201109091522.55989-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add the missing destroy_workqueue() before return from
ufshcd_init in the error handling case. It seems that
exit_gating is an appropriate place.

Fixes: 4db7a2360597 ("scsi: ufs: Fix concurrency of error handler and other error recovery paths")
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/scsi/ufs/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b8f573a02713..9eaa0eaca374 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9206,6 +9206,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 exit_gating:
 	ufshcd_exit_clk_scaling(hba);
 	ufshcd_exit_clk_gating(hba);
+	destroy_workqueue(hba->eh_wq);
 out_disable:
 	hba->is_irq_enabled = false;
 	ufshcd_hba_exit(hba);
-- 
2.23.0

