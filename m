Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62DDFDB6
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Oct 2019 08:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfJVGaK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Oct 2019 02:30:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfJVGaK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 22 Oct 2019 02:30:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E7DC1424222C1D77507;
        Tue, 22 Oct 2019 14:30:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 22 Oct 2019 14:30:01 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <john.garry@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] scsi:sd: define variable dif as unsigned int instead of bool
Date:   Tue, 22 Oct 2019 14:27:08 +0800
Message-ID: <1571725628-132736-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Variable dif in function sd_setup_read_write_cmnd() is the return value
of function scsi_host_dif_capable() which returns dif capability of disks.
If define it as bool, even for the disks which support DIF3, the function
still return dif=1, which causes IO error. So define variable dif as
unsigned int instead of bool.

Fixes: e249e42d277e ("scsi: sd: Clean up sd_setup_read_write_cmnd()")
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 32d9517..a763b70 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1166,11 +1166,12 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	sector_t lba = sectors_to_logical(sdp, blk_rq_pos(rq));
 	sector_t threshold;
 	unsigned int nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
-	bool dif, dix;
 	unsigned int mask = logical_to_sectors(sdp, 1) - 1;
 	bool write = rq_data_dir(rq) == WRITE;
 	unsigned char protect, fua;
 	blk_status_t ret;
+	unsigned int dif;
+	bool dix;
 
 	ret = scsi_init_io(cmd);
 	if (ret != BLK_STS_OK)
-- 
2.8.1

