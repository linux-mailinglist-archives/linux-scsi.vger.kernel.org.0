Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD161277AC8
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Sep 2020 22:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIXUxj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Sep 2020 16:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgIXUxi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 24 Sep 2020 16:53:38 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C542239CF;
        Thu, 24 Sep 2020 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600980818;
        bh=TjZ/h/RB5ENBHC8z4Y+xgQryaV4G3HwztlJFGYzWI5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDvOMvrwNw/XuF6F2CX6aUa9gg7WrJUWG2LvHs5+7kRSnZS16OyH3eILgSuf7mHEB
         ud2Miar6qUIa/cDNPnMtvdrw9Yro0kl5Zsf87JJOlMu1v2X2lkNSHZTwbnSXDRNT+5
         1gpsN9i2QSDJ8N8ZDWjI07s0pEynF0+EFfPzlBNA=
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 3/3] scsi: handle zone resources errors
Date:   Thu, 24 Sep 2020 13:53:30 -0700
Message-Id: <20200924205330.4043232-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924205330.4043232-1-kbusch@kernel.org>
References: <20200924205330.4043232-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

ZBC or ZAC disks that have a limit on the number of open zones may fail
a zone open command or a write to a zone that is not already implicitly
or explicitly open if the total number of open zones is already at the
maximum allowed.

For these operations, instead of returning the generic BLK_STS_IOERR,
return BLK_STS_ZONE_OPEN_RESOURCE which is returned as -ETOOMANYREFS to
the I/O issuer, allowing the device user to act appropriately on these
relatively benign zone resource errors.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/scsi_lib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 7affaaf8b98e..c129ac6666da 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -758,6 +758,15 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 			/* See SSC3rXX or current. */
 			action = ACTION_FAIL;
 			break;
+		case DATA_PROTECT:
+			action = ACTION_FAIL;
+			if ((sshdr.asc == 0x0C && sshdr.ascq == 0x12) ||
+			    (sshdr.asc == 0x55 &&
+			     (sshdr.ascq == 0x0E || sshdr.ascq == 0x0F))) {
+				/* Insufficient zone resources */
+				blk_stat = BLK_STS_ZONE_OPEN_RESOURCE;
+			}
+			break;
 		default:
 			action = ACTION_FAIL;
 			break;
-- 
2.24.1

