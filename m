Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BE4378B0F
	for <lists+linux-scsi@lfdr.de>; Mon, 10 May 2021 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbhEJL7y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 May 2021 07:59:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2615 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbhEJLlA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 10 May 2021 07:41:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FdzZ01TfJzmVHV;
        Mon, 10 May 2021 19:37:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 19:39:43 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <bvanassche@acm.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] scsi: Fix a comment in function scsi_host_dev_release()
Date:   Mon, 10 May 2021 19:35:26 +0800
Message-ID: <1620646526-193154-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

After the patch (3be8828fc507 ("scsi: core: Avoid that ATA error handling 
can trigger a kernel hang or oops")), it uses rcu to scsi_cmnd instead 
of shost, so modify "shost->rcu" to "scmd->rcu" in a comment.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hosts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 697c09e..ba72bd4 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -317,7 +317,7 @@ static void scsi_host_dev_release(struct device *dev)
 
 	scsi_proc_hostdir_rm(shost->hostt);
 
-	/* Wait for functions invoked through call_rcu(&shost->rcu, ...) */
+	/* Wait for functions invoked through call_rcu(&scmd->rcu, ...) */
 	rcu_barrier();
 
 	if (shost->tmf_work_q)
-- 
2.8.1

