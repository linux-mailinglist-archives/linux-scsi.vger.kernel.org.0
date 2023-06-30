Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295274378D
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jun 2023 10:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjF3Ijm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Jun 2023 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjF3Ijk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Jun 2023 04:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5601FCD;
        Fri, 30 Jun 2023 01:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B24BB61701;
        Fri, 30 Jun 2023 08:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF0CC433CA;
        Fri, 30 Jun 2023 08:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688114378;
        bh=w6Brw9/Fy0gUZLJQWka9YJh50AUvIG52WhFXjTZLnJQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HN0xGFMKQiW2qhjMEjjjOgarJhP3bFRz/gEwMF2S+229LicqNg7z+aY8FfO/4Yt7w
         cb74v3F63ewmKStQQC+9OcQUc5xcAvWw5mbe04HSRt/V9z61U+AfQLzCFHFzF93Lad
         yJ00rT9TzUO0KDXUaVrLmuNJM9glycDxH1oN9Sp55vHXRLM0Y48gpWy6XPZriugqIp
         +Jw7Z2By0Ulu1gP+Yqk3c22LGhHBteZw+SIL6m/gDBgwxRZhte6lhHteeijrCcwEGY
         Xh7/ZOtocQ8Ys8EaeSkZPNqpU+Ude8ZmCiWh7B9AEU2vS4X7us5O70L8G3D/uf2B3W
         93YbDktZa921Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2 1/5] scsi: sd_zbc: Set zone limits before revalidating zones
Date:   Fri, 30 Jun 2023 17:39:31 +0900
Message-ID: <20230630083935.433334-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630083935.433334-1-dlemoal@kernel.org>
References: <20230630083935.433334-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In sd_zbc_revalidate_zones(), execute blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set a ZBC device
zone size and maximum zone append sector limit before executing
blk_revalidate_disk_zones(). This is to allow the block layer zone
reavlidation to check these device characteristics prior to checking all
zones of the device.

Since blk_queue_max_zone_append_sectors() already caps the device
maximum zone append limit to the zone size and to the maximum command
size, the max_append value passed to blk_queue_max_zone_append_sectors()
is simplified to the maximum number of segments times the number of
sectors per page.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd_zbc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 22801c24ea19..a25215507668 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -831,7 +831,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	struct request_queue *q = disk->queue;
 	u32 zone_blocks = sdkp->early_zone_info.zone_blocks;
 	unsigned int nr_zones = sdkp->early_zone_info.nr_zones;
-	u32 max_append;
 	int ret = 0;
 	unsigned int flags;
 
@@ -876,6 +875,11 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 		goto unlock;
 	}
 
+	blk_queue_chunk_sectors(q,
+			logical_to_sectors(sdkp->device, zone_blocks));
+	blk_queue_max_zone_append_sectors(q,
+			q->limits.max_segments << PAGE_SECTORS_SHIFT);
+
 	ret = blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);
 
 	memalloc_noio_restore(flags);
@@ -888,12 +892,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 		goto unlock;
 	}
 
-	max_append = min_t(u32, logical_to_sectors(sdkp->device, zone_blocks),
-			   q->limits.max_segments << (PAGE_SHIFT - 9));
-	max_append = min_t(u32, max_append, queue_max_hw_sectors(q));
-
-	blk_queue_max_zone_append_sectors(q, max_append);
-
 	sd_zbc_print_zones(sdkp);
 
 unlock:
-- 
2.41.0

