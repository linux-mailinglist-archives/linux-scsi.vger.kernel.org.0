Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8B144EA4
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jan 2020 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgAVJ2h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jan 2020 04:28:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10127 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAVJ2h (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Jan 2020 04:28:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E62243FB09FEC93AA9F8;
        Wed, 22 Jan 2020 17:28:35 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 17:28:30 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH] scsi: Delete extra blank line
Date:   Wed, 22 Jan 2020 17:27:40 +0800
Message-ID: <20200122092740.27169-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/scsi_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 610ee41fa54c..56bd2c13a1fb 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1547,7 +1547,6 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	if (unlikely(host->shost_state == SHOST_DEL)) {
 		cmd->result = (DID_NO_CONNECT << 16);
 		goto done;
-
 	}
 
 	trace_scsi_dispatch_cmd_start(cmd);
-- 
2.17.2

