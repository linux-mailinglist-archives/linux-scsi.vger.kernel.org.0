Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42181D108E
	for <lists+linux-scsi@lfdr.de>; Wed, 13 May 2020 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgEMLEb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 13 May 2020 07:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgEMLEa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 13 May 2020 07:04:30 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7330EC061A0E
        for <linux-scsi@vger.kernel.org>; Wed, 13 May 2020 04:04:30 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:81a0:190c:7969:2334])
        by michel.telenet-ops.be with bizsmtp
        id eB4T2200L5045R206B4TF2; Wed, 13 May 2020 13:04:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jYpBb-000523-Ec; Wed, 13 May 2020 13:04:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jYpBb-0005rT-BT; Wed, 13 May 2020 13:04:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ata: sata_rcar: Fix DMA boundary mask
Date:   Wed, 13 May 2020 13:04:26 +0200
Message-Id: <20200513110426.22472-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Before commit 9495b7e92f716ab2 ("driver core: platform: Initialize
dma_parms for platform devices"), the R-Car SATA device didn't have DMA
parameters.  Hence the DMA boundary mask supplied by its driver was
silently ignored, as __scsi_init_queue() doesn't check the return value
of dma_set_seg_boundary(), and the default value of 0xffffffff was used.

Now the device has gained DMA parameters, the driver-supplied value is
used, and the following warning is printed on Salvator-XS:

    DMA-API: sata_rcar ee300000.sata: mapping sg segment across boundary [start=0x00000000ffffe000] [end=0x00000000ffffefff] [boundary=0x000000001ffffffe]
    WARNING: CPU: 5 PID: 38 at kernel/dma/debug.c:1233 debug_dma_map_sg+0x298/0x300

(the range of start/end values depend on whether IOMMU support is
 enabled or not)

The issue here is that SATA_RCAR_DMA_BOUNDARY doesn't have bit 0 set, so
any typical end value, which is odd, will trigger the check.

Fix this by increasing the DMA boundary value by 1.

Fixes: 8bfbeed58665dbbf ("sata_rcar: correct 'sata_rcar_sht'")
Fixes: 9495b7e92f716ab2 ("driver core: platform: Initialize dma_parms for platform devices")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
As by default the DMA debug code prints the first error only, this issue
may be hidden on plain v5.7-rc5, where the FCP driver triggers a similar
warning.  Merging commit dd844fb8e50b12e6 ("media: platform: fcp: Set
appropriate DMA parameters") from the media tree fixes the FCP issue,
and exposes the SATA issue.

I added the second fixes tag because that commit is already being
backported to stable kernels, and this patch thus needs backporting,
too.
---
 drivers/ata/sata_rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 980aacdbcf3b42b9..752db75b611e8f8a 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -120,7 +120,7 @@
 /* Descriptor table word 0 bit (when DTA32M = 1) */
 #define SATA_RCAR_DTEND			BIT(0)
 
-#define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFEUL
+#define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFFUL
 
 /* Gen2 Physical Layer Control Registers */
 #define RCAR_GEN2_PHY_CTL1_REG		0x1704
-- 
2.17.1

