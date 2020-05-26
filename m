Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C571A643F
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Apr 2020 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgDMIfY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Apr 2020 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgDMIK5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Apr 2020 04:10:57 -0400
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C33C008749;
        Mon, 13 Apr 2020 01:02:06 -0700 (PDT)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6DA2B36F7FB45CCDE9FA;
        Mon, 13 Apr 2020 16:02:04 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 16:01:54 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <brking@us.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: ipr: remove unneeded semicolon
Date:   Mon, 13 Apr 2020 16:28:22 +0800
Message-ID: <20200413082822.24356-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/ipr.c:1167:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/ipr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index d48a8fa997b9..0db37b4f7265 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -1164,7 +1164,7 @@ static void ipr_update_ata_class(struct ipr_resource_entry *res, unsigned int pr
 	default:
 		res->ata_class = ATA_DEV_UNKNOWN;
 		break;
-	};
+	}
 }
 
 /**
-- 
2.21.1

