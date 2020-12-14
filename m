Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E52D98F7
	for <lists+linux-scsi@lfdr.de>; Mon, 14 Dec 2020 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407907AbgLNNgr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Dec 2020 08:36:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9878 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439953AbgLNNge (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Dec 2020 08:36:34 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cvj7P2mwQz7G5y;
        Mon, 14 Dec 2020 21:35:13 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:35:39 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] scsi: pmcraid: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:36:10 +0800
Message-ID: <20201214133610.3836-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index cbe5fab793eb..439e90f8a279 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -1950,7 +1950,7 @@ static void pmcraid_soft_reset(struct pmcraid_cmd *cmd)
 	}
 
 	iowrite32(doorbell, pinstance->int_regs.host_ioa_interrupt_reg);
-	ioread32(pinstance->int_regs.host_ioa_interrupt_reg),
+	ioread32(pinstance->int_regs.host_ioa_interrupt_reg);
 	int_reg = ioread32(pinstance->int_regs.ioa_host_interrupt_reg);
 
 	pmcraid_info("Waiting for IOA to become operational %x:%x\n",
-- 
2.22.0

