Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B609E22028C
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jul 2020 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGOCzz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jul 2020 22:55:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbgGOCzz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jul 2020 22:55:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6842B459E0B9AD3E8124;
        Wed, 15 Jul 2020 10:55:53 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 10:55:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <axboe@kernel.dk>, <damien.lemoal@wdc.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: sd_zbc: Remove unused inline functions
Date:   Wed, 15 Jul 2020 10:55:23 +0800
Message-ID: <20200715025523.34620-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

They are never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/sd.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 3a74f4b45134..27c0f4e9b1d4 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -229,17 +229,11 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 
 #else /* CONFIG_BLK_DEV_ZONED */
 
-static inline int sd_zbc_init(void)
-{
-	return 0;
-}
-
 static inline int sd_zbc_init_disk(struct scsi_disk *sdkp)
 {
 	return 0;
 }
 
-static inline void sd_zbc_exit(void) {}
 static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
 
 static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
-- 
2.17.1


