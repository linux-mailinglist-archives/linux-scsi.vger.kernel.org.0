Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC28C24D379
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Aug 2020 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHULDu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Aug 2020 07:03:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10299 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726118AbgHULDs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Aug 2020 07:03:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2728DAB371526D17C577;
        Fri, 21 Aug 2020 19:03:44 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 19:03:37 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hare@suse.de>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v3] scsi: libfc: Fix passing zero to 'PTR_ERR' warning
Date:   Fri, 21 Aug 2020 19:02:56 +0800
Message-ID: <20200821110256.6660-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200818114235.51052-1-yuehaibing@huawei.com>
References: <20200818114235.51052-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

drivers/scsi/libfc/fc_disc.c:304
 fc_disc_error() warn: passing zero to 'PTR_ERR'

fp maybe NULL in fc_disc_error(), use PTR_ERR_OR_ZERO to handle this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: use PTR_ERR_OR_ZERO
v2: use use IS_ERR in fc_disc_error()
---
 drivers/scsi/libfc/fc_disc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index d8cbc9c0e766..43284c3b2903 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -302,7 +302,7 @@ static void fc_disc_error(struct fc_disc *disc, struct fc_frame *fp)
 	unsigned long delay = 0;
 
 	FC_DISC_DBG(disc, "Error %ld, retries %d/%d\n",
-		    PTR_ERR(fp), disc->retry_count,
+		    PTR_ERR_OR_ZERO(fp), disc->retry_count,
 		    FC_DISC_RETRY_LIMIT);
 
 	if (!fp || PTR_ERR(fp) == -FC_EX_TIMEOUT) {
-- 
2.17.1


