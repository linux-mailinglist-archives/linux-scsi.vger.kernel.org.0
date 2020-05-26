Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1717F1BF80A
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2020 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD3MSQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Apr 2020 08:18:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3785 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgD3MSQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 Apr 2020 08:18:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9416EA9840337D77221C;
        Thu, 30 Apr 2020 20:18:13 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 20:18:04 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jgill@vmware.com>, <pv-drivers@vmware.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <thellstrom@vmware.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: vmw_pvscsi: use true,false for adapter->use_msg
Date:   Thu, 30 Apr 2020 20:17:29 +0800
Message-ID: <20200430121729.15064-1-yanaijie@huawei.com>
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

drivers/scsi/vmw_pvscsi.c:911:2-18: WARNING: Assignment of 0/1 to bool
variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/vmw_pvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index c3f010df641e..8dbb4db6831a 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -908,7 +908,7 @@ static int pvscsi_host_reset(struct scsi_cmnd *cmd)
 	use_msg = adapter->use_msg;
 
 	if (use_msg) {
-		adapter->use_msg = 0;
+		adapter->use_msg = false;
 		spin_unlock_irqrestore(&adapter->hw_lock, flags);
 
 		/*
-- 
2.21.1

