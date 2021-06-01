Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02853974FD
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Jun 2021 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhFAOHr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Jun 2021 10:07:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2934 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhFAOHh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Jun 2021 10:07:37 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvYlP59FMz68dp;
        Tue,  1 Jun 2021 22:02:57 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 22:05:53 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] scsi: bfa: Remove unneeded if-null-free check
Date:   Tue, 1 Jun 2021 22:19:33 +0800
Message-ID: <20210601141933.4131855-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme760-chm.china.huawei.com (10.3.19.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eliminate the following coccicheck warning:

drivers/scsi/bfa/bfad_debugfs.c:375:2-7: WARNING:
NULL check before some freeing functions is not needed.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/scsi/bfa/bfad_debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index fd1b378a263a..5e419945c6e2 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -371,9 +371,7 @@ bfad_debugfs_release_fwtrc(struct inode *inode, struct file *file)
 	if (!fw_debug)
 		return 0;
 
-	if (fw_debug->debug_buffer)
-		vfree(fw_debug->debug_buffer);
-
+	vfree(fw_debug->debug_buffer);
 	file->private_data = NULL;
 	kfree(fw_debug);
 	return 0;
-- 
2.25.1

