Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6726E961
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIQXSx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 19:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgIQXSw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 19:18:52 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC4D208DB;
        Thu, 17 Sep 2020 23:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600384732;
        bh=NK+w8QmqYf/nABcVzn9HY5/sKPUjVEcVkvH9cPa0NoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVtxeI5gG8IWEwou6juCMvirC4F1CJz5MyfCOZlYlrwq/8ZUhAuB8Hv3RaWos+O6y
         4d8W0hKOyJT5Qa9TdTTbwBonySmPC+2EO3m21pKt+/me/NB2argoB1pPHm2gP9l84e
         q1xwb+WE99zZ5exwGEpNA1RIbOgmCPSxkWwdH8xo=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCHv3 4/4] scsi: handle zone resources errors
Date:   Thu, 17 Sep 2020 16:18:41 -0700
Message-Id: <20200917231841.4029747-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200917231841.4029747-1-kbusch@kernel.org>
References: <20200917231841.4029747-1-kbusch@kernel.org>
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

Cc: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
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

