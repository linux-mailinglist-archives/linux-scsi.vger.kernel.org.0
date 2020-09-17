Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76626E95F
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 01:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQXSx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 19:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIQXSv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 19:18:51 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1AE220870;
        Thu, 17 Sep 2020 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600384730;
        bh=jfma3X7pilb5Fg1ZcDsNgNV8kAHXdod6ppTdWMc8RNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ofz0qOD3l9X33Kcfw7NbvkmdAyr24FL7eNh/2umKkDo7vHaNwKCCu0+iFKD8h2wNN
         36u5GrK1w/S4OPQHLsi1N9JHIKO9Pg+tALI2DeGR/KyyAGRpEYQ7yyMd8+5cnDwtfN
         16HgroN2pOrrI7GYatIf4qGod2C4B5iTNqEaiskU=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCHv3 2/4] nvme: translate zone resource errors
Date:   Thu, 17 Sep 2020 16:18:39 -0700
Message-Id: <20200917231841.4029747-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200917231841.4029747-1-kbusch@kernel.org>
References: <20200917231841.4029747-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Translate zoned resource errors to the appropriate blk_status_t.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
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

