Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4176411B31A
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Dec 2019 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbfLKPkw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Dec 2019 10:40:52 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43341 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388535AbfLKPkv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 11 Dec 2019 10:40:51 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from israelr@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Dec 2019 17:40:44 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBBFeiBC013485;
        Wed, 11 Dec 2019 17:40:44 +0200
From:   Israel Rukshin <israelr@mellanox.com>
To:     Target-devel <target-devel@vger.kernel.org>,
        Linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Israel Rukshin <israelr@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: target/iblock: Fix protection error with sectors greater than 512B
Date:   Wed, 11 Dec 2019 17:36:02 +0200
Message-Id: <1576078562-15240-1-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The sector size of the block layer is 512 bytes, but integrity interval
size might be different (in case of 4K block size of the media). At the
initiator side the virtual start sector is the one that was originally
submitted by the block layer (512 bytes) for the Reftag usage. The
initiator converts the Reftag to integrity interval units and sends it to
the target. So the target virtual start sector should be calculated at
integrity interval units. prepare_fn() and complete_fn() don't remap
correctly the Reftag when using incorrect units of the virtual start
sector, which leads to the following protection error at the device:

"blk_update_request: protection error, dev sdb, sector 2048 op 0x0:(READ)
flags 0x10000 phys_seg 1 prio class 0"

To fix that, set the seed in integrity interval units.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/target/target_core_iblock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 6949ea8..51ffd5c 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -646,7 +646,9 @@ static ssize_t iblock_show_configfs_dev_params(struct se_device *dev, char *b)
 	}
 
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, bio_sectors(bio));
-	bip_set_seed(bip, bio->bi_iter.bi_sector);
+	/* virtual start sector must be in integrity interval units */
+	bip_set_seed(bip, bio->bi_iter.bi_sector >>
+				  (bi->interval_exp - SECTOR_SHIFT));
 
 	pr_debug("IBLOCK BIP Size: %u Sector: %llu\n", bip->bip_iter.bi_size,
 		 (unsigned long long)bip->bip_iter.bi_sector);
-- 
1.8.3.1

