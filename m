Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910EF277ACC
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Sep 2020 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIXUxi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Sep 2020 16:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgIXUxh (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 24 Sep 2020 16:53:37 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97699239E5;
        Thu, 24 Sep 2020 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600980817;
        bh=gIKjuXGa0OuRcH6QYTNcvBoiexuKob7ZVE4w4YhSggk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrUPOA5nAYJ+44LTj/QigEHctkX0QkHyB7g/gP/ORVRqppaWqcBf9AeRn8eypjB9f
         RQ7dIREM47I3HNlD49xrakO5gXI1mf40rNUKSv+Hu+NPUBzxIQp6liDEh4/NGs0owg
         4V08UXnR84tiWBZT0OOqMQXA++WwR/Ozu4Wkt57Y=
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 2/3] nvme: translate zone resource errors
Date:   Thu, 24 Sep 2020 13:53:29 -0700
Message-Id: <20200924205330.4043232-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200924205330.4043232-1-kbusch@kernel.org>
References: <20200924205330.4043232-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Translate zoned resource errors to the appropriate blk_status_t.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 614cd455836b..a0d26fcbf923 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -236,6 +236,10 @@ static blk_status_t nvme_error_status(u16 status)
 		return BLK_STS_NEXUS;
 	case NVME_SC_HOST_PATH_ERROR:
 		return BLK_STS_TRANSPORT;
+	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
+		return BLK_STS_ZONE_ACTIVE_RESOURCE;
+	case NVME_SC_ZONE_TOO_MANY_OPEN:
+		return BLK_STS_ZONE_OPEN_RESOURCE;
 	default:
 		return BLK_STS_IOERR;
 	}
-- 
2.24.1

